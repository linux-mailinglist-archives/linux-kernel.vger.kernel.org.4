Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1EC6B3819
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCJIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCJIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:07:41 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E65ED0D9;
        Fri, 10 Mar 2023 00:07:08 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id v48so2942033uad.6;
        Fri, 10 Mar 2023 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678435609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ompnZ/3O4+0ABFbvCAC6GsX78rObx/mdpREpnU4Oecc=;
        b=cbg0wETPSFur5F3ohH6/3YUQUCSwXh/+CObEvJt4g2MpmNZh7VpVTvfi+R/DkrLdME
         Gl5ebrrnijQocAEx1ZUwF/botmS0rV7JbhaOZnwtPhrb1YszIIwNq+lpGzW9SZcp4u3x
         fj2aCPNJ8i6ajYYyaZOiicTI8Mo72RX0aXW/q2JKVKxHymZurjK1l1+OLwoMr/ttGeR/
         KRFDIifCS28nqitPTq3c0/oMJO8bt3E4FDu0ly5uFd0RyfpOcoGG61XQDAp8NKrfg9gX
         7ZYrdVAy0ae78C8fCXP07GddGi6Bd6X5GAw7eR5LcTAqu5bdW9s1EuhcOvzDyoWqYzD2
         txdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678435609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ompnZ/3O4+0ABFbvCAC6GsX78rObx/mdpREpnU4Oecc=;
        b=c/1y1cBZ0yf5x74k9QH8uzj75MBxjQo0uim2hOG5gotKkgNgt8eiXdGwg+Cv6vcueF
         HXIG2YRNl5bQ/ruZmd59/PRqXLpxV/WRer45jxd0jryaFwFDtpMsXCZIEH44lQSs0LIA
         bPBhGRr9xu1epNiWMpNJpeUqL1PxyO+DHNi95jDPT3ghiSHk/EJa/airEQZ1rljlN1b0
         LbcF0fGjArDs6i9FBLOT9n4LSJknIrhpFNpVJCQmS08pVJM0ClxACsEwBVBBQcxJeK6/
         kAZfHyauzbYfEwRg3BCotknHVbMn1SCTVBcHDumDwur/DjghfTfaJ1DIZv6QBx87IJWd
         mVzg==
X-Gm-Message-State: AO0yUKXqHXzVKOJV8jmLq54fNZznhDPYXtKXzNQ927aRhxVFYO/GAXhQ
        2rj8/GWxRMe7ONAM/d/51BXz7Zr3n4D64Kl8u7w=
X-Google-Smtp-Source: AK7set/qlJvjYuXoCyUYfAj6ozy+Oqc/tvsnLRcTu8sRCueO0ZP2nsCHjERtM+2sxUEh0L/Qs4oOjOXfDAA0Sh/rI6w=
X-Received: by 2002:ab0:5402:0:b0:688:d612:2024 with SMTP id
 n2-20020ab05402000000b00688d6122024mr16280357uaa.2.1678435609291; Fri, 10 Mar
 2023 00:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org> <20230215-immutable-chips-v3-11-972542092a77@linaro.org>
In-Reply-To: <20230215-immutable-chips-v3-11-972542092a77@linaro.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Fri, 10 Mar 2023 09:06:38 +0100
Message-ID: <CABgxDoLkhOR=eq5TAoLk-GfOvPgKzbRyedaM+j-8YsRYn27DMw@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] gpio: msc313: Convert to immutable irq_chip
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
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 9 mars 2023 =C3=A0 08:46, Linus Walleij <linus.walleij@linaro.org> =
a =C3=A9crit :
>
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>
> This conversion follows the pattern of the gpio-ixp4xx
> hierarchical GPIO interrupt driver.

Hi,

lgtm

>
> Cc: Marc Zyngier <maz@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Romain Perier <romain.perier@gmail.com>

> ---
>  drivers/gpio/gpio-msc313.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
> index b0773e5652fa..036ad2324892 100644
> --- a/drivers/gpio/gpio-msc313.c
> +++ b/drivers/gpio/gpio-msc313.c
> @@ -532,17 +532,35 @@ static int msc313_gpio_direction_output(struct gpio=
_chip *chip, unsigned int off
>         return 0;
>  }
>
> +static void msc313_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +
> +       irq_chip_mask_parent(d);
> +       gpiochip_disable_irq(gc, d->hwirq);
> +}
> +
> +static void msc313_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +
> +       gpiochip_enable_irq(gc, d->hwirq);
> +       irq_chip_unmask_parent(d);
> +}
> +
>  /*
>   * The interrupt handling happens in the parent interrupt controller,
>   * we don't do anything here.
>   */
> -static struct irq_chip msc313_gpio_irqchip =3D {
> +static const struct irq_chip msc313_gpio_irqchip =3D {
>         .name =3D "GPIO",
>         .irq_eoi =3D irq_chip_eoi_parent,
> -       .irq_mask =3D irq_chip_mask_parent,
> -       .irq_unmask =3D irq_chip_unmask_parent,
> +       .irq_mask =3D msc313_gpio_irq_mask,
> +       .irq_unmask =3D msc313_gpio_irq_unmask,
>         .irq_set_type =3D irq_chip_set_type_parent,
>         .irq_set_affinity =3D irq_chip_set_affinity_parent,
> +       .flags =3D IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>
>  /*
> @@ -644,7 +662,7 @@ static int msc313_gpio_probe(struct platform_device *=
pdev)
>         gpiochip->names =3D gpio->gpio_data->names;
>
>         gpioirqchip =3D &gpiochip->irq;
> -       gpioirqchip->chip =3D &msc313_gpio_irqchip;
> +       gpio_irq_chip_set_chip(gpioirqchip, &msc313_gpio_irqchip);
>         gpioirqchip->fwnode =3D of_node_to_fwnode(dev->of_node);
>         gpioirqchip->parent_domain =3D parent_domain;
>         gpioirqchip->child_to_parent_hwirq =3D msc313e_gpio_child_to_pare=
nt_hwirq;
>
> --
> 2.34.1
>
