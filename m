Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627886B7F96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCMRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:35:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F82B47C;
        Mon, 13 Mar 2023 10:35:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b34so1323146qkp.8;
        Mon, 13 Mar 2023 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678728956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRj2MDdqf5/iLIV1yny10fSUAfun2B/qRHShe3qPCaI=;
        b=eeyEW66ABReoEiuMJ8NHIcaxVWMZXUWuZjMB69rxhW2hsJsnmMC3Ptyns/3orxmwFE
         PSQykcL3gPWZTdrJl8y28tDXU3ZL7hcA9CzbfK/5HGRf6gKjfY64RBN95oef0KTi33TZ
         IX7GXdZHsffNgjX2nmqXHl87t53eR44uGkBw54BsuMV+/gMhLbQ9YX+hecfltfByftk3
         SP0d6LK/21jMDUyk5gNi/55RAK7LGZ3uLUkQycWQo0cgoclmctajNMuSYMLpn0nMswSW
         QtHb02uq+QjK6sgDDWEuNd9eU2s0d7z8GvL/uZKV7wWk4ko+2ezGcPcXKDu+N4dmBMpQ
         MDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRj2MDdqf5/iLIV1yny10fSUAfun2B/qRHShe3qPCaI=;
        b=qj2lnDSMLLqBiaQ14jVt8gGwQmJMrjhe1coAC0CbuIAnVdMga4nsQGc+/yGqB1rxoT
         Gc8v1DYRk6TCqpKFGzbNWVq4qXf0QF/aHVb/HEGC5VC9QJ6octo/621VEzu7AxI1EEjo
         loDhocOIKIY7Vli5y9DWCxx9R/rF8x7Kapc4Rg8g9VvxMRqLI1HzEWiTJrfQEHHIMCkv
         W1xeNIDgvsg0gcJ/47M0zApuffUpvObNNz+bMuqcvXHVVw3LrOWX3btui54aQBttWGHi
         zkCLQbp5MlmaI4VfPVE8lSuN0qPU3LmncpDczFf1hbpdVhBYS/akXwX+FIpAyZUF6h3C
         W9/g==
X-Gm-Message-State: AO0yUKUYJCKwsZD/7Bfj1Y6AQCHjssHY/Gxzzxd6IvOWNSy8dT13YKoY
        z16JtxN9OtXN8llAmhMrGlkHtmd2zc0vqLZoSeU=
X-Google-Smtp-Source: AK7set/8je9Ik+3KBxZJ2QH/38nWQVioPeBz98OSLoHzkmUBF4fIkmt58LGm0fRBLW5WeV/9YUuDELCbHNQXqRa3gIQ=
X-Received: by 2002:a37:6407:0:b0:745:bd3d:51df with SMTP id
 y7-20020a376407000000b00745bd3d51dfmr102448qkb.3.1678728956344; Mon, 13 Mar
 2023 10:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230313170950.256964-1-francesco@dolcini.it> <20230313170950.256964-3-francesco@dolcini.it>
In-Reply-To: <20230313170950.256964-3-francesco@dolcini.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Mar 2023 19:35:20 +0200
Message-ID: <CAHp75VetwU3pr59sE5zHPf5jPxYb6yJnXZWpD_qn4o6d5Dnmog@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: fxl6408: add I2C GPIO expander driver
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Mon, Mar 13, 2023 at 7:09=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Add minimal driver for Fairchild FXL6408 8-bit I2C-controlled GPIO expand=
er
> using the generic regmap based GPIO driver (GPIO_REGMAP).
>
> The driver implements setting the GPIO direction, reading inputs
> and writing outputs.
>
> In addition to that the FXL6408 has the following functionalities:
> - allows to monitor input ports for data transitions with an interrupt pi=
n
> - all inputs can be configured with pull-up or pull-down resistors

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
But see below.

