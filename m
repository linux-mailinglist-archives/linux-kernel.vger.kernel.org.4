Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45B699006
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBPJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACD4DE07
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so2054717lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl7R3r+A9Tke4e8NDXF8qIlLiiRge2GGICvgO2R5L/w=;
        b=pxg7ldUM+y/9fT9HO1vpoLqyx8DYhPtT6WOYDNRvnDXt8XRMcK2H4HHWdzhdN2X3pq
         JqqfuHvt0rEDXyZjSQbWfIIqwdObuT7LyZr1EdmYFdfnEeuq8qQmFF++dAARzomTLzB8
         AB6rLIKbdkGW6kAHAeOh4qiFiilKhBwjkOphvIkbJs+w2QO3qJ9fE4Uh01+l9xsonc/U
         fcqfkFUtiOe9BBS2Hdy5UvrXLWa7k4y6bQm61tKfbhQYfRh/1oE72H7e56Z5tkc4gBfQ
         SbyiSNKmV27w/l3jTYH9jYqTfdWC2w/dzQJ9jpF8kjB1WSE/f9vgRmUIVWsvA6z2VjUe
         tAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl7R3r+A9Tke4e8NDXF8qIlLiiRge2GGICvgO2R5L/w=;
        b=udv8Y9dN46qoVzmj0KNopAqoKH+VIb8Yr5UYGsnitGpuHqc3jwIFCDSUh12NymJShL
         UBJXjCwKuc3GiC6O4pYBcU4YdPZ6xeyvg6ywtsGwmrHgYn6yypJVmJTfdrbArJNrl362
         HbGNDnu3NuEcSXDeRjV23a/UwPhBL+hfVwZNRp3lE/t0qWJyXcEljVClEYTpqMb8VsKe
         DYlot79mTB+AMAlpd/IM2VIq5e0AhyY4x8iO6NjOB974aeCcOJKdeceb7DMt4TSzZZYg
         DxfRFUOXWsPlQray8sC6eOJ5ELWymnji/CObK80hJ7sfvDkfKu+dasy5zyD8VXGtPtcs
         1Ngw==
X-Gm-Message-State: AO0yUKVe37Ku+3AJvLTimQw64t12/WIVvbV2ClWBYxmuqQgqQghrufDn
        6WyxZ8j3vbPctT8Kdk1zL+ujOQ==
X-Google-Smtp-Source: AK7set+5lpyG/A2gkwOREVj7bxbC83xONCYNQmZgPFTTuF7G7vmN1Ht/jlCYKhdZTaaDaEp0VlLhFw==
X-Received: by 2002:ac2:5544:0:b0:4d7:2e11:d075 with SMTP id l4-20020ac25544000000b004d72e11d075mr1551317lfk.45.1676540232747;
        Thu, 16 Feb 2023 01:37:12 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:12 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:08 +0100
Subject: [PATCH 07/17] gpio: eic_sprd: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-7-51a8f224a5d0@linaro.org>
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
 drivers/gpio/gpio-eic-sprd.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 8d722e026e9c..695d74ba55f0 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
 /* EIC registers definition */
@@ -91,7 +92,7 @@ enum sprd_eic_type {
 
 struct sprd_eic {
 	struct gpio_chip chip;
-	struct irq_chip intc;
+	struct device *dev;
 	void __iomem *base[SPRD_EIC_MAX_BANK];
 	enum sprd_eic_type type;
 	spinlock_t lock;
@@ -255,6 +256,7 @@ static void sprd_eic_irq_mask(struct irq_data *data)
 	default:
 		dev_err(chip->parent, "Unsupported EIC type.\n");
 	}
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void sprd_eic_irq_unmask(struct irq_data *data)
@@ -263,6 +265,7 @@ static void sprd_eic_irq_unmask(struct irq_data *data)
 	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
 	switch (sprd_eic->type) {
 	case SPRD_EIC_DEBOUNCE:
 		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 1);
@@ -564,6 +567,24 @@ static void sprd_eic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
+static void sprd_eic_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+
+	seq_printf(p, dev_name(sprd_eic->dev));
+}
+
+static const struct irq_chip sprd_eic_irq_chip = {
+	.irq_ack = sprd_eic_irq_ack,
+	.irq_mask = sprd_eic_irq_mask,
+	.irq_unmask = sprd_eic_irq_unmask,
+	.irq_set_type = sprd_eic_irq_set_type,
+	.irq_print_chip = sprd_eic_irq_print_chip,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -584,6 +605,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sprd_eic->lock);
 	sprd_eic->type = pdata->type;
+	sprd_eic->dev = &pdev->dev;
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
 	if (sprd_eic->irq < 0)
@@ -626,15 +648,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		break;
 	}
 
-	sprd_eic->intc.name = dev_name(&pdev->dev);
-	sprd_eic->intc.irq_ack = sprd_eic_irq_ack;
-	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
-	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
-	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
-	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
-
 	irq = &sprd_eic->chip.irq;
-	irq->chip = &sprd_eic->intc;
+	gpio_irq_chip_set_chip(irq, &sprd_eic_irq_chip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_eic_irq_handler;

-- 
2.34.1

