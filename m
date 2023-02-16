Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72465698FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBPJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBPJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:12 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990530B35
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so1981856lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/0FpUId6HClHb1SAI405Gamha8rwtpWaTK6vOeKAsI=;
        b=V1qW6TAh7MAURs+MZCDZ8uiulmt6PpzPTJTS0BRM1nNrYuSWhjLQq6n8AnYF9NnixA
         oSYKPab2EfDdOoL9d9E9VBFGO46VqR12pTeb4iyIDfHjEIrWZNh0DnB+aT/yr4Lx+2x+
         m/u6em6i5LX2S0MHyIw/C5J98hnZTRwHSfE7/XTl2XlNkm9jyFPQs0YKIFDHE+Z8z4nh
         XTXr6doIg0Q2+p4eHCEGGKLp7pGhPkCh6ghH+0nQ0OjFHozHTsGUeSiY9HKoF1IyeBx5
         5guhYksfP9gWobJNN/9L8ni6jc3ozRd7OWgTBcdvWhmL1ht9el5QeAsrNdOswY5RFnwT
         W/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/0FpUId6HClHb1SAI405Gamha8rwtpWaTK6vOeKAsI=;
        b=HSuVJHWgmU16lVV7syBhGK689acdej5V8b51/5eCBjv8X3SkMgl9J1b0rBFsqi5/Jf
         WrCotOt0FZn70HaFfRjKeCQZbjJ78erE0u6VkmVxk9pEZ37g0/6zoAJE87G/smZN+DtK
         1fdfrkDr6JZSO9ytnotas1BLuwVD4DY90YslzPAzhgOvpGvW/D4KZYfnzIUdzE+yqQ1Q
         43/k31MKaD1dB5JvbKUdU87Z5Zq1ZcZf9CvcaO3q1wrQ0x8HhkD9N3WwDmLMHlrTNQ2c
         r8saJuE6Z2/wkih4ksm+NAwGjJhwVYn2idHSaM1bjSIztop3jHrZKQusdn5S95tpKNVL
         OIJA==
X-Gm-Message-State: AO0yUKVTlXbeOR8+q3RCHjr+5NvjMA4OkiEb+LQ/ZyY4q08lWTGJC5YW
        XbIF9BPTHgxerqWGiH40zxFG5w==
X-Google-Smtp-Source: AK7set/26jnve47VIeaaZXAa3EILsyiizsaEe4Zh5KRQayUltcbyJkCNsKMt+3Vt3rPvVH7weGuiBg==
X-Received: by 2002:ac2:4c91:0:b0:4cc:8294:e960 with SMTP id d17-20020ac24c91000000b004cc8294e960mr2177300lfl.3.1676540227888;
        Thu, 16 Feb 2023 01:37:07 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:04 +0100
Subject: [PATCH 03/17] gpio: aspeed: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-3-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
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
        Grygorii Strashko <grygorii.strashko@ti.com>,
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index a94da80d3a95..9c4852de2733 100644
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
@@ -1149,6 +1182,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
+	gpio->dev = &pdev->dev;
+
 	raw_spin_lock_init(&gpio->lock);
 
 	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
@@ -1208,12 +1243,9 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 		gpio->irq = rc;
 		girq = &gpio->chip.irq;
-		girq->chip = &gpio->irqc;
+		gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
 		girq->chip->name = dev_name(&pdev->dev);
-		girq->chip->irq_ack = aspeed_gpio_irq_ack;
-		girq->chip->irq_mask = aspeed_gpio_irq_mask;
-		girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
-		girq->chip->irq_set_type = aspeed_gpio_set_type;
+
 		girq->parent_handler = aspeed_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

