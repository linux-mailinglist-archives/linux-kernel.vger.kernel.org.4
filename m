Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806C67B91F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjAYSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjAYSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:17:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E55A36B;
        Wed, 25 Jan 2023 10:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcamg9MBF0sOVsH+KSojXTii6ml5+oupO4OZDW0WRhVUc1/NjzkxFdK2ltIwm+pFN5zZj51bKiEKQjFHrqhxsiGkNhOymAAp/RpIc49dDHSwJmVbJroxNSklBGCZd/vuJG0k5gZLdRUY99ZON5kCo1KN14cDRAdzMimsiaP+Ofp/x4oT5HMRRIALOL7haLuyzsXg7yWiIQ5Q++xWhIeLjdKqGs2CD52T0JEb//usJlaNCm5o3qzTn3vqDoiy2prs1l2TJ/jDv/ivnbnnVkGYYgpbNIHfH6XvaWg7lZA2zo4gNJoDiJJlbev+fzHe575b1SNPCjJynQf0GXan9oa+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE1ygT72lj7MFhojCO+B3dqSE7RsibOD9iDc7MdtRMo=;
 b=a6gfb0I/OJz8TfEIiHaQPEbGT5Dk0thShQLal47X+ut7g8ruBUsaZqxY+2VKVPMwwrzfegWlU/Bq/Yk4oYoLoFoc8bvE6D3OnIz1G2Zn8JyfG4Bio/h7ed2Xl2yGZsYyn1TDGpDnhzfJ0c1nNrjCqv8zu6+SkVeSEMjCnnxqV+g+bkdJhVCdkDObJKKbkF1XNf/kPz2NI5SbsJv/ibLu9wKN7cRJlAjsu0Y6+Ayz9Io+3Y2Q1L7k7v9TFZ2yN4QgnIRenZPOzT8GGOxQXPy8vgN/onF5YKslEA7cVbU77SzRiJxtalNloAOd+FH/JdaFrmV1MJ9+NBYqK0Fa0HZjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE1ygT72lj7MFhojCO+B3dqSE7RsibOD9iDc7MdtRMo=;
 b=mMjXjP15slCcvl6GGOleij8zcMvm78xZYQg09DJXVWVnUBo+I4Tut47JGsynxrRM8TABuoDHDyL72zBFP2UNcckJxxGCGD98s7LHIVDpmOnDKXySDv3HRi2JdDiEbFmbZt3mA3CxNcSsV4U1/NZrPzNKQwDruqNlzxkYG5uqFG7TuSZqMU9cpeXnqBTpAmFuJBgzPWEgMrSh4jLCbMPjOR7YRgsPcPYhNBR0axwbaZQWW5ENxYinX7XwfLvJt85zLvgeiz6W2h+9aagyL+thZNnNdSTpmpcv48GH2VU+CIzmx5i8CjXT9ZVwBAyc3Q2TXeBfM+cZWjUnM2QgjzcmFA==
Received: from DB8PR06CA0056.eurprd06.prod.outlook.com (2603:10a6:10:120::30)
 by AS2PR10MB7276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Wed, 25 Jan
 2023 18:17:25 +0000
Received: from DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::5d) by DB8PR06CA0056.outlook.office365.com
 (2603:10a6:10:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 18:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT069.mail.protection.outlook.com (10.152.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 18:17:24 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 25 Jan 2023 19:17:23 +0100
Received: from localhost.localdomain (139.22.45.22) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 25 Jan 2023 19:17:22 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] leds: simatic-ipc-leds-gpio: do not run into endless EPROBE_DEFER loop
Date:   Wed, 25 Jan 2023 19:17:11 +0100
Message-ID: <20230125181711.30844-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.22.45.22]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT069:EE_|AS2PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: b910d127-a5ce-4db0-4781-08daff006877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGPMWkl6zMZrYKloj2B5mOjS2jzG7BoLArM79PBRixJQZ0QXTt+kn+K2K1ak+s1Z74UBrxEnE9l2c+zbBZcJ4lDKb89OJR++J12guUr5hPTBZBcdk9cBWyIlO7QdRN9HoAq4TWWGTiA7hD2Qna+tTmwiVcMY/gj08zfvObTDaOAIKBy1ns/ZddikV25DsOxLCeVR90F9j/ZPJU74Dg+ihBP6ebycODU4KgKr88d7lX988F6vO35g6lUNBr/6ojWaviCPIZMMxt1r6Lz/u6gMOvEmjjZeq1noylCUPAk2w5x89UyN36Paj0tPfn+xaBXQCphyxYZfpEICDbX4EOf1cJPuZqKB4nSmHZVmWczkW0lFTJkOYpneV6cXEd5L/Hb7XGC5ZDLaEgbsHbetlh1LQwEVr6XyoojO37jJtDjbQ5wGhSbEGPPkyAGWy7Gj7xmQXSA8RdbiNjmyrG2+nKcoZAItSldHqm6uzyYVcceWyESxyg5X5MIecgZiuSUqmHXOpCJidsKvm5nR0vjmLa8qvulq2ZBRTRqb/ztEFmCDOOaQL2qUUXOWhgrTx+eEdv6lnNFRR8HrRxiQxwCOxDgk4pvMDkzjC9WQ9UtqNCV+gJj0uaeAAGkR4KVxCK3RNDiNrP1b5jHXodASpZzE8avhK+dnY/3pPHDlG4hzRqJe7L4J6lFx5HbVdKYmVbS9oSSEiZcF+334AsE8RHFHns7qXSKaMJNwDod0mvuE9+goyK4=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(1076003)(316002)(110136005)(8676002)(36756003)(6666004)(16526019)(70586007)(47076005)(70206006)(5660300002)(86362001)(41300700001)(82310400005)(36860700001)(4326008)(478600001)(8936002)(44832011)(956004)(40460700003)(2616005)(107886003)(83380400001)(82960400001)(82740400003)(81166007)(356005)(186003)(2906002)(26005)(40480700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:17:24.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b910d127-a5ce-4db0-4781-08daff006877
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should the driver providing our GPIOs not be available we used to return
-EPORBE_DEFER out of the probe function and cause a potentially endless
loop that also printed a lot to the kernel log.

...
leds-gpio leds-gpio: cannot find GPIO chip igpio-f7188x-2, deferring
leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (red:status-1)
...

The "leds-gpio" just ignores all entries and would never try again even
if the GPIOs show up later. But our extra two GPIOs could cause that
loop, in which we would even register/unregister "leds-gpio" and cause
all the printing.

If any of those two extra GPIOs is not there, return with -ENODEV
instead of -EPROBE_DEFER.

Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 29 +++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 07f0d79d604d..4e2595e684c6 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -74,14 +74,13 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
 	struct gpio_desc *gpiod;
 	int err;
+	int i;
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_127E:
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
 		break;
 	case SIMATIC_IPC_DEVICE_227G:
-		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
-			return -ENODEV;
 		request_module("gpio-f7188x");
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
 		break;
@@ -99,21 +98,19 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
+	for (i = 0; i < 2; i++) {
+		gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL,
+					ARRAY_SIZE(simatic_ipc_gpio_leds) + i, GPIOD_OUT_LOW);
+		if (IS_ERR(gpiod)) {
+			err = PTR_ERR(gpiod);
+			if (err == -EPROBE_DEFER) {
+				dev_err(&pdev->dev, "GPIO driver seems missing\n");
+				err = -ENODEV;
+			}
+			goto out;
+		}
+		gpiod_put(gpiod);
 	}
-	gpiod_put(gpiod);
 
 	return 0;
 out:
-- 
2.39.1

