Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1369B668
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBQXWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBQXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:22:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CE5F269
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:22:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m13so1409537pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676676167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp0LGpjYzO/wQ9ZofO0IRZ1ED/HKTJwiOg1DwBrCimM=;
        b=NdK9YgJuCiRBPef42LxjEXowdPk2FNt7IFRfxwrka182KEunsBMkBxz2q5Xx6jkUyt
         F5bSIeHYtNDZh7wDkOMX4DPh9yCEeN44tSosIh6FDoJN2FDDkyOYHhbP4dpyBu+tEZEI
         yNnsFXGQgQwF9HtBXm+NMXfGqCYHNokqjDwCiNkFmmX3rX6wkbZWQ8LGqxRpUwry9E2v
         bIGr57rdbVa7GejjmMnXxUCuC2V8bqAWCe01TtCBBtvaI/C6HMyHV0vVurHHz4zEMSBq
         A6QMl4ztxIO9wlrurOcNFBZLD+xq+I8wsx6+WDAQJml6uhGA9kKvRl4UGeXzfrGKX7Ra
         RR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676676167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp0LGpjYzO/wQ9ZofO0IRZ1ED/HKTJwiOg1DwBrCimM=;
        b=jhkCLL/bGjhqPT1H2ZET+lzplcHlFNVMaA/T/0ZmDzj2E1GjtOdvC/ViU9eEon47lI
         QJNlxTjcRHa0TAmyEWjMXNbYVbuj35o+ba/TXaQUuc28Xymzcgbg5vP5XJhb+GN4b+3D
         OK8V56CWzE+lkQf0h6nGJ3fge0JFmhUTu9aPSmAynEji1Dqxhun22xadig6NnuAO58Dk
         7Q6bu+gC/SdMuxd7zclh63qayZs4hQJh7CK8jqcCX+ZYKlO+fIWsv8/cULAICgBfxMYx
         l2FhWM5xrio0ApPK+A9DGD3JHHKJpAddSAa00VHXXFeJ5VnRMkLCeIszC6wjtU2pzUW1
         3MKw==
X-Gm-Message-State: AO0yUKWIz7y1rsjF65XJyvq6ua3BP/dbdhCcEOAwdN/EO/sYl2PSn/C7
        AeCljCwv9nolTT/dD+9S7abkbrKfyJgEt5rc6dsN+g==
X-Google-Smtp-Source: AK7set/Ex/ecKPrR1luvpvNS73pruiK8LWXsXHD5h8XUEHu9Li0cAuOYgCrUqfiDSq8tL5kWg9fU4wNtM7sMcvZ4W60=
X-Received: by 2002:aa7:980f:0:b0:5a8:4dea:7015 with SMTP id
 e15-20020aa7980f000000b005a84dea7015mr132186pfl.36.1676676167036; Fri, 17 Feb
 2023 15:22:47 -0800 (PST)
MIME-Version: 1.0
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com> <20220825212842.7176-1-christian@kohlschutter.com>
In-Reply-To: <20220825212842.7176-1-christian@kohlschutter.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Feb 2023 15:22:10 -0800
Message-ID: <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     broonie@kernel.org, m.szyprowski@samsung.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, m.reichl@fivetechno.de,
        robin.murphy@arm.com, vincent.legoll@gmail.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.
>
> This in turn may initialize the regulator twice, leading to voltage
> glitches that are timing-dependent. A simple, unrelated configuration
> change may be enough to hide this problem, only to be surfaced by
> chance.

In your case, can you elaborate which part of the constraints/init
twice caused the issue?

I'm trying to simplify some of the supply resolving code and I'm
trying to not break your use case.

-Saravana

>
> One such example is the SD-Card voltage regulator in a NanoPI R4S that
> would not initialize reliably unless the registration flow was just
> complex enough to allow the regulator to properly reset between calls.
>
> Fix this by re-arranging regulator_register, trying resolve the
> regulator's supply early enough that set_machine_constraints does not
> need to be called twice.
>
> Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> ---
>  drivers/regulator/core.c | 58 ++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 77f60eef960..2ff0ab2730f 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5391,6 +5391,7 @@ regulator_register(const struct regulator_desc *reg=
ulator_desc,
>         bool dangling_of_gpiod =3D false;
>         struct device *dev;
>         int ret, i;
> +       bool resolved_early =3D false;
>
>         if (cfg =3D=3D NULL)
>                 return ERR_PTR(-EINVAL);
> @@ -5494,24 +5495,10 @@ regulator_register(const struct regulator_desc *r=
egulator_desc,
>         BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
>         INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
>
> -       /* preform any regulator specific init */
> -       if (init_data && init_data->regulator_init) {
> -               ret =3D init_data->regulator_init(rdev->reg_data);
> -               if (ret < 0)
> -                       goto clean;
> -       }
> -
> -       if (config->ena_gpiod) {
> -               ret =3D regulator_ena_gpio_request(rdev, config);
> -               if (ret !=3D 0) {
> -                       rdev_err(rdev, "Failed to request enable GPIO: %p=
e\n",
> -                                ERR_PTR(ret));
> -                       goto clean;
> -               }
> -               /* The regulator core took over the GPIO descriptor */
> -               dangling_cfg_gpiod =3D false;
> -               dangling_of_gpiod =3D false;
> -       }
> +       if (init_data && init_data->supply_regulator)
> +               rdev->supply_name =3D init_data->supply_regulator;
> +       else if (regulator_desc->supply_name)
> +               rdev->supply_name =3D regulator_desc->supply_name;
>
>         /* register with sysfs */
>         rdev->dev.class =3D &regulator_class;
> @@ -5533,13 +5520,38 @@ regulator_register(const struct regulator_desc *r=
egulator_desc,
>                 goto wash;
>         }
>
> -       if (init_data && init_data->supply_regulator)
> -               rdev->supply_name =3D init_data->supply_regulator;
> -       else if (regulator_desc->supply_name)
> -               rdev->supply_name =3D regulator_desc->supply_name;
> +       if ((rdev->supply_name && !rdev->supply) &&
> +               (rdev->constraints->always_on ||
> +                rdev->constraints->boot_on)) {
> +               ret =3D regulator_resolve_supply(rdev);
> +               if (ret !=3D 0)
> +                       rdev_dbg(rdev, "Unable to resolve supply early: %=
pe\n",
> +                                ERR_PTR(ret));
> +
> +               resolved_early =3D true;
> +       }
> +
> +       /* perform any regulator specific init */
> +       if (init_data && init_data->regulator_init) {
> +               ret =3D init_data->regulator_init(rdev->reg_data);
> +               if (ret < 0)
> +                       goto wash;
> +       }
> +
> +       if (config->ena_gpiod) {
> +               ret =3D regulator_ena_gpio_request(rdev, config);
> +               if (ret !=3D 0) {
> +                       rdev_err(rdev, "Failed to request enable GPIO: %p=
e\n",
> +                                        ERR_PTR(ret));
> +                       goto wash;
> +               }
> +               /* The regulator core took over the GPIO descriptor */
> +               dangling_cfg_gpiod =3D false;
> +               dangling_of_gpiod =3D false;
> +       }
>
>         ret =3D set_machine_constraints(rdev);
> -       if (ret =3D=3D -EPROBE_DEFER) {
> +       if (ret =3D=3D -EPROBE_DEFER && !resolved_early) {
>                 /* Regulator might be in bypass mode and so needs its sup=
ply
>                  * to set the constraints
>                  */
> --
> 2.36.2
>
>
