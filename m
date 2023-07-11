Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEF74E9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGKJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjGKJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:01:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8AE56;
        Tue, 11 Jul 2023 02:01:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e99584adaso526341a12.0;
        Tue, 11 Jul 2023 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066073; x=1691658073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kuLGXAIsTTibzBcdPpmL9/pco03CrweKAFXxk1FsHM=;
        b=Qr9bGvtc7beXI+iwSSFPqjiTj3S/DCd4PiO0tSP0WpDTlhm/TqmZT0vzoqq7EIX5Ez
         EoyJFOyMORPvWQkYm5n4aFan5gd934+pHWMpiARMTE5n9vvK/Dw1UuWRnLxOMOX2sGFV
         DwtZRvUJkDNF1U/Rnyg8iyT/jOaR4Aq8B8/EmK7pn6Cmkz/ZImheQ8AmjJHjnLDz9hkP
         JTeVlvtxJb9lm4Fu9xV3JAQYGkfDUSUXtEEJm8y3vQ6SIkkvSygo/km7RPONd9+f6l4S
         Mv4/i6nheSMN5hOfK45QOleDCDBlznvaVJU1awZFIklb8HSrIp6FqBc28a+Q3qzgroRX
         fFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066073; x=1691658073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kuLGXAIsTTibzBcdPpmL9/pco03CrweKAFXxk1FsHM=;
        b=D33zVETXaVpCeFmXLvMOYoIpsU4PoWoF6plRCCikwOcKJYfh7ynfsfE5Q214VWWuFN
         g1WufZnroSw9aPj/9lYL1Yrj4Uoq3mySQ1h7pxfXqWn9Oi/W7rp5ncoT7sVU6oRt1pNc
         4w+so0VJ3z2rs2/og2IxpNyLfM5ZrKA/kkOdl6hcnTII9NcZYunwLz1dCaIQ/c9oA5I3
         9wKArJ6FPTcUUdETIjlDh83p/TL2Ty2rzyrwZ0kJgL/DOZK90y/zCONW2pyXbDYVlpEx
         uN8sJ90nAtp5yIuhqg7DH6LPG2/sI9Yd6wU+YJatZ6rt1xMGhquuWkt3L8/goueL2O7N
         f6Zw==
X-Gm-Message-State: ABy/qLakCVt6oAZmpsA87zeiireReUPavdTUwgEiFCYySx8K0z6//H+N
        9Ki+mb6kxXxQJMg6wJIVhbvj+LBorwc9JGCIJgc=
X-Google-Smtp-Source: APBJJlGLwk0NIo3kkjukH7UnrggZhZtuplNGrknTPYOdhpAfIyV9bv6iLDKwyEp+uh6z0es3woRKuRW8eEU0PtFUm7g=
X-Received: by 2002:a17:906:1ecf:b0:982:30e3:ddcb with SMTP id
 m15-20020a1709061ecf00b0098230e3ddcbmr11437923ejj.65.1689066073353; Tue, 11
 Jul 2023 02:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230711072053.2837327-1-geert+renesas@glider.be>
In-Reply-To: <20230711072053.2837327-1-geert+renesas@glider.be>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 12:00:37 +0300
Message-ID: <CAHp75VfqEgysCHK9qFBSOrpQqW68LUA=i4EEYMaM8e1UeMzCMw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Improve PM configuration
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:21=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If CONFIG_PM=3Dn (e.g. m68k/allmodconfig):
>
>     drivers/gpio/gpio-mxc.c:612:12: error: =E2=80=98mxc_gpio_runtime_resu=
me=E2=80=99 defined but not used [-Werror=3Dunused-function]
>       612 | static int mxc_gpio_runtime_resume(struct device *dev)
>           |            ^~~~~~~~~~~~~~~~~~~~~~~
>     drivers/gpio/gpio-mxc.c:602:12: error: =E2=80=98mxc_gpio_runtime_susp=
end=E2=80=99 defined but not used [-Werror=3Dunused-function]
>       602 | static int mxc_gpio_runtime_suspend(struct device *dev)
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
> callbacks, and by wrapping the driver.pm initializer insider pm_ptr().
>
> As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
> __maybe_unused annotations for the noirq callbacks are no longer needed,
> and can be removed.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpio/gpio-mxc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev=
)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> +static int mxc_gpio_noirq_suspend(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(stru=
ct device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> +static int mxc_gpio_noirq_resume(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struc=
t device *dev)
>  }
>
>  static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
> -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_no=
irq_resume)
> -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_res=
ume, NULL)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_=
resume)
> +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume,=
 NULL)
>  };
>
>  static int mxc_gpio_syscore_suspend(void)
> @@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver =3D {
>                 .name   =3D "gpio-mxc",
>                 .of_match_table =3D mxc_gpio_dt_ids,
>                 .suppress_bind_attrs =3D true,
> -               .pm =3D &mxc_gpio_dev_pm_ops,
> +               .pm =3D pm_ptr(&mxc_gpio_dev_pm_ops),
>         },
>         .probe          =3D mxc_gpio_probe,
>  };
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
