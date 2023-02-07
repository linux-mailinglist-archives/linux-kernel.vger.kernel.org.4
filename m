Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E168E341
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBGWIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBGWIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:08:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32301718;
        Tue,  7 Feb 2023 14:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP1pSt2rwMIIpA1HeXdi+lwWY8F5SQ8fM4INaHwZ0RPM0BTZ6EH+Mr7A8Q5no84CJUbIFE31JzbHBViR5nYdoCy9lIXHnfSt9lxEls1BvX4547MsvyRuHPQzJ3nZssnojDxcGxK9CAIFSXwHxNZw4/AbnXwtBg7s8LEOlNmz2BRmyYOLdBKuvf+4Cq6rfq4ZBZ/+FAgW0srJsKVnbDltG3YRAwTTXEnaSYhrjdaob7SBCXehh8OftFZ1Q8/StUZ9e135chr1BLEhofWiINwUy3msiAbgIudm+ApO9lWMDWnQvhoKDPOek45Gi3gFCQXY+AtRIFhprby2wsYSx6j1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhJrz0UPPAttYYlsH1uONgI493axlUkzqiO90vjoCpw=;
 b=EF1sXuq+uwLAq9+vO6axkv1bJajOmzi1p5UVjqlW+Ur78mbutRAaVt2vvIWRpHAC4F7b0xx36q0icj5XKUuC2n7oqBx/P+HhVZNW3TiA8JBDsnFsIkj2dtCJ4pgBL32HTSFKCKnwAsO0ubVccLmpFatII/iqIyyosEJA/+Ut4ahvq+8D5Nnwq38OsbiTeFNjwWKvc5kq5azSAW/O2zRJWsIg77RcSZ6QJzFoVUqPpjks1ri+P/GeAjTO24nZbS0aON2arMjvyQzUy9TVkmSr5Sw5Pov1GnGBCvhxeBcAgZ3Jy2zcmezNhoWqtOtKrHFz0KCzCoF92mCGU6ZqWmIuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhJrz0UPPAttYYlsH1uONgI493axlUkzqiO90vjoCpw=;
 b=lwrhqVlEQDqQcPPhM544xS3JcTxLS5/zNWiRqb98cw5iPrpYOvAYES+hB6M3PYMSdRUm8RnQhlP3unQBh0Lmihdeg9ZuwrgrL4rkQ3LyAJZIRXj6bQwq1IMZGqjKb2LpdYcsK/3SKUKW3wAxV1foJz92AO4dEiuzd+eaOwVL81k=
