Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0133367B2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjAYMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:45:15 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549F12064
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:45:14 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y19so20193046ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+me64axwvDqb7B12zwUNh5XD3eQ8C/hEK64GWEC77Lc=;
        b=w2Z8tMT3RCLczntu9mAnYJ6xWxaivZDCN8Y+umUhDZwrKVZ93JXeIUiigYbCflW1W6
         XY3VmJjeWoo1yifNlcn5OenpElU3xdJO7NRRrQ/TsN/0JONlKDXRbQuv9p2KZcVviwe/
         CNKjVUmrDMMDlhP6u9BwP7+GzNrzDcdoZgNfFI1LSbfLn0RhH4mjVgqJIZzyQtnE8sTy
         0HQNAkCst8ChKhzly5074JMvkzYIsLjZDF9bvJ+ukwDksev8Plc/5GFHnkRXJiN3mvpj
         FL0Cl4HpC9g21DqBV+A04eWijlZ2LcWdvj6uZEmo309eaak3CoDhEGb5NXfwI9pRaLtj
         /nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+me64axwvDqb7B12zwUNh5XD3eQ8C/hEK64GWEC77Lc=;
        b=nFlqhCCtmgh1410SmUQ/G1ViJ35C9+uUst1moMiH1+NJyuufW6q0jGx6Og6rN1zB4A
         2Jw0ksO8EBh7XkmCkNPas+CaKkKzzI04iJmy5GrXNJ7Lp3W/As2//Da1Ycu5Eth3oBsn
         zumDjHfdLdM3MSkYooSu4k6sP+gHVd2c6b5/xvuLc8ZhvKys2dRLyxGSVQg+ZbxeZPMr
         ah6RMTwcxZIS7spTcMpFN9A7ltqXGhJA82Jkj14ZPOp+iUBHqqA0cYQNZwf26tIc9OBp
         FvA8A0+Xv6VPBYOoQeFVRd8sRl2eM9mxIs3YtQSXEFmQPKIoSUi5FmMiJSFTVllfsZFk
         4zGw==
X-Gm-Message-State: AFqh2krJinYqRUarXzJpAO3KHwdVJDR/Iy+LaRxFGFrEmVzYHEYx5WTr
        gIM0jdn3+K0rcPEw2calDZWMtcXywZcNxUCAU4+cdg==
X-Google-Smtp-Source: AMrXdXsj+EmM846GRFfVzMFebETbdJcj3JaNFDqk/iENU4af0huMhLJOavcFgRfOFGf1qsrrLMTKVCuaWGsIUE1nvBE=
X-Received: by 2002:a2e:7204:0:b0:28a:13a7:a2e7 with SMTP id
 n4-20020a2e7204000000b0028a13a7a2e7mr2015909ljc.520.1674650712346; Wed, 25
 Jan 2023 04:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
 <20230125083026.5399-1-nikita.shubin@maquefel.me> <20230125083026.5399-3-nikita.shubin@maquefel.me>
In-Reply-To: <20230125083026.5399-3-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 25 Jan 2023 13:45:00 +0100
Message-ID: <CAMRc=Mf1p0-7T6Wc85u_NGpO7e8fLW=MJX44OjTazAPxXCeoxA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: ep93xx: Make irqchip immutable
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-gpio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:30 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> This turns the Cirrus ep93xx gpio irqchip immutable.
>
> Preserve per-chip labels by adding an ->irq_print_chip() callback.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Bartosz Golaszewski, Linus Walleij:
>
> This could come togather with some refactoring and replacing
> all 'd->irq & 7' to 'irqd_to_hwirq', bu this comes in following
> patch.
> ---
>  drivers/gpio/gpio-ep93xx.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 7edcdc575080..192be99b1392 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/bitops.h>
> +#include <linux/seq_file.h>
>
>  #define EP93XX_GPIO_F_INT_STATUS 0x5c
>  #define EP93XX_GPIO_A_INT_STATUS 0xa0
> @@ -40,7 +41,6 @@
>  #define EP93XX_GPIO_F_IRQ_BASE 80
>
>  struct ep93xx_gpio_irq_chip {
> -       struct irq_chip ic;
>         u8 irq_offset;
>         u8 int_unmasked;
>         u8 int_enabled;
> @@ -185,6 +185,7 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
>         ep93xx_gpio_update_int_params(epg, eic);
>
>         writeb(port_mask, epg->base + eic->irq_offset + EP93XX_INT_EOI_OFFSET);
> +       gpiochip_disable_irq(gc, irqd_to_hwirq(d));
>  }
>
>  static void ep93xx_gpio_irq_mask(struct irq_data *d)
> @@ -195,6 +196,7 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
>
>         eic->int_unmasked &= ~BIT(d->irq & 7);
>         ep93xx_gpio_update_int_params(epg, eic);
> +       gpiochip_disable_irq(gc, irqd_to_hwirq(d));
>  }
>
>  static void ep93xx_gpio_irq_unmask(struct irq_data *d)
> @@ -203,6 +205,7 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
>         struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
>         struct ep93xx_gpio *epg = gpiochip_get_data(gc);
>
> +       gpiochip_enable_irq(gc, irqd_to_hwirq(d));
>         eic->int_unmasked |= BIT(d->irq & 7);
>         ep93xx_gpio_update_int_params(epg, eic);
>  }
> @@ -320,15 +323,25 @@ static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
>         return 0;
>  }
>
> -static void ep93xx_init_irq_chip(struct device *dev, struct irq_chip *ic)
> +static void ep93xx_irq_print_chip(struct irq_data *data, struct seq_file *p)
>  {
> -       ic->irq_ack = ep93xx_gpio_irq_ack;
> -       ic->irq_mask_ack = ep93xx_gpio_irq_mask_ack;
> -       ic->irq_mask = ep93xx_gpio_irq_mask;
> -       ic->irq_unmask = ep93xx_gpio_irq_unmask;
> -       ic->irq_set_type = ep93xx_gpio_irq_type;
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +
> +       seq_printf(p, dev_name(gc->parent));
>  }
>
> +static const struct irq_chip gpio_eic_irq_chip = {
> +       .name                   = "ep93xx-gpio-eic",
> +       .irq_ack                = ep93xx_gpio_irq_ack,
> +       .irq_mask               = ep93xx_gpio_irq_mask,
> +       .irq_unmask             = ep93xx_gpio_irq_unmask,
> +       .irq_mask_ack   = ep93xx_gpio_irq_mask_ack,
> +       .irq_set_type   = ep93xx_gpio_irq_type,
> +       .irq_print_chip = ep93xx_irq_print_chip,
> +       .flags                  = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
>                                 struct platform_device *pdev,
>                                 struct ep93xx_gpio *epg,
> @@ -359,12 +372,7 @@ static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
>                 if (!egc->eic)
>                         return -ENOMEM;
>                 egc->eic->irq_offset = bank->irq;
> -               ic = &egc->eic->ic;
> -               ic->name = devm_kasprintf(dev, GFP_KERNEL, "gpio-irq-%s", bank->label);
> -               if (!ic->name)
> -                       return -ENOMEM;
> -               ep93xx_init_irq_chip(dev, ic);
> -               girq->chip = ic;
> +               gpio_irq_chip_set_chip(girq, &gpio_eic_irq_chip);
>         }
>
>         if (bank->has_irq) {
> --
> 2.37.4
>

Queued for fixes, thanks!

Bart
