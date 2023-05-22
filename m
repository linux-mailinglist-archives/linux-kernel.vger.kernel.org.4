Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A970C378
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjEVQbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjEVQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:31:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4179E70
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-309550d4f73so2552541f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684773079; x=1687365079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbe+PpwxNeZ9FhCSZTXEhEfAudTQs4JubRLdbyg6O94=;
        b=3LVyULlCTgSzncTtKceGuNucs35noX1YBKN1hXPSFzrpDD0NzVce8L1UmzsLSdXVQz
         T71OnrVmdPmjsdZv+Y1aWj6nfl6464UJusmRatVwwY3d8pKhlF/Z3KKbo4MN7IR0/dgC
         Q+GXXuIBE0T1cH8a9YfL8C9/TRVqowHMXYDMcbWR7wF4dpmG0Zf54aIfiKOiZiPKfDUm
         H9mjvUC6pVepM5/dcl3SSZ2n7khdcR5iq4YlxLLquHJgxmnOArK08EgcYhNHnoihrXMD
         YguIf3zUP+coG+uLpjdnxCbebBLjAbf9PssylMw7EKKaNg1juqdj8uYUWDFaUucE+Cxv
         /Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773079; x=1687365079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbe+PpwxNeZ9FhCSZTXEhEfAudTQs4JubRLdbyg6O94=;
        b=MhldQZa12o2TrS5lDBvN26a/YNoeFrAipTB/rQpwAVI9Sp5NacUZhpSETxgzpbwdnX
         L0a2z2s0nnAQ7btA5DLAa+IR9KkblZ5dkykPPodYhaZQmIHUiH66Cea75cwyRrvFPdBX
         bAulNCRmbqp9fFIhu8P8bLLp680iBTjnCAa2gnpCCQDmKG5FYnLioplaa4iUgHCb2P3c
         sfv6LE0rYpXXcoP6ezYn4CKe7LA8psxyJYOK7zrd73tZpg/E13Tu6NvqIRJIEjFUTGJk
         Fgf1EwYeCXAdLUnSdMKGP9CxvRLX1td+F8yQKlrH4rO9WNDMA/kdeVUHtgxktV5Jz7kL
         7ABg==
X-Gm-Message-State: AC+VfDw2zLD3Poti5c8Q+x/Uh4J8P23DlMT6TBHQDlahYkbXAA8vtbGW
        6t0FHw16ZtjOkvi7OyUq18tuXQ==
