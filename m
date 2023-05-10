Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E66FD867
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEJHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjEJHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:42:27 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EEF26A2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:42:25 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 321ea111-ef06-11ed-b3cf-005056bd6ce9;
        Wed, 10 May 2023 10:42:21 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 10 May 2023 10:42:20 +0300
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, mkshah@codeaurora.org,
        Ben Brown <ben.brown@alliedtelesis.co.nz>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Don't implicitly disable irq when masking
Message-ID: <ZFtK3DydE24Qijle@surfacebook>
References: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 10, 2023 at 12:11:51PM +1200, Chris Packham kirjoitti:
> When preparing to kexec into a new kernel the kexec code will mask all
> interrupts for all interrupt domains before disabling them. In the case
> of a gpio chip which has a mix of gpio and irq pins a warning would be
> triggered as follows

>   [root@localhost ~]# echo c >/proc/sysrq-trigger

Besides the very noisy traceback in the commit message (read
https://kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages)
see below.

> This is because gpiochip_irq_mask was being used to mask all possible

We refer to the functions in the form as follows gpiochip_irq_mask().


> irqs in the domain but gpiochip_disable_irq will WARN if any of those

IRQs
gpiochip_disable_irq()

> gpios haven't been requested as interrupts yet. Remove the call to

GPIOs

> gpiochip_disable_irq to stop the warning.

gpiochip_disable_irq()

> Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/gpio/gpiolib.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 8c041a8dd9d8..903f5185ae55 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1451,7 +1451,6 @@ static void gpiochip_irq_mask(struct irq_data *d)
>  
>  	if (gc->irq.irq_mask)
>  		gc->irq.irq_mask(d);
> -	gpiochip_disable_irq(gc, d->hwirq);
>  }

At the same time the gpiochip_irq_unmask() has the symmetrical call. Why?

Also it's obvious that you have used outdated repository. You need to rebase
against subsystem tree for-next branch.

P.S. It's also makes sense to Cc to Marc Zyngier <maz@kernel.org>.

-- 
With Best Regards,
Andy Shevchenko


