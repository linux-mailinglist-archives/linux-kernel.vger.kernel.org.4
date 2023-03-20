Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8E6C0F07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCTKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCTKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F59D7A90;
        Mon, 20 Mar 2023 03:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3CAB61333;
        Mon, 20 Mar 2023 10:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348B5C433EF;
        Mon, 20 Mar 2023 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679308504;
        bh=M/wWyAoTmx9mB/cTEjucMK8opbUBCDiaoVYvdKCtM00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ug4MGKB5x6BjiRYYC4VzrvoxvY/oDRwFjN2VLdzI5TBwlSfpiMayNt3lfjtPibAHu
         St7oiHUW9MjFsGWKPzLGvkvvUZqr8LOyeFgbzc19GlegmF6RIPsYIgGp3bTH5Q8xbI
         n7QyKIU3IjeRQwkowbrl/zEVnMX59V2xCugTCcAfq5tKdRQBJjp7lWTJET6pIfxMzH
         De+CtrWrTv4duxBvCTvGLvc2V1yU0OKYCkVIuUYnQkuAxg1YiezlnRyCdqXOo3KJWx
         C9ffVaU5Fppad0dttD16qvp+PBUE7PpEdPBO9Xp6YD6Bux3Yej/BZmKW9RY8T6CaBL
         AWpIEJI+3iQUQ==
Date:   Mon, 20 Mar 2023 16:04:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/9] gpio: rda: Convert to immutable irq_chip
Message-ID: <20230320103452.GD4564@thinkpad>
References: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
 <20230316-immutable-chips-2-v1-1-053d6ede831b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230316-immutable-chips-2-v1-1-053d6ede831b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:55:08AM +0100, Linus Walleij wrote:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/gpio/gpio-rda.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
> index 62ba18b3a602..dd568907d389 100644
> --- a/drivers/gpio/gpio-rda.c
> +++ b/drivers/gpio/gpio-rda.c
> @@ -38,7 +38,6 @@ struct rda_gpio {
>  	struct gpio_chip chip;
>  	void __iomem *base;
>  	spinlock_t lock;
> -	struct irq_chip irq_chip;
>  	int irq;
>  };
>  
> @@ -74,6 +73,7 @@ static void rda_gpio_irq_mask(struct irq_data *data)
>  	value |= BIT(offset) << RDA_GPIO_IRQ_FALL_SHIFT;
>  
>  	writel_relaxed(value, base + RDA_GPIO_INT_CTRL_CLR);
> +	gpiochip_disable_irq(chip, offset);
>  }
>  
>  static void rda_gpio_irq_ack(struct irq_data *data)
> @@ -154,6 +154,7 @@ static void rda_gpio_irq_unmask(struct irq_data *data)
>  	u32 offset = irqd_to_hwirq(data);
>  	u32 trigger = irqd_get_trigger_type(data);
>  
> +	gpiochip_enable_irq(chip, offset);
>  	rda_gpio_set_irq(chip, offset, trigger);
>  }
>  
> @@ -195,6 +196,16 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(ic, desc);
>  }
>  
> +static const struct irq_chip rda_gpio_irq_chip = {
> +	.name = "rda-gpio",
> +	.irq_ack = rda_gpio_irq_ack,
> +	.irq_mask = rda_gpio_irq_mask,
> +	.irq_unmask = rda_gpio_irq_unmask,
> +	.irq_set_type = rda_gpio_irq_set_type,
> +	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  static int rda_gpio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -241,15 +252,8 @@ static int rda_gpio_probe(struct platform_device *pdev)
>  	rda_gpio->chip.base = -1;
>  
>  	if (rda_gpio->irq >= 0) {
> -		rda_gpio->irq_chip.name = "rda-gpio",
> -		rda_gpio->irq_chip.irq_ack = rda_gpio_irq_ack,
> -		rda_gpio->irq_chip.irq_mask = rda_gpio_irq_mask,
> -		rda_gpio->irq_chip.irq_unmask = rda_gpio_irq_unmask,
> -		rda_gpio->irq_chip.irq_set_type = rda_gpio_irq_set_type,
> -		rda_gpio->irq_chip.flags = IRQCHIP_SKIP_SET_WAKE,
> -
>  		girq = &rda_gpio->chip.irq;
> -		girq->chip = &rda_gpio->irq_chip;
> +		gpio_irq_chip_set_chip(girq, &rda_gpio_irq_chip);
>  		girq->handler = handle_bad_irq;
>  		girq->default_type = IRQ_TYPE_NONE;
>  		girq->parent_handler = rda_gpio_irq_handler;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
