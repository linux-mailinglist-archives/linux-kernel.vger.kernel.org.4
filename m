Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03186D4D10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjDCQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjDCQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:03:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99326AB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:03:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c29so38755093lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680537824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9G7aUowxIC2TBL5HvvDup5cDrl4CSux698J80MD/8k=;
        b=uIuUI+rmy1bPu//mD4dW34NHS+3aO0fhNH8DA5pUy3oSxt8KOJulSPjI/PGtr+QaJh
         kyGSEwYdBMLnwV9nsQGy1lu4O/ov+W0NDHbKEqOZJcMYkbGy1z4h8U+A0nl+ocxKeY0e
         h3Z1Fu8uDEioFps7Tgp3kh64AQCpTLOEi7/K1rEZUbvJidGgyNDdLq47kZlYo20pAS7R
         B0T2PIQthYwyhSB7xROyLIq9L4CDyCHqkEf3kCey+LRRkLchmvqk5vilnWwoO0F4Dwmq
         VRd8lNm0mSau2R2Vc3ZwNDILjqTDyxLg8Ma7OxWEqUwBdEw3Wbrk/rRkkajBRws5Uf/V
         46jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9G7aUowxIC2TBL5HvvDup5cDrl4CSux698J80MD/8k=;
        b=oWa93fyycjPbKcnskyvLwJQK+qCvsPARWeS6lkOVfLfTVciDTfGGTqyi/TauT4NNug
         ELUG0qxM/N1Ag55Bz0HiUg2rOdfdvuNRZsQYS09mf/BeVBAD/v/5hRJBuJqoW7L4cyCn
         X+QydNBmZq8+ARx3sonZh3qszMKxEqfSrMA/DHg2ea1alx/XzMZsG4arno91U1tuwRwf
         okxKEA8kAKmNOYOL0NY6S+wOJLMz6nel/jlPChAP1bFoN8NS6QPJNhXAuVQlTPldOJS2
         zou77DUNs3nrnRlbuPL0odnEqsl1TDFYMeEF46nlHGioL5e1W1gjh43MvG53VoMcdyQO
         wd3w==
X-Gm-Message-State: AAQBX9evs0Nje/frtD/plUfudIb1qYH2BODsD9iapL/OAQGbNyyw7lww
        0jO9MQuyFEsX0UbaUI1yfIXwHiEWVLQmJUucUR78CA==
X-Google-Smtp-Source: AKy350az+bKy+0p6MVj7KoxWXqsKroiMkmUS8blupoO/H+L43R3XSOKiqKnUViXlnuNJA1p+bvFeCUDIUPdet5qQB6Y=
X-Received: by 2002:a19:ae04:0:b0:4eb:4160:7ca8 with SMTP id
 f4-20020a19ae04000000b004eb41607ca8mr918972lfc.6.1680537824444; Mon, 03 Apr
 2023 09:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230403114033.8336-1-edmund.berenson@emlix.com> <20230403114033.8336-2-edmund.berenson@emlix.com>
In-Reply-To: <20230403114033.8336-2-edmund.berenson@emlix.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Apr 2023 18:03:32 +0200
Message-ID: <CAMRc=MdMd15pDs6WehbQAGKXXm5-C7E2Or0smmD68izvevy62w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: max7317: Add gpio expander driver
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 1:41=E2=80=AFPM Edmund Berenson
<edmund.berenson@emlix.com> wrote:
>
> Add driver for maxim MAX7317 SPI-Interfaced 10 Port
> GPIO Expander.
>
> v2: adjust driver to use regmap
>
> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  drivers/gpio/Kconfig        |  11 +++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-max7317.c | 161 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/gpio/gpio-max7317.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..109cf09d8c05 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1615,6 +1615,17 @@ config GPIO_MAX7301
>         help
>           GPIO driver for Maxim MAX7301 SPI-based GPIO expander.
>
> +config GPIO_MAX7317
> +       tristate "Maxim MAX7317 GPIO expander"
> +       select REGMAP_SPI
> +       help
> +         GPIO driver for Maxim MAX7317 SPI-based GPIO expander.
> +         The MAX7317 is a serial-interfaced gpio extender, with
> +         10 ports.
> +
> +         This driver can also be built as a module. If so, the module wi=
ll be
> +         called gpio-max7317.
> +
>  config GPIO_MC33880
>         tristate "Freescale MC33880 high-side/low-side switch"
>         help
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c048ba003367..8dce549bb6c5 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_GPIO_MAX7300)            +=3D gpio-max7300=
.o
>  obj-$(CONFIG_GPIO_MAX7301)             +=3D gpio-max7301.o
>  obj-$(CONFIG_GPIO_MAX730X)             +=3D gpio-max730x.o
>  obj-$(CONFIG_GPIO_MAX732X)             +=3D gpio-max732x.o
> +obj-$(CONFIG_GPIO_MAX7317)             +=3D gpio-max7317.o
>  obj-$(CONFIG_GPIO_MAX77620)            +=3D gpio-max77620.o
>  obj-$(CONFIG_GPIO_MAX77650)            +=3D gpio-max77650.o
>  obj-$(CONFIG_GPIO_MB86S7X)             +=3D gpio-mb86s7x.o
> diff --git a/drivers/gpio/gpio-max7317.c b/drivers/gpio/gpio-max7317.c
> new file mode 100644
> index 000000000000..65824efaad6c
> --- /dev/null
> +++ b/drivers/gpio/gpio-max7317.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021, Lukasz Zemla, Woodward Inc.
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +
> +#define MAX7317_PIN_NUMBER 10
> +#define REG_CODE_READ_PORTS_7_TO_0     ((u8)0x0E)
> +#define REG_CODE_READ_PORTS_9_TO_8     ((u8)0x0F)
> +
> +struct max7317 {

Please call it max7317_gpio or something similar.

> +       struct gpio_chip        chip;
> +       struct regmap           *regmap;
> +       int                     direction[MAX7317_PIN_NUMBER];

Don't use tabs in structs, it doesn't really add to readability in
small declarations.

> +};
> +
> +struct max7317_platform_data {
> +       unsigned int    gpio_base;
> +};
> +
> +static const struct regmap_config max7317_regmap_cfg =3D  {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +};
> +
> +static int max7317_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct max7317 *ts =3D gpiochip_get_data(chip);
> +       unsigned int val;
> +       int ret;
> +       u8 reg =3D (offset < 8) ? REG_CODE_READ_PORTS_7_TO_0 : REG_CODE_R=
EAD_PORTS_9_TO_8;
> +
> +       ret =3D regmap_read(ts->regmap, reg, &val);
> +       if (ret)
> +               return ret;
> +
> +       return val & BIT(offset % 8);
> +}
> +
> +/*
> + * After writing the register an additional read is performed in order f=
or
> + * changes to take effect.
> + */
> +static void max7317_set(struct gpio_chip *chip, unsigned int offset, int=
 value)
