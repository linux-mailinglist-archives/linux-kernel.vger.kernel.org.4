Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000676ADFEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCGNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCGNFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0874FF1B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t11so16987872lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pkmx+b8ik/C6bLfv+4RBCDp/VEmyhMZOMZzx00ojykk=;
        b=tdXfnpQveQZ13YRTjuwgCi+dCDAKPyozw1qYk19o2EtuyEuikBRxXl6nyMRSB2xKRJ
         WoI6iAmTDBWherJFYCKCXcxRe/4XJHx/fCeWmZ2DZcA3HbL4fOi6nokat7LiDvCQuXYG
         gU4udntoQ0XJ6m+b5ON3WpTR8+YyCXOtbXyrqj8uhMVAbxIy6TMWKhfBezu6mscGBj0J
         TwcV9YsgtwqysWedxow5kbw5KklVoarBDjxm0WDoB0g65+qOJdrsFtY6YuNQA//qVo36
         AxYfUHWcp7ClBdAzlY8RLrdBA/86dbEVMh44W/lFDzziSOxKOoBukra245PzOwLMl0Pl
         YYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkmx+b8ik/C6bLfv+4RBCDp/VEmyhMZOMZzx00ojykk=;
        b=fOShDjZ/wQUy+rsLRloiczrrEE35ASHswXISdnGLHyuESjsoV+223q9IZa1EESfT01
         CgJVANRaoSdyGzcLLCMRrryB5fG2MFqAEeu2LMPaSW9jAXKEJFx5gLEO5l2AB4kN52jo
         cI03LyasYP4GrBTm06eNHRsmP6ByKcKuKcr52m2ajsJEjdOt44WUIOPNHAX6c+CJtXuL
         td7CI6Po9AIXojSlimz1I2FyIaKi8c7LPZSlFI+k/vOHpIXhxPsL6DLHdlHa7v2+cWgW
         zDnoX8TzFTuyIYD6TDN4vbn09li7S4nhWmJcuZT5MFJ09A8DDlSEjW+XSnqnDvHWSwJO
         x2UA==
X-Gm-Message-State: AO0yUKVjCuHglif/qWkxC76BDixJ2zlYjq2MPyaW6feKLeyFXhYqubVu
        o5s1ZJ15fRIrUZc17afvZN8FwA==
X-Google-Smtp-Source: AK7set+BPTrxIQszyBjkoemozr65iYSYHYZLhbySZe0iKuYbn7PX2UF10OfwR0QpBDODuoR5HJXYOw==
X-Received: by 2002:ac2:46d6:0:b0:4da:f436:d423 with SMTP id p22-20020ac246d6000000b004daf436d423mr3963036lfo.21.1678194296895;
        Tue, 07 Mar 2023 05:04:56 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:56 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:53 +0100
Subject: [PATCH v2 11/16] gpio: mlxbf2: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-11-d6b0e3f2d991@linaro.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
In-Reply-To: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-mlxbf2.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 77a41151c921..6abe01bc39c3 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/resource.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -65,10 +66,10 @@ struct mlxbf2_gpio_context_save_regs {
 /* BlueField-2 gpio block context structure. */
 struct mlxbf2_gpio_context {
 	struct gpio_chip gc;
-	struct irq_chip irq_chip;
 
 	/* YU GPIO blocks address */
 	void __iomem *gpio_io;
+	struct device *dev;
 
 	struct mlxbf2_gpio_context_save_regs *csave_regs;
 };
@@ -237,6 +238,7 @@ static void mlxbf2_gpio_irq_enable(struct irq_data *irqd)
 	unsigned long flags;
 	u32 val;
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(irqd));
 	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
 	val = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
 	val |= BIT(offset);
@@ -261,6 +263,7 @@ static void mlxbf2_gpio_irq_disable(struct irq_data *irqd)
 	val &= ~BIT(offset);
 	writel(val, gs->gpio_io + YU_GPIO_CAUSE_OR_EVTEN0);
 	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(irqd));
 }
 
 static irqreturn_t mlxbf2_gpio_irq_handler(int irq, void *ptr)
@@ -322,6 +325,24 @@ mlxbf2_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	return 0;
 }
 
+static void mlxbf2_gpio_irq_print_chip(struct irq_data *irqd,
+				       struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf2_gpio_context *gs = gpiochip_get_data(gc);
+
+	seq_printf(p, dev_name(gs->dev));
+}
+
+static const struct irq_chip mlxbf2_gpio_irq_chip = {
+	.irq_set_type = mlxbf2_gpio_irq_set_type,
+	.irq_enable = mlxbf2_gpio_irq_enable,
+	.irq_disable = mlxbf2_gpio_irq_disable,
+	.irq_print_chip = mlxbf2_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /* BlueField-2 GPIO driver initialization routine. */
 static int
 mlxbf2_gpio_probe(struct platform_device *pdev)
@@ -340,6 +361,8 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 	if (!gs)
 		return -ENOMEM;
 
+	gs->dev = dev;
+
 	/* YU GPIO block address */
 	gs->gpio_io = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gs->gpio_io))
@@ -376,13 +399,8 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0) {
-		gs->irq_chip.name = name;
-		gs->irq_chip.irq_set_type = mlxbf2_gpio_irq_set_type;
-		gs->irq_chip.irq_enable = mlxbf2_gpio_irq_enable;
-		gs->irq_chip.irq_disable = mlxbf2_gpio_irq_disable;
-
 		girq = &gs->gc.irq;
-		girq->chip = &gs->irq_chip;
+		gpio_irq_chip_set_chip(girq, &mlxbf2_gpio_irq_chip);
 		girq->handler = handle_simple_irq;
 		girq->default_type = IRQ_TYPE_NONE;
 		/* This will let us handle the parent IRQ in the driver */

-- 
2.34.1

