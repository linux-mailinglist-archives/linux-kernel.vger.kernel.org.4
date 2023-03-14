Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC66B9C82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCNRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:09:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E3901C;
        Tue, 14 Mar 2023 10:09:22 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m6so3183856qvq.0;
        Tue, 14 Mar 2023 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678813761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRZnXIf/Dj2IuHvY6UPkGbuOZa89NHGLlrypBrVe4MM=;
        b=e5mbCRdQ46OHv04KyBBIduN4S81YAfM/hsglTQDHSckjeCG4orbX0RwjHXavRHdwGZ
         Zq+Crh+eb+QBSpSMND4/xxP7pVyBECI8I31N0YTaEoaGIKTdtX7AlUvTRNCP/kCp+8vn
         +4qgIurb+kfjFEFP0AXj+q1SZNDfd+h/uK9lNsrJqSa0jk1z5COSvOQanrkh2u7fpe5H
         gFxKqjubB8nZ1QJyUkrp1duRFng+XsjGc2vTy2A7EOn8ohkwejsFaubA0QjjHl35UA/3
         R3e4B6uHTqtVHAp/ZEtqs7rY0VqRbH9Gg94faAhgx6nTG2QfhieR+UWlxN3U7sfvl1eZ
         JMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678813761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRZnXIf/Dj2IuHvY6UPkGbuOZa89NHGLlrypBrVe4MM=;
        b=QglhSYNFU1hJq/tzEM8f2fVKkvWixjW/E/qrE+GO44qLR+z2cjyBplLHfQlb1JfrNQ
         TnuJKaZqraNl6j88vkNtyuj5Kvsd0SZ7lD3jqZpQQy9DoMxM2S7OUJW3HflKq/8Urtwf
         yTB6GovP0+x67//kN5rYd0/38B1zOLImY+mqzbR7vc8KFZmGibMCRhBW2ROp5d3y7H0O
         dKx+xy2VtD19sWCuwQdGzmaj8w31A6GXH7nDJeyA4l2w+q+4j277lqmSGfoY3bnKrzYO
         0AnSskLRPW/Rac8bLoRAMphQM6Fwq0l1NHAn+gcnL8QvSdw3FMqi0vfC/l/ttP7tod+d
         4bHQ==
X-Gm-Message-State: AO0yUKXXqkDjLLOOqna/Th6dFwPHhGR9DPRvXHUrdF0Ecc8jRUxf40/C
        8NpCb3OUKwSkodR8xy8psUurl5w1Wf6LvMXLcO0=
X-Google-Smtp-Source: AK7set/bvmcxT4ueCOue6Y4K28852L4z4i5dAFOKoHQQh0iAB28nLxfYoslVm5fBzDSYcSh7z1gsPXC7wBrgaaWS7/Q=
X-Received: by 2002:ad4:4f50:0:b0:56f:795:82cd with SMTP id
 eu16-20020ad44f50000000b0056f079582cdmr3054817qvb.10.1678813761494; Tue, 14
 Mar 2023 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230314134642.21535-1-clin@suse.com> <20230314134642.21535-2-clin@suse.com>
In-Reply-To: <20230314134642.21535-2-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 19:08:45 +0200
Message-ID: <CAHp75Vfc9xQ-eNQZiq+jPstWUKmLE_0EOz-OUYtMFTjT3-fwrQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: s32: refine error/return/config checks and
 simplify driver codes
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

On Tue, Mar 14, 2023 at 3:47=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Improve error/return code handlings and config checks in order to have
> better reliability and simplify driver codes such as removing/changing
> improper macros, blanks, print formats and helper calls.

