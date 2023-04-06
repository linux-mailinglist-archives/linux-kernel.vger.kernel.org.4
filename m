Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5156D9974
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbjDFOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjDFOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:19:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4D8684;
        Thu,  6 Apr 2023 07:19:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 11so1784947ejw.0;
        Thu, 06 Apr 2023 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680790751;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WzeBVz4xh+EUmy3Ll5sxkie6tr4+K0YCnOLUY6fLHU=;
        b=XfQA26MifcUtDBFmQNJ5yW3XXX26Nn64ZhiO+wzb/uca1RV609ovtvbnL6Eww8atAa
         nykXkObmnW/WqQGson+b6Pp7WHQD+OlILmDrRACLaynTH62uhdMRODRgwNcOlDtTrAve
         8GQiHX2q+O0fnmMutQvBnNkyVUyWx+rgMRJTX/k23EpdSmkwLKsGbx/P2VPobc9ypGQW
         RHz0GvEXEIQTkpkJV9+CTfmCu2sbhuNHYJEjYkjyIld676nctrAT41XdrUPsqIMxkvMQ
         nczXL55ettBjRAtOS7eauRdlXkWZ7Dqjn9QDw9xBSYeLcUFo+jN/SAMlH74jx0Wlxb4f
         PZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790751;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WzeBVz4xh+EUmy3Ll5sxkie6tr4+K0YCnOLUY6fLHU=;
        b=2VRVd4ks7u1bhGDesbbtPlbFMaFSZI5ctaUxuNhrNcgADRE9Y90I99bTQhxV77KDUQ
         e8LgPwp/Q29YS8YTJywSUD7FmJzfbQyk81Fmef0rQ/RLf351imNrH+KXhw8X5wy3Wg5B
         xjc5Yz+dIe0FHouAFebJB7zHajSEckTVqn2W8SYZkTizTE/BWaFbjk0zwy6BnewCYxDc
         5km5rHIoVUQPX49tGyMxUOm5yFCBc7ELDvm94UA9N5Cgydp3rEd7OMfhDS06UKVxehFE
         zRcLSNHlFo8KjSKA/wMB5leEACbIB38j8JiR0WqvlaV+4q+FS2p+aSgKxmaG+1OPkziW
         wH4w==
X-Gm-Message-State: AAQBX9cOSgNC1lOL0ZattPfzJv2M1LB15cHViwP6fnycR6Q6JTsthEZx
        i6PwUlvqVCbv3IdeQ+dcJS0=
X-Google-Smtp-Source: AKy350Z1ZmlhLwFxkiP0sWGXcWM2RO6Yjs/H5ZRopDjhq14uU3oqGylVFS6MoUjB/OsbiiSRW9DSBw==
X-Received: by 2002:a17:906:35d5:b0:931:dcd4:4ff0 with SMTP id p21-20020a17090635d500b00931dcd44ff0mr5654707ejb.75.1680790750923;
        Thu, 06 Apr 2023 07:19:10 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170907174b00b0092b546b57casm855117ejc.195.2023.04.06.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:19:10 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:19:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [RESEND v3 2/2] pwm: starfive: Add PWM driver support
Message-ID: <ZC7U3MzdUX_TcA75@orome>
References: <20230321055228.105945-1-william.qiu@starfivetech.com>
 <20230321055228.105945-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ai1V1849wZ7s+NYk"
Content-Disposition: inline
In-Reply-To: <20230321055228.105945-3-william.qiu@starfivetech.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ai1V1849wZ7s+NYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 01:52:28PM +0800, William Qiu wrote:
> Add Pulse Width Modulation driver support for StarFive
> JH7110 soc.

s/soc/SoC/

>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS                    |   7 +
>  drivers/pwm/Kconfig            |  10 ++
>  drivers/pwm/Makefile           |   1 +
>  drivers/pwm/pwm-starfive-ptc.c | 245 +++++++++++++++++++++++++++++++++
>  4 files changed, 263 insertions(+)
>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac151975d0d3..efe1811f9501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19929,6 +19929,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh7=
1*
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>=20
> +STARFIVE JH71X0 PWM DRIVERS
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml
> +F:	drivers/pwm/pwm-starfive-ptc.c
> +
>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..2307a0099994 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -536,6 +536,16 @@ config PWM_SPRD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sprd.
>=20
> +config PWM_STARFIVE_PTC
> +	tristate "StarFive PWM PTC support"
> +	depends on OF
> +	depends on COMMON_CLK

