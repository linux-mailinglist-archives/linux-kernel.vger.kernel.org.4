Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562D699011
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjBPJhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D34DBEB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x40so1987795lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaDptLg2UVfjqxgkXWYzcP1ggIHL/kszXzjjR0QT2QQ=;
        b=Nc/3HPDf/zDE3psdZKg1RxbHj5tDQDAPbVuynb6mr5oJqEKJPLWFhaS6FuZQPPQV6o
         URXeisV6ZgOyFB59ZPwn6rPlhbXFG6Whzf9PV6EYUbFIA8g1QnXiLVQqFL4S4MoGDI1J
         tCYJM8e42fb9sSJy1XmoEuo5n3tlx9BChJY/O/zKhZ7Q5TDo+OJFbw2bjDZBuZyUdrxW
         +4dwk0l/g4oLab6Nk8270tgqBm5nzhn2ESOkD5E35yuM7pxrJGGsSyuHVAszesmrNQsn
         pjyVlyoLY/VlOYVUegUCfg+RaTThJlaEWAW09TR7ZyboqT5mnLinycEdkoxtZUcROgNy
         /7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaDptLg2UVfjqxgkXWYzcP1ggIHL/kszXzjjR0QT2QQ=;
        b=mBHbxPtesL6bfaCv1BhzOV2SnfjQVzcMcrycmMdALrbNyYTnnccufIMYjsMLZrcEq9
         8mP1/IdhQ9JOXw59/Cq+2034C43uzhc+AtI6rpLW62KYi5abKMDJUcWcsETciRpYCt1t
         /aD5i91kgv7o9Yzoan1M5MG2ZSOy9WXbbRtyniW66rc4gGW13sIco1HmR8nyR4BsTbra
         PJyucoEXflufrO/GM0B+eYWkZT7riTayXGPP72VcaEp7Nkz+WMKZeMKtgrSM8MWNHbWQ
         sDhhlqTCHrAccIX4mu7o+qOlOlkwx0hM525mU8D9bMJKnoVzfBtCe0OfQSKob55IV7PB
         YMkA==
X-Gm-Message-State: AO0yUKWz/Mt2NWAs2MsNSQB0TushT2r2OwdJeqA0OV2b18jXyLeOEq5M
        xX9QphPvo0TFEe9cGYpPPCa7Tw==
X-Google-Smtp-Source: AK7set9jmnZ34oHZ75u5rUCL5UMspu8IPo+MiQGCKlLhNckaja93qlQdN57YA9SIeQ1bSN3ICzBBjA==
X-Received: by 2002:a05:6512:73:b0:4db:25c0:5155 with SMTP id i19-20020a056512007300b004db25c05155mr1503320lfo.45.1676540238183;
        Thu, 16 Feb 2023 01:37:18 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:12 +0100
Subject: [PATCH 11/17] gpio: msc313: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-11-51a8f224a5d0@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

This conversion follows the pattern of the gpio-ixp4xx
hierarchical GPIO interrupt driver.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-msc313.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index 52d7b8d99170..57a6c43167f7 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -532,17 +532,35 @@ static int msc313_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 	return 0;
 }
 
+static void msc313_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	irq_chip_mask_parent(d);
+	gpiochip_disable_irq(gc, d->hwirq);
+}
+
+static void msc313_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, d->hwirq);
+	irq_chip_unmask_parent(d);
+}
+
 /*
  * The interrupt handling happens in the parent interrupt controller,
  * we don't do anything here.
  */
-static struct irq_chip msc313_gpio_irqchip = {
+static const struct irq_chip msc313_gpio_irqchip = {
 	.name = "GPIO",
 	.irq_eoi = irq_chip_eoi_parent,
-	.irq_mask = irq_chip_mask_parent,
-	.irq_unmask = irq_chip_unmask_parent,
+	.irq_mask = msc313_gpio_irq_mask,
+	.irq_unmask = msc313_gpio_irq_unmask,
 	.irq_set_type = irq_chip_set_type_parent,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 /*
@@ -644,7 +662,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	gpiochip->names = gpio->gpio_data->names;
 
 	gpioirqchip = &gpiochip->irq;
-	gpioirqchip->chip = &msc313_gpio_irqchip;
+	gpio_irq_chip_set_chip(gpioirqchip, &msc313_gpio_irqchip);
 	gpioirqchip->fwnode = of_node_to_fwnode(dev->of_node);
 	gpioirqchip->parent_domain = parent_domain;
 	gpioirqchip->child_to_parent_hwirq = msc313e_gpio_child_to_parent_hwirq;

-- 
2.34.1

