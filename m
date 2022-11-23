Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57E635050
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiKWGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiKWGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:17:22 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB94DF802B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:16:32 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2AN5pU4L081940;
        Wed, 23 Nov 2022 13:51:32 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Nov
 2022 14:15:55 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>
Subject: [v4 4/5] pwm: Add Aspeed ast2600 PWM support
Date:   Wed, 23 Nov 2022 14:16:34 +0800
Message-ID: <20221123061635.32025-5-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2AN5pU4L081940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of PWM controller which can be found at aspeed ast2600
soc. The pwm supoorts up to 16 channels and it's part function of
multi-function device "pwm-tach controller".

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c | 318 +++++++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)
 create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..54915185d918 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -51,6 +51,16 @@ config PWM_AB8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-ab8500.
 
+config PWM_ASPEED_AST2600
+	tristate "Aspeed ast2600 PWM support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	help
+	  This driver provides support for Aspeed ast2600 PWM controllers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-aspeed-ast2600.
+
 config PWM_ATMEL
 	tristate "Atmel PWM support"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..5169c34056e6 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_ASPEED_AST2600)	+= pwm-aspeed-ast2600.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
new file mode 100644
index 000000000000..2c22aff18624
--- /dev/null
+++ b/drivers/pwm/pwm-aspeed-ast2600.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Aspeed Technology Inc.
+ *
+ * PWM controller driver for Aspeed ast2600 SoCs.
+ * This drivers doesn't support earlier version of the IP.
+ *
+ * The hardware operates in time quantities of length
+ * Q := (DIV_L + 1) << DIV_H / input-clk
+ * The length of a PWM period is (DUTY_CYCLE_PERIOD + 1) * Q.
+ * The maximal value for DUTY_CYCLE_PERIOD is used here to provide
+ * a fine grained selection for the duty cycle.
+ *
+ * This driver uses DUTY_CYCLE_RISING_POINT = 0, so from the start of a
+ * period the output is active until DUTY_CYCLE_FALLING_POINT * Q. Note
+ * that if DUTY_CYCLE_RISING_POINT = DUTY_CYCLE_FALLING_POINT the output is
+ * always active.
+ *
+ * Register usage:
+ * PIN_ENABLE: When it is unset the pwm controller will emit inactive level to the external.
+ * Use to determine whether the PWM channel is enabled or disabled
+ * CLK_ENABLE: When it is unset the pwm controller will assert the duty counter reset and
+ * emit inactive level to the PIN_ENABLE mux after that the driver can still change the pwm period
+ * and duty and the value will apply when CLK_ENABLE be set again.
+ * Use to determine whether duty_cycle bigger than 0.
+ * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inverse immediately.
+ * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POINT: When these two
+ * values are equal it means the duty cycle = 100%.
+ *
+ * The glitch may generate at:
+ * - Enabled changing when the duty_cycle bigger than 0% and less than 100%.
+ * - Polarity changing when the duty_cycle bigger than 0% and less than 100%.
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we cannot prevent in
+ *   software that the output might produce a period with mixed
+ *   settings.
+ * - Disabling the PWM doesn't complete the current period.
+ *
+ * Improvements:
+ * - When only changing one of duty cycle or period, our pwm controller will not
+ *   generate the glitch, the configure will change at next cycle of pwm.
+ *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/sysfs.h>
+
+/* The channel number of Aspeed pwm controller */
+#define PWM_ASPEED_NR_PWMS			16
+/* PWM Control Register */
+#define PWM_ASPEED_CTRL(ch)			((ch) * 0x10 + 0x00)
+#define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT	BIT(19)
+#define PWM_ASPEED_CTRL_DUTY_LOAD_AS_WDT_ENABLE	BIT(18)
+#define PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE	BIT(17)
+#define PWM_ASPEED_CTRL_CLK_ENABLE		BIT(16)
+#define PWM_ASPEED_CTRL_LEVEL_OUTPUT		BIT(15)
+#define PWM_ASPEED_CTRL_INVERSE			BIT(14)
+#define PWM_ASPEED_CTRL_OPEN_DRAIN_ENABLE	BIT(13)
+#define PWM_ASPEED_CTRL_PIN_ENABLE		BIT(12)
+#define PWM_ASPEED_CTRL_CLK_DIV_H		GENMASK(11, 8)
+#define PWM_ASPEED_CTRL_CLK_DIV_L		GENMASK(7, 0)
+
+/* PWM Duty Cycle Register */
+#define PWM_ASPEED_DUTY_CYCLE(ch)		((ch) * 0x10 + 0x04)
+#define PWM_ASPEED_DUTY_CYCLE_PERIOD		GENMASK(31, 24)
+#define PWM_ASPEED_DUTY_CYCLE_POINT_AS_WDT	GENMASK(23, 16)
+#define PWM_ASPEED_DUTY_CYCLE_FALLING_POINT	GENMASK(15, 8)
+#define PWM_ASPEED_DUTY_CYCLE_RISING_POINT	GENMASK(7, 0)
+
+/* PWM fixed value */
+#define PWM_ASPEED_FIXED_PERIOD			FIELD_MAX(PWM_ASPEED_DUTY_CYCLE_PERIOD)
+
+struct aspeed_pwm_data {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct regmap *regmap;
+	struct reset_control *reset;
+};
+
+static inline struct aspeed_pwm_data *
+aspeed_pwm_chip_to_data(struct pwm_chip *chip)
+{
+	return container_of(chip, struct aspeed_pwm_data, chip);
+}
+
+static void aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	u32 hwpwm = pwm->hwpwm;
+	bool polarity,	pin_en, clk_en;
+	u32 duty_pt, val;
+	unsigned long rate;
+	u64 div_h, div_l, duty_cycle_period, dividend;
+
+	regmap_read(priv->regmap, PWM_ASPEED_CTRL(hwpwm), &val);
+	polarity = FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
+	pin_en = FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
+	clk_en = FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
+	div_h = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
+	div_l = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
+	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE(hwpwm), &val);
+	duty_pt = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
+	duty_cycle_period = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
+
+	rate = clk_get_rate(priv->clk);
+
+	/*
+	 * This multiplication doesn't overflow, the upper bound is
+	 * 1000000000 * 256 * 256 << 15 = 0x1dcd650000000000
+	 */
+	dividend = (u64)NSEC_PER_SEC * (div_l + 1) * (duty_cycle_period + 1)
+		       << div_h;
+	state->period = DIV_ROUND_UP_ULL(dividend, rate);
+
+	if (clk_en && duty_pt) {
+		dividend = (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
+				 << div_h;
+		state->duty_cycle = DIV_ROUND_UP_ULL(dividend, rate);
+	} else {
+		state->duty_cycle = clk_en ? state->period : 0;
+	}
+	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->enabled = pin_en;
+	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state->period,
+		state->duty_cycle);
+}
+
+static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	u32 hwpwm = pwm->hwpwm, duty_pt;
+	unsigned long rate;
+	u64 div_h, div_l, divisor, expect_period;
+	bool clk_en;
+
+	rate = clk_get_rate(priv->clk);
+	expect_period = min(div64_u64(ULLONG_MAX, (u64)rate), state->period);
+	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", expect_period,
+		state->duty_cycle);
+	/*
+	 * Pick the smallest value for div_h so that div_l can be the biggest
+	 * which results in a finer resolution near the target period value.
+	 */
+	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
+		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
+	div_h = order_base_2(DIV64_U64_ROUND_UP(rate * expect_period, divisor));
+	if (div_h > 0xf)
+		div_h = 0xf;
+
+	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
+	div_l = div64_u64(rate * expect_period, divisor);
+
+	if (div_l == 0)
+		return -ERANGE;
+
+	div_l -= 1;
+
+	if (div_l > 255)
+		div_l = 255;
+
+	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n", rate, div_h,
+		div_l);
+	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
+	duty_pt = div64_u64(state->duty_cycle * rate,
+			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
+	dev_dbg(dev, "duty_cycle = %lld, duty_pt = %d\n", state->duty_cycle,
+		duty_pt);
+
+	/*
+	 * Fixed DUTY_CYCLE_PERIOD to its max value to get a
+	 * fine-grained resolution for duty_cycle at the expense of a
+	 * coarser period resolution.
+	 */
+	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE(hwpwm),
+			   PWM_ASPEED_DUTY_CYCLE_PERIOD,
+			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
+				      PWM_ASPEED_FIXED_PERIOD));
+	if (duty_pt == 0) {
+		/* emit inactive level and assert the duty counter reset */
+		clk_en = 0;
+	} else {
+		clk_en = 1;
+		if (duty_pt >= (PWM_ASPEED_FIXED_PERIOD + 1))
+			duty_pt = 0;
+		regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE(hwpwm),
+				   PWM_ASPEED_DUTY_CYCLE_RISING_POINT |
+					   PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
+				   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, duty_pt));
+	}
+
+	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL(hwpwm),
+			   PWM_ASPEED_CTRL_CLK_DIV_H | PWM_ASPEED_CTRL_CLK_DIV_L |
+				   PWM_ASPEED_CTRL_PIN_ENABLE | PWM_ASPEED_CTRL_CLK_ENABLE |
+				   PWM_ASPEED_CTRL_INVERSE,
+			   FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
+				   FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l) |
+				   FIELD_PREP(PWM_ASPEED_CTRL_PIN_ENABLE, state->enabled) |
+				   FIELD_PREP(PWM_ASPEED_CTRL_CLK_ENABLE, clk_en) |
+				   FIELD_PREP(PWM_ASPEED_CTRL_INVERSE, state->polarity));
+	return 0;
+}
+
+static const struct pwm_ops aspeed_pwm_ops = {
+	.apply = aspeed_pwm_apply,
+	.get_state = aspeed_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static void aspeed_pwm_reset_assert(void *data)
+{
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static void aspeed_pwm_chip_remove(void *data)
+{
+	struct pwm_chip *chip = data;
+
+	pwmchip_remove(chip);
+}
+
+static int aspeed_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+	struct aspeed_pwm_data *priv;
+	struct device_node *np;
+	struct platform_device *parent_dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	np = pdev->dev.parent->of_node;
+	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
+		return dev_err_probe(dev, -ENODEV,
+				     "Unsupported pwm device binding\n");
+
+	priv->regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "Couldn't get regmap\n");
+
+	parent_dev = of_find_device_by_node(np);
+	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Couldn't get clock\n");
+
+	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "Couldn't get reset control\n");
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Couldn't deassert reset control\n");
+
+	ret = devm_add_action_or_reset(dev, aspeed_pwm_reset_assert,
+				       priv->reset);
+	if (ret)
+		return ret;
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &aspeed_pwm_ops;
+	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+	ret = devm_add_action_or_reset(dev, aspeed_pwm_chip_remove,
+				       &priv->chip);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static const struct of_device_id of_pwm_match_table[] = {
+	{
+		.compatible = "aspeed,ast2600-pwm",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_pwm_match_table);
+
+static struct platform_driver aspeed_pwm_driver = {
+	.probe = aspeed_pwm_probe,
+	.driver	= {
+		.name = "aspeed-pwm",
+		.of_match_table = of_pwm_match_table,
+	},
+};
+
+module_platform_driver(aspeed_pwm_driver);
+
+MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
+MODULE_DESCRIPTION("Aspeed ast2600 PWM device driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

