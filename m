Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A4700A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbjELOSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbjELOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:18:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0C1437F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:18:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so71297665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683901079; x=1686493079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGhBjJo+JVdy9s+IWKqzkk008TA/3her7F+1ovBD+R0=;
        b=IRCkhNMe6gnO5QYQ/pQPQMNzVoyE2X3wo0q+yRwCTYzofvfw7HgXKAu/OsxZ9Z7Vgx
         XmFs29OuE666JZprcgl2/X580weogi7KL9S8s1hKWno9pWkqzwTAWPFlpzPuo1I+i1aW
         YEQpjmZnUOB+zh/e6cQZTg7SY7pJzWf6X4Fnu5KfjnPejITwAl1cXCk+zG1ypu4LKDeD
         mq15eeex+Y0dIzTRXbJ4n/fQ8oRPVI2340YPeddU0hPwRdvpKlDnP14Zt2FH5THN604j
         UGCgJlBjYh8YeJQawiDHwQDEm8YQopwkR7kYMuWfNSxw1CBLti5uSYBYu7YwOxc6+kxl
         tW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683901079; x=1686493079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGhBjJo+JVdy9s+IWKqzkk008TA/3her7F+1ovBD+R0=;
        b=PdL5uonDwQFIcSVynHwh5EIEWnrvMenmMyNI2YYJytAhCU+Y/bl8dgJZ1FTzh4Bvxj
         hE6lm+3b3v31u7tR+wnYKzJTaiV1zJybwcQo2M74c99BmOI3iRPaowOgCy/lHc2aKsDB
         Ld/0FUq05yOXCThhrgHEWAPgOIZuMHpWrvBEjVYN1aZ6RYz1dSHV0A6I1GtvguatxiDF
         mLy6JjxkWtRqflq2j8yHOSO6bV1bj4dVti+yoyb4c6b4k/iE0Z3+jrQtspUNoKku1Bvy
         dsJVVCpl6KU7JR5peIHwTzA6SfMri9x72l/izk6HUOKSPDWWygPFjOOQ3f1MLRA5Vrb8
         gOfA==
X-Gm-Message-State: AC+VfDxMsbsQZbNzxesLHEvi0vPOBDma7jcOyoLT9or23sJA4TJbpDoX
        n55q0PIZXZWeid4LStJJu7AnWw==
X-Google-Smtp-Source: ACHHUZ6WSFcOPy6cBMx2TNzv2NTTcKN/axT3VK5JGPavmq6wgkKoCHBUuRKiVU5hwn4/QhzuMRBkQA==
X-Received: by 2002:a7b:c012:0:b0:3f0:9d1a:223b with SMTP id c18-20020a7bc012000000b003f09d1a223bmr19030562wmb.16.1683901079538;
        Fri, 12 May 2023 07:17:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:c0c4:a67e:f152:1413])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d494c000000b003077f3dfcc8sm22819982wrs.32.2023.05.12.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:17:59 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        sterzik@ti.com, u-kumar1@ti.com
Subject: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
Date:   Fri, 12 May 2023 16:17:54 +0200
Message-Id: <20230512141755.1712358-3-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512141755.1712358-1-eblanc@baylibre.com>
References: <20230512141755.1712358-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TPS6594 PMIC has 11 GPIOs which can be used
for different functions.

This patch adds a pinctrl and GPIO drivers in
order to use those functions.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/pinctrl/Kconfig           |  31 +++
 drivers/pinctrl/Makefile          |   2 +
 drivers/pinctrl/pinctrl-tps6594.c | 301 ++++++++++++++++++++++++++++++
 include/linux/mfd/tps6594.h       |   3 +-
 4 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5787c579dcf6..dd73df978d5c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -480,6 +480,37 @@ config PINCTRL_TB10X
 	depends on OF && ARC_PLAT_TB10X
 	select GPIOLIB
 