X-Google-Smtp-Source: ACHHUZ4iVmc+AbHfkwdarL7Ex7IJZPsPYdnHwtWC2Z6NyZUOMDHQCts+3IMP0fFjdQvTGtBIM3mkZA==
X-Received: by 2002:a5d:6a04:0:b0:30a:8a64:ad0c with SMTP id m4-20020a5d6a04000000b0030a8a64ad0cmr3394757wru.20.1684773078790;
        Mon, 22 May 2023 09:31:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:72d:52cc:8221:fcda])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b002f103ca90cdsm8152677wrp.101.2023.05.22.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:31:18 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: [PATCH v5 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
Date:   Mon, 22 May 2023 18:31:14 +0200
Message-Id: <20230522163115.2592883-3-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522163115.2592883-1-eblanc@baylibre.com>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pinctrl/Kconfig           |  13 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 367 ++++++++++++++++++++++++++++++
 include/linux/mfd/tps6594.h       |   3 +-
 4 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5787c579dcf6..73903fa59776 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -480,6 +480,19 @@ config PINCTRL_TB10X
 	depends on OF && ARC_PLAT_TB10X
 	select GPIOLIB
 
+config PINCTRL_TPS6594
+	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	select PINMUX
+	select GPIOLIB
+	select REGMAP
+	select GPIO_REGMAP
+	help
+	  Say Y to select the pinmuxing and GPIOs driver for the TPS6594
+	  PMICs chip family. This driver can also be built as a module
+	  called tps6594-pinctrl.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e196c6e324ad..28271a8d5275 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
+obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
new file mode 100644
index 000000000000..e663109249db
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinmux and GPIO driver for tps6594 PMIC
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
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
+#define FUNCTION(n, g, v)                                                    \
+	{                                                                    \
+		.pinfunction = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)), \
+		.muxval = v,                                                 \
+	}
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
+static const char *const tps6594_gpio_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4",  "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+static const char *const tps6594_nsleep1_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4",  "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+static const char *const tps6594_nsleep2_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4",  "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+static const char *const tps6594_wkup1_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4",  "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+static const char *const tps6594_wkup2_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4",  "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+static const char *const tps6594_scl_i2c2_cs_spi_func_group_names[] = {
+	"GPIO0",
+	"GPIO1",
+};
+static const char *const tps6594_nrstout_soc_func_group_names[] = {
+	"GPIO0",
+	"GPIO10",
+};
+static const char *const tps6594_trig_wdog_func_group_names[] = {
+	"GPIO1",
+	"GPIO10",
+};
+static const char *const tps6594_sda_i2c2_sdo_spi_func_group_names[] = {
+	"GPIO1",
+};
+static const char *const tps6594_clk32kout_func_group_names[] = {
+	"GPIO2",
+	"GPIO3",
+	"GPIO7",
+};
+static const char *const tps6594_nerr_soc_func_group_names[] = {
+	"GPIO2",
+};
+static const char *const tps6594_sclk_spmi_func_group_names[] = {
+	"GPIO4",
+};
+static const char *const tps6594_sdata_spmi_func_group_names[] = {
+	"GPIO5",
+};
+static const char *const tps6594_nerr_mcu_func_group_names[] = {
+	"GPIO6",
+};
+static const char *const tps6594_syncclkout_func_group_names[] = {
+	"GPIO7",
+	"GPIO9",
+};
+static const char *const tps6594_disable_wdog_func_group_names[] = {
+	"GPIO7",
+	"GPIO8",
+};
+static const char *const tps6594_pdog_func_group_names[] = {
+	"GPIO8",
+};
+static const char *const tps6594_syncclkin_func_group_names[] = {
+	"GPIO9",
+};
+
+struct tps6594_pinctrl_function {
+	struct pinfunction pinfunction;
+	u8 muxval;
+};
+
+static const struct tps6594_pinctrl_function pinctrl_functions[] = {
+	FUNCTION("gpio", tps6594_gpio_func_group_names,
+		 TPS6594_PINCTRL_GPIO_FUNCTION),
+	FUNCTION("nsleep1", tps6594_nsleep1_func_group_names,
+		 TPS6594_PINCTRL_NSLEEP1_FUNCTION),
+	FUNCTION("nsleep2", tps6594_nsleep2_func_group_names,
+		 TPS6594_PINCTRL_NSLEEP2_FUNCTION),
+	FUNCTION("wkup1", tps6594_wkup1_func_group_names,
+		 TPS6594_PINCTRL_WKUP1_FUNCTION),
+	FUNCTION("wkup2", tps6594_wkup2_func_group_names,
+		 TPS6594_PINCTRL_WKUP2_FUNCTION),
+	FUNCTION("scl_i2c2-cs_spi", tps6594_scl_i2c2_cs_spi_func_group_names,
+		 TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION),
+	FUNCTION("nrstout_soc", tps6594_nrstout_soc_func_group_names,
+		 TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION),
+	FUNCTION("trig_wdog", tps6594_trig_wdog_func_group_names,
+		 TPS6594_PINCTRL_TRIG_WDOG_FUNCTION),
+	FUNCTION("sda_i2c2-sdo_spi", tps6594_sda_i2c2_sdo_spi_func_group_names,
+		 TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION),
+	FUNCTION("clk32kout", tps6594_clk32kout_func_group_names,
+		 TPS6594_PINCTRL_CLK32KOUT_FUNCTION),
+	FUNCTION("nerr_soc", tps6594_nerr_soc_func_group_names,
+		 TPS6594_PINCTRL_NERR_SOC_FUNCTION),
+	FUNCTION("sclk_spmi", tps6594_sclk_spmi_func_group_names,
+		 TPS6594_PINCTRL_SCLK_SPMI_FUNCTION),
+	FUNCTION("sdata_spmi", tps6594_sdata_spmi_func_group_names,
+		 TPS6594_PINCTRL_SDATA_SPMI_FUNCTION),
+	FUNCTION("nerr_mcu", tps6594_nerr_mcu_func_group_names,
+		 TPS6594_PINCTRL_NERR_MCU_FUNCTION),
+	FUNCTION("syncclkout", tps6594_syncclkout_func_group_names,
+		 TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION),
+	FUNCTION("disable_wdog", tps6594_disable_wdog_func_group_names,
+		 TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION),
+	FUNCTION("pdog", tps6594_pdog_func_group_names,
+		 TPS6594_PINCTRL_PDOG_FUNCTION),
+	FUNCTION("syncclkin", tps6594_syncclkin_func_group_names,
+		 TPS6594_PINCTRL_SYNCCLKIN_FUNCTION),
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
+	return pinctrl->funcs[selector].pinfunction.name;
+}
+
+static int tps6594_pmx_func_groups(struct pinctrl_dev *pctldev,
+				   unsigned int selector,
+				   const char *const **groups,
+				   unsigned int *num_groups)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pinctrl->funcs[selector].pinfunction.groups;
+	*num_groups = pinctrl->funcs[selector].pinfunction.ngroups;
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
+	*pins = &pinctrl->pins[selector].number;
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(pinctrl->pctl_dev),
+				     "Couldn't register pinctrl driver\n");
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(pinctrl->gpio_regmap),
+				     "Couldn't register gpio_regmap driver\n");
+	}
+
+	return 0;
+}
+
+static struct platform_driver tps6594_pinctrl_driver = {
+	.driver = { .name = "tps6594-pinctrl" },
+	.probe = tps6594_pinctrl_probe,
+};
+
+module_platform_driver(tps6594_pinctrl_driver);
+MODULE_ALIAS("platform:tps6594-pinctrl");
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 pinctrl and GPIO driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
index 3f7c5e23cd4c..2792841f555c 100644
--- a/include/linux/mfd/tps6594.h
+++ b/include/linux/mfd/tps6594.h
@@ -47,7 +47,8 @@ enum pmic_id {
 #define TPS6594_REG_VMON2_PG_WINDOW			0x2f
 #define TPS6594_REG_VMON2_PG_LEVEL			0x30
 
-#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
+// Used to compute register address of GPIO1_CONF to GPIO11_CONF
+#define TPS6594_REG_GPIOX_CONF(gpio_inst)	(0x31 + (gpio_inst))
 #define TPS6594_REG_NPWRON_CONF				0x3c
 #define TPS6594_REG_GPIO_OUT_1				0x3d
 #define TPS6594_REG_GPIO_OUT_2				0x3e
-- 
2.39.2

