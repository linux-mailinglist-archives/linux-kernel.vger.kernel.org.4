Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BF6B1CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCIHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCIHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1215DF729
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j11so1118071lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE0hN/evTOxc8pxKXkniQeMiy8yek7h1H53mI21BTS8=;
        b=wJC3zufwPxxsbKw7VfvKKo3TwQtynJvjK4ttQs4bLtNyCksMt/VUnyY2BAbGcZ0wtG
         Z8D4qs41flPvAArqB5IeScGx0OuJ3Y7b5xrdlVrR8/nx93gcNo2qIhz9ELUvRLrg5G33
         SKHUIgTXjHgfbHrlzU0SyIMIcJjeR0/6LJakIm2q2d1xVcsm13ovij7Qr/i7HpJUYDDZ
         5/pHCUJA2ejaKXai6/ynckG06C8xwHNzmp0nBIcXKjVMJK1Yl1Jqu49ECcYleQcCO3BM
         iV4ZI0ur3ifZGcLbEU/77B5APP93JAcyJcKWXx0P+1HMwVuCU8lmquVKY7yB62YJEjmC
         0Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE0hN/evTOxc8pxKXkniQeMiy8yek7h1H53mI21BTS8=;
        b=U20QBcic9MeMtCqtBEzWz4Df8LZHrR/xOGJIC+iao2xv+wrVnk7E46UJJGO6Ia3i3b
         IcpfF1HW+Tbwt8iTK60U2PzOo71KroD72UxVxEL5TBUWYFAEk1A+6BwK4VHK7RQ3thQ6
         0HLy9aaWQlDrlEzjFQgdaNdu2oc+SXVZCfN/B6xhw33HnkoQZkV780mNcHzAFfu2YhLj
         sopXqGrPimDjL6veXyHzUafJ3s30BkieZiHHFLRa8bReH0szpS6VIo2DCooo7R+GB8FE
         UKjYLOTOs7G5Uo1TtyO7W8iCWo3ZPlPM8PkwtIXG/Rgo8Y7GHn18FI1EeUIOo+rrx7h/
         OdxQ==
X-Gm-Message-State: AO0yUKUSSCtStvlDJM68oxW5ihNQTZn9DW1BLqnSfuc2yw2XWLYEEx+c
        kFaXpRLufoVzZ6CvieijVXenKQ==
X-Google-Smtp-Source: AK7set8oIb7klIzQY7BPa8cZvqgfYhhXZT50T/adiRtau3X8Oi4aw7qxIH/e+BQ9EDeRLQ0xkXKhbg==
X-Received: by 2002:ac2:50d5:0:b0:4dd:a57e:9960 with SMTP id h21-20020ac250d5000000b004dda57e9960mr5974777lfm.5.1678347969422;
        Wed, 08 Mar 2023 23:46:09 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:46:01 +0100
Subject: [PATCH v3 13/17] gpio: max732x: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-13-972542092a77@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-max732x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 68e982cdee73..7f2fde191755 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -351,6 +351,7 @@ static void max732x_irq_mask(struct irq_data *d)
 	struct max732x_chip *chip = gpiochip_get_data(gc);
 
 	chip->irq_mask_cur &= ~(1 << d->hwirq);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void max732x_irq_unmask(struct irq_data *d)
@@ -358,6 +359,7 @@ static void max732x_irq_unmask(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct max732x_chip *chip = gpiochip_get_data(gc);
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
 	chip->irq_mask_cur |= 1 << d->hwirq;
 }
 
@@ -429,7 +431,7 @@ static int max732x_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static struct irq_chip max732x_irq_chip = {
+static const struct irq_chip max732x_irq_chip = {
 	.name			= "max732x",
 	.irq_mask		= max732x_irq_mask,
 	.irq_unmask		= max732x_irq_unmask,
@@ -437,6 +439,8 @@ static struct irq_chip max732x_irq_chip = {
 	.irq_bus_sync_unlock	= max732x_irq_bus_sync_unlock,
 	.irq_set_type		= max732x_irq_set_type,
 	.irq_set_wake		= max732x_irq_set_wake,
+	.flags			= IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static uint8_t max732x_irq_pending(struct max732x_chip *chip)
@@ -517,7 +521,7 @@ static int max732x_irq_setup(struct max732x_chip *chip,
 		}
 
 		girq = &chip->gpio_chip.irq;
-		girq->chip = &max732x_irq_chip;
+		gpio_irq_chip_set_chip(girq, &max732x_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
 		girq->num_parents = 0;

-- 
2.34.1

