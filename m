Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48CF6CCF12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjC2An4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2Anz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:43:55 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83C3E210D;
        Tue, 28 Mar 2023 17:43:49 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(26679:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 29 Mar 2023 08:43:28 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 29 Mar
 2023 08:43:28 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 29 Mar 2023 08:43:28 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <lgirdwood@gmail.com>, <cy_huang@richtek.com>,
        <jeff_chang@richtek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] regulator: Add Richtek RT4803 boost regulator
Date:   Wed, 29 Mar 2023 08:43:26 +0800
Message-ID: <1680050606-461-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680050606-461-1-git-send-email-cy_huang@richtek.com>
References: <1680050606-461-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

RT4803 is a boost converter that integrates an internal bypass FET. It
will automatically transform the operation mode between bypass and boost
based on the voltage difference of the input and output voltage.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig  |  10 +++
 drivers/regulator/Makefile |   1 +
 drivers/regulator/rt4803.c | 216 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/regulator/rt4803.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index aae28d0..fd9a29c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1082,6 +1082,16 @@ config REGULATOR_RT4801
 	  This adds support for voltage regulators in Richtek RT4801 Display Bias IC.
 	  The device supports two regulators (DSVP/DSVN).
 
+config REGULATOR_RT4803
+	tristate "Richtek RT4803 boost regualtor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This adds support for RT4803 boost converter that integrates the
+	  bypass switch. If the input voltage is low than the required voltage,
+	  RT4803 will enter boost mode. Otherwise, enable internal bypass
+	  switch to enter bypass mode.
+
 config REGULATOR_RT4831
 	tristate "Richtek RT4831 DSV Regulators"
 	depends on MFD_RT4831
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index ee383d8..163b599 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
 obj-$(CONFIG_REGULATOR_RT4801)	+= rt4801-regulator.o
+obj-$(CONFIG_REGULATOR_RT4803)	+= rt4803.o
 obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT5120)	+= rt5120-regulator.o
diff --git a/drivers/regulator/rt4803.c b/drivers/regulator/rt4803.c
new file mode 100644
index 00000000..c96fb02
--- /dev/null
+++ b/drivers/regulator/rt4803.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define RT4803_AUTO_MODE	1
+#define RT4803_FPWM_MODE	2
+
+#define RT4803_REG_CONFIG	0x01
+#define RT4803_REG_VSELL	0x02
+#define RT4803_REG_VSELH	0x03
+#define RT4803_REG_ILIM		0x04
+#define RT4803_REG_STAT		0x05
+
+#define RT4803_MODE_MASK	GENMASK(1, 0)
+#define RT4803_VSEL_MASK	GENMASK(4, 0)
+#define RT4803_ILIM_MASK	GENMASK(3, 0)
+#define RT4803_TSD_MASK		BIT(7)
+#define RT4803_HOTDIE_MASK	BIT(6)
+#define RT4803_FAULT_MASK	BIT(1)
+#define RT4803_PGOOD_MASK	BIT(0)
+
+#define RT4803_VOUT_MINUV	2850000
+#define RT4803_VOUT_STEPUV	50000
+#define RT4803_VOUT_NUM		32
+
+static int rt4803_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int modeval;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		modeval = RT4803_AUTO_MODE;
+		break;
+	case REGULATOR_MODE_FAST:
+		modeval = RT4803_FPWM_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	modeval <<= ffs(RT4803_MODE_MASK) - 1;
+
+	return regmap_update_bits(regmap, RT4803_REG_CONFIG, RT4803_MODE_MASK, modeval);
+}
+
+static unsigned int rt4803_get_mode(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int modeval;
+	int ret;
+
+	ret = regmap_read(regmap, RT4803_REG_CONFIG, &modeval);
+	if (ret)
+		return REGULATOR_MODE_INVALID;
+
+	modeval >>= ffs(RT4803_MODE_MASK) - 1;
+
+	switch (modeval) {
+	case RT4803_AUTO_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RT4803_FPWM_MODE:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int rt4803_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int state, events = 0;
+	int ret;
+
+	ret = regmap_read(regmap, RT4803_REG_STAT, &state);
+	if (ret)
+		return ret;
+
+	if (state & RT4803_PGOOD_MASK)
+		goto out_error_flag;
+
+	if (state & RT4803_FAULT_MASK)
+		events |= REGULATOR_ERROR_FAIL;
+
+	if (state & RT4803_HOTDIE_MASK)
+		events |= REGULATOR_ERROR_OVER_TEMP_WARN;
+
+	if (state & RT4803_TSD_MASK)
+		events |= REGULATOR_ERROR_OVER_TEMP;
+
+out_error_flag:
+	*flags = events;
+	return 0;
+}
+
+static int rt4803_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg, vsel;
+
+	if (rdev->desc->vsel_reg == RT4803_REG_VSELL)
+		reg = RT4803_REG_VSELH;
+	else
+		reg = RT4803_REG_VSELL;
+
+	vsel = (uV - rdev->desc->min_uV) / rdev->desc->uV_step;
+	vsel <<= ffs(RT4803_VSEL_MASK) - 1;
+
+	return regmap_update_bits(regmap, reg, RT4803_VSEL_MASK, vsel);
+}
+
+static const struct regulator_ops rt4803_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_mode = rt4803_set_mode,
+	.get_mode = rt4803_get_mode,
+	.get_error_flags = rt4803_get_error_flags,
+	.set_suspend_voltage = rt4803_set_suspend_voltage,
+};
+
+static unsigned int rt4803_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RT4803_AUTO_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RT4803_FPWM_MODE:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static const struct regmap_config rt4803_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT4803_REG_STAT,
+};
+
+static int rt4803_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	struct regulator_desc *desc;
+	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
+	bool vsel_act_high;
+	int ret;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(i2c, &rt4803_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	/* Always configure the input current limit to max 5A at initial */
+	ret = regmap_update_bits(regmap, RT4803_REG_ILIM, RT4803_ILIM_MASK, 0xff);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to config ILIM to max\n");
+
+	vsel_act_high = device_property_read_bool(dev, "richtek,vsel-active-high");
+
+	desc->name = "rt4803-regulator";
+	desc->type = REGULATOR_VOLTAGE;
+	desc->owner = THIS_MODULE;
+	desc->ops = &rt4803_regulator_ops;
+	desc->min_uV = RT4803_VOUT_MINUV;
+	desc->uV_step = RT4803_VOUT_STEPUV;
+	desc->n_voltages = RT4803_VOUT_NUM;
+	desc->vsel_mask = RT4803_VSEL_MASK;
+	desc->of_map_mode = rt4803_of_map_mode;
+	if (vsel_act_high)
+		desc->vsel_reg = RT4803_REG_VSELH;
+	else
+		desc->vsel_reg = RT4803_REG_VSELL;
+
+	cfg.dev = dev;
+	cfg.of_node = dev_of_node(dev);
+	cfg.init_data = of_get_regulator_init_data(dev, dev_of_node(dev), desc);
+
+	rdev = devm_regulator_register(dev, desc, &cfg);
+	return PTR_ERR_OR_ZERO(rdev);
+}
+
+static const struct of_device_id rt4803_device_match_table[] = {
+	{ .compatible = "richtek,rt4803" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt4803_device_match_table);
+
+static struct i2c_driver rt4803_driver = {
+	.driver = {
+		.name = "rt4803",
+		.of_match_table = rt4803_device_match_table,
+	},
+	.probe = rt4803_probe,
+};
+module_i2c_driver(rt4803_driver);
+
+MODULE_DESCRIPTION("Richtek RT4803 voltage regulator driver");
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

