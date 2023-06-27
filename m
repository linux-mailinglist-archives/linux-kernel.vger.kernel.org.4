Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307D73F4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF0GyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjF0Gxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:53:40 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE91FC4;
        Mon, 26 Jun 2023 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687848818;
  x=1719384818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3v9/jaB/RSMjL45iMoGJXiNcFxdalOOruHtV+D4Q+SM=;
  b=L0hzNOXsMEv8PJbIYAKqC/wlhI3sgRIaTrVciitfT+/9veIFn4xNu+5s
   89H4koEH4jwJk6WGPARsDV31InrjcQQ5eYrrFnfRD5T+hDsSitP23OvgU
   0FUIyccNf+YMH/dR1jk4YgX1GBC6RW1hyiBVfuPFklgLZ1dy8I1m4LenY
   A4HWde7sPlCp3R7O7MCsDjFTFHi0FlF4xZnrftFFRjeBif4xWUOK2HX2r
   sdZL+JfQZbsGSPw7F3h+FhV/LEuTUrQevtu3g+LtDY8K2HaGW3dhocLg9
   J9wNh6sYpP3WKVnD+pBdjbX/FOG1usdjcnjsPtpukYy6UpDdD1tDNxqGJ
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 2/2] Input: cap11xx - add advanced sensitivity settings
Date:   Tue, 27 Jun 2023 08:53:16 +0200
Message-ID: <20230627065316.1065911-3-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627065316.1065911-1-jiriv@axis.com>
References: <20230627065316.1065911-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings that allows more precise
tunig of touch buttons. Input-treshold allows to set the sensitivity for
each channel separately. Also add signal guard feature for CAP129x chips.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 drivers/input/keyboard/cap11xx.c | 250 ++++++++++++++++++++++++-------
 1 file changed, 197 insertions(+), 53 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 040696d0e49c..5972415cc549 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
+#include <linux/bitfield.h>
 
 #define CAP11XX_REG_MAIN_CONTROL	0x00
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
@@ -24,6 +25,7 @@
 #define CAP11XX_REG_NOISE_FLAG_STATUS	0x0a
 #define CAP11XX_REG_SENOR_DELTA(X)	(0x10 + (X))
 #define CAP11XX_REG_SENSITIVITY_CONTROL	0x1f
+#define CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK	0x70
 #define CAP11XX_REG_CONFIG		0x20
 #define CAP11XX_REG_SENSOR_ENABLE	0x21
 #define CAP11XX_REG_SENSOR_CONFIG	0x22
@@ -32,6 +34,7 @@
 #define CAP11XX_REG_CALIBRATION		0x26
 #define CAP11XX_REG_INT_ENABLE		0x27
 #define CAP11XX_REG_REPEAT_RATE		0x28
+#define CAP11XX_REG_SIGNAL_GUARD_ENABLE	0x29
 #define CAP11XX_REG_MT_CONFIG		0x2a
 #define CAP11XX_REG_MT_PATTERN_CONFIG	0x2b
 #define CAP11XX_REG_MT_PATTERN		0x2d
@@ -47,6 +50,8 @@
 #define CAP11XX_REG_SENSOR_BASE_CNT(X)	(0x50 + (X))
 #define CAP11XX_REG_LED_POLARITY	0x73
 #define CAP11XX_REG_LED_OUTPUT_CONTROL	0x74
+#define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG	0x80
+#define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG2	0x81
 
 #define CAP11XX_REG_LED_DUTY_CYCLE_1	0x90
 #define CAP11XX_REG_LED_DUTY_CYCLE_2	0x91
