Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD46C8088
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjCXO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:57:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593AB2D5F;
        Fri, 24 Mar 2023 07:57:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 59so1699366qva.11;
        Fri, 24 Mar 2023 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhq0CRfZq0jURwtUphmV8M5JVFpy5MqkWwVA+T8Qna4=;
        b=e8tF/vjX8GoVhc/EFVNsx5Q94neeN4v8d+ToiNNFLuiEwnTuzuwHNwqWRVaczIN9iT
         VLZoQgMFiceEuDATvFNEhcXyGgX8XaPr4fgb+CFL/+ECmCCoyyBJGTBTkOcb3uYDqrKR
         HoC/jpXPQyDHfTRmg0+yXsprpeYZhHg2IpCAqBQYJR3PoMh7YFw7Jiwjj7nxjXFr3NSE
         EGKPMGizxHx+k/TzQq16blH5orWSakrifsFvRmQMbmlmrJPsi9bIlsxniFsLyuzwIDYo
         eHzAUAie3pY0XF7NWf0vbA5nFpoR8Rj7HM6Vk/4SoxLD8o6Wbq3ZKTJxXUcsdLMXYe4O
         XBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhq0CRfZq0jURwtUphmV8M5JVFpy5MqkWwVA+T8Qna4=;
        b=Q3oSGyOfmYqIlF5TwY39aBpJY9ZSpVqoVtLuUbfQLoo6lhwAs0H/I3iKtAiyC1X5oH
         4FWDaUqWrpwu7rq0sLJlGCb1Ze9BpV9fD03Mbfvhhio0LKSjd+qQW1tQmneUju3GjT7Z
         r+nwL5IPeqsmfoXd8m92JE8wFe1xbPRjJ9MxcwYsW5hU+TTkMmuNZOEYS7dCSO7E9aRU
         sujl9WNdiEWGapNZg1h8CIR8N3kK2F/urqvl4w2GSXEjazFSlK5WeXuOtrczAtAMdXp5
         jwAF61Z7Oh3z2/HsScfiMkgBi0tEdIijSpdSQvSVW3n1d21/vRz8KzwwPZd5o/DYZaLh
         kedg==
X-Gm-Message-State: AO0yUKWLVk+Z1xgKd6gv62vS+Fag4nrNsVtibsIjE+TDgr1wfDJHsPMx
        oHxBs7vADOpVRHn70/jeOyMCxIY42tZqyR9p9ZY+dac0YoyK8A==
X-Google-Smtp-Source: AK7set8tMGfw8plPGlnIPH7fB1rr8P42QXE3fWz88ZQHh6+kfl9Y6cOJ9g7AFPiFrEMEj6MiDSvVKSooMX8F0CM83/g=
X-Received: by 2002:a05:6214:1870:b0:5a5:1b99:b96b with SMTP id
 eh16-20020a056214187000b005a51b99b96bmr561067qvb.10.1679669857230; Fri, 24
 Mar 2023 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230324143626.16336-1-clin@suse.com> <20230324143626.16336-6-clin@suse.com>
In-Reply-To: <20230324143626.16336-6-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Mar 2023 16:57:01 +0200
Message-ID: <CAHp75VdLd9UCNcMcCiQfR2OTepA+Z1fYQr6aWUuTP=wnNdCpVw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
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

