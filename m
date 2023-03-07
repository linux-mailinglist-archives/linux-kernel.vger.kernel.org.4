Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9C6ADFF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCGNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCGNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:44 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33BA277
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t14so13056810ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBLzNrziBJousn1yobeY2nHyRl+4RLWPBMZMMzuQhho=;
        b=WoDr9naT88KPAmWtmecnyXyKXIJdxVKHY3fSLJFVbGwG76jmxOMnW1et6daEkqtG8a
         ihRSCVa77byEIL8HXfej//ovzCXo2+wz4tewtmwIYanbdWMiw1u7VZSjs3FvkhLGWAAz
         8bU+ToyGYK5TQqxPFixsNJk3BwPb+xCmOtBb1wfh0vJiixcJpC+jZ6wCUl1pBey1Sfnj
         5O+2O/5WrBnQhSh/+P8FR0PuM04bQvZab0oLWH67mE9DsyTdVwceUHDEC87OzrOq7RJH
         NAeSyLCPgKw2C9ADzYlHWxkINSMPIl1OEVULA0x0k+31OVxFKBls9sFnQoFEVdHaeguW
         1tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBLzNrziBJousn1yobeY2nHyRl+4RLWPBMZMMzuQhho=;
        b=gBC3PpNW7ho6E+2Rnn6AjUlsKlAjuetvKnHsyybmd3IXVn7v6tfjlvTjSuIa7EnTv6
         g+mHifsx0ZU0MM5h28xtNcXjWTzPsrXk5+5uQj6sYt+izexcP4CNsxQG/gdWMsolx0td
         dc7z9JK7Y4TXUTKzuIsyj9B3426gwT/p9JqUgIcxHNRJy5ibb0qyflzWgvhlJvFyoZfz
         /53hYRGl3sf7/hTeR7kz4xVrHvX/+HDAn7E7VtLBYjejrCKQMe+TEYM/h4rdBzyHVs8j
         KnTgWtdJlEpSQKcyphIlFLMPlG9FQEODJVUTkzhHZLmQjmloUYsitE3qw4Rz7Yc0+K3B
         24GQ==
X-Gm-Message-State: AO0yUKVhfdgDhxgrjpm/avNsBfFVJeZhVPKh+606Gv859yl0uKHm5vdP
        pb+5HDq0y0LekzzINlu4wI3IVA==
X-Google-Smtp-Source: AK7set9FIRk+D02EpqNXIipxeF+W2c44Rc49IDIGvQg7pSf1+vwkxVbmpAXxb9VPe8SErITD4clMrg==
X-Received: by 2002:a2e:a99b:0:b0:28b:6525:e6b1 with SMTP id x27-20020a2ea99b000000b0028b6525e6b1mr4810829ljq.24.1678194301238;
        Tue, 07 Mar 2023 05:05:01 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:05:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:57 +0100
Subject: [PATCH v2 15/16] gpio: pci-idio-16: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-15-d6b0e3f2d991@linaro.org>
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
Acked-by: William Breathitt Gray <william.gray@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pci-idio-16.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index a86ce748384b..6726c32e31e6 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -107,6 +107,8 @@ static void idio_16_irq_mask(struct irq_data *data)
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
+
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void idio_16_irq_unmask(struct irq_data *data)
@@ -117,6 +119,8 @@ static void idio_16_irq_unmask(struct irq_data *data)
 	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
 	unsigned long flags;
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
+
 	idio16gpio->irq_mask |= mask;
 
 	if (!prev_irq_mask) {
@@ -138,12 +142,14 @@ static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idio_16_irqchip = {
+static const struct irq_chip idio_16_irqchip = {
 	.name = "pci-idio-16",
 	.irq_ack = idio_16_irq_ack,
 	.irq_mask = idio_16_irq_mask,
 	.irq_unmask = idio_16_irq_unmask,
-	.irq_set_type = idio_16_irq_set_type
+	.irq_set_type = idio_16_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
@@ -242,7 +248,7 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio_16_state_init(&idio16gpio->state);
 
 	girq = &idio16gpio->chip.irq;
-	girq->chip = &idio_16_irqchip;
+	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;

-- 
2.34.1