> +{
> +       struct max7317 *ts =3D gpiochip_get_data(chip);
> +
> +       if (regmap_write(ts->regmap, offset, value ? 1 : 0))
> +               dev_err(chip->parent, "Failed to set pin: %d\n", offset);
> +       max7317_get(chip, offset);

Don't you need to protect both the write and read operations from
concurrent access here?


> +}
> +
> +static int max7317_direction_input(struct gpio_chip *chip, unsigned int =
offset)
> +{
> +       struct max7317 *ts =3D gpiochip_get_data(chip);
> +
> +       max7317_set(chip, offset, 1);
> +       ts->direction[offset] =3D GPIO_LINE_DIRECTION_IN;
> +       return 0;
> +}
> +
> +static int max7317_direction_output(struct gpio_chip *chip, unsigned int=
 offset,
> +                                   int value)
> +{
> +       struct max7317 *ts =3D gpiochip_get_data(chip);
> +
> +       ts->direction[offset] =3D GPIO_LINE_DIRECTION_OUT;
> +       return 0;
> +}
> +
> +static int max7317_get_direction(struct gpio_chip *chip, unsigned int of=
fset)
> +{
> +       struct max7317 *ts =3D gpiochip_get_data(chip);
> +
> +       return ts->direction[offset];
> +}
> +
> +static int max7317_probe(struct spi_device *spi)
> +{
> +       struct max7317 *ts;
> +       struct device *dev;
> +       struct max7317_platform_data *pdata;

Where does this come from?

> +       int i;
> +
> +       ts =3D devm_kzalloc(&spi->dev, sizeof(struct max7317), GFP_KERNEL=
);
> +       if (!ts)
> +               return -ENOMEM;
> +       dev_set_drvdata(&spi->dev, ts);
> +
> +       pdata =3D dev_get_platdata(dev);
> +       if (pdata)
> +               ts->chip.base =3D pdata->gpio_base;

Don't encourage setting a hard-coded base via platform data. Please
use -1 unconditionally in new drivers.

> +       else
> +               ts->chip.base =3D -1;
> +
> +       ts->chip.label =3D dev_name(&spi->dev);
> +       ts->chip.direction_input =3D max7317_direction_input;
> +       ts->chip.get =3D max7317_get;
> +       ts->chip.direction_output =3D max7317_direction_output;
> +       ts->chip.set =3D max7317_set;
> +       ts->chip.get_direction =3D max7317_get_direction;
> +
> +       ts->chip.ngpio =3D MAX7317_PIN_NUMBER;
> +       ts->chip.can_sleep =3D true;
> +       ts->chip.parent =3D &spi->dev;
> +       ts->chip.owner =3D THIS_MODULE;
> +
> +       for (i =3D 0; i < MAX7317_PIN_NUMBER; i++)
> +               ts->direction[i] =3D GPIO_LINE_DIRECTION_IN;
> +
> +       ts->regmap =3D devm_regmap_init_spi(spi, &max7317_regmap_cfg);
> +       if (IS_ERR(ts->regmap))
> +               return PTR_ERR(ts->regmap);
> +
> +       return devm_gpiochip_add_data(&spi->dev, &ts->chip, ts);
> +}
> +
> +static void max7317_remove(struct spi_device *spi)
> +{
> +       struct max7317 *ts =3D dev_get_drvdata(&spi->dev);
> +
> +       if (!ts)
> +               return;
> +
> +       gpiochip_remove(&ts->chip);

This is clearly wrong - you registered the chip using
devm_gpiochip_add_data() precisely to avoid having to call
gpiochip_remove(). And checking for !it makes no sense either - you
should have set it yourself, which you didn't.

Bart

> +}
> +
> +static const struct spi_device_id max7317_id[] =3D {
> +       { "max7317", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, max7317_id);
> +
> +static const struct of_device_id max7317_dt_ids[] =3D {
> +       { .compatible =3D "maxim,max7317" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max7317_dt_ids);
> +
> +static struct spi_driver max7317_driver =3D {
> +       .driver =3D {
> +               .name =3D "max7317",
> +               .of_match_table =3D max7317_dt_ids,
> +       },
> +       .probe =3D max7317_probe,
> +       .remove =3D max7317_remove,
> +       .id_table =3D max7317_id,
> +};
> +module_spi_driver(max7317_driver);
> +
> +MODULE_AUTHOR("Lukasz Zemla");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MAX7317 GPIO-Expander");
> --
> 2.39.2
>
