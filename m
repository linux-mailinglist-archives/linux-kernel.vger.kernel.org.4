Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E816A35FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjB0Aof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjB0Aoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:44:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9571EB6E;
        Sun, 26 Feb 2023 16:44:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so19347129edz.6;
        Sun, 26 Feb 2023 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KpmrTnzuyhRKv0JCadD+iEKjwnk+xgAUYhsA4Gj5pCk=;
        b=lEUzkWrptP2BxOmhswDXzWsZ0ehiM8/64HoGXTZcqkHkv2YWI8+nuRbT65vlupUzMS
         7w8MqMI2U+FruxAzue0e3DtDrNV4LzB9aOC0VZgB8T1qAeEIE9/kPejWRM30AvpjhzUW
         N27uX3f5pU49IXsrgSb5GYiqetcZIVkPGMv/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpmrTnzuyhRKv0JCadD+iEKjwnk+xgAUYhsA4Gj5pCk=;
        b=LaxrxhymbacXpu4xs2zAx0UhoQ+Cn0BV8Nt585MO4XgBlEHRSAaed93fluJaAeKn6q
         YyK0I0QSdzuNi+r8AldYiigaw8i+dapt11CCS4JhvDsiR09oLLE4Kg+g2OkTsOB9xMj7
         hD/F2XqsQXkVcEg6Zr1zwioRVpVDIrtvnui55HwryyiQmgP7/NVXeBkztT5AihMCUbtz
         fgc7yktov6CmqU48jNmqDMdfJGBTrTI4CJ0jzlUmczFgA06mEwN50cMN2hJc4g3eQLNc
         U4Zcu6Pge81P/7WCB2+8Qzewr0aUTlmuvjFdp/Y3pi9TqhWRyiQJBVl1aY0BwrOhPEKX
         HICw==
X-Gm-Message-State: AO0yUKVhjQqduVKEijtd9C/IT4QStAtix1jlZ+yYoZw0s16xLHFwDeLl
        ou3yPDJ2MGOq6f/w05H4fM768pwOafQvFzO19PU=
X-Google-Smtp-Source: AK7set8rl0f6TKFK0MCg8M27+KjTjlNg2cWCQUqa5PUZCFS0jw2dMu+Oq+N5ni/aMuL+aXTb9+25i414NSsNLCwp4u0=
X-Received: by 2002:a50:9f28:0:b0:4ad:7ba3:5bce with SMTP id
 b37-20020a509f28000000b004ad7ba35bcemr10771163edf.7.1677458670886; Sun, 26
 Feb 2023 16:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org> <20230215-immutable-chips-v1-3-51a8f224a5d0@linaro.org>
In-Reply-To: <20230215-immutable-chips-v1-3-51a8f224a5d0@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 27 Feb 2023 00:44:18 +0000
Message-ID: <CACPK8XeqDeXvF9RJ5ppSdjFAGHWDbojCr01Q5W=k=mkFgwQgPg@mail.gmail.com>
Subject: Re: [PATCH 03/17] gpio: aspeed: Convert to immutable irq_chip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 09:37, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Joel Stanley <joel@jms.id.au>

I attempted the conversion but wasn't sure how to proceed because we
dynamically create the irqchip depending on the presence of the
interrupt in the device tree. However, every device tree contains this
interrupt so perhaps we should clean that up.

Cheers,

Joel

> ---
>  drivers/gpio/gpio-aspeed.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index a94da80d3a95..9c4852de2733 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>
> @@ -53,7 +54,7 @@ struct aspeed_gpio_config {
>   */
>  struct aspeed_gpio {
>         struct gpio_chip chip;
> -       struct irq_chip irqc;
> +       struct device *dev;
>         raw_spinlock_t lock;
>         void __iomem *base;
>         int irq;
> @@ -566,6 +567,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
>
>         addr = bank_reg(gpio, bank, reg_irq_enable);
>
> +       /* Unmasking the IRQ */
> +       if (set)
> +               gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
> +
>         raw_spin_lock_irqsave(&gpio->lock, flags);
>         copro = aspeed_gpio_copro_request(gpio, offset);
>
> @@ -579,6 +584,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
>         if (copro)
>                 aspeed_gpio_copro_release(gpio, offset);
>         raw_spin_unlock_irqrestore(&gpio->lock, flags);
> +
> +       /* Masking the IRQ */
> +       if (!set)
> +               gpiochip_disable_irq(&gpio->chip, irqd_to_hwirq(d));
>  }
>
>  static void aspeed_gpio_irq_mask(struct irq_data *d)
> @@ -1080,6 +1089,30 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);
>
> +static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
> +{
> +       const struct aspeed_gpio_bank *bank;
> +       struct aspeed_gpio *gpio;
> +       u32 bit;
> +       int rc, offset;
> +
> +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
> +       if (rc)
> +               return;
> +
> +       seq_printf(p, dev_name(gpio->dev));
> +}
> +
> +static const struct irq_chip aspeed_gpio_irq_chip = {
> +       .irq_ack = aspeed_gpio_irq_ack,
> +       .irq_mask = aspeed_gpio_irq_mask,
> +       .irq_unmask = aspeed_gpio_irq_unmask,
> +       .irq_set_type = aspeed_gpio_set_type,
> +       .irq_print_chip = aspeed_gpio_irq_print_chip,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  /*
>   * Any banks not specified in a struct aspeed_bank_props array are assumed to
>   * have the properties:
> @@ -1149,6 +1182,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>         if (IS_ERR(gpio->base))
>                 return PTR_ERR(gpio->base);
>
> +       gpio->dev = &pdev->dev;
> +
>         raw_spin_lock_init(&gpio->lock);
>
>         gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
> @@ -1208,12 +1243,9 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>
>                 gpio->irq = rc;
>                 girq = &gpio->chip.irq;
> -               girq->chip = &gpio->irqc;
> +               gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
>                 girq->chip->name = dev_name(&pdev->dev);
> -               girq->chip->irq_ack = aspeed_gpio_irq_ack;
> -               girq->chip->irq_mask = aspeed_gpio_irq_mask;
> -               girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
> -               girq->chip->irq_set_type = aspeed_gpio_set_type;
> +
>                 girq->parent_handler = aspeed_gpio_irq_handler;
>                 girq->num_parents = 1;
>                 girq->parents = devm_kcalloc(&pdev->dev, 1,
>
> --
> 2.34.1
>