+config PINCTRL_THUNDERBAY
+	tristate "Generic pinctrl and GPIO driver for Intel Thunder Bay SoC"
+	depends on ARCH_THUNDERBAY || (ARM64 && COMPILE_TEST)
+	depends on HAS_IOMEM
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select GPIO_GENERIC
+	help
+	  This selects pin control driver for the Intel Thunder Bay SoC.
+	  It provides pin config functions such as pull-up, pull-down,
+	  interrupt, drive strength, sec lock, Schmitt trigger, slew
+	  rate control and direction control. This module will be
+	  called as pinctrl-thunderbay.
+
+config PINCTRL_TPS6594
+	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	select PINMUX
+	select GPIOLIB
+	select REGMAP
+	select GPIO_REGMAP
+	help
+	  This driver supports GPIOs and pinmuxing for the TPS6594
+	  PMICs chip family.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e196c6e324ad..a48cbf4e6126 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -49,6 +49,8 @@ obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
+obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
new file mode 100644
index 000000000000..322e83ce8f6e
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinmux and GPIO driver for tps6594 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/gpio/regmap.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <linux/mfd/tps6594.h>
+
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
+	struct gpio_regmap *gpio_regmap;
+	struct pinctrl_dev *pctl_dev;
+	const struct tps6594_pinctrl_function *funcs;
+	const struct pinctrl_pin_desc *pins;
+};
+
+static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
+				     unsigned int base, unsigned int offset,
+				     unsigned int *reg, unsigned int *mask)
+{
+	unsigned int line = offset % 8;
+	unsigned int stride = offset / 8;
+
+	switch (base) {
+	case TPS6594_REG_GPIO1_CONF:
+		*reg = TPS6594_REG_GPIOX_CONF(offset);
+		*mask = TPS6594_BIT_GPIO_DIR;
+		break;
+	case TPS6594_REG_GPIO_IN_1:
+	case TPS6594_REG_GPIO_OUT_1:
+		*reg = base + stride;
+		*mask = BIT(line);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
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
+	struct gpio_regmap_config config = {};
+
+	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+	pctrl_desc->name = dev_name(&pdev->dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = tps6594_pins;
+	pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
+	pctrl_desc->pctlops = &tps6594_pctrl_ops;
+	pctrl_desc->pmxops = &tps6594_pmx_ops;
+
+	pinctrl = devm_kzalloc(&pdev->dev, sizeof(*pinctrl), GFP_KERNEL);
+	if (!pinctrl)
+		return -ENOMEM;
+	pinctrl->tps = dev_get_drvdata(pdev->dev.parent);
+	pinctrl->funcs = pinctrl_functions;
+	pinctrl->pins = tps6594_pins;
+	pinctrl->pctl_dev =
+		devm_pinctrl_register(&pdev->dev, pctrl_desc, pinctrl);
+	if (IS_ERR(pinctrl->pctl_dev)) {
+		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
+		return PTR_ERR(pinctrl->pctl_dev);
+	}
+
+	config.parent = tps->dev;
+	config.regmap = tps->regmap;
+	config.ngpio = TPS6594_PINCTRL_PINS_NB;
+	config.ngpio_per_reg = 8;
+	config.reg_dat_base = TPS6594_REG_GPIO_IN_1;
+	config.reg_set_base = TPS6594_REG_GPIO_OUT_1;
+	config.reg_dir_out_base = TPS6594_REG_GPIO1_CONF;
+	config.reg_mask_xlate = tps6594_gpio_regmap_xlate;
+
+	pinctrl->gpio_regmap = devm_gpio_regmap_register(&pdev->dev, &config);
+	if (IS_ERR(pinctrl->gpio_regmap)) {
+		dev_err(&pdev->dev, "Couldn't register gpio_regmap driver\n");
+		return PTR_ERR(pinctrl->pctl_dev);
+	}
+
+	return 0;
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
diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
index 3f7c5e23cd4c..93da782ed2b7 100644
--- a/include/linux/mfd/tps6594.h
+++ b/include/linux/mfd/tps6594.h
@@ -47,7 +47,8 @@ enum pmic_id {
 #define TPS6594_REG_VMON2_PG_WINDOW			0x2f
 #define TPS6594_REG_VMON2_PG_LEVEL			0x30
 
-#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
+#define TPS6594_REG_GPIO1_CONF				0x31
+#define TPS6594_REG_GPIOX_CONF(gpio_inst)	(TPS6594_REG_GPIO1_CONF + (gpio_inst))
 #define TPS6594_REG_NPWRON_CONF				0x3c
 #define TPS6594_REG_GPIO_OUT_1				0x3d
 #define TPS6594_REG_GPIO_OUT_2				0x3e
-- 
2.39.2

