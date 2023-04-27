Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB46F0508
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjD0La4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjD0Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:30:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4B120
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:30:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f7c281a015so5203932f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682595050; x=1685187050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHrfSHgqSP98gjaXIh1zuaySE0uqFkESE6BbB3tZSac=;
        b=VxGZQtQMQSCWRp6gGabPMxlxDQNfn50Fs0JlV5ZpXktcRX51CA3cHmBbuRMZPamfjX
         vG82pv5si32W8jI9yL36Xc0TGijfj5hmczwTLw9uNr4neuv41ohwtbOIWqMwF7wuIcdP
         WOH+Vrdp7xcYR64Zu/up5ftjdQjlEPuVvPvBFetvqpuo6Et5VS9dtADSsVeBXmWULLGG
         +ccw1BdqbvNvWKcHUV0gGktOj8ahELQ1qAgsBBKhNDt8M/ycbNB5zJehYrRlvh4RPigx
         Zzs47WEhwZJ6+AcxWVESxHdukrS5TWopGVNqYtDFZ4O7YXn9mJjg3ORQIQHMSpHzY1d6
         BLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682595050; x=1685187050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHrfSHgqSP98gjaXIh1zuaySE0uqFkESE6BbB3tZSac=;
        b=QwX1UTFWGaH0RZlkX1SM2hNLvUzo2JI1n5UavHNc03SzTRAYYJ9iD2ET43KPu1OiQ7
         HTkLdofz+CGvaUiDaEY0azUv40nf1U6npmm2nEASGyPNk4Eycl/47qJ3tRMZpKgpUNXe
         LaEh2XqVbBJXhgGwIVtcUOcidnQuH5RSa2CKvaYqKbT3fWgOb05JrCguZN+BdI3jICgN
         0tPtknZqpdxIi/Rk152Cpa3Udag/83XWoI3bZX2/YepmVModH+7mDGlIRq4BJlsm0Ikd
         mSkE0bBKNExwoO57fFTivBFLDFM4o/fk6X353+Jk7mrvxuEsDFdCADYSPS6reLBC0xtp
         eHQg==
X-Gm-Message-State: AC+VfDy7Lajc/RwhwUnHkz/Ms2ESrPooSds5MNH5xxhlwcRYsKgJIRaT
        4h026TJQ62SS3QtCQDx9ATQA6mYbpZ1FqvXVs/Ebow==
X-Google-Smtp-Source: ACHHUZ6xiJ/5dq9XDu5Wv5a9CNGfWQyGFufHBk1jVTi5K8UvnE3HsK32WRO7StHg+Bv3TXodpjfmoQ==
X-Received: by 2002:a5d:4e12:0:b0:2ce:a8e9:bb3a with SMTP id p18-20020a5d4e12000000b002cea8e9bb3amr1076653wrt.4.1682595050484;
        Thu, 27 Apr 2023 04:30:50 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm18224499wru.109.2023.04.27.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 04:30:50 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: max5970: Rename driver and remove wildcard
Date:   Thu, 27 Apr 2023 13:30:46 +0200
Message-Id: <20230427113046.3971425-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this driver included wildcards in file names and
descriptions. This patch renames the driver to only support MAX5970 and
MAX5978, which are the only chips that the driver actually supports.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/Kconfig                     |   6 +-
 drivers/regulator/Makefile                    |   2 +-
 ...ax597x-regulator.c => max5970-regulator.c} | 126 +++++++++---------
 3 files changed, 67 insertions(+), 67 deletions(-)
 rename drivers/regulator/{max597x-regulator.c => max5970-regulator.c} (76%)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index aae28d0a489c..36465aeb4e21 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -546,11 +546,11 @@ config REGULATOR_MAX1586
 	  regulator via I2C bus. The provided regulator is suitable
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.
 
-config REGULATOR_MAX597X
-	tristate "Maxim 597x power switch and monitor"
+config REGULATOR_MAX5970
+	tristate "Maxim 5970/5978 power switch and monitor"
 	depends on I2C
 	depends on OF
