Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E05731BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjFOOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbjFOOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:45:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DE2738;
        Thu, 15 Jun 2023 07:45:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so10878072e87.2;
        Thu, 15 Jun 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840309; x=1689432309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od+eFJu5Un7KQxaLhPRr3IFDtHMK7wuQZd5iaWBOH10=;
        b=fUz6JLSdDRz/tVup/zvfXMmNhkAvFf4elZjb866w5j9o8w7UZJvZ4fYnShm7SWfW9s
         pJFq27oqPsbABnjkpLREi8tW7t9kfgg7ogacwDKLOfAmx28X9DX53cCvZHFf3DSrTRsq
         DHY7Wfwn6QbUf9ArWK/S/TuneYwnSOo0/3Cb2ua2lZjdADxh0ZIiEqWju7JP0yO3XlMF
         YqIXoqMPPCGG8qKA/8Y79q/jYLQwwBKepzCeTMaDB0jnL5wjpqhH9vnA9PjK93Gh3r+6
         oLGoXXVElJVzhnXNNPwAb0UldabuNvXSrVkjpkvEV41HdzLA4FfAdqIIwQkVdzBXXkEz
         ikZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840309; x=1689432309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od+eFJu5Un7KQxaLhPRr3IFDtHMK7wuQZd5iaWBOH10=;
        b=LnU5xdY17PIB6h+KLUW1GM80W1PH/mYct/sdGrpMLF5ZV20nWsDLmtKyNApXF2pqIK
         JnPGqVDHPQ53lHUptDmxFyGYLpjRLXxQPKolDtt4HMYqQC8aunsvzvyMH4cHOQC+fC9T
         u3UbaDC59EEBbTf6cBeBmpfRIVaCMOzqLGgUcy1GrIY4DgDvVFm4hlLN/DrpFAE9BP53
         ryHwVhniehZoJsUoSKikwFLTFMXt6bDk3qNBzxbwBF4+xkxBTIAZp/vXZY0K60IocVxM
         FFdrwQWpP3+h6cyo/c650VixTFCUxqKd0iYGXpfe0wllKJ88P2c0tlRjIOapnAQDi1fT
         akRA==
X-Gm-Message-State: AC+VfDwHrW/YflPkGjtNHrUhKIMEsoUjUgQu0h32ZNneLWX/oPhQBGNs
        6/Qm2mAKvEZHsUcdfo/L0KXw751nvUG2HzhwiQ==
