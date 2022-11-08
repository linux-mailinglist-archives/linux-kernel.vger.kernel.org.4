Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024462199B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiKHQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiKHQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:40:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB967528B9;
        Tue,  8 Nov 2022 08:40:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R52aBbWBbjRYhkwMiV5eclJfvR+cXtz9+blnraPFZ6MKv0A6I0NzT2YbYlELKMnPnq9NZSKmUU5D9uhhBjq03BNunJ55VCfcQzreJA8omYwju/cMHPmDVx8yevRmXoVq8RArUGowXucj0cjK9jdMUQduccTySeMolFpgF6QT0pYYbadnonIgd/mBtduKGePtVRxUVMZiI/8h3pb4GtUCResbHD6btBIgOb3chYih1amkxCvAzh7gUk+vMAZsZxhIe+GO9edJGcxA7XxX2KS2UTUsGGLGV1KOwOhi+5cLrsVXmwxSC/hTBU38svgEJX6+7QT4lB4KZ8Y8Mzfa6ebhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFkfl8BMcTxRxA3ZXlcrRWEgwr78dffkPnc+Q+MgP0M=;
 b=mrFy0Ich8WNlJD28crU0OPHHPBTTgo+Yg2F1XLKnj646RYWk2B4MWYSKn8UnrDgMkvO3iUkcm52KhYRGW60SHiPJmP0vO7sb4UTyKdkTjJ9P5pvPJMUrB/y9pbibGuLDiu58tUAN/Nokj8e03wwMDBDnuC4k/ORgn7sWErbwMdhDHWskWmZM5UlrGCIYH/SAZn8GkWKbq9yic1Tq/oaORShCxrURXuJIgo1ZQj3Xl1z8lEidqtZjPoEFrmPQ2FNWG8gQMOn8/ZZJYQToA9Cfw3a1H57qNRdnCWge2XvdKptYLIk/cyb40+NR3JFCA/XwzOKEnIDCX1P9MoNljn7lyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4454.apcprd06.prod.outlook.com (2603:1096:301:8a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 16:40:01 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 16:40:01 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [PATCH V2 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Wed,  9 Nov 2022 00:38:50 +0800
Message-Id: <20221108163852.15926-2-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66da6a39-6d9c-4aa3-72a9-08dac1a7e166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4d+UI76fvJ4KOfyXdf2DuWAihiehXOm5oUMxYj3b93U/357cN93SMWRSDTrPv6g08xboPOTof5xuxsZy3UFnsrs35c2UUwg7n4u2PcldGLYgBcdf5pc5NcsRU0xijHA4DWltDMgjB35sr9qQK4aNZqaC+whCfnEZmuRQN3wYqTBtHiY0LGXJSAWUh8eBlpSq0csk+vvmPuI0hpHjWWsqBM14wfPiARchvlt3PMUaVRU+vrm3GQUZxBC4zNKxfXPeeciRvTDiBM2VSakZhKzC2S1zUtpQ/l85+KRqf+JjlehTZYEGF1dnTxTY5Qtg++TD7V7AdipFdGZwHD0atOclOw6bfEf4P5mvrm844KT7RBk7VGL6cZnLclseOktTKuMD0BbUxcSfITzSAEDQgTmv2HEQ8wCtQIlK+Ym3sQDkdYSfqDco4Vle08Z3Ucq9s2XGmYfg0awQaI0nO/bSNN3c1weWyNgsWxin6/EFl371faqsnMuHlYnRjUFY+DKFg+KmxvqlXR0AEz6E7hgPpzw3P0cwj0GOdH4ot14ZmAsKLqVTfN7lBtG7JaBtPqYlmjjT7cJaIRZxNVDfZHpqQ/JniIQcrFSuWJC6qmUsF2Zb/QW/nYMWtIi91H57Zr6XAKyf+LvW2Ew/0WQOfdYlKb4hOBYR2mHI+royLxTLx9913LF1Mem/zG9TVRAXVaKuXglmeGNhw1TV4/40D9IIPHDKLau3Rm5G7yEjdSGgAQ7XZpRVNdXamEfpKHqPSguG+Md7/zJYtrWbPJTXOvFNOa8gX9iCtxMXe2XRZ4yUyJwLSaSa+xUT8UHqK8abO2xcXTL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39830400003)(396003)(366004)(136003)(451199015)(7416002)(8936002)(41300700001)(30864003)(38350700002)(38100700002)(52116002)(6666004)(6506007)(4326008)(66946007)(83380400001)(2906002)(66556008)(66476007)(6512007)(26005)(54906003)(316002)(5660300002)(86362001)(478600001)(6486002)(186003)(36756003)(2616005)(8676002)(1076003)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pLLtE7whM8WwcpfCBKKTol+tYqCllCp4whyrS9O/v1Tfz83XVLPGfzAKczf?=
 =?us-ascii?Q?li43jd/jnD7yp8N5wFeJ8hhcHpnEmNKSIEE4k/tMIAwpANicLRmyuSew9s3u?=
 =?us-ascii?Q?G/mHksHx54DigEI5L3MSI4loGMKkBWwRVskrCVkZzl41sUoxrvlqvNmKphc+?=
 =?us-ascii?Q?pqLvN3UlxiM97yJK/xo1ivCTGB6kJUuYswkeksdCrDXtojsjB43e23xbnYmO?=
 =?us-ascii?Q?zw4cB+g4Sxayy4Z6qyVpRe3cXUTVy6m9JVL2YFzWpw3S1xFg0Sh3c1hiUJtD?=
 =?us-ascii?Q?DReFydEq3qfWe76uf8Kzy6z0+bjl+HAstehbIMTC9cbJP99skp4pDAAEirfA?=
 =?us-ascii?Q?1zXpX5vZjx4xxHoMHNVw8y4k1RuoCdKN7CCTNVfwVFEdfMq6KY5mxdSvME45?=
 =?us-ascii?Q?qedofQHGeAf7aPkEZwoQAKfuZs7UDT2UMTgYVfGBwJC7TFZUhdXI3j0XcOAG?=
 =?us-ascii?Q?ST9Sf9T9FCIMBgEqn76YeFl0PiobaonFkPsyY/hycyTyYA6PmjYbUEefI1W/?=
 =?us-ascii?Q?iRhK49nmjc4DBCyqmq0h9MVcT6AhGx48SpAT5gVpGqaMg7541MKYPgoAm7LX?=
 =?us-ascii?Q?tYhWY+tSOuMtYuDMyNSWtBm60HSEtlCRS7v4Cx9dsApCIcKHvyEWqygaD/Af?=
 =?us-ascii?Q?oVqQjfG4zIO4i946h3F51r24WzJrr9sBcJ9tFpuJuZfHw8zj1Mbf/9sHWWVg?=
 =?us-ascii?Q?BsNm2aEwAxpbWLF8agzyDk9UWNJb8P+r0sBreMM4O0RowwzLx2m+1eujrai1?=
 =?us-ascii?Q?LxI8FPMsfOIIsqvyXqkdG3cWKR+Vy5JYgGL6CPLkIT3Ol+rcYOwcB5449vAW?=
 =?us-ascii?Q?dB2dZ+/ARGjN2P72mEnxVFeie35ZJwcDeArPjFZ5+GtBwclHwsAJ/I3VI3gQ?=
 =?us-ascii?Q?MXhndFoOF2ehag4eMd3XDcBWe82fQzDlMBlVU0Xw2SaVT6So88aTUUom7tTw?=
 =?us-ascii?Q?MP81Kn80BookyoevxsACIUkR4RcfTw1KIDqCoZ6QZXjXoOncowgbBx9r8nRy?=
 =?us-ascii?Q?pbBpGmnjB2ND7Rw8BLcUx5/JlsNZ4OeCQQTdLMhv7RR9W9gulG1BCGh+pdRV?=
 =?us-ascii?Q?9eDa+4hemnbzCKHZKtb/7dyolCs81LodyQNDhNcN5SQBKHT3VJq097u3mh4E?=
 =?us-ascii?Q?4+asarAMtN0e9rbfPp8RHr1vmrHXlY8VX9Pfinxjp/Y9MwHM6iIu/58+8WZP?=
 =?us-ascii?Q?loSD1Vg2boON2EEdPu+mxPYdVqLthUU7rXjW4z830S8l93/aN5NOrBDcQhAh?=
 =?us-ascii?Q?OdJvz/u4N0O2l6SKDitATqEDEPobyfPOoaLG5c1z/H5U5lgAOlcMuG+ASIm3?=
 =?us-ascii?Q?HiaoYz4yPYxICgJGik5+XJHKg1nVQAvnqPS+NyABNpK+UZW+WU2g4TWI4Ur2?=
 =?us-ascii?Q?hMfz8O8ba9s/38BGGqEINwu/zW3QCkZlcDwqBHVcBUp0YwTpvlmiUFXKRyGw?=
 =?us-ascii?Q?6AIznlapNrtI11OTbI+Dp73qHlJo3KOav+ho14qRxP0umgQtBtot+tC6Gs0w?=
 =?us-ascii?Q?e4BnIc+e/3QegpHhWstkyB/VfvUdBCDGIR0w7mAOx/27Q87FgkvSmWUYyNwr?=
 =?us-ascii?Q?pa6KnbRg7slaOxEpQEVmysDU5R85meFYarLpW1K+qZEO9ruRJqk30vnQ9LR0?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66da6a39-6d9c-4aa3-72a9-08dac1a7e166
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:40:01.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLSCnpIOOtvBvIoZucf8VkZVRIOSnxkZDznw8VFvmyI8XaxTJDAaZWMHwSmpk5xU9y4A7A2RSR0+7DsxVNtkc/fC9UsxqmNn4aqoteGummM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4454
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP Squared board <http://www.upboard.com> implements certain
features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

This mfd driver implements the line protocol to read and write registers
from the FPGA through regmap. The register address map is also included.

The UP Boards provide a few I/O pin headers (for both GPIO and
functions), including a 40-pin Raspberry Pi compatible header.

This patch implements support for the FPGA-based pin controller that
manages direction and enable state for those header pins.

Partial support UP boards:
* UP core + CREX
* UP core + CRST02

PATCH V2:
(1) Synchronizing upboard github to rc2
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.

Signed-off-by: Javier Arteaga <javier@emutex.com>
[merge various fixes]
Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 632 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  56 +++
 4 files changed, 701 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..c1d72a70e5f2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_UPBOARD_FPGA
+	tristate "Support for the UP board FPGA"
+	select MFD_CORE
+	depends on X86 && ACPI
+	help
+	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
+	  The UP board implements certain features (pin control, onboard LEDs or
+	  CEC) through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..d9d10e3664f7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..a38f3d3375b2
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board main platform driver and FPGA configuration support
+ *
+ * Copyright (c) 2021, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_fpga_data {
+	const struct regmap_config *regmapconf;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+#define UPBOARD_LED_CELL(led_data, n)                   \
+	{                                               \
+		.name = "upboard-led",                  \
+		.id = (n),                              \
+		.platform_data = &led_data[(n)],        \
+		.pdata_size = sizeof(*(led_data)),      \
+	}
+
+#define AAEON_MANUFACTURER_ID 0x01
+#define SUPPORTED_FW_MAJOR 0x0
+#define MENUFACTURER_ID_MASK 0xFF
+
+#define FIRMWARE_ID_BUILD_OFFSET 12
+#define FIRMWARE_ID_MAJOR_OFFSET 8
+#define FIRMWARE_ID_MINOR_OFFSET 4
+#define FIRMWARE_ID_PATCH_OFFSET 0
+#define FIRMWARE_ID_MASK 0xF
+
+#define UPFPGA_QUIRK_UNINITIALISED  BIT(0)
+#define UPFPGA_QUIRK_HRV1_IS_PROTO2 BIT(1)
+#define UPFPGA_QUIRK_GPIO_LED       BIT(2)
+
+#define UPBOARD_DEVID 0
+
+/* UP-CREX carrier board for UP Core */
+
+/* same MAXV config as UP1 (proto2 release) */
+#define upboard_upcore_crex_fpga_data upboard_up_fpga_data
+
+#define APL_GPIO_218	507
+
+/* UP board */
+
+static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	if (IS_ERR(fpga->clear_gpio))	//for none fpga boards
+		return 0;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	reg |= UPFPGA_READ_FLAG;
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+	*val = 0;
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	if (IS_ERR(fpga->clear_gpio))	//for none fpga boards
+		return 0;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, (val >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+static const struct regmap_range upboard_up_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_range upboard_up_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_access_table upboard_up_readable_table = {
+	.yes_ranges = upboard_up_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up_writable_table = {
+	.yes_ranges = upboard_up_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
+};
+
+static const struct regmap_config upboard_up_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+static struct upboard_led_data upboard_up_led_data[] = {
+	{ .bit = 0, .colour = "yellow" },
+	{ .bit = 1, .colour = "green" },
+	{ .bit = 2, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	UPBOARD_LED_CELL(upboard_up_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up_led_data, 2),
+};
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+//UP-EHL
+static const struct mfd_cell upboard_pinctrl_cells[] = {
+	{ .name = "upboard-pinctrl" },
+};
+
+static const struct upboard_fpga_data upboard_pinctrl_data = {
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_pinctrl_cells,
+	.ncells = ARRAY_SIZE(upboard_pinctrl_cells),
+};
+
+/* UP^2 board */
+
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static const struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+//	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .bit = 0, .colour = "blue" },
+	{ .bit = 1, .colour = "yellow" },
+	{ .bit = 2, .colour = "green" },
+	{ .bit = 3, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static struct gpio_led upboard_gpio_leds[] = {
+	{
+		.name = "upboard:blue:",
+		.gpio = APL_GPIO_218,
+		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
+	},
+};
+static struct gpio_led_platform_data upboard_gpio_led_platform_data = {
+	.num_leds = ARRAY_SIZE(upboard_gpio_leds),
+	.leds = upboard_gpio_leds,
+};
+static const struct mfd_cell upboard_gpio_led_cells[] = {
+	{
+		.name = "leds-gpio",
+		.id = 0,
+		.platform_data = &upboard_gpio_led_platform_data,
+		.pdata_size = sizeof(upboard_gpio_led_platform_data),
+	},
+};
+
+static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
+{
+	enum gpiod_flags flags;
+
+	flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
+
+	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", flags);
+	if (IS_ERR(fpga->enable_gpio))
+		return PTR_ERR(fpga->enable_gpio);
+
+	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->clear_gpio))
+		return PTR_ERR(fpga->clear_gpio);
+
+	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->strobe_gpio))
+		return PTR_ERR(fpga->strobe_gpio);
+
+	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->datain_gpio))
+		return PTR_ERR(fpga->datain_gpio);
+
+	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(fpga->dataout_gpio))
+		return PTR_ERR(fpga->dataout_gpio);
+
+	/*
+	 * The SoC pinctrl driver may not support reserving the GPIO line for
+	 * FPGA reset without causing an undesired reset pulse. This will clear
+	 * any settings on the FPGA, so only do it if we must.
+	 */
+	if (fpga->uninitialised) {
+		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset",
+						  GPIOD_OUT_LOW);
+		if (IS_ERR(fpga->reset_gpio))
+			return PTR_ERR(fpga->reset_gpio);
+
+		gpiod_set_value(fpga->reset_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->enable_gpio, 1);
+	fpga->uninitialised = false;
+
+	return 0;
+}
+
+static int __init upboard_fpga_detect_firmware(struct upboard_fpga *fpga)
+{
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	if (!fpga)
+		return -ENOMEM;
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & MENUFACTURER_ID_MASK;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_err(fpga->dev,
+			"driver not compatible with custom FPGA FW from manufacturer id 0x%02x. Exiting",
+			manufacturer_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> FIRMWARE_ID_BUILD_OFFSET) & FIRMWARE_ID_MASK;
+	major = (firmware_id >> FIRMWARE_ID_MAJOR_OFFSET) & FIRMWARE_ID_MASK;
+	minor = (firmware_id >> FIRMWARE_ID_MINOR_OFFSET) & FIRMWARE_ID_MASK;
+	patch = (firmware_id >> FIRMWARE_ID_PATCH_OFFSET) & FIRMWARE_ID_MASK;
+
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_dbg(fpga->dev, "unsupported FPGA FW v%u.%u.%u build 0x%02x",
+			major, minor, patch, build);
+
+		return -ENODEV;
+	}
+
+	dev_info(fpga->dev, "compatible FPGA FW v%u.%u.%u build 0x%02x",
+		 major, minor, patch, build);
+
+	return 0;
+}
+
+void upboard_led_gpio_init(struct upboard_fpga *fpga)
+{
+	struct gpio_led blue_led, yellow_led, green_led, red_led;
+	struct gpio_desc *desc;
+	int blue_gpio = -1, yellow_gpio = -1, green_gpio = -1, red_gpio = -1, leds = 0;
+
+	desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		blue_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		yellow_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		green_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		red_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	if (leds == 0)	//no leds
+		return;
+
+	static struct gpio_led upboard_gpio_leds[8];
+
+	leds = 0;
+	if (blue_gpio > -1) {
+		blue_led.name = "upboard:blue:";
+		blue_led.gpio = blue_gpio;
+		blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = blue_led;
+	}
+	if (yellow_gpio > -1) {
+		yellow_led.name = "upboard:yellow:";
+		yellow_led.gpio = yellow_gpio;
+		yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = yellow_led;
+	}
+	if (green_gpio > -1) {
+		green_led.name = "upboard:green:";
+		green_led.gpio = green_gpio;
+		green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = green_led;
+	}
+	if (red_gpio > -1) {
+		red_led.name = "upboard:red:";
+		red_led.gpio = red_gpio;
+		red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = red_led;
+	}
+
+	static struct gpio_led_platform_data upboard_gpio_led_platform_data;
+
+	upboard_gpio_led_platform_data.num_leds = leds;
+	upboard_gpio_led_platform_data.leds = upboard_gpio_leds;
+
+	static const struct mfd_cell upboard_gpio_led_cells[] = {
+		{
+			.name = "leds-gpio",
+			.id = 0,
+			.platform_data = &upboard_gpio_led_platform_data,
+			.pdata_size = sizeof(upboard_gpio_led_platform_data),
+		},
+	};
+
+	if (devm_mfd_add_devices(fpga->dev, UPBOARD_DEVID,
+				 upboard_gpio_led_cells,
+				 ARRAY_SIZE(upboard_gpio_led_cells),
+				 NULL, 0, NULL)) {
+		dev_info(fpga->dev, "Failed to add GPIO leds");
+	}
+}
+
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0000", (kernel_ulong_t)&upboard_pinctrl_data },
+	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
+	{ "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
+	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
+	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+static const struct dmi_system_id upboard_dmi_table[] __initconst = {
+	{
+		.matches = { /* UP */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-CHT01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_UNINITIALISED,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.3"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_UNINITIALISED |
+			UPFPGA_QUIRK_HRV1_IS_PROTO2),
+	},
+	{
+		.matches = { /* UP2 Pro*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP APL03 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_HRV1_IS_PROTO2 |
+			UPFPGA_QUIRK_GPIO_LED),
+	},
+	{
+		.matches = { /* UP Xtreme */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.1"),
+		},
+	},
+	{
+		.matches = { /* UP Xtreme i11 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-TGL01"),
+		},
+	},
+	{
+		.matches = { /* UP Xtreme i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-ADLP01"),
+		},
+	},
+	{
+		.matches = { /* UP Squared 6000*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-EHL01"),
+		},
+	},
+	{
+		.matches = { /* UPS 6000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-EHL01"),
+		},
+	},
+	{ },
+};
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga *fpga;
+	const struct acpi_device_id *id;
+	const struct upboard_fpga_data *fpga_data;
+	const struct dmi_system_id *system_id;
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long hrv;
+	unsigned long quirks = 0;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&pdev->dev, "failed to get PCTL revision");
+		//return -ENODEV;
+	}
+
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		quirks = (unsigned long)system_id->driver_data;
+
+	if (hrv == UPFPGA_PROTOCOL_V1_HRV &&
+	    (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))
+		hrv = UPFPGA_PROTOCOL_V2_HRV;
+
+	if (hrv != UPFPGA_PROTOCOL_V2_HRV) {
+		dev_info(&pdev->dev, "unsupported PCTL revision: %llu", hrv);
+		//return -ENODEV;
+	}
+
+	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
+
+	fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
+	if (!fpga)
+		return -ENOMEM;
+
+	if (quirks & UPFPGA_QUIRK_UNINITIALISED) {
+		dev_info(&pdev->dev, "FPGA not initialised by this BIOS");
+		fpga->uninitialised = true;
+	}
+
+	dev_set_drvdata(&pdev->dev, fpga);
+	fpga->dev = &pdev->dev;
+	fpga->regmap = devm_regmap_init(&pdev->dev, NULL,
+					fpga, fpga_data->regmapconf);
+	fpga->regmapconf = fpga_data->regmapconf;
+
+	if (IS_ERR(fpga->regmap))
+		return PTR_ERR(fpga->regmap);
+
+	ret = upboard_fpga_gpio_init(fpga);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to initialize FPGA common GPIOs: %d", ret);
+		//return ret;	//ignore fpga error
+	} else {
+		ret = upboard_fpga_detect_firmware(fpga);
+		//if (ret)
+		//	return ret;	//ignore fpga error
+	}
+
+	//gpio leds initialize
+	upboard_led_gpio_init(fpga);
+
+	if (quirks & UPFPGA_QUIRK_GPIO_LED) {
+		ret =  devm_mfd_add_devices(&pdev->dev, UPBOARD_DEVID,
+					    upboard_gpio_led_cells,
+					    ARRAY_SIZE(upboard_gpio_led_cells),
+					    NULL, 0, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add GPIO leds");
+			return ret;
+		}
+	}
+	return devm_mfd_add_devices(&pdev->dev, UPBOARD_DEVID,
+				    fpga_data->cells,
+				    fpga_data->ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-fpga",
+		.acpi_match_table = upboard_fpga_acpi_match,
+	},
+};
+
+module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..ce0c822c4216
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board main platform driver and FPGA configuration support
+ *
+ * Copyright (c) 2021, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_FPGA_H
+#define __LINUX_MFD_UPBOARD_FPGA_H
+
+//fpga/EC protocol version
+#define UPFPGA_PROTOCOL_V1_HRV 1
+#define UPFPGA_PROTOCOL_V2_HRV 2
+
+#define UPFPGA_ADDRESS_SIZE  7
+#define UPFPGA_REGISTER_SIZE 16
+
+#define UPFPGA_READ_FLAG     (1 << UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID   = 0x10,
+	UPFPGA_REG_FIRMWARE_ID   = 0x11,
+	UPFPGA_REG_FUNC_EN0      = 0x20,
+	UPFPGA_REG_FUNC_EN1      = 0x21,
+	UPFPGA_REG_GPIO_EN0      = 0x30,
+	UPFPGA_REG_GPIO_EN1      = 0x31,
+	UPFPGA_REG_GPIO_EN2      = 0x32,
+	UPFPGA_REG_GPIO_DIR0     = 0x40,
+	UPFPGA_REG_GPIO_DIR1     = 0x41,
+	UPFPGA_REG_GPIO_DIR2     = 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct regmap_config *regmapconf;
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *clear_gpio;
+	struct gpio_desc *strobe_gpio;
+	struct gpio_desc *datain_gpio;
+	struct gpio_desc *dataout_gpio;
+	bool uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int bit;
+	const char *colour;
+};
+
+bool regmap_check_writeable(struct upboard_fpga *fpga, unsigned int reg);
+
+#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */
-- 
2.17.1

