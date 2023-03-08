Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E536B0898
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCHN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCHNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:25:55 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB355046;
        Wed,  8 Mar 2023 05:21:55 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id y10so17997651qtj.2;
        Wed, 08 Mar 2023 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJmI3toJcyD0rtXqA+q+mWe1ygqD3kfow9SX9U/OzSo=;
        b=ot9BSAPZlMXCKShIBhVg4MBhDv5ejhXWHVNOnQ8hwho6gJqLKjUWaSI5D3m37WxEJt
         mt5AwfhCT5YBzA0YzNggLFpNy89Z98G1qlJJ32KF4DIAN3OXBy6jyy+DZOF8LgRly2lM
         4J7+6G1o/WmA4DB1/WoC4FjbbQlP8szQ9/YjyMNc9QKq065haGR2yxso7L2Ae591Rm68
         koRlsUnfJ1OI2tFLDBTlm3FaIa8z5dQaxtxOuZfE35zO18ajRjZLYapKFtvXT+g02qAo
         cbaatfuEyjP71BCIZ49jFxVMg02Yp9W+T4ZtlnCQu4Igh/mwoI9mlMG+Tg8+/vshQTC5
         I9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJmI3toJcyD0rtXqA+q+mWe1ygqD3kfow9SX9U/OzSo=;
        b=rEZ9bwGdBzQFX34IjQFuEkx1kRnY5lus5oHR/yapL5xPtKP/Mu/mwJsLypb8hpvZ95
         i/mAIyTu5sCvFEDxdkyJlv+GeIkQxTlptl9EUHv6CwVdyPpRZEkFGiZ94KzsvxIWBmXZ
         Y5Cexx4iD5mlkK02Rd1iL1BSYpDc25Ia4CiKU2817nmQyQTa133YLirSY6rhSiMFD09V
         M2tKeNJogs3SmPMIEAOgVLQ6CU4Z8wg+5ML+lbJYsi+hiATSs5aA5w1aRPZmHaE9nP1w
         bOQ90EoiWuArWgQw3ZsvDtqwlOEOPUXSiFA9VrpsRXBX2/Vua7IPTpaLJGpfgr9o2Eri
         3LMw==
X-Gm-Message-State: AO0yUKVWYDEzWI+bf3ES8vNuZXOqJDaZ/rTAiA8xmUHpXPGHDcFr1xsm
        e44OsPyOrBv9W1IOijje2QUr5T5BgoC9TG/4aPA=
X-Google-Smtp-Source: AK7set+dM0RCKh17ze2ORjK/I8wtGS4UZOAkkZQeT4Sh+/OqgLdsUPbqB6YvzEdGjl9IwDE/ZNYHW3Ik/DNi2PPkRYk=
X-Received: by 2002:ac8:14c:0:b0:3bf:c40b:ecc1 with SMTP id
 f12-20020ac8014c000000b003bfc40becc1mr5257709qtg.1.1678281696455; Wed, 08 Mar
 2023 05:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220023320.3499-1-clin@suse.com> <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook> <ZAgXCi/BzyEQul9B@linux-8mug>
In-Reply-To: <ZAgXCi/BzyEQul9B@linux-8mug>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Mar 2023 15:21:00 +0200
Message-ID: <CAHp75VfxffTvAPSB4D2Oc3-vbiYM4DVpZf5=jRYGsCdFgAyxJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pinctrl: add NXP S32 SoC family support
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:03 AM Chester Lin <clin@suse.com> wrote:
> On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com wrote:
> > Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:

...

> but the driver patch
> has been merged into the maintainer's for-next so I would not change this part
> unless the driver patch needs to be reverted and re-submitted in the end.

As I said you have to keep it in mind for all your future
contributions to the Linux kernel independently on the destiny of this
one.

...

> > > +   depends on ARCH_S32 && OF
> >
> > Is OF necessary? Can it be
>
> I think it's required since the driver file refers to of_* APIs.

And? Is it functional or compilation dependency? If the latter is the
case, what API exactly isn't providing a stub?

> >       depends OF || COMPILE_TEST
> >
> > ?

So?

...

> > > +   depends on ARCH_S32 && OF

Ditto.

