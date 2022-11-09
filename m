Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A062267A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKIJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiKIJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:12:47 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347620F53;
        Wed,  9 Nov 2022 01:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqQsQ0rsU/ptjIKX9vt7fwoiIkHmdcwvw8hMbQki352MIzgEkCdOZEFaRmmlV4PlGji0M8VTFMYyyuZD7uueAYARFe+lZvE8Gjng8yium/HTzzrdvQbQv/Su5tbBelhVxrFaDPlxH7vQlMjbsZmXIFnGKyrhEkj47vN2HTyFaB/26dhS2KrlF+Pj585wP0eOhEJtaxU/jPjOYFmeVAC2QdvdINdboW8wIHUv7kkQjTl4ebJm1ld4Lpp7vbWivvZwsYHQgk7XYZpkiIZrbIhTpQ9YbVLxEI8514UaL1/rdr8WOMjSFIcgJAgFsbT/G4eUaf+kbn0cI/qazkSOuYs0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyWUPELGnW7IyyQ7ftfKtcP49RXjNjxzGEZd1EAd704=;
 b=CS4TJzx/81gyIQoaiJm/D3iJ4z/x1cH+HlKlPs99vNHxLygVkV6VTzYwG1P32gMCukkew6CvpwgN8Hqst9mnyvX06B9nUFPS1pOZzoJigxCmCqj/3I8wMt9Tjo3tEpZ48dy79toepa6S8tdZDsFZKcG+O6CTsimlVLwK6SV9JbE1wGobMLrRIQhQDgzx2BENHFcbCTXFR9oa9krlWS3i0vZvSneHtUY85jS5ImC++oznlxWRCatuxmsmvaq1PXi9edzo1cwp/fnVD2FnVbivNoXZIvKUGkl4ftMiaGL1cykYDDJeYsffKbATP7dupgzE+zX1lThtt7qwPYOfUiA9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SI2PR06MB3881.apcprd06.prod.outlook.com (2603:1096:4:fc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 09:11:56 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 09:11:56 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH V3 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Wed,  9 Nov 2022 17:09:57 +0800
Message-Id: <20221109090957.13167-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109090957.13167-1-larry.lai@yunjingtech.com>
References: <20221109090957.13167-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SI2PR06MB3881:EE_
X-MS-Office365-Filtering-Correlation-Id: 437ced64-3051-41a1-9662-08dac232733a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cnz9VhZ5UPCTOUIBXeNiX/ObTZ2TrL2j7mnPMReuDXRWrBT8U+59X0r0G2eVqkSHGUEPVeYb4tc/y2UBooTfXwGkhz/47RVJqOaZS9rv4Jj00moq/WqUYIk/6yN8j64GlC1nj1nR0BFw3d6KXZzdJfdkktTjoHMGNAqSZ86wJh4llBD3rLRv1CZtf+zuq5hP9brB/uvW43OHPNq1FIUng3mzsyCKsJdpNIlnkj53u2TlnExd/UBPG7yEmUNRclykfLjkYhCAXPHRU4EMs8+hhgRjkjawdnnyoCZt5XEAi4w/YcYaL0qH+lf6lxyBwQGGfyqD9bSAtRczaXEXlx9YVF96g5sRAfBaSyQYOMk8E42poTrV2XUkF5dgKA9So2Qg9MzAYVUrdx7xWIZkPsnTvIaparrWNMuK476/rD9aVzNR1hdzxGzhCGd9hjwajrkj4XCQO7xNdzbLnlwedAwg8lNvMBzCTMA/Wz4q0aiw3xC5s3svUhsvZz74hpyqGNsSX1q2ClqCS+8sqfoY3TJvxQmNlnpUbU0BeMm2DQG3oKk7odehNYoK4I7kFNCkhnCwywhDSKlEKldWiOrOYcReQLY3WDgQxvarDmJYdnrZZGdJSjVcXj2yuMT8JjrXm9HxQOqWU3VZz8TKjXEaNszXPsym5PkUgtV2+qFov1BrtfPzsaTvjDOI79X9weM5j0kMTSPZsjWDsbEtm5VC9y8bAr9AIVDf/C26mYvKEBTN1B+oep1lhHkB+/I/mHoBvI9xVJJuwbeol8hjCPTzWDaWow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39830400003)(346002)(376002)(366004)(396003)(451199015)(4326008)(86362001)(26005)(41300700001)(107886003)(478600001)(38350700002)(2906002)(38100700002)(36756003)(6512007)(8936002)(2616005)(186003)(1076003)(8676002)(5660300002)(6486002)(66476007)(66556008)(316002)(66946007)(52116002)(6506007)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70tVKKIz4CqZQxt2CeTWq2zwmjrb7QnyoCvyl0AMjkBbXQ7ku5jq32wwrwbc?=
 =?us-ascii?Q?bYpZq/aqsnj5uokRa2M9qfHdGsUQeYkWvW6I8v0VT1DHGG8+YMvQabE7tUqq?=
 =?us-ascii?Q?RodAMrKjjbzXQjhakklvXE/Sl0GDpSjQ7mYaEovMkIlYoqJAHErFpOajduNT?=
 =?us-ascii?Q?UWQ0Lt3KW46XEgD8ptE3C1dEBKl8sItuGPImeVNHsHUBkrctoc8eUs0Fz1SW?=
 =?us-ascii?Q?MDtghGQ9Pg7baeGRBlQJ8UNlAoWtsYpXOSzZOE6j+WvBPVqqRyMnV7J7VU4t?=
 =?us-ascii?Q?67/QHLtS5T9aou19vpDFgceO48xd9G4lGyrjKEsewdJjUKxN99neUq7FwuMp?=
 =?us-ascii?Q?2ta2ep9v6DY3b08Il7KNMahWmOaxc486oRrcso3AcmJen8oZdFMi61+fIVF3?=
 =?us-ascii?Q?vYqeiNS72dfZDefTCqfLuYnA33+Wk1hJ27CynYiaGvjwROxbw1L40MMk2Gw9?=
 =?us-ascii?Q?eEpfFHhyFQMhXgabWT3Ff4Wj1ENo7kSss1KsXE2b2TM3zHds+hltV8BRRQmD?=
 =?us-ascii?Q?Tt5X1vIES/M8HGEGNC572h4PF4Qf2ZF5774qVDjSj5frgWTVx29wLFB+vJVI?=
 =?us-ascii?Q?kPENkP4zPqpQFKdu9MdK2Lo54tIw/OfnNhKWQJTWHgmgok66tcatKrRcroUb?=
 =?us-ascii?Q?QJt9BVFNnOM+ObfN8w4UGxSex2w/ND0EiZePWjHMPMBzNOnRBE/DRLqiIOkl?=
 =?us-ascii?Q?UkbQBpSZsJ7HwDCfOfARSVU9t/HN/Gv0w4IuaPwF2CGVvILM6j+es8MYliRv?=
 =?us-ascii?Q?AGjgYrIVb8+Kzno/JeRoi6TAedAGgp99NPtXlq8HaU02GRYbmvh1vPZ21+aD?=
 =?us-ascii?Q?d2VbGbfNssZT7HyQlCP5ggMjFfe2qmvvT+0JhDITH6y3MKWJt11UXNYcqipS?=
 =?us-ascii?Q?twNzqzedXoxj3UCK2Q15beqXWvKn2l2ZSRlvA2X9SjQBpdsh0iKTmT6nXFeT?=
 =?us-ascii?Q?IWlYpSqAruPQL+gjHfR8pqccM5byrKNXTlqcdq1k0zHdA1ET8uMaMbQHJyWA?=
 =?us-ascii?Q?dFITUu/7Pmqcoq2ahSt5Td94iOthf8ZDe2GUYr0RUOe6BdHQS0I1gjAneg3g?=
 =?us-ascii?Q?TzaKT+ACxjuEgrRoyUCSYF8L7HhnBliQMAkx0AfKzgn/rJ9HRiSQ9sa8YDbf?=
 =?us-ascii?Q?6LcwgE+g87aAQr2CtcNBJ6tSzMcvJ6n+PnFQTA1PzLPAFc9TLGJ2/dYr0N2M?=
 =?us-ascii?Q?ykpebhv7rFctvvuusH5D5AkBmwO8okOAbYzJZgdMATvaYL9HUNUUEY25E8IB?=
 =?us-ascii?Q?ctgPBX9rbTyKxRv54Axj88Qu/DPLtLr9+F+dt41/QSIMoZCEEhb8+f33Wbp/?=
 =?us-ascii?Q?fMJAdP9Zqncqc4Lg+5d+h52v+lrbgu/puYrr3+Ix1ZaUDcj3KVqWuRxiMFee?=
 =?us-ascii?Q?rpEQK8xE/A4XufHEgf6skUdRdlAmh5jQROTh6i+4sfT5kMEDtzksJwi80VDg?=
 =?us-ascii?Q?/JEE+TANRhUoiepDqvkX+7i6VhyMj3RCAsgW6tJ18UQO32PeSQ/5IQrr5oIC?=
 =?us-ascii?Q?WqqtKMF2aIiXFe3lV/1WK//g0IIE526TJzkmx/evfzVbxbOu0yrlGVKLn7f4?=
 =?us-ascii?Q?iT4iZ5hX9F4q7zOY2eJir8RgbthHkt4nXts9RGJHdRH7UwRFvXD/kxD1OFez?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437ced64-3051-41a1-9662-08dac232733a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:11:56.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBSbbjMu6Hq2ofmlTBCb4MxHnE/6oW1pZoHncqAMHWN/3RhaqIJkRKAF8UAQRg3i31Tv2GLMRfFqH3Hc5ddwV9U4A7S7mlSY7fZcsbxX5Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3881
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