I dunno if the maintainer wants this to be split to logically unified
changes, but either way it's fine to me.
Also see below some additional minor things you might be interested in fixi=
ng.
With these being addressed:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 141 +++++++++++++++-------------
>  drivers/pinctrl/nxp/pinctrl-s32g2.c |   8 +-
>  2 files changed, 78 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pi=
nctrl-s32cc.c
> index e1da332433a3..7a38e3216b0c 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -28,7 +28,8 @@
>  #include "../pinctrl-utils.h"
>  #include "pinctrl-s32.h"
>
> -#define S32_PIN_ID_MASK                GENMASK(31, 4)
> +#define S32_PIN_ID_SHIFT       4
> +#define S32_PIN_ID_MASK                GENMASK(31, S32_PIN_ID_SHIFT)
>
>  #define S32_MSCR_SSS_MASK      GENMASK(2, 0)
>  #define S32_MSCR_PUS           BIT(12)
> @@ -46,7 +47,7 @@ static struct regmap_config s32_regmap_config =3D {
>
>  static u32 get_pin_no(u32 pinmux)
>  {
> -       return (pinmux & S32_PIN_ID_MASK) >> __ffs(S32_PIN_ID_MASK);
> +       return (pinmux & S32_PIN_ID_MASK) >> S32_PIN_ID_SHIFT;
>  }
>
>  static u32 get_pin_func(u32 pinmux)
> @@ -108,7 +109,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned =
int pin)
>         unsigned int mem_regions =3D ipctl->info->mem_regions;
>         unsigned int i;
>
> -       for (i =3D 0; i < mem_regions; ++i) {
> +       for (i =3D 0; i < mem_regions; i++) {
>                 pin_range =3D ipctl->regions[i].pin_range;
>                 if (pin >=3D pin_range->start && pin <=3D pin_range->end)
>                         return &ipctl->regions[i];
> @@ -224,8 +225,7 @@ static int s32_dt_group_node_to_map(struct pinctrl_de=
v *pctldev,
>
>         n_pins =3D of_property_count_elems_of_size(np, "pinmux", sizeof(u=
32));
>         if (n_pins < 0) {
> -               dev_warn(dev, "Unable to find 'pinmux' property in node %=
s.\n",
> -                       np->name);
> +               dev_warn(dev, "Can't find 'pinmux' property in node %pOFn=
\n", np);
>         } else if (!n_pins) {
>                 return -EINVAL;
>         }
> @@ -317,20 +317,25 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev,=
 unsigned int selector,
>                 info->functions[selector].name, grp->name);
>
>         /* Check beforehand so we don't have a partial config. */
> -       for (i =3D 0; i < grp->npins; ++i) {
> +       for (i =3D 0; i < grp->npins; i++) {
>                 if (s32_check_pin(pctldev, grp->pin_ids[i]) !=3D 0) {
> -                       dev_err(info->dev, "invalid pin: %d in group: %d\=
n",
> +                       dev_err(info->dev, "invalid pin: %u in group: %u\=
n",
>                                 grp->pin_ids[i], group);
>                         return -EINVAL;
>                 }
>         }
>
> -       for (i =3D 0, ret =3D 0; i < grp->npins && !ret; ++i) {
> +       for (i =3D 0, ret =3D 0; i < grp->npins && !ret; i++) {
>                 ret =3D s32_regmap_update(pctldev, grp->pin_ids[i],
>                                         S32_MSCR_SSS_MASK, grp->pin_sss[i=
]);
> +               if (ret) {
> +                       dev_err(info->dev, "Failed to set pin %u\n",
> +                               grp->pin_ids[i]);
> +                       return ret;
> +               }
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static int s32_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
> @@ -375,8 +380,8 @@ static int s32_pmx_gpio_request_enable(struct pinctrl=
_dev *pctldev,
>         int ret;
>
>         ret =3D s32_regmap_read(pctldev, offset, &config);
> -       if (ret !=3D 0)
> -               return -EINVAL;
> +       if (ret)
> +               return ret;
>
>         /* Save current configuration */
>         gpio_pin =3D kmalloc(sizeof(*gpio_pin), GFP_KERNEL);
> @@ -387,7 +392,7 @@ static int s32_pmx_gpio_request_enable(struct pinctrl=
_dev *pctldev,
>         gpio_pin->config =3D config;
>
>         spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
> -       list_add(&(gpio_pin->list), &(ipctl->gpio_configs));
> +       list_add(&gpio_pin->list, &ipctl->gpio_configs);
>         spin_unlock_irqrestore(&ipctl->gpio_configs_lock, flags);
>
>         /* GPIO pin means SSS =3D 0 */
> @@ -401,15 +406,13 @@ static void s32_pmx_gpio_disable_free(struct pinctr=
l_dev *pctldev,
>                                       unsigned int offset)
>  {
>         struct s32_pinctrl *ipctl =3D pinctrl_dev_get_drvdata(pctldev);
> -       struct list_head *pos, *tmp;
> -       struct gpio_pin_config *gpio_pin;
> +       struct gpio_pin_config *gpio_pin, *tmp;
>         unsigned long flags;
>         int ret;
>
>         spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
>
> -       list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
> -               gpio_pin =3D list_entry(pos, struct gpio_pin_config, list=
);
> +       list_for_each_entry_safe(gpio_pin, tmp, &ipctl->gpio_configs, lis=
t) {

>

This blank line now can be removed.

>                 if (gpio_pin->pin_id =3D=3D offset) {
>                         ret =3D s32_regmap_write(pctldev, gpio_pin->pin_i=
d,
> @@ -417,7 +420,7 @@ static void s32_pmx_gpio_disable_free(struct pinctrl_=
dev *pctldev,
>                         if (ret !=3D 0)
>                                 goto unlock;
>
> -                       list_del(pos);
> +                       list_del(&gpio_pin->list);
>                         kfree(gpio_pin);
>                         break;
>                 }
> @@ -461,7 +464,8 @@ static const int support_slew[] =3D {208, -1, -1, -1,=
 166, 150, 133, 83};
>
>  static int s32_get_slew_regval(int arg)
>  {
> -       int i;
> +       unsigned int i;
> +
>         /* Translate a real slew rate (MHz) to a register value */
>         for (i =3D 0; i < ARRAY_SIZE(support_slew); i++) {
>                 if (arg =3D=3D support_slew[i])
> @@ -542,10 +546,11 @@ static int s32_pinconf_mscr_update(struct pinctrl_d=
ev *pctldev,
>         unsigned int config =3D 0, mask =3D 0;
>         int i, ret;
>
> -       if (s32_check_pin(pctldev, pin_id) !=3D 0)
> -               return -EINVAL;
> +       ret =3D s32_check_pin(pctldev, pin_id);
> +       if (ret)
> +               return ret;
>
> -       dev_dbg(ipctl->dev, "pinconf set pin %s with %d configs\n",
> +       dev_dbg(ipctl->dev, "pinconf set pin %s with %u configs\n",
>                 pin_get_name(pctldev, pin_id), num_configs);
>
>         for (i =3D 0; i < num_configs; i++) {
> @@ -559,11 +564,9 @@ static int s32_pinconf_mscr_update(struct pinctrl_de=
v *pctldev,
>         if (!config && !mask)
>                 return 0;
>
> -       ret =3D s32_regmap_update(pctldev, pin_id, mask, config);
> -
> -       dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
> +       dev_dbg(ipctl->dev, "update: pin %u cfg 0x%x\n", pin_id, config);
>
> -       return ret;
> +       return s32_regmap_update(pctldev, pin_id, mask, config);
>  }
>
>  static int s32_pinconf_get(struct pinctrl_dev *pctldev,
> @@ -604,10 +607,13 @@ static void s32_pinconf_dbg_show(struct pinctrl_dev=
 *pctldev,
>                                  struct seq_file *s, unsigned int pin_id)
>  {
>         unsigned int config;
> -       int ret =3D s32_regmap_read(pctldev, pin_id, &config);
> +       int ret;
> +
> +       ret =3D s32_regmap_read(pctldev, pin_id, &config);
> +       if (ret)
> +               return;
>
> -       if (!ret)
> -               seq_printf(s, "0x%x", config);
> +       seq_printf(s, "0x%x", config);
>  }
>
>  static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
> @@ -710,7 +716,7 @@ int s32_pinctrl_resume(struct device *dev)
>  }
>  #endif
>
> -static void s32_pinctrl_parse_groups(struct device_node *np,
> +static int s32_pinctrl_parse_groups(struct device_node *np,
>                                      struct s32_pin_group *grp,
>                                      struct s32_pinctrl_soc_info *info)
>  {
> @@ -722,21 +728,20 @@ static void s32_pinctrl_parse_groups(struct device_=
node *np,
>
>         dev =3D info->dev;
>
> -       dev_dbg(dev, "group: %s\n", np->name);
> +       dev_dbg(dev, "group: %pOFn\n", np);
>
>         /* Initialise group */
>         grp->name =3D np->name;
>
>         npins =3D of_property_count_elems_of_size(np, "pinmux", sizeof(u3=
2));
> -
>         if (npins < 0) {
>                 dev_err(dev, "Failed to read 'pinmux' property in node %s=
.\n",
> -                       np->name);
> -               return;
> +                       grp->name);
> +               return -EINVAL;
>         }
>         if (!npins) {
> -               dev_err(dev, "The group %s has no pins.\n", np->name);
> -               return;
> +               dev_err(dev, "The group %s has no pins.\n", grp->name);
> +               return -EINVAL;
>         }
>
>         grp->npins =3D npins;
> @@ -745,12 +750,8 @@ static void s32_pinctrl_parse_groups(struct device_n=
ode *np,
>                                     sizeof(unsigned int), GFP_KERNEL);
>         grp->pin_sss =3D devm_kcalloc(info->dev, grp->npins,
>                                     sizeof(unsigned int), GFP_KERNEL);
> -
> -       if (!grp->pin_ids || !grp->pin_sss) {
> -               dev_err(dev, "Failed to allocate memory for the group %s.=
\n",
> -                       np->name);
> -               return;
> -       }
> +       if (!grp->pin_ids || !grp->pin_sss)
> +               return -ENOMEM;
>
>         i =3D 0;
>         of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
> @@ -761,9 +762,11 @@ static void s32_pinctrl_parse_groups(struct device_n=
ode *np,
>                         grp->pin_ids[i], grp->pin_sss[i]);
>                 i++;
>         }
> +
> +       return 0;
>  }
>
> -static void s32_pinctrl_parse_functions(struct device_node *np,
> +static int s32_pinctrl_parse_functions(struct device_node *np,
>                                         struct s32_pinctrl_soc_info *info=
,
>                                         u32 index)
>  {
> @@ -771,8 +774,9 @@ static void s32_pinctrl_parse_functions(struct device=
_node *np,
>         struct s32_pmx_func *func;
>         struct s32_pin_group *grp;
>         u32 i =3D 0;
> +       int ret =3D 0;
>
> -       dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
> +       dev_dbg(info->dev, "parse function(%u): %pOFn\n", index, np);
>
>         func =3D &info->functions[index];
>
> @@ -780,18 +784,24 @@ static void s32_pinctrl_parse_functions(struct devi=
ce_node *np,
>         func->name =3D np->name;
>         func->num_groups =3D of_get_child_count(np);
>         if (func->num_groups =3D=3D 0) {
> -               dev_err(info->dev, "no groups defined in %s\n", np->full_=
name);
> -               return;
> +               dev_err(info->dev, "no groups defined in %pOF\n", np);
> +               return -EINVAL;
>         }
> -       func->groups =3D devm_kzalloc(info->dev,
> -                       func->num_groups * sizeof(char *), GFP_KERNEL);
> +       func->groups =3D devm_kcalloc(info->dev, func->num_groups,

> +                                   sizeof(char *), GFP_KERNEL);

sizeof(*func->groups) ?

> +       if (!func->groups)
> +               return -ENOMEM;
>
>         for_each_child_of_node(np, child) {
>                 func->groups[i] =3D child->name;
>                 grp =3D &info->groups[info->grp_index++];
> -               s32_pinctrl_parse_groups(child, grp, info);
> +               ret =3D s32_pinctrl_parse_groups(child, grp, info);
> +               if (ret)
> +                       return ret;
>                 i++;
>         }
> +
> +       return 0;
>  }
>
>  static int s32_pinctrl_probe_dt(struct platform_device *pdev,
> @@ -804,6 +814,7 @@ static int s32_pinctrl_probe_dt(struct platform_devic=
e *pdev,
>         struct regmap *map;
>         void __iomem *base;
>         int mem_regions =3D info->mem_regions;
> +       int ret;
>         u32 nfuncs =3D 0;
>         u32 i =3D 0;
>
> @@ -815,13 +826,12 @@ static int s32_pinctrl_probe_dt(struct platform_dev=
ice *pdev,
>                 return -EINVAL;
>         }
>
> -       ipctl->regions =3D devm_kzalloc(&pdev->dev,
> -                                     mem_regions * sizeof(*(ipctl->regio=
ns)),
> -                                     GFP_KERNEL);
> +       ipctl->regions =3D devm_kcalloc(&pdev->dev, mem_regions,
> +                                     sizeof(*(ipctl->regions)), GFP_KERN=
EL);

Too many parentheses.

>         if (!ipctl->regions)
>                 return -ENOMEM;
>
> -       for (i =3D 0; i < mem_regions; ++i) {
> +       for (i =3D 0; i < mem_regions; i++) {
>                 base =3D devm_platform_get_and_ioremap_resource(pdev, i, =
&res);
>                 if (IS_ERR(base))
>                         return PTR_ERR(base);
> @@ -851,24 +861,26 @@ static int s32_pinctrl_probe_dt(struct platform_dev=
ice *pdev,
>         }
>
>         info->nfunctions =3D nfuncs;
> -       info->functions =3D devm_kzalloc(&pdev->dev,
> -                                      nfuncs * sizeof(struct s32_pmx_fun=
c),
> -                                      GFP_KERNEL);
> +       info->functions =3D devm_kcalloc(&pdev->dev, nfuncs,
> +                                      sizeof(struct s32_pmx_func), GFP_K=
ERNEL);

sizeof(*info->functions)

>         if (!info->functions)
>                 return -ENOMEM;
>
>         info->ngroups =3D 0;
>         for_each_child_of_node(np, child)
>                 info->ngroups +=3D of_get_child_count(child);
> -       info->groups =3D devm_kzalloc(&pdev->dev,
> -                                   info->ngroups * sizeof(struct s32_pin=
_group),
> -                                   GFP_KERNEL);
> +
> +       info->groups =3D devm_kcalloc(&pdev->dev, info->ngroups,
> +                                   sizeof(struct s32_pin_group), GFP_KER=
NEL);

sizeof (*info->groups) ?

>         if (!info->groups)
>                 return -ENOMEM;
>
>         i =3D 0;
> -       for_each_child_of_node(np, child)
> -               s32_pinctrl_parse_functions(child, info, i++);
> +       for_each_child_of_node(np, child) {
> +               ret =3D s32_pinctrl_parse_functions(child, info, i++);
> +               if (ret)
> +                       return ret;
> +       }
>
>         return 0;
>  }
> @@ -923,12 +935,9 @@ int s32_pinctrl_probe(struct platform_device *pdev,
>
>         ipctl->pctl =3D devm_pinctrl_register(&pdev->dev, s32_pinctrl_des=
c,
>                                             ipctl);
> -
> -       if (IS_ERR(ipctl->pctl)) {
> -               dev_err(&pdev->dev, "could not register s32 pinctrl drive=
r\n");
> -               return PTR_ERR(ipctl->pctl);
> -       }

> -

Don't drop this blank line, see below.

> +       if (IS_ERR(ipctl->pctl))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(ipctl->pctl),
> +                                    "could not register s32 pinctrl driv=
er\n");

It should be here.

>  #ifdef CONFIG_PM_SLEEP
>         saved_context =3D &ipctl->saved_context;
>         saved_context->pads =3D
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pi=
nctrl-s32g2.c
> index 5028f4adc389..0b0b06f12b8a 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> @@ -746,8 +746,8 @@ static int s32g_pinctrl_probe(struct platform_device =
*pdev)
>         if (!of_id)
>                 return -ENODEV;
>
> -       return s32_pinctrl_probe
> -                       (pdev, (struct s32_pinctrl_soc_info *) of_id->dat=
a);
> +       return s32_pinctrl_probe(pdev,
> +                                (struct s32_pinctrl_soc_info *) of_id->d=
ata);

No space after casting, but why is it using this interface? Convert to
of_device_get_match_data().
(In a separate patch before this one)

>  }
>
>  static const struct dev_pm_ops s32g_pinctrl_pm_ops =3D {
> @@ -757,14 +757,12 @@ static const struct dev_pm_ops s32g_pinctrl_pm_ops =
=3D {
>  static struct platform_driver s32g_pinctrl_driver =3D {
>         .driver =3D {
>                 .name =3D "s32g-siul2-pinctrl",
> -               .owner =3D THIS_MODULE,
>                 .of_match_table =3D s32_pinctrl_of_match,
> -               .pm =3D &s32g_pinctrl_pm_ops,
> +               .pm =3D pm_sleep_ptr(&s32g_pinctrl_pm_ops),
>                 .suppress_bind_attrs =3D true,
>         },
>         .probe =3D s32g_pinctrl_probe,
>  };
> -
>  builtin_platform_driver(s32g_pinctrl_driver);
>
>  MODULE_AUTHOR("Matthew Nunez <matthew.nunez@nxp.com>");
> --
> 2.37.3
>


--=20
With Best Regards,
Andy Shevchenko
