Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E16ADFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCGNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCGNFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF627E8A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n2so16924624lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ycp1fOFRcqnvrXtuAswlNcdj2NkXI8qjDu7ztULp4g=;
        b=QehD1bhYUi9CqVD9QXVP0PtANkHCGauBClYHYYp0hr12HX7h0TkjG6fFMxmn9vm4Fq
         A0X4es0spCzccWcbPoMxmOrMCNy/A5TG0QfpzMRBydTn0gUeRbHifX49RoaxF28/p4c3
         3MPzisEdzqQcDpwFKdn1vn0WbPQoyeWfa56aT8dso6OaTuDQ3wnHvEk04IKND9fyVPLy
         Q6J9Et8+kF3WOl+6mfaK7yqU8cRBEec7+/1TvJLaC+JdzO19/KWv8b2nUAnoD8s5OhEH
         /FYgtuMbVw+pao3NUpX0jp4lf0kWuC3tKBRndIYTnNOznEgDVQg2LLCkUfoNy87pvt5c
         k3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ycp1fOFRcqnvrXtuAswlNcdj2NkXI8qjDu7ztULp4g=;
        b=uzMz5R1nYftb+3SoVjKy5rfxqnYT7LS0jiNJkLhCaz5MhM2nG+6TZ98VbYpJSE9mFf
         6VZS6H+mhFf4xpmkfBAnW1v6T6FNaVZ6/nO77ccmq0a3CMdtaogRuFUNJhhyt2J8KsfG
         WPbHfpZeRnGjnUBJVO+qbpeuVMY/Ark3wY62QqjdOAIsQCOA4YQq8aqUD82eSyCz+J4t
         H0BxXiR9tmTEKnn7EI/B7mxZ8OuL8e8pHbxJMyjZlPnFbUjGjFDgxbBYCPWMQcMQmkdD
         EfMjNwkBi8QDnl0AEZZ9RZibd+L1DXOis22ZwfWwG4oChqLM/fisSD+Q7cNnVvPgAjnU
         SaXw==
X-Gm-Message-State: AO0yUKUzBVXl38/t55miX8DgNx4Uv3qwoA+o8d7ym0BKOvVjOCDhO98E
        C39iTETX8TVHCydoEMvRthgCeA==
X-Google-Smtp-Source: AK7set93WXjwZmiOBSQIZMB+0eDjPtJOLkR/LAOqDz4vWAPBj9BCaVrg7CvYpdXzX2eFJC+J4/9b9A==
X-Received: by 2002:a19:760e:0:b0:4df:2c71:57fb with SMTP id c14-20020a19760e000000b004df2c7157fbmr4088445lff.43.1678194302348;
        Tue, 07 Mar 2023 05:05:02 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:05:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:58 +0100
Subject: [PATCH v2 16/16] gpio: pcie-idio-24: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-16-d6b0e3f2d991@linaro.org>
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
 drivers/gpio/gpio-pcie-idio-24.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 8a9b98fa418f..ac42150f4009 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -396,6 +396,8 @@ static void idio_24_irq_mask(struct irq_data *data)
 	}
 
 	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void idio_24_irq_unmask(struct irq_data *data)
@@ -408,6 +410,8 @@ static void idio_24_irq_unmask(struct irq_data *data)
 	const unsigned long bank_offset = bit_offset / 8;
 	unsigned char cos_enable_state;
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
+
 	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
 	prev_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
@@ -437,12 +441,14 @@ static int idio_24_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idio_24_irqchip = {
+static const struct irq_chip idio_24_irqchip = {
 	.name = "pcie-idio-24",
 	.irq_ack = idio_24_irq_ack,
 	.irq_mask = idio_24_irq_mask,
 	.irq_unmask = idio_24_irq_unmask,
-	.irq_set_type = idio_24_irq_set_type
+	.irq_set_type = idio_24_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
@@ -535,7 +541,7 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio24gpio->chip.set_multiple = idio_24_gpio_set_multiple;
 
 	girq = &idio24gpio->chip.irq;
-	girq->chip = &idio_24_irqchip;
+	gpio_irq_chip_set_chip(girq, &idio_24_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;

-- 
2.34.1

