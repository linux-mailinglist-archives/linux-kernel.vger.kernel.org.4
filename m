Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350846C7070
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjCWSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:45:06 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7DFF24;
        Thu, 23 Mar 2023 11:45:05 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e12so10745619uaa.3;
        Thu, 23 Mar 2023 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBDC4YqSAlgVBo8jKYk3v5jKYzycCpJsqxMwBoNPQHc=;
        b=UDQUaTiM3Ol49YOYEaeIUV8i6kXJ0/rUqSHOrix46bMOBVgNbpsJgfUBoEx9iPVV4b
         rKGEJQ8MwG16gdGoO+RXiL+uX5MbOGczBKE3HmK2zTcpkQaGSOtEDVMgGWHTT6w/7JiM
         iXMR44j6znM3JDjoywrdSnqYB37yHgOIHsQr5HSH2ubU7RyF6RAyYhgDoCjnruC9Vci6
         w7mpg14fB0pTc/3HWWeL0QzgPxDim7rW9u9L6L6861mnOKBDC+4Io9OFZ7+u+0t9JltE
         wrWb1+DPFoCp6Mpo3w0RXX7w7t2AmUQ1vjsQJtt1LE+7u2wiO98o0rfTUQzmvawKo6V2
         vsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBDC4YqSAlgVBo8jKYk3v5jKYzycCpJsqxMwBoNPQHc=;
        b=T6PcskDLgjf0INWY7/lW+MGSNse4bxWjdETj7U5fFECXDfRmt4QNipdRnp9A06KdMF
         WHYSVW4ezYcUtHcovAhjfh0KpeFVmwGoEXUamuxr4fNcgV32GNX+fxL4EiC5TS6iP0Ec
         dA9VKh8djog1GA0lBiSpGYNrIprrQnOjgbff3tE4MChwzWxdg/qMmWyqbhAbR31gLUQ2
         ZCqIDnJjxL7pasqTjtx6xFWBO0UvqRXHErPv0nyHuEiJPwCe47M/kGwhlf9J6mdqU/lf
         KHb54FeA8R2DiTdMqa+UI8jz7cTk74IftFueborQYMJf+fM8TbsFmknRF0raoYZTamfD
         ikQQ==
X-Gm-Message-State: AAQBX9eiXaxUSfI3tKIk1IlJCZyvJUa8V9K3LCqlFu/8oTCUl7L9o1n+
        AfFCjEaFlJWeAq0kI/Ayq8GnK0FEN2+gniZanqg=
X-Google-Smtp-Source: AKy350YeNXJkSX/tlhFD+Slv47JiiTHx1k8LWpgsM0iesU7f43QZt8XyntJ5ViDjN245LJNzev8d1Ai3xZ7oRFvEaxk=
X-Received: by 2002:a1f:2d56:0:b0:439:d3e1:112b with SMTP id
 t83-20020a1f2d56000000b00439d3e1112bmr385078vkt.0.1679597104229; Thu, 23 Mar
 2023 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230323144833.28562-1-clin@suse.com> <20230323144833.28562-4-clin@suse.com>
In-Reply-To: <20230323144833.28562-4-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Mar 2023 20:44:28 +0200
Message-ID: <CAHp75Vfue6TNNbNh8b_fCFKF7+rACd=hgXdoQd7drfojDWOvUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] pinctrl: s32cc: refactor pin config parsing
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 4:49=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Move common codes into smaller inline functions and remove argument check=
s
> that are not actually used by pull up/down bits in S32 MSCR register.

in the S32

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> Changes v3:
> - Move the PIN_CONFIG_BIAS_DISABLE case to be with PU and PD cases since
>   they have the same function call.
> - Roll back the argument checks of OUTPUT_ENABLE and INPUT_ENABLE cases
>   since they were wrongly removed with the PU & PD parts in v2.
>
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 52 ++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pi=
nctrl-s32cc.c
> index f698e1a240ef..36f323f87785 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -474,11 +474,38 @@ static int s32_get_slew_regval(int arg)
>         return -EINVAL;
>  }
>
> -static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
> -                           unsigned int *mask, unsigned int *config)
> +static inline void s32_pin_set_pull(enum pin_config_param param,
> +                                  unsigned int *mask, unsigned int *conf=
ig)
>  {
> +       switch (param) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +       case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +               *config &=3D ~(S32_MSCR_PUS | S32_MSCR_PUE);
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +               *config |=3D S32_MSCR_PUS | S32_MSCR_PUE;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               *config &=3D ~S32_MSCR_PUS;
> +               *config |=3D S32_MSCR_PUE;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       *mask |=3D S32_MSCR_PUS | S32_MSCR_PUE;
> +}
> +
> +static int s32_parse_pincfg(unsigned long pincfg, unsigned int *mask,
> +                           unsigned int *config)
> +{
> +       enum pin_config_param param;
> +       u32 arg;
>         int ret;
>
> +       param =3D pinconf_to_config_param(pincfg);
> +       arg =3D pinconf_to_config_argument(pincfg);
> +
>         switch (param) {
>         /* All pins are persistent over suspend */
>         case PIN_CONFIG_PERSIST_STATE:
> @@ -508,26 +535,15 @@ static int s32_get_pin_conf(enum pin_config_param p=
aram, u32 arg,
>                 *config |=3D S32_MSCR_SRE((u32)ret);
>                 *mask |=3D S32_MSCR_SRE(~0);
>                 break;
> +       case PIN_CONFIG_BIAS_DISABLE:
>         case PIN_CONFIG_BIAS_PULL_UP:
> -               if (arg)
> -                       *config |=3D S32_MSCR_PUS;
> -               else
> -                       *config &=3D ~S32_MSCR_PUS;
> -               fallthrough;
>         case PIN_CONFIG_BIAS_PULL_DOWN:
> -               if (arg)
> -                       *config |=3D S32_MSCR_PUE;
> -               else
> -                       *config &=3D ~S32_MSCR_PUE;
> -               *mask |=3D S32_MSCR_PUE | S32_MSCR_PUS;
> +               s32_pin_set_pull(param, mask, config);
>                 break;
>         case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>                 *config &=3D ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE=
);
>                 *mask |=3D S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> -               fallthrough;
> -       case PIN_CONFIG_BIAS_DISABLE:
> -               *config &=3D ~(S32_MSCR_PUS | S32_MSCR_PUE);
> -               *mask |=3D S32_MSCR_PUS | S32_MSCR_PUE;
> +               s32_pin_set_pull(param, mask, config);
>                 break;
>         default:
>                 return -EOPNOTSUPP;
> @@ -553,9 +569,7 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev=
 *pctldev,
>                 pin_get_name(pctldev, pin_id), num_configs);
>
>         for (i =3D 0; i < num_configs; i++) {
> -               ret =3D s32_get_pin_conf(pinconf_to_config_param(configs[=
i]),
> -                                      pinconf_to_config_argument(configs=
[i]),
> -                                      &mask, &config);
> +               ret =3D s32_parse_pincfg(configs[i], &mask, &config);
>                 if (ret)
>                         return ret;
>         }
> --
> 2.37.3
>


--=20
With Best Regards,
Andy Shevchenko
