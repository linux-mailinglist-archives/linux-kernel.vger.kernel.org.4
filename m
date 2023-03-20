Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908BE6C1D88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjCTRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjCTRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:16:18 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B393FE;
        Mon, 20 Mar 2023 10:12:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i24so13927172qtm.6;
        Mon, 20 Mar 2023 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa45T5JZz/WUqww16pUGPvwtIPF00tMVrhHt9qgdajA=;
        b=Ed+LYNJz3Sa1euGI95Z7a4hBefP8Uj45+u+jxcBldGXUIEvsEkzHRxRm/b/7Koam9c
         RzcC+KEg/5DWcXV3NXBEeFfUSFZUYf8iEyaei+sok6BLpXPC/PkitgJrBr8nWeS6B4UH
         MbSL++o8S5WuN0B/VAZJP/nxrGmdH13IgagPgWaDbNwD444zVrhJlmhFQtLNsZgtcRnA
         I/Waa54TOxTgU3405snDwxTP90y5cZXVtyY9Y9j87t8t/qrXAi6CCj2P0g9acO8RcZdk
         2g8HG97HzRCd7OopwEWQUDul1FlyL9LGcQO4t431bP35bHWTolUHjk0yfO/VdcnpGZ/l
         dXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pa45T5JZz/WUqww16pUGPvwtIPF00tMVrhHt9qgdajA=;
        b=crnSbqzW8o2i7P4MCXBtMytie8axO1DMfAmY0C7IfuamAKzdrm9G/Ea+80a8fbsKQk
         Jk8Bu/WTJybU6dLwpp/DqsAJG/mV6ZeQaYAqmyGJ04wkvcaepae0VOxMF2MYP3xOGQLt
         xHrIVtSp0UiCrTdo3aZOcwfj9SLZz0V7YwZUhTWVfUXnQmdLUOQX4pN+zQrSaa6eTZw1
         g3sP1S8OBUgPxd+ruGw35SwlI4v8onB5SahTMl/Aoiclw+Lo0M0xBKiSp3pdugvYnFyd
         2Gs4SEE3KMVl4YaXh1zxNvV5rPBjCT8hyf/+nmnkyhv0cv4ytHnRaSaKOOT8BOVqNx/w
         2GBQ==
X-Gm-Message-State: AO0yUKW+APito5qW7AkrZo1oHPDUaTk/Ia2ne1xSdmYcF/h4qKQd2a6X
        JtoKMqY6SxNAe1GaWcKJuz9nsyZLMBcerql3k/A=
X-Google-Smtp-Source: AK7set9DzW2OMHqY2H2mFcYxNa42UIbbQl+3io6PZqkwn0Op1nzCw5bBtE2RnU43NIQCvEjm+QVKEMcoXOoeKFL+OlQ=
X-Received: by 2002:ac8:7e84:0:b0:3de:1720:b54b with SMTP id
 w4-20020ac87e84000000b003de1720b54bmr1113qtj.0.1679332276497; Mon, 20 Mar
 2023 10:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230320163823.886-1-clin@suse.com> <20230320163823.886-5-clin@suse.com>
In-Reply-To: <20230320163823.886-5-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 19:10:40 +0200
Message-ID: <CAHp75VfFTjPFMQ91yHC4O1enTJqtww7ur8ppwa1rqT_7WNzDTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pinctrl: s32cc: embed generic struct pingroup and pinfunction
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 6:39=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Use generic data structure to describe pin control functions and groups i=
n
> S32 SoC family and drop duplicated struct members.

