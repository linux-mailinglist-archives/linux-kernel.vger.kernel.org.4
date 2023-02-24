Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE476A1D05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBXNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBXNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:31:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0C4BE90
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p26so11395712wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1677245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AJpG3b+5nh0JP3Y3B72T/w7YEmWL2KoaIhrl1LS2N4=;
        b=4SQlr4yFY8ZKc9cIxtafVYxVATgwia3+3+8WaJdaxY6LpWQFil1vDvWBk/RQkguyiF
         bGIfV6tXuO7fFXIMsMfX2RC3cSiQAULuVR+s0nKeiyM30shyI40qE6DrbC5iqCKoKsln
         fG9VgZNhwexQlAkMb8KjR2AgsizOr8rNuH2U+1tXuotq/duRfgy8YuCz9bfkcp/gnsiG
         V5WWZQnki7KSw6TkGmN3YRTdJqnT1CZWuHZSihy02+aPqYDrkvDcHH8YnYbXohu3ZuOX
         LjHX8V71G/6NWT1LYC0KIAG+BTAnV0DYvtCYciHvP2K4NLziUSgIDFofHjgyh4UuebUr
         i7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AJpG3b+5nh0JP3Y3B72T/w7YEmWL2KoaIhrl1LS2N4=;
        b=pMYdoaPwRkHhcA5XF7iKceJXkc3hPzGVMCV1mls2IdqpxXp4xdCdYoIcNmAgj1YjUX
         XKumvGhlLi8+9UosU1wn1BYbMrv8ZXg1QE5OxJj2JnSnb4ByvAUKa7W0lGDrzvTeR0TW
         SZR8Y5BL9aVYrHPbAEzECtnWeBAJDRZ8nRF6zExgMZ0QzgYz4GM47CioRmAxnHQPRUi2
         Qt0MakVBxnPfuZQ1uhxJowXVTJ8XCq/xB2n9nJdprHgO9s4kHsUexfmLVoDpXL9trnb6
         OElJi2yznWgtOJcuIPv4nhtTtL5/1iBqdJWXSrhT4daKavG9jUcv3qrh4JrixtnlJtpc
         H/yQ==
X-Gm-Message-State: AO0yUKX5I5dbBFxgtHOEOsArwYaBUthawdfKcSpnwTY9Qf5ZlubLgD/N
        n0grPpxRwck74GopgATaU/amTg==
X-Google-Smtp-Source: AK7set9GgTxT9QPDajl0We3MlLaa8VCoWm+j0LyDjDTQM3BSMQLy1LdTioqEPGuvU8DUucyMDPD6vg==
X-Received: by 2002:a05:600c:a295:b0:3eb:29fe:70ec with SMTP id hu21-20020a05600ca29500b003eb29fe70ecmr813792wmb.27.1677245492688;
        Fri, 24 Feb 2023 05:31:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5e4:476:5145:2ad1])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm3308735wms.18.2023.02.24.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:31:32 -0800 (PST)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH INTERNAL v1 2/3] pinctrl: tps6594: add for TPS6594 PMIC
Date:   Fri, 24 Feb 2023 14:31:28 +0100
Message-Id: <20230224133129.887203-3-eblanc@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230224133129.887203-1-eblanc@baylibre.com>
References: <20230224133129.887203-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TPS6594 PMIC has 11 GPIOs which can be used for different
functions

This add a pinctrl and pinmux drivers in order to use those functions

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/pinctrl/Kconfig           |   9 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 367 ++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7d5f5458c72e..323c5b0d63bd 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -499,6 +499,15 @@ config PINCTRL_THUNDERBAY
 	  rate control and direction control. This module will be
 	  called as pinctrl-thunderbay.
 