> > > +/**
> > > + * struct s32_pin_group - describes an S32 pin group
> > > + * @name: the name of this specific pin group
> > > + * @npins: the number of pins in this group array, i.e. the number of
> > > + *         elements in pin_ids and pin_sss so we can iterate over that array
> > > + * @pin_ids: an array of pin IDs in this group
> > > + * @pin_sss: an array of source signal select configs paired with pin_ids
> > > + */
> > > +struct s32_pin_group {
> > > +   const char *name;
> > > +   unsigned int npins;
> > > +   unsigned int *pin_ids;
> > > +   unsigned int *pin_sss;
> >
> > Why didn't you embed struct pingroup?
>
> I did think about that but there's an additional 'pin_sss' which could make code
> a bit messy. For example:
>
>         s32_regmap_update(pctldev, grp->grp.pins[i],
>                           S32_MSCR_SSS_MASK, grp->pin_sss[i]);

We specifically provide those data types to separate generic things
with custom ones. I don't think about the code getting longer, the
access to the proper data seems reasonable to me. Look into other
drivers that utilise these data types.

> > > +};
> > > +
> > > +/**
> > > + * struct s32_pmx_func - describes S32 pinmux functions
> > > + * @name: the name of this specific function
> > > + * @groups: corresponding pin groups
> > > + * @num_groups: the number of groups
> > > + */
> > > +struct s32_pmx_func {
> > > +   const char *name;
> > > +   const char **groups;
> > > +   unsigned int num_groups;
> > > +};
> >
> > struct pinfunction.
>
> Thanks for your information. I was not aware of this new struct since it just got
> merged recently.

That's why the rule is to keep an eye on the subsystem development by
regular rebasing on top of its tip (pinctrl tree, devel branch in this
case).

...

> > > +#ifdef CONFIG_PM_SLEEP
> > > +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> > > +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> > > +#endif
> >
> > Please, consider using new PM macros, like pm_ptr().
>
> Maybe pm_sleep_ptr() is more accurate?

You are the author, choose what you think fits the best!

...


> > > +   case PIN_CONFIG_BIAS_PULL_UP:
> > > +           if (arg)
> > > +                   *config |= S32_MSCR_PUS;
> > > +           else
> > > +                   *config &= ~S32_MSCR_PUS;
> >
> > > +           fallthrough;
> >
> > It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?
> >
> I admit that it's ambiguous and should be improved in order to have better readability.
>
> In a S32G2 MSCR register, there are two register bits related to pull up/down functions:
>
> PUE (Pull Enable, MSCR[13]): 0'b: Disabled,  1'b: Enabled
> PUS (Pull Select, MSCR[12]): 0'b: Pull Down, 1'b: Pull Up
>
> The dt properties could be like these:
>
> 1) 'bias-pull-up' or 'bias-pull-up: true'  --> arg = 1
>    In this case both PUE and PUS are set.
>
> 2) 'bias-pull-up: false'  --> arg = 0
>    In this case both PUE and PUS are cleared since the pull-up function must be disabled.

So, split it to a separate function where you do the enabling only once.
I can point to drivers/pinctrl/intel/pinctrl-intel.c for the idea to take from.

> > > +   case PIN_CONFIG_BIAS_PULL_DOWN:
> > > +           if (arg)
> > > +                   *config |= S32_MSCR_PUE;
> > > +           else
> > > +                   *config &= ~S32_MSCR_PUE;
> > > +           *mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> > > +           break;
> > > +   case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > > +           *config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> > > +           *mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> > > +           fallthrough;
> >
> > Ditto.
> >
>
> It's similar to the case 'PIN_CONFIG_BIAS_PULL_UP' although the PUS bit is assumed
> as 0 via the config variable so only the PUE bit needs to be configured, for example:
>
> 1) 'bias-pull-down' or 'bias-pull-down: true'  --> arg = 1
>    PUE is set and PUS is cleared.
>
> 2) 'bias-pull-down: false'  --> arg = 0
>    In this case both PUE and PUS are cleared since the pull-down function must be disabled.
>
> > > +   case PIN_CONFIG_BIAS_DISABLE:
> > > +           *config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > > +           *mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > > +           break;

Ditto.

...

I assume that non-commented is equal to silent agreement and will be
addressed accordingly. If it's not the case, reply again with your
objections.

-- 
With Best Regards,
Andy Shevchenko
