Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CF6B0459
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCHKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCHKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:30:36 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB2B9BFC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:29:59 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id m10so14936069vso.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678271398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs6kG7SxJlX0Yk0MstxBWczLimozPECORl9CWMpgGIE=;
        b=09XXxUisY/HQYXwwxtyhC7SBMwEiIOErSiKN8eKWW87IQlEg8OyXmx1ITZP1UrAhdw
         78fZ0z+X3gPORRermXoXW7AUucJKgdWV+MBLqRHXM1sFeE0pzZvJUencYjw4+uZVsp3V
         V/JN0qlgaYCJslTpjwLgjybJsMXvyoCWYsizTehd3T5f0cmaCQtDBpicIGppfCQiRpB4
         10GD4s4RpMmZhmIuH0QXpRuYbdHo41m6eMuf7WyQS9tkUEHghQ42yOpZ7s1lWX3he33w
         S0IILgoLcDvJ0Ep6Wpjm4hVRH5kxKi4GWpCapoLdkkrLuaf5HgX7arIAlGyi/hoNH62F
         MOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs6kG7SxJlX0Yk0MstxBWczLimozPECORl9CWMpgGIE=;
        b=2rDVaFtKiv+r2JvHr5j4ofOjVfNDuVCEI4I2hJlnsWWAO4XtGmEGX5zrie0iW12faS
         KXPsH3VGAIL7hmDxF6PetlR+W/6/DK0txne7emYYdKRUAUL2dKikk8WWDJgBAiuvx8lZ
         3OstrV6tzBdC63uTn0Lo20gF6u2W7mimLGj7sFC/Y5E7QZHgPzA2vybkzu9DtnEsItpi
         zZtC8H39iTVccol2RXviXJhW1cYB9oMxqoi0MNnL9fYgrKANqXoxE1skXh2fex2rTDT8
         9qtLDyPZPLfLkM1vLFZSCxtge94sxSfgoOGSPJmmlZ07dBMu8cEhuyTnnHUrXEf15s0S
         /KQw==
X-Gm-Message-State: AO0yUKVsI/1v2W7cLji48SMZwvttL6N0F5B5pQMXc5vp0UIuNaNZGLpW
        ukYeQFBxPfkbg+ECHAu+rp2xVUTszoKuQrsz0XjFmQ==
X-Google-Smtp-Source: AK7set/KeAajv23VPgHouLH4U6B4lFCG5Lg3uXjZmL8R9yoeDuIDjWXQeRxkg4Ktp5A2k597WDKVIEY7FkOJiuQ49IU=
X-Received: by 2002:a67:f406:0:b0:414:48a5:473f with SMTP id
 p6-20020a67f406000000b0041448a5473fmr11779308vsn.0.1678271398011; Wed, 08 Mar
 2023 02:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-6-afd@ti.com>
In-Reply-To: <20230307165432.25484-6-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:29:47 +0100
Message-ID: <CAMRc=Mcr_yM8Z4bg3EqvxBrRsEqNjigfNoxZAd-5zNeXzG8yeQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: tps65086: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-tps65086.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tps65086.c b/drivers/gpio/gpio-tps65086.c
> index 1e9d8262d0ff..0b8b631441ae 100644
> --- a/drivers/gpio/gpio-tps65086.c
> +++ b/drivers/gpio/gpio-tps65086.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com=
/
> - *     Andrew F. Davis <afd@ti.com>
> + * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.=
ti.com/
> + *     Andrew Davis <afd@ti.com>
>   *
>   * Based on the TPS65912 driver
>   */
> @@ -86,13 +86,11 @@ static int tps65086_gpio_probe(struct platform_device=
 *pdev)
>         if (!gpio)
>                 return -ENOMEM;
>
> -       platform_set_drvdata(pdev, gpio);
> -
>         gpio->tps =3D dev_get_drvdata(pdev->dev.parent);
>         gpio->chip =3D template_chip;
>         gpio->chip.parent =3D gpio->tps->dev;
>
> -       ret =3D gpiochip_add_data(&gpio->chip, gpio);
> +       ret =3D devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Could not register gpiochip, %d\n", =
ret);

Drop this log and just return directly the result of
devm_gpiochip_add_data() to save a couple more lines.

Bart

>                 return ret;
> @@ -101,15 +99,6 @@ static int tps65086_gpio_probe(struct platform_device=
 *pdev)
>         return 0;
>  }
>
> -static int tps65086_gpio_remove(struct platform_device *pdev)
> -{
> -       struct tps65086_gpio *gpio =3D platform_get_drvdata(pdev);
> -
> -       gpiochip_remove(&gpio->chip);
> -
> -       return 0;
> -}
> -
>  static const struct platform_device_id tps65086_gpio_id_table[] =3D {
>         { "tps65086-gpio", },
>         { /* sentinel */ }
> @@ -121,11 +110,10 @@ static struct platform_driver tps65086_gpio_driver =
=3D {
>                 .name =3D "tps65086-gpio",
>         },
>         .probe =3D tps65086_gpio_probe,
> -       .remove =3D tps65086_gpio_remove,
>         .id_table =3D tps65086_gpio_id_table,
>  };
>  module_platform_driver(tps65086_gpio_driver);
>
> -MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> +MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
>  MODULE_DESCRIPTION("TPS65086 GPIO driver");
>  MODULE_LICENSE("GPL v2");
> --
> 2.39.2
>
