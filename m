Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04E06B1CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCIHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCIHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7FDD5B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id t11so1175937lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PUEBNIWi9XlpGpt5vSwoRNt6H80aDlupNA++Rohdv4=;
        b=nybRzTeW6RIm/2SrjGOF5FaP6SKi0d2JiXT906zjXJAVNYdYnXLgomwmFQ3almrEfr
         6y+Wk8XrQG9P9BA0tGoydQmWGqeWAPlnB7UABZ/ZBKAlmBp7avsgDU1hBnali3npmo0X
         3v1LYSh5mo+nsjTpHlMe3NQJoPm1k9seTsqo4Il5j5WFvoWRD/8AS88vDfTiL9hs/BRy
         aJ61t8qKUw6AvsY1GuSYuuz8DoPXutrHWXZvxrGAccfwUoMuO6zZHCExNPAlkNCkQlPL
         WGKfjoe9SFAE7uf/T2V2R2uabcIqtgPSeniJji05bixYq5dYPjT1/yO3BPqumDQTPsbe
         42XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PUEBNIWi9XlpGpt5vSwoRNt6H80aDlupNA++Rohdv4=;
        b=bUfGO8pLbKmvPGFjg3ff4wOcFwf9QD5yNPaJCXzPTU8OdQ6cXXXrWA1fjv3GPFmeQ/
         8zeKrZbZIDwyMJHyF4Wk+ceozFllzKCZUR0wWzoreBPEYcKUjIB1GCmmiyhCCQGJ2Tz5
         7DmjDzLPoRdj27HcxytJgPgilJXSmtShzTFYglCohgm09J1p7GGG+XPDdOS4X53OVHpg
         6nnjytf2SWhoQh2dkmRoGVKbJ8Mn5JvugdHi81oJSyz9iz3a+zb3D6Et51+J5cxydV8t
         baZQFySfD3kOGHY0Ko8Mg8J3SV6bGFZ53A9p6i+gEbf/uIul2k67zXEOhb17rZLAZvRp
         N66A==
X-Gm-Message-State: AO0yUKUBm1g+nRgjIj4GRAZ0NbKE2wXwHlZDWe30eomaDz/4tcWHEwsL
        sYnpzkYEtL03ijsdD7KpbQv8Lg==
X-Google-Smtp-Source: AK7set9Rf6KwMUejQHH6eNoYok3Zam8mTGRtBlpbIPx+hAHzI1oz/B6ewh7RXNguuScReStV6zHWSQ==
X-Received: by 2002:a19:7406:0:b0:4d8:5e8e:b138 with SMTP id v6-20020a197406000000b004d85e8eb138mr5587064lfe.14.1678347961936;
        Wed, 08 Mar 2023 23:46:01 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:54 +0100
Subject: [PATCH v3 06/17] gpio: ath79: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-6-972542092a77@linaro.org>
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
 drivers/gpio/gpio-ath79.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 3958c6d97639..aa0a954b8392 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -71,6 +71,7 @@ static void ath79_gpio_irq_unmask(struct irq_data *data)
 	u32 mask = BIT(irqd_to_hwirq(data));
 	unsigned long flags;
 
+	gpiochip_enable_irq(&ctrl->gc, irqd_to_hwirq(data));
 	raw_spin_lock_irqsave(&ctrl->lock, flags);
 	ath79_gpio_update_bits(ctrl, AR71XX_GPIO_REG_INT_MASK, mask, mask);
 	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
@@ -85,6 +86,7 @@ static void ath79_gpio_irq_mask(struct irq_data *data)
 	raw_spin_lock_irqsave(&ctrl->lock, flags);
 	ath79_gpio_update_bits(ctrl, AR71XX_GPIO_REG_INT_MASK, mask, 0);
 	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
+	gpiochip_disable_irq(&ctrl->gc, irqd_to_hwirq(data));
 }
 
 static void ath79_gpio_irq_enable(struct irq_data *data)
@@ -169,13 +171,15 @@ static int ath79_gpio_irq_set_type(struct irq_data *data,
 	return 0;
 }
 
-static struct irq_chip ath79_gpio_irqchip = {
+static const struct irq_chip ath79_gpio_irqchip = {
 	.name = "gpio-ath79",
 	.irq_enable = ath79_gpio_irq_enable,
 	.irq_disable = ath79_gpio_irq_disable,
 	.irq_mask = ath79_gpio_irq_mask,
 	.irq_unmask = ath79_gpio_irq_unmask,
 	.irq_set_type = ath79_gpio_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void ath79_gpio_irq_handler(struct irq_desc *desc)
@@ -274,7 +278,7 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 	/* Optional interrupt setup */
 	if (!np || of_property_read_bool(np, "interrupt-controller")) {
 		girq = &ctrl->gc.irq;
-		girq->chip = &ath79_gpio_irqchip;
+		gpio_irq_chip_set_chip(girq, &ath79_gpio_irqchip);
 		girq->parent_handler = ath79_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),

-- 
2.34.1