X-Google-Smtp-Source: ACHHUZ42J/0Jf+gDaLLKGQHbIyIlptOWp+NsU/XsK+8bJkVec+s53U9ItXSWHV2vOSUE3URFiJCKgQ==
X-Received: by 2002:a19:6d1c:0:b0:4ef:fb4b:eb2d with SMTP id i28-20020a196d1c000000b004effb4beb2dmr9341785lfc.33.1686840309008;
        Thu, 15 Jun 2023 07:45:09 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm244451lfp.186.2023.06.15.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:45:08 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: [PATCH v1 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date:   Thu, 15 Jun 2023 17:43:57 +0300
Message-Id: <20230615144423.828698-3-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615144423.828698-1-privatesub2@gmail.com>
References: <20230615144423.828698-1-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
controllers with ones supported by pwm-sun4i driver.

This patch adds a PWM controller driver for Allwinner's D1,
T113-S3 and R329 SoCs. The main difference between these SoCs
is the number of channels defined by the DT property.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sun20i.c | 364 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun20i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8df861b1f4a3..b435e50fbd3e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -594,6 +594,18 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN20I
+	tristate "Allwinner D1/T113s/R329 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
+	  The main difference between these SoCs is the number of
+	  channels defined by the DT property.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun20i.
+
 config PWM_SUNPLUS
 	tristate "Sunplus PWM support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 19899b912e00..cea872e22c78 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN20I)	+= pwm-sun20i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
new file mode 100644
index 000000000000..100b0f3bcec0
--- /dev/null
+++ b/drivers/pwm/pwm-sun20i.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
+ *
+ * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#define PWM_CLK_CFG_REG(chan)		(0x20 + (((chan) >> 1) * 0x4))
+#define PWM_CLK_SRC			7
+#define PWM_CLK_SRC_MASK		GENMASK(8, PWM_CLK_SRC)
+#define PWM_CLK_DIV_M			0
+#define PWM_CLK_DIV_M_MASK		GENMASK(3, PWM_CLK_DIV_M)
+
+#define PWM_CLK_GATE_REG		0x40
+#define PWM_CLK_GATING(chan)		BIT(chan)
+
+#define PWM_ENABLE_REG			0x80
+#define PWM_EN(chan)			BIT(chan)
+
+#define PWM_CTL_REG(chan)		(0x100 + (chan) * 0x20)
+#define PWM_ACT_STA			BIT(8)
+#define PWM_PRESCAL_K			0
+#define PWM_PRESCAL_K_MASK		GENMASK(7, PWM_PRESCAL_K)
+
+#define PWM_PERIOD_REG(chan)		(0x104 + (chan) * 0x20)
+#define PWM_ENTIRE_CYCLE		16
+#define PWM_ENTIRE_CYCLE_MASK		GENMASK(31, PWM_ENTIRE_CYCLE)
+#define PWM_ACT_CYCLE			0
+#define PWM_ACT_CYCLE_MASK		GENMASK(15, PWM_ACT_CYCLE)
+
+#define SET_VALUE(reg_val, val, name) \
+		 (reg_val = (((reg_val) & ~name##_MASK) | ((val) << (name))))
+#define GET_VALUE(reg_val, name) \
+		 (((reg_val) & ~name##_MASK) >> (name))
+
+struct sun20i_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk_bus, *clk_hosc;
+	struct reset_control *rst;
+	void __iomem *base;
+	/* Mutex to protect pwm apply state */
+	struct mutex mutex;
+};
+
+static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun20i_pwm_chip, chip);
+}
+
+static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
+				   unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
+				     u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun20i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+	u64 clk_rate, tmp;
+	u32 val;
+	u16 clk_div, act_cycle;
+	u8 prescal, div_id;
+	u8 chn = pwm->hwpwm;
+
+	mutex_lock(&sun20i_chip->mutex);
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
+	div_id = GET_VALUE(val, PWM_CLK_DIV_M);
+	if (GET_VALUE(val, PWM_CLK_SRC) == 0)
+		clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
+	else
+		clk_rate = clk_get_rate(sun20i_chip->clk_bus);
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
+	if (PWM_ACT_STA & val)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	prescal = PWM_PRESCAL_K & val;
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
+	if (PWM_EN(chn) & val)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
+	act_cycle = GET_VALUE(val, PWM_ACT_CYCLE);
+	clk_div = GET_VALUE(val, PWM_ENTIRE_CYCLE);
+
+	tmp = act_cycle * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+	tmp = clk_div * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+
+	mutex_unlock(&sun20i_chip->mutex);
+
+	return 0;
+}
+
+static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct pwm_state curstate;
+	int ret = 0;
+	u32 clk_gate, clk_cfg, pwm_en, ctl, period;
+	u64 bus_rate, hosc_rate, clk_div, val, clk_rate;
+	u16 prescaler, div_m;
+	bool use_bus_clk;
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+
+	mutex_lock(&sun20i_chip->mutex);
+	pwm_get_state(pwm, &curstate);
+
+	pwm_en = sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
+	if (state->polarity != curstate.polarity ||
+	    state->duty_cycle != curstate.duty_cycle ||
+	    state->period != curstate.period) {
+		ctl = sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
+		clk_cfg = sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
+		hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
+		bus_rate = clk_get_rate(sun20i_chip->clk_bus);
+
+		if (pwm_en & PWM_EN(pwm->hwpwm ^ 1)) {
+			/* check period only */
+			if (GET_VALUE(clk_cfg, PWM_CLK_SRC) == 0)
+				clk_rate = hosc_rate;
+			else
+				clk_rate = bus_rate;
+
+			val = state->period * clk_rate;
+			do_div(val, NSEC_PER_SEC);
+
+			div_m = GET_VALUE(clk_cfg, PWM_CLK_DIV_M);
+
+			/* calculate and set prescaler, PWM entire cycle */
+			clk_div = val;
+			for (prescaler = 0; clk_div > 65535; prescaler++) {
+				if (prescaler >= 256) {
+					dev_err(sun20i_chip->chip.dev, "Period is too long\n");
+					ret = -EINVAL;
+					goto unlock_mutex;
+				}
+
+				clk_div = val;
+				do_div(clk_div, 1U << div_m);
+				do_div(clk_div, prescaler + 1);
+			}
+		} else {
+			/* check period and select clock source */
+			use_bus_clk = false;
+			val = state->period * hosc_rate;
+			do_div(val, NSEC_PER_SEC);
+			if (val <= 1) {
+				use_bus_clk = true;
+				val = state->period * bus_rate;
+				do_div(val, NSEC_PER_SEC);
+				if (val <= 1) {
+					dev_err(sun20i_chip->chip.dev, "Period is too small\n");
+					ret = -EINVAL;
+					goto unlock_mutex;
+				}
+			}
+
+			if (use_bus_clk)
+				SET_VALUE(clk_cfg, 1, PWM_CLK_SRC);
+			else
+				SET_VALUE(clk_cfg, 0, PWM_CLK_SRC);
+
+			/* calculate and set prescaler, M factor, PWM entire cycle */
+			clk_div = val;
+			for (prescaler = div_m = 0; clk_div > 65535; prescaler++) {
+				if (prescaler >= 256) {
+					prescaler = 0;
+					div_m++;
+					if (div_m >= 9) {
+						dev_err(sun20i_chip->chip.dev, "Period is too long\n");
+						ret = -EINVAL;
+						goto unlock_mutex;
+					}
+				}
+
+				clk_div = val;
+				do_div(clk_div, 1U << div_m);
+				do_div(clk_div, prescaler + 1);
+			}
+
+			/* set up the M factor */
+			SET_VALUE(clk_cfg, div_m, PWM_CLK_DIV_M);
+
+			sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG_REG(pwm->hwpwm));
+		}
+
+		period = sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
+
+		SET_VALUE(period, clk_div, PWM_ENTIRE_CYCLE);
+		SET_VALUE(ctl, prescaler, PWM_PRESCAL_K);
+
+		/* set duty cycle */
+		val = state->period;
+		do_div(val, clk_div);
+		clk_div = state->duty_cycle;
+		do_div(clk_div, val);
+		if (clk_div > 65535)
+			clk_div = 65535;
+
+		SET_VALUE(period, clk_div, PWM_ACT_CYCLE);
+		sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD_REG(pwm->hwpwm));
+
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			ctl |= PWM_ACT_STA;
+		else
+			ctl &= ~PWM_ACT_STA;
+
+		sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL_REG(pwm->hwpwm));
+	}
+
+	if (state->enabled != curstate.enabled) {
+		clk_gate = sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE_REG);
+
+		if (state->enabled) {
+			clk_gate |= PWM_CLK_GATING(pwm->hwpwm);
+			pwm_en |= PWM_EN(pwm->hwpwm);
+		} else {
+			clk_gate &= ~PWM_CLK_GATING(pwm->hwpwm);
+			pwm_en &= ~PWM_EN(pwm->hwpwm);
+		}
+		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
+		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG);
+	}
+
+unlock_mutex:
+	mutex_unlock(&sun20i_chip->mutex);
+
+	return ret;
+}
+
+static const struct pwm_ops sun20i_pwm_ops = {
+	.get_state = sun20i_pwm_get_state,
+	.apply = sun20i_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id sun20i_pwm_dt_ids[] = {
+	{ .compatible = "allwinner,sun20i-d1-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
+
+static int sun20i_pwm_probe(struct platform_device *pdev)
+{
+	struct sun20i_pwm_chip *sun20i_chip;
+	int ret;
+
+	sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
+	if (!sun20i_chip)
+		return -ENOMEM;
+
+	sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun20i_chip->base))
+		return PTR_ERR(sun20i_chip->base);
+
+	sun20i_chip->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(sun20i_chip->clk_bus)) {
+		dev_err(&pdev->dev, "Failed to get bus clock\n");
+		return PTR_ERR(sun20i_chip->clk_bus);
+	}
+
+	sun20i_chip->clk_hosc = devm_clk_get(&pdev->dev, "hosc");
+	if (IS_ERR(sun20i_chip->clk_hosc)) {
+		dev_err(&pdev->dev, "Failed to get hosc clock\n");
+		return PTR_ERR(sun20i_chip->clk_hosc);
+	}
+
+	sun20i_chip->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(sun20i_chip->rst)) {
+		dev_err(&pdev->dev, "Failed to get bus reset\n");
+		return PTR_ERR(sun20i_chip->rst);
+	}
+
+	/* Deassert reset */
+	ret = reset_control_deassert(sun20i_chip->rst);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to deassert reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(sun20i_chip->clk_bus);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to ungate bus clock\n");
+		goto err_bus;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "allwinner,pwm-channels",
+				   &sun20i_chip->chip.npwm);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't get pwm-channels\n");
+		goto err_pwm_add;
+	}
+
+	sun20i_chip->chip.dev = &pdev->dev;
+	sun20i_chip->chip.ops = &sun20i_pwm_ops;
+
+	mutex_init(&sun20i_chip->mutex);
+
+	ret = pwmchip_add(&sun20i_chip->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
+		goto err_pwm_add;
+	}
+
+	platform_set_drvdata(pdev, sun20i_chip);
+
+	return 0;
+
+err_pwm_add:
+	clk_disable_unprepare(sun20i_chip->clk_bus);
+err_bus:
+	reset_control_assert(sun20i_chip->rst);
+	return ret;
+}
+
+static void sun20i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun20i_pwm_chip *sun20i_chip = platform_get_drvdata(pdev);
+	int ret;
+
+	pwmchip_remove(&sun20i_chip->chip);
+
+	clk_disable_unprepare(sun20i_chip->clk_bus);
+	reset_control_assert(sun20i_chip->rst);
+}
+
+static struct platform_driver sun20i_pwm_driver = {
+	.driver = {
+		.name = "sun20i-pwm",
+		.of_match_table = sun20i_pwm_dt_ids,
+	},
+	.probe = sun20i_pwm_probe,
+	.remove_new = sun20i_pwm_remove,
+};
+module_platform_driver(sun20i_pwm_driver);
+
+MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

