Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38466AB90
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjANN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjANN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:26:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9A18A7D;
        Sat, 14 Jan 2023 05:26:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs20so23403940wrb.3;
        Sat, 14 Jan 2023 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QdtFduAUazoRi+gFa6YJzP5gQ4JWm55xKraka6mCaE=;
        b=d3LLx7AGzhiShDp19MfcigvkdYmCc/OUeoNj58UE5BRFst8jDWjmoNXx5Dfj9yvs37
         L5SYxdpRzSMsmxkkhHWJcsra5dl6CxVDHo+dW366sxNCzv86yNi2HxUYzPcnt6UJof0V
         QLOlGK+oM8HiBZhdbD2CY+l1HaA4ODcbrCjntUQYAycH6hY2NClLFNkj+hccAv0f09H1
         FypxsdU33JUdIPX8rZE/sVwpc8laFbmDpIOjppWxkU0EAa9c9ksoC6kizUzHzIn/T21K
         Z/E1olbmoCRwycQgfId6X+2jCsxY/G9x+byUCvHSP8f1XOtAmS+0KRxEyd0O5iJpoYeR
         rY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QdtFduAUazoRi+gFa6YJzP5gQ4JWm55xKraka6mCaE=;
        b=wXIHGcLt1iTSGuRoGF4mDN/hEc27Z5e1kOox4TbJZv0MMYd5z69nrO/0pwMJj9D/oc
         X1MKkIbLgzwQI8jxVwfzjNfA/eIYETq6b8XG1EqyCAHrOgHGrG7X/d1TV3M1tpu/aXA+
         qTUI8K1ycrBnmLiNikmU8+YfeHGDDsNYPjEb7ankR9vfMmAoXRMLbfEf9UavdI4Guamh
         qD8T1+ygV00dcqbAuUyNV6bGS6HIQ4qdnsjcIFrC41A3Sj5/4bZpU2FbJ2yfAj9xaZxL
         2W9TaDSVwYv168/WoepBOf1zRCHh9Pj6v8iF8z5ftRx7W7NOE+Y1hpHEt2bTCczqxxFp
         CemA==
X-Gm-Message-State: AFqh2koFG94hAJFo2OUb8kSiOMajJO3Ckl+ABzMv9pC3XvhkAPD8HWM4
        TtuIVsVHnRv5tE/byHsLPpg=
X-Google-Smtp-Source: AMrXdXtX9XEYIJE30llAT5ls65UZ2GHzkbkLAid1iRkGfjXgMfgTOva4jdC+czEVjCgZNXO3qxjGtA==
X-Received: by 2002:a05:6000:617:b0:242:1c5f:ee61 with SMTP id bn23-20020a056000061700b002421c5fee61mr57595065wrb.39.1673702811896;
        Sat, 14 Jan 2023 05:26:51 -0800 (PST)
Received: from localhost ([176.234.9.57])
        by smtp.gmail.com with UTF8SMTPSA id m5-20020a056000024500b00267bcb1bbe5sm22062872wrz.56.2023.01.14.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 05:26:51 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v7 2/5] pwm: Add Apple PWM controller
Date:   Sat, 14 Jan 2023 16:25:05 +0300
Message-Id: <20230114132508.96600-3-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230114132508.96600-1-fnkl.kernel@gmail.com>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
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
 drivers/pwm/Kconfig     |  12 +++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-apple.c | 159 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/pwm/pwm-apple.c

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
2.37.1 (Apple Git-137.1)

