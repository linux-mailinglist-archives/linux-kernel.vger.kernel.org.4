Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8605B6D5C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjDDJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjDDJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6B1BD0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c29so41632118lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKK9eLgubzxWPHMWxI1yK7d1/+43BWwyQkM2tfuG2Ww=;
        b=x7ppiWbyNyZwwriIorzWRnpZP4rWgQx6yFQbqXqh1OXDLJel4zda/pCcS6POdONcaG
         7Yv3e7fbUTqfjUrHeAtVc5xqJ4Gmz4/GtSFu4grqH+f3gGPtr0jGvRyKK6vRApV0uNNn
         pBO5KB050ARhuPvDhuT2MFcCNRi/fcfb9A8aqygpgQrVbjwJfG7hcodVt+q/oS/Bx9LW
         /fnKSlEVfDctfs5GeV3aYtiORbT1k5+p5mQ5pjXT0uBW89SPhm+5PXh2tDA/qmLebjcZ
         KK5Dn3f/RObhVpTmQsLbGJDuntgJHC8ftHLkH2+hc+DxBbBxb4xgIHwtdQT4P8ohou1j
         CfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKK9eLgubzxWPHMWxI1yK7d1/+43BWwyQkM2tfuG2Ww=;
        b=uqZwHWh/OGVpnthIJG/+v2OsUDB8kK7VV73DLVvWs/x+t+RYVedwnyhWmHoo0+QSKp
         IZp/NNzsd1tErcyHU+TzkhX9x+d2KmvVw/Ulz66v/n12yTWQlnjYjh1O+6/H3vIwXWg+
         V0HxLMdd0vxX8bdJfJkXCcEyLkzMLISNKA+qhUoruJJFD3lUTcwZPV9llKayB8Ux4rPJ
         nR1DwH6lWCCJL012WKGRaO8GraEBlhmL6VuKcfiZS+g85x93579m1n9YQvtjxY+DUlXK
         c79v1SxR+ZAVclebwQsezAjY8k38pSs/C9T/EH2at/ngs1tTL3D87wGjN1oRQ7WNHJbC
         TvVw==
X-Gm-Message-State: AAQBX9fF6eG/Smni353omIGGNoffUxsvKKx2f9/r8jFd3eL7f1Vlfpp3
        c0ptOmqNIGiANW24HuAwVxm1QA==
X-Google-Smtp-Source: AKy350bXU9qE5on50GOy/zA3QRbSNFs+CqcTvsLk9DkI3fNquQp8y9IwP/2sQB6t0bTIVTgIgnAjHw==
X-Received: by 2002:ac2:4c92:0:b0:4df:b32b:a2a3 with SMTP id d18-20020ac24c92000000b004dfb32ba2a3mr477734lfl.47.1680601390612;
        Tue, 04 Apr 2023 02:43:10 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:10 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 04 Apr 2023 11:43:03 +0200
Subject: [PATCH 1/9] pinctrl: iproc: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-immutable-irqchips-v1-1-503788a7f6e6@linaro.org>
References: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
In-Reply-To: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 38 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 3df56a4ea510..cc3eb7409ab3 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #include <linux/pinctrl/consumer.h>
@@ -108,7 +109,6 @@ struct iproc_gpio {
 
 	raw_spinlock_t lock;
 
-	struct irq_chip irqchip;
 	struct gpio_chip gc;
 	unsigned num_banks;
 
@@ -217,7 +217,7 @@ static void iproc_gpio_irq_set_mask(struct irq_data *d, bool unmask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
-	unsigned gpio = d->hwirq;
+	unsigned gpio = irqd_to_hwirq(d);
 
 	iproc_set_bit(chip, IPROC_GPIO_INT_MSK_OFFSET, gpio, unmask);
 }
@@ -231,6 +231,7 @@ static void iproc_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_gpio_irq_set_mask(d, false);
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void iproc_gpio_irq_unmask(struct irq_data *d)
@@ -239,6 +240,7 @@ static void iproc_gpio_irq_unmask(struct irq_data *d)
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_gpio_irq_set_mask(d, true);
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
@@ -302,6 +304,26 @@ static int iproc_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void iproc_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct iproc_gpio *chip = gpiochip_get_data(gc);
+
+	seq_printf(p, dev_name(chip->dev));
+}
+
+static const struct irq_chip iproc_gpio_irq_chip = {
+	.irq_ack = iproc_gpio_irq_ack,
+	.irq_mask = iproc_gpio_irq_mask,
+	.irq_unmask = iproc_gpio_irq_unmask,
+	.irq_set_type = iproc_gpio_irq_set_type,
+	.irq_enable = iproc_gpio_irq_unmask,
+	.irq_disable = iproc_gpio_irq_mask,
+	.irq_print_chip = iproc_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /*
  * Request the Iproc IOMUX pinmux controller to mux individual pins to GPIO
  */
@@ -852,20 +874,10 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	/* optional GPIO interrupt support */
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
-		struct irq_chip *irqc;
 		struct gpio_irq_chip *girq;
 
-		irqc = &chip->irqchip;
-		irqc->name = dev_name(dev);
-		irqc->irq_ack = iproc_gpio_irq_ack;
-		irqc->irq_mask = iproc_gpio_irq_mask;
-		irqc->irq_unmask = iproc_gpio_irq_unmask;
-		irqc->irq_set_type = iproc_gpio_irq_set_type;
-		irqc->irq_enable = iproc_gpio_irq_unmask;
-		irqc->irq_disable = iproc_gpio_irq_mask;
-
 		girq = &gc->irq;
-		girq->chip = irqc;
+		gpio_irq_chip_set_chip(girq, &iproc_gpio_irq_chip);
 		girq->parent_handler = iproc_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(dev, 1,

-- 
2.34.1

