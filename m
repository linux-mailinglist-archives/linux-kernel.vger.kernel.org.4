Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FB69902A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBPJif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBPJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BD518E5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j17so2051542lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HayiibrRJAE6+zZp+nCHddL7slKdhuxnPg1rl6oYz5s=;
        b=qKMWDE0s9gCjjzGUaa5+s3tvuBsUkE0qi/wuilD+whMwslm0svnZJI11oI/ANtCxyr
         tSezoe6cs/9PgRpGaEWw5TJvkt45RTEGNEPpeFcPvOqah64RIlnu6RsN5xtcWBQr7LsJ
         ETwh4QmDtDbJsqq+XjvUwu+/vMfzuLqNffr2Na9YHlJYZRg8NTKW+fINpDylckBgZncY
         umEZRSCcHJALCB06rFriNrL6zi8U6X2EzPf+Tvoyi/6V9ZgADxxaAYL9t6f6rBU/YemE
         XaN7iI5wHh8DmB9z6z9umaK8nn6hTUeR5bpcIGHk2zE1GMESh73345f8DvJmiAMHdUeF
         ZI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HayiibrRJAE6+zZp+nCHddL7slKdhuxnPg1rl6oYz5s=;
        b=lzoudUKWXosrPdJxtVdw5IdHvJ4ky6tU+OiYQb+/SinScclCMtfQHLhJgTOUlFg51c
         AM2Fdzk234Wsklnajp+OUCw9AiZTlFbOo//ndCDm1xaqhAAeqX7TZfimzNNtfZaOyRTR
         x6/hPO6XlvZoOw6mX8Qk0I7rDEit4ODiDEEym4jvOJ4Oz+IAxmQ/pY+GP1sb2rN6Vbui
         6whsqnZDuttdtebhZgqwW7pATv2uL79RI+TtC80hIiNxbVCpjiVUxTxvWCbw3oFxOXiS
         ReccTPYwx9NvGJqXws1Nijh4Jl+xcLGm2jeOTf5ovisMEbFb9cT0LdO5oMqWqnIJphim
         HBTw==
X-Gm-Message-State: AO0yUKUuFw1pF/gZxP7vCynRWhJ8FmRF5LDwaH2GUhTyqSZp/fZyot6x
        iKnKAsCWrgA3MLiPT6u7t1xt3Q==
X-Google-Smtp-Source: AK7set9mJ54fVQopM5T/C3b/5InJm9ineYC8yOOFm5D6dwmMqRFJZHeuUywp8DfZxXwnhCAoox4kEg==
X-Received: by 2002:ac2:53aa:0:b0:4a4:68b7:d621 with SMTP id j10-20020ac253aa000000b004a468b7d621mr1410066lfh.8.1676540245705;
        Thu, 16 Feb 2023 01:37:25 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:17 +0100
Subject: [PATCH 16/17] gpio: pci-idio-16: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-16-51a8f224a5d0@linaro.org>
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

Cc: Marc Zyngier <maz@kernel.org>
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