> Datasheet: https://www.onsemi.com/download/data-sheet/pdf/fxl6408-d.pdf
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v3:
>  * add include files: kernel.h and err.h
>  * refactor of fxl6408_identify and used dev_err_probe instead of dev_err
>  * use FXL6408_REG_INT_STS instead of FXL6408_MAX_REGISTER
>
> v2:
>  * remove includes: <linux/gpio.h> and <linux/of_platform.h>
>  * add missing and required select REGMAP_I2C in KConfig
>  * use dev_err_probe()
>  * add "Datasheet:" tag in commit message
>  * improve KConfig help section
>  * fix newlines, multi-line comments and trailing commas
> ---
>  drivers/gpio/Kconfig        |  10 +++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-fxl6408.c | 158 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 drivers/gpio/gpio-fxl6408.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..56a73007ebcb 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1000,6 +1000,16 @@ config GPIO_ADNP
>           enough to represent all pins, but the driver will assume a
>           register layout for 64 pins (8 registers).
>
> +config GPIO_FXL6408
> +       tristate "FXL6408 I2C GPIO expander"
> +       select GPIO_REGMAP
> +       select REGMAP_I2C
> +       help
> +         GPIO driver for Fairchild Semiconductor FXL6408 GPIO expander.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called gpio-fxl6408.
> +
>  config GPIO_GW_PLD
>         tristate "Gateworks PLD GPIO Expander"
>         depends on OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c048ba003367..12027f4c3bee 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_GPIO_EP93XX)             +=3D gpio-ep93xx.=
o
>  obj-$(CONFIG_GPIO_EXAR)                        +=3D gpio-exar.o
>  obj-$(CONFIG_GPIO_F7188X)              +=3D gpio-f7188x.o
>  obj-$(CONFIG_GPIO_FTGPIO010)           +=3D gpio-ftgpio010.o
> +obj-$(CONFIG_GPIO_FXL6408)             +=3D gpio-fxl6408.o
>  obj-$(CONFIG_GPIO_GE_FPGA)             +=3D gpio-ge.o
>  obj-$(CONFIG_GPIO_GPIO_MM)             +=3D gpio-gpio-mm.o
>  obj-$(CONFIG_GPIO_GRGPIO)              +=3D gpio-grgpio.o
> diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
> new file mode 100644
> index 000000000000..d7387c0101e2
> --- /dev/null
> +++ b/drivers/gpio/gpio-fxl6408.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FXL6408 GPIO driver
> + *
> + * Copyright 2023 Toradex
> + *
> + * Author: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>

