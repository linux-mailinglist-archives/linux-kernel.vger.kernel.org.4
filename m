Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3F612F03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJaC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:29:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFFB844;
        Sun, 30 Oct 2022 19:29:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 4so9605871pli.0;
        Sun, 30 Oct 2022 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdwtzHR+xQdJbDyYyz1o5nHG0wEHYVT1LmuGtsV2+G8=;
        b=YIM59IV43rjaq5RAKarM+/WlP1FL/zRcbhtZ/cHSh33QyBibZh4c9ZIqPkhTjJdjnN
         vzwh94kHUuUam35TUAbCMLqSYKC3d5cLAMvMK+uxYPTSHUAdD/3WJhvLnafMKLB73L8H
         AbvXQHrd4LdL8GQKmlogEqZAQWIYjaAWoFHTuufs+yGEz+qsQZX/1HQEG6fXrJtiFTSB
         eeJVRE+kaNL+ofeI2QJW4Dw+ba0INdVuFS6yoqo66Nx7Ef6dxVsD7PkQqkOrDlzePJBK
         fLQpEWXD2EEPWVX62xWMxHIdAgd5lHm8KvHIC1fHmaQbxVaLEFIPE9ZreqN7T/JPDzoO
         fu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdwtzHR+xQdJbDyYyz1o5nHG0wEHYVT1LmuGtsV2+G8=;
        b=29ThP2PVYLVOmaoJGC0uJgQ3NmzsATbkxCHZkKBQJ4yrJTQwYYvSm1zTPfjPlk3xZU
         SjR+0XWiIWAIhgNZo65ZjVOJRcFWmBGSj4L0iLgsbQn5b/IEqyOqLXWieaPm4pOcq8lp
         y37DS5pMGBIY12zWhgt+xnSlgVeBzoYdLhYVDBsAg7lcj5WaFdEh51XnIV2M+68hU+Dw
         8fm5yn0pjdixMA5JrqAtaQX1exg7NEslS0KB4zQuTGD4NYTyoXp1eEfPtJFWG7eqSYI8
         4qYZAEUtRmqMue39yv5MMWRR/W/HHZujB1hV4PiWK0BBZ+Q5LRjvSXByQ0SxiQZhFrbn
         bIuA==
X-Gm-Message-State: ACrzQf0lorrNcaSHUoQTbHkaOlWLp/b4BxvjSSd9AlFabOP+zoIIbDk8
        fURlm4Rs7w8/b2kilI9Vr1I=
X-Google-Smtp-Source: AMsMyM5l4MA6BkI467Rx/cJRzGQ2F8lqrurOIFZAW6NkP91c8FD+E2EE0BG89UtfADxtrolIM0CNwg==
X-Received: by 2002:a17:902:d409:b0:186:af8d:4029 with SMTP id b9-20020a170902d40900b00186af8d4029mr11880672ple.78.1667183346534;
        Sun, 30 Oct 2022 19:29:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:ab6a:820:3d51:c22d:4bb5])
        by smtp.gmail.com with ESMTPSA id q42-20020a17090a17ad00b0021282014066sm3064504pja.9.2022.10.30.19.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 19:29:06 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] regulator: rt6190: Add support for Richtek RT6190 regulator
Date:   Mon, 31 Oct 2022 10:28:54 +0800
Message-Id: <1667183334-16511-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
References: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add support for Richtek RT6190 4-Switch BuckBoost controller.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig            |  11 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt6190-regulator.c | 495 +++++++++++++++++++++++++++++++++++
 3 files changed, 507 insertions(+)
 create mode 100644 drivers/regulator/rt6190-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e440..4e4614d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1124,6 +1124,17 @@ config REGULATOR_RT6160
 	  The wide output range is from 2025mV to 5200mV and can be used on most
 	  common application scenario.
 
+config REGULATOR_RT6190
+	tristate "Richtek RT6190 4-Switch BuckBoost controller"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  The RT6190 is a 4-Switch BuckBoost controller designed for converting
+	  input voltage to output voltage that can be equal to, higher or lower
+	  than input voltage. It operates with wide input voltage range from
+	  4.5V to 36V, and the output voltage can be set from 3V to 36V by
+	  external FB pin.
+
 config REGULATOR_RT6245
 	tristate "Richtek RT6245 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5962307..c3b5cf6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_REGULATOR_RT5120)	+= rt5120-regulator.o
 obj-$(CONFIG_REGULATOR_RT5190A) += rt5190a-regulator.o
 obj-$(CONFIG_REGULATOR_RT5759)	+= rt5759-regulator.o
 obj-$(CONFIG_REGULATOR_RT6160)	+= rt6160-regulator.o
+obj-$(CONFIG_REGULATOR_RT6190)	+= rt6190-regulator.o
 obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ2134) += rtq2134-regulator.o