You probably want HAS_IOMEM here as well, otherwise this will likely
fail to build on some architectures.

> +	help
> +	  Generic PWM framework driver for StarFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-starfive-ptc.
> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..577f69904baa 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+=3D pwm-sprd.o
> +obj-$(CONFIG_PWM_STARFIVE_PTC)	+=3D pwm-starfive-ptc.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-pt=
c.c
> new file mode 100644
> index 000000000000..239df796d240
> --- /dev/null
> +++ b/drivers/pwm/pwm-starfive-ptc.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2018 StarFive Technology Co., Ltd.
> + */
> +
> +#include <dt-bindings/pwm/pwm.h>

You don't use anything from this, nor should you. Just drop it.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/io.h>

These should be in alphabetic order.

> +
> +/* how many parameters can be transferred to ptc */
> +#define OF_PWM_N_CELLS			3

You use this exactly once, so this definition is useless.

> +
> +/* PTC Register offsets */
> +#define REG_RPTC_CNTR			0x0
> +#define REG_RPTC_HRC			0x4
> +#define REG_RPTC_LRC			0x8
> +#define REG_RPTC_CTRL			0xC

These seem to have been replaced by the REG_PTC_RPTC_* definitions
below. Pick one and drop the other.

> +/* Bit for PWM clock */
> +#define BIT_PWM_CLOCK_EN		31
> +
> +/* Bit for clock gen soft reset */
> +#define BIT_CLK_GEN_SOFT_RESET		13

These two bit definitions seem to be completely unused.

> +
> +#define NS_PER_SECOND			1000000000

Use the standard NSEC_PER_SEC.

