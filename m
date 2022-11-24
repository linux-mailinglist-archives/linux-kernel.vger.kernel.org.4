Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A2637DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKXRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKXRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BA2B1BB;
        Thu, 24 Nov 2022 09:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzUIlsqQx1+uwW0O3dY8R2GF1TIlCYxhJjjVRuRaX+es/HZ8htfF1Ci0rgqpwU/A/SsNjocy09a/t+T+BmdWTyS8V8CC00FWD551BLM/1PplN43C4+OnFwlnqcf7xpwpOcZWjEWAKIvfn27OaI8pmVB8dF4h0+2r3bZiBDUPEFt6fFPfgiA6qek+PByFXfqsSbJFdyLqvnxZW/0EWww8GhdPluEX7A1YWo8n/jcmgx67QuV8d9WYuRSvjf6GowtHBL2la0g1NCLxa9V7fUuutfNBwfZsF+4U/mqaiCNMKsDca2HQo006fsexJ4C6HvQ8vbVgpTP4LSjPBbSBM1EEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db1D8ug9/GltA0r3x1ETVzxepUSksvRIAhwEgIpeuNA=;
 b=IEvtsTorziTE+cKsMIDVCWvceoIk3bqD4hD1ByC8gAT73rp3e0Y0whNzkTLKqLLd8d9rat1XpmLeAI+LpWKizXxTsdYz53vkQwT5I443LwPH4CC9/MlO/h1XtohhQwC+HxToIiB4qlAVNGnAwgRy6GBILNBH8eQGSOGy93FrQeS3Ss6hyx9yBRlAPuEAYYcdmUQZXDEdXMk0mUDKVSUIQiTXqtJRZR83S80VIUkomAGiyeuKj30AUoWGBRWBM0ZvSTxnpRmg06G6m9BnnF6GfvLMa094ATpU7WjNf9X7TICoKM3HKigftPUAPgHRpf+QkOVfrEVJ1qQWsoHFxiLL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db1D8ug9/GltA0r3x1ETVzxepUSksvRIAhwEgIpeuNA=;
 b=pGp67+7gRR+szupHZaPM76MP4Vpv79/XRByU/Nxb/5H5Js8E729cs5cojy+nrCz6QD9iuNl6lZ52o+jkA5vlR/4cw4q3wtCfw61ooJokpMm5zb06ad+uw8KjLrZZHjGOUxxCo1uF7qxqDLu03thAEt9dLEzGC3jG9K2s8gaVfzg=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 17:02:48 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::bd) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 17:02:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:46 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:46 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 5/6] docs/sp_SP: Add kernel-docs.rst Spanish translation
