Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A845FF041
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJNOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJNOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:25:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6F6248C3;
        Fri, 14 Oct 2022 07:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO4d+svlkypMegKhzoMKdyRkPENZlnbR2ObttVj6frLFnqNBDn1IqVhSwnQzGdR1zQxxWZR2smAOQ8pkQWo/2LUrp2Zjr8tg3OQCqSNKEgJDqUB/LUy8yIqHuld5vmuFZ6H48kLLOZzJ0UwvXr8NtfcW84nA4yZ4RtK7ipOPC9uomqtayef6TRdS7myyLvclJ6UsGh/g8Ueu0+N8tI6JGBVxH5JtEkeTYFAc0rFfldzgWvJy9KUc/h/ZVNILwC9/1cNKR12p7K1ZWLEGq+tOHjB8CeL/cJJvEtLxfqDGcks+QtIf2YI7seWlnOmmCCjiqNr24rICjXVGunnf3MxqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucfijwcKL18SJLYrpJXgCzV/+yPD1G4mZkaIyT9Dq3M=;
 b=iuQnWTF6orWWSye6/FslV3N4G65U3u4bFLEaDLCDxEU/SrmtBJ0CLlRSJzbMfu9iMEhO535NFzP6fFG9X3aMpQ5I9/ApXm/KJROrr82bVQbrdHHnPfBxyVGNhm51FYqNAsrBgydEgchrxYH/I5oC4pYtNoO+75Kk+yccNk2fymp9mMjn08YIMtaYFJMM8NIr6kKNe6fzoh4uNPP8Uge19M/q3RO+sF2yEaBmcBGlaXivWwNgwOUxmPW49PsMlNgT9o3zm0Bhvs8058ABXVd98xxfjP+WyuSpZ7Tv25KeGkwXz7e5NIdekrC3XmwK3krbNAz27N561KSbADFMY4I5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucfijwcKL18SJLYrpJXgCzV/+yPD1G4mZkaIyT9Dq3M=;
 b=TSqA++iMAB2mVYwsMB8yn3lliIOb6YzwQjK/JLiR+6M2mNmWBbjEX+q7AyM6EQ67Kg5Qrh/9O6rREiFvnXP31u8I9Nwnf1XKr1EZkrkavN5Jm78NarlqCqPQLLQ7P+QSzvghyD3ZG+tjpYUmhgICOZYTXdu+uxz2047BQt60jIA=
Received: from DS7PR03CA0233.namprd03.prod.outlook.com (2603:10b6:5:3ba::28)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 14:24:57 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::a2) by DS7PR03CA0233.outlook.office365.com
 (2603:10b6:5:3ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Fri, 14 Oct 2022 14:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 14:24:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 09:24:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 09:24:55 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 14 Oct 2022 09:24:55 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 1/2] Documentation: Start translations to Spanish
