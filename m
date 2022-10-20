Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200A86069BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJTUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:43:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B241F810A;
        Thu, 20 Oct 2022 13:43:11 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-009.ewe-ip-backbone.de [91.96.59.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 549096602538;
        Thu, 20 Oct 2022 21:42:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666298577;
        bh=ju4+Y6oRH1bukxoahGYecoITlUw4tb3HclJZrUKfzRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsQH5LWQaGA/TNR0caSY6BL/T0oXevfIVAxqje7OM5wexR7iD/TRKF1iurHr+QBSq
         KewGQ5J8jvPA1ZjhUqInDfXadwJkAxudr55SKq5sOFnn2Z9nFOCGOhhBShpxBjRFCo
         ftRzE3RODidriepOsJGCryeeTzI3y9OFxYHvtRgz9vxKt3Aw5cQ4jnePkejugy1ZuQ
         7J0oGhYRkNLwYZbbOLkFRyEYoKEjkhLfoC9DDSiWbx7zEEQ2ZexKtJgnPpZ5oCAxss
         8qO7j6LxzGjwNKRUa92SpUj7quqru7p945ZM94DINE0FxgNP/xIHh4f17kq86nK45J
         MaZZFjWrfnrig==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5D7D548089C; Thu, 20 Oct 2022 22:42:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv4 07/13] mfd: rk808: split into core and i2c