Received: from BN9PR03CA0704.namprd03.prod.outlook.com (2603:10b6:408:ef::19)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 22:08:46 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::9d) by BN9PR03CA0704.outlook.office365.com
 (2603:10b6:408:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 22:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 22:08:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 16:08:45 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Feb 2023 16:08:44 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add process programming-language translation
Date:   Tue, 7 Feb 2023 16:08:44 -0600
Message-ID: <20230207220844.2661295-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dd3084-e04e-496a-3418-08db0957e194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFD2iX5IuorUg9zrpM6+Shcud1MmQZmJRh5LJ/tPHaZv9gpo7RwSJEOgIpZ1zUboG9G5prG3igzSxRQrz7S6pnoKohGB5DrB0qbjxu7QUQJpXwP9uWt66TaLgalrZmb/IA7aWN0prfACdmeVIeMjPa4Sshe8O/Q3gS9KSVN17t7HpKvMk4/q5BJyanOuDpruJ14wQCMzCOIgv/jsinA2k23iN0IqAcDX5BrftQ/0mxNYBXBJX2lc27VoEw5nKg8LSpR8grtZyDXk696HnZaXWRTVHS8FN++oAmIfLtfDbXA5H1PWRC36+i75W9kPqihsbZynSpi2rR6BwC+85DIh4CHM+osqBB6N5RI74V4aDRgYmsf+06jhvGmZLv/Pd0c2hlrt62sB8QUcMKWCOKd3oPTuL+ZWJhHd/QZPkQ6xjoQiaa8OV3LQWx2VVeVniPgAufjONsGUNSwTFgr/WVzrvoEv4TOZAMh0F7KGZkOHDSPDm15dzA1up5IakA1hVbRH1hfGbq8drkD/ZYoYVzcCZiIqbzzClmkGX3Vdg5Omh0gnmEtRUPj6ssbcHT23ptsM+HZHoLwkHS5zcgffkQjz6aguzTMwghCtL9B92UOsgBkHOfCVXYBIzhUf74PDxR4Tw/KElYijynBr7//NQcoNmfj7xyPb1rGjD/6MVGJHe6b49Y3D6LuPKJaxJnnxkXALkg3fDjrPNP5TpPWX1gPf/MSdu7OGECSlypeksdfzeoQO1W1jKQhg3RE+zSAzCFBsoYtueGi2qzle+n7LjTaSTad5/nzgLqbl/5rvWvkMLmHK26GIpN/aP3Z0o46qMPKG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(336012)(1076003)(186003)(26005)(82740400003)(2616005)(47076005)(426003)(83380400001)(7696005)(966005)(478600001)(36860700001)(356005)(81166007)(4326008)(70586007)(8676002)(316002)(54906003)(6916009)(86362001)(8936002)(5660300002)(44832011)(41300700001)(36756003)(40460700003)(2906002)(70206006)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 22:08:45.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd3084-e04e-496a-3418-08db0957e194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/programming-language.rst into Spanish.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |  1 +
 .../sp_SP/process/programming-language.rst    | 53 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/programming-language.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index c978a8132ce1..0f1e131b3bb1 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -17,3 +17,4 @@
    kernel-enforcement-statement
    email-clients
    magic-number
+   programming-language
diff --git a/Documentation/translations/sp_SP/process/programming-language.rst b/Documentation/translations/sp_SP/process/programming-language.rst
new file mode 100644
index 000000000000..301f525372d8
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/programming-language.rst
@@ -0,0 +1,53 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_programming_language:
+
+Lenguaje de programación
+========================
+
+El kernel está escrito en el lenguaje de programación C [sp-c-language]_.
+Más concretamente, el kernel normalmente se compila con ``gcc`` [sp-gcc]_
+bajo ``-std=gnu11`` [sp-gcc-c-dialect-options]_: el dialecto GNU de ISO C11.
+``clang`` [sp-clang]_ también es compatible, consulte los documentos en
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
+Este dialecto contiene muchas extensiones del lenguaje [sp-gnu-extensions]_,
+y muchos de ellos se usan dentro del kernel de forma habitual.
+
+Hay algo de soporte para compilar el núcleo con ``icc`` [sp-icc]_ para varias
+de las arquitecturas, aunque en el momento de escribir este texto, eso no
+está terminado y requiere parches de terceros.
+
+Atributos
+---------
+
+Una de las comunes extensiones utilizadas en todo el kernel son los atributos
+[sp-gcc-attribute-syntax]_. Los atributos permiten introducir semántica
+definida por la implementación a las entidades del lenguaje (como variables,
+funciones o tipos) sin tener que hacer cambios sintácticos significativos
+al idioma (por ejemplo, agregar una nueva palabra clave) [sp-n2049]_.
+
+En algunos casos, los atributos son opcionales (es decir, hay compiladores
+que no los admiten pero de todos modos deben producir el código adecuado,
+incluso si es más lento o no realiza tantas comprobaciones/diagnósticos en
+tiempo de compilación).
+
+El kernel define pseudo-palabras clave (por ejemplo, ``__pure``) en lugar
+de usar directamente la sintaxis del atributo GNU (por ejemplo,
+``__attribute__((__pure__))``) con el fin de detectar cuáles se pueden
+utilizar y/o acortar el código.
+
+Por favor consulte ``include/linux/compiler_attributes.h`` para obtener
+más información.
+
+.. [sp-c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [sp-gcc] https://gcc.gnu.org
+.. [sp-clang] https://clang.llvm.org
+.. [sp-icc] https://software.intel.com/en-us/c-compilers
+.. [sp-gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [sp-gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [sp-gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [sp-n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
-- 
2.34.1

