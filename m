Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2446EE4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjDYP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjDYP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:26:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8ED332;
        Tue, 25 Apr 2023 08:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0PflHD5lLTIDfi2V8lQX4MNEvQCy0K7dax4dlClRxsVTBAUSlKLoeq2hx4H2Z6CNi+46pTBNjxxp7+st/JTZrD4inWS4vtG1/DTnIFraiv8FqR14JqqNHSbDNNDyMixrcKkLWxQGYxk0oRmYVr/pkhkxUire2st1eUjrkb9jr+k05hiKbmcXkQHmOF5ZsHuLhroAXQx/mMHT6xQ2IsLtbnQjYVWiEXoH24PTVwo/PCnOV81PLtrAWSxIzyEXX9An8u1EHljuEp4v7O3z46hTiw+TtnDt8xwBd0Hhr1b89JPiorTxNWqtdUX4hRLARtCAtylz4fjsYChRb8PPZiOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X6SCJAzchJZZ3ImRCQFVjQpz1weBsUW3nxdSh3o4qw=;
 b=LoUdgDD+f3loZK0USOHmLw1gsxdVkFtdBwYYmkoU24AXtRyVlpoPArsgzIC799r6H75J+kpljmQReRmzgEnxlRm0RJtB5QLXka7OMHfgsUH4oditZY/dnmWbMl3vZWd0z7r+XLI6EK5j8QHPdglETaOjKV/6hkQXo52uUq0InLBFp14f+kVzmcFUz74DH6x5vq2TWjpv30C0Nveeq2Pt84wajPvZNLfTOTD1YInk2a38rKwttfV+XgnYtBh4uVVnzWcZE4FPh1fkrJRD1Zg03IUL2pfiYtc+fhAs3PaXSfY4cbw3lcrXsqrpMZnmpYvK5MfITCXCBkFY5wrBEKGvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SG2PR06MB5154.apcprd06.prod.outlook.com (2603:1096:4:1cd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.29; Tue, 25 Apr 2023 15:26:19 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 15:26:19 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [RFC RESEND 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Tue, 25 Apr 2023 23:21:35 +0800
Message-Id: <20230425152135.30745-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425152135.30745-1-larry.lai@yunjingtech.com>
References: <20230425152135.30745-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0342.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::8) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SG2PR06MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 700d6646-3a16-40c2-1d1d-08db45a16b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U0kaRyRiqvXkK9iXcOuF8T4+iCweVZ+zBRFvk70MVCq5I2q8Sv8jo2k64sgi8QYihFI6YfcSdL2naYiywfgll4aRtLa0TOLXI7bFKeSwipf18wImtVe0dwflfpm9IJxrgyjCGVl0uAEvXud9QW29HpWc0Ex7GnwDYtsPgo4ch7YGTTWRKsUZWVtLkF73BPaaGaCKp9dEbB3ZEtq4iWBxeFjBz1WOGj6+CJ8+1eynaCke5e7SBbBwNdSHstoiepJZWamqIARVJtVBth7ur8z0MFVpbYNt2Ubg89QUDbxwOhUCkH4tqpjN8IX49vt5oNmodLt5HZcfksGdQJcYdfKqkbbjdtSMlnzlKP+EmJfDzIAt0ZsnPvzTZU4UiuFuU/FfJLQtLFvVK623Ls8Y+JTfGHeZ1P6+oSUa92+MkXVPC2U3SpjjP2cOK/ObyvNORWceMM9EFfeNYmSvkJFn2ffcPraUyrUH8LC+1IyfyeWsVfhl7a+K7RNskCVqj5i3kXjpR8Esxc6aV/7VOgr+YrUgXXMEOcMIVGt0ceKs/l3jbZblyw0c/ZCKF6H87/x6F39odfbYRj8R5jUghANikqAhguK2TlJfPrEYiqrzHW/ZTYxs31FrIJyhsnAP4Fvlj0k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39830400003)(396003)(451199021)(2616005)(83380400001)(2906002)(5660300002)(38350700002)(8676002)(186003)(1076003)(26005)(6506007)(6512007)(8936002)(38100700002)(107886003)(41300700001)(66946007)(86362001)(6486002)(36756003)(52116002)(6666004)(478600001)(4326008)(66556008)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+m9Z0KjLsO0Q0eZZc+nHvdtRRp2ugdPzf6w1qppEHEKIoiVlXOqntkh1fZ/?=
 =?us-ascii?Q?AzK9nYDz/b9vDfIt6RPI+nZ3ccX4rH3rJ2ZCrcVNf32cZjAT5f6lqKm13VOz?=
 =?us-ascii?Q?ekN+WonBVybAIPl4PlXvlbm/jhKVxlNRHK7wKKRjqln/Z3MkmdpzrTxtnKxr?=
 =?us-ascii?Q?fsVPkVyVr+Kikx3BWi5W2DjsYMWIN8O0Vao2PJZBXK9V2XSmFLXdVVyuk42Z?=
 =?us-ascii?Q?gI8cgbAs2li7rtmp4YIBjdNXmrchGkLNmjGv1daSovhh5E+/2HMiJbK7D5B0?=
 =?us-ascii?Q?GbSxVRNjtJ5kPmt1dgN1LMKQAarimHlyOxtofrDCTNMchYOVjrf7qRuEUjAH?=
 =?us-ascii?Q?AKfadrj8mOy2AGU6JM4/XGPswsBhbo7N6OOw6KK516+1kIY//maC5VgZlQA0?=
 =?us-ascii?Q?231gcUanEH8OIGI4eUxf8htheGycrN6dGni0Wfd+kIypCIpTJ/ixVSm8KRGA?=
 =?us-ascii?Q?XGKHdRfixrrFCsCELGAFoCSKEgfc1CmVmHqiFUDMLkcVW5Ewdle/HcxT3nM5?=
 =?us-ascii?Q?8WLBC9OrRLH+57UjGyidmKDoCm3JdZHwLvUW1Y0piFsHGljC67ogwamKsID/?=
 =?us-ascii?Q?gdr1WYThpumtAul4X8ZAGlqMGmvJYkC6LSI7XhsvmWv4nW1o1a0wMyR9TorE?=
 =?us-ascii?Q?Rb+/cucQK8EPxrb3JS8AKDtpZwn4TSOLWF6XF4ypOV80LJPpIwKApraP0CYv?=
 =?us-ascii?Q?ORgId+woH+eCQC3e2sGhhOe6PXXLAASNBZbtpsKXl8HFp0wQx0N2lVs9AGtw?=
 =?us-ascii?Q?25a1aNDvTM+l59sh3QGe+W3IhvJxXNv4BwRJYaTNsNxq4IU3JOlEUy2fGYUg?=
 =?us-ascii?Q?YXqUJSWjT8nw9zesXYvRzLxjJlSW6iDcX+sGSGKofJ7ApNE5Z1oxbEzcivoI?=
 =?us-ascii?Q?+K8QBMMieCCARNQHK68l5/n/GarAwt0QT27tFOo4X8aQOrxQRVM/n6/B/jHl?=
 =?us-ascii?Q?YRSTx5/P0m/93jA18+AHhtoKt24FVb0Svs8PPD+9WR6v56v8k8Xa19Ms1VrP?=
 =?us-ascii?Q?VXnjMAX6iTR4VlDEUNPKh5BtoXohbbm96IuK9+hepTXBSClcipC4o2a/ptpb?=
 =?us-ascii?Q?3D63M492iHbNZq6Wz4lbiIBfsWqeiKHYrXjGIWgMOBgmDi7J87/poqgGV8ha?=
 =?us-ascii?Q?lJL7jfuSdA7aYYjewtZYjAVCQG7kc+4ppq11dud5C6ye+y7zGC+chZFLqA0K?=
 =?us-ascii?Q?rcW9MQ+x/BxAp5Eb2C/8VMRpOf2lKMG8lVJvQ/pKYpEL486a7vatjSqX1JBD?=
 =?us-ascii?Q?cxgTQYBukz3K1gcbUoOvkm1+4GLpPYYCtmyFPNUZ0g7QVvL0SgTCULnFdNqB?=
 =?us-ascii?Q?c16ADCgfM1SeHFh3DZdzFk3zqF/Ttt+T0gd9GM6+u20B8bKN8QEL3DFEyyJq?=
 =?us-ascii?Q?/aI2q1g+BLFkiewDAy5G/U+enZjpDcEcFfzEPoMEeWGDduchRkqd6qSPTkS9?=
 =?us-ascii?Q?WbryOCrUMVP4tM5d36PZRsz0jDSIeZdVeaDynMSp4mPGlV6oWnQdGNUiMGwW?=
 =?us-ascii?Q?JFRoESsdv4QAgw5+LXmo+z8PNwiTqpEEr2G6c1H9JsFUqps6dpGYJ6LU15YI?=
 =?us-ascii?Q?PVOYM7jJ3H3ukjpT8Ay4ZlV1RUGnUXmo2TwkwX7JVydaN5JaEfLPHTFXCmi3?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700d6646-3a16-40c2-1d1d-08db45a16b36
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:26:19.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyX28QvxavooD1JEx/t+Wk7ERNa2f9yZONf79uOuoOo559S9aL6Az0Kqh3e3dSIfhcX84aRqN9vysasgI2nX6s1RzIsn3RDTjF0Y+08XPT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

This patch depends on patch "mfd: Add support for UP board CPLD/FPGA".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
RFC 2022/11/23 --> RFC 2023/04/25: Refer 2022/12/08 Lee Jones review,
cleaned up coding style.
PATCH V3 -> RFC 2022/11/23: Update the changes Copyright.
PATCH V1 -> V3: There is no change.
PATCH --> PATCH V1: Refer 2022/10/03 Andy Shevchenko review, cleaned up
coding style.
---
---
 drivers/leds/Kconfig        | 10 +++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..d9d533cb38ca 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,16 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_INTEL_UPBOARD_FPGA
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
index 000000000000..8a44afe8c526
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board CPLD/FPGA based LED driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
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
+	struct regmap_field *field;
+	struct led_classdev cdev;
+	unsigned char bit;
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
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-led");
-- 
2.17.1

