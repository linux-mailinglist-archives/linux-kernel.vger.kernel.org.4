Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937CD6AB3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCFAnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 19:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:42:59 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4351F1738;
        Sun,  5 Mar 2023 16:42:55 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16313:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Mon, 06 Mar 2023 08:42:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 08:42:39 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 6 Mar 2023 08:42:39 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <lgirdwood@gmail.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/2] regulator: Add support for Richtek RT5739 voltage regulator
Date:   Mon, 6 Mar 2023 08:42:38 +0800
Message-ID: <1678063358-18128-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678063358-18128-1-git-send-email-cy_huang@richtek.com>
References: <1678063358-18128-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The RT5739 is a step-down switching voltage regulator that supports
output voltage ragne from 300mV to 1300mV with the wide input supply
voltage range from 2.5V to 5.5V.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig  |  13 ++
 drivers/regulator/Makefile |   1 +
 drivers/regulator/rt5739.c | 290 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/regulator/rt5739.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0..f7f992c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1112,6 +1112,19 @@ config REGULATOR_RT5190A
 	  buck converters, 1 LDO, mute AC OFF depop function, with the general
 	  I2C control interface.
 
+config REGULATOR_RT5739
+	tristate "Rcihtek RT5739 Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This adds support for voltage regulator in Richtek RT5739.
+	  It's a step-down switching voltage regulator. Using a proprietary
+	  architecture with synchronous rectification, it is capable of
+	  delivering 3.5A continuously at over 80% efficiency.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rt5739.
+
 config REGULATOR_RT5759
 	tristate "Richtek RT5759 Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b9f5eb3..30a61fc 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT5120)	+= rt5120-regulator.o
 obj-$(CONFIG_REGULATOR_RT5190A) += rt5190a-regulator.o
+obj-$(CONFIG_REGULATOR_RT5739)	+= rt5739.o
 obj-$(CONFIG_REGULATOR_RT5759)	+= rt5759-regulator.o
 obj-$(CONFIG_REGULATOR_RT6160)	+= rt6160-regulator.o
 obj-$(CONFIG_REGULATOR_RT6190)	+= rt6190-regulator.o
diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
new file mode 100644
index 00000000..0a9e102
--- /dev/null
+++ b/drivers/regulator/rt5739.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device driver for RT5739 regulator
+ *
+ * Copyright (C) 2023 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define RT5739_AUTO_MODE	0
+#define RT5739_FPWM_MODE	1
+
+#define RT5739_REG_NSEL0	0x00
+#define RT5739_REG_NSEL1	0x01
+#define RT5739_REG_CNTL1	0x02
+#define RT5739_REG_ID1		0x03
+#define RT5739_REG_CNTL2	0x06
+#define RT5739_REG_CNTL4	0x08
+
+#define RT5739_VSEL_MASK	GENMASK(7, 0)
+#define RT5739_MODEVSEL1_MASK	BIT(1)
+#define RT5739_MODEVSEL0_MASK	BIT(0)
+#define RT5739_VID_MASK		GENMASK(7, 5)
+#define RT5739_ACTD_MASK	BIT(7)
+#define RT5739_ENVSEL1_MASK	BIT(1)
+#define RT5739_ENVSEL0_MASK	BIT(0)
+
+#define RT5739_VOLT_MINUV	300000
+#define RT5739_VOLT_MAXUV	1300000
+#define RT5739_VOLT_STPUV	5000
+#define RT5739_N_VOLTS		201
+#define RT5739_I2CRDY_TIMEUS	1000
+
+static int rt5739_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mask, val;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		mask = RT5739_MODEVSEL0_MASK;
+	else
+		mask = RT5739_MODEVSEL1_MASK;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = mask;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, RT5739_REG_CNTL1, mask, val);
+}
+
+static unsigned int rt5739_get_mode(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mask, val;
+	int ret;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		mask = RT5739_MODEVSEL0_MASK;
+	else
+		mask = RT5739_MODEVSEL1_MASK;
+
+	ret = regmap_read(regmap, RT5739_REG_CNTL1, &val);
+	if (ret)
+		return REGULATOR_MODE_INVALID;
+
+	if (val & mask)
+		return REGULATOR_MODE_FAST;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int rt5739_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg, vsel;
+
+	if (uV < RT5739_VOLT_MINUV || uV > RT5739_VOLT_MAXUV)
+		return -EINVAL;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		reg = RT5739_REG_NSEL1;
+	else
+		reg = RT5739_REG_NSEL0;
+
+	vsel = (uV - RT5739_VOLT_MINUV) / RT5739_VOLT_STPUV;
+	return regmap_write(regmap, reg, vsel);
+}
+
+static int rt5739_set_suspend_enable(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mask;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		mask = RT5739_ENVSEL1_MASK;
+	else
+		mask = RT5739_ENVSEL0_MASK;
+
+	return regmap_update_bits(regmap, desc->enable_reg, mask, mask);
+}
+
+static int rt5739_set_suspend_disable(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mask;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		mask = RT5739_ENVSEL1_MASK;
+	else
+		mask = RT5739_ENVSEL0_MASK;
+
+	return regmap_update_bits(regmap, desc->enable_reg, mask, 0);
+}
+
+static int rt5739_set_suspend_mode(struct regulator_dev *rdev,
+				   unsigned int mode)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mask, val;
+
+	if (desc->vsel_reg == RT5739_REG_NSEL0)
+		mask = RT5739_MODEVSEL1_MASK;
+	else
+		mask = RT5739_MODEVSEL0_MASK;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = mask;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, RT5739_REG_CNTL1, mask, val);
+}
+
+static const struct regulator_ops rt5739_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.enable	= regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_mode = rt5739_set_mode,
+	.get_mode = rt5739_get_mode,
+	.set_suspend_voltage = rt5739_set_suspend_voltage,
+	.set_suspend_enable = rt5739_set_suspend_enable,
+	.set_suspend_disable = rt5739_set_suspend_disable,
+	.set_suspend_mode = rt5739_set_suspend_mode,
+};
+
+static unsigned int rt5739_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RT5739_AUTO_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RT5739_FPWM_MODE:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static void rt5739_init_regulator_desc(struct regulator_desc *desc,
+				       bool vsel_active_high)
+{
+	/* Fixed */
+	desc->name = "rt5739-regulator";
+	desc->owner = THIS_MODULE;
+	desc->ops = &rt5739_regulator_ops;
+	desc->n_voltages = RT5739_N_VOLTS;
+	desc->min_uV = RT5739_VOLT_MINUV;
+	desc->uV_step = RT5739_VOLT_STPUV;
+	desc->vsel_mask = RT5739_VSEL_MASK;
+	desc->enable_reg = RT5739_REG_CNTL2;
+	desc->active_discharge_reg = RT5739_REG_CNTL1;
+	desc->active_discharge_mask = RT5739_ACTD_MASK;
+	desc->active_discharge_on = RT5739_ACTD_MASK;
+	desc->of_map_mode = rt5739_of_map_mode;
+
+	/* Assigned by vsel level */
+	if (vsel_active_high) {
+		desc->vsel_reg = RT5739_REG_NSEL1;
+		desc->enable_mask = RT5739_ENVSEL1_MASK;
+	} else {
+		desc->vsel_reg = RT5739_REG_NSEL0;
+		desc->enable_mask = RT5739_ENVSEL0_MASK;
+	}
+}
+
+static const struct regmap_config rt5739_regmap_config = {
+	.name = "rt5739",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT5739_REG_CNTL4,
+};
+
+static int rt5739_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regulator_desc *desc;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
+	bool vsel_acth;
+	unsigned int vid;
+	int ret;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(enable_gpio), "Failed to get 'enable' gpio\n");
+	else if (enable_gpio)
+		usleep_range(RT5739_I2CRDY_TIMEUS, RT5739_I2CRDY_TIMEUS + 1000);
+
+	regmap = devm_regmap_init_i2c(i2c, &rt5739_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	ret = regmap_read(regmap, RT5739_REG_ID1, &vid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read VID\n");
+
+	/* RT5739: (VID & MASK) must be 0 */
+	if (vid & RT5739_VID_MASK)
+		return dev_err_probe(dev, -ENODEV, "Incorrect VID (0x%02x)\n", vid);
+
+	vsel_acth = device_property_read_bool(dev, "richtek,vsel-active-high");
+
+	rt5739_init_regulator_desc(desc, vsel_acth);
+
+	cfg.dev = dev;
+	cfg.of_node = dev_of_node(dev);
+	cfg.init_data = of_get_regulator_init_data(dev, dev_of_node(dev), desc);
+	rdev = devm_regulator_register(dev, desc, &cfg);
+	if (IS_ERR(rdev))
+		return dev_err_probe(dev, PTR_ERR(rdev), "Failed to register regulator\n");
+
+	return 0;
+}
+
+static const struct of_device_id rt5739_device_table[] = {
+	{ .compatible = "richtek,rt5739" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rt5739_device_table);
+
+static struct i2c_driver rt5739_driver = {
+	.driver = {
+		.name = "rt5739",
+		.of_match_table = rt5739_device_table,
+	},
+	.probe_new = rt5739_probe,
+};
+module_i2c_driver(rt5739_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT5739 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

