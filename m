Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865B65B264
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjABMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjABMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:50:41 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A9636E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:50:39 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id i188so28849958vsi.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMZx54Xj2ddNmH7CYT53GxPmLR4IA/SYVliSYQdrkpw=;
        b=PvM8eQTCd7btpRU4ZlTCF4FwTkgmzS/WWSkogViUT4SQitmOmeDGaqAImpqXDZ/bY8
         dLHKKQiFQVLZNAG2Mmg9uEIIPxtGNiy97XDqBa/o3o2u0/HIfb0uqNsE6X/EXjDfj3u8
         bk4BrFfCqpq173Y33Qph5m+UGqQy1aNVr3SywMseBY3Z1BdR8BMm3VowUdMBX6eK791A
         nubZzDTPaYiBJeKbyCkFpnZRqgp+TBnOSKpA0H1xBgtJsYshe4+kLQ/a92E1B5TdlR0C
         IXpoG1QNu5LzzygGiEdtNtkbw/qsPlJFlsVsk+ohSK5YTkiKAh2v2ZREkI3hAoZrmO+x
         STnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMZx54Xj2ddNmH7CYT53GxPmLR4IA/SYVliSYQdrkpw=;
        b=hNcJhMHTC3l2aKP7bC+x8vFqtARX+MvL4N0I/Nak0P7wj6pOH3/gyldvAUapYam4Ed
         60IPQ/pCHRqRTdVqZ9dN1PQXBoFtz8I0/XrpPE+lvFA6h8bNAM2fib6aMxbOboT+bBgY
         tG+xruuQn1QqTpm0UFi0+G6AiwXqUxa7KoamJpgMgavxMHC2BnmZI9J7QAGKV1bIEIrV
         bm1746Nawa8LQO9aV4R23F+zRfFRWCJzaTbpfppHW4T6dtgzHkM3PM8EJreiQJyqVNBi
         GZ35p8V5cZQEje/Zu37Hxty02eNIPtFnH0g7Sf5H6gQ7Ye7sLNTL/O0iXWsRqFzrS4c8
         vyAw==
X-Gm-Message-State: AFqh2kon/a4gOgdKY6MnOvK3WB1WRyhPd2fspRVpzQR/nwvzAtioAxYA
        GToqlJyJtpac8K/7pi1vcx2JvzvN83gAmPCQUuTFyg==
X-Google-Smtp-Source: AMrXdXuf4b3Bg22BCumrnpgf8Qq1Vd3sY7tHk7TVqhJ7KpYvOygxJe3TYd/BrwSL62GTL8cl0TxrybJiy7UffzX4Kus=
X-Received: by 2002:a67:df8c:0:b0:3c5:1ac1:bf38 with SMTP id
 x12-20020a67df8c000000b003c51ac1bf38mr4030319vsk.78.1672663838685; Mon, 02
 Jan 2023 04:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com> <20221213224310.543243-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221213224310.543243-5-fabrizio.castro.jz@renesas.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Jan 2023 13:50:27 +0100