Date:   Thu, 20 Oct 2022 22:42:45 +0200
Message-Id: <20221020204251.108565-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020204251.108565-1-sebastian.reichel@collabora.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split rk808 into a core and an i2c part in preperation for
SPI support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/Kconfig                   |   2 +-
 drivers/input/misc/Kconfig            |   2 +-
 drivers/mfd/Kconfig                   |   7 +-
 drivers/mfd/Makefile                  |   3 +-
 drivers/mfd/{rk808.c => rk8xx-core.c} | 210 ++++----------------------
 drivers/mfd/rk8xx-i2c.c               | 209 +++++++++++++++++++++++++
 drivers/pinctrl/Kconfig               |   2 +-
 drivers/power/supply/Kconfig          |   2 +-
 drivers/regulator/Kconfig             |   2 +-
 drivers/rtc/Kconfig                   |   2 +-
 include/linux/mfd/rk808.h             |   6 +
 sound/soc/codecs/Kconfig              |   2 +-
 12 files changed, 263 insertions(+), 186 deletions(-)
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (75%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d79905f3e174..8448d616b9aa 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -83,7 +83,7 @@ config COMMON_CLK_MAX9485
 
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal oscillator clock.
 	  These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f088900f863..1899afeaec47 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -588,7 +588,7 @@ config INPUT_PWM_VIBRA
 
 config INPUT_RK805_PWRKEY
 	tristate "Rockchip RK805 PMIC power key support"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  Select this option to enable power key driver for RK805.
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..8e3de443cc3d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1201,12 +1201,17 @@ config MFD_RC5T583
 	  Additional drivers must be enabled in order to use the
 	  different functionality of the device.
 
-config MFD_RK808
+config MFD_RK8XX
+	bool
+	select MFD_CORE
+
+config MFD_RK8XX_I2C
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select MFD_RK8XX
 	help
 	  If you say yes here you get support for the RK805, RK808, RK809,
 	  RK817 and RK818 Power Management chips.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..edf84e870f98 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -223,7 +223,8 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
-obj-$(CONFIG_MFD_RK808)		+= rk808.o
+obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
+obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk8xx-core.c
similarity index 75%
rename from drivers/mfd/rk808.c
rename to drivers/mfd/rk8xx-core.c
index b154ca96d812..098506972710 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -3,16 +3,9 @@
  * MFD core driver for Rockchip RK808/RK818
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
- *
- * Author: Chris Zhong <zyw@rock-chips.com>
- * Author: Zhang Qing <zhangqing@rock-chips.com>
- *
  * Copyright (C) 2016 PHYTEC Messtechnik GmbH
- *
- * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/rk808.h>
 #include <linux/mfd/core.h>
@@ -27,92 +20,6 @@ struct rk808_reg_data {
 	int value;
 };
 
-static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	/*
-	 * Notes:
-	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
-	 *   we don't use that feature.  It's better to cache.
-	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
-	 *   bits are cleared in case when we shutoff anyway, but better safe.
-	 */
-
-	switch (reg) {
-	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
-	case RK808_RTC_STATUS_REG:
-	case RK808_VB_MON_REG:
-	case RK808_THERMAL_REG:
-	case RK808_DCDC_UV_STS_REG:
-	case RK808_LDO_UV_STS_REG:
-	case RK808_DCDC_PG_REG:
-	case RK808_LDO_PG_REG:
-	case RK808_DEVCTRL_REG:
-	case RK808_INT_STS_REG1:
-	case RK808_INT_STS_REG2:
-		return true;
-	}
-
-	return false;
-}
-
-static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	/*
-	 * Notes:
-	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
-	 *   we don't use that feature.  It's better to cache.
-	 */
-
-	switch (reg) {
-	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
-	case RK817_RTC_STATUS_REG:
-	case RK817_CODEC_DTOP_LPT_SRST:
-	case RK817_GAS_GAUGE_ADC_CONFIG0 ... RK817_GAS_GAUGE_CUR_ADC_K0:
-	case RK817_PMIC_CHRG_STS:
-	case RK817_PMIC_CHRG_OUT:
-	case RK817_PMIC_CHRG_IN:
-	case RK817_INT_STS_REG0:
-	case RK817_INT_STS_REG1:
-	case RK817_INT_STS_REG2:
-	case RK817_SYS_STS:
-		return true;
-	}
-
-	return false;
-}
-
-static const struct regmap_config rk818_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK818_USB_CTRL_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk805_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK805_OFF_SOURCE_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk808_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK808_IO_POL_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk817_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK817_GPIO_INT_CFG,
-	.cache_type = REGCACHE_NONE,
-	.volatile_reg = rk817_is_volatile_reg,
-};
-
 static const struct resource rtc_resources[] = {
 	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
@@ -598,9 +505,9 @@ static int rk808_restart(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-static void rk8xx_shutdown(struct i2c_client *client)
+void rk8xx_shutdown(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(client);
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret;
 
 	switch (rk808->variant) {
@@ -621,62 +528,31 @@ static void rk8xx_shutdown(struct i2c_client *client)
 		return;
 	}
 	if (ret)
-		dev_warn(&client->dev,
+		dev_warn(dev,
 			 "Cannot switch to power down function\n");
 }
+EXPORT_SYMBOL_GPL(rk8xx_shutdown);
 
-static const struct of_device_id rk808_of_match[] = {
-	{ .compatible = "rockchip,rk805" },
-	{ .compatible = "rockchip,rk808" },
-	{ .compatible = "rockchip,rk809" },
-	{ .compatible = "rockchip,rk817" },
-	{ .compatible = "rockchip,rk818" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, rk808_of_match);
-
-static int rk808_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
 {
-	struct device_node *np = client->dev.of_node;
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
 	const struct mfd_cell *cells;
 	int nr_pre_init_regs;
 	int nr_cells;
-	int msb, lsb;
-	unsigned char pmic_id_msb, pmic_id_lsb;
 	int ret;
 	int i;
 
-	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
+	rk808 = devm_kzalloc(dev, sizeof(*rk808), GFP_KERNEL);
 	if (!rk808)
 		return -ENOMEM;
-
-	if (of_device_is_compatible(np, "rockchip,rk817") ||
-	    of_device_is_compatible(np, "rockchip,rk809")) {
-		pmic_id_msb = RK817_ID_MSB;
-		pmic_id_lsb = RK817_ID_LSB;
-	} else {
-		pmic_id_msb = RK808_ID_MSB;
-		pmic_id_lsb = RK808_ID_LSB;
-	}
-
-	/* Read chip variant */
-	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
-	if (msb < 0)
-		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
-
-	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
-	if (lsb < 0)
-		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
-
-	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
-	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
+	rk808->dev = dev;
+	rk808->variant = variant;
+	rk808->regmap = regmap;
+	dev_set_drvdata(dev, rk808);
 
 	switch (rk808->variant) {
 	case RK805_ID:
-		rk808->regmap_cfg = &rk805_regmap_config;
 		rk808->regmap_irq_chip = &rk805_irq_chip;
 		pre_init_reg = rk805_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
@@ -684,7 +560,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk805s);
 		break;
 	case RK808_ID:
-		rk808->regmap_cfg = &rk808_regmap_config;
 		rk808->regmap_irq_chip = &rk808_irq_chip;
 		pre_init_reg = rk808_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
@@ -692,7 +567,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk808s);
 		break;
 	case RK818_ID:
-		rk808->regmap_cfg = &rk818_regmap_config;
 		rk808->regmap_irq_chip = &rk818_irq_chip;
 		pre_init_reg = rk818_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
@@ -701,7 +575,6 @@ static int rk808_probe(struct i2c_client *client,
 		break;
 	case RK809_ID:
 	case RK817_ID:
-		rk808->regmap_cfg = &rk817_regmap_config;
 		rk808->regmap_irq_chip = &rk817_irq_chip;
 		pre_init_reg = rk817_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
@@ -709,27 +582,20 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk817s);
 		break;
 	default:
-		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
-			rk808->variant);
+		dev_err(dev, "Unsupported RK8XX ID %lu\n", rk808->variant);
 		return -EINVAL;
 	}
 
-	rk808->dev = &client->dev;
-	i2c_set_clientdata(client, rk808);
-
-	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
-	if (IS_ERR(rk808->regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(rk808->regmap),
-				     "regmap initialization failed\n");
+	dev_info(dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
 
-	if (!client->irq)
-		return dev_err_probe(&client->dev, -EINVAL, "No interrupt support, no core IRQ\n");
+	if (!irq)
+		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
-	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
+	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
 				       IRQF_ONESHOT, -1,
 				       rk808->regmap_irq_chip, &rk808->irq_data);
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "Failed to add irq_chip\n");
+		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
 
 	for (i = 0; i < nr_pre_init_regs; i++) {
 		ret = regmap_update_bits(rk808->regmap,
@@ -737,45 +603,46 @@ static int rk808_probe(struct i2c_client *client,
 					pre_init_reg[i].mask,
 					pre_init_reg[i].value);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "0x%x write err\n",
+			return dev_err_probe(dev, ret, "0x%x write err\n",
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "failed to add MFD devices\n");
+		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
 
-	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		ret = devm_register_sys_off_handler(&client->dev,
+	if (device_property_read_bool(dev, "rockchip,system-power-controller")) {
+		ret = devm_register_sys_off_handler(dev,
 				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
 				    &rk808_power_off, rk808);
 		if (ret)
-			return dev_err_probe(&client->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to register poweroff handler\n");
 
 		switch (rk808->variant) {
 		case RK809_ID:
 		case RK817_ID:
-			ret = devm_register_sys_off_handler(&client->dev,
+			ret = devm_register_sys_off_handler(dev,
 							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
 							    &rk808_restart, rk808);
 			if (ret)
-				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
+				dev_warn(dev, "failed to register rst handler, %d\n", ret);
 			break;
 		default:
-			dev_dbg(&client->dev, "pmic controlled board reset not supported\n");
+			dev_dbg(dev, "pmic controlled board reset not supported\n");
 			break;
 		}
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rk8xx_probe);
 
-static int __maybe_unused rk8xx_suspend(struct device *dev)
+int rk8xx_suspend(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret = 0;
 
 	switch (rk808->variant) {
@@ -798,10 +665,11 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rk8xx_suspend);
 
-static int __maybe_unused rk8xx_resume(struct device *dev)
+int rk8xx_resume(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret = 0;
 
 	switch (rk808->variant) {
@@ -818,22 +686,10 @@ static int __maybe_unused rk8xx_resume(struct device *dev)
 
 	return ret;
 }
-static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
-
-static struct i2c_driver rk808_i2c_driver = {
-	.driver = {
-		.name = "rk808",
-		.of_match_table = rk808_of_match,
-		.pm = &rk8xx_pm_ops,
-	},
-	.probe    = rk808_probe,
-	.shutdown = rk8xx_shutdown,
-};
-
-module_i2c_driver(rk808_i2c_driver);
+EXPORT_SYMBOL_GPL(rk8xx_resume);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
-MODULE_DESCRIPTION("RK808/RK818 PMIC driver");
+MODULE_DESCRIPTION("RK8xx PMIC core");
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
new file mode 100644
index 000000000000..7babb0e1e64c
--- /dev/null
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip RK808/RK818 Core (I2C) driver
+ *
+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ *
+ * Author: Chris Zhong <zyw@rock-chips.com>
+ * Author: Zhang Qing <zhangqing@rock-chips.com>
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/rk808.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Notes:
+	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 *   we don't use that feature.  It's better to cache.
+	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
+	 *   bits are cleared in case when we shutoff anyway, but better safe.
+	 */
+
+	switch (reg) {
+	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
+	case RK808_RTC_STATUS_REG:
+	case RK808_VB_MON_REG:
+	case RK808_THERMAL_REG:
+	case RK808_DCDC_UV_STS_REG:
+	case RK808_LDO_UV_STS_REG:
+	case RK808_DCDC_PG_REG:
+	case RK808_LDO_PG_REG:
+	case RK808_DEVCTRL_REG:
+	case RK808_INT_STS_REG1:
+	case RK808_INT_STS_REG2:
+		return true;
+	}
+
+	return false;
+}
+
+static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Notes:
+	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 *   we don't use that feature.  It's better to cache.
+	 */
+
+	switch (reg) {
+	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
+	case RK817_RTC_STATUS_REG:
+	case RK817_CODEC_DTOP_LPT_SRST:
+	case RK817_GAS_GAUGE_ADC_CONFIG0 ... RK817_GAS_GAUGE_CUR_ADC_K0:
+	case RK817_PMIC_CHRG_STS:
+	case RK817_PMIC_CHRG_OUT:
+	case RK817_PMIC_CHRG_IN:
+	case RK817_INT_STS_REG0:
+	case RK817_INT_STS_REG1:
+	case RK817_INT_STS_REG2:
+	case RK817_SYS_STS:
+		return true;
+	}
+
+	return false;
+}
+
+
+static const struct regmap_config rk818_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK818_USB_CTRL_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk805_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK805_OFF_SOURCE_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk808_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK808_IO_POL_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk817_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK817_GPIO_INT_CFG,
+	.cache_type = REGCACHE_NONE,
+	.volatile_reg = rk817_is_volatile_reg,
+};
+
+static int rk8xx_i2c_get_variant(struct i2c_client *client)
+{
+	u8 pmic_id_msb, pmic_id_lsb;
+	int msb, lsb;
+
+	if (of_device_is_compatible(client->dev.of_node, "rockchip,rk817") ||
+	    of_device_is_compatible(client->dev.of_node, "rockchip,rk809")) {
+		pmic_id_msb = RK817_ID_MSB;
+		pmic_id_lsb = RK817_ID_LSB;
+	} else {
+		pmic_id_msb = RK808_ID_MSB;
+		pmic_id_lsb = RK808_ID_LSB;
+	}
+
+	/* Read chip variant */
+	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
+	if (msb < 0)
+		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
+
+	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
+	if (lsb < 0)
+		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
+
+	return ((msb << 8) | lsb) & RK8XX_ID_MSK;
+}
+
+static int rk8xx_i2c_probe(struct i2c_client *client)
+{
+	const struct regmap_config *regmap_cfg;
+	struct regmap *regmap;
+	int variant;
+
+	variant = rk8xx_i2c_get_variant(client);
+	if (variant < 0)
+		return variant;
+
+	switch (variant) {
+	case RK805_ID:
+		regmap_cfg = &rk805_regmap_config;
+		break;
+	case RK808_ID:
+		regmap_cfg = &rk808_regmap_config;
+		break;
+	case RK818_ID:
+		regmap_cfg = &rk818_regmap_config;
+		break;
+	case RK809_ID:
+	case RK817_ID:
+		regmap_cfg = &rk817_regmap_config;
+		break;
+	default:
+		return dev_err_probe(&client->dev, -EINVAL, "Unsupported RK8XX ID %x\n", variant);
+	}
+
+	regmap = devm_regmap_init_i2c(client, regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
+	return rk8xx_probe(&client->dev, variant, client->irq, regmap);
+}
+
+static void rk8xx_i2c_shutdown(struct i2c_client *client)
+{
+	rk8xx_shutdown(&client->dev);
+}
+
+static int __maybe_unused rk8xx_i2c_suspend(struct device *dev)
+{
+	return rk8xx_suspend(dev);
+}
+
+static int __maybe_unused rk8xx_i2c_resume(struct device *dev)
+{
+	return rk8xx_resume(dev);
+}
+static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_i2c_suspend, rk8xx_i2c_resume);
+
+static const struct of_device_id rk8xx_i2c_of_match[] = {
+	{ .compatible = "rockchip,rk805" },
+	{ .compatible = "rockchip,rk808" },
+	{ .compatible = "rockchip,rk809" },
+	{ .compatible = "rockchip,rk817" },
+	{ .compatible = "rockchip,rk818" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
+
+static struct i2c_driver rk8xx_i2c_driver = {
+	.driver = {
+		.name = "rk8xx-i2c",
+		.of_match_table = rk8xx_i2c_of_match,
+		.pm = &rk8xx_i2c_pm_ops,
+	},
+	.probe_new = rk8xx_i2c_probe,
+	.shutdown  = rk8xx_i2c_shutdown,
+};
+module_i2c_driver(rk8xx_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
+MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
+MODULE_DESCRIPTION("RK8xx I2C PMIC driver");
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f71fefff400f..3618660b6a5c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -396,7 +396,7 @@ config PINCTRL_PISTACHIO
 
 config PINCTRL_RK805
 	tristate "Pinctrl and GPIO driver for RK805 PMIC"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	select GPIOLIB
 	select PINMUX
 	select GENERIC_PINCONF
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0bbfe6a7ce4d..306a9b1f897e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -725,7 +725,7 @@ config CHARGER_BQ256XX
 
 config CHARGER_RK817
 	tristate "Rockchip RK817 PMIC Battery Charger"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  Say Y to include support for Rockchip RK817 Battery Charger.
 
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e4403c6c2..d5eb240a1bb1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1039,7 +1039,7 @@ config REGULATOR_RC5T583
 
 config REGULATOR_RK808
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power regulators"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  Select this option to enable the power regulator of ROCKCHIP
 	  PMIC RK805,RK809&RK817,RK808 and RK818.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index bb63edb507da..09f59059a60f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -395,7 +395,7 @@ config RTC_DRV_NCT3018Y
 
 config RTC_DRV_RK808
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 RTC"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  If you say yes here you will get support for the
 	  RTC of RK805, RK809 and RK817, RK808 and RK818 PMIC.
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a89ddd9ba68e..4183427a80fe 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -794,4 +794,10 @@ struct rk808 {
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
 };
+
+void rk8xx_shutdown(struct device *dev);
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap);
+int rk8xx_suspend(struct device *dev);
+int rk8xx_resume(struct device *dev);
+
 #endif /* __LINUX_REGULATOR_RK808_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e3b90c425faf..fec157721703 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1210,7 +1210,7 @@ config SND_SOC_RK3328
 
 config SND_SOC_RK817
 	tristate "Rockchip RK817 audio CODEC"
-	depends on MFD_RK808 || COMPILE_TEST
+	depends on MFD_RK8XX || COMPILE_TEST
 
 config SND_SOC_RL6231
 	tristate
-- 
2.35.1

