Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD973F703
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjF0IZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjF0IYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:24:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633952953;
        Tue, 27 Jun 2023 01:24:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b5c231f842so38525211fa.2;
        Tue, 27 Jun 2023 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687854253; x=1690446253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVgwEWqV1/QLEQ3WdNfF1TarAqhtogY8yI7ZYRgdsLc=;
        b=VIQTiGRFBHa89JJk77fcoM96LBohuQmcvYyqiYiQ0ypG2WYkouuybQR5wcY5ltUp0C
         YlZcHAcrRTfXTG4CwmDG5HuHmfzo2rQSaKiaDfviqBBxm32Uh4xrt4oHe5G7VsvAD7Nr
         6Tqcu5wSyTCu5F81Cg6QEuQlumxg2bttOz+l5vZwJbh9zSzoM8YVMYeNmrEvQRgVz2YV
         LtaulQ+6PGLLNJvbSNJekeAFJ3WPyv210VG7n4c576e8mFlxqDXwF5aKY6fzyALF1Tp/
         BtP5vQO/cnFrwl8mSKGe0ymB+D4cYn+/SvHikRHqoEUw0b0DxoGyQoVVh3B9OIKsihxn
         hxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854253; x=1690446253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVgwEWqV1/QLEQ3WdNfF1TarAqhtogY8yI7ZYRgdsLc=;
        b=dxJZFDUbr7v3jGmSWk3u6zRS1bqMa5/b7lu6az1H9NDC+u0mR0epXNTUhpUvuqi5iz
         T/BVlnN5RFFJP+bAZx9fq2nEXP6wnfke9cR281rLNFm8wOSnPcbl6+bonumeITjlqu1Z
         pJ7KCn1NKcd63rgTg9y9WyKqGqYKcScVB//mo0BeST3tjPZ5mnOEHTRKlkUamUx0sLnc
         21VGh36wMrf91VSJVMM+rk76/gmCF1Unf0A1ODhPWTwfIOiyVr/cy5cm8Rh9Fx6E/9j3
         MBqdqmGR4hvfTB1717Q9mFro9z4lSz4qx3b/HA2N0Y53lRT+wyoQL2u216S/IJOI2GVd
         QV7A==
X-Gm-Message-State: AC+VfDypfx8BJqIxC+tiiCukjB272SdaeDTrlUuQMwprlu3yxgM5NTBK
        0I9cElhnTPGcfblYh2rbPGV17qr5LKX90pQ=
X-Google-Smtp-Source: ACHHUZ5H7Tk/7UDpaGZFl4JT+tAMpcCS1R68o2Hmq3AzZyGcLoFGEc5p8iV9eMGdnaX1oqvQKMMu0g==
X-Received: by 2002:a05:6512:15aa:b0:4fb:74d6:6154 with SMTP id bp42-20020a05651215aa00b004fb74d66154mr3569982lfb.37.1687854253119;
        Tue, 27 Jun 2023 01:24:13 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512006c00b004eb12329053sm1420673lfo.256.2023.06.27.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:24:12 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date:   Tue, 27 Jun 2023 11:23:25 +0300