@@ -78,12 +83,20 @@ struct cap11xx_led {
 
 struct cap11xx_priv {
 	struct regmap *regmap;
+	struct device *dev;
 	struct input_dev *idev;
+	const struct cap11xx_hw_model *model;
+	u8 id;
 
 	struct cap11xx_led *leds;
 	int num_leds;
 
 	/* config */
+	u8 analog_gain;
+	u8 sensitivity_delta_sense;
+	u8 signal_guard_inputs_mask;
+	u32 thresholds[8];
+	u32 calib_sensitivities[8];
 	u32 keycodes[];
 };
 
@@ -181,6 +194,178 @@ static const struct regmap_config cap11xx_regmap_config = {
 	.volatile_reg = cap11xx_volatile_reg,
 };
 
+static int
+cap11xx_write_calib_sens_config_1(struct cap11xx_priv *priv)
+{
+	return regmap_write(priv->regmap,
+			CAP11XX_REG_CALIB_SENSITIVITY_CONFIG,
+			(priv->calib_sensitivities[3] << 6) |
+			(priv->calib_sensitivities[2] << 4) |
+			(priv->calib_sensitivities[1] << 2) |
+			priv->calib_sensitivities[0]);
+}
+
+static int
+cap11xx_write_calib_sens_config_2(struct cap11xx_priv *priv)
+{
+	return regmap_write(priv->regmap,
+			CAP11XX_REG_CALIB_SENSITIVITY_CONFIG2,
+			(priv->calib_sensitivities[7] << 6) |
+			(priv->calib_sensitivities[6] << 4) |
+			(priv->calib_sensitivities[5] << 2) |
+			priv->calib_sensitivities[4]);
+}
+
+static int
+cap11xx_init_keys(struct cap11xx_priv *priv)
+{
+	struct device_node *node = priv->dev->of_node;
+	struct device *dev = priv->dev;
+	int i, error;
+	u32 u32_val;
+
+	if (!node) {
+		dev_err(dev, "Corresponding DT entry is not available\n");
+		return -ENODEV;
+	}
+
+	if (!of_property_read_u32(node, "microchip,sensor-gain", &u32_val)) {
+		if (priv->model->no_gain) {
+			dev_warn(dev,
+				 "This model doesn't support 'sensor-gain'\n");
+		} else if (is_power_of_2(u32_val) && u32_val <= 8) {
+			priv->analog_gain = (u8)ilog2(u32_val);
+
+			error = regmap_update_bits(priv->regmap,
+				CAP11XX_REG_MAIN_CONTROL,
+				CAP11XX_REG_MAIN_CONTROL_GAIN_MASK,
+				priv->analog_gain << CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT);
+			if (error)
+				return error;
+		} else {
+			dev_err(dev, "Invalid sensor-gain value %u\n", u32_val);
+			return -EINVAL;
+		}
+	}
+
+	if (of_property_read_bool(node, "microchip,irq-active-high")) {
+		if (priv->id == CAP1106 ||
+		    priv->id == CAP1126 ||
+		    priv->id == CAP1188) {
+			error = regmap_update_bits(priv->regmap,
+						   CAP11XX_REG_CONFIG2,
+						   CAP11XX_REG_CONFIG2_ALT_POL,
+						   0);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'irq-active-high'\n");
+		}
+	}
+
+	if (!of_property_read_u32(node,
+				  "microchip,sensitivity-delta-sense", &u32_val)) {
+		if (!is_power_of_2(u32_val) || u32_val > 128) {
+			dev_err(dev, "Invalid sensitivity-delta-sense value %u\n", u32_val);
+			return -EINVAL;
+		}
+
+		priv->sensitivity_delta_sense = (u8)ilog2(u32_val);
+		u32_val = ~(FIELD_PREP(CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK,
+					priv->sensitivity_delta_sense));
+
+		error = regmap_update_bits(priv->regmap,
+					   CAP11XX_REG_SENSITIVITY_CONTROL,
+					   CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK,
+					   u32_val);
+		if (error)
+			return error;
+	}
+
+	if (!of_property_read_u32_array(node, "microchip,input-treshold",
+					priv->thresholds, priv->model->num_channels)) {
+		for (i = 0; i < priv->model->num_channels; i++) {
+			if (priv->thresholds[i] > 127) {
+				dev_err(dev, "Invalid input-treshold value %u\n",
+					priv->thresholds[i]);
+				return -EINVAL;
+			}
+
+			error = regmap_write(priv->regmap,
+					     CAP11XX_REG_SENSOR_THRESH(i),
+					     priv->thresholds[i]);
+			if (error)
+				return error;
+		}
+	}
+
+	if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
+					priv->calib_sensitivities, priv->model->num_channels)) {
+		if (priv->id == CAP1293 || priv->id == CAP1298) {
+			for (i = 0; i < priv->model->num_channels; i++) {
+				if (!is_power_of_2(priv->calib_sensitivities[i]) ||
+				    priv->calib_sensitivities[i] > 4) {
+					dev_err(dev, "Invalid calib-sensitivity value %u\n",
+						priv->calib_sensitivities[i]);
+					return -EINVAL;
+				}
+				priv->calib_sensitivities[i] = ilog2(priv->calib_sensitivities[i]);
+			}
+
+			error = cap11xx_write_calib_sens_config_1(priv);
+			if (error)
+				return error;
+
+			if (priv->id == CAP1298) {
+				error = cap11xx_write_calib_sens_config_2(priv);
+				if (error)
+					return error;
+			}
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'calib-sensitivity'\n");
+		}
+	}
+
+	for (i = 0; i < priv->model->num_channels; i++) {
+		if (!of_property_read_u32_index(node, "microchip,signal-guard",
+						i, &u32_val)) {
+			if (u32_val > 1)
+				return -EINVAL;
+			if (u32_val)
+				priv->signal_guard_inputs_mask |= 0x01 << i;
+		}
+	}
+
+	if (priv->signal_guard_inputs_mask) {
+		if (priv->id == CAP1293 || priv->id == CAP1298) {
+			error = regmap_write(priv->regmap,
+					     CAP11XX_REG_SIGNAL_GUARD_ENABLE,
+					     priv->signal_guard_inputs_mask);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'signal-guard'\n");
+		}
+	}
+
+	/* Provide some useful defaults */
+	for (i = 0; i < priv->model->num_channels; i++)
+		priv->keycodes[i] = KEY_A + i;
+
+	of_property_read_u32_array(node, "linux,keycodes",
+				   priv->keycodes, priv->model->num_channels);
+
+	/* Disable autorepeat. The Linux input system has its own handling. */
+	error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 {
 	struct cap11xx_priv *priv = data;
@@ -332,11 +517,9 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c_client);
 	struct device *dev = &i2c_client->dev;
 	struct cap11xx_priv *priv;