Date:   Thu, 24 Nov 2022 11:02:41 -0600
Message-ID: <20221124170242.1892751-6-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9595d832-7aca-496b-62ca-08dace3db670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXHZgkFT72aIPY/ug3/Rg39nS0aO6FmXNjuFHYFhrlYNDtbOMhKSeBmcu8Zh7oWfAcDRldhINbb+e4FE/sYZWb/+kLqkjMZvVoncUODFhF9ZM/0oMSXkYoWLc8axbcg8D7q4kHzeB6W0p5vvZIbLreozMPD5YCT/VCmdlRvucMYiMaSw8sasw4J45c9XMifooBQakRa/7vUr+1YR4l/fsjkmY8wXKwVoclj1zILY8WdQ0pSXd1cI9IoS51nIV+mjNNzwZ386/RBZV6n0mPBZwOv+QQ85wjsYO/YB0P12bhbEjbHRwijb4MB3UgTZ+yvoF0XFljXltIm5+kT+L8vftMJLz5lsld6ld+nU8k7KBQKuB48tAeyHgioKiNd9BaNLDUmtYaTek0/G2g+ICMuNqW44zcFrE2EdjoSgfCjbSPvv3n8omJ92bF4a/jvno5001IlCRelwPl09PWHrazPgiQ4LEEwBzpQhEDExTCiPk5Zm+zxGiud89CDL1QbTjKQ3ULtNvEH42W+1zsl0h9p+nWAOL21CCB9VmlIZ4p9+4NLbZervq5he22mbCzxeWjlLuS9LNU4KLN2r1arDr61pryZO8koo29gd9HqMBuIzb9T3SoEdQYcJholB5E7qHyZLVxLDQjybpjGedc4PzSmS+imeuaAcWeDTd0e+L6Vbd/NLAiJrjrLwUF4D59gJF5hQD7X97fre+Mnk2atu09GlPBBxzUQBS/9JNGk65AIt+/AEauOeF7LeJfMkBvvDY/5i+LRBcyFRGK/ck4UM51Ga8yAHKk/zk/uHk65FHHeqrSdrG5tB/EcEb4hNCpaEbhiDzrmSyeJ7tw+rif90SjJVqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(8676002)(70586007)(4326008)(70206006)(82740400003)(81166007)(356005)(36860700001)(82310400005)(478600001)(83380400001)(6666004)(7696005)(1076003)(2616005)(26005)(2906002)(47076005)(41300700001)(426003)(54906003)(110136005)(44832011)(5660300002)(316002)(336012)(186003)(8936002)(40460700003)(966005)(36900700001)(562404015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:47.4554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9595d832-7aca-496b-62ca-08dace3db670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/kernel-docs.rst into Spanish.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/kernel-docs.rst             | 187 ++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/kernel-docs.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index ecdf6fa9df0c..4acb7f5005af 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -11,3 +11,4 @@
    :maxdepth: 1
 
    submitting-patches
+   kernel-docs
diff --git a/Documentation/translations/sp_SP/process/kernel-docs.rst b/Documentation/translations/sp_SP/process/kernel-docs.rst
new file mode 100644
index 000000000000..62b8105445fb
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/kernel-docs.rst
@@ -0,0 +1,187 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_kernel_docs:
+
+Índice de documentación adicional del kernel
+============================================
+
+La necesidad de un documento como este se hizo evidente en la lista de
+correo de linux-kernel cuando las mismas preguntas, solicitando sugerencias
+e información, aparecieron una y otra vez.
+
+Afortunadamente, a medida que más y más gente accede a GNU/Linux, más
+desarrolladores se interesan por el kernel. Sin embargo, leer las fuentes
+no siempre es suficiente. Es fácil entender el código, pero se pierden los
+conceptos, la filosofía y decisiones de diseño detrás de dicho código.
+
+Desafortunadamente, no existen muchos documentos disponibles para que los
+principiantes comiencen. Y, aunque existieran, no habría ningún lugar
+"conocido" que les pudiera seguir la pista. Estas líneas tratan de cubrir
+esta carencia.
+
+POR FAVOR, si conoce algún documento que no figura aquí, o si escribe un
+nuevo documento, incluya una referencia aquí, siguiendo el proceso de envío
+de parches del kernel. Cualquier corrección, idea o comentario también es
+bienvenida.
+
+Todos los documentos se catalogan con los siguientes campos: el "Título",
+el "Autor"/es, la "URL" donde se encuentran, algunas "Palabras clave"
+útiles para buscar temas específicos, y una breve "Descripción" del
+documento en cuestión.
+
+.. note::
+
+   Los documentos de cada sección en este documento están ordenados por su
+   fecha de publicación, del más reciente al más antiguo. Los maintainers
+   deben ir retirando recursos obsoletos o anticuados.
+
+Documentos en el árbol del kernel Linux
+-----------------------------------------
+
+Los libros de Sphinx deben compilarse con ``make {htmldocs | pdfdocs | epubdocs}``.
+
+    * Título: **linux/Documentation**
+
+      :Autor: Many.
+      :Ubicación: Documentation/
+      :Palabras Clave: archivos de texto, Sphinx.
+      :Descripción: Documentación que viene con las fuentes del kernel,
+        dentro del directorio Documentation. Algunas páginas de este documento
+        (incluido este documento en sí) se han trasladado allí, y podrían
+        estar más actualizadas que la versión web.
+
+Documentos en línea
+-------------------
+
+    * Título: **Linux Kernel Mailing List Glossary**
+
+      :Autor: various
+      :URL: https://kernelnewbies.org/KernelGlossary
+      :Fecha: rolling version
+      :Palabras Clave: glosario terminos, linux-kernel.
+      :Descripción: De la Introducción: "This glossary is intended as
+        a brief description of some of the acronyms and terms you may hear
+        during discussion of the Linux kernel".
+
+    * Título: **The Linux Kernel Module Programming Guide**
+
+      :Autor: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+        Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Fecha: 2021
+      :Palabras Clave: modules, GPL book, /proc, ioctls, system calls,
+        interrupt handlers, llamadas al sistema, interrupciones.
+      :Descripción: Un muy buen libro GPL sobre el tema de la programación
+        de módulos. Muchos ejemplos. Actualmente la nueva versión está
+        siendo mantenida activamente ent https://github.com/sysprog21/lkmpg.
+
+Libros publicados
+-----------------
+
+    * Título: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
+
+      :Autor: Kaiwan N. Billimoria
+      :Publica: Packt Publishing Ltd
+      :Fecha: 2021
+      :Paginas: 754
+      :ISBN: 978-1789953435
+
+    * Título: **Linux Kernel Development, 3rd Edition**
+
+      :Autor: Robert Love
+      :Publica: Addison-Wesley
+      :Fecha: July, 2010
+      :Paginas: 440
+      :ISBN: 978-0672329463
+      :Notas: Libro fundacional
+
+.. _sp_ldd3_published:
+
+    * Título: **Linux Device Drivers, 3rd Edition**
+
+      :Authors: Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman
+      :Publica: O'Reilly & Associates
+      :Fecha: 2005
+      :Paginas: 636
+      :ISBN: 0-596-00590-3
+      :Notas: Libro fundacional. Más información en
+        http://www.oreilly.com/catalog/linuxdrive3/
+        formato PDF, URL: https://lwn.net/Kernel/LDD3/
+
+    * Título: **The Design of the UNIX Operating System**
+
+      :Autor: Maurice J. Bach
+      :Publica: Prentice Hall
+      :Fecha: 1986
+      :Paginas: 471
+      :ISBN: 0-13-201757-1
+      :Notas: Libro fundacional
+
+Recursos varios
+---------------
+
+    * Título: **Cross-Referencing Linux**
+
+      :URL: https://elixir.bootlin.com/
+      :Palabras Clave: Browsing source code.
+      :Descripción: Otro navegador de código fuente del kernel Linux que se
+        encuentra en la web.  Muchas referencias cruzadas a variables y
+        funciones. Puedes ver dónde se definen y dónde se utilizan.
+
+    * Título: **Linux Weekly News**
+
+      :URL: https://lwn.net
+      :Palabras Clave: latest kernel news, noticias del kernel Linux.
+      :Descripción: El título lo dice todo (Noticias Semanales de Linux).
+        Hay una sección fija sobre el kernel, resumiendo el trabajo de sus
+        desarrolladores, correcciones de errores, nuevas funciones y
+        versiones, producido durante la semana.
+
+    * Título: **The home page of Linux-MM**
+
+      :Autor: The Linux-MM team.
+      :URL: https://linux-mm.org/
+      :Palabras Clave: memory management, Linux-MM, mm patches, TODO, docs,
+        mailing list, administración de memoria, Linux-MM, parches mm, listas
+        de correo.
+      :Descripción: Sitio dedicado al desarrollo de la gestión de memoria
+        de Linux. Parches relacionados con la memoria, HOWTOs, enlaces,
+        desarrolladores de mm... ¡Si está interesado en el desarrollo de la
+        gestión de memoria no te lo pierdas!
+
+    * Título: **Kernel Newbies IRC Channel and Website**
+
+      :URL: https://www.kernelnewbies.org
+      :Palabras Clave: IRC, newbies, channel, asking doubts, canal, dudas,
+        novatos, preguntar.
+      :Descripción: #kernelnewbies en irc.oftc.net.
+        #kernelnewbies es una red de IRC dedicada al hacker del kernel
+        'novato'. La audiencia se compone principalmente de personas que
+        quieren aprender sobre el kernel, trabajar en proyectos del kernel
+        o hackers profesionales del kernel que quieren ayudar a la gente
+        menos experimentada.
+        #kernelnewbies es parte de la red OFTC IRC.
+        Pruebe con irc.oftc.net como su servidor y luego haga /join
+        #kernelnewbies.
+        El sitio web kernelnewbies también alberga artículos, documentos, FAQs...
+
+    * Título: **linux-kernel mailing list archives and search engines**
+
+      :URL: http://vger.kernel.org/vger-lists.html
+      :URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
+      :URL: http://groups.google.com/group/mlist.linux.kernel
+      :Palabras Clave: linux-kernel, archives, buscar, search, archivos.
+      :Descripción: Algunos de los archivadores de listas de correo del
+        kernel de Linux. Si usted tiene uno mejor/otro, por favor hágamelo
+        saber.
+
+-------
+
+Este documento se basaba originalmente en:
+
+  https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
+
+escrito por Juan-Mariano de Goyenche
-- 
2.34.1

