Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686656FEF34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjEKJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbjEKJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:50:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265CBD053;
        Thu, 11 May 2023 02:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6WSbKIotLBCLEjXkMZoIzkC4I8ZruwztJkpi+5gi1FahKTPnRhrj5s5JkUkJkJtZ7rSWBEH7f7ZmkAE5yirJ8xRIaRaLobCIOAQQHV4xNlq6qih71l3B5Sikbzobrdm/6rC0rKo0qFqd+HmbJ0gmGEUADDNgOVvX7yVQeegM9DrWj9EIb/0ztgfniUbxOxpCvYbFAnEr3n5W0e5qenOsV5Mu0Z7BmKROFgyyVaFxgpgGZmsfnY8n8sSz5n/eFV52eean8vbpCCigZXnJFAMJTswDuGp5y2XWpK0GEhzfnWpGqq1QHReh8QQVYGaHBv2cX2pw7kPRnPXHdChmpYLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAaEsUkcgx8Wcf2GTsXriQrMUVHgGX9FzXgHjx9zGvs=;
 b=G+cRSBnJvbtUuq45ZSqvwILeU6/E+GoQhabiGmHTk0lgALQKZtBRd3BFNuaroHHyfRclTJNJzQ4ngIirqUarGyzBgyl2hah3NQ33b2ezB7dyWHKrf0tIEihQjpX8uZdUcpS2vPH/ay35hu/qpPjM6HdvLcnj4NyALUaI1CaMG2nYGW7NjPhaALFxKKwFh9Ij32P9lOTZFOTLYiJcxk0VD5w+ThVDEM//04GUVrNjiJL019oHGj67j6bMDK6scJ/GhGMhmPGj+ppYQaXkRcBvG3vm0LXtuVKESiLQunQHFQLpON4tBPaVq3XZ4ZMHoa8jXm9YbQbd+wdifelKZD4TZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 KL1PR0601MB3876.apcprd06.prod.outlook.com (2603:1096:820:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Thu, 11 May
 2023 09:50:04 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 09:50:04 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V4 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Thu, 11 May 2023 17:49:34 +0800
