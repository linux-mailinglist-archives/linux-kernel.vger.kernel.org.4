Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C476BA24E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCNWTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCNWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:18:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550F1CF5C;
        Tue, 14 Mar 2023 15:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyvC7D50P3lWHBPxPNfjaJrtdnOiBR/MTBtwn1l5IxRah3ciFrefOnuCZFszhE/DX629RUPKxkd7Th7rq6C8DiIk25ce098/VkzfFi8LQtu4a2eYsWmuO7u3jvtjyGst+BvfmKhxwpb9vNTFulHWd8X53z5YnlgXkGH4bJVupAAzVCfAgNCSr7aFv9TBClQzkkc22mQ7+cDAOINDlSoIxj8cicu7R+c1Otv6T//yqcC/U+ojlsNDaSh1mvN7nBUK500779BQwoxQy41KDrdtldw68OOSUsv5UkH/xs+rNPtGiXiqdfZx7RRiXmNegZN+p99PvRDE+aTYHElEVxENrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv0zALneV5hrsr8yHv+OpCWVtKAJcNRqG1MD/gKDWwk=;
 b=Z9fppDLA2jGNmch6jCpFaSW/OlUcYXezILAockHqw5GG1ihiqfs1xiGsstyHbzm/wxtrQSkNWpzlzQ1TIBxLK0YQ3FDXwm0AYQFr3dE+x4bm+9tvPas/juNBXG+LtOX2xvTBM3XHXN8mL0Fih5QQWVDdgUX97SkExP3f6byYGiQNd6VmD1OEjLL055S0aRx2tWjHeU+wPyGcBxG5Zrg/NhLHbBcKrLmAwPfrgwCaNRx+RxQhYx7zz0zZkIV19Xt+NQaOYoGM/f/cbxyZq2NFb5JtlfFdrWtBYd1CCLYyv/wGZTX8RDxHku/uDzjaVkV2HLF8vOv2SaZTdy0MJQm1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv0zALneV5hrsr8yHv+OpCWVtKAJcNRqG1MD/gKDWwk=;
 b=ZNoc2d0hlST5n/gdFKQ3Ro/73mq7IWESrA7UT3xKdNLUYR97Z/BI1CDZbLQ/LI/dM62bPY37JBi+0RXWu7dljbH23EF0Wd4PP3w81zNXL6a1dd4Qvbgc0/jXoWdyvFKhUvEUa/6+keOJT5wP9vjwWIfAF5UWp4Tw3SQ0jItIQmVKBILSDgw2+Z8VMA6A1kxRCFvUPt38XdSner/w4MuzZ8Vo8Yaif8YZmHarQPs92IV4YUFydKIuyKt1zHXAGCLG+1y1UKm/EDuaLQK+8+qKALsyvWl+/JX8jc556u9Jy9iLg9XVA17GyTDXhO3Kr/NgF5umt/9VUfFp4mrZVdBMOg==
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 22:16:29 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::4d) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 22:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Tue, 14 Mar 2023 22:16:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 14 Mar 2023
 15:16:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 14 Mar
 2023 15:16:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Tue, 14 Mar
 2023 15:16:20 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <niyas.sait@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
