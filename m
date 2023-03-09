Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C440F6B1CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCIHq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCIHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59262DD370
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bi9so1173808lfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEW74q7+LMSUY62mVTwdBMLjddbljPzOZryQLptVoYY=;
        b=XMbLbd3t48QtZLIZdDhf0HUbvwbrN57LRxCsnWYwD95sSoH2C9ydCK9Ou4efqV4wBf
         fPho61KoVh/4YrAezawtOyTjD3HO3JWICfKNAme4sdUkVQiyuINnrmd0FI5wYdsJv3K3
         EBch5GcMrv+1Jw6aPqiNtQool9SLVRIoZh+7fUKiAAJMA/e7/ch/BIxYVP7nksuk4aSL
         rPTs1Z688sR4BgDAUVMyh74s85bPjuMjJCoJVJ0L75uXA1Todzi5Oy9fS+BobwrqTWfJ
         azL/5VqCzWQFL8KilTI4GpkGuXTGbgnzloDwIRNt47hTvhJYDWiyLx5b/cS+eWRbSjZb
         gFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEW74q7+LMSUY62mVTwdBMLjddbljPzOZryQLptVoYY=;
        b=HThFdYLfaV2a6jGrHtZmwus5NTQejT/MEqghItHYeBuyCputqPg67bVdCVv5yTVV8g
         KY6yaDlAb06Yxe8lg7tOKB+mURPw8jrZ0AevPe4vDlOBqwor2A/mQCxX/joT96Sy+3ER
         4/YzlB8u4HQpsf8HI3XBZhZYNc1BIQ8ZUEWD4dJufJyA2zrFVoD6nBowV003hWIGT/xt
         tIe27htQY8op/F4w1IL+gkK6gC0ryCwnXclCPIlHaZjuvoIqVnaFL6r2AxjjF1a9dOQV
         m/9DD+Bi/BdLGqmMqIogp+qAE6OZg4IHpZEOT1IEwnEppZKMmQX9y/tbwl4X3TDhwIaH
         f7fg==
X-Gm-Message-State: AO0yUKXHDfsxsGyHUO9vdwQPp4DNNIQumpBZ1QaUBlDMFsxXtI+EAc3r
        LkJzUWKv5x3aBa1X+LyUAm5PQA==
X-Google-Smtp-Source: AK7set9NiI3sz9FB4RU4+JFGgCcGNjfGi6smKIbqfdmd3mqgfKR8YgnJ28lt6ZQEbhknooPgZlQ61g==
X-Received: by 2002:ac2:51c2:0:b0:4e2:40ba:af44 with SMTP id u2-20020ac251c2000000b004e240baaf44mr6215672lfm.7.1678347959770;
        Wed, 08 Mar 2023 23:45:59 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:45:59 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:52 +0100
Subject: [PATCH v3 04/17] gpio: aspeed: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-4-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Tested-by: Joel Stanley <joel@jms.id.au>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on v6.3-rc1
- Collect ACKs
ChangeLog v2->v3:
- Drop chip->name = dev_name() assignment.
- Rebase on top of Joels patch to make irqchip compulsory
---
 drivers/gpio/gpio-aspeed.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 129f6a6b4d1d..da33bbbdacb9 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
@@ -53,7 +54,7 @@ struct aspeed_gpio_config {
  */
 struct aspeed_gpio {
 	struct gpio_chip chip;
-	struct irq_chip irqc;
+	struct device *dev;
 	raw_spinlock_t lock;
 	void __iomem *base;
 	int irq;
@@ -566,6 +567,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 
 	addr = bank_reg(gpio, bank, reg_irq_enable);
 
+	/* Unmasking the IRQ */
+	if (set)
+		gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
+
 	raw_spin_lock_irqsave(&gpio->lock, flags);
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
@@ -579,6 +584,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+
+	/* Masking the IRQ */
+	if (!set)
+		gpiochip_disable_irq(&gpio->chip, irqd_to_hwirq(d));
 }
 
 static void aspeed_gpio_irq_mask(struct irq_data *d)
@@ -1080,6 +1089,30 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);
 
+static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	const struct aspeed_gpio_bank *bank;
+	struct aspeed_gpio *gpio;
+	u32 bit;
+	int rc, offset;
+
+	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
+	if (rc)
+		return;
+
+	seq_printf(p, dev_name(gpio->dev));
+}
+
+static const struct irq_chip aspeed_gpio_irq_chip = {
+	.irq_ack = aspeed_gpio_irq_ack,
+	.irq_mask = aspeed_gpio_irq_mask,
+	.irq_unmask = aspeed_gpio_irq_unmask,
+	.irq_set_type = aspeed_gpio_set_type,
+	.irq_print_chip = aspeed_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /*
  * Any banks not specified in a struct aspeed_bank_props array are assumed to
  * have the properties:
@@ -1150,6 +1183,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
+	gpio->dev = &pdev->dev;
+
 	raw_spin_lock_init(&gpio->lock);
 
 	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
@@ -1208,12 +1243,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 		return irq;
 	gpio->irq = irq;
 	girq = &gpio->chip.irq;
-	girq->chip = &gpio->irqc;
-	girq->chip->name = dev_name(&pdev->dev);
-	girq->chip->irq_ack = aspeed_gpio_irq_ack;
-	girq->chip->irq_mask = aspeed_gpio_irq_mask;
-	girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
-	girq->chip->irq_set_type = aspeed_gpio_set_type;
+	gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
+
 	girq->parent_handler = aspeed_gpio_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents), GFP_KERNEL);

-- 
2.34.1