Message-Id: <20230627082334.1253020-3-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627082334.1253020-1-privatesub2@gmail.com>
References: <20230627082334.1253020-1-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sun20i.c | 322 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun20i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8df861b1f4a3..05c48a36969e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -594,6 +594,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN20I
+	tristate "Allwinner D1/T113s/R329 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
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
index 000000000000..63e9c64e0e18
--- /dev/null
+++ b/drivers/pwm/pwm-sun20i.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
+ *
+ * Limitations:
+ * - When the parameters change, current running period will not be completed
+ *   and run new settings immediately.
+ * - It output HIGH-Z state when PWM channel disabled.
+ *
+ * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define PWM_CLK_CFG_REG(chan)		(0x20 + (((chan) >> 1) * 0x4))
+#define PWM_CLK_SRC			GENMASK(8, 7)
+#define PWM_CLK_DIV_M			GENMASK(3, 0)
+
+#define PWM_CLK_GATE_REG		0x40
+#define PWM_CLK_BYPASS(chan)		BIT((chan) - 16)
+#define PWM_CLK_GATING(chan)		BIT(chan)
+
+#define PWM_ENABLE_REG			0x80
+#define PWM_EN(chan)			BIT(chan)
+
+#define PWM_CTL_REG(chan)		(0x100 + (chan) * 0x20)
+#define PWM_ACT_STA			BIT(8)
+#define PWM_PRESCAL_K			GENMASK(7, 0)
+
+#define PWM_PERIOD_REG(chan)		(0x104 + (chan) * 0x20)
+#define PWM_ENTIRE_CYCLE		GENMASK(31, 16)
+#define PWM_ACT_CYCLE			GENMASK(15, 0)
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
+	u16 ent_cycle, act_cycle;
+	u8 prescal, div_id;
+
+	mutex_lock(&sun20i_chip->mutex);
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
+	div_id = FIELD_GET(PWM_CLK_DIV_M, val);
+	if (FIELD_GET(PWM_CLK_SRC, val) == 0)
+		clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
+	else
+		clk_rate = clk_get_rate(sun20i_chip->clk_bus);
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
+	state->polarity = (PWM_ACT_STA & val) ? PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
+
+	prescal = FIELD_GET(PWM_PRESCAL_K, val) + 1;
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
+	state->enabled = (PWM_EN(pwm->hwpwm) & val) ? true : false;
+
+	val = sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
+	act_cycle = FIELD_GET(PWM_ACT_CYCLE, val);
+	ent_cycle = FIELD_GET(PWM_ENTIRE_CYCLE, val);
+	if (act_cycle > ent_cycle)
+		act_cycle = ent_cycle;
+
+	tmp = (u64)(act_cycle) * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
+	tmp = (u64)(ent_cycle) * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
+	mutex_unlock(&sun20i_chip->mutex);
+
+	return 0;
+}
+
+static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int ret = 0;
+	u32 clk_gate, clk_cfg, pwm_en, ctl, period;
+	u64 bus_rate, hosc_rate, clk_div, val;
+	u16 prescaler, div_m;
+	bool use_bus_clk, calc_div_m;
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+
+	mutex_lock(&sun20i_chip->mutex);
+
+	pwm_en = sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
+
+	if (state->enabled != pwm->state.enabled)
+		clk_gate = sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE_REG);
+
+	if (state->enabled != pwm->state.enabled && !state->enabled) {
+		clk_gate &= ~PWM_CLK_GATING(pwm->hwpwm);
+		pwm_en &= ~PWM_EN(pwm->hwpwm);
+		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
+		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG);
+	}
+
+	if (state->polarity != pwm->state.polarity ||
+	    state->duty_cycle != pwm->state.duty_cycle ||
+	    state->period != pwm->state.period) {
+		ctl = sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
+		clk_cfg = sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
+		hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
+		bus_rate = clk_get_rate(sun20i_chip->clk_bus);
+		if (pwm_en & PWM_EN(pwm->hwpwm ^ 1)) {
+			/* if the neighbor channel is enable, check period only */
+			use_bus_clk = FIELD_GET(PWM_CLK_SRC, clk_cfg) != 0;
+			if (use_bus_clk)
+				val = state->period * bus_rate;
+			else
+				val = state->period * hosc_rate;
+			do_div(val, NSEC_PER_SEC);
+
+			div_m = FIELD_GET(PWM_CLK_DIV_M, clk_cfg);
+			calc_div_m = false;
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
+					ret = -EINVAL;
+					goto unlock_mutex;
+				}
+			}
+			div_m = 0;
+			calc_div_m = true;
+
+			/* set up the CLK_DIV_M and clock CLK_SRC */
+			clk_cfg = FIELD_PREP(PWM_CLK_DIV_M, div_m);
+			clk_cfg |= FIELD_PREP(PWM_CLK_SRC, use_bus_clk ? 1 : 0);
+
+			sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG_REG(pwm->hwpwm));
+		}
+
+		/* calculate prescaler, M factor, PWM entire cycle */
+		clk_div = val;
+		for (prescaler = 0;; prescaler++) {
+			if (prescaler >= 256) {
+				if (calc_div_m) {
+					prescaler = 0;
+					div_m++;
+					if (div_m >= 9) {
+						ret = -EINVAL;
+						goto unlock_mutex;
+					}
+				} else {
+					ret = -EINVAL;
+					goto unlock_mutex;
+				}
+			}
+
+			clk_div = val >> div_m;
+			do_div(clk_div, prescaler + 1);
+			if (clk_div <= 65534)
+				break;
+		}
+
+		period = FIELD_PREP(PWM_ENTIRE_CYCLE, clk_div);
+
+		/* set duty cycle */
+		if (use_bus_clk)
+			val = state->duty_cycle * bus_rate;
+		else
+			val = state->duty_cycle * hosc_rate;
+		do_div(val, NSEC_PER_SEC);
+		clk_div = val >> div_m;
+		do_div(clk_div, prescaler + 1);
+
+		if (state->duty_cycle == state->period)
+			clk_div++;
+		period |= FIELD_PREP(PWM_ACT_CYCLE, clk_div);
+		sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD_REG(pwm->hwpwm));
+
+		ctl = FIELD_PREP(PWM_PRESCAL_K, prescaler);
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			ctl |= PWM_ACT_STA;
+
+		sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL_REG(pwm->hwpwm));
+	}
+
+	if (state->enabled != pwm->state.enabled && state->enabled) {
+		clk_gate &= ~PWM_CLK_BYPASS(pwm->hwpwm);
+		clk_gate |= PWM_CLK_GATING(pwm->hwpwm);
+		pwm_en |= PWM_EN(pwm->hwpwm);
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
+	sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
+	if (IS_ERR(sun20i_chip->clk_bus))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
+				     "failed to get bus clock\n");
+
+	sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
+	if (IS_ERR(sun20i_chip->clk_hosc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
+				     "failed to get hosc clock\n");
+
+	sun20i_chip->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(sun20i_chip->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
+				     "failed to get bus reset\n");
+
+	ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
+				   &sun20i_chip->chip.npwm);
+	if (ret)
+		sun20i_chip->chip.npwm = 8;
+
+	/* Deassert reset */
+	ret = reset_control_deassert(sun20i_chip->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
+
+	sun20i_chip->chip.dev = &pdev->dev;
+	sun20i_chip->chip.ops = &sun20i_pwm_ops;
+
+	mutex_init(&sun20i_chip->mutex);
+
+	ret = pwmchip_add(&sun20i_chip->chip);
+	if (ret < 0) {
+		reset_control_assert(sun20i_chip->rst);
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, sun20i_chip);
+
+	return 0;
+}
+
+static void sun20i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun20i_pwm_chip *sun20i_chip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&sun20i_chip->chip);
+
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

