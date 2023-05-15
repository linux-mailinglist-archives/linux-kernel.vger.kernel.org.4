Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475C57030EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbjEOPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241960AbjEOPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:04:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8403A92;
        Mon, 15 May 2023 08:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6vWE+XEWpDLbVB29QSHsEu7U8OK0MVrSJCAjlrxGXsKHN7MfMSC0p1azpF109Tjw8fqwCrQ6Q60RRBejSRQoDsevN3HrvF4oaOtSKm4xPY42Ra1iK2Jbl7GyKgqONh41JzuQmzYdpYw+DPrYi+P2IvwrOf3C26JgmMV4gfs4i5kqXhqygT0WK0/RaGO3nEIgAHKk/6VQuqZgcuuJRMUJzE92TDhWfeint/rwcLLZd/66ErowpeW/YIsgObBTOqo3okMmn1nhMGgXzpjBDgKzw57JfZn5h/IKYAaGapLEj/ixynH1m0zxL9oPN8tSfnGMnUvFVk0gapvDf5D9AOK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeWiY6zxYEIXvztagTypa0zBF5OaPGxukcx50PzVH0E=;
 b=SmcSMDPtnBDUsvHwxGAsaOomlh67CVapT3O3LrdJHcH8GnUbZ0I4miD30wgXBA0x+3jrdYHDgyBN0mu6RCrg3KYwIWl6WQh+funvGdZoUUJfrMkYp00cxWIZrTfXqYoazxhnYaoEBf37J7pVaDS/CVQ0CewvH04HgUQlfCxzhXGYFM6ATVYVqOrg1BZbQu8hL4mET42FH2kKpGBTtCrsaohKaJhuHO/kfDNVax78g+koaojuF5ew+ajy/N38VmND1hmHgYFzrEVeN4PrNCFbmFRzEkXP88wpMKwLDR0wY7/DS70yr9FJNTRiaza1fgXHckDf1o+PJEudXhekQdk7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeWiY6zxYEIXvztagTypa0zBF5OaPGxukcx50PzVH0E=;
 b=MRcPLcKoM6xqNzoqCCmpZ0+sKl9DbEo8w1Wd2cENSuYskP8vRFp7xFJ6jdoZuffYvJFcw5zSS1JflbcAEXn8Lfj2WrOr/9Uu8HFTRX/iffxcBVyi/JruPY52p3bA25QH5aW8qO/YX0w/+BjxMTWyVJzATWjIM3lOT2Enwjye7hfY7Qb/WYn8BTvCzS5FozKRUmAoGVPmA77WnlW4irqeHDtEtNbTAN91yH9Y12uY9/W7ICS0H+Iyze4YLe93uveYBK5n7lkB93jbNfyh91X6P3MBVlyRjZw4d7R+tW8pJeFRYpZNL0MxndzNzZWyacEFtemRRyjEyJh0ZOG6IgKwrQ==
Received: from DB6P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::26) by
 DU2PR10MB7741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 15:04:13 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::53) by DB6P193CA0016.outlook.office365.com
 (2603:10a6:6:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 15:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.32 via Frontend Transport; Mon, 15 May 2023 15:04:12 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:12 +0200
Received: from localhost.localdomain (167.87.0.30) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:11 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio pins into another table
Date:   Mon, 15 May 2023 17:03:50 +0200
Message-ID: <20230515150352.30925-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230515150352.30925-1-henning.schild@siemens.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.0.30]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT060:EE_|DU2PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6992d6-34a6-4d9c-2b7d-08db5555a4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xezeKOVQ3s23EC+uOzx3C6MWSVsH+EIvJzqGzklg0zMqrFdI6QV60da061ErXcHN/3ln/b4mDsobdUnZDID35WBHFOYtNRAuMnhDz9OHEigJJ1fl91NXFqicxzfTGwlMRnqXCIoU6pOyZn/zWmbFyEBVitJtcEQJ32a1yhrnQqibwYpraJOJmbnu3AveZAc8HVFtoWhwwJKFogmWqdnk4s3kxR5YHljGKwQ1AQhMSIyU2etUe0ulyjRuswe5jsOqqKtXiq3fMDna7nvgdBlAToVdf/e+NKFMt8GUGnWqk5jdrOVMg957dtvTky8A4QaAr3FbgFtuB31KePGGTdKowGtT4DiPW8pJfd1YVqP22wXJBcXMqqiYlSDONrB1JQyAFsPV3IdUA0gWfe3EUYwAUClcl5pyZ+gf7Zk6JxA4xWNf1lcC1R5cRzmC7AJVnw0wm+lgyWOmrFGAug7WzoIeBz8qZ66fPKkes7ZQLBVRP3ndppzYXBBvVPIHnD58nLgVC1dCnyObnT1boOwbHn3yKR/9Z9Ft9Q+3WJQhUW9mzkbpowh1kmMIDXo6xVozoqiWGEvazsw4MJ4byU5RMmKuh6/3/ruVJOCQhUuOmXBdl47ef3+BH9vvUZpkMpKIbhjpDP4ZHrovieSwKUE9nrqcNI2okXHM2aC8JPsWgTr+e7QnCEqV29IJEUT+O5NjasWKn98TPyCIf/g5sE7kidmyikB7JsQ38eXDLlVfiG0LkeKQAOzrnBwX+DnG1FpX35hyjUNE5zjQpJjRp8S1YGcQ5g==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(186003)(16526019)(956004)(2616005)(47076005)(107886003)(8936002)(8676002)(2906002)(82740400003)(82960400001)(40480700001)(40460700003)(83380400001)(336012)(36860700001)(70206006)(70586007)(4326008)(316002)(6666004)(110136005)(478600001)(41300700001)(81166007)(5660300002)(36756003)(44832011)(356005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:12.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6992d6-34a6-4d9c-2b7d-08db5555a4dc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index e8d329b5a68c..87efdfbb3fcd 100644
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
+	.dev_id = NULL, /* Filled during initialization */
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
+	.dev_id = NULL, /* Filled during initialization */
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
2.39.3

