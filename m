Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042F76F6793
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjEDIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:33:36 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5949D1;
        Thu,  4 May 2023 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683189083;
  x=1714725083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+1mD+2G/YQf+1sysUFKbadN741GOKVAcFB3DDi0P978=;
  b=I/YyRhyJGLpTzXIE5Eq8ILvVjFRGIC0GxiLJ7RbnS+pcIMRAejbwisIS
   kmi921/5BUUgf2BU/Mk3cUKZ8DjUAtw+lTO5uHDQ++RtWEhuSH2GK+Qh+
   IjftYrGoKpsa4RFjsRJZLiyr5kEWZk0pKoYchhAYE8IiKffALNGEfLq7/
   3j28T0apWt/QeFE8jS0WqdtU6PaPH/Refv1WHtM73aB7xPjVrgdL6ClAF
   NXQovhwGu1gfCfSByta7gIF/Ry74HYTZXylq/af6LEiqi+n2L8FCLa/R+
   eJRXdNyH1BN18lhxoLR5rl0yYmIjQ4agr6X2uAVgKYDrfTEa26KSrK0yG
   g==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 4 May 2023 10:30:27 +0200
Subject: [PATCH v2 2/2] regulator: Add support for TI TPS6287x regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
In-Reply-To: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683189034; l=9815;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=9aHD25qFdvOpdJ3aJnbh13Wp3O397F9k/dHxjJw1ekE=;
 b=uUspr+o0FcQli3o+2+Ekr7hx9P/n1mI4POKO8l4jgYOaavvHGoK+71ZSyBe14+8+nyBz9/nzY
 ItLornvWLzCAH785OYtbfVBKaTCuC+JWUBiI0KuULQS6mBjhdw+PH9A
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/regulator/tps6287x-regulator.c | 289 +++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)

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
index 000000000000..644549b6856e
--- /dev/null
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -0,0 +1,289 @@
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
+#define TPS6287X_VRANGE_DFLT	2
+#define TPS6287X_MIN_UV_DFLT	400000
+#define TPS6287X_MAX_UV_DFLT	1675000
+#define TPS6287X_STEP_UV_DFLT	5000
+
+struct tps6287x_chip {
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	unsigned int uv_step;
+};
+
+static const struct regmap_config tps6287x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPS6287X_STATUS,
+};
+
+/* min_uv, max_uv, uv_step */
+static const unsigned int tps6287x_voltage_table[][3] = {
+	{ 400000, 718750, 1250 },
+	{ 400000, 1037500, 2500 },
+	{ 400000, 1675000, 5000 },
+	{ 800000, 3350000, 10000 },
+};
+
+static const unsigned int tps6287x_ramp_table[] = {
+	10000, 5000, 1250, 500
+};
+
+static int tps6287x_get_voltage(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct tps6287x_chip *chip =
+	    i2c_get_clientdata(to_i2c_client(dev->parent));
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, TPS6287X_VSET, &val);
+	if (ret != 0)
+		return -ENOTRECOVERABLE;
+
+	return (val * chip->uv_step) + rdev->constraints->min_uV;
+}
+
+static int tps6287x_set_voltage(struct regulator_dev *rdev, int min_uv,
+				int max_uv, unsigned int *selector)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct tps6287x_chip *chip =
+	    i2c_get_clientdata(to_i2c_client(dev->parent));
+	int val = min_uv;
+
+	*selector = 0;
+
+	if (val < rdev->constraints->min_uV)
+		val = rdev->constraints->min_uV;
+	if (val > rdev->constraints->max_uV)
+		val = rdev->constraints->max_uV;
+
+	val -= rdev->constraints->min_uV;
+	val = DIV_ROUND_CLOSEST(val, chip->uv_step);
+
+	return regmap_write(rdev->regmap, TPS6287X_VSET, val);
+}
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
+	.get_voltage = tps6287x_get_voltage,
+	.set_voltage = tps6287x_set_voltage,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+};
+
+static struct regulator_desc tps6287x_reg = {
+	.name = "tps6287x",
+	.of_match = of_match_ptr("vout"),
+	.owner = THIS_MODULE,
+	.ops = &tps6287x_regulator_ops,
+	.of_map_mode = tps6287x_of_map_mode,
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.enable_reg = TPS6287X_CTRL1,
+	.enable_mask = TPS6287X_CTRL1_SWEN,
+	.ramp_reg = TPS6287X_CTRL1,
+	.ramp_mask = TPS6287X_CTRL1_VRAMP,
+	.ramp_delay_table = tps6287x_ramp_table,
+	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
+};
+
+static int tps6287x_setup_vrange(struct tps6287x_chip *chip)
+{
+	struct regulator_dev *rdev = chip->rdev;
+	unsigned int val, r;
+	bool found = false;
+	int ret;
+
+	/*
+	 * Match DT voltage range to one of the predefined ranges,
+	 * and configure the regulator with the selected range.
+	 */
+	for (r = 0; r < ARRAY_SIZE(tps6287x_voltage_table); r++) {
+		if (tps6287x_voltage_table[r][0] == rdev->constraints->min_uV &&
+		    tps6287x_voltage_table[r][1] == rdev->constraints->max_uV) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_warn(rdev_get_dev(rdev)->parent, "Missing or invalid voltage range. Using default.\n");
+		rdev->constraints->min_uV = TPS6287X_MIN_UV_DFLT;
+		rdev->constraints->max_uV = TPS6287X_MAX_UV_DFLT;
+		return 0;
+	}
+
+	if (r == TPS6287X_VRANGE_DFLT)
+		return 0;
+
+	ret = regmap_update_bits(chip->regmap, TPS6287X_CTRL2,
+				 TPS6287X_CTRL2_VRANGE,
+				 FIELD_PREP(TPS6287X_CTRL2_VRANGE, r));
+	if (ret < 0)
+		return ret;
+
+	chip->uv_step = tps6287x_voltage_table[r][2];
+
+	/*
+	 * When voltage range is changed the setpoint register must be cleared
+	 * and rewritten to make the regulator start using the new range.
+	 */
+	ret = regmap_read(rdev->regmap, TPS6287X_VSET, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = regmap_write(rdev->regmap, TPS6287X_VSET, 0);
+	if (ret != 0)
+		return ret;
+
+	return regmap_write(rdev->regmap, TPS6287X_VSET, val);
+}
+
+static int tps6287x_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regulator_config config = {};
+	struct tps6287x_chip *chip;
+	int ret;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->uv_step = TPS6287X_STEP_UV_DFLT;
+
+	chip->regmap = devm_regmap_init_i2c(i2c, &tps6287x_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		dev_err(dev, "Failed to init i2c\n");
+		return PTR_ERR(chip->regmap);
+	}
+
+	i2c_set_clientdata(i2c, chip);
+
+	config.dev = dev;
+	config.of_node = dev->of_node;
+	config.regmap = chip->regmap;
+
+	chip->rdev = devm_regulator_register(dev, &tps6287x_reg, &config);
+	if (IS_ERR(chip->rdev)) {
+		dev_err(dev, "Failed to register regulator\n");
+		return PTR_ERR(chip->rdev);
+	}
+
+	ret = tps6287x_setup_vrange(chip);
+	if (ret)
+		return ret;
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

