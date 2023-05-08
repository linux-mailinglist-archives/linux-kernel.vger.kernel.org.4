Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7C6FB10A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjEHNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:14:31 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A221FF3;
        Mon,  8 May 2023 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683551671;
  x=1715087671;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=31oPLS+7Hgm9X/Zm9Z+o/iZmWh0uhAjmSuXoswXLrTA=;
  b=a1s/M2JepKMlXJOhpyOMReaqpFkRq6ibF5rdJ+r9pTw+oSErfK/7H/Sb
   qjp47JIpI8XMoEHLfwmHZIAW+UI8083hfv4Wv62GyVJhb58fWec3QVb4g
   DX+erFxaxOI50TYY5CKVFD5H48Hh5BGPZRhudYHN6detL7czyY7IkHmn/
   Q9idedCclEfvz8LmzpGmvlUFKT8yQqyJgZ1Qw76swx1G60cvcZl7AqsFr
   vKJcWzXT9mtQsvMiuS95ESssi8wVD/m7WmY19f+NIbH2n2AHanh2rUbs1
   pcgIJDl5xno+krvNjyOxsQv7+apBdW+vccivnmCeoLvar/i5Iez2YveTz
   Q==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Mon, 8 May 2023 15:14:08 +0200
Subject: [PATCH v3 2/2] regulator: Add support for TI TPS6287x regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230502-tps6287x-driver-v3-2-e25140a023f5@axis.com>
References: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
In-Reply-To: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683551664; l=7321;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=Kt3klOUPvbJLgJuPw9rVm9s3RwJlYgoyV77lgGlarnE=;
 b=qrxS931JcHo1GxxCZ1ZPZeZJFKP+EOvwK2ZEQPDUWfvusWP2zvwzN+fYDBC/dkALei7UwHYWE
 EoYxbKpuXvVD1e3dcxO/3zu92pCc8L2c5ryfap/Ba5Gt6f47m/Ck75Q
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instruments TPS6287x, single-channel
synchronous step-down converters with four output voltage ranges.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/regulator/Kconfig              |  11 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/tps6287x-regulator.c | 188 +++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index aae28d0a489c..d7923ac53f53 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1374,6 +1374,17 @@ config REGULATOR_TPS6286X
 	  high-frequency synchronous step-down converters with an I2C
 	  interface.
 
+config REGULATOR_TPS6287X
+	tristate "TI TPS6287x Power Regulator"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  This driver supports TPS6287x voltage regulator chips. These are
+	  pin-to-pin high-frequency synchronous step-down dc-dc converters
+	  with an I2C interface.
+
+	  If built as a module it will be called tps6287x-regulator.
+
 config REGULATOR_TPS65023
 	tristate "TI TPS65023 Power regulators"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index ee383d8fc835..857995db3fa4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -161,6 +161,7 @@ obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6286X) += tps6286x-regulator.o
