Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA533645F16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiLGQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLGQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:36:27 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B1966CAA;
        Wed,  7 Dec 2022 08:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzeiNtdvVJosScZtHzV1Qv0e7P92oQuo0YFGZOtcIKR1dqs2LwLUZkL5DR1IPvjXAjoCAnJBktR0v1clO/TgkQvlNN1rF2TfA30i2neYTkTRIHWAi1zLsV9bd38cOJS+IwuLASW1dPsTUCAAPyK6pGyFQjSUaHVc9/TMcEbuvwREgwxfYLolf1bBKhV/YMSfcEZnsdjFMP2mAyE11C5zfXwHqP/DVpJ1ZgUv+stRjq6k4tKlPPz96QHmjEte0gSF23D6uLuBZwarzcq3EHKJSRVF2UfS63+K0qbNNWXqdj9qaNrCgHJgjyNSH9dbZ5I8KWaJjdAs9acdV9LT7h7t1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCTN//2hG1zBa2wpibGoGEQUCrdQJve9x/40Xz0z1Ow=;
 b=T0Awp7zFwtKJktOFNxrRmdsJ8sCEf+6GMgmI4ySMxsegdEdxwYob+cce6bRnKdlzTaBuNfJn1cmWdVJ1NKSvY+eUrMR0hzMzACzMM0RHPd3xntTF1klJhigKFNzkdg2CdznA5bKOg6XsVoqeeGLCeqvZTkT/j5jeaGn4ZKc4wV6JTI8bAe2iDW6HGGIYwitmspF4+KaUre04IS9UhMVxJT3/U2zrHjA3ZsI7DN4LBpECTTu877VuMWQUNQhJaFDVtEUhyiCAh33a2HZczaFA7hHOc+Ii8c3H83TlVhbdkRf60PNfJEfH1j0QL62jFY+YaR4xN3boccHS6irGtxoz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4278.apcprd06.prod.outlook.com (2603:1096:301:84::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 16:36:23 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:36:23 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: [RFC 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Thu,  8 Dec 2022 00:33:59 +0800
Message-Id: <20221207163359.26564-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207163359.26564-1-larry.lai@yunjingtech.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|PSAPR06MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac75888-299e-48af-5cd9-08dad8712d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVcM8M02mBYVJTcyvP0ZB91kn/cx2LAhlo1SJ5UbGi7sDEJYZXliNWrudGDcBbnoJeQa1YcBAo4Jd0T7gqsTK5hTX+nXbXYOK95/ANFtnyxN9e8xHCEAbBeA6rvOhyREBNHH5o3W1swTI0311ZQryeOOHVtHUgOKtokOnlKTAp0Nb/8gO1uZREhhg8Rl+8f18CyXhIUy+7laHmPAXiNz2ZonfopLwmkIgQvMRUbhQ1NZaoqGfZJC4ymsSvJz5figh7IYHLPhVFJdDuNfQZFhjE1Natl/q+tOU+S7sth5wwuYOFxDYm5/Av5kM1EMU2m9oWAfQr9McEWOR4mN0s5Qg17vKWr1O8wTLuXHgKARpWNIKt9J4dEJpJ+IljLoPJ1sX2GSHd+DiDnzoGnXeNsPtDyEqD7rkUdy9TPtkYbZOSEYO8HHFiv5Gxh+TifmAixjkpLFSxSSuRDdSdvGCK179VaRW1nWl/V2kUGLzcLphs7B+/awvryFILQd4oMoZ8tVSAvTvR9pyT8XtzRV+VKCNXiNNA0u7vhOOpS7b00EQYwjM7ZyAat11O+gAVklRjlyCOG1F8+HPi3Tzpio4+9E7BYxG1QJ7qhGLOX006P9JM9ghDWptn3s9jmYR+CGsktWr8+NjvLjeWSb7dfuC2w5Yedb3Iv3MmdICrl6YD2ZZnMFEtvy9euZsffUPGe+MyKt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(38350700002)(38100700002)(2906002)(6506007)(36756003)(2616005)(316002)(1076003)(86362001)(5660300002)(52116002)(6512007)(66556008)(26005)(186003)(83380400001)(8936002)(41300700001)(4326008)(478600001)(6486002)(8676002)(66946007)(66476007)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Ij3G0iE1E7RAI5sTiY2Pr34lGAoMw+5hDMsMWH3lEP+qfWHHgKEgjgCiFrX?=
 =?us-ascii?Q?RBGjfQVLw8wDglJSk0ssmFoMQGucSfYrdqBKQEsgHVbqAZ2N9i0uUmi9COEj?=
 =?us-ascii?Q?mcUFF7j85M1lJF4D63pLzwig3Hu+aB03fOhuw21AxPfiKgcvVjWdbOtHuHdg?=
 =?us-ascii?Q?LSw30RpS9IE6IpslYuZHHnYhwwQ37TO4VAtbXIm5vXatjPzTaP/GDCN4QItB?=
 =?us-ascii?Q?8rlokmB5rDjym1sLGiE8z59wN5GRxlI+xztRcyWhnmv1qqJdRWzgjK+gDrBB?=
 =?us-ascii?Q?glwMAzJkJunrdUUkp9rrJXnjMXmF4NMWIXU6tSH76aVSJCwoThBUUtt7ZFEM?=
 =?us-ascii?Q?drpdwgMDKr9DOwOPXybcqC7XyNjjGkbdMVH1+oGqXSRtbbS0auXzS7XGBz1c?=
 =?us-ascii?Q?Yo1Dj7GlqWwA5u463yvMq1Fz3aKA3PUxszLRxUkOFQQdkz+8aTDu77LtWVVq?=
 =?us-ascii?Q?+uYhoDDxiPHzGC+Nz6eAZn1EooFdl0MsZ21Ew+7FSh5OW2eSYpMRMRhQ6Yyw?=
 =?us-ascii?Q?brGewxAXTdQMD/e5xEti7yDAYkg+nG2YTRg+ktDf7WGwPgeWO9MBq3l49wl7?=
 =?us-ascii?Q?3uhKPFzSgkTQY6OMEopwkRbNzc6hhUQFrtPs3tyssMgftJB/L6jDu3gGJ2rO?=
 =?us-ascii?Q?4lRYmnK9Q+bhOWAEM60kpwZxMaovr0S9e7GJ9Bao0oUgIHnoGQW2BgVOOmRJ?=
 =?us-ascii?Q?S3abQBT4KASrfEmoUA/MIF+hGr7srJZY6ODbe2JxohByOMcjndnxT3KexqAo?=
 =?us-ascii?Q?eBa0P6OV00ysA8ib/QLLgj3SLIlWqalLoLbTooheiZfDTmFKGD/hwzdfP1M2?=
 =?us-ascii?Q?m86QyPaqoWE0Hut7ueVhmjLhagBmCCJ1LPHbjWWsLGtDRibTo8/a/lI4sX1P?=
 =?us-ascii?Q?2ot4NnOCkGGtQYUw/Bomen26JeKkExba4YjlaGa045dro1rU7kjQ04G3g27D?=
 =?us-ascii?Q?1syevncGRWFCX6dX2jggFYvdbBGf8TlDdpaeBytTex/0SZpPh6+6NwQzhKx4?=
 =?us-ascii?Q?pK/lvCDsfgxo6SYmHfenEepP+HedndCA7jJ/BtcRC5RGn3bIZn1NcMJUQzzb?=
 =?us-ascii?Q?irbhXXgCJkxKTQOVRf43QaZTMk9HU754vnjFW/c0Tal3an6OcqRAnLcniSL8?=
 =?us-ascii?Q?X5dMkj6NbfMAaznwuyK82aYlreqJZw6vZ8wUXHa03L/BXsu73l220TzIQwbJ?=
 =?us-ascii?Q?xHtwOGNNO/TaHO46q43PO96PMpxr69FJzvKDSUtFqBQw3ol5IvJa0cl4dyT/?=
 =?us-ascii?Q?S2/dV1gIcAixC0tdfYJSm3RZgduGXbxl+kh84hOuCCia7soB137vKCzQc74e?=
 =?us-ascii?Q?FSdgHjX8NIkWIFaZZRKL7X2vuL5SJUqFU8dibTlWCSBM+OW42AZDSstABEBX?=
 =?us-ascii?Q?FhIDenGgwWEI74w+5tmDF1geM/6E/Cz4n4zlFleyMUC2Uf14XgOYc5EWve5D?=
 =?us-ascii?Q?HIIB9xREsjJrB7dfGEIhuGH++KvMfJjQH6p6B1OAcdIxqJnELbmBMJIE39dL?=
 =?us-ascii?Q?wnN928EVsI8luu7h69gv2pOjanQZ4HtKSD5aOZ9FV8L1vrgC5amPOso+GUIJ?=
 =?us-ascii?Q?9FGzwdpNo/70oSXM6iBZucLocP4o9uy0whz7OyoVPeMdpfhyGLu1qk64K3js?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac75888-299e-48af-5cd9-08dad8712d26
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:36:22.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lss+xANaoQzOfq5uh51nLaghyLpvJyPrVydLjM5ExNIkvYLi1WGumxM03Ss9QO7xOLmM0sjr6uCWp5E30uDtET5bbGHy6KkNLoNXC5QsWSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V3 -> RFC 2022/11/23: Update the changes Copyright.
PATCH V1 -> V3: There is no change.
PATCH --> PATCH V1: Refer 2022/10/03 Andy Shevchenko review, cleaned up
coding style.
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
index 000000000000..7a597fdad43c
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board FPGA-based LED driver
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ * Copyright (c) 2022, YunJingTech Ltd.
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