-	struct device_node *node;
 	const struct cap11xx_hw_model *cap;
-	int i, error, irq, gain = 0;
+	int i, error;
 	unsigned int val, rev;
-	u32 gain32;
 
 	if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
 		dev_err(dev, "Invalid device ID %lu\n", id->driver_data);
@@ -355,6 +538,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = dev;
+
 	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap11xx_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -384,50 +569,15 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 		return error;
 
 	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
-		 id->name, rev);
-	node = dev->of_node;
-
-	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
-		if (cap->no_gain)
-			dev_warn(dev,
-				 "This version doesn't support sensor gain\n");
-		else if (is_power_of_2(gain32) && gain32 <= 8)
-			gain = ilog2(gain32);
-		else
-			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
-	}
+			 id->name, rev);
 
-	if (id->driver_data == CAP1106 ||
-	    id->driver_data == CAP1126 ||
-	    id->driver_data == CAP1188) {
-		if (of_property_read_bool(node, "microchip,irq-active-high")) {
-			error = regmap_update_bits(priv->regmap,
-						   CAP11XX_REG_CONFIG2,
-						   CAP11XX_REG_CONFIG2_ALT_POL,
-						   0);
-			if (error)
-				return error;
-		}
-	}
-
-	/* Provide some useful defaults */
-	for (i = 0; i < cap->num_channels; i++)
-		priv->keycodes[i] = KEY_A + i;
-
-	of_property_read_u32_array(node, "linux,keycodes",
-				   priv->keycodes, cap->num_channels);
+	priv->model = cap;
+	priv->id = id->driver_data;
 
-	if (!cap->no_gain) {
-		error = regmap_update_bits(priv->regmap,
-				CAP11XX_REG_MAIN_CONTROL,
-				CAP11XX_REG_MAIN_CONTROL_GAIN_MASK,
-				gain << CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT);
-		if (error)
-			return error;
-	}
+	dev_info(dev, "CAP11XX device detected, model %s, revision 0x%02x\n",
+		 id->name, rev);
 
-	/* Disable autorepeat. The Linux input system has its own handling. */
-	error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
+	error = cap11xx_init_keys(priv);
 	if (error)
 		return error;
 
@@ -439,7 +589,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	priv->idev->id.bustype = BUS_I2C;
 	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
 
-	if (of_property_read_bool(node, "autorepeat"))
+	if (of_property_read_bool(dev->of_node, "autorepeat"))
 		__set_bit(EV_REP, priv->idev->evbit);
 
 	for (i = 0; i < cap->num_channels; i++)
@@ -474,14 +624,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (error)
 		return error;
 
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq) {
-		dev_err(dev, "Unable to parse or map IRQ\n");
-		return -ENXIO;
-	}
-
-	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
-					  IRQF_ONESHOT, dev_name(dev), priv);
+	error = devm_request_threaded_irq(dev, i2c_client->irq, NULL,
+					cap11xx_thread_func, IRQF_ONESHOT, dev_name(dev), priv);
 	if (error)
 		return error;
 
-- 
2.25.1

