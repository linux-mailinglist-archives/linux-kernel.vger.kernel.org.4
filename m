Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A816B1CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCIHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCIHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB874DF70D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so1134975lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhXTDSkBpSBmoLnt16h1xxcFV0v4vmTT7mnJI/zNpFI=;
        b=RdVd7acfqbV/RJ0zljVIdHf8OEekFM1TtLnwjfbFmZBCfpKs48zDqq9jmJ00FNhc3+
         /21cJMiUoapp6aQgyYn2yng55EYkn3VehxFmuN1KnP/66ZoKwnbW0Wb8Gmj1f2X4zxlV
         6LNliyaEJkqXcqyNFaQ/sM8kHziZlZvQx4gpkJETQSQ83/q9298lWDpGeGdTJmd6GNn4
         cGXLY4Hj3atvGpFxTvp1/dXiAJqtNMlGCMP2rAqJr2cXTfR7dDa2I1yjcHTBYj/eTDgY
         qwctT1YvUcEGtoaxJZUIzCJNr3Gjesc1tFMnBD9WrbkLI9DoPMhpqxXXFYdpMbMvZm76
         LW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhXTDSkBpSBmoLnt16h1xxcFV0v4vmTT7mnJI/zNpFI=;
        b=DKsjhH8UZHzFXzYBKYE2FkYrNW0irp4GtkT7iCVjpJkAUmjYe5oQXyVBg/0oZL0XTf
         L1OnFhVjcbwwlp0gNykJrlNiUxPbX6r7iVLIscgVQbFK0RuoY5R2qBCV2wuwDSXbQZ2y
         /0YuMxqsv/jDLVm7b+iEH7PE+4Kwptkn0JFtYdSwwb1kzcKKpZec7aQbpcj2F3GwY+6U
         9Swmzb6l0WJqLY++tupK3E1Y2R55gUc5MQzqGsbuMAzUz8r3FayBdPIFhGDs/lMtvpUr
         nK27+iz/rDE8AjSgy82AIBAwnK12Vi62sKQm69d2vWRP4A3yg8qwI6ZxgTdzt0Z17zg/
         ktBA==
X-Gm-Message-State: AO0yUKUcrtwnECPy3cMCFAfrAAJdgGdi64c/l5PIsfObq96niJK0gaRr
        LubRSuX4ELUJfxvtr/o3FxqJBw==
X-Google-Smtp-Source: AK7set+l0IBAcPEMof3/gCWtD/52DgbhsGMf+RINIiurOj/KsNvWkoCxqcEPKNnC9v2V7US9f4a2Fg==
X-Received: by 2002:ac2:5630:0:b0:4db:384c:bb8 with SMTP id b16-20020ac25630000000b004db384c0bb8mr5204447lff.69.1678347965235;
        Wed, 08 Mar 2023 23:46:05 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:57 +0100
Subject: [PATCH v3 09/17] gpio: hlwd: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-9-972542092a77@linaro.org>
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
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-hlwd.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 4e13e937f832..c208ac1c54a6 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 /*
@@ -48,7 +49,7 @@
 
 struct hlwd_gpio {
 	struct gpio_chip gpioc;
-	struct irq_chip irqc;
+	struct device *dev;
 	void __iomem *regs;
 	int irq;
 	u32 edge_emulation;
@@ -123,6 +124,7 @@ static void hlwd_gpio_irq_mask(struct irq_data *data)
 	mask &= ~BIT(data->hwirq);
 	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
 	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	gpiochip_disable_irq(&hlwd->gpioc, irqd_to_hwirq(data));
 }
 
 static void hlwd_gpio_irq_unmask(struct irq_data *data)
@@ -132,6 +134,7 @@ static void hlwd_gpio_irq_unmask(struct irq_data *data)
 	unsigned long flags;
 	u32 mask;
 
+	gpiochip_enable_irq(&hlwd->gpioc, irqd_to_hwirq(data));
 	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
 	mask |= BIT(data->hwirq);
@@ -202,6 +205,24 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
+static void hlwd_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+
+	seq_printf(p, dev_name(hlwd->dev));
+}
+
+static const struct irq_chip hlwd_gpio_irq_chip = {
+	.irq_mask = hlwd_gpio_irq_mask,
+	.irq_unmask = hlwd_gpio_irq_unmask,
+	.irq_enable = hlwd_gpio_irq_enable,
+	.irq_set_type = hlwd_gpio_irq_set_type,
+	.irq_print_chip = hlwd_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int hlwd_gpio_probe(struct platform_device *pdev)
 {
 	struct hlwd_gpio *hlwd;
@@ -216,6 +237,8 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(hlwd->regs))
 		return PTR_ERR(hlwd->regs);
 
+	hlwd->dev = &pdev->dev;
+
 	/*
 	 * Claim all GPIOs using the OWNER register. This will not work on
 	 * systems where the AHBPROT memory firewall hasn't been configured to
@@ -259,14 +282,8 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 			return hlwd->irq;
 		}
 
-		hlwd->irqc.name = dev_name(&pdev->dev);
-		hlwd->irqc.irq_mask = hlwd_gpio_irq_mask;
-		hlwd->irqc.irq_unmask = hlwd_gpio_irq_unmask;
-		hlwd->irqc.irq_enable = hlwd_gpio_irq_enable;
-		hlwd->irqc.irq_set_type = hlwd_gpio_irq_set_type;
-
 		girq = &hlwd->gpioc.irq;
-		girq->chip = &hlwd->irqc;
+		gpio_irq_chip_set_chip(girq, &hlwd_gpio_irq_chip);
 		girq->parent_handler = hlwd_gpio_irqhandler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

