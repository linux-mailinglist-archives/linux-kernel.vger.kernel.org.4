Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E0750412
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGLKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGLKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:04:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2410F2;
        Wed, 12 Jul 2023 03:04:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so10530269e87.1;
        Wed, 12 Jul 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689156278; x=1691748278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg3PIZLxcmLPbTTz3barqLxpgo7A/s+2KALDE1Wf9vU=;
        b=ooerHfqDoFsg4m/SdmiYQ0dnFloeSITdEKTng/HddATq2I/D/J6ZC+Kn/GhSINvKz1
         KCfJUEG3kl8uPA7khfxmjtwUsaMV+pb55KaIUergK+sB2zLaQSydH31fkK9wyAZ9qPtO
         WlaBK2gZD5sDEp2lEMZxVnsRqCUL6pKaDafT+4y59vLar23tFKSc6KMGq+R9boYvcaLn
         WN0QOWGjlIXGG8KJl3XLKpUUtsWaRML4qu2iMmVeMFSIAen6H85GcTAKP3r9Lh2tKmoC
         lckAQPTaAYKxNuarzDG+EzRwls+IYDQ+pDOcMadp4w582zV71e5ILwKlIEz+f4bysOlq
         iFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689156278; x=1691748278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg3PIZLxcmLPbTTz3barqLxpgo7A/s+2KALDE1Wf9vU=;
        b=ANOTbmVRpO+KmtprdCza/q5hX//jnWGt0lp84C2xzL0J38LYkEkl+e3uNGyvqhvRRG
         AHv9we1bLopV0HeaU8fd0uPQUKaSneJPK8hF9NLDyjEMX/55SEt6bVgIk6nCi4X5GhrK
         R13FURqoXcKh6oUOOJYhO0xykYStNMyfOVciV23Ycu5aLbJkPyVuCK21y4kF2VyApFWL
         Q+B2SVsIjnylmbB35m/OtFsFcVjoNFWL6+BHWGUOyorlk96/PO/sRTkoGGAzFpTZ93fu
         rrJ1OURjNLqn/9zJucjrSUoMFvZ+pWeNITOJibTnIH3QjOZk4p+R4MOcELDrSDNiIff/
         NHrg==
X-Gm-Message-State: ABy/qLYA/8vAoN9rv0Talk9dNl16uskAYWy2h6F+6ozkWeGZU+WqZFGy
        /nYtzENG7Gkkwx0nibPZrnu2z1dfZYoRzcdCgBI=
X-Google-Smtp-Source: APBJJlHCb1OyVyj4iCM3rCz4GjPXUmdoYSdObwbNJFLAhqgHTrXSad/in6TH4twTTTCDSnlGaEVe2nIl0pINFk+BJZo=
X-Received: by 2002:a05:6512:1108:b0:4f4:dbcc:54da with SMTP id
 l8-20020a056512110800b004f4dbcc54damr17321858lfg.27.1689156277984; Wed, 12
 Jul 2023 03:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094857.218105-1-alex@shruggie.ro>
In-Reply-To: <20230712094857.218105-1-alex@shruggie.ro>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Jul 2023 13:04:01 +0300
Message-ID: <CAHp75VenLV_+LMvxRcpdRGN5eBK9+ZBoGLaOox+XpOvaUP5Csw@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74xx-mmio: remove unneeded platform_set_drvdata() call
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:49=E2=80=AFPM Alexandru Ardelean <alex@shruggie.=
ro> wrote:
>
> The platform_set_drvdata() was needed when the driver had an explicit
> remove function.
> That function got removed a while back, so we don't need to keep a pointe=
r
> (on 'dev->driver_data') for the private data of the driver anymore.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/gpio/gpio-74xx-mmio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.=
c
> index 0464f1ecd20d..c7ac5a9ffb1f 100644
> --- a/drivers/gpio/gpio-74xx-mmio.c
> +++ b/drivers/gpio/gpio-74xx-mmio.c
> @@ -135,8 +135,6 @@ static int mmio_74xx_gpio_probe(struct platform_devic=
e *pdev)
>         priv->gc.ngpio =3D MMIO_74XX_BIT_CNT(priv->flags);
>         priv->gc.owner =3D THIS_MODULE;
>
> -       platform_set_drvdata(pdev, priv);
> -
>         return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
>  }
>
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