Message-ID: <CAMRc=MdmtzynWR22Cyzm-vzt_g0g9aAmNX4fYbnB4invDq3+Fg@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: Add support for Renesas RZ/V2M PWC
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:43 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> The RZ/V2M SoC contains an External Power Sequence Controller (PWC)
> module. This module provides an external power supply on/off sequence,
> on/off signal for the LPDDR4 core power supply, control signals for
> external I/O power supplies of the SD host interfaces, and key input
> signals.
> PWC is essentially a Multi-Function Device (MFD).
>
> The driver just implements the control signals for external I/O
> power supplies of the SD host interfaces as gpios, and it relies on
> syscon and simple-mfd.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  drivers/gpio/Kconfig          |   8 +++
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-rzv2m-pwc.c | 123 ++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/gpio/gpio-rzv2m-pwc.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index e6ebc4c90a5d..e016919b9643 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -553,6 +553,14 @@ config GPIO_ROCKCHIP
>         help
>           Say yes here to support GPIO on Rockchip SoCs.
>
> +config GPIO_RZV2M_PWC
> +       tristate "Renesas RZ/V2M PWC GPIO support"
> +       depends on MFD_SYSCON
> +       depends on ARCH_R9A09G011 || COMPILE_TEST
> +       help
> +         Say yes here to support the External Power Sequence Controller (PWC)
> +         GPIO controller driver for RZ/V2M devices.
> +
>  config GPIO_SAMA5D2_PIOBU
>         tristate "SAMA5D2 PIOBU GPIO support"
>         depends on MFD_SYSCON
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 3462a138764a..5f655684603f 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -132,6 +132,7 @@ obj-$(CONFIG_GPIO_RDC321X)          += gpio-rdc321x.o
>  obj-$(CONFIG_GPIO_REALTEK_OTTO)                += gpio-realtek-otto.o
>  obj-$(CONFIG_GPIO_REG)                 += gpio-reg.o
>  obj-$(CONFIG_GPIO_ROCKCHIP)    += gpio-rockchip.o
> +obj-$(CONFIG_GPIO_RZV2M_PWC)           += gpio-rzv2m-pwc.o
>  obj-$(CONFIG_ARCH_SA1100)              += gpio-sa1100.o
>  obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)       += gpio-sama5d2-piobu.o
>  obj-$(CONFIG_GPIO_SCH311X)             += gpio-sch311x.o
> diff --git a/drivers/gpio/gpio-rzv2m-pwc.c b/drivers/gpio/gpio-rzv2m-pwc.c
> new file mode 100644
> index 000000000000..672d868cb8c9
> --- /dev/null
> +++ b/drivers/gpio/gpio-rzv2m-pwc.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * GPIO driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
> + */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +
> +struct rzv2m_pwc_gpio_priv {
> +       struct gpio_chip gp;
> +       int offset;
> +       struct regmap *regmap;
> +       DECLARE_BITMAP(ch_en_bits, 2);
> +};
> +
> +static void rzv2m_pwc_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +                              int value)
> +{
> +       struct rzv2m_pwc_gpio_priv *priv = gpiochip_get_data(chip);
> +       u32 reg;
> +
> +       /* BIT 16 enables write to BIT 0, and BIT 17 enables write to BIT 1 */
> +       reg = BIT(offset + 16);
> +       if (value)
> +               reg |= BIT(offset);
> +
> +       regmap_write(priv->regmap, priv->offset, reg);
> +
> +       if (value)
> +               set_bit(offset, priv->ch_en_bits);
> +       else
> +               clear_bit(offset, priv->ch_en_bits);

You can use assign_bit() here and pass value to it.

> +}
> +
> +static int rzv2m_pwc_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct rzv2m_pwc_gpio_priv *priv = gpiochip_get_data(chip);
> +
> +       return test_bit(offset, priv->ch_en_bits);
> +}
> +
> +static int rzv2m_pwc_gpio_direction_output(struct gpio_chip *gc,
> +                                          unsigned int nr, int value)
> +{
> +       if (nr > 1)
> +               return -EINVAL;
> +
> +       rzv2m_pwc_gpio_set(gc, nr, value);
> +
> +       return 0;
> +}
> +
> +static const struct gpio_chip rzv2m_pwc_gc = {
> +       .label = "rzv2m_pwc_gpio",
> +       .owner = THIS_MODULE,
> +       .get = rzv2m_pwc_gpio_get,
> +       .set = rzv2m_pwc_gpio_set,
> +       .direction_output = rzv2m_pwc_gpio_direction_output,
> +       .can_sleep = false,
> +       .ngpio = 2,
> +       .base = -1,
> +};
> +
> +static int rzv2m_pwc_gpio_probe(struct platform_device *pdev)
> +{
> +       struct rzv2m_pwc_gpio_priv *priv;
> +       int err;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                                      "regmap");
> +
> +       if (IS_ERR(priv->regmap))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
> +                                    "Can't find regmap property");
> +
> +       err = of_property_read_u32(pdev->dev.of_node, "offset", &priv->offset);

Please don't use OF APIs in drivers anymore, use
device_property_read_u32() instead.

Otherwise looks pretty good!

Bart

> +       if (err)
> +               return dev_err_probe(&pdev->dev, -EINVAL,
> +                                    "Can't find offset property");
> +
> +       /*
> +        * The register used by this driver cannot be read, therefore set the
> +        * outputs to their default values and initialize priv->ch_en_bits accordingly.
> +        * BIT 16 enables write to BIT 0, BIT 17 enables write to BIT 1, and the
> +        * default value of both BIT 0 and BIT 1 is 0.
> +        */
> +       regmap_write(priv->regmap, priv->offset, BIT(17) | BIT(16));
> +       bitmap_zero(priv->ch_en_bits, 2);
> +
> +       priv->gp = rzv2m_pwc_gc;
> +       priv->gp.parent = pdev->dev.parent;
> +       priv->gp.fwnode = dev_fwnode(&pdev->dev);
> +
> +       return devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
> +}
> +
> +static const struct of_device_id rzv2m_pwc_gpio_of_match[] = {
> +       { .compatible = "renesas,rzv2m-pwc-gpio" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzv2m_pwc_gpio_of_match);
> +
> +static struct platform_driver rzv2m_pwc_gpio_driver = {
> +       .probe = rzv2m_pwc_gpio_probe,
> +       .driver = {
> +               .name = "rzv2m_pwc_gpio",
> +               .of_match_table = of_match_ptr(rzv2m_pwc_gpio_of_match),
> +       },
> +};
> +module_platform_driver(rzv2m_pwc_gpio_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/V2M PWC GPIO");
> --
> 2.34.1
>
