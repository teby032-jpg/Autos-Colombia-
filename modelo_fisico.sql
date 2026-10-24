CREATE DATABASE IF NOT EXISTS parqueadero_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE parqueadero_db;

CREATE TABLE IF NOT EXISTS TipoVehiculo (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    tarifa_por_hora DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'Operador'
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Vehiculo (
    placa VARCHAR(10) PRIMARY KEY,
    id_tipo INT NOT NULL,
    CONSTRAINT fk_vehiculo_tipo
        FOREIGN KEY (id_tipo) REFERENCES TipoVehiculo(id_tipo)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS RegistroEstancia (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    fecha_hora_entrada DATETIME NOT NULL,
    fecha_hora_salida DATETIME NULL,
    total_pagar DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    estado ENUM('Activo', 'Finalizado') NOT NULL DEFAULT 'Activo',
    id_usuario_entrada INT NOT NULL,
    id_usuario_salida INT NULL,
    CONSTRAINT fk_registro_vehiculo
        FOREIGN KEY (placa) REFERENCES Vehiculo(placa),
    CONSTRAINT fk_registro_usuario_entrada
        FOREIGN KEY (id_usuario_entrada) REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_registro_usuario_salida
        FOREIGN KEY (id_usuario_salida) REFERENCES Usuario(id_usuario)
) ENGINE = InnoDB;
