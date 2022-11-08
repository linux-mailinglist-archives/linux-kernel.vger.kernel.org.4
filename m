Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335E6219A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiKHQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiKHQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:40:14 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D266F57B5B;
        Tue,  8 Nov 2022 08:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss5C3g9cDAHERxQyGB3Xmz4tyJm6w6X+vcf0FX7RUsc3rUnV/E+3YFk4n4wNjmN+sSwYursHWbsaxWo38q6zZQxsUs6tMM/eWnUQzFVWPJlcrZVkV25snCJx9XOZUEKH7GZ+jQPqEoFfHj6jxdiOWHiM4/mM5IpjcF5Smlnwuo6p9WwGOnjrwPc6xLYQrUzYU4zasnlzHm6HKLD52Ctw3GSq4bmhv3EVtceL8GxygFB8re9PmfVB8j3d7reE/RFuGUc0b73X8JsSf4q9FuWCVrcHaWR1krQAg5skgB9va8pZbzp/wkig+qlLrNe0xHLtpKXtaMzB09v3d0siHVks0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thpcfEjkT6M3Cbh0jMprMM++zM74T/WSw+KO6E7QZfI=;
 b=cArlejMg4uFprozlJyfi1fQ2fz/IFdwb31GbG3ckMygDLyA/+wqzAuzltTBRdEBm6V6H5+FXSpFxYUPo6Dbfn3gX4jLigv2dvY9DqweB7/VkE7hhyuafAspdwsO+iC+ukTQL/fXCNN74NWdIPoE99OAslYqp1yFYLHetdN7m0RB467CMaW4wg7qxhIjPKoDAj57/AwfhIjaO+hUExNc1yJT5hp9eTrehTCt0yDdehGi33Jbgmb1kEYnw85VzO3pUN6BSp5YyjviSuhZoBPrdtYxp7IVpvdZKqg56asYLDClRf3NVh7e2WTCGaX6s/JOItWTKuclQn/hhK72qWC54Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4454.apcprd06.prod.outlook.com (2603:1096:301:8a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 16:40:06 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 16:40:06 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH V2 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Wed,  9 Nov 2022 00:38:52 +0800
Message-Id: <20221108163852.15926-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108163852.15926-1-larry.lai@yunjingtech.com>
References: <20221108163852.15926-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|PSAPR06MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 15baacfb-5a4a-4fba-0642-08dac1a7e453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6BajtPAVjCMYqPp/nUVVFH6m+HJgY653mpyMKnj7njkBv6LHVH463IDE503wNM7omgXKMeCtNai+dqDmtp6mzKZvmadtMVejUqpzXBxqV7M9dhvIF3qoRIUJ1Ejw0ZJOJvcBlsVStST2KNxT78BQUhZpLsNSc/0lHF35wI5Ftp5vwc+YNgQPH0AaUIbje/yRvX+99YOqMI1tCBaBH0o/n4C3g0juCz1pXEZm2W6U2nlLT5K5Y9q7Dz53O3ZNuxf+zWGJO4+tNVvYFJpzGIf8Ds4QdwV0tECBxhj+pfC+h/pGaaPMa8opci1TVEK/3Gs+jN1HXZ6JabzFKmnhDUFTAuf1fDDboo9xRRXps1CPKNl2Bl5JvU6hH8EjL2J/OvQar5IuXj9+d7VEtBvvgxza/Bzs9QBEjRY77pU3yiC4oNiojABrmwrs9B2PtA+BAUhYuIRDz4n6P2owG6cJ3pcB7jwkpuL1V/VB5pUA13afbhd++keOjSa3TJhipw63ugOpFe2LKz9hRAovocgP0OzcqZFd0FjCjt2RolaAvoOWf54KxSlBfLtyi5KMQBG7ZTTd7+JXIuoEzzSPHDM05q5L4HQRMffQ0rdyy/msPk8i90w9By7fQq4wHKE9uR/HKkq7b+PDfyj7B5PFSCdnrvspuWpNtgUgnZItIsMaJ7VV7ClmcpS/Zg6X/rPBCcXtCSo2EqRpc8mGmblzo2ohdPcgulW4I/pnesg3BmifCSZZcMZ6M4vBWLLowa5L4xI34Anlyx9jrePSShZi/4aYA1NwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39830400003)(396003)(366004)(136003)(451199015)(8936002)(41300700001)(38350700002)(38100700002)(52116002)(6666004)(6506007)(4326008)(66946007)(2906002)(66556008)(66476007)(6512007)(26005)(316002)(5660300002)(86362001)(478600001)(107886003)(6486002)(186003)(36756003)(2616005)(8676002)(1076003)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBV74zgWRBvsNUnS5Y0ZHvgp7dhgEQcPINHms4bnh3LGNOUk6NbuLJ+o+Agr?=
 =?us-ascii?Q?8tJZuMtRFz2xDwTTkNo0s9zYxvntB1x+YihqovHtlT0A93pSSNEK+jywanxu?=
 =?us-ascii?Q?3pGsu1jEkFgrdT4gXUgTH62evn4F/mNHODbiqxfOYYTC52M51sDZx5cseMhI?=
 =?us-ascii?Q?cfOnhGqFtKRF6pZTP54bNF+gH1/G5omiWtuHZQC2T2cQYdoxF9nXU8ubxB0g?=
 =?us-ascii?Q?Va4pz+fCBFsPEBg57rFvxd9I43E1Qp0xZDoxAYvM/MfkcyQc52bYIEAZlcLc?=
 =?us-ascii?Q?TMGBM3VAN2jhJ9SLT9itKRxg99W74Tx0ih19EWZb0bymoINedmcLwf1TGRvk?=
 =?us-ascii?Q?SZUGHdZYVA0etnDOwBwDauK6nR56tb43Xrdn7Xf7TxPDYffy7h6vHzC2BTAm?=
 =?us-ascii?Q?lHPano0UAd00xn/7j9+0ir6pBDx4RjnPoI6qXwNJlT9Q1vhcFtXzl0lSA/6c?=
 =?us-ascii?Q?H2t4GnTLpP09cFyH8xWjiiEzjmtIEyGs+/zzk35zbqYQXlgIEK3PkDrLG+Ix?=
 =?us-ascii?Q?QVJpsXoZ8Azg2fKBKJmy3Ba4c77tk35GH5u+h01hKbgj1bl2fiwHk5l6vuNF?=
 =?us-ascii?Q?kT4MqQGkNDfqIQQzvTY76G5Rz/r5LoEFihSLT8hODhRbukxL8wn1RJ3Q0bkv?=
 =?us-ascii?Q?HahptxTqltbSGoHqPwZGaTHmyiExyvg4QNp7xtODmABotwcwM5ZwtJZe+ws0?=
 =?us-ascii?Q?C0RQDnU2j5slBa2BPOXPHurFKUmNS8ElGXrlItp6ZoECVV1LI5JvRqs1KwMf?=
 =?us-ascii?Q?eECBdGYlaXkj4O8DHVRKyXsfkDGJMOVu/MN8b1uizdMvJjukHL5KovbE4JkM?=
 =?us-ascii?Q?M1C/m0Awzqlhr6WMyJGtC/aM11s0f2N2j6SJMwRBMkDsTu931X8+iVexP4Eq?=
 =?us-ascii?Q?wiFJRd2besfdEqLaAtNZrHxZW4Gb9CrPZyYhoGJsZOxgtwggI4M5yf7Tdo/O?=
 =?us-ascii?Q?xwT+zVJeZbqP0OqdKAMMGTJvEVnbOnkJsc2fHYYlNYEQySYmewt52gBrzDIF?=
 =?us-ascii?Q?h6mh3ODg3+NVF9IxIWBZ0r33pNW9/y06biOIgMGM7hD2Jpf4UyKnOw5a/IRL?=
 =?us-ascii?Q?hzEFxyJv0LazUKwGil0h/W0XFsJm5Y7zfQv3Vy1A+A9tnFSEHo9S8taBPOVO?=
 =?us-ascii?Q?iKbuYS7/q1FOKVkwSc+tNcMEKQpR7a58hJqxgqvInqwm9+pF5IXyvZovHm6I?=
 =?us-ascii?Q?nknhbcundDKtGtnUVKGtSJbIB/bDJqygV1uQc+2oHtcba+YrYJN4D47EZTsQ?=
 =?us-ascii?Q?19XckVjBGxug8M7H9g4SrDeVCSiYw3C6PBq+h8jbxXlZ40xonOrI+WRwWC+Z?=
 =?us-ascii?Q?2QCdmqRVPT6yQUcM4PmkYiDbKZtV9pRCLfptWaIwRFZH1zVGSDCtnLNoA2KV?=
 =?us-ascii?Q?avevs6R09Z8lPXsGKn5XfZ6esS/umXOe/iFRi9QlpNunLV0PKVo5liayaSt6?=
 =?us-ascii?Q?XEYJ6HyT8Ww3IysYl0up41IOWTzcSQQOQrOJ7fvvCzWQYvnXRs/Vq8LK6PvB?=
 =?us-ascii?Q?XCpmtfwa5ZEArpNJt5dV9RjI0t9+6aqhhK8fg8zjhRwxuosjDExGNN6JXCGh?=
 =?us-ascii?Q?CiO4NfQHfhPXMJeZVT4ryH3MShMDnV2TVW3+7DevlC36Yu74ON36Z+jlfx6o?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15baacfb-5a4a-4fba-0642-08dac1a7e453
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:40:06.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIXBSawxESFiz4lvXHt2KGXEvHc9O0SwJYKn2Z2Eod70WjL69xuYPVjoSADwJAbSOjo4sWQhdbqIXT7kngmQ8fb10gyzzbvSP58H3zsgdU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4454
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

