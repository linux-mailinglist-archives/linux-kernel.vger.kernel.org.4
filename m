Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1037C60F29C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiJ0Ihl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiJ0IhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:37:21 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07F158187;
        Thu, 27 Oct 2022 01:36:23 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id h16so349451vkn.4;
        Thu, 27 Oct 2022 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c39D+F4e8YHmvY5D42QFvMHkl0AwzgPk+17Hes9atyw=;
        b=I5RLdgJ9YiZqPeunpBj5xzTnjV1RVXA5qrGQhCBk/Pzs5wv8h3eV9UT/JWcCVINnRh
         MLvrefK1l9HHQbrozeTzXqveA/OWuvRYj8dWWVey1szbr1cK5O3DsM0tf10V4850WIuD
         KTfCuZlVUtZKeSN/+yBl7zSVgn3KRiF4iJhmN2rvPslzdHzopqyiLPOoNmMXPKLQCxnc
         KECu1dZZUfZV0ZMgiQ7vdeN3ICiQz4IRQGt5zP4fF+VwPUk7N7f7MBhtFWHxFkSNDWlh
         6A5fH5qhVOucslpw0CXuRkp5d52tR7bcT/shePxKE2GXRej03cBoP1ZIiXFs9jrBDjq4
         eAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c39D+F4e8YHmvY5D42QFvMHkl0AwzgPk+17Hes9atyw=;
        b=I/T6ahctNb3zM0A+KG8qX4Ido/VkwDi24J2eacfzmaQGgd5MyvHYgx8wj4rZSCYKUx
         wrDzXo3laYS/shs4uIZFJVPdEPG44eVWHhBYw8dP5R+RCiJF2R40Olan67UsPjFtethz
         COANUNtPlPJ/cOAtdWD8TC/ukEoQpYCMXCopfCTeod72tpbX4V6EEpv5avOFmDZoqoMD
         R3qjtRpOkLuv+aBn6Mn9J++Ao4cTgZuexM78aihgx9V0a1uuxSmlhffi7sv9p82XiZb2
         Y9QM35mej5DP2i0Twm/anzC7JO5z1siE3DwVb4MyLvW5EFuP/qi/FTv7fRuLbY/JGV99
         jlbg==
X-Gm-Message-State: ACrzQf24qkZJQmgO2qadizyfa63Hp+rxwnb3KywZeLoPrmSg6GeWE+Uz
        6WjjeCKBbQMXLVJ99KB04gkahwXqB6Kz/RJ5KsQ=
X-Google-Smtp-Source: AMsMyM6bTL3U2v1crn79C43zvfkuqPKjJYUI1i7Xh25x4KTaaQF4K5epB0oy8HIRxl8uJ2Cqzd+mTLukQkLLgmeDUOY=
X-Received: by 2002:a1f:200e:0:b0:3b7:6558:52a2 with SMTP id
 g14-20020a1f200e000000b003b7655852a2mr9686636vkg.20.1666859781931; Thu, 27
 Oct 2022 01:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-3-romain.perier@gmail.com> <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
In-Reply-To: <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 27 Oct 2022 10:36:10 +0200
Message-ID: <CABgxDoJmVRbZEP02QoEhHKXiu127073oK2NE2VgFHBADCBbdog@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pwm: Add support for the MSTAR MSC313 PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi,


