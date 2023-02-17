Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDB69AE20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBQOeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:34:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C3F6644FB;
        Fri, 17 Feb 2023 06:34:11 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pT1o3-0001zG-00; Fri, 17 Feb 2023 15:33:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 19465C28A2; Fri, 17 Feb 2023 14:28:16 +0100 (CET)
Date:   Fri, 17 Feb 2023 14:28:16 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
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
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 10/17] gpio: idt3243x: Convert to immutable irq_chip
Message-ID: <20230217132816.GA9335@alpha.franken.de>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-10-51a8f224a5d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215-immutable-chips-v1-10-51a8f224a5d0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:37:11AM +0100, Linus Walleij wrote:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-idt3243x.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
> index 1cafdf46f875..00f547d26254 100644
> --- a/drivers/gpio/gpio-idt3243x.c
> +++ b/drivers/gpio/gpio-idt3243x.c
> @@ -92,6 +92,8 @@ static void idt_gpio_mask(struct irq_data *d)
>  	writel(ctrl->mask_cache, ctrl->pic + IDT_PIC_IRQ_MASK);
>  
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +
> +	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
>  }
>  
>  static void idt_gpio_unmask(struct irq_data *d)
> @@ -100,6 +102,7 @@ static void idt_gpio_unmask(struct irq_data *d)
>  	struct idt_gpio_ctrl *ctrl = gpiochip_get_data(gc);
>  	unsigned long flags;
>  
> +	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  
>  	ctrl->mask_cache &= ~BIT(d->hwirq);
> @@ -119,12 +122,14 @@ static int idt_gpio_irq_init_hw(struct gpio_chip *gc)
>  	return 0;
>  }
>  
> -static struct irq_chip idt_gpio_irqchip = {
> +static const struct irq_chip idt_gpio_irqchip = {
>  	.name = "IDTGPIO",
>  	.irq_mask = idt_gpio_mask,
>  	.irq_ack = idt_gpio_ack,
>  	.irq_unmask = idt_gpio_unmask,
> -	.irq_set_type = idt_gpio_irq_set_type
> +	.irq_set_type = idt_gpio_irq_set_type,
> +	.flags = IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>  
>  static int idt_gpio_probe(struct platform_device *pdev)
> @@ -168,7 +173,7 @@ static int idt_gpio_probe(struct platform_device *pdev)
>  			return parent_irq;
>  
>  		girq = &ctrl->gc.irq;
> -		girq->chip = &idt_gpio_irqchip;
> +		gpio_irq_chip_set_chip(girq, &idt_gpio_irqchip);
>  		girq->init_hw = idt_gpio_irq_init_hw;
>  		girq->parent_handler = idt_gpio_dispatch;
>  		girq->num_parents = 1;
> 
> -- 
> 2.34.1

Tested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