> +
> +/*
> + * Access PTC register (cntr hrc lrc and ctrl),
> + * need to replace PWM_BASE_ADDR
> + */
> +#define REG_PTC_BASE_ADDR_SUB(base, N)	\
> +((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
> +
> +/* PTC_RPTC_CTRL */
> +#define PTC_EN      BIT(0)
> +#define PTC_ECLK    BIT(1)
> +#define PTC_NEC     BIT(2)
> +#define PTC_OE      BIT(3)
> +#define PTC_SIGNLE  BIT(4)
> +#define PTC_INTE    BIT(5)
> +#define PTC_INT     BIT(6)
> +#define PTC_CNTRRST BIT(7)
> +#define PTC_CAPTE   BIT(8)
> +
> +struct starfive_pwm_ptc_device {
> +	struct pwm_chip		chip;
> +	struct clk		*clk;
> +	struct reset_control	*rst;
> +	void __iomem		*regs;
> +	int			irq;
> +	unsigned int		approx_freq;/*pwm apb clock frequency*/

No need for aligning these with tabs. Single space is enough for each of
these.

Also, you're dealing with potentially large numbers here, so best to
make the approx_freq unsigned long or perhaps even u64.

> +};
> +
> +static inline
> +struct starfive_pwm_ptc_device *chip_to_starfive_ptc(struct pwm_chip *c)
> +{
> +	return container_of(c, struct starfive_pwm_ptc_device, chip);
> +}
> +
> +static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
> +				       struct pwm_device *dev,
> +				       struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm =3D chip_to_starfive_ptc(chip);
> +	u32 data_lrc, data_hrc;
> +	u32 pwm_clk_ns =3D 0;
> +
> +	data_lrc =3D ioread32(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
> +	data_hrc =3D ioread32(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));

Why ioread32()? It doesn't look like this is getting used in some sort
of I/O port setup, so you probably want readl()/writel() instead.

> +
> +	pwm_clk_ns =3D NS_PER_SECOND / pwm->approx_freq;
> +
> +	state->period =3D data_lrc * pwm_clk_ns;
> +	state->duty_cycle =3D data_hrc * pwm_clk_ns;

Again, you want data_lrc, data_hrc and pwm_clk_ns to be unsigned long
or u64 to avoid overflow.

> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D 1;

So these cannot be turned off? You seem to emulate enabled =3D false by
setting duty cycle to 0 in starfive_pwm_ptc_apply(), so it's probably
best to mirror that here.

> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
> +				  struct pwm_device *dev,
> +				  struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm =3D chip_to_starfive_ptc(chip);
> +	u32 data_hrc =3D 0;
> +	u32 data_lrc =3D 0;
> +	u32 period_data =3D 0;
> +	u32 duty_data =3D 0;

Some of these can be condensed into a single line.

> +	s64 multi =3D pwm->approx_freq;
> +	s64 div =3D NS_PER_SECOND;

NSEC_PER_SEC

> +	void __iomem *reg_addr;
> +
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;
> +
> +	while (multi % 10 =3D=3D 0 && div % 10 =3D=3D 0 && multi > 0 && div > 0=
) {
> +		multi /=3D 10;
> +		div /=3D 10;
> +	}
> +
> +	period_data =3D (u32)(state->period * multi / div);

You're doing 64-bit multiplications and divisions here, which will
likely trigger a build error on some platforms (typically 32-bit ARM).
You should look using at the various helpers in linux/math64.h.

> +	if (abs(period_data * div / multi - state->period)
> +	    > abs((period_data + 1) * div / multi - state->period) ||
> +	    (state->period > 0 && period_data =3D=3D 0))
> +		period_data +=3D 1;

We typically write this as period_data++;

> +
> +	if (state->enabled) {
> +		duty_data =3D (u32)(state->duty_cycle * multi / div);
> +		if (abs(duty_data * div / multi - state->duty_cycle)
> +			> abs((duty_data + 1) * div / multi - state->duty_cycle) ||
> +			(state->duty_cycle > 0 && duty_data =3D=3D 0))
> +			duty_data +=3D 1;

Same here. You may also want to create temporary variables for those
abs() parameters (or the result) to make this a bit more readable.

> +	} else {
> +		duty_data =3D 0;
> +	}
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		data_hrc =3D period_data - duty_data;
> +	else
> +		data_hrc =3D duty_data;

That's not how we do polarity inversion. If you need period - duty for
normal polarity, that probably indicates that your PWM supports inverse
polarity natively. Furthermore the above seems to only consider the
output power when reversing polarity, which is not correct. If you need
this for the likes of pwm-fan, then you should look at inverting the
polarity in those drivers.

> +
> +	data_lrc =3D period_data;
> +
> +	reg_addr =3D REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm);
> +	iowrite32(data_hrc, reg_addr);
> +
> +	reg_addr =3D REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm);
> +	iowrite32(data_lrc, reg_addr);
> +
> +	reg_addr =3D REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm);
> +	iowrite32(0, reg_addr);
> +
> +	reg_addr =3D REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm);
> +	iowrite32(PTC_EN | PTC_OE, reg_addr);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops starfive_pwm_ptc_ops =3D {
> +	.get_state	=3D starfive_pwm_ptc_get_state,
> +	.apply		=3D (void *)starfive_pwm_ptc_apply,

Why do you need to cast this? Also, drop the extra padding.

> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct starfive_pwm_ptc_device *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip =3D &pwm->chip;
> +	chip->dev =3D dev;
> +	chip->ops =3D &starfive_pwm_ptc_ops;
> +	chip->npwm =3D 8;
> +
> +	chip->of_pwm_n_cells =3D OF_PWM_N_CELLS;

Simply use the literal "3" here. It's sufficiently clear from the
context what this means, so it's not a "magic" value or anything.

> +	chip->base =3D -1;

This is no longer needed.

> +
> +	pwm->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->regs))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
> +					"Unable to map IO resources\n");

The string on the second line should be aligned with "dev" from the
first line. Same for the errors below.

> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +					"Unable to get pwm clock\n");
> +
> +	pwm->rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pwm->rst))
> +		return dev_err_probe(dev, PTR_ERR(pwm->rst),
> +					"Unable to get pwm reset\n");
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to enable pwm clock, %d\n", ret);

s/pwm/PWM/ in the strings above. And why not use dev_err_probe() here as
well?

> +		return ret;
> +	}
> +
> +	reset_control_deassert(pwm->rst);
> +
> +	pwm->approx_freq =3D (unsigned int)clk_get_rate(pwm->clk);

Drop the cast. It's not needed.

> +	if (!pwm->approx_freq)
> +		dev_err(dev, "get pwm apb clock rate failed.\n");

Don't you want to make this fatal? If not, you'll end up dividing by
zero in ->get_state(). Also, you may want to reword the error message to
be more in line with the others in this function. Perhaps something
like:

	dev_err(dev, "failed to get APB clock rate\n");

> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot register PTC: %d\n", ret);
> +		clk_disable_unprepare(pwm->clk);

Maybe reset_control_assert() here as well?

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
> +{
> +	struct starfive_pwm_ptc_device *pwm =3D platform_get_drvdata(dev);
> +	struct pwm_chip *chip =3D &pwm->chip;
> +
> +	pwmchip_remove(chip);

No need for the temporary variable, you can pass &pwm->chip directly to
pwmchip_remove().

> +
> +	return 0;
> +}

You may want to use the ->remove_new() callback instead since the error
code return is misleading.

Although, I just noticed that you use devm_pwmchip_add(), so there
should be no need for the remove callback at all.

Thierry

> +
> +static const struct of_device_id starfive_pwm_ptc_of_match[] =3D {
> +	{ .compatible =3D "starfive,jh7110-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
> +
> +static struct platform_driver starfive_pwm_ptc_driver =3D {
> +	.probe =3D starfive_pwm_ptc_probe,
> +	.remove =3D starfive_pwm_ptc_remove,
> +	.driver =3D {
> +		.name =3D "pwm-starfive-ptc",
> +		.of_match_table =3D starfive_pwm_ptc_of_match,
> +	},
> +};
> +module_platform_driver(starfive_pwm_ptc_driver);
> +
> +MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive PWM PTC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>=20

--Ai1V1849wZ7s+NYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQu1NoACgkQ3SOs138+
s6GlsxAAhKmSCX7oQ0vBJqyn3LGBjfV84Y3AAzi+/QkJGl6Upe9W72L/RKZHnLNc
TKj39aBUVNDT/NDAGPIFRoHgx6Zful7OKIj74wcRr6MBy9EL5Qy19Cp/Z19DlgCC
VJfxiuLZge1D3xbheJiiR7IsLrJOwJGc257x60s7dRYCceNVYGLdW1Pjs9V1o16j
xSavmn++57iEAyywf0hankZd5MgizTanzvWMBVipVplMSsBkXZWztG27SQgUYmVU
6j2Lu7bEPWS6r+NH/NMeicz7kAIV//wtRYQPrwQXOXvo9Lbu9bh5NdwimlaZJPdN
co3iYSDswCN/rq5Qi+3b466WNwNNYz6YAOI/PGXzrL+of+xSMZCa6piO44aPziS/
ctlL/JSDl+5OnvkeHR9N8w1fiQL3MB0whTgnA5i2mwAVIu1c2K4YQVzwKPnYGX/o
HWe8SYpI4Vyed6F0uVr5SVJAai+osZe0kc6y4hgasSDD5vaMXFXU2nJwkAt6IqVU
xqBiy3mEVOBuov0ci6uPlleyi0wrr2IL3eJokYdqMmCRlZA9EiU4gZAVA7XQ7Fpe
ULirO72yznPiubCI7ZgStMwUmAWVlhEd4eXUgUnwwxv/wDHLeK8KwF/FFRLIsdCh
Cj1/w2cuGnUX+mQQ/4UYoMhr9MxRvjkbflN5JzKFol7bm0sUu8s=
=rObe
-----END PGP SIGNATURE-----

--Ai1V1849wZ7s+NYk--