Date:   Fri, 14 Oct 2022 09:24:53 -0500
Message-ID: <20221014142454.871196-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014142454.871196-1-carlos.bilbao@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|BN9PR12MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 85628c3f-ffd1-407b-77d6-08daadefde32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueSa47appqZqQ6DuBXXIUYZzi9FRByJkDzyhMf0tR8cOlA0bvl026iYUY5dK3WYzLb/sG6QOPvPw6UbULJ+Otp5Wqt7WR9OCgMgVXsE7YIBTEVDHUyOu1Fc18U0R+c5Q6H+cVtB4UeQyL3o0vpD9sAzUGZ/blsYQnHT9PTsXZIOT8C59zhGaWtFB/qw6qilyHzOJ5WIHnjVZOSElHsjzXCc21u+8M3k0jPfb0tqz4uCLwnT3SNaNoWPBmSILGWjbw0haFyiuIpQZ/iY3asfCvuOqsXqXrvpOvc870srNrRozlJLHW3lIv/b+5/rblr4mfkHKg6L1Jxj9QXNGp+T5oeWDpn8CpWvTspsDUKEgiElm9g5IuY+b43FJgWxLL9tG9GPYvqUAf3j9YJGUWY7aH+CP/BbEliU+52R0/YFnQqU8Mx6pdKS/d3iHAHyoLTQ4YgDmA0ff64/X5rWOFu6grGdV9qFBA4MHlIVoF17Xo881g4tHs94I8qA6BEreKdkpiK7/ed0oEcgJyWnWOJi173qqSH3pSTCLlRMGs51TuG+UA/LAUsu7krKbp949S2dYlgcqaiF/1zTQCYIeQXvFqtKsWzj28cCwSQv6tvYpXpa5ir5udSzdF4oLF15iVFDtUkz/MWnIDB69Juy2lVz+QArXlrtRKYRxhtCfzj8js4mssXp6Kzs9Uc73nt6idUseFthJUWC2Eu2TeXCrRmEFv7CyKSKvGveYOraZQh4y6Dh731hQVfJhi/hzdM2V3g6TiGaDF7CgyMrOXcVUYxHnwSvRIKhAbP9ShePer2bgV7F51A/7EFwIlq2YJzs8vSdTXDZekbn4TQVh2mgfGXkMTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(70586007)(44832011)(426003)(86362001)(66574015)(2906002)(5660300002)(82310400005)(36860700001)(336012)(82740400003)(1076003)(186003)(47076005)(2616005)(81166007)(83380400001)(356005)(7696005)(478600001)(966005)(54906003)(6916009)(26005)(4326008)(8936002)(41300700001)(8676002)(40480700001)(70206006)(40460700003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:24:56.2359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85628c3f-ffd1-407b-77d6-08daadefde32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the process of translating kernel documentation to Spanish. Create
sp_SP/ and include an index and a disclaimer, following the approach of
prior translations. Add Carlos Bilbao as MAINTAINER of this translation
effort.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/index.rst          |  1 +
 .../translations/sp_SP/disclaimer-sp.rst      |  6 ++
 Documentation/translations/sp_SP/index.rst    | 72 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 4 files changed, 84 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
 create mode 100644 Documentation/translations/sp_SP/index.rst

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 1175a47d07f0..b826c34791c0 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -12,6 +12,7 @@ Translations
    it_IT/index
    ko_KR/index
    ja_JP/index
+   sp_SP/index
 
 
 .. _translations_disclaimer:
diff --git a/Documentation/translations/sp_SP/disclaimer-sp.rst b/Documentation/translations/sp_SP/disclaimer-sp.rst
new file mode 100644
index 000000000000..a400034e95f9
--- /dev/null
+++ b/Documentation/translations/sp_SP/disclaimer-sp.rst
@@ -0,0 +1,6 @@
+:orphan:
+
+.. warning::
+   Si tiene alguna duda sobre la exactitud del contenido de esta
+   traducción, la única referencia válida es la documentación oficial en
+   inglés.
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
new file mode 100644
index 000000000000..2800041168f4
--- /dev/null
+++ b/Documentation/translations/sp_SP/index.rst
@@ -0,0 +1,72 @@
+.. _sp_linux_doc:
+
+=======================
+Traducción al español
+=======================
+
+.. raw:: latex
+
+	\kerneldocCJKoff
+
+:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_disclaimer:
+
+Advertencia
+===========
+
+El objetivo de esta traducción es facilitar la lectura y comprensión para
+aquellos que no entiendan inglés o duden de sus interpretaciones, o
+simplemente para aquellos que prefieran leer en el idioma español. Sin
+embargo, tenga en cuenta que la *única* documentación oficial es la que
+está en inglés: :ref:`linux_doc`
+
+La propagación simultanea de la traducción de una modificación en
+:ref:`linux_doc` es altamente improbable. Los maintainers y colaboradores
+de la traducción intentan mantener sus traducciones al día, en tanto les
+es posible. Por tanto, no existe ninguna garantía de que una traducción
+esté actualizada con las ultimas modificaciones. Si lo que lee en una
+traducción no se corresponde con lo que ve en el código fuente, informe
+al maintainer de la traducción y, si puede, consulte la documentación en
+inglés.
+
+Una traducción no es una * bifurcación * de la documentación oficial, por
+lo que los usuarios no encontrarán aquí ninguna información que no sea la
+versión oficial. Cualquier adición, supresión o modificación de los
+contenidos deberá ser realizada anteriormente en los documentos en inglés.
+Posteriormente, y cuando sea posible, dicho cambio debería aplicarse
+también a las traducciones. Los maintainers de las traducciones aceptan
+contribuciones que son puramente de interés relativo a la traducción (por
+ejemplo, nuevas traducciones, actualizaciones, correcciones).
+
+Las traducciones tratan de ser lo más precisas posible pero no es posible
+convertir directamente un idioma a otro. Cada idioma tiene su propia
+gramática, y una cultura tras ella, por lo tanto, la traducción de una
+oración al inglés se podría modificar para adaptarlo al español. Por esta
+razón, cuando lea esta traducción, puede encontrar algunas diferencias en
+la forma, pero todavía transmiten el mensaje original. A pesar de la gran
+difusión del inglés en el idioma hablado, cuando sea posible, expresiones
+en inglés serán reemplazadas por las palabras correspondientes en español.
+
+Si necesita ayuda para comunicarse con la comunidad de Linux pero no se
+siente cómodo escribiendo en inglés, puede pedir ayuda al maintainer para
+obtener una traducción.
+
+Muchos países hablan español, cada uno con su propia cultura, expresiones,
+y diferencias gramaticales en ocasiones significativas. Las traducciones de
+los maintainers pueden utilizar el español con el que dichos maintainers se
+sientan mas cómodos. En principio, estas pequeñas diferencias no deberían
+suponer una gran barrera para hablantes de distintas versiones del español,
+pero en caso de duda se puede consultar a los maintainers.
+
+La documentación del kernel de Linux
+====================================
+
+Este es el nivel superior de la documentación del kernel en idioma español.
+La traducción es incompleta, y podría encontrar advertencias que indiquen
+la falta de una traducción o de un grupo de traducciones.
+
+En términos más generales, la documentación, como el kernel mismo, están en
+constante desarrollo. Las mejoras en la documentación siempre son
+bienvenidas; de modo que, si desea ayudar, únase a la lista de correo de
+linux-doc en vger.kernel.org.
diff --git a/MAINTAINERS b/MAINTAINERS
index 944dc265b64d..b3133f013efb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19150,6 +19150,11 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
+SPANISH DOCUMENTATION
+M:	Carlos Bilbao <carlos.bilbao@amd.com>
+S:	Maintained
+F:	Documentation/translations/sp_SP/
+
 SPARC + UltraSPARC (sparc/sparc64)
 M:	"David S. Miller" <davem@davemloft.net>
 L:	sparclinux@vger.kernel.org
-- 
2.34.1