+obj-$(CONFIG_REGULATOR_TPS6287X) += tps6287x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6507X) += tps6507x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65086) += tps65086-regulator.o
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
new file mode 100644
index 000000000000..d7fc82175493
--- /dev/null
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Axis Communications AB
+ *
+ * Driver for Texas Instruments TPS6287x PMIC.
+ * Datasheet: https://www.ti.com/lit/ds/symlink/tps62873.pdf
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
+#include <linux/bitfield.h>
+#include <linux/linear_range.h>
+
+#define TPS6287X_VSET		0x00
+#define TPS6287X_CTRL1		0x01
+#define TPS6287X_CTRL1_VRAMP	GENMASK(1, 0)
+#define TPS6287X_CTRL1_FPWMEN	BIT(4)
+#define TPS6287X_CTRL1_SWEN	BIT(5)
+#define TPS6287X_CTRL2		0x02
+#define TPS6287X_CTRL2_VRANGE	GENMASK(3, 2)
+#define TPS6287X_CTRL3		0x03
+#define TPS6287X_STATUS		0x04
+
+static const struct regmap_config tps6287x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPS6287X_STATUS,
+};
+
+static const struct linear_range tps6287x_voltage_ranges[] = {
+	LINEAR_RANGE(400000, 0, 0xFF, 1250),
+	LINEAR_RANGE(400000, 0, 0xFF, 2500),
+	LINEAR_RANGE(400000, 0, 0xFF, 5000),
+	LINEAR_RANGE(800000, 0, 0xFF, 10000),
+};
+
+static const unsigned int tps6287x_voltage_range_sel[] = {
+	0x0, 0x4, 0x8, 0xC
+};
+
+static const unsigned int tps6287x_ramp_table[] = {
+	10000, 5000, 1250, 500
+};
+
+static int tps6287x_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	unsigned int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = TPS6287X_CTRL1_FPWMEN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, TPS6287X_CTRL1,
+				  TPS6287X_CTRL1_FPWMEN, val);
+}
+
+static unsigned int tps6287x_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, TPS6287X_CTRL1, &val);
+	if (ret < 0)
+		return 0;
+
+	return (val & TPS6287X_CTRL1_FPWMEN) ? REGULATOR_MODE_FAST :
+	    REGULATOR_MODE_NORMAL;
+}
+
+static unsigned int tps6287x_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+	case REGULATOR_MODE_FAST:
+		return mode;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static const struct regulator_ops tps6287x_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_mode = tps6287x_set_mode,
+	.get_mode = tps6287x_get_mode,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+};
+
+static struct regulator_desc tps6287x_reg = {
+	.name = "tps6287x",
+	.owner = THIS_MODULE,
+	.ops = &tps6287x_regulator_ops,
+	.of_map_mode = tps6287x_of_map_mode,
+	.type = REGULATOR_VOLTAGE,
+	.enable_reg = TPS6287X_CTRL1,
+	.enable_mask = TPS6287X_CTRL1_SWEN,
+	.vsel_reg = TPS6287X_VSET,
+	.vsel_mask = 0xFF,
+	.vsel_range_reg = TPS6287X_CTRL2,
+	.vsel_range_mask = TPS6287X_CTRL2_VRANGE,
+	.ramp_reg = TPS6287X_CTRL1,
+	.ramp_mask = TPS6287X_CTRL1_VRAMP,
+	.ramp_delay_table = tps6287x_ramp_table,
+	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
+	.linear_ranges = tps6287x_voltage_ranges,
+	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
+	.linear_range_selectors = tps6287x_voltage_range_sel,
+};
+
+static int tps6287x_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+
+	config.regmap = devm_regmap_init_i2c(i2c, &tps6287x_regmap_config);
+	if (IS_ERR(config.regmap)) {
+		dev_err(dev, "Failed to init i2c\n");
+		return PTR_ERR(config.regmap);
+	}
+
+	config.dev = dev;
+	config.of_node = dev->of_node;
+	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						      &tps6287x_reg);
+
+	rdev = devm_regulator_register(dev, &tps6287x_reg, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(dev, "Failed to register regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	dev_dbg(dev, "Probed regulator\n");
+
+	return 0;
+}
+
+static const struct of_device_id tps6287x_dt_ids[] = {
+	{ .compatible = "ti,tps62870", },
+	{ .compatible = "ti,tps62871", },
+	{ .compatible = "ti,tps62872", },
+	{ .compatible = "ti,tps62873", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, tps6287x_dt_ids);
+
+static const struct i2c_device_id tps6287x_i2c_id[] = {
+	{ "tps62870", 0 },
+	{ "tps62871", 0 },
+	{ "tps62872", 0 },
+	{ "tps62873", 0 },
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, tps6287x_i2c_id);
+
+static struct i2c_driver tps6287x_regulator_driver = {
+	.driver = {
+		.name = "tps6287x",
+		.of_match_table = tps6287x_dt_ids,
+	},
+	.probe_new = tps6287x_i2c_probe,
+	.id_table = tps6287x_i2c_id,
+};
+
+module_i2c_driver(tps6287x_regulator_driver);
+
+MODULE_AUTHOR("Mårten Lindahl <marten.lindahl@axis.com>");
+MODULE_DESCRIPTION("Regulator driver for TI TPS6287X PMIC");
+MODULE_LICENSE("GPL");

-- 
2.30.2

