Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDA720289
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjFBND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjFBNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:03:55 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30819A;
        Fri,  2 Jun 2023 06:03:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6261cb1208eso19480756d6.0;
        Fri, 02 Jun 2023 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711032; x=1688303032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwu3a5TiDNk8aQX2qZ7oGL61sBeYU4YgJcuj8qXhAP4=;
        b=AUtqBJyZ0q5NPj4CuiDNzoMzkp06YVY+KXCw5P/LEFgqo3bvtjU6wcdT7Kq/bJ00fj
         ekdccBJyWK2YzgUG7gaIPL+N4PS/WXGy2QeKn5PHijfRsko0ofEI8CMTURVlVWKxmkye
         kdW8vINpOKSOJanVCdeVHNNfwMQqwEj4w5/4lntGFRbYJNIve1fLkT6rpmIDOv23VQxL
         lQTb/wkp8kOH/XIhV0Eb5vkyxLtyiyAnBd+zh3ASH3S3Xmi7JRKG4FPZZhLnBFLI89XV
         OOlQcvBm+Ri3hEfok4py9SD/ch5NIKxHTLItTJhZRlcFSNgdUaQj3q4ZdW0K2tAqeTZr
         OY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711032; x=1688303032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwu3a5TiDNk8aQX2qZ7oGL61sBeYU4YgJcuj8qXhAP4=;
        b=JlF+uC8DEa1B6QYdTK4K8/sTrkUUCOKievCj18siXvJ7KcSUoPtvm6HvpT1zWqnqDK
         3U5/nmyWq3FtBny+uhUGHj9Ur0WU/cGdetSRk86OXy5W1FT68UykV/RwHdPIKVWnOfOk
         AjeP/x2CCceO7UV5LbvhZihF9knU7tPVrAzlAcf/tpesne5jXJAvpLCLLBJO7UPmmzrt
         tfXSD1UZrXlYVWQDVkEFYRbJKFK5F8FARvyNMMETvXbqvFv2+ah5wRgPH0DRDYIZES9N
         0SQmBwpqAjW+ByiPRvT9ENeWunqXEvFJkS+lUJTckDZUDHc003YPDECh2l5gxA7LMBbc
         iuKQ==
X-Gm-Message-State: AC+VfDwLmJDNtxf2IwTGec7puPpvEHPn8iye2ST8sK5jrPHLC2H4++Nf
        aQb1bJ/668gi/Cw9lYIlfjL0IouaZvKMGKirT8o=
X-Google-Smtp-Source: ACHHUZ5oNkE2+uMJq9lvZUWNrIS3tlbtY4VxLBOJs7jzLpJ3o43croYk9Ip3WhUy+unyiGCQgAx5CbQb186fLGTd1yc=
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id
 fv11-20020a056214240b00b006239a084eddmr6420585qvb.25.1685711031776; Fri, 02
 Jun 2023 06:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230602072755.7314-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230602072755.7314-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jun 2023 16:03:15 +0300
Message-ID: <CAHp75VfSU-xXWPmwjCKsxc_WcFdZmJuYBO1nd230SeLe7D+b-g@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sifive: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 10:28=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.c=
n> wrote:
>
> Add the missing check for platform_get_irq and return error code
> if it fails.

The template for function references is func().
Otherwise looks fine to me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Return "chip->irq_number[i]" instead of "-ENODEV".
> ---
>  drivers/gpio/gpio-sifive.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 98939cd4a71e..7245000fb049 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -221,8 +221,11 @@ static int sifive_gpio_probe(struct platform_device =
*pdev)
>                 return -ENODEV;
>         }
>
> -       for (i =3D 0; i < ngpio; i++)
> +       for (i =3D 0; i < ngpio; i++) {
>                 chip->irq_number[i] =3D platform_get_irq(pdev, i);
> +               if (chip->irq_number[i] < 0)
> +                       return chip->irq_number[i];
> +       }
>
>         ret =3D bgpio_init(&chip->gc, dev, 4,
>                          chip->base + SIFIVE_GPIO_INPUT_VAL,
> --
> 2.25.1
>


--
With Best Regards,
Andy Shevchenko
