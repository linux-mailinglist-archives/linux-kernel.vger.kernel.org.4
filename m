Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9C6BB639
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjCOOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCOOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:36:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE7366D2A;
        Wed, 15 Mar 2023 07:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxaYEWwMFeeiG4yBTke701MiLxh5ioitTNe7Y80madYjemlAqcThfL5LsDzVeN5LYNw07wH0xZUeFKF/ZdaOxGu+6zRLwYSxGRcIauJD58E2jBdtjxgj9i7kD068mB4rlUsGl8X/38Ctvn8F5NCjGTryKwXqFV8jJSMTa7A40hvittbTwsm+BxMVQu8BVN9cAfaEPGTkC2MrdJYL/yuAk/9ISTo2niGjksfGJ5WXv0MrXNQZ0JIqT73juypMEC7LtPrfITMNwajP6cLNx/dmnDz3W7Gg3N6JwhBPdkm8yLVvHdOy4vfGG1nKAKriqKByMhfsPJrp+n3U0VanFf87RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWFZf73FALvv47IVCFo72tSEo4QcvNrcoCCMIlrOTTM=;
 b=Dl6rpfh2/bw3WS0XEDK5lRY2hz2XHRQufXUrzhqezjAEyHT7o1Y3teR5vPUGzOqBCLB8sx4N9fmmAH6nqR1gL8fK2UJEjzjWIDfh6WtCSfwpG45FnD20j2VLsuukxTqYC8OsiAxL4TkEBGIS7ClsOdcOm2GG7XXnP3IM+CKzWndV2WhYWToVAz6WL/3Oe2wsCcLnOxjrOZlpcOpCX17wSWnUU9mJClbyY11Fbua9F55zSRc3mYOb5AGaaOHI6XvTkHIzZPj3Gf47dhZCS6KE6el4s1Vi7QlR2lpYVnvglp8TDWuPQ6SDEigt1bGlcLeFXnlqtkIodZupwUu79Etj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWFZf73FALvv47IVCFo72tSEo4QcvNrcoCCMIlrOTTM=;
 b=GyudcQKl4ef95+psbay2VRY4TPYUXHgOuyDNSME5dlNmngfaNpUVKVV1k9qfT5Uw7TaaeEAvPfet8mkEMGt4bHG8CL8cGMPGQ8N9QCwzwfoS13/+3S6UzW+C3y7xR3UzaOlRq4wO3QS3iVcbkyULW2piSR3wEFwocFGqLfcv0X0=
