Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215216588BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiL2CwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2CwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:52:19 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B20BB9;
        Wed, 28 Dec 2022 18:52:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYJZ.O-_1672282334;
Received: from 30.236.46.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VYJZ.O-_1672282334)
          by smtp.aliyun-inc.com;
          Thu, 29 Dec 2022 10:52:15 +0800
Message-ID: <c8c5472f-68ca-0b53-e8ba-56f296fb2624@linux.alibaba.com>
Date:   Thu, 29 Dec 2022 10:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 1/3] gpio: eic-sprd: Make the irqchip immutable
To:     Cixi Geng <cixi.geng@linux.dev>, linus.walleij@linaro.org,
        brgl@bgdev.pl, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
References: <20221228122442.392504-1-cixi.geng@linux.dev>
 <20221228122442.392504-2-cixi.geng@linux.dev>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221228122442.392504-2-cixi.geng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2022 8:24 PM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Remove the irq_chip from pmic_eic structure,
> use the various calls by defining the statically
> irq_chip structure.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 8d722e026e9c..86563c0604e8 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -91,7 +91,6 @@ enum sprd_eic_type {
>   
>   struct sprd_eic {
>   	struct gpio_chip chip;
> -	struct irq_chip intc;
>   	void __iomem *base[SPRD_EIC_MAX_BANK];
>   	enum sprd_eic_type type;
>   	spinlock_t lock;
> @@ -255,6 +254,8 @@ static void sprd_eic_irq_mask(struct irq_data *data)
>   	default:
>   		dev_err(chip->parent, "Unsupported EIC type.\n");
>   	}
> +
> +	gpiochip_disable_irq(chip, offset);
>   }
>   
>   static void sprd_eic_irq_unmask(struct irq_data *data)
> @@ -263,6 +264,8 @@ static void sprd_eic_irq_unmask(struct irq_data *data)
>   	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
>   	u32 offset = irqd_to_hwirq(data);
>   
> +	gpiochip_enable_irq(chip, offset);
> +
>   	switch (sprd_eic->type) {
>   	case SPRD_EIC_DEBOUNCE:
>   		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 1);
> @@ -564,6 +567,15 @@ static void sprd_eic_irq_handler(struct irq_desc *desc)
>   	chained_irq_exit(ic, desc);
>   }
>   
> +static const struct irq_chip sprd_eic_irq = {
> +	.name		= "sprd-eic-gpio",

Should be "sprd-eic". Otherwise looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> +	.irq_ack	= sprd_eic_irq_ack,
> +	.irq_mask	= sprd_eic_irq_mask,
> +	.irq_unmask	= sprd_eic_irq_unmask,
> +	.irq_set_type	= sprd_eic_irq_set_type,
> +	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
>   static int sprd_eic_probe(struct platform_device *pdev)
>   {
>   	const struct sprd_eic_variant_data *pdata;
> @@ -626,15 +638,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   		break;
>   	}
>   
> -	sprd_eic->intc.name = dev_name(&pdev->dev);
> -	sprd_eic->intc.irq_ack = sprd_eic_irq_ack;
> -	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
> -	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
> -	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
> -	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
> -
>   	irq = &sprd_eic->chip.irq;
> -	irq->chip = &sprd_eic->intc;
> +	gpio_irq_chip_set_chip(irq, &sprd_eic_irq);
>   	irq->handler = handle_bad_irq;
>   	irq->default_type = IRQ_TYPE_NONE;
>   	irq->parent_handler = sprd_eic_irq_handler;