Le mar. 27 sept. 2022 =C3=A0 18:33, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> a =C3=A9crit :
>
> Hello Romain, hello Daniel,
>
> adding Mark Brown to Cc: for the regmap stuff.
>
> On Wed, Sep 07, 2022 at 03:12:38PM +0200, Romain Perier wrote:
> > From: Daniel Palmer <daniel@0x0f.com>
> >
> > This adds support for the PWM block on the Mstar MSC313e SoCs and newer=
.
> >
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > Co-developed-by: Romain Perier <romain.perier@gmail.com>
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  MAINTAINERS               |   1 +
> >  drivers/pwm/Kconfig       |   9 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-msc313e.c | 269 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 280 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-msc313e.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d7f64dc0efe..c3b39b09097c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2439,6 +2439,7 @@ F:      arch/arm/mach-mstar/
> >  F:   drivers/clk/mstar/
> >  F:   drivers/clocksource/timer-msc313e.c
> >  F:   drivers/gpio/gpio-msc313.c
> > +F:   drivers/pwm/pwm-msc313e.c
> >  F:   drivers/rtc/rtc-msc313.c
> >  F:   drivers/watchdog/msc313e_wdt.c
> >  F:   include/dt-bindings/clock/mstar-*
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 60d13a949bc5..8049fd03a821 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -372,6 +372,15 @@ config PWM_MESON
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-meson.
> >
> > +config PWM_MSC313E
> > +     tristate "MStar MSC313e PWM support"
> > +     depends on ARCH_MSTARV7 || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for MSTAR MSC313e.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-msc313e.
> > +
> >  config PWM_MTK_DISP
> >       tristate "MediaTek display PWM driver"
> >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 7bf1a29f02b8..bc285c054f2a 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -62,4 +62,5 @@ obj-$(CONFIG_PWM_TWL)               +=3D pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)    +=3D pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VISCONTI)   +=3D pwm-visconti.o
> >  obj-$(CONFIG_PWM_VT8500)     +=3D pwm-vt8500.o
> > +obj-$(CONFIG_PWM_MSC313E)    +=3D pwm-msc313e.o
> >  obj-$(CONFIG_PWM_XILINX)     +=3D pwm-xilinx.o
> > diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
> > new file mode 100644
> > index 000000000000..a71f39ba66c3
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-msc313e.c
> > @@ -0,0 +1,269 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
> > + * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define DRIVER_NAME "msc313e-pwm"
> > +
> > +#define CHANNEL_OFFSET       0x80
> > +#define REG_DUTY     0x8
> > +#define REG_PERIOD   0x10
> > +#define REG_DIV              0x18
> > +#define REG_CTRL     0x1c
> > +#define REG_SWRST    0x1fc
> > +
> > +struct msc313e_pwm_channel {
> > +     struct regmap_field *clkdiv;
> > +     struct regmap_field *polarity;
> > +     struct regmap_field *dutyl;
> > +     struct regmap_field *dutyh;
> > +     struct regmap_field *periodl;
> > +     struct regmap_field *periodh;
> > +     struct regmap_field *swrst;
> > +};
> > +
> > +struct msc313e_pwm {
> > +     struct regmap *regmap;
> > +     struct pwm_chip pwmchip;
> > +     struct clk *clk;
> > +     struct msc313e_pwm_channel channels[];
> > +};
> > +
> > +struct msc313e_pwm_info {
> > +     unsigned int channels;
> > +};
> > +
> > +#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pwmc=
hip)
> > +
> > +static const struct regmap_config msc313e_pwm_regmap_config =3D {
> > +     .reg_bits =3D 16,
> > +     .val_bits =3D 16,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static const struct msc313e_pwm_info msc313e_data =3D {
> > +     .channels =3D 8,
> > +};
> > +
> > +static const struct msc313e_pwm_info ssd20xd_data =3D {
> > +     .channels =3D 4,
> > +};
> > +
> > +static void msc313e_pwm_writecounter(struct regmap_field *low, struct =
regmap_field *high, u32 value)
> > +{
> > +     /* The bus that connects the CPU to the peripheral registers spli=
ts 32 bit registers into
>
> Please fix the comment style to use /* on a line for itself. Also for
> comments staying below 80 chars per line is appreciated.

even if check-patch.pl --strict passed ? ^^

>
> > +      * two 16bit registers placed 4 bytes apart. It's the hardware de=
sign they used. The counter
> > +      * we are about to write has this contrainst.
>
> s/contrainst/contraint/
>
> I wonder if that could be abstracted by regmap?!

I had the same thought, not from what I have read/found, but perhaps
the regmap maintainer has an opinion.

>
> > +      */
> > +     regmap_field_write(low, value & 0xffff);
> > +     regmap_field_write(high, value >> 16);
> > +}
> > +
> > +static void msc313e_pwm_readcounter(struct regmap_field *low, struct r=
egmap_field *high, u32 *value)
> > +{
> > +     unsigned int val =3D 0;
> > +
> > +     regmap_field_read(low, &val);
> > +     *value =3D val;
> > +     regmap_field_read(high, &val);
> > +     *value =3D (val << 16) | *value;
> > +}
> > +
> > +static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *device,
> > +                           int duty_ns, int period_ns)
> > +{
> > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > +     unsigned long long nspertick =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC,=
 clk_get_rate(pwm->clk));
> > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hw=
pwm];
> > +     unsigned long long div =3D 1;
> > +
> > +     /* Fit the period into the period register by prescaling the clk =
*/
> > +     while (DIV_ROUND_DOWN_ULL(period_ns, nspertick) > 0x3ffff) {
>
> dividing by the result of a division looses precision. Also rounding
> down both divisions looks wrong.

Such cases are not supposed to be covered by PWM_DEBUG ? (because
everything passed with PWM_DEBUG)


>
> > +             div++;
> > +             if (div > (0xffff + 1)) {
> > +                     /* Force clk div to the maximum allowed value */
> > +                     div =3D 0xffff;
> > +                     break;
> > +             }
> > +             nspertick =3D DIV_ROUND_DOWN_ULL(nspertick, div);
> > +     }
> > +
> > +     regmap_field_write(channel->clkdiv, div - 1);
> > +     msc313e_pwm_writecounter(channel->dutyl, channel->dutyh,
> > +                              DIV_ROUND_DOWN_ULL(duty_ns, nspertick));
> > +     msc313e_pwm_writecounter(channel->periodl, channel->periodh,
> > +                              DIV_ROUND_DOWN_ULL(period_ns, nspertick)=
);
> > +     return 0;
> > +};
> > +
> > +static int msc313e_pwm_set_polarity(struct pwm_chip *chip, struct pwm_=
device *device,
> > +                                 enum pwm_polarity polarity)
> > +{
> > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hw=
pwm];
> > +     unsigned int pol =3D 0;
> > +
> > +     if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             pol =3D 1;
> > +     regmap_field_update_bits(channel->polarity, 1, pol);
> > +
> > +     return 0;
> > +}
> > +
> > +static int msc313e_pwm_enable(struct pwm_chip *chip, struct pwm_device=
 *device)