-	depends on MFD_MAX597X
+	depends on MFD_MAX5970
 	help
 	  This driver controls a Maxim 5970/5978 switch via I2C bus.
 	  The MAX5970/5978 is a smart switch with no output regulation, but
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index ee383d8fc835..aed1b7c2eb78 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
-obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
+obj-$(CONFIG_REGULATOR_MAX5970) += max5970-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max5970-regulator.c
similarity index 76%
rename from drivers/regulator/max597x-regulator.c
rename to drivers/regulator/max5970-regulator.c
index 648e3641885a..08c8eb7b1ed6 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -20,19 +20,19 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
 
-#include <linux/mfd/max597x.h>
+#include <linux/mfd/max5970.h>
 
-struct max597x_regulator {
+struct max5970_regulator {
 	int num_switches, mon_rng, irng, shunt_micro_ohms, lim_uA;
 	struct regmap *regmap;
 };
 
-enum max597x_regulator_id {
-	MAX597X_SW0,
-	MAX597X_SW1,
+enum max5970_regulator_id {
+	MAX5970_SW0,
+	MAX5970_SW1,
 };
 
-static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
+static int max5970_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
 {
 	int ret, reg;
 
@@ -54,11 +54,11 @@ static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
 	return 0;
 }
 
-static int max597x_set_vp(struct regulator_dev *rdev, int lim_uV, int severity,
+static int max5970_set_vp(struct regulator_dev *rdev, int lim_uV, int severity,
 			  bool enable, bool overvoltage)
 {
 	int off_h, off_l, reg, ret;
-	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	struct max5970_regulator *data = rdev_get_drvdata(rdev);
 	int channel = rdev_get_id(rdev);
 
 	if (overvoltage) {
@@ -96,7 +96,7 @@ static int max597x_set_vp(struct regulator_dev *rdev, int lim_uV, int severity,
 	return 0;
 }
 
-static int max597x_set_uvp(struct regulator_dev *rdev, int lim_uV, int severity,
+static int max5970_set_uvp(struct regulator_dev *rdev, int lim_uV, int severity,
 			   bool enable)
 {
 	int ret;
@@ -108,14 +108,14 @@ static int max597x_set_uvp(struct regulator_dev *rdev, int lim_uV, int severity,
 	if ((lim_uV && !enable) || (!lim_uV && enable))
 		return -EINVAL;
 
-	ret = max597x_uvp_ovp_check_mode(rdev, severity);
+	ret = max5970_uvp_ovp_check_mode(rdev, severity);
 	if (ret)
 		return ret;
 
-	return max597x_set_vp(rdev, lim_uV, severity, enable, false);
+	return max5970_set_vp(rdev, lim_uV, severity, enable, false);
 }
 
-static int max597x_set_ovp(struct regulator_dev *rdev, int lim_uV, int severity,
+static int max5970_set_ovp(struct regulator_dev *rdev, int lim_uV, int severity,
 			   bool enable)
 {
 	int ret;
@@ -127,20 +127,20 @@ static int max597x_set_ovp(struct regulator_dev *rdev, int lim_uV, int severity,
 	if ((lim_uV && !enable) || (!lim_uV && enable))
 		return -EINVAL;
 
-	ret = max597x_uvp_ovp_check_mode(rdev, severity);
+	ret = max5970_uvp_ovp_check_mode(rdev, severity);
 	if (ret)
 		return ret;
 
-	return max597x_set_vp(rdev, lim_uV, severity, enable, true);
+	return max5970_set_vp(rdev, lim_uV, severity, enable, true);
 }
 
-static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
+static int max5970_set_ocp(struct regulator_dev *rdev, int lim_uA,
 			   int severity, bool enable)
 {
 	int val, reg;
 	unsigned int vthst, vthfst;
 
-	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	struct max5970_regulator *data = rdev_get_drvdata(rdev);
 	int rdev_id = rdev_get_id(rdev);
 	/*
 	 * MAX5970 doesn't has enable control for ocp.
@@ -187,7 +187,7 @@ static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
 	return regmap_write(rdev->regmap, reg, val);
 }
 
-static int max597x_get_status(struct regulator_dev *rdev)
+static int max5970_get_status(struct regulator_dev *rdev)
 {
 	int val, ret;
 
@@ -208,21 +208,21 @@ static int max597x_get_status(struct regulator_dev *rdev)
 	return REGULATOR_STATUS_OFF;
 }
 
-static const struct regulator_ops max597x_switch_ops = {
+static const struct regulator_ops max5970_switch_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-	.get_status = max597x_get_status,
-	.set_over_voltage_protection = max597x_set_ovp,
-	.set_under_voltage_protection = max597x_set_uvp,
-	.set_over_current_protection = max597x_set_ocp,
+	.get_status = max5970_get_status,
+	.set_over_voltage_protection = max5970_set_ovp,
+	.set_under_voltage_protection = max5970_set_uvp,
+	.set_over_current_protection = max5970_set_ocp,
 };
 
-static int max597x_dt_parse(struct device_node *np,
+static int max5970_dt_parse(struct device_node *np,
 			    const struct regulator_desc *desc,
 			    struct regulator_config *cfg)
 {
-	struct max597x_regulator *data = cfg->driver_data;
+	struct max5970_regulator *data = cfg->driver_data;
 	int ret = 0;
 
 	ret =
@@ -236,26 +236,26 @@ static int max597x_dt_parse(struct device_node *np,
 
 }
 
-#define MAX597X_SWITCH(_ID, _ereg, _chan, _supply) {     \
+#define MAX5970_SWITCH(_ID, _ereg, _chan, _supply) {     \
 	.name            = #_ID,                         \
 	.of_match        = of_match_ptr(#_ID),           \
-	.ops             = &max597x_switch_ops,          \
+	.ops             = &max5970_switch_ops,          \
 	.regulators_node = of_match_ptr("regulators"),   \
 	.type            = REGULATOR_VOLTAGE,            \
-	.id              = MAX597X_##_ID,                \
+	.id              = MAX5970_##_ID,                \
 	.owner           = THIS_MODULE,                  \
 	.supply_name     = _supply,                      \
 	.enable_reg      = _ereg,                        \
 	.enable_mask     = CHXEN((_chan)),               \
-	.of_parse_cb	 = max597x_dt_parse,		 \
+	.of_parse_cb	 = max5970_dt_parse,		 \
 }
 
 static const struct regulator_desc regulators[] = {
-	MAX597X_SWITCH(SW0, MAX5970_REG_CHXEN, 0, "vss1"),
-	MAX597X_SWITCH(SW1, MAX5970_REG_CHXEN, 1, "vss2"),
+	MAX5970_SWITCH(SW0, MAX5970_REG_CHXEN, 0, "vss1"),
+	MAX5970_SWITCH(SW1, MAX5970_REG_CHXEN, 1, "vss2"),
 };
 
-static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
+static int max5970_regmap_read_clear(struct regmap *map, unsigned int reg,
 				     unsigned int *val)
 {
 	int ret;
@@ -270,14 +270,14 @@ static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
 	return 0;
 }
 
-static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
+static int max5970_irq_handler(int irq, struct regulator_irq_data *rid,
 			       unsigned long *dev_mask)
 {
 	struct regulator_err_state *stat;
-	struct max597x_regulator *d = (struct max597x_regulator *)rid->data;
+	struct max5970_regulator *d = (struct max5970_regulator *)rid->data;
 	int val, ret, i;
 
-	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
+	ret = max5970_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
 	if (ret)
 		return REGULATOR_FAILED_RETRY;
 
@@ -302,7 +302,7 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 		}
 	}
 
-	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT1, &val);
+	ret = max5970_regmap_read_clear(d->regmap, MAX5970_REG_FAULT1, &val);
 	if (ret)
 		return REGULATOR_FAILED_RETRY;
 
@@ -320,7 +320,7 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 		}
 	}
 
-	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT2, &val);
+	ret = max5970_regmap_read_clear(d->regmap, MAX5970_REG_FAULT2, &val);
 	if (ret)
 		return REGULATOR_FAILED_RETRY;
 
@@ -357,7 +357,7 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 	return 0;
 }
 
-static int max597x_adc_range(struct regmap *regmap, const int ch,
+static int max5970_adc_range(struct regmap *regmap, const int ch,
 			     u32 *irng, u32 *mon_rng)
 {
 	unsigned int reg;
@@ -391,14 +391,14 @@ static int max597x_adc_range(struct regmap *regmap, const int ch,
 	return 0;
 }
 
-static int max597x_setup_irq(struct device *dev,
+static int max5970_setup_irq(struct device *dev,
 			     int irq,
 			     struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES],
-			     int num_switches, struct max597x_regulator *data)
+			     int num_switches, struct max5970_regulator *data)
 {
-	struct regulator_irq_desc max597x_notif = {
-		.name = "max597x-irq",
-		.map_event = max597x_irq_handler,
+	struct regulator_irq_desc max5970_notif = {
+		.name = "max5970-irq",
+		.map_event = max5970_irq_handler,
 		.data = data,
 	};
 	int errs = REGULATOR_ERROR_UNDER_VOLTAGE |
@@ -410,7 +410,7 @@ static int max597x_setup_irq(struct device *dev,
 	void *irq_helper;
 
 	/* Register notifiers - can fail if IRQ is not given */
-	irq_helper = devm_regulator_irq_helper(dev, &max597x_notif,
+	irq_helper = devm_regulator_irq_helper(dev, &max5970_notif,
 					       irq, 0, errs, NULL,
 					       &rdevs[0], num_switches);
 	if (IS_ERR(irq_helper)) {
@@ -423,11 +423,11 @@ static int max597x_setup_irq(struct device *dev,
 	return 0;
 }
 
-static int max597x_regulator_probe(struct platform_device *pdev)
+static int max5970_regulator_probe(struct platform_device *pdev)
 {
-	struct max597x_data *max597x;
+	struct max5970_data *max5970;
 	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	struct max597x_regulator *data;
+	struct max5970_regulator *data;
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -438,25 +438,25 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);
-	if (!max597x)
+	max5970 = devm_kzalloc(&i2c->dev, sizeof(struct max5970_data), GFP_KERNEL);
+	if (!max5970)
 		return -ENOMEM;
 
-	i2c_set_clientdata(i2c, max597x);
+	i2c_set_clientdata(i2c, max5970);
 
 	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
-		max597x->num_switches = MAX597x_TYPE_MAX5978;
+		max5970->num_switches = MAX5978_NUM_SWITCHES;
 	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
-		max597x->num_switches = MAX597x_TYPE_MAX5970;
+		max5970->num_switches = MAX5970_NUM_SWITCHES;
 	else
 		return -ENODEV;
 
-	i2c_set_clientdata(i2c, max597x);
-	num_switches = max597x->num_switches;
+	i2c_set_clientdata(i2c, max5970);
+	num_switches = max5970->num_switches;
 
 	for (i = 0; i < num_switches; i++) {
 		data =
-		    devm_kzalloc(&i2c->dev, sizeof(struct max597x_regulator),
+		    devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
 				 GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
@@ -464,12 +464,12 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		data->num_switches = num_switches;
 		data->regmap = regmap;
 
-		ret = max597x_adc_range(regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
+		ret = max5970_adc_range(regmap, i, &max5970->irng[i], &max5970->mon_rng[i]);
 		if (ret < 0)
 			return ret;
 
-		data->irng = max597x->irng[i];
-		data->mon_rng = max597x->mon_rng[i];
+		data->irng = max5970->irng[i];
+		data->mon_rng = max5970->mon_rng[i];
 
 		config.dev = &i2c->dev;
 		config.driver_data = (void *)data;
@@ -482,12 +482,12 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 			return PTR_ERR(rdev);
 		}
 		rdevs[i] = rdev;
-		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
+		max5970->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
 	if (i2c->irq) {
 		ret =
-		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
+		    max5970_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
 				      data);
 		if (ret) {
 			dev_err(&i2c->dev, "IRQ setup failed");
@@ -498,14 +498,14 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver max597x_regulator_driver = {
+static struct platform_driver max5970_regulator_driver = {
 	.driver = {
-		.name = "max597x-regulator",
+		.name = "max5970-regulator",
 	},
-	.probe = max597x_regulator_probe,
+	.probe = max5970_regulator_probe,
 };
 
-module_platform_driver(max597x_regulator_driver);
+module_platform_driver(max5970_regulator_driver);
 
 
 MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
-- 
2.39.1