this patch depends on patch "mfd: Add support for UP board CPLD/FPGA"

PATCH V3:
PATCH V2:
There is no change.

Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/leds/Kconfig        | 10 +++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..80b9c394c5b6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,16 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD_FPGA
+	help
+	  This option enables support for the UP board LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..e72956645646 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= leds-ti-lmu-common.o
 obj-$(CONFIG_LEDS_TLC591XX)		+= leds-tlc591xx.o
 obj-$(CONFIG_LEDS_TPS6105X)		+= leds-tps6105x.o
 obj-$(CONFIG_LEDS_TURRIS_OMNIA)		+= leds-turris-omnia.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 000000000000..214325442f3b
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board FPGA-based LED driver
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_led {
+	struct led_classdev cdev;
+	struct regmap_field *field;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+};
+
+static void upboard_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+
+	regmap_field_write(led->field, brightness != LED_OFF);
+};
+
+static int __init upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const up_fpga = dev_get_drvdata(pdev->dev.parent);
+	struct reg_field fldconf = {
+		.reg = UPFPGA_REG_FUNC_EN0,
+	};
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard_led *led;
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	fldconf.lsb = pdata->bit;
+	fldconf.msb = pdata->bit;
+	led->field = devm_regmap_field_alloc(&pdev->dev, up_fpga->regmap, fldconf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:",
+					pdata->colour);
+	if (!led->cdev.name)
+		return -ENOMEM;
+
+	return devm_led_classdev_register(&pdev->dev, &led->cdev);
+};
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-led");
-- 
2.17.1

