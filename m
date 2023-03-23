Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303C6C7087
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCWSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:49:55 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DC72887E;
        Thu, 23 Mar 2023 11:49:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id cu36so11014595vsb.7;
        Thu, 23 Mar 2023 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncX8iuqCgbqtJzMgPUPEHF36WyRojpiwD54nsqA/TSM=;
        b=Y6qbUgEKHn+oxb9buZaR78gFvNl9rTwMxRkXd6zX3MwoWrDAWPCDEeux/8G+qAFYS4
         d2j2oe0k21G7vvzaeWDK2tffYUd19TlN9BiGv8CgnGmPH5r1gdCOSkY1ZFPoLn2oGsbW
         /qt5oCGz8WAPvO/BQCHunLNur8g4wnGFDRcWPM3g77R8bDT5qS6FDigP0njEFHc1mYnI
         bsym6xWfmMBC8JAXEVlDmcS0wEnFV7u29jbhOvFXTgt7y81GkiO2fJsUdZgwQiuayFg3
         plC6H4T4K8vfZR6e+n8lBvGRpNH39knNIdnzXdMzHAb4iMV01XyywIWjdrneKzTQGoGb
         cNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncX8iuqCgbqtJzMgPUPEHF36WyRojpiwD54nsqA/TSM=;
        b=iOeZ4LasmyNcVaAdiIzj+7RSAgjb5v6klMiW1n2YBj3JEkIqbY+F8yj+mdDI6jO2GU
         q1E0ngyrwjJ2u8Y+paliERX7SZeTKu3C/Uh+7TK6HI5fEdrqZQFAfeQ6VQ/+mBlNaNXP
         Bil9I7/QE8IxwczxHmce1Rr4b1FPj27eS0TxwyOddXMeKEQfFd1iXooHMShtEC+U3DsG
         kh0tEIQ2oc0VAam8Q1RLvkLt5fBnF3jqdD6bXL17xXzlRuKT4eb6T1BtHrNrBL7KpwlS
         LOI2pOOL0xhx8HG+Yk744+oHcefJwtxnmnhw3m2Z4JaaU9/tjYf4QJelNTP5N+myzjq4
         wwAA==
X-Gm-Message-State: AO0yUKVlpKp/r4MBd6T19wh/HBI6j++fYHQv7c3hekobTgpG4suksW4c
        qsb5XIdxe48GekMs8/T75Eufu5BIs5mF1qqZ6V7a59+1llo=
X-Google-Smtp-Source: AK7set9ar+rqlol3nFwlTx8Fiw9JLSTiZasb66JIGqWd104vRvIu9rVxuftxdl4EAr/ItIIX0Rwou3wIC2YhQHr+1YU=
X-Received: by 2002:a67:c31c:0:b0:425:e372:e0e4 with SMTP id
 r28-20020a67c31c000000b00425e372e0e4mr2358622vsj.4.1679597393800; Thu, 23 Mar
 2023 11:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230323144833.28562-1-clin@suse.com> <20230323144833.28562-6-clin@suse.com>
In-Reply-To: <20230323144833.28562-6-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Mar 2023 20:49:17 +0200
Message-ID: <CAHp75VeC_xv3C2b4xQB98=pLdUT_pQf_OF5O1fSjXud9W8ptXg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] pinctrl: s32cc: Use generic struct data to
 describe pin function
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
> Replace struct s32_pmx_func with generic struct pinfunction since they
> have the same data fields.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> Changes in v3:
> - Separate the generic pinfunction patch from [PATCH v2 4/4]
> - Fix the data type declaration and remove unncessary type casting
>   developed in v2.
>
>  drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +-------------
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 18 +++++++++++-------
>  2 files changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinc=
trl-s32.h
> index 850cd668f406..2f7aecd462e4 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> @@ -24,18 +24,6 @@ struct s32_pin_group {
>         unsigned int *pin_sss;
>  };
>
> -/**
> - * struct s32_pmx_func - describes S32 pinmux functions
> - * @name: the name of this specific function
> - * @groups: corresponding pin groups
> - * @num_groups: the number of groups
> - */
> -struct s32_pmx_func {
> -       const char *name;
> -       const char **groups;
> -       unsigned int num_groups;
> -};
> -
>  /**
>   * struct s32_pin_range - pin ID range for each memory region.
>   * @start: start pin ID
> @@ -52,7 +40,7 @@ struct s32_pinctrl_soc_info {
>         unsigned int npins;
>         struct s32_pin_group *groups;
>         unsigned int ngroups;
> -       struct s32_pmx_func *functions;
> +       struct pinfunction *functions;
>         unsigned int nfunctions;
>         unsigned int grp_index;
>         const struct s32_pin_range *mem_pin_ranges;
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pi=
nctrl-s32cc.c
> index e65c88162d7f..8373468719b6 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -364,7 +364,7 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pct=
ldev,
>         const struct s32_pinctrl_soc_info *info =3D ipctl->info;
>
>         *groups =3D info->functions[selector].groups;
> -       *num_groups =3D info->functions[selector].num_groups;
> +       *num_groups =3D info->functions[selector].ngroups;
>
>         return 0;
>  }
> @@ -785,8 +785,9 @@ static int s32_pinctrl_parse_functions(struct device_=
node *np,
>                                         u32 index)
>  {
>         struct device_node *child;
> -       struct s32_pmx_func *func;
> +       struct pinfunction *func;
>         struct s32_pin_group *grp;
> +       const char **groups;
>         u32 i =3D 0;
>         int ret =3D 0;
>
> @@ -796,18 +797,19 @@ static int s32_pinctrl_parse_functions(struct devic=
e_node *np,
>
>         /* Initialise function */
>         func->name =3D np->name;
> -       func->num_groups =3D of_get_child_count(np);
> -       if (func->num_groups =3D=3D 0) {
> +       func->ngroups =3D of_get_child_count(np);
> +       if (func->ngroups =3D=3D 0) {
>                 dev_err(info->dev, "no groups defined in %pOF\n", np);
>                 return -EINVAL;
>         }
> -       func->groups =3D devm_kcalloc(info->dev, func->num_groups,
> +
> +       groups =3D devm_kcalloc(info->dev, func->ngroups,
>                                     sizeof(*func->groups), GFP_KERNEL);
> -       if (!func->groups)
> +       if (!groups)
>                 return -ENOMEM;
>
>         for_each_child_of_node(np, child) {
> -               func->groups[i] =3D child->name;
> +               groups[i] =3D child->name;
>                 grp =3D &info->groups[info->grp_index++];
>                 ret =3D s32_pinctrl_parse_groups(child, grp, info);
>                 if (ret)
> @@ -815,6 +817,8 @@ static int s32_pinctrl_parse_functions(struct device_=
node *np,
>                 i++;
>         }
>
> +       func->groups =3D groups;
> +
>         return 0;
>  }
>
> --
> 2.37.3
>


--=20
With Best Regards,
Andy Shevchenko
