Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536AF62607C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiKKRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiKKReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813F65E57;
        Fri, 11 Nov 2022 09:34:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id i10so5438806ejg.6;
        Fri, 11 Nov 2022 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+9IrtAc191rAMJ9lamUKYajmKH7hj/07wCLXl1AJ5g=;
        b=DIJW4KppnxTe5jNYgySEgLVz/BgGBJ9LxSXsFSI0l8GY2mlIsocAwy5HdrKOpW24pj
         Ix2cWw0/z52VisPWJJyE89qEbOuL7uSa8CI6escg2QrIDGCNsxx9ZcusvKArTHJeAa/c
         JZv86yvZc6FcJZ0BONBXZE9FTzxlHDfBp9EogP74wScUNIhedW3xw3lya4GNpsMJ67J4
         iiMH0kyrkhRBxEcOJj/iJKmxORuvm+ptDJSzU95YD/YVYx7MC0evRVLQ8b7T2ZEpa11q
         cw+WFLZqnXZ2K//+HeQXY1La5WWam60r4gfxj/aKceX1AqAZ+N9IEkzFVU4pfEoKaTKD
         /Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9IrtAc191rAMJ9lamUKYajmKH7hj/07wCLXl1AJ5g=;
        b=cikk/l30EVc2UfJuZFWj5h8oET8avoFHmqdSoPJ3/kwxhRRF/IvBV36zBgNd/p7loO
         uYlo8L+MRKW3w8WXM15ZKD+hn10AVq4f52yV6HtbSFdbPVIgsOWxejmXCGZ6VKfFaZ8d
         o8BPBMCfs5n7V9ACuxxJ/Q8a57yQo4oe447wPWtyMO5STf+RAnxuYI8c5Ln7Y2wz0nz7
         ThcOJ+cVABbWhRjXs3VMDilCsHCPLZJRZcv2OTpfCgTRKLav/daeEfARuueC1UE7MIaX
         Jjf/v4lfo2cA/jKFeaKqzR4BUBD0mamm7sV1AjpBcRfHM9Q5rIDJbK+GMRf80Lyyv9z2
         IaRw==
X-Gm-Message-State: ANoB5pnwehziuHXF7q5LF4JouWlaXCpLDJxUijklc5wsyWtXLsW9sdax
        gQ/nOe4fPs9e48u9xUjy2R8=
X-Google-Smtp-Source: AA0mqf6kmFSn98UQppLfpDVIILHJIkkiozI9/PhISa0GLrMIph2jrKJ74oNPGwXwIvcOMdBCpdeCyg==
X-Received: by 2002:a17:906:4d58:b0:781:bc28:f455 with SMTP id b24-20020a1709064d5800b00781bc28f455mr2692591ejv.170.1668188054895;
        Fri, 11 Nov 2022 09:34:14 -0800 (PST)
Received: from localhost ([85.153.204.139])
        by smtp.gmail.com with UTF8SMTPSA id b12-20020a17090630cc00b00780b1979adesm1066664ejb.218.2022.11.11.09.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:14 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v3 2/4] pwm: Add Apple PWM controller
Date:   Fri, 11 Nov 2022 20:33:46 +0300
Message-Id: <20221111173348.6537-3-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221111173348.6537-1-fnkl.kernel@gmail.com>
References: <20221111173348.6537-1-fnkl.kernel@gmail.com>
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
 drivers/pwm/pwm-apple.c | 127 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
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
index 000000000000..b0c3f86fd578
--- /dev/null
+++ b/drivers/pwm/pwm-apple.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Driver for the Apple SoC PWM controller
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+
+#define PWM_CONTROL     0x00
+#define PWM_ON_CYCLES   0x1c
+#define PWM_OFF_CYCLES  0x18
+
+#define CTRL_ENABLE        BIT(0)
+#define CTRL_MODE          BIT(2)
+#define CTRL_UPDATE        BIT(5)
+#define CTRL_TRIGGER       BIT(9)
+#define CTRL_INVERT        BIT(10)
+#define CTRL_OUTPUT_ENABLE BIT(14)
+
+struct apple_pwm {
+	struct pwm_chip chip;
+	void __iomem *base;
+	u64 clkrate;
+};
+
+static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct apple_pwm *fpwm;
+	u64 on_cycles, off_cycles;
+
+	fpwm = container_of(chip, struct apple_pwm, chip);
+	if (state->enabled) {
+		on_cycles = mul_u64_u64_div_u64(fpwm->clkrate,
+						state->duty_cycle, NSEC_PER_SEC);
+		off_cycles = mul_u64_u64_div_u64(fpwm->clkrate,
+						 state->period, NSEC_PER_SEC) - on_cycles;
+		writel(on_cycles, fpwm->base + PWM_ON_CYCLES);
+		writel(off_cycles, fpwm->base + PWM_OFF_CYCLES);
+		writel(CTRL_ENABLE | CTRL_OUTPUT_ENABLE | CTRL_UPDATE,
+		       fpwm->base + PWM_CONTROL);
+	} else {
+		writel(0, fpwm->base + PWM_CONTROL);
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
+	fpwm = container_of(chip, struct apple_pwm, chip);
+
+	ctrl = readl(fpwm->base + PWM_CONTROL);
+	on_cycles = readl(fpwm->base + PWM_ON_CYCLES);
+	off_cycles = readl(fpwm->base + PWM_OFF_CYCLES);
+
+	state->enabled = (ctrl & CTRL_ENABLE) && (ctrl & CTRL_OUTPUT_ENABLE);
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->duty_cycle = div_u64(on_cycles, fpwm->clkrate) * NSEC_PER_SEC;
+	state->period = div_u64(off_cycles + on_cycles, fpwm->clkrate) * NSEC_PER_SEC;
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
+	struct apple_pwm *pwm;
+	struct clk *clk;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->base))
+		return PTR_ERR(pwm->base);
+
+	platform_set_drvdata(pdev, pwm);
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	pwm->clkrate = clk_get_rate(clk);
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.npwm = 1;
+	pwm->chip.ops = &apple_pwm_ops;
+
+	ret = devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return ret;
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
+		.owner = THIS_MODULE,
+		.of_match_table = apple_pwm_of_match,
+	},
+};
+module_platform_driver(apple_pwm_driver);
+
+MODULE_DESCRIPTION("Apple SoC PWM driver");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.38.1

