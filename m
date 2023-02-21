Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E9069E051
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjBUMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjBUMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:24:48 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B259EF;
        Tue, 21 Feb 2023 04:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtCBkdABdWIJf3ytLu66r0GyHH3sgWkv83GadxhY8zKtZOj4Vt4Not61TFFcWrtT9vTOFECPQKdOCU6fbWpf8IlsAgb+qS7tCnMo11uWuVAV653nFjUxYzSbKh0nKj0xtqRNHqVZkiBAEfe8YQ9pulWQackbyapNF1wl7XcUkkpuP5ZZzrlQyylObrtPeajCTfbNnV7LLCCBmEKLtJu+PQSMpEYCGdv4c3q2VY3xlVsBc2dq5IrbARKMMrSi1K3TKIOx45zNXfsH+W9O/lZ6eLMM/1CxcKtRcEVJP+xanBEfGCy2SiddoBhX9KCFQ0pWwk7Gqsy757T34cvOhjQNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+dt1VJ7+2xbwsvC5GLOTQP4z/FF9olVkbK+zo/2R/A=;
 b=AnzxzzAogpsF9p/5wiUbHIQKha/BqKnb6LHJKWwZuXc77Nxm9+/EwNgVwTdCJM5cdOHhROawl9KF9oY/sGgu22HWbLycHD8M06KX+ZBx+fSVznRN5cqny9sqcdEKEJT6+p1bpW7KGwV2XFPPONGnUefX1YEXtlrhvUrOsGBdHn1xRu/EDzwF9HNlHAXNNerARBsiubmMZC9Bdf/ubEpNJmjLBh3yHdm/a2Vswqgy7j1hv7OzCpJcfp4n3v/vNbX3sb0C45EVrmzZox/Uhkm0gd5soqIrZsCe2LqCG1dG/ZDtsAOovtZSvmYMOkDtyvLckuOX4OEpIefuBCRiAPFguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+dt1VJ7+2xbwsvC5GLOTQP4z/FF9olVkbK+zo/2R/A=;
 b=YBXsP7+uV56rhHZPWTGX52Zim8vraNGMe9aSoxwE9ZY2Oooph2daiVFQdrcvfB/fioTKNagiiqMEccwkKdOh9zU/Gqg8AaJ1zXvh5a/audtbKw794mWYPI0JpLQMZObm+JYM73Xu/BPabOIt+Oq++2gTHWthNvBG9JL2oHVMAk1jxPxlgeukipQgZggaXcR9541WJbUqYhqpfuxOGpk/AhS3Gd8WntjFSuJ2PFS6sTk7qFHnFSxq/EWpRQBt2B1KKczeUguaYWVL25IAHeZgSvddC4kb1DB+cZJneQ8tMf7v+kFX7RHeSn+SZgmIvxTPEsfh0GDXInHocUV4vO+z+A==
Received: from DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) by AS1PR10MB5368.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 12:24:42 +0000
Received: from DB5EUR01FT083.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::2f) by DUZPR01CA0048.outlook.office365.com
 (2603:10a6:10:469::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 12:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT083.mail.protection.outlook.com (10.152.5.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 12:24:41 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:41 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.68.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:40 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 3/3] leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
Date:   Tue, 21 Feb 2023 13:24:14 +0100
Message-ID: <20230221122414.24874-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221122414.24874-1-henning.schild@siemens.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.242]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT083:EE_|AS1PR10MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdfa51e-a10e-4e74-3a0e-08db14069ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ8SPRm5MFNCMZNIXZqPGnDjAQ6IfVFUAbR8dBHDs7NGtplIq10fVlDZrQaVH475HzewVWQvG9B40Mmk0SDl6bsvi6mrf3B6FCI1rIZhZa9mWVNAcjiUfP7KaS75E+tqSuronBBpuXTQtIxlpfle6ff7maeFF28iRyMkiYgtTVbfFRRKg/zli+O4XcK6XF6nESnfROb8lRoeGR1dzyuT9aBXGpx5m3q5qVtJeSKBUtCXQvwRtGfLo59PqLE42emyEPo5rwBD48KFRth+spxxYmqRrS3b+SMvgGZPQGFuxTlQ5CE+A793x7KZtpEbgGUm9IrfQEDKNoDfkhD8kEmCmAvmJ7nCDdzGmYZ2vugeLbrmYFyco0J3dBA1A2tHbjLxwoFgXDaMRqnURV73qDgtxl1+OTrdQouQW2kI5JJC8WO2ICb8PrnAjAkTnIA5o1+RuDzQ3s25AZzwrsTpMyFX0NBd01exWMJsEsHF1pmI3N9lmGbSK/NXJGKYdj9XvvDIPZgBh6bm+FFlqDohUMUfCQH2sBtCPQG1e/DX8Aptxooj0xD83XpvQBVS5e24pEJhUDDP94TuXzIoBf+ZT6qPDFp0jgmrLBxSyROqQW0QSEKI8Ybxffjafid6X5+FN9qIzDc4jgKa0js+BE62hTMREcmPcMwxJzsnnZRXLvBhaCsVooaNogwzoqDefrKcfYH9Tj66JcJwcMmd9UtxtGUHcByWOkK9GMy0DqvwbO2Vmjc=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(41300700001)(82310400005)(186003)(16526019)(26005)(316002)(110136005)(86362001)(40480700001)(6666004)(107886003)(478600001)(1076003)(40460700003)(356005)(36756003)(336012)(2616005)(956004)(70206006)(4326008)(70586007)(8676002)(47076005)(36860700001)(2906002)(82960400001)(82740400003)(81166007)(5660300002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:24:41.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdfa51e-a10e-4e74-3a0e-08db14069ba9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To describe the dependency chain better and allow for potential
fine-grained config tuning, introduce Kconfig switch for the individual
gpio based drivers.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
 drivers/leds/simple/Makefile |  6 +++---
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index fd2b8225d926..fc80a5d1d78b 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -1,11 +1,36 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
-	depends on LEDS_GPIO
 	depends on SIEMENS_SIMATIC_IPC
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
 
-	  To compile this driver as a module, choose M here: the modules
-	  will be called simatic-ipc-leds and simatic-ipc-leds-gpio.
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds.
+
+config LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
+	tristate "LED driver for Siemens Simatic IPCs based on Intel apollolake GPIO"
+	depends on LEDS_GPIO
+	depends on PINCTRL_BROXTON
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on apollolake GPIO i.e. IPC127E.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio-apollolake.
+
+config LEDS_SIEMENS_SIMATIC_IPC_F7188X
+	tristate "LED driver for Siemens Simatic IPCs based on Nuvoton GPIO"
+	depends on LEDS_GPIO
+	depends on GPIO_F7188X
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on Nuvoton GPIO i.e. IPC227G.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio-f7188x.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 21853956c1ea..1e78bc5904be 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-f7188x.o
-- 
2.39.2

