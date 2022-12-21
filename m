Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B516537F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiLUVHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiLUVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:07:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141E26550;
        Wed, 21 Dec 2022 13:07:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso2480241wms.4;
        Wed, 21 Dec 2022 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQdvSaqbWHS4wz+69NFwa5kReNCnCDhDB3OtMVssUjQ=;
        b=aIpgBQsker2pIhmo1vLTLk2kkV1LfzF0IhdRh0TNqIQM5KqT1ZC7HZYKU59/rnnCjx
         tFN3rmaYs6o2bQNlNJbZhOC3Lae01EMw0qepQarchNCU8HFgJk+O3O2otdFN0wY9WHLt
         GHgIL5WwWQ2VBU4xi0rKOjpZUA0KKlr2XUGxHFjISPA37veWlyUcI4y7qBFjruLY5cyW
         lSSCenaawwGIO+fzlyDZdYLynVpao+ZkqS+1SZJOzpPCutWFAi3TL68XoUtW2Yf+ouy8
         A89nFOThjCkx/We+X8kjykeFSr8Eq2lUPPTpiDKOi4SnWRPumpHVdeT7FzCNGgf+p0CZ
         a3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQdvSaqbWHS4wz+69NFwa5kReNCnCDhDB3OtMVssUjQ=;
        b=pXc0hG/pYHmQupB9x6uIxsmguKpjZvpa3SWecPSdEoyH8t8A8kfIykg9n5zyiVbstI
         fz351s91lHjSpx6dIs1Uz34MqfIhl9zhW4nI8SQP4S4pN06Hg0legIqazHXn1HuZmbuH
         er79FR8amgkb0DB9aH/W5U3EcADbcgGt9wlQQq3KDDSO743iOAOJRACfFaqVmASEgCCS
         Q5jRfReCwWh9t+jIsoHSfobeWYrgCD4vunmGz4oh7y+qsEYbn+Jtvw4xpYBQ2iEguweD
         bbaL2sRDxRKdC8nE5URlok2/NTMn0+U+LGxjnwVi1+VtCvy4X3Q6nOugZPoNJ+kgNTHr
         MZiA==
X-Gm-Message-State: AFqh2krvkijeIWWzOZ79KPczpzOJvlzr4EfHtwG3VK3mQIgqeskEjSTb
        XF60JLeTH6etURCUgmZ/yZQ=
X-Google-Smtp-Source: AMrXdXuoS7C9qK4GEk0MQPo0OanE6nyR5kYYS03xd9vnUbNCr2Thc5mqdT081cn4vMQeiFxjSuvoVw==
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr3129826wmq.4.1671656825883;
        Wed, 21 Dec 2022 13:07:05 -0800 (PST)
Received: from localhost ([176.234.10.188])
        by smtp.gmail.com with UTF8SMTPSA id x15-20020a1c7c0f000000b003c6bbe910fdsm4438944wmc.9.2022.12.21.13.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 13:07:05 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v5 2/4] pwm: Add Apple PWM controller
Date:   Thu, 22 Dec 2022 00:06:46 +0300
Message-Id: <20221221210648.2735-3-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221221210648.2735-1-fnkl.kernel@gmail.com>
References: <20221221210648.2735-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the Apple PWM controller driver.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/pwm/Kconfig     |  12 ++++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-apple.c | 154 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/pwm/pwm-apple.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..c3be11468414 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -51,6 +51,18 @@ config PWM_AB8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-ab8500.
 
+config PWM_APPLE
+	tristate "Apple SoC PWM support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	help
+	  Generic PWM framework driver for PWM controller present on
+	  Apple SoCs
+
+	  Say Y here if you have an ARM Apple laptop, otherwise say N
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-apple.
+
 config PWM_ATMEL
 	tristate "Atmel PWM support"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..19899b912e00 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