Seems unordered?

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define FXL6408_REG_DEVICE_ID          0x01
> +#define FXL6408_MF_FAIRCHILD           0b101
> +#define FXL6408_MF_SHIFT               5
> +
> +/* Bits set here indicate that the GPIO is an output. */
> +#define FXL6408_REG_IO_DIR             0x03
> +
> +/*
> + * Bits set here, when the corresponding bit of IO_DIR is set, drive
> + * the output high instead of low.
> + */
> +#define FXL6408_REG_OUTPUT             0x05
> +
> +/* Bits here make the output High-Z, instead of the OUTPUT value. */
> +#define FXL6408_REG_OUTPUT_HIGH_Z      0x07
> +
> +/* Returns the current status (1 =3D HIGH) of the input pins. */
> +#define FXL6408_REG_INPUT_STATUS       0x0f
> +
> +/*
> + * Return the current interrupt status
> + * This bit is HIGH if input GPIO !=3D default state (register 09h).
> + * The flag is cleared after being read (bit returns to 0).
> + * The input must go back to default state and change again before this =
flag is raised again.
> + */
> +#define FXL6408_REG_INT_STS            0x13
> +
> +#define FXL6408_NGPIO                  8
> +
> +static const struct regmap_range rd_range[] =3D {
> +       { FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
> +       { FXL6408_REG_IO_DIR, FXL6408_REG_OUTPUT },
> +       { FXL6408_REG_INPUT_STATUS, FXL6408_REG_INPUT_STATUS },
> +};
> +
> +static const struct regmap_range wr_range[] =3D {
> +       { FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
> +       { FXL6408_REG_IO_DIR, FXL6408_REG_OUTPUT },
> +       { FXL6408_REG_OUTPUT_HIGH_Z, FXL6408_REG_OUTPUT_HIGH_Z },
> +};
> +
> +static const struct regmap_range volatile_range[] =3D {
> +       { FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
> +       { FXL6408_REG_INPUT_STATUS, FXL6408_REG_INPUT_STATUS },
> +};
> +
> +static const struct regmap_access_table rd_table =3D {
> +       .yes_ranges =3D rd_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(rd_range),
> +};
> +
> +static const struct regmap_access_table wr_table =3D {
> +       .yes_ranges =3D wr_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(wr_range),
> +};
> +
> +static const struct regmap_access_table volatile_table =3D {
> +       .yes_ranges =3D volatile_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(volatile_range),
> +};
> +
> +static const struct regmap_config regmap =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +
> +       .max_register =3D FXL6408_REG_INT_STS,
> +       .wr_table =3D &wr_table,
> +       .rd_table =3D &rd_table,
> +       .volatile_table =3D &volatile_table,
> +
> +       .cache_type =3D REGCACHE_RBTREE,
> +       .num_reg_defaults_raw =3D FXL6408_REG_INT_STS + 1,
> +};
> +
> +static int fxl6408_identify(struct device *dev, struct regmap *regmap)
> +{
> +       int val, ret;
> +
> +       ret =3D regmap_read(regmap, FXL6408_REG_DEVICE_ID, &val);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "error reading DEVICE_ID\n=
");
> +       if (val >> FXL6408_MF_SHIFT !=3D FXL6408_MF_FAIRCHILD)
> +               return dev_err_probe(dev, -ENODEV, "invalid device id 0x%=
02x\n", val);
> +
> +       return 0;
> +}
> +
> +static int fxl6408_probe(struct i2c_client *client)
> +{
> +       struct device *dev =3D &client->dev;
> +       int ret;
> +       struct gpio_regmap_config gpio_config =3D {
> +               .parent =3D dev,
> +               .ngpio =3D FXL6408_NGPIO,
> +               .reg_dat_base =3D GPIO_REGMAP_ADDR(FXL6408_REG_INPUT_STAT=
US),
> +               .reg_set_base =3D GPIO_REGMAP_ADDR(FXL6408_REG_OUTPUT),
> +               .reg_dir_out_base =3D GPIO_REGMAP_ADDR(FXL6408_REG_IO_DIR=
),
> +               .ngpio_per_reg =3D FXL6408_NGPIO,
> +       };
> +
> +       gpio_config.regmap =3D devm_regmap_init_i2c(client, &regmap);
> +       if (IS_ERR(gpio_config.regmap))
> +               return dev_err_probe(dev, PTR_ERR(gpio_config.regmap),
> +                                    "failed to allocate register map\n")=
;
> +
> +       ret =3D fxl6408_identify(dev, gpio_config.regmap);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable High-Z of outputs, so that our OUTPUT updates actually=
 take effect. */
> +       ret =3D regmap_write(gpio_config.regmap, FXL6408_REG_OUTPUT_HIGH_=
Z, 0);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to write 'output h=
igh Z' register\n");
> +
> +       return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_confi=
g));
> +}
> +
> +static const __maybe_unused struct of_device_id fxl6408_dt_ids[] =3D {
> +       { .compatible =3D "fcs,fxl6408" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, fxl6408_dt_ids);
> +
> +static const struct i2c_device_id fxl6408_id[] =3D {
> +       { "fxl6408", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, fxl6408_id);
> +
> +static struct i2c_driver fxl6408_driver =3D {
> +       .driver =3D {
> +               .name   =3D "fxl6408",
> +               .of_match_table =3D fxl6408_dt_ids,
> +       },
> +       .probe_new      =3D fxl6408_probe,
> +       .id_table       =3D fxl6408_id,
> +};
> +module_i2c_driver(fxl6408_driver);
> +
> +MODULE_AUTHOR("Emanuele Ghidoli <emanuele.ghidoli@toradex.com>");
> +MODULE_DESCRIPTION("FXL6408 GPIO driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko
