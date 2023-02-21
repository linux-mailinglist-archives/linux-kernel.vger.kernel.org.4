Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7469E04B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjBUMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjBUMYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:24:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77B1EBCE;
        Tue, 21 Feb 2023 04:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoJEW0LQhoycO1uITy2jyQ+KTuJo4+wIERNKeioC98TtJgv6CP7Qpddw54KcTp33fBeWwcEDx2fKg+Pza6ymnYOdRImUpk35YMvbMDs6OCWkusXiyForfVb0Vnfm8wBYlmBLYWbLZ7aZcqEjzBZ4NzVyDXeXvdZ54WFKD7KrHG/iUPrW0wD4bLxdt9S8JjPKH/ensK11+oalLgLpElqqjUM7rerpgHoChOsLUKUPeRe/h0WgBcgKJVxXi9zhbhtShNvaZ5uXDbFKBBqA1VDRLGcgdBSv+LLJeDwcUU1CPJ4f1mclbzoxgJfeir3O5l4exowoK4AqqFMTcPc2+Zy32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b56LChrrOMNeXlSta0NH0223mU21fCBnYB3TCZTyDUo=;
 b=dloCINq2NE9LgbHrPUXmcrGzOiOAkLlzOlMfloqFfm9nfZnkqRL3r4gDkiGfyatusaVwJRofHKRyERvzxUMwq/XhpS9WrCkgqNYLp07u7qFaKc4oRQS2AfejUaqCHB3N8lZ1GL8diUUaHStI8Bp3CYwBAcYBfcW5XnuLbTBtNzuD3QDBLSyMWvZN2lplyyKaP78CfMNsPg/80dImka0Hd6gbg9J6WquyvLDgJ0wTTmS1CUeF/MM1h+Nv0ZwXe9yjE98qrJ3D+ks+Waf/zMODEoBRrOgzcdVe+k3nwZnUawaDUGemFgoz3c75Z6em2X87Z+hUz64IDzgBGxn/TlEzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b56LChrrOMNeXlSta0NH0223mU21fCBnYB3TCZTyDUo=;
 b=DLxti9DyqPDugIysiyKRlz2vbRoFAZt2/4XKobA9fX4UMeLATl1m8OdTlmJyomwSI0p3lRJ7H2Ajkj85rY4J3iRTUey8WSTl2EfaxjDjdZdAhL8dpLBOOuw9G7rwsCFcrmRIIH+epyk0bRhKHU9xklrJLJWoOSKVs7JoiqI9+C4iQ5cTLtaoRZkfd0dRn0AN2RvqMCO8SoZlRumTARKYeGjMA3r3WFkHAuZ12HtPLOr+HyFlxSz8uiBdJz+3aD9fiaDbmpR2rLHGj6sjwDxP9F5QteBTICCji6UEW640fgQ61dI/GbRA0HhGhyqkLx8q6nhXr21BoxqmSXnUSwlsbw==
Received: from FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a9::13)
 by AS8PR10MB7828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 12:24:30 +0000
Received: from VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a9:cafe::8) by FR0P281CA0092.outlook.office365.com
 (2603:10a6:d10:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17 via Frontend
 Transport; Tue, 21 Feb 2023 12:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT079.mail.protection.outlook.com (10.152.3.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 12:24:29 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.68.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio pins into another table
Date:   Tue, 21 Feb 2023 13:24:12 +0100
Message-ID: <20230221122414.24874-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221122414.24874-1-henning.schild@siemens.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.242]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT079:EE_|AS8PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2729ce-fdd9-4849-a928-08db140694b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ES12m61kIYshcOrVV+4Hp7y8XSAFFfiRtQ3ca4fwpXPEnVxDxMu177DFa/G5rgCKH3dMrIx3WCKegcb0mjBNnlLnxhBoElFZ594SQ2KMpPxo+k3p9QGCNktxm7dwJX8a2feTxbtrWtTqG2jtNKTQK6DC/hXjXh73q9BJY6H6flVU9r9vm7WWkmAiAIzLqSSRc0maKOpQugztwT6OBT01QCNXByixlOZyr4rpR8A+GafyFKILRIgrynYcVlSqVMuYnoJ5mY4coJZxbcQpbSEYLMVgCPeI1uFANyAAJtMoU9HpAPgom5l2Xf25x68ZnJ3vHcHNgHShE8PF0pcgQYgdkFixnbVZjI7MWF4LzEbO9EQclZAqaXehxLOak1Q+ZodMrBrYmO1eqsuDIfG6wewZTp349WPHbDFpmx51a+H6AuvceSlto0HNMqPDjOUrraGXkIvw5QEoQCeIS2g7EIN2CzeiBl8pPkjLluqq+8ch3lAfLFxPy4m5EFmX3BIW2DGrD3q3WbZPB1zct8WVyl1a471XInofwjQaK68r/rS58mslm42ibIhgolM12W9H7ySAQbLpc5bdA258rmuUckRSlY9M87hBdhK7LBf8OjUqk4F8pR/UWBB+pdD1J3lACzqgWODFiSVFFKxkP226L/a2h+k/Ah/FEyFqzSIs6aRsC/SjbXlbKqUPUkqGXSgEnMkJjEKb/cyflkI8EJUFKXU41VamarEVZJZimCAO+exqxn0=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(356005)(86362001)(44832011)(5660300002)(41300700001)(2906002)(36860700001)(82740400003)(82960400001)(83380400001)(81166007)(82310400005)(478600001)(70586007)(70206006)(8676002)(110136005)(8936002)(16526019)(40460700003)(26005)(186003)(40480700001)(336012)(2616005)(316002)(4326008)(1076003)(107886003)(6666004)(956004)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:24:29.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2729ce-fdd9-4849-a928-08db140694b3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two special pins needed to init the LEDs. We used to have them
at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
way is to have a dedicated table for the special pins.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 26 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index e8d329b5a68c..ba0f24638af5 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 
 static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
+static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
 
 static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
@@ -26,6 +27,12 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
+	.dev_id = NULL,
+	.table = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 	},
@@ -40,9 +47,15 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
+	.dev_id = NULL,
+	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
-	}
+	},
 };
 
 static const struct gpio_led simatic_ipc_gpio_leds[] = {
@@ -64,6 +77,7 @@ static struct platform_device *simatic_leds_pdev;
 static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 {
 	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
 	platform_device_unregister(simatic_leds_pdev);
 
 	return 0;
@@ -72,6 +86,7 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
 	struct gpio_desc *gpiod;
 	int err;
 
@@ -80,12 +95,14 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
 			return -ENODEV;
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
 		break;
 	case SIMATIC_IPC_DEVICE_227G:
 		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
 			return -ENODEV;
 		request_module("gpio-f7188x");
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
 		break;
 	default:
 		return -ENODEV;
@@ -101,8 +118,11 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
+
 	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
@@ -110,7 +130,7 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	gpiod_put(gpiod);
 
 	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
-- 
2.39.2

