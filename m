Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906D64816B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLILPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLILPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:15:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF266B999;
        Fri,  9 Dec 2022 03:15:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3164624wmb.5;
        Fri, 09 Dec 2022 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRzhndnw4Gp9xKPjkwy46wWOr4BlSgqeLKWGVWxZpeo=;
        b=S0Ex8ckdo0SKDLDKE4/ZhjjxeZsih6hlZsyz0JpJmWcMV3DaOI7lH4ebNgjG86WoPr
         06K7qCMxCR2RilQsDLgAwTflnanlqiiTE2ukqWMOg3NLQNPm8+q7Ef5K8IzufuNfpei8
         acFJawcyhbAVzZVDBdo/EzCbG3uktC8AADoYZ6LDz+TXA8dyDVTLiQsesvDwNG4X1k6x
         Z13ySdGc/tTNcYht43jSBKHvZ0mcTGFFwRaXDu1K9sglPK8WF8bEDJ7IZKwoUIr1Mwwh
         jWhKGqxZXuDL+pO3WsCWFyb3gIgdR/1i2/l38Tkrwzr2VkV/usDVMBMGqxqe5pU/fbkg
         wByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRzhndnw4Gp9xKPjkwy46wWOr4BlSgqeLKWGVWxZpeo=;
        b=jiffX6NxTOPizHGk+eQLGtyb6MQooT6pSKT8JWF9QFzw/BpTiMhaqmDRtVnEvj/b0E
         4T2je7ROn4HSQ5fGQrh7lsNzNznWTKsQHwGpU9cF8koHNNE0YXaSOt62yB6/gLinjJjX
         VNAnfnYD4M8CXY26XFxKdGaTMPBncxDHravsoqw2mFoebNPebr79y2RS3uxBclf0GLWC
         Dj65MKkdMeO9jyTK6IMupcyE944ahUyNqjp18R2/iNJpZvlz9oFMv9VVfHwzyC2pnJtF
         4upsa3GiqpKO7L/W9+FMCP74TlusXWQhoQdxos9JGjepqs3QWyx70pgt9sXcg/b85ALi
         jzsw==
X-Gm-Message-State: ANoB5pnWe1LRSKvSNl60W+sRKOuzWfINDOeeDZOIyOeT3RowaQA+ah0F
        0+/F8jszTGtf7PFA7OBsE5g=
X-Google-Smtp-Source: AA0mqf7dAQxbKBTV8U5qzh1b8U1sJOZraekeAr3PnBtkFRJsGh3TEjJa6Pc+D+RmyLkEhQ1umxxHkw==
X-Received: by 2002:a05:600c:3c96:b0:3cf:8d51:1622 with SMTP id bg22-20020a05600c3c9600b003cf8d511622mr4484446wmb.1.1670584508221;
        Fri, 09 Dec 2022 03:15:08 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id q10-20020a05600c46ca00b003c70191f267sm8587611wmo.39.2022.12.09.03.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:15:07 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v4 2/4] pwm: Add Apple PWM controller
Date:   Fri,  9 Dec 2022 14:13:11 +0300
Message-Id: <20221209111313.2701-3-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221209111313.2701-1-fnkl.kernel@gmail.com>
References: <20221209111313.2701-1-fnkl.kernel@gmail.com>
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
 drivers/pwm/pwm-apple.c | 150 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
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
index 000000000000..a85fecb20105
--- /dev/null
+++ b/drivers/pwm/pwm-apple.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Driver for the Apple SoC PWM controller
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Limitations:
+ * - The writes to cycle registers are shadowed until a write to
+ *   the control register.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/math64.h>
+
+#define APPLE_PWM_CONTROL     0x00
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
+	u64 on_cycles, off_cycles;
+
+	fpwm = to_apple_pwm(chip);
+	if (state->enabled) {
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
+		       fpwm->base + APPLE_PWM_CONTROL);
+	} else {
+		writel(0, fpwm->base + APPLE_PWM_CONTROL);
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
+	ctrl = readl(fpwm->base + APPLE_PWM_CONTROL);
+	on_cycles = readl(fpwm->base + APPLE_PWM_ON_CYCLES);
+	off_cycles = readl(fpwm->base + APPLE_PWM_OFF_CYCLES);
+
+	state->enabled = (ctrl & APPLE_CTRL_ENABLE) && (ctrl & APPLE_CTRL_OUTPUT_ENABLE);
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->duty_cycle = mul_u64_u64_div_u64(on_cycles, NSEC_PER_SEC, fpwm->clkrate);
+	state->period = mul_u64_u64_div_u64(off_cycles + on_cycles,
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