new file mode 100644
index 000000000000..09048b02b2f5
--- /dev/null
+++ b/drivers/pwm/pwm-apple.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Driver for the Apple SoC PWM controller
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Limitations:
+ * - The writes to cycle registers are shadowed until a write to
+ *   the control register.
+ * - If both OFF_CYCLES and ON_CYCLES are set to 0, the output
+ *   is a constant off signal.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/math64.h>
+
+#define APPLE_PWM_CTRL        0x00
+#define APPLE_PWM_ON_CYCLES   0x1c
+#define APPLE_PWM_OFF_CYCLES  0x18
+
+#define APPLE_CTRL_ENABLE        BIT(0)
+#define APPLE_CTRL_MODE          BIT(2)
+#define APPLE_CTRL_UPDATE        BIT(5)
+#define APPLE_CTRL_TRIGGER       BIT(9)
+#define APPLE_CTRL_INVERT        BIT(10)
+#define APPLE_CTRL_OUTPUT_ENABLE BIT(14)
+
+struct apple_pwm {
+	struct pwm_chip chip;
+	void __iomem *base;
+	u64 clkrate;
+};
+
+static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct apple_pwm, chip);
+}
+
+static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct apple_pwm *fpwm;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	fpwm = to_apple_pwm(chip);
+	if (state->enabled) {
+		u64 on_cycles, off_cycles;
+
+		on_cycles = mul_u64_u64_div_u64(fpwm->clkrate,
+						state->duty_cycle, NSEC_PER_SEC);
+		if (on_cycles > 0xFFFFFFFF)
+			return -ERANGE;
+
+		off_cycles = mul_u64_u64_div_u64(fpwm->clkrate,
+						 state->period, NSEC_PER_SEC) - on_cycles;
+		if (off_cycles > 0xFFFFFFFF)
+			return -ERANGE;
+
+		writel(on_cycles, fpwm->base + APPLE_PWM_ON_CYCLES);
+		writel(off_cycles, fpwm->base + APPLE_PWM_OFF_CYCLES);
+		writel(APPLE_CTRL_ENABLE | APPLE_CTRL_OUTPUT_ENABLE | APPLE_CTRL_UPDATE,
+		       fpwm->base + APPLE_PWM_CTRL);
+	} else {
+		writel(0, fpwm->base + APPLE_PWM_CTRL);
+	}
+	return 0;
+}
+
+static void apple_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	struct apple_pwm *fpwm;
+	u32 on_cycles, off_cycles, ctrl;
+
+	fpwm = to_apple_pwm(chip);
+
+	ctrl = readl(fpwm->base + APPLE_PWM_CTRL);
+	on_cycles = readl(fpwm->base + APPLE_PWM_ON_CYCLES);
+	off_cycles = readl(fpwm->base + APPLE_PWM_OFF_CYCLES);
+
+	state->enabled = (ctrl & APPLE_CTRL_ENABLE) && (ctrl & APPLE_CTRL_OUTPUT_ENABLE);
+	state->polarity = PWM_POLARITY_NORMAL;
+	// on_cycles + off_cycles is 33 bits, NSEC_PER_SEC is 30, there is no overflow
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)on_cycles * NSEC_PER_SEC, fpwm->clkrate);
+	state->period = DIV64_U64_ROUND_UP(((u64)off_cycles + (u64)on_cycles) *
+					    NSEC_PER_SEC, fpwm->clkrate);
+}
+
+static const struct pwm_ops apple_pwm_ops = {
+	.apply = apple_pwm_apply,
+	.get_state = apple_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int apple_pwm_probe(struct platform_device *pdev)
+{
+	struct apple_pwm *fpwm;
+	struct clk *clk;
+	int ret;
+
+	fpwm = devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
+	if (!fpwm)
+		return -ENOMEM;
+
+	fpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fpwm->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fpwm->base), "unable to map mmio");
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the clock");
+
+	/*
+	 * uses the 24MHz system clock on all existing devices, can only
+	 * happen if the device tree is broken
+	 */
+	fpwm->clkrate = clk_get_rate(clk);
+	if (fpwm->clkrate > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
+
+	fpwm->chip.dev = &pdev->dev;
+	fpwm->chip.npwm = 1;
+	fpwm->chip.ops = &apple_pwm_ops;
+
+	ret = devm_pwmchip_add(&pdev->dev, &fpwm->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
+
+	return 0;
+}
+
+static const struct of_device_id apple_pwm_of_match[] = {
+	{ .compatible = "apple,s5l-fpwm" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_pwm_of_match);
+
+static struct platform_driver apple_pwm_driver = {
+	.probe = apple_pwm_probe,
+	.driver = {
+		.name = "apple-pwm",
+		.of_match_table = apple_pwm_of_match,
+	},
+};
+module_platform_driver(apple_pwm_driver);
+
+MODULE_DESCRIPTION("Apple SoC PWM driver");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.37.1 (Apple Git-137.1)