Message-Id: <20230511094934.4941-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511094934.4941-1-larry.lai@yunjingtech.com>
References: <20230511094934.4941-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|KL1PR0601MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: 855aca9f-1486-45a4-6fa6-08db52051881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iL+nyOAel+74gtVmUd7t1R/4W0VcojnkDFxLQfCs4d45lb9xFD5wPiZy9Kn7dHMMwrFXcKv15US8Q+J9bIN7iQcnjU33jpDHopgj6+aBRbSYuLOW30Lc0WIOMKyKAIGHQOB1FBLX7J060XiHL8JFukqPG8vjF5Ggx1dmgF06jc9l5XBogjRv0aSAM0P4J35cyPWDPbi4bzRUUjIpEab5rTffTYGRVU5zfwi2k2NF6i0dI3Ya+BTKllYljqhSPBeEq6UFDCcrXiTBht8JLtuR9VYI3YYFTpWRi8tJpQXXOXFnixTM7Mp55lKHmNN0TEoRm+h3KpoBNjZnArf5E9kJL878TZ9CVG9wUUuIztXaMHiMlxlXZBG7ROT9IBGg8PrO1F9Kf0sWe8RrsLttj423A59RbSadVY/5KOOjJArjfdOCtd15nRcxPIfKE3WCFC6/5c4lnwokDFpEgyWCRkhpg9O2p6zixlqqaKxoZaMRvXSM9ljzlbs4J6TxHtjYHNbeFfNshMksuRbOLojmPbxxFVgwmSXe3hTTGuVrzp+1g/pCdg6lXfaFPAS1q0RZNryggaqqSmnfmccHeuNhkVZpOOMdQT1/xlhT4lShCke+8ggqSQrNJYPZxwuVOOQKZJzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39830400003)(136003)(451199021)(8676002)(2616005)(2906002)(316002)(38100700002)(38350700002)(66946007)(41300700001)(86362001)(8936002)(66476007)(4326008)(66556008)(5660300002)(186003)(478600001)(36756003)(6486002)(52116002)(6512007)(6666004)(1076003)(6506007)(26005)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sulfzd2rFTQ+R+8haUPecv/LrKk6VXavO46xuSTk12YEb60vicMiWeOF/rUh?=
 =?us-ascii?Q?x6HukQGmw8OddgUvi7PapSdzUSQFvjs6kk+hUkLwVeZQmZhUiiTAdHv/G4Jw?=
 =?us-ascii?Q?kn3gS0+SIzfduIF+LdDuralY3HZ/UmvndeRGeOJ0UmGIB5Y5uuE8HCxSnlIz?=
 =?us-ascii?Q?P/Yl0ja7iiDJU4D6i/B/M9E0tSTVyQSJ5MUVezRs1TIpro4hOUV0buA8XABv?=
 =?us-ascii?Q?hJA/B0sSHOPJ2NHGTTX5OKI3W3X7nRs/gx5fZ8vHjZfuF4ZDXqDQVYybrMn/?=
 =?us-ascii?Q?fqBs56qkpAzaBNyymrEWnDWoK4gn/V42OTu7uZlDyDPImqND/9+0burNjj58?=
 =?us-ascii?Q?LRhW41OX1J4UOBep9k3t4nqLiOdQz4DLGMxdr5QhhPo50GUGkDBkDXGuPZ3w?=
 =?us-ascii?Q?57d19dQrUW89v/LKnppv6JgvxVS/H7COHJmzpkDTu++WD795Pc1euiyrvlik?=
 =?us-ascii?Q?874fP7du5Cgl3JlwDVKS7Qg+MZGbMtPf9itSrTrLS1YXBkTu7QKCECfUt62N?=
 =?us-ascii?Q?pY69UbLPcFVpZtnPbZ7Wbyt2/hFRweF00+lDClb/mLtb9gvyBfkuBIlPgs4+?=
 =?us-ascii?Q?q0NNRE+uWHL/EMOuAP+i6svReb8z6Z34Bv5i2c4U1Uq8DKnkUFMFXfPsNvEC?=
 =?us-ascii?Q?4ae2QeZCFy0nWfyRh0XLPmhR05DDPGusqd2npwfBRsQr5sKxD3RqEGd30eTK?=
 =?us-ascii?Q?vWoNQAXeItie+MJWFRQJleBFzju2qnrDG8ZiQ4pDZgf0C0SPXh/JeUxnYKET?=
 =?us-ascii?Q?aFJMXKle+tnrFgQSYm0rgciSvXsvUWIlEoHu2ltj6fLyFMOzjjZw+x9/zval?=
 =?us-ascii?Q?bCt3+1xdljIoJeso3Gvbv00uA+visz+CCzfjQh65R0nViZ1Lq1XeByB2ZOyJ?=
 =?us-ascii?Q?3JhwPcbTrZ2RxXL09a8L6oiKJYcyByy9hYH58knGlXMbw5oAZnGp/RtycUzY?=
 =?us-ascii?Q?CuB5HVegq8tEPxo7QORwaS1o4OLyTOAdodvWPsO5PkmC3tCvA1I03WDeSjIw?=
 =?us-ascii?Q?plPyOfh58+B2NINobYrWfsrGZt5IP0dhQak3JSGPm6aSYkFBK9UqyugbCwQo?=
 =?us-ascii?Q?sCR6CugmbVpf1QizwWiQyU2qNoLkokI0oU5KG1O4dyJ4pqfIlLkvUXxeF85w?=
 =?us-ascii?Q?qp2lTt06xCHSrXkH1lwPsL2hMA5gHuMeUyPdcxbUkBDREBrqO01nyQNGqQvN?=
 =?us-ascii?Q?8qv5TjBo/+a2oAKoU0u1kCwktySEUYDqDtCmnxYh+RZ2Qmv6BVgoIh3fUA39?=
 =?us-ascii?Q?R/dTIKek4NCN9N3u39AJC94i6jtHkkV3n4/SETcs3PrumJs6CucFN+9xycGz?=
 =?us-ascii?Q?pCUHS41/s8mjnjNPMWN/CD9AK/jr1yIcVAK9zJ/jbVcgzpdas1PrPFLt3IO2?=
 =?us-ascii?Q?pHoeQSRGt6ccmI8FzVldx8OPh3rwqnjtG262w9ioz4BUt9VpUQ/U6xxrXpg1?=
 =?us-ascii?Q?SILKiIrT5ltRiOh81wwnt1q7GwCpevjliNwlWbRpH2AJk6SwZ6coq1umBp5M?=
 =?us-ascii?Q?/VRj/AuvDWb5dEOWzQ8P6ZYCU0RMdO2PzDj6aZ2sNKsw6EAHoPtNQrPY/6IM?=
 =?us-ascii?Q?6HoMCwXCzgMiqpTSsLn3ZnjTjtijfEQXvP4LUrYTU7f3rfiUUTVZl0kCtq31?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855aca9f-1486-45a4-6fa6-08db52051881
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:50:04.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUSC7rSh0m6O3APA0NPwL3nUmyFaJpNPPTrHOALs4o18tsMmqHgHqBuTGxRvspiSTm9kbajki51bsmfINOEzhBX4hIUK+AGEUI23Hno2Cl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3876
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

This patch depends on patch "mfd: Add support for UP board CPLD/FPGA".

Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 --> RFC 2023/04/25: Refer 2022/12/08 Lee Jones review,
cleaned up coding style.
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