Not sure about the need of the casting, see below, otherwise LGTM.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> Changes in v2:
> - Simply use generic 'struct pinfunction' rather than having extra 'struc=
t
>   s32_pmx_func'.
>
>  drivers/pinctrl/nxp/pinctrl-s32.h   | 26 ++--------
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 76 +++++++++++++++--------------
>  2 files changed, 45 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinc=
trl-s32.h
> index 545bf16b988d..2f7aecd462e4 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> @@ -15,31 +15,15 @@ struct platform_device;
>
>  /**
>   * struct s32_pin_group - describes an S32 pin group
> - * @name: the name of this specific pin group
> - * @npins: the number of pins in this group array, i.e. the number of
> - *         elements in pin_ids and pin_sss so we can iterate over that a=
rray
> - * @pin_ids: an array of pin IDs in this group
> - * @pin_sss: an array of source signal select configs paired with pin_id=
s
> + * @data: generic data describes group name, number of pins, and a pin a=
rray in
> +       this group.
> + * @pin_sss: an array of source signal select configs paired with pin ar=
ray.
>   */
>  struct s32_pin_group {
> -       const char *name;
> -       unsigned int npins;
> -       unsigned int *pin_ids;
> +       struct pingroup data;
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
> @@ -56,7 +40,7 @@ struct s32_pinctrl_soc_info {
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
> index cb8a0844c0fa..4ed0cc905232 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -188,7 +188,7 @@ static const char *s32_get_group_name(struct pinctrl_=
dev *pctldev,
>         struct s32_pinctrl *ipctl =3D pinctrl_dev_get_drvdata(pctldev);
>         const struct s32_pinctrl_soc_info *info =3D ipctl->info;
>
> -       return info->groups[selector].name;
> +       return info->groups[selector].data.name;
>  }
>
>  static int s32_get_group_pins(struct pinctrl_dev *pctldev,
> @@ -198,8 +198,8 @@ static int s32_get_group_pins(struct pinctrl_dev *pct=
ldev,
>         struct s32_pinctrl *ipctl =3D pinctrl_dev_get_drvdata(pctldev);
>         const struct s32_pinctrl_soc_info *info =3D ipctl->info;
>
> -       *pins =3D info->groups[selector].pin_ids;
> -       *npins =3D info->groups[selector].npins;
> +       *pins =3D info->groups[selector].data.pins;
> +       *npins =3D info->groups[selector].data.npins;
>
>         return 0;
>  }
> @@ -314,23 +314,23 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev,=
 unsigned int selector,
>         grp =3D &info->groups[group];
>
>         dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
> -               info->functions[selector].name, grp->name);
> +               info->functions[selector].name, grp->data.name);
>
>         /* Check beforehand so we don't have a partial config. */
> -       for (i =3D 0; i < grp->npins; i++) {
> -               if (s32_check_pin(pctldev, grp->pin_ids[i]) !=3D 0) {
> +       for (i =3D 0; i < grp->data.npins; i++) {
> +               if (s32_check_pin(pctldev, grp->data.pins[i]) !=3D 0) {
>                         dev_err(info->dev, "invalid pin: %u in group: %u\=
n",
> -                               grp->pin_ids[i], group);
> +                               grp->data.pins[i], group);
>                         return -EINVAL;
>                 }
>         }
>
> -       for (i =3D 0, ret =3D 0; i < grp->npins && !ret; i++) {
> -               ret =3D s32_regmap_update(pctldev, grp->pin_ids[i],
> +       for (i =3D 0, ret =3D 0; i < grp->data.npins && !ret; i++) {
> +               ret =3D s32_regmap_update(pctldev, grp->data.pins[i],
>                                         S32_MSCR_SSS_MASK, grp->pin_sss[i=
]);
>                 if (ret) {
>                         dev_err(info->dev, "Failed to set pin %u\n",
> -                               grp->pin_ids[i]);
> +                               grp->data.pins[i]);
>                         return ret;
>                 }
>         }
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
> @@ -602,8 +602,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pc=
tldev, unsigned int selecto
>         int i, ret;
>
>         grp =3D &info->groups[selector];
> -       for (i =3D 0; i < grp->npins; i++) {
> -               ret =3D s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
> +       for (i =3D 0; i < grp->data.npins; i++) {
> +               ret =3D s32_pinconf_mscr_update(pctldev, grp->data.pins[i=
],
>                                               configs, num_configs);
>                 if (ret)
>                         return ret;
> @@ -637,9 +637,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl=
_dev *pctldev,
>
>         seq_puts(s, "\n");
>         grp =3D &info->groups[selector];
> -       for (i =3D 0; i < grp->npins; i++) {
> -               name =3D pin_get_name(pctldev, grp->pin_ids[i]);
> -               ret =3D s32_regmap_read(pctldev, grp->pin_ids[i], &config=
);
> +       for (i =3D 0; i < grp->data.npins; i++) {
> +               name =3D pin_get_name(pctldev, grp->data.pins[i]);
> +               ret =3D s32_regmap_read(pctldev, grp->data.pins[i], &conf=
ig);
>                 if (ret)
>                         return;
>                 seq_printf(s, "%s: 0x%x\n", name, config);
> @@ -732,6 +732,7 @@ static int s32_pinctrl_parse_groups(struct device_nod=
e *np,
>         const __be32 *p;
>         struct device *dev;
>         struct property *prop;
> +       unsigned int *pins, *sss;
>         int i, npins;
>         u32 pinmux;
>
> @@ -740,38 +741,38 @@ static int s32_pinctrl_parse_groups(struct device_n=
ode *np,
>         dev_dbg(dev, "group: %pOFn\n", np);
>
>         /* Initialise group */
> -       grp->name =3D np->name;
> +       grp->data.name =3D np->name;
>
>         npins =3D of_property_count_elems_of_size(np, "pinmux", sizeof(u3=
2));
>         if (npins < 0) {
>                 dev_err(dev, "Failed to read 'pinmux' property in node %s=
.\n",
> -                       grp->name);
> +                       grp->data.name);
>                 return -EINVAL;
>         }
>         if (!npins) {
> -               dev_err(dev, "The group %s has no pins.\n", grp->name);
> +               dev_err(dev, "The group %s has no pins.\n", grp->data.nam=
e);
>                 return -EINVAL;
>         }
>
> -       grp->npins =3D npins;
> +       grp->data.npins =3D npins;
>
> -       grp->pin_ids =3D devm_kcalloc(info->dev, grp->npins,
> -                                   sizeof(unsigned int), GFP_KERNEL);
> -       grp->pin_sss =3D devm_kcalloc(info->dev, grp->npins,
> -                                   sizeof(unsigned int), GFP_KERNEL);
> -       if (!grp->pin_ids || !grp->pin_sss)
> +       pins =3D devm_kcalloc(info->dev, npins, sizeof(*pins), GFP_KERNEL=
);
> +       sss =3D devm_kcalloc(info->dev, npins, sizeof(*sss), GFP_KERNEL);
> +       if (!pins || !sss)
>                 return -ENOMEM;
>
>         i =3D 0;
>         of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
> -               grp->pin_ids[i] =3D get_pin_no(pinmux);
> -               grp->pin_sss[i] =3D get_pin_func(pinmux);
> +               pins[i] =3D get_pin_no(pinmux);
> +               sss[i] =3D get_pin_func(pinmux);
>
> -               dev_dbg(info->dev, "pin-id: 0x%x, sss: 0x%x",
> -                       grp->pin_ids[i], grp->pin_sss[i]);
> +               dev_dbg(info->dev, "pin: 0x%x, sss: 0x%x", pins[i], sss[i=
]);
>                 i++;
>         }
>
> +       grp->data.pins =3D pins;
> +       grp->pin_sss =3D sss;
> +
>         return 0;
>  }
>
> @@ -780,8 +781,9 @@ static int s32_pinctrl_parse_functions(struct device_=
node *np,
>                                         u32 index)
>  {
>         struct device_node *child;
> -       struct s32_pmx_func *func;
> +       struct pinfunction *func;
>         struct s32_pin_group *grp;
> +       char **groups;
>         u32 i =3D 0;
>         int ret =3D 0;
>
> @@ -791,18 +793,18 @@ static int s32_pinctrl_parse_functions(struct devic=
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
> -                                   sizeof(*func->groups), GFP_KERNEL);
> -       if (!func->groups)
> +       groups =3D devm_kcalloc(info->dev, func->ngroups,
> +                             sizeof(*func->groups), GFP_KERNEL);
> +       if (!groups)
>                 return -ENOMEM;
>
>         for_each_child_of_node(np, child) {
> -               func->groups[i] =3D child->name;
> +               groups[i] =3D (char *)child->name;
>                 grp =3D &info->groups[info->grp_index++];
>                 ret =3D s32_pinctrl_parse_groups(child, grp, info);
>                 if (ret)
> @@ -810,6 +812,8 @@ static int s32_pinctrl_parse_functions(struct device_=
node *np,
>                 i++;
>         }
>
> +       func->groups =3D (const char **)groups;

Hmm... Why is casting needed?

>         return 0;
>  }

--=20
With Best Regards,
Andy Shevchenko
