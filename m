Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E96C0DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCTJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCTJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:55:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA24208
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b10so12943404lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679306122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONs8hu4DakRq6Eq9QQk6sVabt3pk1jUGku2e96eNaoc=;
        b=aOazW7qyLg8EFAxpfusMynHT4aR5dT28i5YmCDy2aNE49eIk4P+GQ36cGYKN769CRr
         8MkfV47LsZ80x+/3fpq0B+lMRPiab+22V/Z6LIGq14vI7NkNTumNzLDvAegjlBKrKiED
         CHMcfcXyEZuYYPSJNKR3mketsbGFofKCVw2uSSXwVWr8U1utrhwdZ0QehLWUyi5Dadpd
         Jbj8c7/XlikkigGSWOIokZzMIs5a/eKH8LEosYiibLs+1z3BAW4j9/9Q+RHg13e3SDFJ
         /Gb8o/Df2SJUEbvYbCJnKo4RkxaNF1CXYnsJ2MLVe6QcXoHDeRRWRu4g6DOsK4q7iC+V
         LyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONs8hu4DakRq6Eq9QQk6sVabt3pk1jUGku2e96eNaoc=;
        b=zmSYCYIbk4scSFjwJNjZrlGeGoAEPeyO2O+vGzfY/nMkZ+Ho8JGlrrn9MK1y5O8/M9
         MIGnZ4GstAY8I20pCJ3tM23MJYV9SCkXfq+NQn6gGTikFhdoED7SeRVnvgrXndJY24Ds
         6GdjZPBUzgioahLVXpPD2muz58t5mFU3k4sjkiiYCzfDrGtoag0T7e4q1vEFM7cybMY9
         tFWTcJ7tqwklrNeXAazXPUy55NDgS4fCJI+7VgqeuC19U2pQtpeEJ8QjIaIsaZlxzin5
         ZGaY30fvkqrLx5OZEnx8zOEJe1XH+kKzp3G4JdXzLmbJjQF0490JqoWpC11yXaokJ9vU
         UCeQ==
X-Gm-Message-State: AO0yUKV8lsaOIjhyg8entP2ukXQ4tgY73pVjoQ31XPu4nR/3TdkLRnqj
        +Y45TVAALtWPOYW5P8rKIYX/iQ==
X-Google-Smtp-Source: AK7set8w6iy03am10n1Sm2MgCdWv1BERnE5+g5WCs7+WojuUv198OHiedcdFMO8QaEfHsO52hTcu8A==
X-Received: by 2002:a19:f00d:0:b0:4e9:d53:a5ef with SMTP id p13-20020a19f00d000000b004e90d53a5efmr4588282lfc.1.1679306122703;
        Mon, 20 Mar 2023 02:55:22 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004e792045b3dsm1640104lfm.106.2023.03.20.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:55:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 10:55:15 +0100
Subject: [PATCH 8/9] gpio: xilinx: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230316-immutable-chips-2-v1-8-053d6ede831b@linaro.org>
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
 drivers/gpio/gpio-xilinx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index e248809965ca..1fa66f2a667f 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -68,7 +68,6 @@ struct xgpio_instance {
 	DECLARE_BITMAP(dir, 64);
 	spinlock_t gpio_lock;	/* For serializing operations */
 	int irq;
-	struct irq_chip irqchip;
 	DECLARE_BITMAP(enable, 64);
 	DECLARE_BITMAP(rising_edge, 64);
 	DECLARE_BITMAP(falling_edge, 64);
@@ -416,6 +415,8 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
 	}
 	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+
+	gpiochip_disable_irq(&chip->gc, irq_offset);
 }
 
 /**
@@ -431,6 +432,8 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 	u32 old_enable = xgpio_get_value32(chip->enable, bit);
 	u32 mask = BIT(bit / 32), val;
 
+	gpiochip_enable_irq(&chip->gc, irq_offset);
+
 	spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__set_bit(bit, chip->enable);
@@ -544,6 +547,16 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static const struct irq_chip xgpio_irq_chip = {
+	.name = "gpio-xilinx",
+	.irq_ack = xgpio_irq_ack,
+	.irq_mask = xgpio_irq_mask,
+	.irq_unmask = xgpio_irq_unmask,
+	.irq_set_type = xgpio_set_irq_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /**
  * xgpio_probe - Probe method for the GPIO device.
  * @pdev: pointer to the platform device
@@ -653,12 +666,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	if (chip->irq <= 0)
 		goto skip_irq;
 
-	chip->irqchip.name = "gpio-xilinx";
-	chip->irqchip.irq_ack = xgpio_irq_ack;
-	chip->irqchip.irq_mask = xgpio_irq_mask;
-	chip->irqchip.irq_unmask = xgpio_irq_unmask;
-	chip->irqchip.irq_set_type = xgpio_set_irq_type;
-
 	/* Disable per-channel interrupts */
 	xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, 0);
 	/* Clear any existing per-channel interrupts */
@@ -668,7 +675,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	xgpio_writereg(chip->regs + XGPIO_GIER_OFFSET, XGPIO_GIER_IE);
 
 	girq = &chip->gc.irq;
-	girq->chip = &chip->irqchip;
+	gpio_irq_chip_set_chip(girq, &xgpio_irq_chip);
 	girq->parent_handler = xgpio_irqhandler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

