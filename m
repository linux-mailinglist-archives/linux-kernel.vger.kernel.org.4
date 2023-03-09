Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAD6B1CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCIHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCIHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3311DDF10
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so1161648lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYLgGoAAs4DcH8LZQncbtVAjj3rbStL1HUOVD02/kfE=;
        b=rJW1pSbwgXGQIlPm5ZBopg7dEA8C3O55AzE5vYaOruYmgvx5z0j4F7H0Lewh/xU3Dd
         /xeRDYCyohcL0ULLOkqBAsG46h38ZzjlCTW3uMseFqTSg1h4cuygoaeaJL5N27Y+krl9
         XwIDv02p5/81Z9aTe/zJ9iT+5T6G7cfeMDThpA/1G2zkZUNgLKvDm/s4yLJehxUn59Y2
         zkg9YB16i46HNi0D1AyIlIyZSE9TCV2nAMM74+snebtys9ozxLiRKJ/Wn0yAwXt8WuXg
         Wb1AXDnYkimrgs3ZMuS/B8e09KuQwmWyxwCQsGqDOjtXrKfgmI/NTlQOVLm6XUXiTC8D
         bOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYLgGoAAs4DcH8LZQncbtVAjj3rbStL1HUOVD02/kfE=;
        b=NYnRtJVImQwx5m/58Z9aXwLA63qtPSBShj5MNloyMYQd1OL4Phh9JbPcRtRTYqVcSo
         Y8ktIwihVrXCUjhHnp7Rt7u8HaSibERaR7HijaLEOHxftQ6e63SEa4fwqTdmiq0N/Rma
         X/Xmr+St5W8mWmugiFXsYUilR93lsRg5LuVUkML7acvdX2FBEgvQ9frYiJ0YuDldwD3S
         mltuS6U/sw0SwRqNZJkqd7+NgTYhNWK4QoEjXpZZ8xPf9ZmKihHPe2RX+AfzVUth1lEi
         kB+Gn2GX9A2O8IqrBdgOXAX+DzxUN+x9TAO4PpdVm6y+zWbKrY8d4m+8egK1Ji/d+25M
         WDDg==
X-Gm-Message-State: AO0yUKWfTk6rJFn5RXcIhUrJ+VWB4WwSuWCM62Y4cXErN2/+OAwTe32I
        bBrlwgQRcdozS/I7xmsNyc83Dw==
X-Google-Smtp-Source: AK7set+OwrelDKOTCHQ5D4UzvKLaGoQSyvbZB2fwQemO/aBw4V37VR9FeZ0MmSn2ufVp+AZCP6MVTQ==
X-Received: by 2002:ac2:5a4c:0:b0:4dc:7ff4:83f9 with SMTP id r12-20020ac25a4c000000b004dc7ff483f9mr6093156lfn.16.1678347971558;
        Wed, 08 Mar 2023 23:46:11 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:46:03 +0100
Subject: [PATCH v3 15/17] gpio: omap: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-15-972542092a77@linaro.org>
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
        Marc Zyngier <maz@kernel.org>, Tony Lindgren <tony@atomide.com>
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

This driver require some special care: .irq_ack() was copied
from dummy_irq_chip where it was defined as noop. This only
makes sense if using handle_edge_irq() that will unconditionally
call .irq_ack() to avoid a crash, but this driver is not ever
using handle_edge_irq() so just avoid assigning .irq_ack().

A separate chip had to be created for the non-wakeup instance.

Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-omap.c | 68 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1cbd040cf796..a08be5bf6808 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <linux/syscore_ops.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -47,6 +48,7 @@ struct gpio_regs {
 struct gpio_bank {
 	void __iomem *base;
 	const struct omap_gpio_reg_offs *regs;
+	struct device *dev;
 
 	int irq;
 	u32 non_wakeup_gpios;
@@ -681,6 +683,7 @@ static void omap_gpio_mask_irq(struct irq_data *d)
 	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 	omap_set_gpio_irqenable(bank, offset, 0);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
+	gpiochip_disable_irq(&bank->chip, offset);
 }
 
 static void omap_gpio_unmask_irq(struct irq_data *d)
@@ -690,6 +693,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
+	gpiochip_enable_irq(&bank->chip, offset);
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_set_gpio_irqenable(bank, offset, 1);
 
@@ -708,6 +712,40 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void omap_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+
+	seq_printf(p, dev_name(bank->dev));
+}
+
+static const struct irq_chip omap_gpio_irq_chip = {
+	.irq_startup = omap_gpio_irq_startup,
+	.irq_shutdown = omap_gpio_irq_shutdown,
+	.irq_mask = omap_gpio_mask_irq,
+	.irq_unmask = omap_gpio_unmask_irq,
+	.irq_set_type = omap_gpio_irq_type,
+	.irq_set_wake = omap_gpio_wake_enable,
+	.irq_bus_lock = omap_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	.irq_print_chip = omap_gpio_irq_print_chip,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static const struct irq_chip omap_gpio_irq_chip_nowake = {
+	.irq_startup = omap_gpio_irq_startup,
+	.irq_shutdown = omap_gpio_irq_shutdown,
+	.irq_mask = omap_gpio_mask_irq,
+	.irq_unmask = omap_gpio_unmask_irq,
+	.irq_set_type = omap_gpio_irq_type,
+	.irq_bus_lock = omap_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	.irq_print_chip = omap_gpio_irq_print_chip,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -986,8 +1024,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		writel_relaxed(0, base + bank->regs->ctrl);
 }
 
-static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
-			       struct device *pm_dev)
+static int omap_gpio_chip_init(struct gpio_bank *bank, struct device *pm_dev)
 {
 	struct gpio_irq_chip *irq;
 	static int gpio;
@@ -1023,12 +1060,12 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 	}
 	bank->chip.ngpio = bank->width;
 
+	irq = &bank->chip.irq;
 	/* MPUIO is a bit different, reading IRQ status clears it */
 	if (bank->is_mpuio && !bank->regs->wkup_en)
-		irqc->irq_set_wake = NULL;
-
-	irq = &bank->chip.irq;
-	irq->chip = irqc;
+		gpio_irq_chip_set_chip(irq, &omap_gpio_irq_chip_nowake);
+	else
+		gpio_irq_chip_set_chip(irq, &omap_gpio_irq_chip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->num_parents = 1;
@@ -1361,7 +1398,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct omap_gpio_platform_data *pdata;
 	struct gpio_bank *bank;
-	struct irq_chip *irqc;
 	int ret;
 
 	pdata = device_get_match_data(dev);
@@ -1374,21 +1410,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
-	if (!irqc)
-		return -ENOMEM;
-
-	irqc->irq_startup = omap_gpio_irq_startup,
-	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = dummy_irq_chip.irq_ack,
-	irqc->irq_mask = omap_gpio_mask_irq,
-	irqc->irq_unmask = omap_gpio_unmask_irq,
-	irqc->irq_set_type = omap_gpio_irq_type,
-	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
-	irqc->name = dev_name(&pdev->dev);
-	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	bank->dev = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
@@ -1452,7 +1474,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_mod_init(bank);
 
-	ret = omap_gpio_chip_init(bank, irqc, dev);
+	ret = omap_gpio_chip_init(bank, dev);
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);

-- 
2.34.1