Date:   Tue, 14 Mar 2023 18:16:09 -0400
Message-ID: <20230314221609.22433-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230314221609.22433-1-asmaa@nvidia.com>
References: <20230314221609.22433-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 485a4045-07e0-4b02-c07f-08db24d9c289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlkweWPNY5VmpA/saexmF2etBakdE0948osilIdLq2g3/+YXO/TYDtH1Lp+GH7N+QrT6qNN8S4K1ADzSczuIZ1rwXmaS+lJFDrVmHciNkJzfrfXklE7q43/nOJkI+1cCnMQNa6gxrcrVj8piBUBgsCcas0l8reuWUI28/nrOL+o94zdZMAVcvhkIC8GUCIN5rnrJ4GY9cqhFlVXMQYdr9IRbrZRTUaB+EBPKjYfq9mIifX57fHueX+5JZDEzucVVgajvRYKhhw+zWXpagEVFC4d+gB72HDXaYPmFmG+btrRHxqbFLW1p77tCy2aQ7tEXKG+AbAMXsko53M7d47v509g/aShLP0VH/cJKxu0CqN+JU9aelATy+A758jTR1FVC8DgPTRpLznIzjhZVw0LIUvL8Jhf1sNPTUJaLsLo2CArN0oHwlhFYGzfYhZnzpCTWQ3XLG57FtpS40Ei8YKDXktqKHFbrBbY6tAnYydxFd8YJulA5rJcqEqh4o0fpywC/VRwTJQ+2jD39RsxGoQsSTFP0gJnCP1eQsPGjAQKs5EH0fCHBl5ayN4yNCnZyxm1yZfufBF08TqDKeiuQhLrDtJzx6LxtrYagDnCAK2JVJPaFvvj7uwNvY1Uk5e76MfE/i61OTcARrXdWQhjFxrT0Av5T1SU4f6CkHMSloY4HVS5H7gbPrpIeOuWEDM1xoKwuAcf78GJeTUYKGRzcyrJeyhwA8NbFjVzpHYjEsHwGaWysicq6gV6szMayS/7K86xt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(4326008)(336012)(8936002)(5660300002)(40460700003)(41300700001)(186003)(1076003)(26005)(36756003)(82310400005)(86362001)(2616005)(36860700001)(83380400001)(426003)(2906002)(70206006)(6666004)(8676002)(70586007)(30864003)(47076005)(316002)(478600001)(7696005)(356005)(40480700001)(107886003)(110136005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 22:16:29.1805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a4045-07e0-4b02-c07f-08db24d9c289
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
or take the default hardware functionality. Add a driver for
the pin muxing.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/pinctrl/Kconfig          |  13 ++
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-mlxbf3.c | 318 +++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7d5f5458c72e..9009bc6adbea 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -523,6 +523,19 @@ config PINCTRL_ZYNQMP
 	  This driver can also be built as a module. If so, the module
 	  will be called pinctrl-zynqmp.
 
+config PINCTRL_MLXBF3
+	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
+	depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
+	select PINMUX
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select GPIO_MLXBF3
+	help
+	  Say Y to select the pinctrl driver for BlueField-3 SoCs.
+	  This pin controller allows selecting the mux function for
+	  each pin. This driver can also be built as a module called
+	  pinctrl-mlxbf3.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..10dd072e8423 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
+obj-$(CONFIG_PINCTRL_MLXBF3)	+= pinctrl-mlxbf3.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
new file mode 100644
index 000000000000..19293eddc2e8
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define MLXBF3_NGPIOS_GPIO0    32
+#define MLXBF3_MAX_GPIO_PINS   56
+
+enum {
+	MLXBF3_GPIO_HW_MODE,
+	MLXBF3_GPIO_SW_MODE,
+};
+
+struct mlxbf3_pinctrl {
+	void __iomem *fw_ctrl_set0;
+	void __iomem *fw_ctrl_clr0;
+	void __iomem *fw_ctrl_set1;
+	void __iomem *fw_ctrl_clr1;
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_gpio_range gpio_range;
+};
+
+#define MLXBF3_GPIO_RANGE(_id, _pinbase, _gpiobase, _npins)	\
+	{							\
+		.name = "mlxbf3_gpio_range",			\
+		.id = _id,					\
+		.base = _gpiobase,				\
+		.pin_base = _pinbase,				\
+		.npins = _npins,				\
+	}
+
+static struct pinctrl_gpio_range mlxbf3_pinctrl_gpio_ranges[] = {
+	MLXBF3_GPIO_RANGE(0, 0,  480, 32),
+	MLXBF3_GPIO_RANGE(1,  32, 456, 24),
+};
+
+static const struct pinctrl_pin_desc mlxbf3_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+	PINCTRL_PIN(23, "gpio23"),
+	PINCTRL_PIN(24, "gpio24"),
+	PINCTRL_PIN(25, "gpio25"),
+	PINCTRL_PIN(26, "gpio26"),
+	PINCTRL_PIN(27, "gpio27"),
+	PINCTRL_PIN(28, "gpio28"),
+	PINCTRL_PIN(29, "gpio29"),
+	PINCTRL_PIN(30, "gpio30"),
+	PINCTRL_PIN(31, "gpio31"),
+	PINCTRL_PIN(32, "gpio32"),
+	PINCTRL_PIN(33, "gpio33"),
+	PINCTRL_PIN(34, "gpio34"),
+	PINCTRL_PIN(35, "gpio35"),
+	PINCTRL_PIN(36, "gpio36"),
+	PINCTRL_PIN(37, "gpio37"),
+	PINCTRL_PIN(38, "gpio38"),
+	PINCTRL_PIN(39, "gpio39"),
+	PINCTRL_PIN(40, "gpio40"),
+	PINCTRL_PIN(41, "gpio41"),
+	PINCTRL_PIN(42, "gpio42"),
+	PINCTRL_PIN(43, "gpio43"),
+	PINCTRL_PIN(44, "gpio44"),
+	PINCTRL_PIN(45, "gpio45"),
+	PINCTRL_PIN(46, "gpio46"),
+	PINCTRL_PIN(47, "gpio47"),
+	PINCTRL_PIN(48, "gpio48"),
+	PINCTRL_PIN(49, "gpio49"),
+	PINCTRL_PIN(50, "gpio50"),
+	PINCTRL_PIN(51, "gpio51"),
+	PINCTRL_PIN(52, "gpio52"),
+	PINCTRL_PIN(53, "gpio53"),
+	PINCTRL_PIN(54, "gpio54"),
+	PINCTRL_PIN(55, "gpio55"),
+};
+
+/*
+ * All single-pin functions can be mapped to any GPIO, however pinmux applies
+ * functions to pin groups and only those groups declared as supporting that
+ * function. To make this work we must put each pin in its own dummy group so
+ * that the functions can be described as applying to all pins.
+ * We use the same name as in the datasheet.
+ */
+static const char * const mlxbf3_pinctrl_single_group_names[] = {
+	"gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6", "gpio7",
+	"gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14", "gpio15",
+	"gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21", "gpio22", "gpio23",
+	"gpio24", "gpio25", "gpio26", "gpio27", "gpio28", "gpio29", "gpio30", "gpio31",
+	"gpio32", "gpio33", "gpio34", "gpio35", "gpio36", "gpio37", "gpio38", "gpio39",
+	"gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45", "gpio46", "gpio47",
+	"gpio48", "gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55"
+};
+
+static int mlxbf3_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	/* Number single-pin groups */
+	return MLXBF3_MAX_GPIO_PINS;
+}
+
+static const char *mlxbf3_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	return mlxbf3_pinctrl_single_group_names[selector];
+}
+
+static int mlxbf3_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	/* return the dummy group for a single pin */
+	*pins = &selector;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mlxbf3_pinctrl_group_ops = {
+	.get_groups_count = mlxbf3_get_groups_count,
+	.get_group_name = mlxbf3_get_group_name,
+	.get_group_pins = mlxbf3_get_group_pins,
+};
+
+/*
+ * Only 2 functions are supported and they apply to all pins:
+ * 1) Default hardware functionality
+ * 2) Software controlled GPIO
+ */
+static const char * const mlxbf3_gpiofunc_group_names[] = { "swctrl" };
+static const char * const mlxbf3_hwfunc_group_names[]   = { "hwctrl" };
+
+struct pinfunction mlxbf3_pmx_funcs[] = {
+	PINCTRL_PINFUNCTION("hwfunc", mlxbf3_hwfunc_group_names, 1),
+	PINCTRL_PINFUNCTION("gpiofunc", mlxbf3_gpiofunc_group_names, 1),
+};
+
+static int mlxbf3_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mlxbf3_pmx_funcs);
+}
+
+static const char *mlxbf3_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned int selector)
+{
+	return mlxbf3_pmx_funcs[selector].name;
+}
+
+static int mlxbf3_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = mlxbf3_pmx_funcs[selector].groups;
+	*num_groups = MLXBF3_MAX_GPIO_PINS;
+
+	return 0;
+}
+
+static int mlxbf3_pmx_set(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector == MLXBF3_GPIO_HW_MODE) {
+		if (group < MLXBF3_NGPIOS_GPIO0)
+			writel(BIT(group), priv->fw_ctrl_clr0);
+		else
+			writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
+	}
+
+	if (selector == MLXBF3_GPIO_SW_MODE) {
+		if (group < MLXBF3_NGPIOS_GPIO0)
+			writel(BIT(group), priv->fw_ctrl_set0);
+		else
+			writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_set1);
+	}
+
+	return 0;
+}
+
+static int mlxbf3_gpio_request_enable(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (offset < MLXBF3_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->fw_ctrl_set0);
+	else
+		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_set1);
+
+	return 0;
+}
+
+static void mlxbf3_gpio_disable_free(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned int offset)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* disable GPIO functionality by giving control back to hardware */
+	if (offset < MLXBF3_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->fw_ctrl_clr0);
+	else
+		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
+}
+
+static const struct pinmux_ops mlxbf3_pmx_ops = {
+	.get_functions_count = mlxbf3_pmx_get_funcs_count,
+	.get_function_name = mlxbf3_pmx_get_func_name,
+	.get_function_groups = mlxbf3_pmx_get_groups,
+	.set_mux = mlxbf3_pmx_set,
+	.gpio_request_enable = mlxbf3_gpio_request_enable,
+	.gpio_disable_free = mlxbf3_gpio_disable_free,
+};
+
+static struct pinctrl_desc mlxbf3_pin_desc = {
+	.name = "pinctrl-mlxbf3",
+	.pins = mlxbf3_pins,
+	.npins = ARRAY_SIZE(mlxbf3_pins),
+	.pctlops = &mlxbf3_pinctrl_group_ops,
+	.pmxops = &mlxbf3_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static_assert(ARRAY_SIZE(mlxbf3_pinctrl_single_group_names) == MLXBF3_MAX_GPIO_PINS);
+
+static int mlxbf3_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_pinctrl *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->fw_ctrl_set0 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_clr0 = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_set1 = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_clr1 = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	ret = devm_pinctrl_register_and_init(dev,
+					     &mlxbf3_pin_desc,
+					     priv,
+					     &priv->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pinctrl\n");
+
+	pinctrl_add_gpio_ranges(priv->pctl, mlxbf3_pinctrl_gpio_ranges, 2);
+
+	return 0;
+}
+
+static const struct acpi_device_id mlxbf3_pinctrl_acpi_ids[] = {
+	{ "MLNXBF34", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf3_pinctrl_acpi_ids);
+
+static struct platform_driver mlxbf3_pinctrl_driver = {
+	.driver = {
+		.name = "pinctrl-mlxbf3",
+		.acpi_match_table = mlxbf3_pinctrl_acpi_ids,
+	},
+	.probe = mlxbf3_pinctrl_probe,
+};
+module_platform_driver(mlxbf3_pinctrl_driver);
+
+MODULE_DESCRIPTION("NVIDIA pinctrl driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

