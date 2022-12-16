Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0564E76A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLPGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:50:28 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD155AB9;
        Thu, 15 Dec 2022 22:50:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VXPi44Y_1671173422;
Received: from 30.97.48.49(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VXPi44Y_1671173422)
          by smtp.aliyun-inc.com;
          Fri, 16 Dec 2022 14:50:23 +0800
Message-ID: <97e244d4-6b5c-31c9-7329-b8deef615645@linux.alibaba.com>
Date:   Fri, 16 Dec 2022 14:50:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] gpio: sprd: Make irq_chip immutable
To:     Cixi Geng <cixi.geng@linux.dev>, linus.walleij@linaro.org,
        brgl@bgdev.pl, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        gengcixi@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216041708.32768-1-cixi.geng@linux.dev>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221216041708.32768-1-cixi.geng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2022 12:17 PM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Kernel warns about mutable irq_chips:
> 
>      "not an immutable chip, please consider fixing!"
> 
> Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
> new helper functions, and call the appropriate gpiolib functions.

Please split them into 3 patches and each patch converts one driver, 
which is easy to review.

> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c      |  4 ++--
>   drivers/gpio/gpio-pmic-eic-sprd.c |  4 ++--
>   drivers/gpio/gpio-sprd.c          | 11 +++++++++--
>   3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 8d722e026e9c..07b9099f2a6d 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -631,10 +631,10 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
>   	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
>   	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
> -	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
> +	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;
>   
>   	irq = &sprd_eic->chip.irq;
> -	irq->chip = &sprd_eic->intc;
> +	gpio_irq_chip_set_chip(irq, &sprd_eic->intc);
>   	irq->handler = handle_bad_irq;
>   	irq->default_type = IRQ_TYPE_NONE;
>   	irq->parent_handler = sprd_eic_irq_handler;
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> index e518490c4b68..d96604ea10e7 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -344,10 +344,10 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
>   	pmic_eic->intc.irq_set_type = sprd_pmic_eic_irq_set_type;
>   	pmic_eic->intc.irq_bus_lock = sprd_pmic_eic_bus_lock;
>   	pmic_eic->intc.irq_bus_sync_unlock = sprd_pmic_eic_bus_sync_unlock;
> -	pmic_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
> +	pmic_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;

Why not add GPIOCHIP_IRQ_RESOURCE_HELPERS for above 2 drivers? Seems we 
can remove the irq_chip from pmic_eic structure, instead we can define 
it statically with adding GPIOCHIP_IRQ_RESOURCE_HELPERS like other patch 
[1] did?

[1] https://lore.kernel.org/all/20220419141846.598305-6-maz@kernel.org/

>   
>   	irq = &pmic_eic->chip.irq;
> -	irq->chip = &pmic_eic->intc;
> +	gpio_irq_chip_set_chip(irq, &pmic_eic->intc);
>   	irq->threaded = true;
>   
>   	ret = devm_gpiochip_add_data(&pdev->dev, &pmic_eic->chip, pmic_eic);
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index 9bff63990eee..8398f9707ec0 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -64,6 +64,11 @@ static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
>   
>   	writel_relaxed(tmp, base + reg);
>   	spin_unlock_irqrestore(&sprd_gpio->lock, flags);
> +
> +	if (reg == SPRD_GPIO_IE && val == 1)
> +		gpiochip_enable_irq(chip, offset);
> +	else if (reg == SPRD_GPIO_IE && val == 0)
> +		gpiochip_disable_irq(chip, offset);

Looks incorrect to me, IIUC you should move 
gpiochip_enable_irq/gpiochip_disable_irq() into sprd_gpio_irq_mask() and 
sprd_gpio_irq_unmask().

>   }
>   
>   static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset, u16 reg)
> @@ -205,13 +210,15 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
>   	chained_irq_exit(ic, desc);
>   }
>   
> -static struct irq_chip sprd_gpio_irqchip = {
> +static const struct irq_chip sprd_gpio_irqchip = {
>   	.name = "sprd-gpio",
>   	.irq_ack = sprd_gpio_irq_ack,
>   	.irq_mask = sprd_gpio_irq_mask,
>   	.irq_unmask = sprd_gpio_irq_unmask,
>   	.irq_set_type = sprd_gpio_irq_set_type,
>   	.flags = IRQCHIP_SKIP_SET_WAKE,
> +	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>   };
>   
>   static int sprd_gpio_probe(struct platform_device *pdev)
> @@ -245,7 +252,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>   	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
>   
>   	irq = &sprd_gpio->chip.irq;
> -	irq->chip = &sprd_gpio_irqchip;
> +	gpio_irq_chip_set_chip(irq, &sprd_gpio_irqchip);
>   	irq->handler = handle_bad_irq;
>   	irq->default_type = IRQ_TYPE_NONE;
>   	irq->parent_handler = sprd_gpio_irq_handler;