+config PINCTRL_TPS6594
+	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
+	depends on MFD_TPS6594
+	select PINMUX
+	select GPIOLIB
+	help
+	  This driver supports the GPIO for the TPS6594 PMICs.
+	  chip family.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..ba7149883a06 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_TPS6594) += pinctrl-tps6594.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
new file mode 100644
index 000000000000..8decf758ff54
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinmux and GPIO driver for tps6594 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#define DEBUG
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <linux/mfd/tps6594.h>
+
+#define TPS6594_GPIO_DIR_IN 0
+#define TPS6594_GPIO_DIR_OUT TPS6594_BIT_GPIO_DIR
+#define TPS6594_PINCTRL_PINS_NB 11
+
+#define TPS6594_PINCTRL_GPIO_FUNCTION 0
+#define TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION 1
+#define TPS6594_PINCTRL_TRIG_WDOG_FUNCTION 1
+#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION 1
+#define TPS6594_PINCTRL_SCLK_SPMI_FUNCTION 1
+#define TPS6594_PINCTRL_SDATA_SPMI_FUNCTION 1
+#define TPS6594_PINCTRL_NERR_MCU_FUNCTION 1
+#define TPS6594_PINCTRL_PDOG_FUNCTION 1
+#define TPS6594_PINCTRL_SYNCCLKIN_FUNCTION 1
+#define TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION 2
+#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION 2
+#define TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION 2
+#define TPS6594_PINCTRL_NERR_SOC_FUNCTION 2
+#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION 3
+#define TPS6594_PINCTRL_NSLEEP1_FUNCTION 4
+#define TPS6594_PINCTRL_NSLEEP2_FUNCTION 5
+#define TPS6594_PINCTRL_WKUP1_FUNCTION 6
+#define TPS6594_PINCTRL_WKUP2_FUNCTION 7
+
+/* Special muxval for recalcitrant pins */
+#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8 2
+#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8 3
+#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9 3
+
+#define TPS6594_OFFSET_GPIO_SEL 5
+
+static const struct pinctrl_pin_desc tps6594_pins[TPS6594_PINCTRL_PINS_NB] = {
+	PINCTRL_PIN(0, "GPIO0"),   PINCTRL_PIN(1, "GPIO1"),
+	PINCTRL_PIN(2, "GPIO2"),   PINCTRL_PIN(3, "GPIO3"),
+	PINCTRL_PIN(4, "GPIO4"),   PINCTRL_PIN(5, "GPIO5"),
+	PINCTRL_PIN(6, "GPIO6"),   PINCTRL_PIN(7, "GPIO7"),
+	PINCTRL_PIN(8, "GPIO8"),   PINCTRL_PIN(9, "GPIO9"),
+	PINCTRL_PIN(10, "GPIO10"),
+};
+
+static const char *groups_name[TPS6594_PINCTRL_PINS_NB] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10"
+};
+
+struct tps6594_pinctrl_function {
+	const char *name;
+	u8 muxval;
+	const char **groups;
+	unsigned long ngroups;
+};
+
+static const struct tps6594_pinctrl_function pinctrl_functions[] = {
+	{ "gpio", TPS6594_PINCTRL_GPIO_FUNCTION, groups_name,
+	  TPS6594_PINCTRL_PINS_NB },
+	{ "nsleep1", TPS6594_PINCTRL_NSLEEP1_FUNCTION, groups_name,
+	  TPS6594_PINCTRL_PINS_NB },
+	{ "nsleep2", TPS6594_PINCTRL_NSLEEP2_FUNCTION, groups_name,
+	  TPS6594_PINCTRL_PINS_NB },
+	{ "wkup1", TPS6594_PINCTRL_WKUP1_FUNCTION, groups_name,
+	  TPS6594_PINCTRL_PINS_NB },
+	{ "wkup2", TPS6594_PINCTRL_WKUP2_FUNCTION, groups_name,
+	  TPS6594_PINCTRL_PINS_NB },
+	{ "scl_i2c2-cs_spi", TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION,
+	  (const char *[]){ "GPIO0", "GPIO1" }, 2 },
+	{ "nrstout_soc", TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION,
+	  (const char *[]){ "GPIO0", "GPIO10" }, 2 },
+	{ "trig_wdog", TPS6594_PINCTRL_TRIG_WDOG_FUNCTION,
+	  (const char *[]){ "GPIO1", "GPIO10" }, 2 },
+	{ "sda_i2c2-sdo_spi", TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION,
+	  (const char *[]){ "GPIO1" }, 1 },
+	{ "clk32kout", TPS6594_PINCTRL_CLK32KOUT_FUNCTION,
+	  (const char *[]){ "GPIO2", "GPIO3", "GPIO7" }, 3 },
+	{ "nerr_soc", TPS6594_PINCTRL_NERR_SOC_FUNCTION,
+	  (const char *[]){ "GPIO2" }, 1 },
+	{ "sclk_spmi", TPS6594_PINCTRL_SCLK_SPMI_FUNCTION,
+	  (const char *[]){ "GPIO4" }, 1 },
+	{ "sdata_spmi", TPS6594_PINCTRL_SDATA_SPMI_FUNCTION,
+	  (const char *[]){ "GPIO5" }, 1 },
+	{ "nerr_mcu", TPS6594_PINCTRL_NERR_MCU_FUNCTION,
+	  (const char *[]){ "GPIO6" }, 1 },
+	{ "syncclkout", TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION,
+	  (const char *[]){ "GPIO7", "GPIO9" }, 2 },
+	{ "disable_wdog", TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION,
+	  (const char *[]){ "GPIO7", "GPIO8" }, 2 },
+	{ "pdog", TPS6594_PINCTRL_PDOG_FUNCTION, (const char *[]){ "GPIO8" },
+	  1 },
+	{ "syncclkin", TPS6594_PINCTRL_SYNCCLKIN_FUNCTION,
+	  (const char *[]){ "GPIO9" }, 1 },
+};
+
+struct tps6594_pinctrl {
+	struct tps6594 *tps;
+	struct gpio_chip gpio_chip;
+	struct pinctrl_dev *pctl_dev;
+	const struct tps6594_pinctrl_function *funcs;
+	const struct pinctrl_pin_desc *pins;
+};
+
+static int tps6594_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps6594_pinctrl *pinctrl = gpiochip_get_data(gc);
+	int ret, val;
+
+	ret = regmap_read(pinctrl->tps->regmap, TPS6594_REG_GPIOX_IN(offset),
+			  &val);
+	if (ret < 0)
+		return ret;
+
+	val = (val & TPS6594_BIT_GPIOX_IN(offset)) > 0;
+
+	return val;
+}
+
+static void tps6594_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
+{
+	struct tps6594_pinctrl *pinctrl = gpiochip_get_data(gc);
+	unsigned int set_register = TPS6594_REG_GPIOX_OUT(offset);
+	int ret;
+
+	ret = regmap_update_bits(pinctrl->tps->regmap, set_register,
+				 TPS6594_BIT_GPIOX_OUT(offset),
+				 value ? TPS6594_BIT_GPIOX_OUT(offset) : 0);
+	if (ret < 0)
+		dev_err(pinctrl->tps->dev,
+			"gpio_set failed to set GPIO%d to %d: %d\n", offset,
+			value, ret);
+}
+
+static int tps6594_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps6594_pinctrl *pinctrl = gpiochip_get_data(gc);
+	int ret;
+
+	ret = regmap_test_bits(pinctrl->tps->regmap,
+			       TPS6594_REG_GPIOX_CONF(offset),
+			       TPS6594_BIT_GPIO_DIR);
+	if (ret < 0) {
+		dev_err(pinctrl->tps->dev,
+			"gpio_get_direction for GPIO%d failed: %d\n", offset,
+			ret);
+		return ret;
+	}
+
+	/*
+	 * TPS6594 direction is 0 = input and 1 = output but Linux direction is 0 = output and
+	 * 1 = input
+	 * Let's invert our value
+	 */
+	return !ret;
+}
+
+static int tps6594_gpio_change_direction(struct gpio_chip *gc,
+					 unsigned int offset,
+					 unsigned int direction)
+{
+	struct tps6594_pinctrl *pinctrl = gpiochip_get_data(gc);
+	int ret;
+
+	ret = regmap_update_bits(pinctrl->tps->regmap,
+				 TPS6594_REG_GPIOX_CONF(offset),
+				 TPS6594_BIT_GPIO_DIR, direction);
+	if (ret < 0)
+		dev_err(pinctrl->tps->dev,
+			"gpio_change_direction for GPIO%d to %u direction failed: %d\n",
+			offset, direction, ret);
+
+	return ret;
+}
+
+static int tps6594_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	return tps6594_gpio_change_direction(gc, offset, TPS6594_GPIO_DIR_IN);
+}
+
+static int tps6594_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset, int value)
+{
+	tps6594_gpio_set(gc, offset, value);
+
+	return tps6594_gpio_change_direction(gc, offset, TPS6594_GPIO_DIR_OUT);
+}
+
+static const struct gpio_chip template_gpio_chip = {
+	.label = "tps6594-gpio",
+	.owner = THIS_MODULE,
+	.get_direction = tps6594_gpio_get_direction,
+	.direction_input = tps6594_gpio_direction_input,
+	.direction_output = tps6594_gpio_direction_output,
+	.get = tps6594_gpio_get,
+	.set = tps6594_gpio_set,
+	.base = -1,
+	.ngpio = TPS6594_PINCTRL_PINS_NB,
+	.can_sleep = true,
+};
+
+static int tps6594_pmx_func_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(pinctrl_functions);
+}
+
+static const char *tps6594_pmx_func_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl->funcs[selector].name;
+}
+
+static int tps6594_pmx_func_groups(struct pinctrl_dev *pctldev,
+				   unsigned int selector,
+				   const char *const **groups,
+				   unsigned int *num_groups)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pinctrl->funcs[selector].groups;
+	*num_groups = pinctrl->funcs[selector].ngroups;
+
+	return 0;
+}
+
+static int tps6594_pmx_set(struct tps6594_pinctrl *pinctrl, unsigned int pin,
+			   u8 muxval)
+{
+	u8 mux_sel_val = muxval << TPS6594_OFFSET_GPIO_SEL;
+
+	return regmap_update_bits(pinctrl->tps->regmap,
+				  TPS6594_REG_GPIOX_CONF(pin),
+				  TPS6594_MASK_GPIO_SEL, mux_sel_val);
+}
+
+static int tps6594_pmx_set_mux(struct pinctrl_dev *pctldev,
+			       unsigned int function, unsigned int group)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+	u8 muxval = pinctrl->funcs[function].muxval;
+
+	/* Some pins don't have the same muxval for the same function... */
+	if (group == 8) {
+		if (muxval == TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION)
+			muxval = TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8;
+		else if (muxval == TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION)
+			muxval = TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8;
+	} else if (group == 9) {
+		if (muxval == TPS6594_PINCTRL_CLK32KOUT_FUNCTION)
+			muxval = TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9;
+	}
+
+	return tps6594_pmx_set(pinctrl, group, muxval);
+}
+
+static int tps6594_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+					  struct pinctrl_gpio_range *range,
+					  unsigned int offset, bool input)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+	u8 muxval = pinctrl->funcs[TPS6594_PINCTRL_GPIO_FUNCTION].muxval;
+
+	return tps6594_pmx_set(pinctrl, offset, muxval);
+}
+
+static const struct pinmux_ops tps6594_pmx_ops = {
+	.get_functions_count = tps6594_pmx_func_cnt,
+	.get_function_name = tps6594_pmx_func_name,
+	.get_function_groups = tps6594_pmx_func_groups,
+	.set_mux = tps6594_pmx_set_mux,
+	.gpio_set_direction = tps6594_pmx_gpio_set_direction,
+	.strict = true,
+};
+
+static int tps6594_groups_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(tps6594_pins);
+}
+
+static int tps6594_group_pins(struct pinctrl_dev *pctldev,
+			      unsigned int selector, const unsigned int **pins,
+			      unsigned int *num_pins)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned int *)&pinctrl->pins[selector];
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const char *tps6594_group_name(struct pinctrl_dev *pctldev,
+				      unsigned int selector)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl->pins[selector].name;
+}
+
+static const struct pinctrl_ops tps6594_pctrl_ops = {
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
+	.dt_free_map = pinconf_generic_dt_free_map,
+	.get_groups_count = tps6594_groups_cnt,
+	.get_group_name = tps6594_group_name,
+	.get_group_pins = tps6594_group_pins,
+};
+
+static int tps6594_pinctrl_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct tps6594_pinctrl *pinctrl;
+	struct pinctrl_desc *pctrl_desc;
+
+	pinctrl = devm_kzalloc(&pdev->dev, sizeof(*pinctrl), GFP_KERNEL);
+	if (!pinctrl)
+		return -ENOMEM;
+
+	pinctrl->tps = dev_get_drvdata(pdev->dev.parent);
+	pinctrl->gpio_chip = template_gpio_chip;
+	pinctrl->gpio_chip.parent = tps->dev;
+
+	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+
+	pctrl_desc->name = dev_name(&pdev->dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = tps6594_pins;
+	pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
+	pctrl_desc->pctlops = &tps6594_pctrl_ops;
+	pctrl_desc->pmxops = &tps6594_pmx_ops;
+	pinctrl->funcs = pinctrl_functions;
+	pinctrl->pins = tps6594_pins;
+	pinctrl->pctl_dev =
+		devm_pinctrl_register(&pdev->dev, pctrl_desc, pinctrl);
+	if (IS_ERR(pinctrl->pctl_dev)) {
+		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
+		return PTR_ERR(pinctrl->pctl_dev);
+	}
+
+	return devm_gpiochip_add_data(&pdev->dev, &pinctrl->gpio_chip, pinctrl);
+}
+
+static struct platform_driver tps6594_pinctrl_driver = {
+	.driver = { .name = "tps6594-pinctrl" },
+	.probe = tps6594_pinctrl_probe,
+};
+module_platform_driver(tps6594_pinctrl_driver);
+
+MODULE_ALIAS("platform:tps6594-pinctrl");
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 pinctrl and GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

