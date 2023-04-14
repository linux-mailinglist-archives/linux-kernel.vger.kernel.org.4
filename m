Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD036E2064
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDNKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21727AA0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so7948215wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681467140; x=1684059140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64UdctYKJnZ2I8K7Xw7XUZPJyeDSHiF3GJmb3RFlEcY=;
        b=fIwf4SNNAxcpCwcBy30zXR1RqlLJpwpw0KAtbj1Eu7LKkrVTGMwjcYZKXuv+fWlQNS
         edGuvKe2QjKbbJAxFTulgrbDhZ3fBw0fC8EhGmmwB1dVr3aEQbmtattfO4+XydFJqtu7
         IGakC/emLwhfmOGZIbHdsWg+hDWsvucA8j28ufshC3mQ7HgQXKecFKrVNoT364PpFUTX
         /BLoHRhhEYqIpE204R8aARg/555G1FMLorQy9ErKPFmSyjRqAd4pYkhwBY84zAJqkPAQ
         LksEU2nCatymbB4bjqqZs33wYaIddRER1H5GvqY28Slqc2o72qhrf3j4Kqop9PaN8rI1
         6F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467140; x=1684059140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64UdctYKJnZ2I8K7Xw7XUZPJyeDSHiF3GJmb3RFlEcY=;
        b=V19jMEE4whmeRE9owBYCk02uO0uNhRMCEx3ipKHEZtMYIy47ZNCnvtno+NXBgb6IjB
         AekHHg9UfDWKoBggsN/D4brd/S18UJSN9UKw4V0qDCZOt7M01NSG1V7rXKZvJz5clF3z
         +R6iB0MfF/IqPdPfWl1OSbSvrELeI2NbuM2hYExcC1QRXxjBbgOL4x9uCqiU2ZFsugRA
         z1mdpnh+Jj1mUZQU/nj4ILTah7l/P2fxzGy0uFkroioMylW2PE3IpFCEr9+p0XTKyguh
         hy+ifxV7ZSnCH0vl1UDvy9Nmkjm4kWXNH1il+rVcGK83AojPlZEddG1oBpnXjD12wrj0
         I/8g==
X-Gm-Message-State: AAQBX9dWzyH7LmuDDbesHg9KBgOLmqhljfDNfm1lKp7KZ6UILOYhqtz2
        haEZCUoMAh4w69DC2msSy0pahA==
X-Google-Smtp-Source: AKy350bBVveKplgqAHAmKTXLzV940tMX75tC7mLeENBMWZxZV4RB7VMZqsri1b5TXxAgAYONifLM0Q==
X-Received: by 2002:a05:600c:224e:b0:3e2:2467:d3f5 with SMTP id a14-20020a05600c224e00b003e22467d3f5mr4075593wmm.25.1681467140161;
        Fri, 14 Apr 2023 03:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003ef5e5f93f5sm7612923wms.19.2023.04.14.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:12:19 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: [PATCH v3 2/3] pinctrl: tps6594: add for TPS6594 PMIC
Date:   Fri, 14 Apr 2023 12:12:16 +0200
Message-Id: <20230414101217.1342891-3-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414101217.1342891-1-eblanc@baylibre.com>
References: <20230414101217.1342891-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TPS6594 PMIC has 11 GPIOs which can be used for different
functions.

This add a pinctrl and pinmux drivers in order to use those functions.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/pinctrl/Kconfig           |  10 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 365 ++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index dcb53c4a9584..2c1826e86a54 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -499,6 +499,16 @@ config PINCTRL_THUNDERBAY
 	  rate control and direction control. This module will be
 	  called as pinctrl-thunderbay.
 
+config PINCTRL_TPS6594
+	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	select PINMUX
+	select GPIOLIB
+	help
+	  This driver supports GPIOs and pinmuxing for the TPS6594
+	  PMICs chip family.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..ddaee9459da7 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
new file mode 100644
index 000000000000..0f424cbd21a8
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinmux and GPIO driver for tps6594 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
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
2.39.2