> > +{
> > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hw=
pwm];
> > +     int ret;
> > +
> > +     ret =3D clk_prepare_enable(pwm->clk);
> > +     if (ret)
> > +             return ret;
> > +     return regmap_field_write(channel->swrst, 0);
> > +}
> > +
> > +static int msc313e_pwm_disable(struct pwm_chip *chip, struct pwm_devic=
e *device)
> > +{
> > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hw=
pwm];
> > +     int ret;
> > +
> > +     ret =3D regmap_field_write(channel->swrst, 1);
> > +     clk_disable_unprepare(pwm->clk);
> > +     return ret;
> > +}
> > +
> > +static int msc313e_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
> > +                      const struct pwm_state *state)
> > +{
> > +     int ret;
> > +
> > +     if (state->enabled) {
> > +             if (!pwm->state.enabled) {
> > +                     ret =3D msc313e_pwm_enable(chip, pwm);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +             msc313e_pwm_set_polarity(chip, pwm, state->polarity);
> > +             msc313e_pwm_config(chip, pwm, state->duty_cycle, state->p=
eriod);
>
> Does the output emit a previous setting after msc313e_pwm_enable()? If
> so, please do the enable at the end.
>
> Does calling msc313e_pwm_set_polarity() and msc313e_pwm_config() have an
> immediate effect? Or is the currently running period completed?
>
> > +     } else if (pwm->state.enabled) {
> > +             ret =3D msc313e_pwm_disable(chip, pwm);
>
> How does the output behave on disable? Typical options are:
>
>  - freezes where ever it currently is
>  - goes to the inactive level

I let Daniel answer these questions.


>
> Does it complete the currently running period? Please answer these in a
> "Limitations:" section similar to e.g. pwm-sl28cpld.c and pwm-iqs620a.
>
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void msc313e_get_state(struct pwm_chip *chip, struct pwm_device=
 *device,
>
> Please s/device/pwm/ to match the naming used in other drivers.
>
> > +                           struct pwm_state *state)
> > +{
> > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hw=
pwm];
> > +     unsigned long long nspertick =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC,=
 clk_get_rate(pwm->clk));
> > +     unsigned int val =3D 0;
> > +
> > +     regmap_field_read(channel->polarity, &val);
> > +     state->polarity =3D val ? PWM_POLARITY_INVERSED : PWM_POLARITY_NO=
RMAL;
> > +
> > +     regmap_field_read(channel->swrst, &val);
> > +     state->enabled =3D val =3D=3D 0 ? true : false;
> > +
> > +     msc313e_pwm_readcounter(channel->dutyl, channel->dutyh, &val);
> > +     state->duty_cycle =3D val * nspertick;
>
> Please do the division at the end. Consider val =3D 333335 and
> clk_get_rate() returning 666666667.
>
> Then the exact duty cycle would be 500002.49974999874 but you would
> calculate nspertick =3D 1 and so duty_cycle =3D 333335.
>
> Also you need to round up. Did you test your driver with PWM_DEBUG
> enabled?

Take a look at my cover letter, yeah I have tested everything with
PWM_DEBUG, everything passed ^^

The idea is that .get_state should return 500003 here to have
> apply =E2=88=98 get_state idempotent. As apply is supposed to round down =
to the
> next available setting, get_state has to round up.
>
> > +     msc313e_pwm_readcounter(channel->periodl, channel->periodh, &val)=
;
> > +     state->period =3D val * nspertick;
> > +}
> > +
> > +static const struct pwm_ops msc313e_pwm_ops =3D {
> > +     .apply =3D msc313e_apply,
> > +     .get_state =3D msc313e_get_state,
> > +     .owner =3D THIS_MODULE
> > +};
> > +
> > +static int msc313e_pwm_probe(struct platform_device *pdev)
> > +{
> > +     const struct msc313e_pwm_info *match_data;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct msc313e_pwm *pwm;
> > +     __iomem void *base;
> > +     int i;
> > +
> > +     match_data =3D of_device_get_match_data(dev);
> > +     if (!match_data)
> > +             return -EINVAL;
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     pwm =3D devm_kzalloc(dev, struct_size(pwm, channels, match_data->=
channels), GFP_KERNEL);
>
> Please don't use "pwm" as a name for your driver data variable. That
> name is reserved for struct pwm_device pointers. Something like "ddata"
> would be fine, but there is a wide variety in pwm driver land to choose
> from.
>
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     pwm->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(pwm->clk))
> > +             return dev_err_probe(dev, PTR_ERR(pwm->clk), "Cannot get =
clk\n");
> > +
> > +     pwm->regmap =3D devm_regmap_init_mmio(dev, base, &msc313e_pwm_reg=
map_config);
> > +     if (IS_ERR(pwm->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(pwm->regmap), "Cannot g=
et regmap\n");
> > +
> > +     for (i =3D 0; i < match_data->channels; i++) {
> > +             unsigned int offset =3D CHANNEL_OFFSET * i;
> > +             struct reg_field div_clkdiv_field =3D REG_FIELD(offset + =
REG_DIV, 0, 7);
> > +             struct reg_field ctrl_polarity_field =3D REG_FIELD(offset=
 + REG_CTRL, 4, 4);
> > +             struct reg_field dutyl_field =3D REG_FIELD(offset + REG_D=
UTY, 0, 15);
> > +             struct reg_field dutyh_field =3D REG_FIELD(offset + REG_D=
UTY + 4, 0, 2);
> > +             struct reg_field periodl_field =3D REG_FIELD(offset + REG=
_PERIOD, 0, 15);
> > +             struct reg_field periodh_field =3D REG_FIELD(offset + REG=
_PERIOD + 4, 0, 2);
> > +             struct reg_field swrst_field =3D REG_FIELD(REG_SWRST, i, =
i);
> > +
> > +             pwm->channels[i].clkdiv =3D devm_regmap_field_alloc(dev, =
pwm->regmap,
> > +                                                               div_clk=
div_field);
> > +             pwm->channels[i].polarity =3D devm_regmap_field_alloc(dev=
, pwm->regmap,
> > +                                                                 ctrl_=
polarity_field);
> > +             pwm->channels[i].dutyl =3D devm_regmap_field_alloc(dev, p=
wm->regmap, dutyl_field);
> > +             pwm->channels[i].dutyh =3D devm_regmap_field_alloc(dev, p=
wm->regmap, dutyh_field);
> > +             pwm->channels[i].periodl =3D devm_regmap_field_alloc(dev,=
 pwm->regmap, periodl_field);
> > +             pwm->channels[i].periodh =3D devm_regmap_field_alloc(dev,=
 pwm->regmap, periodh_field);
> > +             pwm->channels[i].swrst =3D devm_regmap_field_alloc(dev, p=
wm->regmap, swrst_field);
> > +
> > +             /* Channels are enabled on boot, disable it until the pwm=
 subsystem re-enable it
> > +              * explicitly
>
> You're supposed to keep the PWM running. (Consider a bootloader setting
> up a splash screen. You're probably killing the backlight here.) Note
> you need improved clk handling to do that right.
>
> > +              */
> > +             regmap_field_write(pwm->channels[i].swrst, 1);
> > +     }
> > +
> > +     pwm->pwmchip.dev =3D dev;
> > +     pwm->pwmchip.ops =3D &msc313e_pwm_ops;
> > +     pwm->pwmchip.npwm =3D match_data->channels;
> > +
> > +     platform_set_drvdata(pdev, pwm);
>
> This is unused, please drop.
>
> > +     return devm_pwmchip_add(dev, &pwm->pwmchip);
> > +}
> > +
> > +static const struct of_device_id msc313e_pwm_dt_ids[] =3D {
> > +     { .compatible =3D "mstar,msc313e-pwm", .data =3D &msc313e_data },
> > +     { .compatible =3D "mstar,ssd20xd-pwm", .data =3D &ssd20xd_data },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, msc313e_pwm_dt_ids);
> > +
> > +static struct platform_driver msc313e_pwm_driver =3D {
> > +     .probe =3D msc313e_pwm_probe,
> > +     .driver =3D {
> > +             .name =3D DRIVER_NAME,
> > +             .of_match_table =3D msc313e_pwm_dt_ids,
> > +     },
> > +};
> > +module_platform_driver(msc313e_pwm_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mstar MSC313e PWM driver");
> > +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
>
> That address doesn't match the author of this patch. Is this on purpose?
>
> Best regards
> Uwe


Regards,
Romain