diff --git a/drivers/regulator/rt6190-regulator.c b/drivers/regulator/rt6190-regulator.c
new file mode 100644
index 00000000..995e028
--- /dev/null
+++ b/drivers/regulator/rt6190-regulator.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define RT6190_REG_VID		0x00
+#define RT6190_REG_OUTV		0x01
+#define RT6190_REG_OUTC		0x03
+#define RT6190_REG_SET1		0x0D
+#define RT6190_REG_SET2		0x0E
+#define RT6190_REG_SET4		0x10
+#define RT6190_REG_RATIO	0x11
+#define RT6190_REG_OUT_VOLT_L	0x12
+#define RT6190_REG_TEMP_H	0x1B
+#define RT6190_REG_STAT1	0x1C
+#define RT6190_REG_ALERT1	0x1E
+#define RT6190_REG_ALERT2	0x1F
+#define RT6190_REG_MASK2	0x21
+#define RT6190_REG_OCPEN	0x28
+#define RT6190_REG_SET5		0x29
+#define RT6190_REG_VBUSC_ADC	0x32
+#define RT6190_REG_BUSC_VOLT_L	0x33
+#define RT6190_REG_BUSC_VOLT_H	0x34
+#define RT6190_REG_STAT3	0x37
+#define RT6190_REG_ALERT3	0x38
+#define RT6190_REG_MASK3	0x39
+
+#define RT6190_ENPWM_MASK	BIT(7)
+#define RT6190_ENDCHG_MASK	BIT(4)
+#define RT6190_ALERT_OTPEVT	BIT(6)
+#define RT6190_ALERT_UVPEVT	BIT(5)
+#define RT6190_ALERT_OVPEVT	BIT(4)
+#define RT6190_ENGCP_MASK	BIT(1)
+#define RT6190_FCCM_MASK	BIT(7)
+
+#define RICHTEK_VID		0x82
+#define RT6190_OUT_MIN_UV	3000000
+#define RT6190_OUT_MAX_UV	32000000
+#define RT6190_OUT_STEP_UV	20000
+#define RT6190_OUT_N_VOLT	(RT6190_OUT_MAX_UV / RT6190_OUT_STEP_UV + 1)
+#define RT6190_OUTV_MINSEL	150
+#define RT6190_OUT_MIN_UA	306000
+#define RT6190_OUT_MAX_UA	12114000
+#define RT6190_OUT_STEP_UA	24000
+#define RT6190_OUTC_MINSEL	19
+#define RT6190_EN_TIME_US	500
+
+#define RT6190_PSM_MODE		0
+#define RT6190_FCCM_MODE	1
+
+struct rt6190_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	unsigned int cached_alert_evt;
+};
+
+static int rt6190_out_set_voltage_sel(struct regulator_dev *rdev,
+				      unsigned int selector)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__le16 le_sel = cpu_to_le16(selector);
+
+	return regmap_raw_write(regmap, RT6190_REG_OUTV, &le_sel,
+				sizeof(le_sel));
+}
+
+static int rt6190_out_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__le16 le_sel;
+	int ret;
+
+	ret = regmap_raw_read(regmap, RT6190_REG_OUTV, &le_sel, sizeof(le_sel));
+
+	return ret ?: le16_to_cpu(le_sel);
+}
+
+static int rt6190_out_enable(struct regulator_dev *rdev)
+{
+	struct rt6190_data *data = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	u8 out_cfg[4];
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+
+	/*
+	 * From off to on, vout config will restore to IC default.
+	 * Read vout configs before enable, and restore them after enable
+	 */
+	ret = regmap_raw_read(regmap, RT6190_REG_OUTV, out_cfg,
+			      sizeof(out_cfg));
+	if (ret)
+		return ret;
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret)
+		return ret;
+
+	ret = regmap_raw_write(regmap, RT6190_REG_OUTV, out_cfg,
+			       sizeof(out_cfg));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(regmap, RT6190_REG_SET5, RT6190_ENGCP_MASK,
+				  RT6190_ENGCP_MASK);
+}
+
+static int rt6190_out_disable(struct regulator_dev *rdev)
+{
+	struct rt6190_data *data = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int ret;
+
+	ret = regmap_update_bits(regmap, RT6190_REG_SET5, RT6190_ENGCP_MASK, 0);
+	if (ret)
+		return ret;
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret)
+		return ret;
+
+	/* cleared cached alert event */
+	data->cached_alert_evt = 0;
+
+	pm_runtime_put(data->dev);
+
+	return 0;
+}
+
+static int rt6190_out_set_current_limit(struct regulator_dev *rdev, int min_uA,
+					int max_uA)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int csel, clim;
+	__le16 le_csel;
+
+	if (min_uA < RT6190_OUT_MIN_UA || max_uA > RT6190_OUT_MAX_UA)
+		return -EINVAL;
+
+	csel = DIV_ROUND_UP(min_uA - RT6190_OUT_MIN_UA, RT6190_OUT_STEP_UA);
+
+	clim = RT6190_OUT_MIN_UA + RT6190_OUT_STEP_UA * csel;
+	if (clim > max_uA)
+		return -EINVAL;
+
+	csel += RT6190_OUTC_MINSEL;
+	le_csel = cpu_to_le16(csel);
+
+	return regmap_raw_write(regmap, RT6190_REG_OUTC, &le_csel,
+				sizeof(le_csel));
+}
+
+static int rt6190_out_get_current_limit(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__le16 le_csel;
+	int csel, ret;
+
+	ret = regmap_raw_read(regmap, RT6190_REG_OUTC, &le_csel,
+			      sizeof(le_csel));
+	if (ret)
+		return ret;
+
+	csel = le16_to_cpu(le_csel);
+	csel -= RT6190_OUTC_MINSEL;
+
+	return RT6190_OUT_MIN_UA + RT6190_OUT_STEP_UA * csel;
+}
+
+static int rt6190_out_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = RT6190_FCCM_MASK;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, RT6190_REG_SET1, RT6190_FCCM_MASK,
+				  val);
+}
+
+static unsigned int rt6190_out_get_mode(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int config;
+	int ret;
+
+	ret = regmap_read(regmap, RT6190_REG_SET1, &config);
+	if (ret)
+		return REGULATOR_MODE_INVALID;
+
+	if (config & RT6190_FCCM_MASK)
+		return REGULATOR_MODE_FAST;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int rt6190_out_get_error_flags(struct regulator_dev *rdev,
+				      unsigned int *flags)
+{
+	struct rt6190_data *data = rdev_get_drvdata(rdev);
+	unsigned int state, rpt_flags = 0;
+	int ret;
+
+	ret = regmap_read(data->regmap, RT6190_REG_STAT1, &state);
+	if (ret)
+		return ret;
+
+	state |= data->cached_alert_evt;
+
+	if (state & RT6190_ALERT_OTPEVT)
+		rpt_flags |= REGULATOR_ERROR_OVER_TEMP;
+
+	if (state & RT6190_ALERT_UVPEVT)
+		rpt_flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+	if (state & RT6190_ALERT_OVPEVT)
+		rpt_flags |= REGULATOR_ERROR_REGULATION_OUT;
+
+	*flags = rpt_flags;
+
+	return 0;
+}
+
+static unsigned int rt6190_out_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RT6190_PSM_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RT6190_FCCM_MODE:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static const struct regulator_ops rt6190_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = rt6190_out_set_voltage_sel,
+	.get_voltage_sel = rt6190_out_get_voltage_sel,
+	.enable = rt6190_out_enable,
+	.disable = rt6190_out_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_current_limit = rt6190_out_set_current_limit,
+	.get_current_limit = rt6190_out_get_current_limit,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_mode = rt6190_out_set_mode,
+	.get_mode = rt6190_out_get_mode,
+	.get_error_flags = rt6190_out_get_error_flags,
+};
+
+static const struct regulator_desc rt6190_regulator_desc = {
+	.name = "rt6190-regulator",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &rt6190_regulator_ops,
+	.min_uV = RT6190_OUT_MIN_UV,
+	.uV_step = RT6190_OUT_STEP_UV,
+	.n_voltages = RT6190_OUT_N_VOLT,
+	.linear_min_sel = RT6190_OUTV_MINSEL,
+	.enable_reg = RT6190_REG_SET2,
+	.enable_mask = RT6190_ENPWM_MASK,
+	.active_discharge_reg = RT6190_REG_SET2,
+	.active_discharge_mask = RT6190_ENDCHG_MASK,
+	.active_discharge_on = RT6190_ENDCHG_MASK,
+	.of_map_mode = rt6190_out_of_map_mode,
+};
+
+static bool rt6190_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT6190_REG_OUT_VOLT_L ... RT6190_REG_ALERT2:
+	case RT6190_REG_BUSC_VOLT_L ... RT6190_REG_BUSC_VOLT_H:
+	case RT6190_REG_STAT3 ... RT6190_REG_ALERT3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rt6190_regmap_config = {
+	.name = "rt6190",
+	.cache_type = REGCACHE_FLAT,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT6190_REG_MASK3,
+	.num_reg_defaults_raw = RT6190_REG_MASK3 + 1,
+	.volatile_reg = rt6190_is_volatile_reg,
+};
+
+static irqreturn_t rt6190_irq_handler(int irq, void *devid)
+{
+	struct regulator_dev *rdev = devid;
+	struct rt6190_data *data = rdev_get_drvdata(rdev);
+	unsigned int alert;
+	int ret;
+
+	ret = regmap_read(data->regmap, RT6190_REG_ALERT1, &alert);
+	if (ret)
+		return IRQ_NONE;
+
+	/* Write clear alert events */
+	ret = regmap_write(data->regmap, RT6190_REG_ALERT1, alert);
+	if (ret)
+		return IRQ_NONE;
+
+	data->cached_alert_evt |= alert;
+
+	if (alert & RT6190_ALERT_OTPEVT)
+		regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_TEMP, NULL);
+
+	if (alert & RT6190_ALERT_UVPEVT)
+		regulator_notifier_call_chain(rdev, REGULATOR_EVENT_UNDER_VOLTAGE, NULL);
+
+	if (alert & RT6190_ALERT_OVPEVT)
+		regulator_notifier_call_chain(rdev, REGULATOR_EVENT_REGULATION_OUT, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static int rt6190_init_registers(struct regmap *regmap)
+{
+	int ret;
+
+	/* Enable_ADC = 1 */
+	ret = regmap_write(regmap, RT6190_REG_SET4, 0x82);
+	if (ret)
+		return ret;
+
+	/* Config default VOUT ratio to be higher */
+	ret = regmap_write(regmap, RT6190_REG_RATIO, 0x20);
+
+	/* Mask unused alert */
+	ret = regmap_write(regmap, RT6190_REG_MASK2, 0);
+	if (ret)
+		return ret;
+
+	/* OCP config */
+	ret = regmap_write(regmap, RT6190_REG_OCPEN, 0);
+	if (ret)
+		return ret;
+
+	/* Enable VBUSC ADC */
+	return regmap_write(regmap, RT6190_REG_VBUSC_ADC, 0x02);
+}
+
+static int rt6190_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct rt6190_data *data;
+	struct gpio_desc *enable_gpio;
+	struct regmap *regmap;
+	struct regulator_dev *rdev;
+	struct regulator_config cfg = {};
+	unsigned int vid;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(enable_gpio), "Failed to get 'enable' gpio\n");
+	else if (enable_gpio)
+		usleep_range(RT6190_EN_TIME_US, RT6190_EN_TIME_US * 2);
+
+	regmap = devm_regmap_init_i2c(i2c, &rt6190_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	data->dev = dev;
+	data->enable_gpio = enable_gpio;
+	data->regmap = regmap;
+	i2c_set_clientdata(i2c, data);
+
+	ret = regmap_read(regmap, RT6190_REG_VID, &vid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read VID\n");
+
+	if (vid != RICHTEK_VID)
+		return dev_err_probe(dev, -ENODEV, "Incorrect VID 0x%02x\n", vid);
+
+	ret = rt6190_init_registers(regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init registers\n");
+
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set pm_runtime enable\n");
+
+	cfg.dev = dev;
+	cfg.of_node = dev->of_node;
+	cfg.driver_data = data;
+	cfg.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						   &rt6190_regulator_desc);
+
+	rdev = devm_regulator_register(dev, &rt6190_regulator_desc, &cfg);
+	if (IS_ERR(rdev))
+		return dev_err_probe(dev, PTR_ERR(rdev), "Failed to register regulator\n");
+
+	if (i2c->irq) {
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+						rt6190_irq_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						rdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to register interrupt\n");
+	}
+
+	return 0;
+}
+
+static int rt6190_runtime_suspend(struct device *dev)
+{
+	struct rt6190_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+
+	if (!data->enable_gpio)
+		return 0;
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	gpiod_set_value(data->enable_gpio, 0);
+
+	return 0;
+}
+
+static int rt6190_runtime_resume(struct device *dev)
+{
+	struct rt6190_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+
+	if (!data->enable_gpio)
+		return 0;
+
+	gpiod_set_value(data->enable_gpio, 1);
+	usleep_range(RT6190_EN_TIME_US, RT6190_EN_TIME_US * 2);
+
+	regcache_cache_only(regmap, false);
+	return regcache_sync(regmap);
+}
+
+static const struct dev_pm_ops __maybe_unused rt6190_dev_pm = {
+	RUNTIME_PM_OPS(rt6190_runtime_suspend, rt6190_runtime_resume, NULL)
+};
+
+static const struct of_device_id rt6190_of_dev_table[] = {
+	{ .compatible = "richtek,rt6190" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt6190_of_dev_table);
+
+static struct i2c_driver rt6190_driver = {
+	.driver = {
+		.name = "rt6190",
+		.of_match_table = rt6190_of_dev_table,
+		.pm = pm_ptr(&rt6190_dev_pm),
+	},
+	.probe_new = rt6190_probe,
+};
+module_i2c_driver(rt6190_driver);
+
+MODULE_DESCRIPTION("Richtek RT6190 regulator driver");
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