Received: from DS7PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:3b8::18)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 14:35:50 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::d4) by DS7PR03CA0013.outlook.office365.com
 (2603:10b6:5:3b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Wed, 15 Mar 2023 14:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 14:35:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 09:35:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 09:35:26 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Mar 2023 09:35:26 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mauriciofb@gmail.com>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add translation of process/adding-syscalls
Date:   Wed, 15 Mar 2023 09:35:26 -0500
Message-ID: <20230315143526.1213813-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: d8185c33-992b-4f0e-8dea-08db25629289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o70yxXe5kMUd/Zv90zacZ1U4f2FnDy78mHKOwhk47oGUgbrFs/tICqI7XBTn25mD7EdMMa1oi4WQ6GcbGVMplbcPkADy6TMommG11ZN3Sd9V7lvzLqOKacd2AG3rMGsjcLqXSAoVOLFo9z5OPopIdL3pe/NYURrMeOe4Vwpz48gl9xRcJ+qoiQjOxr0VbmhSULHvAsgODQIfDrcIfIBTBXkSgw+NGH5woxwaftkdO+vzRSR/qcsIZkxcp6rPJmoRpmJVLs7nINhMVEWXCQBJubOdZlRR76BjNV+dAXufcR6wHfKKs2FRrQZRm6mRXK5qWjE7EONCCsWlgkkc9quyyXRgrmcq9TkZ/dwciNIjMIyqBqjBcYOjqjOgTtbgTgwEvJQojoxfd5AM25xF13gpcHI/r9WesB8zGBb0wUJFsModMLpcRtjNw3YooMJ3RzkeGMq4N/l8Nh5r5j+NAHuAdf13kIKd1qBqpw35HEiNjX50FTauQPay/osvLAR4Re46GjNp1NV44O+9I7qmLw6zVCcytY2pL+U0Cqw0CNfzRvxjpSr3RHaRqfflrH8iQ2VJnMfy+mYl64m3GDDugL4pUTolXkx3f8FaRO51zDcc25tMsV2SgRHnPbG5usGXZ0fu38VTNx27QpJCUqcp5hJhAE5LKi2ItXemTDpCtju536RYgW2+yKjPn8wCeRgyuiaR83kAPTJOkU2lfujDpKTqI/8k8iwhye9uWvvv0Ugu+4qLSIlaR94DSviA4Dmkx1IaR7mLY4KmQRbXOeddY7yuXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(66899018)(41300700001)(30864003)(8936002)(5660300002)(2906002)(36756003)(86362001)(356005)(36860700001)(82740400003)(81166007)(478600001)(7696005)(44832011)(6916009)(8676002)(70586007)(70206006)(966005)(2616005)(40480700001)(40460700003)(4326008)(82310400005)(26005)(66574015)(426003)(54906003)(316002)(186003)(47076005)(1076003)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 14:35:49.7786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8185c33-992b-4f0e-8dea-08db25629289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/adding-syscalls.rst into Spanish.

Co-developed-by: Mauricio Fuentes <mauriciofb@gmail.com>
Signed-off-by: Mauricio Fuentes <mauriciofb@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../sp_SP/process/adding-syscalls.rst         | 632 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   1 +
 2 files changed, 633 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/adding-syscalls.rst

diff --git a/Documentation/translations/sp_SP/process/adding-syscalls.rst b/Documentation/translations/sp_SP/process/adding-syscalls.rst
new file mode 100644
index 000000000000..f21504c612b2
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/adding-syscalls.rst
@@ -0,0 +1,632 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/adding-syscalls.rst <addsyscalls>`
+:Translator: Mauricio Fuentes <mauriciofb@gmail.com>
+
+.. _sp_addsyscalls:
+
+Agregando una Nueva Llamada del Sistema
+=======================================
+
+Este documento describe qué involucra agregar una nueva llamada del sistema
+al kernel Linux, más allá de la presentación y consejos normales en
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` que
+también puede encontrar traducido a este idioma.
+
+Alternativas a Llamadas del Sistema
+-----------------------------------
+
+La primera cosa a considerar cuando se agrega una llamada al sistema es si
+alguna alternativa es adecuada en su lugar. Aunque las llamadas al sistema
+son los puntos de interacción entre el userspace y el kernel más obvios y
+tradicionales, existen otras posibilidades -- elija la que mejor se adecúe
+a su interfaz.
+
+ - Si se puede hacer que la operación se parezca a un objeto filesystem,
+   podría tener más sentido crear un nuevo sistema de ficheros o
+   dispositivo. Esto también hará más fácil encapsular la nueva
+   funcionalidad en un módulo del kernel en vez de requerir que sea
+   construido junto al kernel principal.
+
+     - Si la nueva funcionalidad involucra operaciones donde el kernel
+       notifica al userspace que algo ha pasado, entonces retornar un nuevo
+       descriptor de archivo para el objeto relevante permite al userspace
+       usar ``poll``/``select``/``epoll`` para recibir esta notificación.
+
+     - Sin embargo, operaciones que no mapean a operaciones similares a
+       :manpage:`read(2)`/:manpage:`write(2)` tienen que ser implementadas
+       como solicitudes :manpage:`ioctl(2)`, las cuales pueden llevar a un
+       API algo opaca.
+
+ - Si sólo está exponiendo información del runtime, un nuevo nodo en sysfs
+   (mire ``Documentation/filesystems/sysfs.rst``) o el filesystem ``/proc``
+   podría ser más adecuado. Sin embargo, acceder a estos mecanismos
+   requiere que el filesystem relevante esté montado, lo que podría no ser
+   siempre el caso (e.g. en un ambiente namespaced/sandboxed/chrooted).
+   Evite agregar cualquier API a debugfs, ya que no se considera una
+   interfaz (interface) de 'producción' para el userspace.
+
+ - Si la operación es específica a un archivo o descriptor de archivo
+   específico, entonces la opción de comando adicional :manpage:`fcntl(2)`
+   podría ser más apropiada. Sin embargo, :manpage:`fcntl(2)` es una
+   llamada al sistema multiplexada que esconde mucha complejidad, así que
+   esta opción es mejor cuando la nueva funcion es analogamente cercana a
+   la funcionalidad existente :manpage:`fcntl(2)`, o la nueva funcionalidad
+   es muy simple (por ejemplo, definir/obtener un flag simple relacionado a
+   un descriptor de archivo).
+
+ - Si la operación es específica a un proceso o tarea particular, entonces
+   un comando adicional :manpage:`prctl(2)` podría ser más apropiado. Tal
+   como con :manpage:`fcntl(2)`, esta llamada al sistema es un multiplexor
+   complicado así que está reservado para comandos análogamente cercanos
+   del existente ``prctl()`` u obtener/definir un flag simple relacionado a
+   un proceso.
+
+Diseñando el API: Planeando para extensiones
+--------------------------------------------
+
+Una nueva llamada del sistema forma parte del API del kernel, y tiene que
+ser soportada indefinidamente. Como tal, es una muy buena idea discutir
+explícitamente el interface en las listas de correo del kernel, y es
+importante planear para futuras extensiones del interface.
+
+(La tabla syscall está poblada con ejemplos históricos donde esto no se
+hizo, junto con los correspondientes seguimientos de los system calls --
+``eventfd``/``eventfd2``, ``dup2``/``dup3``, ``inotify_init``/``inotify_init1``,
+``pipe``/``pipe2``, ``renameat``/``renameat2`` -- así que aprenda de la
+historia del kernel y planee extensiones desde el inicio.)
+
+Para llamadas al sistema más simples que sólo toman un par de argumentos,
+la forma preferida de permitir futuras extensiones es incluir un argumento
+flag a la llamada al sistema. Para asegurarse que el userspace pueda usar
+de forma segura estos flags entre versiones del kernel, revise si los flags
+contienen cualquier flag desconocido, y rechace la llamada al sistema (con
+``EINVAL``) si ocurre::
+
+    if (flags & ~(THING_FLAG1 | THINGFLAG2 | THING_FLAG3))
+        return -EINVAL;
+
+(Si no hay valores de flags usados aún, revise que los argumentos del flag
+sean cero.)
+
+Para llamadas al sistema más sofisticadas que involucran un gran número de
+argumentos, es preferible encapsular la mayoría de los argumentos en una
+estructura que sea pasada a través de un puntero. Tal estructura puede
+hacer frente a futuras extensiones mediante la inclusión de un argumento de
+tamaño en la estructura::
+
+    struct xyzzy_params {
+        u32 size; /* userspace define p->size = sizeof(struct xyzzy_params) */
+        u32 param_1;
+        u64 param_2;
+        u64 param_3;
+    };
+
+Siempre que cualquier campo añadido subsecuente, digamos ``param_4``, sea
+diseñado de forma tal que un valor cero, devuelva el comportamiento previo,
+entonces permite versiones no coincidentes en ambos sentidos:
+
+ - Para hacer frente a programas del userspace más modernos, haciendo
+   llamadas a un kernel más antiguo, el código del kernel debe revisar que
+   cualquier memoria más allá del tamaño de la estructura sea cero (revisar
+   de manera efectiva que ``param_4 == 0``).
+ - Para hacer frente a programas antiguos del userspace haciendo llamadas a
+   un kernel más nuevo, el código del kernel puede extender con ceros, una
+   instancia más pequeña de la estructura (definiendo efectivamente
+   ``param_4 == 0``).
+
+Revise :manpage:`perf_event_open(2)` y la función ``perf_copy_attr()`` (en
+``kernel/events/code.c``) para un ejemplo de esta aproximación.
+
+
+Diseñando el API: Otras consideraciones
+---------------------------------------
+
+Si su nueva llamada al sistema permite al userspace hacer referencia a un
+objeto del kernel, esta debería usar un descriptor de archivo como el
+manipulador de ese objeto -- no invente un nuevo tipo de objeto manipulador
+userspace cuando el kernel ya tiene mecanismos y semánticas bien definidas
+para usar los descriptores de archivos.
+
+Si su nueva llamada a sistema :manpage:`xyzzy(2)` retorna un nuevo
+descriptor de archivo, entonces el argumento flag debe incluir un valor que
+sea equivalente a definir ``O_CLOEXEC`` en el nuevo FD. Esto hace posible
+al userspace acortar la brecha de tiempo entre ``xyzzy()`` y la llamada a
+``fcntl(fd, F_SETFD, FD_CLOEXEC)``, donde un ``fork()`` inesperado y
+``execve()`` en otro hilo podrían filtrar un descriptor al programa
+ejecutado. (Sin embargo, resista la tentación de reusar el valor actual de
+la constante ``O_CLOEXEC``, ya que es específica de la arquitectura y es
+parte de un espacio numerado de flags ``O_*`` que está bastante lleno.)
+
+Si su llamada de sistema retorna un nuevo descriptor de archivo, debería
+considerar también que significa usar la familia de llamadas de sistema
+:manpage:`poll(2)` en ese descriptor de archivo. Hacer un descriptor de
+archivo listo para leer o escribir es la forma normal para que el kernel
+indique al espacio de usuario que un evento ha ocurrido en el
+correspondiente objeto del kernel.
+
+Si su nueva llamada de sistema :manpage:`xyzzy(2)` involucra algún nombre
+de archivo como argumento::
+
+    int sys_xyzzy(const char __user *path, ..., unsigned int flags);
+
+debería considerar también si una versión :manpage:`xyzzyat(2)` es mas
+apropiada::
+
+    int sys_xyzzyat(int dfd, const char __user *path, ..., unsigned int flags);
+
+Esto permite más flexibilidad en como el userspace especifica el archivo en
+cuestión; en particular esto permite al userspace pedir la funcionalidad a
+un descriptor de archivo ya abierto usando el flag ``AT_EMPTY_PATH``,
+efectivamente dando una operación :manpage:`fxyzzy(3)` gratis::
+
+ - xyzzyat(AT_FDCWD, path, ..., 0) es equivalente a xyzzy(path, ...)
+ - xyzzyat(fd, "", ..., AT_EMPTY_PATH) es equivalente a fxyzzy(fd, ...)
+
+(Para más detalles sobre la explicación racional de las llamadas \*at(),
+revise el man page :manpage:`openat(2)`; para un ejemplo de AT_EMPTY_PATH,
+mire el man page :manpage:`fstatat(2)` manpage.)
+
+Si su nueva llamada de sistema :manpage:`xyzzy(2)` involucra un parámetro
+describiendo un describiendo un movimiento dentro de un archivo, ponga de
+tipo ``loff_t`` para que movimientos de 64-bit puedan ser soportados
+incluso en arquitecturas de 32-bit.
+
+Si su nueva llamada de sistema  :manpage:`xyzzy` involucra una
+funcionalidad privilegiada, esta necesita ser gobernada por la capability
+bit linux apropiada (revisado con una llamada a ``capable()``), como se
+describe en el man page :manpage:`capabilities(7)`. Elija una parte de
+capability linux que govierne las funcionalidades relacionadas, pero trate
+de evitar combinar muchas funciones sólo relacionadas vagamente bajo la
+misma sección, ya que va en contra de los propósitos de las capabilities de
+dividir el poder del usuario root. En particular, evite agregar nuevos usos
+de la capacidad ya demasiado general de la capabilities ``CAP_SYS_ADMIN``.
+
+Si su nueva llamada de sistema :manpage:`xyzzy(2)` manipula un proceso que
+no es el proceso invocado, este debería ser restringido (usando una llamada
+a ``ptrace_may_access()``) de forma que el único proceso con los mismos
+permisos del proceso objetivo, o con las capacidades (capabilities)
+necesarias, pueda manipulador el proceso objetivo.
+
+Finalmente, debe ser conciente de que algunas arquitecturas no-x86 tienen
+un manejo más sencillo si los parámetros que son explícitamente 64-bit
+caigan en argumentos enumerados impares (i.e. parámetros 1,3,5), para
+permitir el uso de pares contiguos de registros 32-bits. (Este cuidado no
+aplica si el argumento es parte de una estructura que se pasa a través de
+un puntero.)
+
+Proponiendo el API
+------------------
+
+Para hacer una nueva llamada al sistema fácil de revisar, es mejor dividir
+el patchset (conjunto de parches) en trozos separados. Estos deberían
+incluir al menos los siguientes items como commits distintos (cada uno de
+los cuales se describirá más abajo):
+
+ - La implementación central de la llamada al sistema, junto con
+   prototipos, numeración genérica, cambios Kconfig e implementaciones de
+   rutinas de respaldo (fallback stub)
+ - Conectar la nueva llamada a sistema a una arquitectura particular,
+   usualmente x86 (incluyendo todas las x86_64, x86_32 y x32).
+ - Una demostración del use de la nueva llamada a sistema en el userspace
+   vía un selftest en ``tools/testing/selftest/``.
+ - Un borrador de man-page para la nueva llamada a sistema, ya sea como
+   texto plano en la carta de presentación, o como un parche (separado)
+   para el repositorio man-pages.
+
+Nuevas propuestas de llamadas de sistema, como cualquier cambio al API del
+kernel, debería siempre ser copiado a linux-api@vger.kernel.org.
+
+
+Implementation de Llamada de Sistema Generica
+---------------------------------------------
+
+La entrada principal a su nueva llamada de sistema :manpage:`xyzzy(2)` será
+llamada ``sys_xyzzy()``, pero incluya este punto de entrada con la macro
+``SYSCALL_DEFINEn()`` apropiada en vez de explicitamente. El 'n' indica el
+numero de argumentos de la llamada de sistema, y la macro toma el nombre de
+la llamada de sistema seguida por el par (tipo, nombre) para los parámetros
+como argumentos. Usar esta macro permite a la metadata de la nueva llamada
+de sistema estar disponible para otras herramientas.
+
+El nuevo punto de entrada también necesita un prototipo de función
+correspondiente en ``include/linux/syscalls.h``,  marcado como asmlinkage
+para calzar en la manera en que las llamadas de sistema son invocadas::
+
+    asmlinkage long sys_xyzzy(...);
+
+Algunas arquitecturas (e.g. x86) tienen sus propias tablas de syscall
+específicas para la arquitectura, pero muchas otras arquitecturas comparten
+una tabla de syscall genéricas. Agrega su nueva llamada de sistema a la
+lista genérica agregando una entrada a la lista en
+``include/uapi/asm-generic/unistd.h``::
+
+    #define __NR_xyzzy 292
+    __SYSCALL(__NR_xyzzy, sys_xyzzy )
+
+También actualice el conteo de __NR_syscalls para reflejar la llamada de
+sistema adicional, y note que si multiples llamadas de sistema nuevas son
+añadidas en la misma ventana unida, su nueva llamada de sistema podría
+tener que ser ajustada para resolver conflictos.
+
+El archivo ``kernel/sys_ni.c`` provee una implementación fallback stub
+(rutina de respaldo) para cada llamada de sistema, retornando ``-ENOSYS``.
+Incluya su nueva llamada a sistema aquí también::
+
+    COND_SYSCALL(xyzzy);
+
+Su nueva funcionalidad del kernel, y la llamada de sistema que la controla,
+debería normalmente ser opcional, así que incluya una opción ``CONFIG``
+(tipicamente en ``init/Kconfig``) para ella. Como es usual para opciones
+``CONFIG`` nuevas:
+
+ - Incluya una descripción para la nueva funcionalidad y llamada al sistema
+   controlada por la opción.
+ - Haga la opción dependiendo de EXPERT si esta debe estar escondida de los
+   usuarios normales.
+ - Haga que cualquier nuevo archivo fuente que implemente la función
+   dependa de la opción CONFIG en el Makefile (e.g.
+   ``obj-$(CONFIG_XYZZY_SYSCALL) += xyzzy.o``).
+ - Revise dos veces que el kernel se siga compilando con la nueva opción
+   CONFIG apagada.
+
+Para resumir, necesita un commit que incluya:
+
+ - una opción ``CONFIG`` para la nueva función, normalmente en ``init/Kconfig``
+ - ``SYSCALL_DEFINEn(xyzzy, ...)`` para el punto de entrada
+ - El correspondiente prototipo en ``include/linux/syscalls.h``
+ - Una entrada genérica en ``include/uapi/asm-generic/unistd.h``
+ - fallback stub en ``kernel/sys_ni.c``
+
+
+Implementación de Llamada de Sistema x86
+----------------------------------------
+
+Para conectar su nueva llamada de sistema a plataformas x86, necesita
+actualizar las tablas maestras syscall. Asumiendo que su nueva llamada de
+sistema ni es especial de alguna manera (revise abajo), esto involucra una
+entrada "común" (para x86_64 y x86_32) en
+arch/x86/entry/syscalls/syscall_64.tbl::
+
+    333   common   xyzz     sys_xyzzy
+
+y una entrada "i386" en ``arch/x86/entry/syscalls/syscall_32.tbl``::
+
+    380   i386     xyzz     sys_xyzzy
+
+De nuevo, estos número son propensos de ser cambiados si hay conflictos en
+la ventana de integración relevante.
+
+
+Compatibilidad de Llamadas de Sistema (Genérica)
+------------------------------------------------
+
+Para la mayoría de llamadas al sistema la misma implementación 64-bit puede
+ser invocada incluso cuando el programa de userspace es en si mismo 32-bit;
+incluso si los parámetros de la llamada de sistema incluyen un puntero
+explícito, esto es manipulado de forma transparente.
+
+Sin embargo, existe un par de situaciones donde se necesita una capa de
+compatibilidad para lidiar con las diferencias de tamaño entre 32-bit y
+64-bit.
+
+La primera es si el kernel 64-bit también soporta programas del userspace
+32-bit, y por lo tanto necesita analizar areas de memoria del (``__user``)
+que podrían tener valores tanto 32-bit como 64-bit. En particular esto se
+necesita siempre que un argumento de la llamada a sistema es:
+
+ - un puntero a un puntero
+ - un puntero a un struc conteniendo un puntero (por ejemplo
+   ``struct iovec __user *``)
+ - un puntero a un type entero de tamaño entero variable (``time_t``,
+   ``off_t``, ``long``, ...)
+ - un puntero a un struct conteniendo un type entero de tamaño variable.
+
+La segunda situación que requiere una capa de compatibilidad es cuando uno
+de los argumentos de la llamada a sistema tiene un argumento que es
+explícitamente 64-bit incluso sobre arquitectura 32-bit, por ejemplo
+``loff_t`` o ``__u64``. En este caso, el valor que llega a un kernel 64-bit
+desde una aplicación de 32-bit se separará en dos valores de 32-bit, los
+que luego necesitan ser reensamblados en la capa de compatibilidad.
+
+(Note que un argumento de una llamada a sistema que sea un puntero a un
+type explicitamente de 64-bit **no** necesita una capa de compatibilidad;
+por ejemplo, los argumentos de :manpage:`splice(2)`) del tipo
+``loff_t __user *`` no significan la necesidad de una llamada a sistema
+``compat_``.)
+
+La versión compatible de la llamada de sistema se llama
+``compat_sys_xyzzy()``, y se agrega con la macro
+``COMPAT_SYSCALL_DEFINEn``, de manera análoga a SYSCALL_DEFINEn. Esta
+versión de la implementación se ejecuta como parte de un kernel de 64-bit,
+pero espera recibir parametros con valores 32-bit y hace lo que tenga que
+hacer para tratar con ellos. (Típicamente, la versión ``compat_sys_``
+convierte los valores a versiones de 64 bits y llama a la versión ``sys_``
+o ambas llaman a una función de implementación interna común.)
+
+El punto de entrada compat también necesita un prototipo de función
+correspondiente, en ``include/linux/compat.h``, marcado como asmlinkage
+para igualar la forma en que las llamadas al sistema son invocadas::
+
+    asmlinkage long compat_sys_xyzzy(...);
+
+Si la nueva llamada al sistema involucra una estructura que que se dispone
+de forma distinta en sistema de 32-bit y 64-bit, digamos
+``struct xyzzy_args``, entonces el archivo de cabecera
+include/linux/compat.h también debería incluir una versión compatible de la
+estructura (``struct compat_xyzzy_args``) donde cada campo de tamaño
+variable tiene el tipo ``compat_`` apropiado que corresponde al tipo en
+``struct xyzzy_args``. La rutina ``compat_sys_xyzzy()`` puede entonces usar
+esta estructura ``compat_`` para analizar los argumentos de una invocación
+de 32-bit.
+
+Por ejemplo, si hay campos::
+
+    struct xyzzy_args {
+      const char __user *ptr;
+      __kernel_long_t varying_val;
+      u64 fixed_val;
+      /* ... */
+    };
+
+en struct xyzzy_args, entonces struct compat_xyzzy_args debe tener::
+
+    struct compat_xyzzy_args {
+      compat_uptr_t ptr;
+      compat_long_t varying_val;
+      u64 fixed_val;
+      /* ... */
+    };
+
+la lista genérica de llamadas al sistema también necesita ajustes para
+permitir la versión compat; la entrada en
+``include/uapi/asm-generic/unistd.h`` debería usar ``__SC_COMP`` en vez de
+``__SYSCALL``::
+
+    #define __NR_xyzzy 292
+    __SC_COMP(__NR_xyzzy, sys_xyzzy, compat_sys_xyzzy)
+
+Para resumir, necesita:
+
+  - una ``COMPAT_SYSCALL_DEFINEn(xyzzy, ...)`` para el punto de entrada de compat.
+  - el prototipo correspondiente en ``include/linux/compat.h``
+  - (en caso de ser necesario) un struct de mapeo de 32-bit en ``include/linux/compat.h``
+  - una instancia de ``__SC_COMP`` no ``__SYSCALL`` en ``include/uapi/asm-generic/unistd.h``
+
+Compatibilidad de Llamadas de Sistema (x86)
+-------------------------------------------
+
+Para conectar la arquitectura x86 de una llamada al sistema con una versión
+de compatibilidad, las entradas en las tablas de syscall deben ser
+ajustadas.
+
+Primero, la entrada en ``arch/x86/entry/syscalls/syscall_32.tbl`` recibe
+una columna extra para indicar que un programa del userspace de 32-bit
+corriendo en un kernel de 64-bit debe llegar al punto de entrada compat::
+
+    380  i386     xyzzy      sys_xyzzy    __ia32_compat_sys_xyzzy
+
+Segundo, tienes que averiguar qué debería pasar para la versión x32 ABI de
+la nueva llamada al sistema. Aquí hay una elección: el diseño de los
+argumentos debería coincidir con la versión de 64-bit o la versión de
+32-bit.
+
+Si hay involucrado un puntero-a-puntero, la decisión es fácil: x32 es
+ILP32, por lo que el diseño debe coincidir con la versión 32-bit, y la
+entrada en ``arch/x86/entry/syscalls/syscall_64.tbl`` se divide para que
+progamas 32-bit lleguen al envoltorio de compatibilidad::
+
+    333   64        xyzzy       sys_xyzzy
+    ...
+    555   x32       xyzzy       __x32_compat_sys_xyzzy
+
+Si no hay punteros involucrados, entonces es preferible reutilizar el system
+call 64-bit para el x32 ABI  (y consecuentemente la entrada en
+arch/x86/entry/syscalls/syscall_64.tbl no se cambia).
+
+En cualquier caso, debes revisar que lo tipos involucrados en su diseño de
+argumentos de hecho asigne exactamente de x32 (-mx32) a 32-bit(-m32) o
+equivalentes 64-bit (-m64).
+
+
+Llamadas de Sistema Retornando a Otros Lugares
+----------------------------------------------
+
+Para la mayoría de las llamadas al sistema, una vez que se la llamada al
+sistema se ha completado el programa de usuario continúa exactamente donde
+quedó -- en la siguiente instrucción, con el stack igual y la mayoría de
+los registros igual que antes de la llamada al sistema, y con el mismo
+espacio en la memoria virtual.
+
+Sin embargo, unas pocas llamadas al sistema hacen las cosas diferente.
+Estas podrían retornar a una ubicación distinta (``rt_sigreturn``) o
+cambiar el espacio de memoria (``fork``/``vfork``/``clone``) o incluso de
+arquitectura (``execve``/``execveat``) del programa.
+
+Para permitir esto, la implementación del kernel de la llamada al sistema
+podría necesitar guardar y restaurar registros adicionales al stak del
+kernel, brindandole control completo de donde y cómo la ejecución continúa
+después de la llamada a sistema.
+
+Esto es arch-specific, pero típicamente involucra definir puntos de entrada
+assembly que guardan/restauran registros adicionales e invocan el punto de
+entrada real de la llamada a sistema.
+
+Para x86_64, esto es implementado como un punto de entrada ``stub_xyzzy``
+en ``arch/x86/entry/entry_64.S``, y la entrada en la tabla syscall
+(``arch/x86/entry/syscalls/syscall_32.tbl``) es ajustada para calzar::
+
+    333   common  xyzzy     stub_xyzzy
+
+El equivalente para programas 32-bit corriendo en un kernel 64-bit es
+normalmente llamado ``stub32_xyzzy`` e implementado en
+``arch/x86/entry/entry_64_compat.S``, con el correspondiente ajuste en la
+tabla syscall en ``arch/x86/syscalls/syscall_32.tbl``::
+
+    380    i386       xyzzy     sys_xyzzy     stub32_xyzzy
+
+Si la llamada a sistema necesita una capa de compatibilidad (como en la
+sección anterior) entonces la versión ``stub32_`` necesita llamar a la
+versión ``compat_sys_`` de la llamada a sistema, en vez de la versión
+nativa de 64-bit. También, si la implementación de la versión x32 ABI no es
+comun con la versión x86_64, entonces su tabla syscall también necesitará
+invocar un stub que llame a la versión ``compat_sys_``
+
+Para completar, también es agradable configurar un mapeo de modo que el
+user-mode linux todavía funcione -- su tabla syscall referenciará
+stub_xyzzy, pero el UML construido no incluye una implementación
+``arch/x86/entry/entry_64.S``. Arreglar esto es tan simple como agregar un
+#define a ``arch/x86/um/sys_call_table_64.c``::
+
+    #define stub_xyzzy sys_xyzzy
+
+
+Otros detalles
+--------------
+
+La mayoría del kernel trata las llamadas a sistema de manera genérica, pero
+está la excepción ocasional que pueda requerir actualización para su
+llamada a sistema particular.
+
+El subsistema de auditoría es un caso especial; este incluye funciones
+(arch-specific) que clasifican algunos tipos especiales de llamadas al
+sistema -- específicamente file open (``open``/``openat``), program
+execution (``execve`` /``execveat``) o operaciones multiplexores de socket
+(``socketcall``). Si su nueva llamada de sistema es análoga a alguna de
+estas, entonces el sistema auditor debe ser actualizado.
+
+Más generalmente, si existe una llamada al sistema que sea análoga a su
+nueva llamada al sistema, entonces vale la pena hacer un grep a todo el
+kernel de la llamada a sistema existente, para revisar que no exista otro
+caso especial.
+
+
+Testing
+-------
+
+Una nueva llamada al sistema debe obviamente ser probada; también es útil
+proveer a los revisores con una demostración de cómo los programas del
+userspace usarán la llamada al sistema. Una buena forma de combinar estos
+objetivos es incluir un simple programa self-test en un nuevo directorio
+bajo ``tools/testing/selftests/``.
+
+Para una nueva llamada al sistema, obviamente no habrá una función
+envoltorio libc por lo que el test necesitará ser invocado usando
+``syscall()``; también, si la llamada al sistema involucra una nueva
+estructura userspace-visible, el encabezado correspondiente necesitará ser
+instalado para compilar el test.
+
+Asegure que selftest corra satisfactoriamente en todas las arquitecturas
+soportadas. Por ejemplo, revise si funciona cuando es compilado como un
+x86_64 (-m64), x86_32 (-m32) y x32 (-mx32) programa ABI.
+
+Para pruebas más amplias y exhautivas de la nueva funcionalidad, también
+debería considerar agregar tests al Linus Test Project, o al proyecto
+xfstests para cambios filesystem-related
+
+  - https://linux-test-project.github.io/
+  - git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
+
+
+Man Page
+--------
+
+Todas las llamada al sistema nueva deben venir con un man page completo,
+idealmente usando groff markup, pero texto plano también funciona. Si se
+usa groff, es útil incluir una versión ASCII pre-renderizada del man-page
+en el cover del email para el patchset, para la conveniencia de los
+revisores.
+
+El man page debe ser cc'do a linux-man@vger.kernel.org
+Para más detalles, revise https://www.kernel.org/doc/man-pages/patches.html
+
+
+No invoque las llamadas de sistemas en el kernel
+------------------------------------------------
+
+Las llamadas al sistema son, cómo se declaró más arriba, puntos de
+interacción entre el userspace y el kernel. Por lo tanto, las funciones de
+llamada al sistema como ``sys_xyzzy()`` o ``compat_sys_xyzzy()`` deberían
+ser llamadas sólo desde el userspace vía la tabla de syscall, pero no de
+otro lugar en el kernel. Si la funcionalidad syscall es útil para ser usada
+dentro del kernel, necesita ser compartida entre syscalls nuevas o
+antiguas, o necesita ser compartida entre una syscall y su variante de
+compatibilidad, esta debería ser implementada mediante una función "helper"
+(como ``ksys_xyzzy()``). Esta función del kernel puede ahora ser llamada
+dentro del syscall stub (``sys_xyzzy()``), la syscall stub de
+compatibilidad (``compat_sys_xyzzy()``), y/o otro código del kernel.
+
+Al menos en 64-bit x86, será un requerimiento duro desde la v4.17 en
+adelante no invocar funciones de llamada al sistema (system call) en el
+kernel. Este usa una convención de llamada diferente para llamadas al
+sistema donde ``struct pt_regs`` es decodificado on-the-fly en un
+envoltorio syscall que luego entrega el procesamiento al syscall real. Esto
+significa que sólo aquellos parámetros que son realmente necesarios para
+una syscall específica son pasados durante la entrada del syscall, en vez
+de llenar en seis registros de CPU con contenido random del userspace todo
+el tiempo (los cuales podrían causar serios problemas bajando la cadena de
+llamadas).
+
+Más aún, reglas sobre cómo se debería acceder a la data pueden diferir
+entre la data del kernel y la data de usuario. Esta es otra razón por la
+cual llamar a ``sys_xyzzy()`` es generalmente una mala idea.
+
+Excepciones a esta regla están permitidas solamente en overrides
+específicos de arquitectura, envoltorios de compatibilidad específicos de
+arquitectura, u otro código en arch/.
+
+
+Referencias y fuentes
+---------------------
+
+ - Artículo LWN de Michael Kerrisk sobre el uso de argumentos flags en llamadas al
+   sistema:
+   https://lwn.net/Articles/585415/
+ - Artículo LWN de Michael Kerrisk sobre cómo manejar flags desconocidos en una
+   llamada al sistema: https://lwn.net/Articles/588444/
+ - Artículo LWN de Jake Edge describiendo restricciones en argumentos en
+   64-bit system call: https://lwn.net/Articles/311630/
+ - Par de artículos LWN de David Drysdale que describen la ruta de implementación
+   de llamadas al sistema en detalle para v3.14:
+
+    - https://lwn.net/Articles/604287/
+    - https://lwn.net/Articles/604515/
+
+ - Requerimientos arquitectura-específicos para llamadas al sistema son discutidos en el
+   :manpage:`syscall(2)` man-page:
+   http://man7.org/linux/man-pages/man2/syscall.2.html#NOTES
+ - Recopilación de emails de Linus Torvalds discutiendo problemas con ``ioctl()``:
+   https://yarchive.net/comp/linux/ioctl.html
+ - "How to not invent kernel interfaces", Arnd Bergmann,
+   https://www.ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
+ - Artículo LWN de Michael Kerrisk sobre evitar nuevos usos de CAP_SYS_ADMIN:
+   https://lwn.net/Articles/486306/
+ - Recomendaciones de Andrew Morton que toda la información relacionada a una nueva
+   llamada al sistema debe venir en el mismo hilo de correos:
+   https://lore.kernel.org/r/20140724144747.3041b208832bbdf9fbce5d96@linux-foundation.org
+ - Recomendaciones de Michael Kerrisk que una nueva llamada al sistema debe venir
+   con un man-page: https://lore.kernel.org/r/CAKgNAkgMA39AfoSoA5Pe1r9N+ZzfYQNvNPvcRN7tOvRb8+v06Q@mail.gmail.com
+ - Sugerencias de Thomas Gleixner que conexiones x86 deben ir en commits
+   separados: https://lore.kernel.org/r/alpine.DEB.2.11.1411191249560.3909@nanos
+ - Sugerencias de Greg Kroah-Hartman que es bueno para las nueva llamadas al sistema
+   que vengan con man-page y selftest: https://lore.kernel.org/r/20140320025530.GA25469@kroah.com
+ - Discusión de Michael Kerrisk de nuevas system call vs. extensiones :manpage:`prctl(2)`:
+   https://lore.kernel.org/r/CAHO5Pa3F2MjfTtfNxa8LbnkeeU8=YJ+9tDqxZpw7Gz59E-4AUg@mail.gmail.com
+ - Sugerencias de Ingo Molnar que llamadas al sistema que involucran múltiples
+   argumentos deben encapsular estos argumentos en una estructura, la cual incluye
+   un campo de tamaño para futura extensibilidad: https://lore.kernel.org/r/20150730083831.GA22182@gmail.com
+ - Enumerando rarezas por la (re-)utilización de O_* numbering space flags:
+
+    - commit 75069f2b5bfb ("vfs: renumber FMODE_NONOTIFY and add to uniqueness
+      check")
+    - commit 12ed2e36c98a ("fanotify: FMODE_NONOTIFY and __O_SYNC in sparc
+      conflict")
+    - commit bb458c644a59 ("Safer ABI for O_TMPFILE")
+
+ - Discusión de Matthew Wilcox sobre las restricciones en argumentos 64-bit:
+   https://lore.kernel.org/r/20081212152929.GM26095@parisc-linux.org
+ - Recomendaciones de Greg Kroah-Hartman sobre flags desconocidos deben ser
+   vigilados: https://lore.kernel.org/r/20140717193330.GB4703@kroah.com
+ - Recomendaciones de Linus Torvalds que las llamadas al sistema x32 deben favorecer
+   compatibilidad con versiones 64-bit sobre versiones 32-bit:
+   https://lore.kernel.org/r/CA+55aFxfmwfB7jbbrXxa=K7VBYPfAvmu3XOkGrLbB1UFjX1+Ew@mail.gmail.com
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 351bcd3921ba..a0ff2e132c54 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -18,3 +18,4 @@
    email-clients
    programming-language
    deprecated
+   adding-syscalls
-- 
2.34.1

