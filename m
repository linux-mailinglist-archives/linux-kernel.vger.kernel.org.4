Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1116ABAA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:03:51 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E735A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:03:49 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m10so8575357vso.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678097029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPzr8oFiB9fNElzzDfAoV9vrNYHk5FKfy7JJ4PIAqSE=;
        b=2RNNu9YkiQ9SLv1yzu0hlw6ycMPTC+jRGdK9O0mV15wx4zfDdLYJ6qq6IyXMjFC2ui
         RWQNlI0cF75KIRly7kP8H5zxL2Ufsr4KKlbw7MW4tu2lCQEWY3i0F2OTZXl2D9RlLkfD
         2jRrUv7v+b2vtrK7k/xAwCOMkyJdgxkEfPwkqdoSsmD/skVJPXlkXDFU4vRi+5UTH2kh
         nJy1mOaur2/OrTCMRw0YO11n+wUwiJ69YXhyRCbQmQAYDP1xmfrzCDaq+iFZlMez8kF5
         xDlF5OMkj2IsPpyf355iA28pzlByuWb0IlHXeRMWhe6Twio8NJIj67ZBvgesIwjPc9jD
         OixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPzr8oFiB9fNElzzDfAoV9vrNYHk5FKfy7JJ4PIAqSE=;
        b=A6AaNpgqMl1lwgAi82GQT0wypYF+9HEhe4PFP1aWtNrrqbbupuvAI1w8ZtUoWqV0MU
         2DSD26MRptxQHlOZvvndCTTmZ2sQwE6pAMmvolSVhhl7BqIKPuGa+9s5ZSpNNlgRC8/p
         oGTrskpTrQolMLRS5GO40bnM6b0YkkF+i+eTBfeU0dPhsG+fy/wrIuTHz/jzN/5LsNRn
         Ntkqy7dNLa4lkVOqyk+uTpPqXLAJCs0q3Xq2lUr7rPckjW/KK446AV5aDLqKOA7FG1e+
         10nVHwphUgU9w52s/H3u+2PsdS58E8U5zS9C6Gb4lW8DNCb/uGT2Yib2L7k17JpBLCvx
         fwzA==
X-Gm-Message-State: AO0yUKUXpgRJTT4r83jtvJ1acmmZg723nRm+xxFz0HRwxPDiVcl9WP4A
        yesZ5DWJre9actpjBcW/lP2AykY9i6feWCdfJSHY0MDBVq5jzTW7
X-Google-Smtp-Source: AK7set/J3QEIzca9ZeSGAD0EnY2yePNuRBAoapV1qPXPpS6dkGzXCjbp2NA254SLfkJPBXsK4Fu6CuDo2QzsnXATQIE=
X-Received: by 2002:a67:ec4f:0:b0:411:c9c5:59ae with SMTP id
 z15-20020a67ec4f000000b00411c9c559aemr6817085vso.5.1678097028919; Mon, 06 Mar
 2023 02:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20230226205319.1013332-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20230226205319.1013332-1-dario.binacchi@amarulasolutions.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 11:03:38 +0100
Message-ID: <CAMRc=MdoMPROUVeu3m9Jx+-5deRMC9jm+zbGBQ=OdHaLApmJ-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: use dynamic allocation of base
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 9:53=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using stat=
ic
> gpiobase allocation"), one or more warnings are printed during boot on
> systems where static allocation of GPIO base is used:
>
> [    1.611480] gpio gpiochip0: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
> [    1.622893] gpio gpiochip1: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
> [    1.633272] gpio gpiochip2: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
> [    1.643388] gpio gpiochip3: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
> [    1.653474] gpio gpiochip4: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
>
> So let's follow the suggestion and use dynamic allocation.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  drivers/gpio/gpio-mxc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 9d0cec4b82a3..abc129a88a62 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -462,8 +462,7 @@ static int mxc_gpio_probe(struct platform_device *pde=
v)
>         port->gc.request =3D gpiochip_generic_request;
>         port->gc.free =3D gpiochip_generic_free;
>         port->gc.to_irq =3D mxc_gpio_to_irq;
> -       port->gc.base =3D (pdev->id < 0) ? of_alias_get_id(np, "gpio") * =
32 :
> -                                            pdev->id * 32;
> +       port->gc.base =3D -1;
>
>         err =3D devm_gpiochip_add_data(&pdev->dev, &port->gc, port);
>         if (err)
> --
> 2.32.0
>

Linus,

I'm afraid we'll need to do something about this warning, because
we're getting the same patch for like 4th time already...

Bart
