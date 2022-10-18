Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C36025AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJRH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJRH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:28:37 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4142B60D;
        Tue, 18 Oct 2022 00:28:36 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id a18so8165397qko.0;
        Tue, 18 Oct 2022 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsYcGW4TBn6VK6ga6YeeEhBKt8rBJ4PJ+yBy0r0qvZQ=;
        b=7cmB9RAZPIb1mm/t378K9BkdtxtQcublOvOnw+87kR7XR9tGnRH/P2ct5e/LcucKun
         raPupMtNMTDUHqauNh26+tdbVFlYxo7hCofd2ajFUmScwZJBXANF5RB4nIvKhTsSm+Cw
         YqpBjkLvteCPx2gXJFa5jfPJGUA/0e+4eLvqJ1bycBIug2iOuAUIQjHsubCWSi1tFlSm
         qfXKWycG3GEh77mXwC0/sL7I2gDIJDuBWPU/ViIqSoW7h5lLY7Ick2mOYUaLk4ZNxDoJ
         Co2Kz1hGZG3CAR4icOT50aTJOlK4smcus2P/mND9WwAZThje/oaKL/fZnvNYYsRG7LIS
         t8jQ==
X-Gm-Message-State: ACrzQf0FdFa4yvmEMSiDc71ODZb1dtTDM0XVOJYxVKyf41jfrd/7F7OC
        8D0X/hsyYFw6BVJXTyuWpsPKcfSsCgzFTQ==
X-Google-Smtp-Source: AMsMyM6V6Huror4kr2/bh0w1E6/DBl282o3yPQa2JsHtOMHv0sPFbNrz9WFoVC9yBykk1K8aweAmbw==
X-Received: by 2002:a05:620a:1523:b0:6ee:4780:4844 with SMTP id n3-20020a05620a152300b006ee47804844mr943848qkk.700.1666078115383;
        Tue, 18 Oct 2022 00:28:35 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id az13-20020a05620a170d00b006eea461177csm1887335qkb.29.2022.10.18.00.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:28:35 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e62so15981257yba.6;
        Tue, 18 Oct 2022 00:28:34 -0700 (PDT)
X-Received: by 2002:a25:2:0:b0:6c4:dc1:d37c with SMTP id 2-20020a250002000000b006c40dc1d37cmr1255226yba.380.1666078114683;
 Tue, 18 Oct 2022 00:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221015172602.84855-1-clamor95@gmail.com> <20221015172602.84855-2-clamor95@gmail.com>
In-Reply-To: <20221015172602.84855-2-clamor95@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 09:28:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVy2YPY=35tBUj-_p=VvkGpJH4=OrDQLjFvr6+pKv3JRA@mail.gmail.com>
Message-ID: <CAMuHMdVy2YPY=35tBUj-_p=VvkGpJH4=OrDQLjFvr6+pKv3JRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: tegra: Convert to immutable irq chip
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

On Sat, Oct 15, 2022 at 7:30 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> Update the driver to use an immutable IRQ chip to fix this warning:
>
>     "not an immutable chip, please consider fixing it!"
>
> Preserve per-chip labels by adding an ->irq_print_chip() callback.
>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # TF201 T30
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # TF101 T20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks for your patch!

Thanks for your patch, which is now commit 6ebd28bd087127ab
("gpio: tegra: Convert to immutable irq chip") in next-20221018.

noreply@ellerman.id.au reports a build failure introduced by
this commit on e.g. m68k-allmodconfig:

    drivers/gpio/gpio-tegra.c:616:48: error: 'tegra_gpio_irq_set_wake'
undeclared here (not in a function); did you mean
'tegra_gpio_irq_set_type'?


> index e4fb4cb38a0f..6b469253fad8 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c

> @@ -598,10 +600,43 @@ static void tegra_gpio_irq_release_resources(struct irq_data *d)
>         tegra_gpio_enable(tgi, d->hwirq);
>  }
>
> +static void tegra_gpio_irq_print_chip(struct irq_data *d, struct seq_file *s)
> +{
> +       struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +
> +       seq_printf(s, dev_name(chip->parent));
> +}
> +
> +static const struct irq_chip tegra_gpio_irq_chip = {
> +       .irq_shutdown           = tegra_gpio_irq_shutdown,
> +       .irq_ack                = tegra_gpio_irq_ack,
> +       .irq_mask               = tegra_gpio_irq_mask,
> +       .irq_unmask             = tegra_gpio_irq_unmask,
> +       .irq_set_type           = tegra_gpio_irq_set_type,
> +       .irq_set_wake           = pm_sleep_ptr(tegra_gpio_irq_set_wake),

This is an unrelated change, breaking the build if CONFIG_PM_SLEEP
is not set: the function pointer argument of pm_sleep_ptr() is always
referenced, so the function definition must not be protected by #ifdef
CONFIG_PM_SLEEP.

As tegra_gpio_{resume,suspend}() are also in that section, you probably
want to convert the references to them to the new macros introduced by
commit 1a3c7bb088266fa2 ("PM: core: Add new *_PM_OPS macros,
deprecate old ones"), too.

Or just revert this change for now.

> +       .irq_print_chip         = tegra_gpio_irq_print_chip,
> +       .irq_request_resources  = tegra_gpio_irq_request_resources,
> +       .irq_release_resources  = tegra_gpio_irq_release_resources,
> +       .flags                  = IRQCHIP_IMMUTABLE,
> +};
> +
> +static const struct irq_chip tegra210_gpio_irq_chip = {
> +       .irq_shutdown           = tegra_gpio_irq_shutdown,
> +       .irq_ack                = tegra_gpio_irq_ack,
> +       .irq_mask               = tegra_gpio_irq_mask,
> +       .irq_unmask             = tegra_gpio_irq_unmask,
> +       .irq_set_affinity       = tegra_gpio_irq_set_affinity,
> +       .irq_set_type           = tegra_gpio_irq_set_type,
> +       .irq_set_wake           = pm_sleep_ptr(tegra_gpio_irq_set_wake),
> +       .irq_print_chip         = tegra_gpio_irq_print_chip,
> +       .irq_request_resources  = tegra_gpio_irq_request_resources,
> +       .irq_release_resources  = tegra_gpio_irq_release_resources,
> +       .flags                  = IRQCHIP_IMMUTABLE,
> +};
> +
>  #ifdef CONFIG_DEBUG_FS
>
>  #include <linux/debugfs.h>
> -#include <linux/seq_file.h>
>
>  static int tegra_dbg_gpio_show(struct seq_file *s, void *unused)
>  {
> @@ -689,18 +724,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
>         tgi->gc.ngpio                   = tgi->bank_count * 32;
>         tgi->gc.parent                  = &pdev->dev;
>
> -       tgi->ic.name                    = "GPIO";
> -       tgi->ic.irq_ack                 = tegra_gpio_irq_ack;
> -       tgi->ic.irq_mask                = tegra_gpio_irq_mask;
> -       tgi->ic.irq_unmask              = tegra_gpio_irq_unmask;
> -       tgi->ic.irq_set_type            = tegra_gpio_irq_set_type;
> -       tgi->ic.irq_shutdown            = tegra_gpio_irq_shutdown;
> -#ifdef CONFIG_PM_SLEEP
> -       tgi->ic.irq_set_wake            = tegra_gpio_irq_set_wake;
> -#endif
> -       tgi->ic.irq_request_resources   = tegra_gpio_irq_request_resources;
> -       tgi->ic.irq_release_resources   = tegra_gpio_irq_release_resources;
> -
>         platform_set_drvdata(pdev, tgi);
>
>         if (tgi->soc->debounce_supported)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
