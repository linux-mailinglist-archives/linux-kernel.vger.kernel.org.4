Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1580870F6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjEXMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjEXMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:47:10 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A216E42;
        Wed, 24 May 2023 05:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2UR3vGWsmlOYgEClIBg1BRLZg5PCCQXcVD59ql030D8LNGPUApMeOW8M7eP/0lcEF7rDkjCJ2ToSzsSI9Mft4fNYoM1A4K4dFdtREqiBqHJPvn91M8oLwmlnj/QAXU3zdYSNfYJHmf59gUsqR+oX2aTLsPH9Wz6Ne33pd859YEogoyGhUSpPkhTxf9SGZRmwIB5h40ILutwr5IA9DsHjQhvJnZoUsvLdn+zPBTRdlbuRQ4wU3GVwxtMvYmV53t0iBbdqEORHLG1xPFJEmHQ1Pa9WyDC1UCY3+2uIJcGBgffD81kuz1bw5COXkaqD8Ww44TILnNfgy8utzPglC8uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDIbHt+GIdNrdOWSe2pZSzaoc3EgQgnGfKLokJlxn5o=;
 b=Pvb4PuPl1qtwRszyeebjP1abjw8RVl6ZxOxHnVS00LClFCVwEUXDE9c15vuhuEY+GTYx3MKp4azINjr+tfoj97yvkrP38IKSh27M54X7MlOgWJ7jiaSGO5mvZWOpeiNGEvXednhbBexEVwkw0tvg7FKpPhkQfG43Npw11Ph+JFSx8o/QZb66WIL5u1N1Qks8PSmkcnn0aaMnsCccwqVc3UBFUkT6XPPq5nFkcBDuXYqNIyxYNQasxbNylP7Cs9lE2GMryPcq4a0tUnTGtlqD2QktkHVm3uyhGzxpTRhMtkpgFOY3HB1015Zj1vFPQxv+9KAjNt4Ir4BNlzqfYekcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDIbHt+GIdNrdOWSe2pZSzaoc3EgQgnGfKLokJlxn5o=;
 b=NkY/6L5hU8PaIzVUyB7/9sCTmfSwRr13zuxzBPeiY6o3TkzS9Tat87VY1z5+/y9aG4FRNLKI/cATsxGHABIrhlQQvtjcO1GECnJCPi38ZICQT5eQFKX4YpjfBh4I61qtSwkIfpUKNFIXp0Hho2o3Zv0o2UnGNsxp6qE914sD3aj2R0OqxWuZmq9XdYAaymivnM/NmA1GvSB9JUtabVDRO7mNxZMO03en+EaG1c1bXIFCTufQednnw1/D/Tmoz619ldXx6E6VquNfyA687bxShEPZnpOZBzw3MbM/+5EehQp/wiiFsulXQgu/GMfW6DJiI7+2dlrAGdfNC5AUIwcg6Q==
Received: from DB6PR0301CA0051.eurprd03.prod.outlook.com (2603:10a6:4:54::19)
 by DB3PR10MB6884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:46:56 +0000
Received: from DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:54:cafe::88) by DB6PR0301CA0051.outlook.office365.com
 (2603:10a6:4:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Wed, 24 May 2023 12:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT052.mail.protection.outlook.com (10.152.5.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 12:46:55 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:54 +0200
Received: from localhost.localdomain (139.22.37.129) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:54 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 4/4] leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
Date:   Wed, 24 May 2023 14:46:28 +0200
Message-ID: <20230524124628.32295-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230524124628.32295-1-henning.schild@siemens.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.22.37.129]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT052:EE_|DB3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d84974d-e11a-44a5-a0c9-08db5c54f4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52P0WMZL11Ws+CPPlMr0RgFx95a6czfa8NPX/1Yb8b4NnAozwhhgqJdIXGtgaYB4uQ0SQAmuTZw9v/iE5HzNydQ7XvreP2D2YYkEfSnLYzCSQRgmpespFRJ/1KIF229Uep0k4vXGNFIqaA9SYARAKilfGI+dykmvu2+i8Lq5vJoFkRyGkmk6QdnBDFqrXPz2nJ4xpCAUX8JS0FYGMyFBJ1xWtezMa++JRwRum4WngnHxUd8bKkijQKebbtrgADi4eugc2HHGM3jgsXVin/ihoxEauK8Ql1NGpo+8SXIYbWTkuQmhTajj+JuUn/dGv/slTmggiZhnbMwuGOwViPwEWk2pwRxtGwmzYYlM5SK004IMu5xcqkUlZYAXCgnEjBCW8c6w8OiHIF1/5cMZahkt3dJRbJB90PMYYa6I6rq5JM/Xa/fkF7Ws8sgLKf2hJc0B9lcxOtPmh/Xzmd/6gPxf3qCPVPoYvQ30sE4UwwN9CtEnb3E/AZbyjurMS2ZN7hxRBb+38vpQuFD+nRjP5uFY3bKkCDizy48QsdK9tvx9tks3UknfmJlq+4J/tBKkdJgAcKH3IZTXrvELR/25o8uRVfGFH8xXx75J0iZWiV7WUn61A6JoIJAtHxzIlWmGSH9tPAwABMD1QVoeZo+a07ZSsdlt3sFZzBqizSrnLXZJN2dlvnk1L2itdtBFCkPifEapF/MtlrYO8BURIPZXSVqkgJAC3XbckT+hzv4NDely/G8idIJbn+Xq/tUG9oNXUoFxTT/9H4dIL5UwntMhafXCKw==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(26005)(1076003)(16526019)(186003)(316002)(356005)(82960400001)(5660300002)(107886003)(41300700001)(44832011)(82740400003)(40480700001)(40460700003)(36756003)(82310400005)(86362001)(956004)(2616005)(36860700001)(478600001)(83380400001)(47076005)(110136005)(336012)(81166007)(2906002)(8936002)(8676002)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:46:55.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d84974d-e11a-44a5-a0c9-08db5c54f4e1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To describe the dependency chain better and allow for potential
fine-grained config tuning, introduce Kconfig switch for the individual
GPIO based drivers.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
 drivers/leds/simple/Makefile |  7 +++----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index fd2b8225d926..44fa0f93cb3b 100644
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
+	tristate "LED driver for Siemens Simatic IPCs based on Intel Apollo Lake GPIO"
+	depends on LEDS_GPIO
+	depends on PINCTRL_BROXTON
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on Apollo Lake GPIO i.e. IPC127E.
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
index ed9057f7b6da..e3e840cea275 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  += simatic-ipc-leds-gpio-core.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o
-- 
2.39.3

