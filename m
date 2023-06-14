Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEB7274D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjFHCQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjFHCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:16:35 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF79726A3;
        Wed,  7 Jun 2023 19:16:32 -0700 (PDT)
Received: from BillyTsai-pc.aspeed.com (192.168.1.221) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Jun
 2023 10:16:22 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patrick@stwcx.xyz>
Subject: [v6 3/4] pwm: Add Aspeed ast2600 PWM support
Date:   Thu, 8 Jun 2023 10:18:38 +0800
Message-ID: <20230608021839.12769-4-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.1.221]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of PWM controller which can be found in the Aspeed AST2600
SoC. This particular SoC features 16 PWM controllers, with each controller
capable of supporting up to 1 PWM output.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c | 309 +++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
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
index 000000000000..ae6eb197e473
--- /dev/null
+++ b/drivers/pwm/pwm-aspeed-ast2600.c
@@ -0,0 +1,309 @@
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
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/sysfs.h>
+
+/* PWM Control Register */
+#define PWM_ASPEED_CTRL				(0x00)
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
+#define PWM_ASPEED_DUTY_CYCLE			(0x04)
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
+	void __iomem *base;
+	struct reset_control *reset;
+	unsigned long clk_source;
+};
+
+static inline struct aspeed_pwm_data *
+aspeed_pwm_chip_to_data(struct pwm_chip *chip)
+{
+	return container_of(chip, struct aspeed_pwm_data, chip);
+}
+
+static int aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	bool polarity,	pin_en, clk_en;
+	u32 duty_pt, val;
+	u64 div_h, div_l, duty_cycle_period, dividend;
+
+	val = readl(priv->base + PWM_ASPEED_CTRL);
+	polarity = FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
+	pin_en = FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
+	clk_en = FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
+	div_h = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
+	div_l = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
+	val = readl(priv->base + PWM_ASPEED_DUTY_CYCLE);
+	duty_pt = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
+	duty_cycle_period = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
+
+	/*
+	 * This multiplication doesn't overflow, the upper bound is
+	 * 1000000000 * 256 * 256 << 15 = 0x1dcd650000000000
+	 */
+	dividend = (u64)NSEC_PER_SEC * (div_l + 1) * (duty_cycle_period + 1)
+		       << div_h;
+	state->period = DIV_ROUND_UP_ULL(dividend, priv->clk_source);
+
+	if (clk_en && duty_pt) {
+		dividend = (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
+				 << div_h;
+		state->duty_cycle =
+			DIV_ROUND_UP_ULL(dividend, priv->clk_source);
+	} else {
+		state->duty_cycle = clk_en ? state->period : 0;
+	}
+	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->enabled = pin_en;
+	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state->period,
+		state->duty_cycle);
+	return 0;
+}
+
+static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	u32 duty_pt;
+	u64 div_h, div_l, divisor, expect_period;
+	bool clk_en;
+
+	expect_period = min(div64_u64(ULLONG_MAX, (u64)priv->clk_source),
+			    state->period);
+	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", expect_period,
+		state->duty_cycle);
+	/*
+	 * Pick the smallest value for div_h so that div_l can be the biggest
+	 * which results in a finer resolution near the target period value.
+	 */
+	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
+		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
+	div_h = order_base_2(DIV64_U64_ROUND_UP(priv->clk_source * expect_period, divisor));
+	if (div_h > 0xf)
+		div_h = 0xf;
+
+	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
+	div_l = div64_u64(priv->clk_source * expect_period, divisor);
+
+	if (div_l == 0)
+		return -ERANGE;
+
+	div_l -= 1;
+
+	if (div_l > 255)
+		div_l = 255;
+
+	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n",
+		priv->clk_source, div_h, div_l);
+	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
+	duty_pt = div64_u64(state->duty_cycle * priv->clk_source,
+			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
+	dev_dbg(dev, "duty_cycle = %lld, duty_pt = %d\n", state->duty_cycle,
+		duty_pt);
+
+	/*
+	 * Fixed DUTY_CYCLE_PERIOD to its max value to get a
+	 * fine-grained resolution for duty_cycle at the expense of a
+	 * coarser period resolution.
+	 */
+	writel((readl(priv->base + PWM_ASPEED_DUTY_CYCLE) &
+		~(PWM_ASPEED_DUTY_CYCLE_PERIOD)) |
+		       FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
+				  PWM_ASPEED_FIXED_PERIOD),
+	       priv->base + PWM_ASPEED_DUTY_CYCLE);
+
+	if (duty_pt == 0) {
+		/* emit inactive level and assert the duty counter reset */
+		clk_en = 0;
+	} else {
+		clk_en = 1;
+		if (duty_pt >= (PWM_ASPEED_FIXED_PERIOD + 1))
+			duty_pt = 0;
+		writel((readl(priv->base + PWM_ASPEED_DUTY_CYCLE) &
+			~(PWM_ASPEED_DUTY_CYCLE_RISING_POINT |
+			  PWM_ASPEED_DUTY_CYCLE_FALLING_POINT)) |
+			       FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
+					  duty_pt),
+		       priv->base + PWM_ASPEED_DUTY_CYCLE);
+	}
+
+	writel((readl(priv->base + PWM_ASPEED_CTRL) &
+		~(PWM_ASPEED_CTRL_CLK_DIV_H | PWM_ASPEED_CTRL_CLK_DIV_L |
+		  PWM_ASPEED_CTRL_PIN_ENABLE | PWM_ASPEED_CTRL_CLK_ENABLE |
+		  PWM_ASPEED_CTRL_INVERSE)) |
+		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
+		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l) |
+		       FIELD_PREP(PWM_ASPEED_CTRL_PIN_ENABLE, state->enabled) |
+		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_ENABLE, clk_en) |
+		       FIELD_PREP(PWM_ASPEED_CTRL_INVERSE, state->polarity),
+	       priv->base + PWM_ASPEED_CTRL);
+
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
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Couldn't get clock\n");
+	priv->clk_source = clk_get_rate(priv->clk);
+	priv->reset = devm_reset_control_get_shared(dev, NULL);
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
+	priv->chip.npwm = 1;
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

