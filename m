Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CD6EE4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjDYP0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjDYP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:26:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F314474;
        Tue, 25 Apr 2023 08:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBh1kuvnsJEKKscqJkUCDAf1OO226zD0zM9juyMgckjE6GGQ+XYypQwP58CKYGVNEn1mkGbsI/6AtgkCd1H35T+n7NcXUuOyYbdhJouMeLMlnDo+VMtj/svqS86DVfEb/qa+3P0smnCUrpXs2CZpJiaevDYfgWGpnXVgjLOsHncI2Pi/UVqNfSi7KvnbBFoN+PkrimMaRwjVqJLa5esdn+a70IU4lqBc84YhXvRZn+DaNDW5qFU10o6yAnK6M8rdPtXhFGVN1fikK3oUGgDXDdbhhgYLDeVfRxQk/+acIPX/NzUp7EUd1i8a285iBiNKwYvObEcIwV3xJneKBWD06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2NU9yQ+3ObP3QKx8gbcp8+XsBvOsVdM9OhLDW3cmJU=;
 b=fdJsXirA6BlItLlMgB76mdXHhHHbshDFwOqukp1xzoNKloTYTBm7AdXKgxeeN04x7X9siNFDC8j7nlD8wG6Cb+9/6pcA0guo7WTKc+rWPwxAhWHrxSspVdTS9tN+Wgv28/qmrh1svJYQm8fjJ3JSawoAhsVkk001HGbLkjDlFYF/PBAhzyBzynCfRqRpBE5kg3jWOA6XW2EBaIln3dwkjQ5OScFFnDjrlAgxvLePdiNi+JT67yWuJbP1hvBlWJaRWA4j7orE+AdT28xAdiLjeCrylz9NDMnAQt2ar8VxG+OFsYLzLREDsUlIH0dAuwjDWvGLHmKQVd1+RKOzD+hikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SG2PR06MB5154.apcprd06.prod.outlook.com (2603:1096:4:1cd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.29; Tue, 25 Apr 2023 15:26:16 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 15:26:15 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [RFC RESEND 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
Date:   Tue, 25 Apr 2023 23:21:34 +0800
Message-Id: <20230425152135.30745-3-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: cfc7b65d-857f-4fa7-df8b-08db45a16905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5SvW3+DROtljy4y2Tsml2Zrjq5f9EpnWWpR0moUPZWyQq7yq5Srupq12JutmSF6YBSyQfbkriDREyihWeSxm5IRVegXg4PqKDoOvVPoJOblOJ6OJk6S4iWFBjZGaOoXchlOd1lSfEUf+m3LGdlsIl3Cv7CwqgN4EDR53U8fSe26XjKr9LEKBTF4WEYPeqefcSmT8fw008Cj+4CZ9MohJEIr7Ypvk4RlqyHkwTH+klPP78TjYbsv8+ZgxuOE1nl2txHr3vA49qp5xt2OXht8KGRRYbhtGL2xyTysAt/7M7lv7xTYK9uo5IL4lI/P9BqTAkojb3kqBeJYOhjt9bHlU/Jop1dmjVevRIUtzP4/YIpf74PqAGMqpU4goqAQCfIuNOheN6eRq9/1KHx7820+Ujp7TovvOMda2LsJDtaei9qUD79Lq8sLL5ph3A8Pd9WUDH4qfbeIN+4pw/WqIvRaScMjA+SKGU4MbWYlTM0cf7eJUlRptSX7tAmQREIfrOBXh8xTFA0hLDo8NbCbFMUuatLPsarRO0EScpwlxplY1y6za5AqotsPe9y7tHm6haRH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39830400003)(396003)(451199021)(2616005)(83380400001)(30864003)(2906002)(5660300002)(38350700002)(8676002)(186003)(1076003)(26005)(6506007)(6512007)(8936002)(38100700002)(107886003)(41300700001)(66946007)(86362001)(6486002)(36756003)(52116002)(6666004)(478600001)(4326008)(66556008)(66476007)(316002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGibVxOJdqO+vFljlDjCAG+B7hRaPbNkK0ukdGlS/T1zpsf8BUfTtHxsdD1B?=
 =?us-ascii?Q?iL9SvQast2SgIJmxt/b/VL3tEFGYh+G9N/7KW2oviApM9QXQiH9Q4mJkFvrL?=
 =?us-ascii?Q?p0v7KzezRIU9Fs59FEkf5s5UEoCZPZ4amzAwHxaNrHyxaks9kgki/uq7j76k?=
 =?us-ascii?Q?mcKYsIs2yckr/UWsS+N5aswn0d376wLN1QwWZIFujl2OY32R0nwF3V4GF/mU?=
 =?us-ascii?Q?pLRUd8Q34se67a5TOmLN0sQw0AErV3+HL4ryzOKVQnnE9YAlVFR6s5mHCNvJ?=
 =?us-ascii?Q?N1xK5ubMGGpMXbERIl6BQ5gbSjTIBa+XLWXkWMXWXmmTdxAn8SgdoaPSFqBr?=
 =?us-ascii?Q?pS8EbvRTtOYmzt8qnDuK12bs7ui+SvhYyGvdY3FyXSJ2ScdD/obyUKDQQ9ug?=
 =?us-ascii?Q?hhe8r7Nuees4RXGxf6hxhciqRETaL9ImxIcEXx9h+3HeFqZFjDeYtFVOj9sJ?=
 =?us-ascii?Q?BStss9e5dBnzSOKGLbQCcP1ByznDLvpvwlg9pgSgIRwvD0yao0D3uwFPmXFF?=
 =?us-ascii?Q?t8BUm57Ugout61vsIMsfBbqM121ZxEwD0y1pib6Orl3/v8QIUWhRVU1AeQDz?=
 =?us-ascii?Q?2SmHqLyYbSXbXlUA6dJVufgNZ9QPuuq8IUDZ2A0MB8y9nXRCnDQRZQZC8CZq?=
 =?us-ascii?Q?TOORZxRHYb2zL7R/xZfEVYAZjUdrLytdWI07YtCt74mvIGm325mQyd1gFr/F?=
 =?us-ascii?Q?W5kfoR75INV1mKQTeryHUSGb57ru74EjgSilH4jkhuBhs6OktLKBBbKOeoOJ?=
 =?us-ascii?Q?MOJjK5UseJXcoRn8zKDuCvBHPK4e/3UGMvh/+2tZuKRcK2ErHZLDfm/7GmJS?=
 =?us-ascii?Q?e94KzbP5OYmb0OTP8pwVakiH3d36iamEzDyiazc3Fg8xzwoqIh4V8DbYwS2q?=
 =?us-ascii?Q?01iJQbSUqhEgQzJDpixeSTOD1JzIB92EYDNI/hCowqfCTHo6wSAPF2LPy5xi?=
 =?us-ascii?Q?phlAfFb8r7LoTKeXRSTJBS33n2zL/mQDRU7icWQWO11ln97oFerme3SteuAw?=
 =?us-ascii?Q?Joh7Fs+mLZJgjnOGZyWEHvnTu/9Yxg0rGvTB7axWocpKC+8dBoxR+PXVaZoI?=
 =?us-ascii?Q?i4UOcxTMGSen3qMzb9GHuJ6KaVslxsQQl7RHcfSsnG4m9ttqEFiUi/BpHwC9?=
 =?us-ascii?Q?i9gzWQ/6VzZTRhwQ2DmePmzrXsEfPua3E3cdCe1KuQXepP28oSdW8y4PbNfQ?=
 =?us-ascii?Q?AENuE5KB4ndpBXwBZsN7inHzAKzfJi78Dy/EfpMVRVaYo+G1IiI8KKD+sr08?=
 =?us-ascii?Q?DMoYpY8uuKRZY4ZUrDn+9nBs6fNgMjo6SXiLJpH7Z00kFGwY+rhKF8aFgL1d?=
 =?us-ascii?Q?wHSav10xsgLhjSGOrX1l3UxfYOxk+Uq041VMxrCH9ihnH0b4gG3JJZcIpc8u?=
 =?us-ascii?Q?1F6ZCBigBKebY0EAam2+ZlU6oNUF+teFYaaTpYqoieD3OvQah8PiMFrv8u6k?=
 =?us-ascii?Q?Ay7AYHgzWD3oFREnCICtR4SCtkUItErY0hNEYEDKIYtBFZ9+OntETlbrN8tE?=
 =?us-ascii?Q?EXFermEqbvNyEAFBpMJMz8vbgVrdYNzmQczEaNyiQivkB27iiFIKPdubuPP9?=
 =?us-ascii?Q?mdQkhvXuT4o19/HvDWnf5GRd+Pm3+iPxPk0ppK4xhaS+Iyfzfd7tf3+MuSvv?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc7b65d-857f-4fa7-df8b-08db45a16905
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:26:15.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhtcO6jJCVBvCW2XW5VzDDlM4gN47RJXYDYfH4eSVZMTNJR02cu7MjRiM1Va29XKrzc68dLm290ezHIcmXlsjCXnztap3THgEhOSo5YPtmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP Squared board <http://www.upboard.com> implements certain
features (pin control) through an on-board FPGA.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style and
addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/09 Linus Walleij review, cleaned up coding style and
addressed review comments.
PATCH V2 -> V3:
There's no change.
PATCH V1 -> V2:
(1) Synchronized with upboard github to rc2
(2) Refer 2022/10/19 Mark Brown and Andy Shevchenko review, we removed
the regmap and acpi patches and implement in upboard pinctrl driver.
(3) Refer 2022/10/19 Andy Shevchenko review, fixed the coding style
issues, removed using gpio_xxxx API and removed including <linux/gpio.h>.
---
---
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1281 +++++++++++++++++++++++++++++
 3 files changed, 1296 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1cf74b0c42e5..cc8dae75289b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -483,6 +483,20 @@ config PINCTRL_THUNDERBAY
 	  rate control and direction control. This module will be
 	  called as pinctrl-thunderbay.
 
+config PINCTRL_UPBOARD
+	tristate "UP board FPGA pin controller"
+	depends on (X86 && ACPI) || COMPILE_TEST
+	depends on MFD_INTEL_UPBOARD_FPGA
+	select GENERIC_PINCONF
+	select PINMUX
+	select PINCONF
+	help
+	  Pin controller for the FPGA GPIO lines on UP boards. Due to the
+	  hardware layout, these are meant to be controlled in tandem with their
+	  corresponding Intel SoC GPIOs.
+	  To compile this driver as a module, choose M here: the module
+	  will be called pinctrl-upboard.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e76f5cdc64b0..c366706d36e7 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_UPBOARD)	+= pinctrl-upboard.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
new file mode 100644
index 000000000000..9cabbf460d6e
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -0,0 +1,1281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board HAT pin controller driver
+ * remapping native pin to RPI pin and set CPLD pin dir
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Authors: Gary Wang <garywang@aaeon.com.tw>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "intel/pinctrl-intel.h"
+
+/* Offset from regs */
+#define REVID				0x000
+#define REVID_SHIFT			16
+#define REVID_MASK			GENMASK(31, 16)
+#define PADBAR				0x00c
+
+/* Offset from pad_regs */
+#define PADCFG0				0x000
+#define PADCFG0_RXEVCFG_SHIFT		25
+#define PADCFG0_RXEVCFG_MASK		GENMASK(26, 25)
+#define PADCFG0_RXEVCFG_LEVEL		0
+#define PADCFG0_RXEVCFG_EDGE		1
+#define PADCFG0_RXEVCFG_DISABLED	2
+#define PADCFG0_RXEVCFG_EDGE_BOTH	3
+#define PADCFG0_PREGFRXSEL		BIT(24)
+#define PADCFG0_RXINV			BIT(23)
+#define PADCFG0_GPIROUTIOXAPIC		BIT(20)
+#define PADCFG0_GPIROUTSCI		BIT(19)
+#define PADCFG0_GPIROUTSMI		BIT(18)
+#define PADCFG0_GPIROUTNMI		BIT(17)
+#define PADCFG0_PMODE_SHIFT		10
+#define PADCFG0_PMODE_MASK		GENMASK(13, 10)
+#define PADCFG0_PMODE_GPIO		0
+#define PADCFG0_GPIORXDIS		BIT(9)
+#define PADCFG0_GPIOTXDIS		BIT(8)
+#define PADCFG0_GPIORXSTATE		BIT(1)
+#define PADCFG0_GPIOTXSTATE		BIT(0)
+
+#define PADCFG1				0x004
+#define PADCFG1_TERM_UP			BIT(13)
+#define PADCFG1_TERM_SHIFT		10
+#define PADCFG1_TERM_MASK		GENMASK(12, 10)
+#define PADCFG1_TERM_20K		BIT(2)
+#define PADCFG1_TERM_5K			BIT(1)
+#define PADCFG1_TERM_1K			BIT(0)
+#define PADCFG1_TERM_833		(BIT(1) | BIT(0))
+
+#define PADCFG2				0x008
+#define PADCFG2_DEBEN			BIT(0)
+#define PADCFG2_DEBOUNCE_SHIFT		1
+#define PADCFG2_DEBOUNCE_MASK		GENMASK(4, 1)
+
+#define DEBOUNCE_PERIOD_NSEC		31250
+
+/* Additional features supported by the hardware */
+#define PINCTRL_FEATURE_DEBOUNCE	BIT(0)
+#define PINCTRL_FEATURE_1K_PD		BIT(1)
+
+#define BOARD_UP_CHT01			0
+#define BOARD_UP_APL01			1
+#define BOARD_UP_UPCORE			2
+#define BOARD_UP_CORE_PLUS		3
+#define BOARD_AIOT_IP6801		4
+#define BOARD_UP_WHL01			5
+#define BOARD_UP_ISH			7
+#define BOARD_UPN_APL			8
+#define BOARD_UP_APL03			9
+#define BOARD_UPX_WHLite		10
+#define BOARD_UPX_TGL			11
+#define BOARD_UPX_EDGE_WHL2		12
+#define BOARD_UPN_EHL01			13
+#define BOARD_UPS_EHL01			14
+#define BOARD_UPX_ADLP01		15
+#define BOARD_UPN_ADLN01		16
+#define BOARD_UPS_ADLP01		15
+
+struct upboard_pin {
+	struct regmap_field *funcbit;
+	struct regmap_field *enbit;
+	struct regmap_field *dirbit;
+	/* native pin controllers: number, base, irq */
+	unsigned int gpio;
+	unsigned int base;
+	int irq;
+	void __iomem *regs;
+};
+
+struct upboard_pinctrl {
+	struct gpio_chip chip;
+	struct device *dev;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pin *pins;
+	struct regmap *regmap;
+	const unsigned int *rpi_mapping;
+	int ident;
+};
+
+enum upboard_func0_fpgabit {
+	UPFPGA_I2C0_EN = 8,
+	UPFPGA_I2C1_EN = 9,
+	UPFPGA_CEC0_EN = 12,
+	UPFPGA_ADC0_EN = 14,
+};
+
+static const struct reg_field upboard_i2c0_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_I2C0_EN, UPFPGA_I2C0_EN);
+
+static const struct reg_field upboard_i2c1_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_I2C1_EN, UPFPGA_I2C1_EN);
+
+static const struct reg_field upboard_adc0_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_ADC0_EN, UPFPGA_ADC0_EN);
+
+/* Pin group information */
+struct upboard_pingroup {
+	const char *name;
+	const unsigned int *pins;
+	size_t npins;
+};
+
+/* Pin function information */
+struct upboard_function {
+	const char *name;
+	const char * const *groups;
+	size_t ngroups;
+};
+
+#define UPBOARD_BIT_TO_PIN(r, bit) \
+	((r) * UPFPGA_REGISTER_SIZE + (bit))
+
+/*
+ * UP board data
+ */
+
+#define UPBOARD_UP_BIT_TO_PIN(r, id) (UPBOARD_BIT_TO_PIN(r, UPFPGA_UP_##id))
+
+#define UPBOARD_UP_PIN_ANON(r, bit)					\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+	}
+
+#define UPBOARD_UP_PIN_NAME(r, id)					\
+	{								\
+		.number = UPBOARD_UP_BIT_TO_PIN(r, id),			\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UP_PIN_FUNC(r, id, data)				\
+	{								\
+		.number = UPBOARD_UP_BIT_TO_PIN(r, id),			\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+#define UPBOARD_PIN_GROUP(n, p)			\
+	{					\
+		.name = (n),			\
+		.pins = (p),			\
+		.npins = ARRAY_SIZE((p)),	\
+	}
+
+#define FUNCTION(n, g)				\
+	{					\
+		.name = (n),			\
+		.groups = (g),			\
+		.ngroups = ARRAY_SIZE((g)),	\
+	}
+
+enum upboard_up_reg1_fpgabit {
+	UPFPGA_UP_I2C1_SDA,
+	UPFPGA_UP_I2C1_SCL,
+	UPFPGA_UP_ADC0,
+	UPFPGA_UP_GPIO17,
+	UPFPGA_UP_GPIO27,
+	UPFPGA_UP_GPIO22,
+	UPFPGA_UP_SPI_MOSI,
+	UPFPGA_UP_SPI_MISO,
+	UPFPGA_UP_SPI_CLK,
+	UPFPGA_UP_I2C0_SDA,
+	UPFPGA_UP_GPIO5,
+	UPFPGA_UP_GPIO6,
+	UPFPGA_UP_PWM1,
+	UPFPGA_UP_I2S_FRM,
+	UPFPGA_UP_GPIO26,
+	UPFPGA_UP_UART1_TX,
+};
+
+enum upboard_up_reg2_fpgabit {
+	UPFPGA_UP_UART1_RX,
+	UPFPGA_UP_I2S_CLK,
+	UPFPGA_UP_GPIO23,
+	UPFPGA_UP_GPIO24,
+	UPFPGA_UP_GPIO25,
+	UPFPGA_UP_SPI_CS0,
+	UPFPGA_UP_SPI_CS1,
+	UPFPGA_UP_I2C0_SCL,
+	UPFPGA_UP_PWM0,
+	UPFPGA_UP_GPIO16,
+	UPFPGA_UP_I2S_DIN,
+	UPFPGA_UP_I2S_DOUT,
+};
+
+#define UPFPGA_UP_UART1_RTS UPFPGA_UP_GPIO17
+#define UPFPGA_UP_UART1_CTS UPFPGA_UP_GPIO16
+
+static struct pinctrl_pin_desc upboard_up_pins[] = {
+	UPBOARD_UP_PIN_FUNC(0, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UP_PIN_FUNC(0, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UP_PIN_FUNC(0, ADC0, &upboard_adc0_reg),
+	UPBOARD_UP_PIN_NAME(0, UART1_RTS),
+	UPBOARD_UP_PIN_NAME(0, GPIO27),
+	UPBOARD_UP_PIN_NAME(0, GPIO22),
+	UPBOARD_UP_PIN_NAME(0, SPI_MOSI),
+	UPBOARD_UP_PIN_NAME(0, SPI_MISO),
+	UPBOARD_UP_PIN_NAME(0, SPI_CLK),
+	UPBOARD_UP_PIN_FUNC(0, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UP_PIN_NAME(0, GPIO5),
+	UPBOARD_UP_PIN_NAME(0, GPIO6),
+	UPBOARD_UP_PIN_NAME(0, PWM1),
+	UPBOARD_UP_PIN_NAME(0, I2S_FRM),
+	UPBOARD_UP_PIN_NAME(0, GPIO26),
+	UPBOARD_UP_PIN_NAME(0, UART1_TX),
+	/* register 1 */
+	UPBOARD_UP_PIN_NAME(1, UART1_RX),
+	UPBOARD_UP_PIN_NAME(1, I2S_CLK),
+	UPBOARD_UP_PIN_NAME(1, GPIO23),
+	UPBOARD_UP_PIN_NAME(1, GPIO24),
+	UPBOARD_UP_PIN_NAME(1, GPIO25),
+	UPBOARD_UP_PIN_NAME(1, SPI_CS0),
+	UPBOARD_UP_PIN_NAME(1, SPI_CS1),
+	UPBOARD_UP_PIN_FUNC(1, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UP_PIN_NAME(1, PWM0),
+	UPBOARD_UP_PIN_NAME(1, UART1_CTS),
+	UPBOARD_UP_PIN_NAME(1, I2S_DIN),
+	UPBOARD_UP_PIN_NAME(1, I2S_DOUT),
+};
+
+static const unsigned int upboard_up_rpi_mapping[] = {
+	UPBOARD_UP_BIT_TO_PIN(0, I2C0_SDA),
+	UPBOARD_UP_BIT_TO_PIN(1, I2C0_SCL),
+	UPBOARD_UP_BIT_TO_PIN(0, I2C1_SDA),
+	UPBOARD_UP_BIT_TO_PIN(0, I2C1_SCL),
+	UPBOARD_UP_BIT_TO_PIN(0, ADC0),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO5),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO6),
+	UPBOARD_UP_BIT_TO_PIN(1, SPI_CS1),
+	UPBOARD_UP_BIT_TO_PIN(1, SPI_CS0),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_MISO),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_MOSI),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_CLK),
+	UPBOARD_UP_BIT_TO_PIN(1, PWM0),
+	UPBOARD_UP_BIT_TO_PIN(0, PWM1),
+	UPBOARD_UP_BIT_TO_PIN(0, UART1_TX),
+	UPBOARD_UP_BIT_TO_PIN(1, UART1_RX),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO16),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO17),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_CLK),
+	UPBOARD_UP_BIT_TO_PIN(0, I2S_FRM),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_DIN),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_DOUT),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO22),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO23),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO24),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO25),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO26),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO27),
+};
+
+static const unsigned int uart1_pins[] = { 14, 15, 16, 17 };
+static const unsigned int uart2_pins[] = { 25, 27 };
+static const unsigned int i2c0_pins[]  = { 0, 1 };
+static const unsigned int i2c1_pins[]  = { 2, 3 };
+static const unsigned int spi2_pins[]  = { 8, 9, 10, 11 };
+static const unsigned int i2s0_pins[]  = { 18, 19, 20, 21 };
+static const unsigned int pwm0_pins[]  = { 12 };
+static const unsigned int pwm1_pins[]  = { 13 };
+static const unsigned int adc0_pins[]  = { 4 };
+
+static const struct upboard_pingroup pin_groups[] = {
+	UPBOARD_PIN_GROUP("uart1_grp", uart1_pins),
+	UPBOARD_PIN_GROUP("uart2_grp", uart2_pins),
+	UPBOARD_PIN_GROUP("i2c0_grp", i2c0_pins),
+	UPBOARD_PIN_GROUP("i2c1_grp", i2c1_pins),
+	UPBOARD_PIN_GROUP("spi2_grp", spi2_pins),
+	UPBOARD_PIN_GROUP("i2s0_grp", i2s0_pins),
+	UPBOARD_PIN_GROUP("pwm0_grp", pwm0_pins),
+	UPBOARD_PIN_GROUP("pwm1_grp", pwm1_pins),
+	UPBOARD_PIN_GROUP("adc0_grp", adc0_pins),
+};
+
+static const char * const uart1_groups[] = { "uart1_grp" };
+static const char * const uart2_groups[] = { "uart2_grp" };
+static const char * const i2c0_groups[]  = { "i2c0_grp" };
+static const char * const i2c1_groups[]  = { "i2c1_grp" };
+static const char * const spi2_groups[]  = { "spi2_grp" };
+static const char * const i2s0_groups[]  = { "i2s0_grp" };
+static const char * const pwm0_groups[]  = { "pwm0_grp" };
+static const char * const pwm1_groups[]  = { "pwm1_grp" };
+static const char * const adc0_groups[]  = { "adc0_grp" };
+
+static const struct upboard_function pin_functions[] = {
+	FUNCTION("uart1", uart1_groups),
+	FUNCTION("uart2", uart2_groups),
+	FUNCTION("i2c0",  i2c0_groups),
+	FUNCTION("i2c1",  i2c1_groups),
+	FUNCTION("spi2",  spi2_groups),
+	FUNCTION("i2s0",  i2s0_groups),
+	FUNCTION("pwm0",  pwm0_groups),
+	FUNCTION("pwm1",  pwm1_groups),
+	FUNCTION("adc0",  adc0_groups),
+};
+
+/*
+ * UP^2 board data
+ */
+
+#define UPBOARD_UP2_BIT_TO_PIN(r, id) (UPBOARD_BIT_TO_PIN(r, UPFPGA_UP2_##id))
+
+#define UPBOARD_UP2_PIN_ANON(r, bit)					\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+		.name = "NONAME",					\
+	}
+
+#define UPBOARD_UP2_PIN_NAME(r, id)					\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UP2_PIN_FUNC(r, id, data)				\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+enum upboard_up2_reg0_fpgabit {
+	UPFPGA_UP2_UART1_TXD,
+	UPFPGA_UP2_UART1_RXD,
+	UPFPGA_UP2_UART1_RTS,
+	UPFPGA_UP2_UART1_CTS,
+	UPFPGA_UP2_GPIO3,
+	UPFPGA_UP2_GPIO5,
+	UPFPGA_UP2_GPIO6,
+	UPFPGA_UP2_GPIO11,
+	UPFPGA_UP2_EXHAT_LVDS1n,
+	UPFPGA_UP2_EXHAT_LVDS1p,
+	UPFPGA_UP2_SPI2_TXD,
+	UPFPGA_UP2_SPI2_RXD,
+	UPFPGA_UP2_SPI2_FS1,
+	UPFPGA_UP2_SPI2_FS0,
+	UPFPGA_UP2_SPI2_CLK,
+	UPFPGA_UP2_SPI1_TXD,
+};
+
+enum upboard_up2_reg1_fpgabit {
+	UPFPGA_UP2_SPI1_RXD,
+	UPFPGA_UP2_SPI1_FS1,
+	UPFPGA_UP2_SPI1_FS0,
+	UPFPGA_UP2_SPI1_CLK,
+	UPFPGA_UP2_BIT20,
+	UPFPGA_UP2_BIT21,
+	UPFPGA_UP2_BIT22,
+	UPFPGA_UP2_BIT23,
+	UPFPGA_UP2_PWM1,
+	UPFPGA_UP2_PWM0,
+	UPFPGA_UP2_EXHAT_LVDS0n,
+	UPFPGA_UP2_EXHAT_LVDS0p,
+	UPFPGA_UP2_I2C0_SCL,
+	UPFPGA_UP2_I2C0_SDA,
+	UPFPGA_UP2_I2C1_SCL,
+	UPFPGA_UP2_I2C1_SDA,
+};
+
+enum upboard_up2_reg2_fpgabit {
+	UPFPGA_UP2_EXHAT_LVDS3n,
+	UPFPGA_UP2_EXHAT_LVDS3p,
+	UPFPGA_UP2_EXHAT_LVDS4n,
+	UPFPGA_UP2_EXHAT_LVDS4p,
+	UPFPGA_UP2_EXHAT_LVDS5n,
+	UPFPGA_UP2_EXHAT_LVDS5p,
+	UPFPGA_UP2_I2S_SDO,
+	UPFPGA_UP2_I2S_SDI,
+	UPFPGA_UP2_I2S_WS_SYNC,
+	UPFPGA_UP2_I2S_BCLK,
+	UPFPGA_UP2_EXHAT_LVDS6n,
+	UPFPGA_UP2_EXHAT_LVDS6p,
+	UPFPGA_UP2_EXHAT_LVDS7n,
+	UPFPGA_UP2_EXHAT_LVDS7p,
+	UPFPGA_UP2_EXHAT_LVDS2n,
+	UPFPGA_UP2_EXHAT_LVDS2p,
+};
+
+static struct pinctrl_pin_desc upboard_up2_pins[] = {
+	UPBOARD_UP2_PIN_NAME(0, UART1_TXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RTS),
+	UPBOARD_UP2_PIN_NAME(0, UART1_CTS),
+	UPBOARD_UP2_PIN_NAME(0, GPIO3),
+	UPBOARD_UP2_PIN_NAME(0, GPIO5),
+	UPBOARD_UP2_PIN_NAME(0, GPIO6),
+	UPBOARD_UP2_PIN_NAME(0, GPIO11),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1n),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1p),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_TXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_RXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS1),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS0),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_CLK),
+	UPBOARD_UP2_PIN_NAME(0, SPI1_TXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_RXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS1),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS0),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_CLK),
+	UPBOARD_UP2_PIN_ANON(1, 4),
+	UPBOARD_UP2_PIN_ANON(1, 5),
+	UPBOARD_UP2_PIN_ANON(1, 6),
+	UPBOARD_UP2_PIN_ANON(1, 7),
+	UPBOARD_UP2_PIN_NAME(1, PWM1),
+	UPBOARD_UP2_PIN_NAME(1, PWM0),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0n),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0p),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5p),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDO),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDI),
+	UPBOARD_UP2_PIN_NAME(2, I2S_WS_SYNC),
+	UPBOARD_UP2_PIN_NAME(2, I2S_BCLK),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2p),
+};
+
+static const unsigned int upboard_up2_rpi_mapping[] = {
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C0_SDA),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C0_SCL),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C1_SDA),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C1_SCL),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO3),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO11),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_CLK),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_FS1),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_FS0),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI1_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_CLK),
+	UPBOARD_UP2_BIT_TO_PIN(1, PWM0),
+	UPBOARD_UP2_BIT_TO_PIN(1, PWM1),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_CTS),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_RTS),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_BCLK),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_WS_SYNC),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_SDI),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_SDO),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO6),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_FS1),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_FS0),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO5),
+};
+
+/*
+ * UP Core board + CREX carrier board data
+ */
+
+#define UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id)				\
+	(UPBOARD_BIT_TO_PIN(r, UPFPGA_UPCORE_CREX_##id))
+
+#define UPBOARD_UPCORE_CREX_PIN_ANON(r, bit)				\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+	}
+
+#define UPBOARD_UPCORE_CREX_PIN_NAME(r, id)				\
+	{								\
+		.number = UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id),	\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UPCORE_CREX_PIN_FUNC(r, id, data)			\
+	{								\
+		.number = UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id),	\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+enum upboard_upcore_crex_reg1_fpgabit {
+	UPFPGA_UPCORE_CREX_I2C0_SDA,
+	UPFPGA_UPCORE_CREX_I2C0_SCL,
+	UPFPGA_UPCORE_CREX_I2C1_SDA,
+	UPFPGA_UPCORE_CREX_I2C1_SCL,
+	UPFPGA_UPCORE_CREX_SPI2_CS0,
+	UPFPGA_UPCORE_CREX_SPI2_CS1,
+	UPFPGA_UPCORE_CREX_SPI2_MOSI,
+	UPFPGA_UPCORE_CREX_SPI2_MISO,
+	UPFPGA_UPCORE_CREX_SPI2_CLK,
+	UPFPGA_UPCORE_CREX_UART1_TXD,
+	UPFPGA_UPCORE_CREX_UART1_RXD,
+	UPFPGA_UPCORE_CREX_PWM0,
+	UPFPGA_UPCORE_CREX_PWM1,
+	UPFPGA_UPCORE_CREX_I2S2_FRM,
+	UPFPGA_UPCORE_CREX_I2S2_CLK,
+	UPFPGA_UPCORE_CREX_I2S2_RX,
+};
+
+enum upboard_upcore_crex_reg2_fpgabit {
+	UPFPGA_UPCORE_CREX_I2S2_TX,
+	UPFPGA_UPCORE_CREX_GPIO0,
+	UPFPGA_UPCORE_CREX_GPIO2,
+	UPFPGA_UPCORE_CREX_GPIO3,
+	UPFPGA_UPCORE_CREX_GPIO4,
+	UPFPGA_UPCORE_CREX_GPIO9,
+};
+
+static struct pinctrl_pin_desc upboard_upcore_crex_pins[] = {
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CS0),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CS1),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_MOSI),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_MISO),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CLK),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, UART1_TXD),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, UART1_RXD),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, PWM0),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, PWM1),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_FRM),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_CLK),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_RX),
+	/* register 1 */
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, I2S2_TX),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO0),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(1, GPIO2, &upboard_adc0_reg),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO3),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO4),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO9),
+};
+
+static unsigned int upboard_upcore_crex_rpi_mapping[] = {
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C0_SDA),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C0_SCL),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C1_SDA),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C1_SCL),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO2),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO3),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CS1),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CS0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_MISO),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_MOSI),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CLK),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, PWM0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, PWM1),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, UART1_TXD),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, UART1_RXD),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO9),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO4),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_CLK),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_FRM),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_RX),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, I2S2_TX),
+};
+
+/*
+ * UP Core board + CRST02 carrier board data
+ */
+
+#define upboard_upcore_crst02_pins		upboard_upcore_crex_pins
+#define upboard_upcore_crst02_rpi_mapping	upboard_upcore_crex_rpi_mapping
+
+static int upboard_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+			   unsigned int group)
+{
+	return 0;
+}
+
+static int upboard_fpga_request_enable(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int pin)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+	int ret;
+
+	p = pd->drv_data;
+	if (p->funcbit) {
+		ret = regmap_field_write(p->funcbit, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (p->enbit) {
+		ret = regmap_field_write(p->enbit, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_fpga_request_free(struct pinctrl_dev *pctldev,
+				     unsigned int pin)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+	int ret;
+
+	p = pd->drv_data;
+	if (p->funcbit) {
+		ret = regmap_field_write(p->funcbit, 1);
+		if (ret)
+			return ret;
+	}
+
+	if (p->enbit) {
+		ret = regmap_field_write(p->enbit, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_fpga_set_direction(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int pin, bool input)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+
+	p = pd->drv_data;
+	upboard_fpga_request_enable(pctldev, range, pin);
+
+	return regmap_field_write(p->dirbit, input);
+}
+
+static int upboard_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *upboard_get_function_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector)
+{
+	return NULL;
+}
+
+static int upboard_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned int *num_groups)
+{
+	*groups = NULL;
+	*num_groups = 0;
+	return 0;
+}
+
+static const struct pinmux_ops upboard_pinmux_ops = {
+	.get_functions_count = upboard_get_functions_count,
+	.get_function_groups = upboard_get_function_groups,
+	.get_function_name = upboard_get_function_name,
+	.set_mux = upboard_set_mux,
+	.gpio_request_enable = upboard_fpga_request_enable,
+	.gpio_set_direction = upboard_fpga_set_direction,
+};
+
+static int upboard_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *upboard_get_group_name(struct pinctrl_dev *pctldev,
+					  unsigned int selector)
+{
+	return NULL;
+}
+
+static const struct pinctrl_ops upboard_pinctrl_ops = {
+	.get_groups_count = upboard_get_groups_count,
+	.get_group_name = upboard_get_group_name,
+};
+
+static struct pinctrl_desc upboard_up_pinctrl_desc = {
+	.pins = upboard_up_pins,
+	.npins = ARRAY_SIZE(upboard_up_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_up2_pinctrl_desc = {
+	.pins = upboard_up2_pins,
+	.npins = ARRAY_SIZE(upboard_up2_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_upcore_crex_pinctrl_desc = {
+	.pins = upboard_upcore_crex_pins,
+	.npins = ARRAY_SIZE(upboard_upcore_crex_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_upcore_crst02_pinctrl_desc = {
+	.pins = upboard_upcore_crst02_pins,
+	.npins = ARRAY_SIZE(upboard_upcore_crst02_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static void upboard_alt_func_enable(struct gpio_chip *gc, const char *name, int id)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	int offset[pctrl->pctldesc->npins];
+	int i, cnt;
+
+	/* find all pins */
+	for (i = 0, cnt = 0; i < pctrl->pctldesc->npins; i++) {
+		if (strstr(pctrl->pctldesc->pins[i].name, name))
+			offset[cnt++] = i;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (pinctrl_gpio_request(pctrl->pins[offset[i]].gpio))
+			return; /* this pin is being used */
+
+		pinctrl_gpio_free(pctrl->pins[offset[i]].gpio);
+	}
+
+	/* change to alternate function */
+	for (i = 0; i < cnt; i++) {
+		if (pctrl->pins[offset[i]].regs == NULL)
+			continue;
+		bool input = false;
+		int mode = 1; /* default */
+		unsigned int val = readl(pctrl->pins[offset[i]].regs);
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2C")) {
+			switch (id) {
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 2;
+				break;
+			default:
+				break;
+			}
+			val |= mode<<PADCFG0_PMODE_SHIFT;
+			writel(val, pctrl->pins[offset[i]].regs);
+			upboard_fpga_request_free(pctrl->pctldev, offset[i]);
+			continue;
+		} else if (strstr(pctrl->pctldesc->pins[offset[i]].name, "UART")) {
+			switch (id) {
+			case BOARD_UPN_EHL01:
+			case BOARD_UPS_EHL01:
+				mode = 4;
+				break;
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 2;
+				break;
+			default:
+				break;
+			}
+		} else if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SPI")) {
+			switch (id) {
+			case BOARD_UP_WHL01:
+				mode = 3;
+				break;
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 7;
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MOSI")) {
+					val &= ~PADCFG0_GPIOTXDIS;
+					val |= PADCFG0_GPIORXDIS;
+				}
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO")) {
+					val |= PADCFG0_GPIORXDIS;
+				}
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CLK")) {
+					val &= ~PADCFG0_GPIOTXDIS;
+					val |= PADCFG0_GPIORXDIS;
+				}
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS0")) {
+					val |= PADCFG0_GPIORXDIS;
+				}
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS1")) {
+					continue;
+				}
+				break;
+			default:
+				break;
+			}
+		} else if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2S")) {
+			switch (id) {
+			case BOARD_UPX_ADLP01:
+				mode = 4;
+				break;
+			default:
+				break;
+			}
+		}
+		val |= mode<<PADCFG0_PMODE_SHIFT;
+		writel(val, pctrl->pins[offset[i]].regs);
+
+		/* input pins */
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
+			input = true;
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
+			input = true;
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC"))
+			input = true;
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
+			input = true;
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
+			input = true;
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SDI"))
+			input = true;
+		upboard_fpga_set_direction(pctrl->pctldev, NULL, offset[i], input);
+	}
+}
+
+static int upboard_rpi_to_native_gpio(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[gpio];
+	struct pinctrl_gpio_range *range;
+
+	range = pinctrl_find_gpio_range_from_pin(pctrl->pctldev, pin);
+	if (!range)
+		return -ENODEV;
+
+	return range->base;
+}
+
+static int upboard_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+
+	return pinctrl_gpio_request(gpio);
+}
+
+static void upboard_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	char name[strlen(pctrl->pctldesc->pins[pin].name)];
+	char *p;
+
+	pinctrl_gpio_free(gpio);
+
+	strcpy(name, pctrl->pctldesc->pins[pin].name);
+	p = name;
+	upboard_alt_func_enable(gc, strsep(&p, "_"), pctrl->ident);
+}
+
+static int upboard_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+
+	return gpiod_get_value(gpio_to_desc(gpio));
+}
+
+static void upboard_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+
+	gpiod_set_value(gpio_to_desc(gpio), value);
+
+	/* APL03 board open drain GPIO */
+	if (pctrl->ident == BOARD_UP_APL03) {
+		if (pin == 0 || pin == 1) {
+			int val = readl(pctrl->pins[pin].regs);
+
+			if (value)
+				val |= PADCFG0_GPIOTXDIS;
+			else
+				val &= ~PADCFG0_GPIOTXDIS;
+
+			writel(val, pctrl->pins[pin].regs);
+		}
+	}
+}
+
+static int upboard_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	struct pinctrl_gpio_range *range;
+
+	range = pinctrl_find_gpio_range_from_pin(pctrl->pctldev, pin);
+	upboard_fpga_set_direction(pctrl->pctldev, range, pin, true);
+
+	return gpiod_direction_input(gpio_to_desc(gpio));
+}
+
+static int upboard_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset, int value)
+{
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	struct pinctrl_gpio_range *range;
+
+	range = pinctrl_find_gpio_range_from_pin(pctrl->pctldev, pin);
+	upboard_fpga_set_direction(pctrl->pctldev, range, pin, false);
+
+	return gpiod_direction_output(gpio_to_desc(gpio), value);
+}
+
+static void __iomem *upboard_get_regs(struct gpio_chip *gc, unsigned int gpio, unsigned int reg)
+{
+	struct platform_device *pdev = to_platform_device(gc->parent);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	size_t nregs;
+	void __iomem *base = NULL;
+	u32 offset, value;
+	int pin = gpio-gc->base;
+
+	/* check Intel pin controller for all platform */
+	if (pctrl->ncommunities > 1) {
+		int i, j, offset = 0;
+
+		pin = -1;
+		for (i = 0; i < pctrl->ncommunities; i++) {
+			struct intel_community *community = &pctrl->communities[i];
+
+			for (j = 0; j < community->ngpps ; j++) {
+				struct intel_padgroup gpps = community->gpps[j];
+
+				if (gpio < gc->base + gpps.gpio_base + gpps.size) {
+					res = platform_get_resource(pdev, IORESOURCE_MEM,
+								    community->barno);
+					pin = gpio-gc->base-gpps.gpio_base +
+					      offset-community->pin_base;
+					break;
+				}
+
+				offset += gpps.size;
+			}
+
+			if (pin != -1)
+				break;
+		}
+	}
+
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (base == NULL)
+		return base;
+
+	offset = readl(base + PADBAR);
+	value = readl(base + REVID);
+
+	if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x94)
+		nregs = 4;
+	else
+		nregs = 2;
+
+	return base + offset + reg + pin * nregs * 4;
+}
+
+int upboard_acpi_node_pin_mapping(struct upboard_fpga *fpga,
+				  struct upboard_pinctrl *pctrl,
+				  const char *propname,
+				  const char *pinctl_name,
+				  unsigned int pin_offset)
+{
+	struct gpio_descs *descs;
+	int ret, i;
+
+	descs = devm_gpiod_get_array(fpga->dev, propname, GPIOD_ASIS);
+	if (IS_ERR(descs)) {
+		ret = PTR_ERR(descs);
+		if (ret != -EPROBE_DEFER)
+			dev_err(fpga->dev, "Failed to get %s gpios", propname);
+
+		return ret;
+	}
+
+	for (i = 0; i < descs->ndescs; i++) {
+		struct gpio_desc *desc = descs->desc[i];
+		struct gpio_chip *gc = gpiod_to_chip(desc);
+
+		pctrl->pins[i].gpio = desc_to_gpio(desc);
+		pctrl->pins[i].base = gc->base;
+		pctrl->pins[i].irq = gpiod_to_irq(desc);
+		pctrl->pins[i].regs =
+			upboard_get_regs(gc,
+					 desc_to_gpio(desc) - gc->base,
+					 PADCFG0);
+
+		/* The GPIOs may not be contiguous, so add them 1-by-1 */
+		ret = gpiochip_add_pin_range(gpiod_to_chip(desc), pinctl_name,
+					     desc_to_gpio(desc) - gc->base,
+					     pin_offset + i, 1);
+		if (ret)
+			return ret;
+	}
+
+	/* dispose acpi resource */
+	devm_gpiod_put_array(fpga->dev, descs);
+
+	return ret;
+}
+
+static struct gpio_chip upboard_gpio_chip = {
+	.label = "Raspberry Pi compatible UP GPIO",
+	.base = 0,
+	.request = upboard_gpio_request,
+	.free = upboard_gpio_free,
+	.get = upboard_gpio_get,
+	.set = upboard_gpio_set,
+	.direction_input = upboard_gpio_direction_input,
+	.direction_output = upboard_gpio_direction_output,
+	.owner = THIS_MODULE,
+};
+
+/* DMI Matches for older bios without fpga initialization */
+static const struct dmi_system_id upboard_dmi_table[] __initconst = {
+	{
+		.ident = BOARD_UP_APL03,
+		.matches = { /* UP 4000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
+		},
+	},
+	{
+		.ident = BOARD_UP_WHL01,
+		.matches = { /* UPX WHL */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPX_TGL,
+		.matches = { /* UP i11 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-TGL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPN_EHL01,
+		.matches = { /* UP 6000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-EHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPS_EHL01,
+		.matches = { /* UP squared v2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-EHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPX_ADLP01,
+		.matches = { /* UP Xtreme i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-ADLP01"),
+		},
+	},
+	{
+		.ident = BOARD_UPN_ADLN01,
+		.matches = { /* UP 7000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-ADLN01"),
+		},
+	},
+	{
+		.ident = BOARD_UPS_ADLP01,
+		.matches = { /* UP Squared i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-ADLP01"),
+		},
+	},
+	{ }	/* Terminating entry */
+};
+
+static int __init upboard_pinctrl_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);
+	struct acpi_device * const adev = ACPI_COMPANION(&pdev->dev);
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pinctrl *pctrl;
+	struct upboard_pin *pins;
+	const struct dmi_system_id *system_id;
+	const char *hid;
+	const unsigned int *rpi_mapping;
+	unsigned int ngpio;
+	int ret;
+	int i;
+
+	if (!fpga)
+		return -EINVAL;
+
+	if (!adev)
+		return -ENODEV;
+
+	/* set pin desc and rpi GPIO mapping table by HID */
+	hid = acpi_device_hid(adev);
+	if (!strcmp(hid, "AANT0F00") || !strcmp(hid, "AANT0F04") ||
+	    !strcmp(hid, "AANT0000")) {
+		pctldesc = &upboard_up_pinctrl_desc;
+		rpi_mapping = upboard_up_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_up_rpi_mapping);
+	} else if (!strcmp(hid, "AANT0F01")) {
+		pctldesc = &upboard_up2_pinctrl_desc;
+		rpi_mapping = upboard_up2_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_up2_rpi_mapping);
+	} else if (!strcmp(hid, "AANT0F02")) {
+		pctldesc = &upboard_upcore_crex_pinctrl_desc;
+		rpi_mapping = upboard_upcore_crex_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
+	} else if (!strcmp(hid, "AANT0F03")) {
+		pctldesc = &upboard_upcore_crst02_pinctrl_desc;
+		rpi_mapping = upboard_upcore_crst02_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
+	} else
+		return -ENODEV;
+
+	pctldesc->name = dev_name(&pdev->dev);
+
+	pins = devm_kcalloc(&pdev->dev, pctldesc->npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	/* initialise pins */
+	for (i = 0; i < pctldesc->npins; i++) {
+		struct upboard_pin *pin = &pins[i];
+		struct pinctrl_pin_desc *pd = (struct pinctrl_pin_desc *) &pctldesc->pins[i];
+		struct reg_field fldconf = {0};
+		unsigned int regoff = (pd->number / UPFPGA_REGISTER_SIZE);
+		unsigned int lsb = pd->number % UPFPGA_REGISTER_SIZE;
+
+		pin->funcbit = NULL;
+
+		if (pd->drv_data) {
+			fldconf = *(struct reg_field *)pd->drv_data;
+
+			pin->funcbit = devm_regmap_field_alloc(&pdev->dev,
+							       fpga->regmap,
+							       fldconf);
+			if (IS_ERR(pin->funcbit))
+				return PTR_ERR(pin->funcbit);
+		}
+
+		pin->enbit = NULL;
+		fldconf.reg = UPFPGA_REG_GPIO_EN0 + regoff;
+		fldconf.lsb = lsb;
+		fldconf.msb = lsb;
+
+		pin->enbit = devm_regmap_field_alloc(&pdev->dev,
+						     fpga->regmap,
+						     fldconf);
+		if (IS_ERR(pin->enbit))
+			return PTR_ERR(pin->enbit);
+
+		fldconf.reg = UPFPGA_REG_GPIO_DIR0 + regoff;
+		fldconf.lsb = lsb;
+		fldconf.msb = lsb;
+
+		pin->dirbit = devm_regmap_field_alloc(&pdev->dev,
+						      fpga->regmap,
+						      fldconf);
+		if (IS_ERR(pin->dirbit))
+			return PTR_ERR(pin->dirbit);
+
+		pd->drv_data = pin;
+
+		/* set output by default */
+		regmap_field_write(pin->dirbit, false);
+	}
+
+	/* create a new pinctrl device and register it */
+	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	pctrl->regmap = fpga->regmap;
+	pctrl->rpi_mapping = rpi_mapping;
+	pctrl->chip = upboard_gpio_chip;
+	pctrl->pctldesc = pctldesc;
+	pctrl->chip.parent = &pdev->dev;
+	pctrl->chip.ngpio = ngpio;
+	pctrl->pins = pins;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctrl->chip, pctrl);
+	if (ret)
+		return ret;
+
+	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, pctldesc, pctrl);
+	if (IS_ERR(pctrl->pctldev))
+		return PTR_ERR(pctrl->pctldev);
+
+	/* add acpi pin mapping according to external-gpios key */
+	ret = upboard_acpi_node_pin_mapping(fpga, pctrl,
+					    "external",
+					    dev_name(&pdev->dev),
+					    0);
+	if (ret)
+		return ret;
+
+	/* check for special board versions that require register patches */
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		pctrl->ident = system_id->ident;
+	else
+		pctrl->ident = BOARD_UP_APL03;
+
+	upboard_alt_func_enable(&pctrl->chip, "I2C",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "SPI",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "SPI1",   pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "SPI2",   pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "UART",   pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "I2S",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "PWM",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "ADC",    pctrl->ident);
+	/* I2C pin mux by CPLD in UP2 */
+	upboard_alt_func_enable(&pctrl->chip, "NONAME", pctrl->ident);
+
+	return ret;
+}
+
+static struct platform_driver upboard_pinctrl_driver = {
+	.driver = {
+		.name = "upboard-pinctrl",
+	},
+};
+module_platform_driver_probe(upboard_pinctrl_driver, upboard_pinctrl_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board HAT pin controller driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-pinctrl");
-- 
2.17.1