On Fri, Mar 24, 2023 at 4:38=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> The .data field in struct of_device_id is used as a const member so it's
> inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> because some members in s32_pinctrl_soc_info need to be filled by
> pinctrl-s32cc at runtime.
>
> For this reason, struct s32_pinctrl_soc_info must be allocated in
> pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> to represent const .data in of_device_id. To combine these two structures=
,
> a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.
>
> Besides, use of_device_get_match_data() instead of of_match_device() sinc=
e
> the driver only needs to retrieve the .data from of_device_id.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(casting question is minor and can be addressed in v5, if can be done,
or when applying)

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> Changes in v4:
> - Retrieve the matched device data by calling of_device_get_match_data()
>   and remove unnecessary type casting. (Merged from the previous v3 serie=
s
>   [PATCH v3 1/6])
>
>  drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
>  drivers/pinctrl/nxp/pinctrl-s32g2.c | 13 +++++--------
>  3 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinc=
trl-s32.h
> index 2f7aecd462e4..add3c77ddfed 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> @@ -34,24 +34,28 @@ struct s32_pin_range {
>         unsigned int end;
>  };
>
> -struct s32_pinctrl_soc_info {
> -       struct device *dev;
> +struct s32_pinctrl_soc_data {
>         const struct pinctrl_pin_desc *pins;
>         unsigned int npins;
> +       const struct s32_pin_range *mem_pin_ranges;
> +       unsigned int mem_regions;
> +};
> +
> +struct s32_pinctrl_soc_info {
> +       struct device *dev;
> +       const struct s32_pinctrl_soc_data *soc_data;
>         struct s32_pin_group *groups;
>         unsigned int ngroups;
>         struct pinfunction *functions;
>         unsigned int nfunctions;
>         unsigned int grp_index;
> -       const struct s32_pin_range *mem_pin_ranges;
> -       unsigned int mem_regions;
>  };
>
>  #define S32_PINCTRL_PIN(pin)   PINCTRL_PIN(pin, #pin)
>  #define S32_PIN_RANGE(_start, _end) { .start =3D _start, .end =3D _end }
>
>  int s32_pinctrl_probe(struct platform_device *pdev,
> -                       struct s32_pinctrl_soc_info *info);
> +                     const struct s32_pinctrl_soc_data *soc_data);
>  int s32_pinctrl_resume(struct device *dev);
>  int s32_pinctrl_suspend(struct device *dev);
>  #endif /* __DRIVERS_PINCTRL_S32_H */
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pi=
nctrl-s32cc.c
> index 8373468719b6..41e024160f36 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -106,7 +106,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned =
int pin)
>  {
>         struct s32_pinctrl *ipctl =3D pinctrl_dev_get_drvdata(pctldev);
>         const struct s32_pin_range *pin_range;
> -       unsigned int mem_regions =3D ipctl->info->mem_regions;
> +       unsigned int mem_regions =3D ipctl->info->soc_data->mem_regions;
>         unsigned int i;
>
>         for (i =3D 0; i < mem_regions; i++) {
> @@ -688,8 +688,8 @@ int s32_pinctrl_suspend(struct device *dev)
>         int ret;
>         unsigned int config;
>
> -       for (i =3D 0; i < info->npins; i++) {
> -               pin =3D &info->pins[i];
> +       for (i =3D 0; i < info->soc_data->npins; i++) {
> +               pin =3D &info->soc_data->pins[i];
>
>                 if (!s32_pinctrl_should_save(ipctl, pin->number))
>                         continue;
> @@ -713,8 +713,8 @@ int s32_pinctrl_resume(struct device *dev)
>         struct s32_pinctrl_context *saved_context =3D &ipctl->saved_conte=
xt;
>         int ret, i;
>
> -       for (i =3D 0; i < info->npins; i++) {
> -               pin =3D &info->pins[i];
> +       for (i =3D 0; i < info->soc_data->npins; i++) {
> +               pin =3D &info->soc_data->pins[i];
>
>                 if (!s32_pinctrl_should_save(ipctl, pin->number))
>                         continue;
> @@ -831,7 +831,7 @@ static int s32_pinctrl_probe_dt(struct platform_devic=
e *pdev,
>         struct resource *res;
>         struct regmap *map;
>         void __iomem *base;
> -       int mem_regions =3D info->mem_regions;
> +       unsigned int mem_regions =3D info->soc_data->mem_regions;
>         int ret;
>         u32 nfuncs =3D 0;
>         u32 i =3D 0;
> @@ -869,7 +869,7 @@ static int s32_pinctrl_probe_dt(struct platform_devic=
e *pdev,
>                 }
>
>                 ipctl->regions[i].map =3D map;
> -               ipctl->regions[i].pin_range =3D &info->mem_pin_ranges[i];
> +               ipctl->regions[i].pin_range =3D &info->soc_data->mem_pin_=
ranges[i];
>         }
>
>         nfuncs =3D of_get_child_count(np);
> @@ -904,20 +904,26 @@ static int s32_pinctrl_probe_dt(struct platform_dev=
ice *pdev,
>  }
>
>  int s32_pinctrl_probe(struct platform_device *pdev,
> -                     struct s32_pinctrl_soc_info *info)
> +                     const struct s32_pinctrl_soc_data *soc_data)
>  {
>         struct s32_pinctrl *ipctl;
>         int ret;
>         struct pinctrl_desc *s32_pinctrl_desc;
> +       struct s32_pinctrl_soc_info *info;
>  #ifdef CONFIG_PM_SLEEP
>         struct s32_pinctrl_context *saved_context;
>  #endif
>
> -       if (!info || !info->pins || !info->npins) {
> +       if (!soc_data || !soc_data->pins || !soc_data->npins) {
>                 dev_err(&pdev->dev, "wrong pinctrl info\n");
>                 return -EINVAL;
>         }
>
> +       info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->soc_data =3D soc_data;
>         info->dev =3D &pdev->dev;
>
>         /* Create state holders etc for this driver */
> @@ -938,8 +944,8 @@ int s32_pinctrl_probe(struct platform_device *pdev,
>                 return -ENOMEM;
>
>         s32_pinctrl_desc->name =3D dev_name(&pdev->dev);
> -       s32_pinctrl_desc->pins =3D info->pins;
> -       s32_pinctrl_desc->npins =3D info->npins;
> +       s32_pinctrl_desc->pins =3D info->soc_data->pins;
> +       s32_pinctrl_desc->npins =3D info->soc_data->npins;
>         s32_pinctrl_desc->pctlops =3D &s32_pctrl_ops;
>         s32_pinctrl_desc->pmxops =3D &s32_pmx_ops;
>         s32_pinctrl_desc->confops =3D &s32_pinconf_ops;
> @@ -960,7 +966,7 @@ int s32_pinctrl_probe(struct platform_device *pdev,
>  #ifdef CONFIG_PM_SLEEP
>         saved_context =3D &ipctl->saved_context;
>         saved_context->pads =3D
> -               devm_kcalloc(&pdev->dev, info->npins,
> +               devm_kcalloc(&pdev->dev, info->soc_data->npins,
>                              sizeof(*saved_context->pads),
>                              GFP_KERNEL);
>         if (!saved_context->pads)
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pi=
nctrl-s32g2.c
> index d9f3ff6794ea..e0944c071c8c 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> @@ -721,7 +721,7 @@ static const struct s32_pin_range s32_pin_ranges_siul=
2[] =3D {
>         S32_PIN_RANGE(942, 1007),
>  };
>
> -static struct s32_pinctrl_soc_info s32_pinctrl_info =3D {
> +static struct s32_pinctrl_soc_data s32_pinctrl_data =3D {
>         .pins =3D s32_pinctrl_pads_siul2,
>         .npins =3D ARRAY_SIZE(s32_pinctrl_pads_siul2),
>         .mem_pin_ranges =3D s32_pin_ranges_siul2,
> @@ -732,7 +732,7 @@ static const struct of_device_id s32_pinctrl_of_match=
[] =3D {
>         {
>
>                 .compatible =3D "nxp,s32g2-siul2-pinctrl",
> -               .data =3D (void *) &s32_pinctrl_info,
> +               .data =3D (void *) &s32_pinctrl_data,
>         },
>         { /* sentinel */ }
>  };
> @@ -740,14 +740,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
>
>  static int s32g_pinctrl_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =3D
> -               of_match_device(s32_pinctrl_of_match, &pdev->dev);
> +       const struct s32_pinctrl_soc_data *soc_data;
>
> -       if (!of_id)
> -               return -ENODEV;
> +       soc_data =3D of_device_get_match_data(&pdev->dev);
>
> -       return s32_pinctrl_probe
> -                       (pdev, (struct s32_pinctrl_soc_info *) of_id->dat=
a);
> +       return s32_pinctrl_probe(pdev, soc_data);
>  }
>
>  static const struct dev_pm_ops s32g_pinctrl_pm_ops =3D {
> --
> 2.37.3
>


--=20
With Best Regards,
Andy Shevchenko
