Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43056588CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiL2DAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiL2DAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:00:19 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D512088;
        Wed, 28 Dec 2022 19:00:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYJZ1mx_1672282814;
Received: from 30.236.46.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VYJZ1mx_1672282814)
          by smtp.aliyun-inc.com;
          Thu, 29 Dec 2022 11:00:15 +0800
Message-ID: <f4b97e4c-008b-d55c-26a0-5fb3d58fb30d@linux.alibaba.com>
Date:   Thu, 29 Dec 2022 11:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 3/3] gpio: gpio-sprd: Make the irqchip immutable
To:     Cixi Geng <cixi.geng@linux.dev>, linus.walleij@linaro.org,
        brgl@bgdev.pl, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
References: <20221228122442.392504-1-cixi.geng@linux.dev>
 <20221228122442.392504-4-cixi.geng@linux.dev>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221228122442.392504-4-cixi.geng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2022 8:24 PM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
> new helper functions, and call the appropriate gpiolib functions.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/gpio/gpio-sprd.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index 9bff63990eee..072b4e653216 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -120,6 +120,7 @@ static void sprd_gpio_irq_mask(struct irq_data *data)
>   	u32 offset = irqd_to_hwirq(data);
>   
>   	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 0);
> +	gpiochip_disable_irq(chip, offset);
>   }
>   
>   static void sprd_gpio_irq_ack(struct irq_data *data)
> @@ -136,6 +137,7 @@ static void sprd_gpio_irq_unmask(struct irq_data *data)
>   	u32 offset = irqd_to_hwirq(data);
>   
>   	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 1);
> +	gpiochip_enable_irq(chip, offset); >   }
>   
>   static int sprd_gpio_irq_set_type(struct irq_data *data,
> @@ -205,13 +207,14 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
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
> -	.flags = IRQCHIP_SKIP_SET_WAKE,
> +	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>   };
>   
>   static int sprd_gpio_probe(struct platform_device *pdev)
> @@ -245,7 +248,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>   	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
>   
>   	irq = &sprd_gpio->chip.irq;
> -	irq->chip = &sprd_gpio_irqchip;
> +	gpio_irq_chip_set_chip(irq, &sprd_gpio_irqchip);
>   	irq->handler = handle_bad_irq;
>   	irq->default_type = IRQ_TYPE_NONE;
>   	irq->parent_handler = sprd_gpio_irq_handler;
