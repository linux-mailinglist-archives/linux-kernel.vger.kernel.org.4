Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C16D5C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjDDJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjDDJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF051BEA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c29so41632161lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1U3mznWUSnJq2x7KzrZeo74yHwZxjse8U63SQkTN4k=;
        b=eX5ZeFcrDyeOZ/+cmIw1GthasxB336QssKMWmkFVFjzUzquTWCGLPH0q1EZGkx57D7
         lMBTV4GQvDuLwdcpX7uMkCsYiT15dsHdEflv9g0w1W+ahbDSVxbyUvz5gUTVJ5sYN5nd
         gGSkMJIKgzuEsvJpz5qvVuUa9tXPAIFLLMxBUS9ZN6aJGEJa88cvLFIhVRzr7cFD3xO4
         V/C0tVGfceLtY5T6HC9Bg5fuMQSPe39vC9gft3my7IAoHhwOGoYe386nE0RCa7Nph0FF
         HFz4nkApA+T03Chl0EFnlvCZrI+HrbjlWiHUeCW0UG/pPXcOb+msKYSk3REigmMJsDvV
         tYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1U3mznWUSnJq2x7KzrZeo74yHwZxjse8U63SQkTN4k=;
        b=ucHHd5+1AImvREDep9Iw/1dRuH3rAwYWh4hGg9JnTSkcqMUxylbEzwMyC7BmilCZ36
         KMSF0/lnCHlOTLoIV3O3m3Au1af7rG8GNYzL4JklIHAFSLcydUaPCdHR16xZIc5wseuv
         UfhX8p/6+toFxgcmuf5Iyi4kDTPW7Pqv+K5tAGs0k5vxI6v2eUcdXjbwKALIXBOn9dWy
         GDKzTt9Q/xDKGe3EIcUvtEWGbZiKVbaAYg7yUEqSPjg/eTeXULritfTiZZ1RLPtO/0xF
         4HIE91lLyCzeXfmuq+H20KHq6sD4o/eoz30cKY+iTAZAVU8nx5ZNHS5EUWP5i6RLpVug
         7AxA==
X-Gm-Message-State: AAQBX9efCR+2DHA+635s9sOCoM4Yi1TDlxN9/T8ymHLWlDjECOsinU+v
        tQJbgW5QDFd3W3QLJHSEaiF8Ww==
X-Google-Smtp-Source: AKy350a7DLDlAx2wATbxYZ+yV4+OnJfCSexEHHMxv0+zsfQNpGxjvujPBQwRFlw396afIThPkSlLDg==
X-Received: by 2002:a05:6512:118d:b0:4eb:2b62:134f with SMTP id g13-20020a056512118d00b004eb2b62134fmr4661753lfr.16.1680601391634;
        Tue, 04 Apr 2023 02:43:11 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 04 Apr 2023 11:43:04 +0200
Subject: [PATCH 2/9] pinctrl: nsp: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-immutable-irqchips-v1-2-503788a7f6e6@linaro.org>
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
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index 3c792bf03bda..5045a7e57f1d 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -60,7 +60,6 @@ struct nsp_gpio {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *io_ctrl;
-	struct irq_chip irqchip;
 	struct gpio_chip gc;
 	struct pinctrl_dev *pctl;
 	struct pinctrl_desc pctldesc;
@@ -193,6 +192,7 @@ static void nsp_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_gpio_irq_set_mask(d, false);
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void nsp_gpio_irq_unmask(struct irq_data *d)
@@ -201,6 +201,7 @@ static void nsp_gpio_irq_unmask(struct irq_data *d)
 	struct nsp_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_gpio_irq_set_mask(d, true);
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
@@ -258,6 +259,16 @@ static int nsp_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static const struct irq_chip nsp_gpio_irq_chip = {
+	.name = "gpio-a",
+	.irq_ack = nsp_gpio_irq_ack,
+	.irq_mask = nsp_gpio_irq_mask,
+	.irq_unmask = nsp_gpio_irq_unmask,
+	.irq_set_type = nsp_gpio_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int nsp_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
 {
 	struct nsp_gpio *chip = gpiochip_get_data(gc);
@@ -650,14 +661,6 @@ static int nsp_gpio_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0) {
 		struct gpio_irq_chip *girq;
-		struct irq_chip *irqc;
-
-		irqc = &chip->irqchip;
-		irqc->name = "gpio-a";
-		irqc->irq_ack = nsp_gpio_irq_ack;
-		irqc->irq_mask = nsp_gpio_irq_mask;
-		irqc->irq_unmask = nsp_gpio_irq_unmask;
-		irqc->irq_set_type = nsp_gpio_irq_set_type;
 
 		val = readl(chip->base + NSP_CHIP_A_INT_MASK);
 		val = val | NSP_CHIP_A_GPIO_INT_BIT;
@@ -673,7 +676,7 @@ static int nsp_gpio_probe(struct platform_device *pdev)
 		}
 
 		girq = &chip->gc.irq;
-		girq->chip = irqc;
+		gpio_irq_chip_set_chip(girq, &nsp_gpio_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
 		girq->num_parents = 0;

-- 
2.34.1

