Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248146C0DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCTJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCTJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:55:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C358A4C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g17so14142501lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679306119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOglr4b8wCIZjowHrmCHalgLUTFsF3VGPj317uHaVFA=;
        b=kJ56kO3MduhiDK5ybC0WL3qaOzThm6WPK8eMyB1OamVZiJfOcQk0xmXE/zSisFY0dB
         MppJxQ2gGiT09ZH487ElXsDAGrtQ/ogdwA2zLb0Xrf5q0OObLU48m9uZiBd5rmAoLz19
         c87J3IwGn68t/c4poAw7ckPaJz82738fW0ktSIKaoEfp0jn+T05UpNTxbunOynb+fYHS
         3pOHgEPRPuSq+G9TlA0LQSX0mKmEBwa7IIaeFArqxLcZtYTIWuNLH25t/aVdXOosDUVK
         DJlQYGwxDg16lZOq/vLKok6RDvSzlCo4SCMZSJUDvn/fvHwz+bQnbahCPa4VITowm5zF
         hSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOglr4b8wCIZjowHrmCHalgLUTFsF3VGPj317uHaVFA=;
        b=HfNI4w/FOp5hlhrNZ862NXPsHveSDA84TAlUAYG7WuU+U4C//feHqrPXaweBPFNRaU
         +KcIVOm/FoLf99REhMk9YGyULzYTHi+Jtgvq74eIWEMIt0AzPcgVy1RG+E9VwdhJQ+Tk
         iqGEoEzN2i/8vXfpoJIxjUdp8fMoet6H9kx676/nUCSXoY8oGLB7zVyBQMcCpjwZi+Bq
         tuHaRvgO8cqmOt/Z1MIL3n1o25Cu4KLRbYJOmySkqSMPRj3paAFLjNUrdu4sVxIIUjdL
         3MGHMRrJ0Yz79Ct5Wxj9vrizm4HDaNpGAcDqtBr56GdgF/TWS2i6eRvAUiwwo59COx+C
         700g==
X-Gm-Message-State: AO0yUKXiSgJdSwip2xgJqFeMiemtJeS0IZBaS9DVhNWh1ZIY3AQn8wZ0
        JOYaiEoObKXWh6sB6w13gYHtpg==
X-Google-Smtp-Source: AK7set+nN7wJ+atkoSzdFP68LNe4ASCgnZA7hoX78zbZLZDK9kBtZZM0z69izqvAxxmLwp/AJRTN/A==
X-Received: by 2002:ac2:46d4:0:b0:4e9:4d61:e750 with SMTP id p20-20020ac246d4000000b004e94d61e750mr4663273lfo.32.1679306119303;
        Mon, 20 Mar 2023 02:55:19 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004e792045b3dsm1640104lfm.106.2023.03.20.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:55:18 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 10:55:12 +0100
Subject: [PATCH 5/9] gpio: tqmx86: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230316-immutable-chips-2-v1-5-053d6ede831b@linaro.org>
References: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
In-Reply-To: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robert Richter <rric@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-tqmx86.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index e739dcea61b2..6f8bd1155db7 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #define TQMX86_NGPIO	8
@@ -34,7 +35,6 @@
 
 struct tqmx86_gpio_data {
 	struct gpio_chip	chip;
-	struct irq_chip		irq_chip;
 	void __iomem		*io_base;
 	int			irq;
 	raw_spinlock_t		spinlock;
@@ -122,6 +122,7 @@ static void tqmx86_gpio_irq_mask(struct irq_data *data)
 	gpiic &= ~mask;
 	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
+	gpiochip_disable_irq(&gpio->chip, irqd_to_hwirq(data));
 }
 
 static void tqmx86_gpio_irq_unmask(struct irq_data *data)
@@ -134,6 +135,7 @@ static void tqmx86_gpio_irq_unmask(struct irq_data *data)
 
 	mask = TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS);
 
+	gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(data));
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
 	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
 	gpiic &= ~mask;
@@ -226,6 +228,22 @@ static void tqmx86_init_irq_valid_mask(struct gpio_chip *chip,
 	clear_bit(3, valid_mask);
 }
 
+static void tqmx86_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, gc->label);
+}
+
+static const struct irq_chip tqmx86_gpio_irq_chip = {
+	.irq_mask = tqmx86_gpio_irq_mask,
+	.irq_unmask = tqmx86_gpio_irq_unmask,
+	.irq_set_type = tqmx86_gpio_irq_set_type,
+	.irq_print_chip = tqmx86_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int tqmx86_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -277,14 +295,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (irq > 0) {
-		struct irq_chip *irq_chip = &gpio->irq_chip;
 		u8 irq_status;
 
-		irq_chip->name = chip->label;
-		irq_chip->irq_mask = tqmx86_gpio_irq_mask;
-		irq_chip->irq_unmask = tqmx86_gpio_irq_unmask;
-		irq_chip->irq_set_type = tqmx86_gpio_irq_set_type;
-
 		/* Mask all interrupts */
 		tqmx86_gpio_write(gpio, 0, TQMX86_GPIIC);
 
@@ -293,7 +305,7 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		tqmx86_gpio_write(gpio, irq_status, TQMX86_GPIIS);
 
 		girq = &chip->irq;
-		girq->chip = irq_chip;
+		gpio_irq_chip_set_chip(girq, &tqmx86_gpio_irq_chip);
 		girq->parent_handler = tqmx86_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

