Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2760E676
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiJZR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:29:14 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C342E1011B0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:29:11 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 26 Oct 2022 20:29:06 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 29QHSxgY015430;
        Wed, 26 Oct 2022 13:28:59 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 29QHSx2W027361;
        Wed, 26 Oct 2022 13:28:59 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        bgolaszewski@baylibre.com, linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 2/2] Support NVIDIA BlueField-3 pinctrl driver
Date:   Wed, 26 Oct 2022 13:28:43 -0400
Message-Id: <20221026172843.27236-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20221026172843.27236-1-asmaa@nvidia.com>
References: <20221026172843.27236-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the BlueField-3 SoC pin controller.
It allows muxing individual GPIOs to switch from the default
hardware mode to software controlled mode.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/pinctrl/Kconfig         |   9 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 353 ++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f71fefff400f..caeef68cf51e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -512,6 +512,15 @@ config PINCTRL_ZYNQMP
 	  This driver can also be built as a module. If so, the module
 	  will be called pinctrl-zynqmp.
 
+config PINCTRL_MLXBF
+	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
+	select PINMUX
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	help
+	  This selects the pinctrl driver for BlueField-3 SoCs.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 89bfa01b5231..e4497078146e 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
+obj-$(CONFIG_PINCTRL_MLXBF)	+= pinctrl-mlxbf.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
diff --git a/drivers/pinctrl/pinctrl-mlxbf.c b/drivers/pinctrl/pinctrl-mlxbf.c
new file mode 100644
index 000000000000..6304a66f0290
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mlxbf.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+#include "core.h"
+
+#define MLXBF_GPIO0_FW_CONTROL_SET   0
+#define MLXBF_GPIO0_FW_CONTROL_CLEAR 0x14
+#define MLXBF_GPIO1_FW_CONTROL_SET   0x80
+#define MLXBF_GPIO1_FW_CONTROL_CLEAR 0x94
+
+#define MLXBF_NGPIOS_GPIO0    32
+
+enum {
+	MLXBF_GPIO_HW_MODE,
+	MLXBF_GPIO_SW_MODE
+};
+
+struct mlxbf_pinctrl {
+	void __iomem *base;
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_gpio_range gpio_range;
+};
+
+#define MLXBF_GPIO_RANGE(_id, _pinbase, _gpiobase, _npins)	\
+	{							\
+		.name = "mlxbf_gpio_range",			\
+		.id = _id,					\
+		.base = _gpiobase,				\
+		.pin_base = _pinbase,				\
+		.npins = _npins,				\
+	}
+
+static struct pinctrl_gpio_range mlxbf_pinctrl_gpio_ranges[] = {
+	MLXBF_GPIO_RANGE(0, 0,  480, 32),
+	MLXBF_GPIO_RANGE(1,  32, 456, 24),
+};
+
+static const struct pinctrl_pin_desc mlxbf_pins[] = {
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
+static const char * const mlxbf_pinctrl_single_group_names[] = {
+	"gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7", "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34",
+	"gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41",
+	"gpio42", "gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48",
+	"gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55"
+};
+
+/* Set of pin numbers for single-pin groups */
+static const unsigned int mlxbf_pinctrl_single_group_pins[] = {
+	0,  1,  2,  3,  4,  5,  6,
+	7,  8,  9, 10, 11, 12, 13,
+	14, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27,
+	28, 29, 30, 31, 32, 33, 34,
+	35, 36, 37, 38, 39, 40, 41,
+	42, 43, 44, 45, 46, 47, 48,
+	49, 50, 51, 52, 53, 54, 55,
+};
+
+static int mlxbf_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	/* Number single-pin groups */
+	return ARRAY_SIZE(mlxbf_pinctrl_single_group_pins);
+}
+
+static const char *mlxbf_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	return mlxbf_pinctrl_single_group_names[selector];
+}
+
+static int mlxbf_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	/* return the dummy group for a single pin */
+	*pins = &mlxbf_pinctrl_single_group_pins[selector];
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mlxbf_pinctrl_group_ops = {
+	.get_groups_count = mlxbf_get_groups_count,
+	.get_group_name = mlxbf_get_group_name,
+	.get_group_pins = mlxbf_get_group_pins,
+};
+
+static const char * const mlxbf_gpiofunc_group_names[] = { "swctrl" };
+static const char * const mlxbf_hwfunc_group_names[]   = { "hwctrl" };
+
+/*
+ * Only 2 functions are supported which apply to all pins:
+ * 1) Possible default hardware functionality
+ * 2) Software controlled GPIO
+ */
+static const struct {
+	const char *name;
+	const char * const *group_names;
+} mlxbf_pmx_funcs[] = {
+	{
+		.name = "hwfunc",
+		.group_names = mlxbf_hwfunc_group_names
+	},
+	{
+		.name = "gpiofunc",
+		.group_names = mlxbf_gpiofunc_group_names
+	},
+};
+
+static int mlxbf_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mlxbf_pmx_funcs);
+}
+
+static const char *mlxbf_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned int selector)
+{
+	return mlxbf_pmx_funcs[selector].name;
+}
+
+static int mlxbf_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = mlxbf_pmx_funcs[selector].group_names;
+	/* The function where "software has control over a GPIO" is available to all gpio pins */
+	*num_groups = ARRAY_SIZE(mlxbf_pinctrl_single_group_pins);
+
+	return 0;
+}
+
+static int mlxbf_pmx_set(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector == MLXBF_GPIO_HW_MODE) {
+		if (group < MLXBF_NGPIOS_GPIO0)
+			writel(BIT(group), priv->base + MLXBF_GPIO0_FW_CONTROL_CLEAR);
+		else
+			writel(BIT(group % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_CLEAR);
+	}
+
+	if (selector == MLXBF_GPIO_SW_MODE) {
+		if (group < MLXBF_NGPIOS_GPIO0)
+			writel(BIT(group), priv->base + MLXBF_GPIO0_FW_CONTROL_SET);
+		else
+			writel(BIT(group % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_SET);
+	}
+
+	return 0;
+}
+
+static int mlxbf_gpio_request_enable(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (offset < MLXBF_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->base + MLXBF_GPIO0_FW_CONTROL_SET);
+	else
+		writel(BIT(offset % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_SET);
+
+	return 0;
+}
+
+static void mlxbf_gpio_disable_free(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned int offset)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* disable GPIO functionality by giving control back to hardware */
+	if (offset < MLXBF_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->base + MLXBF_GPIO0_FW_CONTROL_CLEAR);
+	else
+		writel(BIT(offset % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_CLEAR);
+
+}
+
+static const struct pinmux_ops mlxbf_pmx_ops = {
+	.get_functions_count = mlxbf_pmx_get_funcs_count,
+	.get_function_name = mlxbf_pmx_get_func_name,
+	.get_function_groups = mlxbf_pmx_get_groups,
+	.set_mux = mlxbf_pmx_set,
+	.gpio_request_enable = mlxbf_gpio_request_enable,
+	.gpio_disable_free = mlxbf_gpio_disable_free,
+};
+
+static struct pinctrl_desc mlxbf_pin_desc = {
+	.name = "pinctrl-mlxbf",
+	.pins = mlxbf_pins,
+	.npins = ARRAY_SIZE(mlxbf_pins),
+	.pctlops = &mlxbf_pinctrl_group_ops,
+	.pmxops = &mlxbf_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static int mlxbf_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf_pinctrl *priv;
+	struct resource *res;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mlxbf_pinctrl_single_group_names) !=
+		     ARRAY_SIZE(mlxbf_pinctrl_single_group_pins));
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	priv->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!priv->base)
+		return -ENOMEM;
+
+	ret = devm_pinctrl_register_and_init(priv->dev,
+					     &mlxbf_pin_desc,
+					     priv,
+					     &priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed pinctrl register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed to enable pinctrl (%d)\n", ret);
+		return ret;
+	}
+
+	pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[0]);
+	pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[1]);
+
+	return 0;
+}
+
+static const struct acpi_device_id mlxbf_pinctrl_acpi_ids[] = {
+	{ "MLNXBF34", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf_pinctrl_acpi_ids);
+
+static struct platform_driver mlxbf_pinctrl_driver = {
+	.driver = {
+		.name = "pinctrl-mlxbf",
+		.acpi_match_table = mlxbf_pinctrl_acpi_ids,
+	},
+	.probe = mlxbf_pinctrl_probe,
+};
+
+module_platform_driver(mlxbf_pinctrl_driver);
+
+MODULE_DESCRIPTION("NVIDIA pinctrl driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

