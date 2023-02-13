Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B5694BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBMQAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjBMQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:00:18 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB91C5B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:00:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D720BFC15;
        Mon, 13 Feb 2023 17:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676304005; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=hUmCZGE2wb9knP0v6NH5JhHMF782alLAiH/tuWKzmDI=;
        b=CA2KQRUaBqNL3lxReuQirhcBjLTKO4rM3/huFqcxhar9gVyheiCLb+3i//IttMumrfJtqy
        tB0oCBpnSetCEqlQ3i/Y36KbHYo93Uwx0V4TlQh57MRgCK2DP/XHkobUVftj83QCcqa5bm
        spg+7uyL4fI7No4HAH/iavXn3MWSFSI8+XdoWlPqwKPc5Bxa5ddj1ru1Ugogt/YW8KApfR
        J03OQf+8zlEbbiiO4dfzTTuHZ3R8duWPvFe2Gk27Ma4KgUfClLW4Ykfka8nC8a/1vmdtxh
        8DuL9b0jS7rFZyZ0s86ErGXorNcUCdC0IfQgtxovX0sRjG/nbgjbcL2kGIDwrQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 5/6] regulator: pca9450: Fix control register for LDO5
Date:   Mon, 13 Feb 2023 16:58:23 +0100
Message-Id: <20230213155833.1644366-6-frieder@fris.de>
In-Reply-To: <20230213155833.1644366-1-frieder@fris.de>
References: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

For LDO5 we need to be able to check the status of the SD_VSEL input in
order to know which control register is used. Read the status of the
SD_VSEL signal via GPIO and add a get_reg_voltage_sel operation for
LDO5 that returns the register that is currently in use to the core.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 45 ++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 804a22c0e376..a0802c6cb259 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -32,6 +33,7 @@ struct pca9450_regulator_desc {
 struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -55,6 +57,16 @@ static const struct regmap_config pca9450_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static unsigned int pca9450_ldo5_get_reg_voltage_sel(struct regulator_dev *rdev)
+{
+	struct pca9450 *pca9450 = rdev_get_drvdata(rdev);
+
+	if (pca9450->sd_vsel_gpio && !gpiod_get_value(pca9450->sd_vsel_gpio))
+		return PCA9450_REG_LDO5CTRL_L;
+
+	return PCA9450_REG_LDO5CTRL_H;
+}
+
 /*
  * BUCK1/2/3
  * BUCK1RAM[1:0] BUCK1 DVS ramp rate setting
@@ -97,6 +109,16 @@ static const struct regulator_ops pca9450_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
+static const struct regulator_ops pca9450_ldo5_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_reg_voltage_sel = pca9450_ldo5_get_reg_voltage_sel,
+};
+
 /*
  * BUCK1/2/3
  * 0.60 to 2.1875V (12.5mV step)
@@ -438,12 +460,11 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO5,
-			.ops = &pca9450_ldo_regulator_ops,
+			.ops = &pca9450_ldo5_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
 			.linear_ranges = pca9450_ldo5_volts,
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
-			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
 			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
@@ -647,12 +668,11 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO5,
-			.ops = &pca9450_ldo_regulator_ops,
+			.ops = &pca9450_ldo5_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
 			.linear_ranges = pca9450_ldo5_volts,
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
-			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
 			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
@@ -705,6 +725,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 				      of_device_get_match_data(&i2c->dev);
 	const struct pca9450_regulator_desc	*regulator_desc;
 	struct regulator_config config = { };
+	struct regulator_dev *ldo5;
 	struct pca9450 *pca9450;
 	unsigned int device_id, i;
 	unsigned int reset_ctrl;
@@ -770,6 +791,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 		config.regmap = pca9450->regmap;
 		config.dev = pca9450->dev;
+		config.driver_data = pca9450;
 
 		rdev = devm_regulator_register(pca9450->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -779,6 +801,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 				desc->name, ret);
 			return ret;
 		}
+
+		if (!strcmp(desc->name, "ldo5"))
+			ldo5 = rdev;
 	}
 
 	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
@@ -832,6 +857,18 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
+	/*
+	 * For LDO5 we need to be able to check the status of the SD_VSEL input in
+	 * order to know which control register is used. Most boards connect SD_VSEL
+	 * to the VSELECT signal, so we can use the GPIO that is internally routed
+	 * to this signal (if SION bit is set in IOMUX).
+	 */
+	pca9450->sd_vsel_gpio = gpiod_get_optional(&ldo5->dev, "sd-vsel", GPIOD_IN);
+	if (IS_ERR(pca9450->sd_vsel_gpio)) {
+		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
+		return ret;
+	}
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
-- 
2.39.1

