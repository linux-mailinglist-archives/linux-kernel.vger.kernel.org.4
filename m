Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6566968AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjBNP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjBNP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:58:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619E2BEFE;
        Tue, 14 Feb 2023 07:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24B87CE1DDF;
        Tue, 14 Feb 2023 15:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42566C4339E;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676390262;
        bh=mdeu5NwcV69CinND5uBT5R84jgOoioaM9qohNC7tOpE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=kImq1Eu/eUco1cKy5fO30pMN1ISpoQSyckduihp3K54LOKVJC+b7JVUc+frpxbCAv
         I9vqVo3A76xgiMKqp/MEn2P7h2HSszKNoo9FJl3pqlG15HhzlRBIGO5ndHWmyVcnn3
         303fc+5huukAPp4kjZeMT0a29Wzg4RyBNmDfY8BXc6uzl4Kqnu6sgEyVUAGq/5xoxr
         A7Cw95wCoQJ/RnM/0FMPZuZckHz1ZXL1CcLDMRyS8PK/iW5jbv4+7HcuZKd7D67wL/
         Yf1a29BSCmt8Yw8BfYAPyZmP5H3bKBPqnHsn7c5KbfDsBAPDyZAoYSSD/l5/SugsmL
         Nu/Ck/Zr1xRYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 2D03CC05027;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
From:   Sasha Finkelstein via B4 Submission Endpoint 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Tue, 14 Feb 2023 16:57:24 +0100
Subject: [PATCH RESEND 2 v7 2/5] pwm: Add Apple PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v7-2-fb0a6bfbd037@gmail.com>
References: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
In-Reply-To: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676390260; l=6451;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=lwp+zNXuVmVlUScBEP6xNgWVKJk43JYJIexegTOlJP8=;
 b=oYRGnlBbUz3pxzkHeZeRJUzt76rWOQMZs+4stI8QuKdIbAToOZ7Z4igXgn/yjIXU7Kwu+lZjO
 o7sACGmZVGVDwRmTTZfoFbPYrb1Sg6jQXS7kfZLxMGjSaY0k1nrSUdY
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Submission Endpoint for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Adds the Apple PWM controller driver.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/pwm/Kconfig     |  12 ++++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-apple.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a2..8df861b1f4a3 100644
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
index 000000000000..551e07d49bf7
--- /dev/null
+++ b/drivers/pwm/pwm-apple.c
@@ -0,0 +1,159 @@
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
+ * - When APPLE_PWM_CTRL is set to 0, the output is constant low
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
+#define APPLE_PWM_CTRL_ENABLE        BIT(0)
+#define APPLE_PWM_CTRL_MODE          BIT(2)
+#define APPLE_PWM_CTRL_UPDATE        BIT(5)
+#define APPLE_PWM_CTRL_TRIGGER       BIT(9)
+#define APPLE_PWM_CTRL_INVERT        BIT(10)
+#define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
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
+		writel(APPLE_PWM_CTRL_ENABLE | APPLE_PWM_CTRL_OUTPUT_ENABLE | APPLE_PWM_CTRL_UPDATE,
+		       fpwm->base + APPLE_PWM_CTRL);
+	} else {
+		writel(0, fpwm->base + APPLE_PWM_CTRL);
+	}
+	return 0;
+}
+
+static int apple_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	state->enabled = (ctrl & APPLE_PWM_CTRL_ENABLE) && (ctrl & APPLE_PWM_CTRL_OUTPUT_ENABLE);
+	state->polarity = PWM_POLARITY_NORMAL;
+	// on_cycles + off_cycles is 33 bits, NSEC_PER_SEC is 30, there is no overflow
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)on_cycles * NSEC_PER_SEC, fpwm->clkrate);
+	state->period = DIV64_U64_ROUND_UP(((u64)off_cycles + (u64)on_cycles) *
+					    NSEC_PER_SEC, fpwm->clkrate);
+
+	return 0;
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
+		return PTR_ERR(fpwm->base);
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the clock");
+
+	/*
+	 * Uses the 24MHz system clock on all existing devices, can only
+	 * happen if the device tree is broken
+	 *
+	 * This check is done to prevent an overflow in .apply
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
Git-137.1)

