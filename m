Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0D668589
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjALVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjALVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:34:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E63102D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:25:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG54W-0001r9-Ak; Thu, 12 Jan 2023 22:25:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG54U-005clc-Va; Thu, 12 Jan 2023 22:25:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG54U-00CMxK-Ai; Thu, 12 Jan 2023 22:25:14 +0100
Date:   Thu, 12 Jan 2023 22:25:14 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mubin Sayyed <mubin.sayyed@amd.com>
Cc:     robh+dt@kernel.org, treding@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, mubin10@gmail.com
Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Message-ID: <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkk2cdc5fe4gezxe"
Content-Disposition: inline
In-Reply-To: <20230112071526.3035949-4-mubin.sayyed@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkk2cdc5fe4gezxe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 12, 2023 at 12:45:26PM +0530, Mubin Sayyed wrote:
> Cadence TTC timer can be configured as clocksource/clockevent
> or PWM device. Specific TTC device would be configured as PWM
> device, if pwm-cells property is present in the device tree
> node.
>=20
> In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
> timers/counters, so maximum 3 PWM channels can be configured for
> each TTC IP instance. Also, output of 0th PWM channel of each TTC
> device can be routed to MIO or EMIO, and output of 2nd and 3rd
> PWM channel can be routed only to EMIO.
>=20
> Period for given PWM channel is configured through interval timer
> and duty cycle through match counter.
>=20
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-cadence.c | 363 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 375 insertions(+)
>  create mode 100644 drivers/pwm/pwm-cadence.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..9e0f1fae4711 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -504,6 +504,17 @@ config PWM_SIFIVE
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sifive.
> =20
> +config PWM_CADENCE

Please keep both Kconfig and Makefile sorted alphabetically.

> +	tristate "Cadence PWM support"
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for cadence TTC IP found on
> +	  Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
> +	  channels. Output of 0th PWM channel of each TTC device can
> +	  be routed to MIO or EMIO, and output of 1st and 2nd PWM
> +	  channels can be routed only to EMIO.
> +
>  config PWM_SL28CPLD
>  	tristate "Kontron sl28cpld PWM support"
>  	depends on MFD_SL28CPLD || COMPILE_TEST
> [...]
> diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
> new file mode 100644
> index 000000000000..de981df3ec5a
> --- /dev/null
> +++ b/drivers/pwm/pwm-cadence.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver to configure cadence TTC timer as PWM
> + * generator
> + *
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */

Is there a public manual for the hardware? If yes, please mention a link
here.

> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

clk-provider looks wronge here, your device is only a consumer, isn't
it?

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/of_address.h>
> +
> +#define TTC_CLK_CNTRL_OFFSET		0x00
> +#define TTC_CNT_CNTRL_OFFSET		0x0C
> +#define TTC_MATCH_CNT_VAL_OFFSET	0x30
> +#define TTC_COUNT_VAL_OFFSET		0x18
> +#define TTC_INTR_VAL_OFFSET		0x24
> +#define TTC_ISR_OFFSET			0x54
> +#define TTC_IER_OFFSET			0x60
> +#define TTC_PWM_CHANNEL_OFFSET		0x4
> +
> +#define TTC_CLK_CNTRL_CSRC_MASK		BIT(5)
> +#define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
> +
> +#define TTC_CNTR_CTRL_DIS_MASK		BIT(0)
> +#define TTC_CNTR_CTRL_INTR_MODE_EN_MASK	BIT(1)
> +#define TTC_CNTR_CTRL_MATCH_MODE_EN_MASK	BIT(3)
> +#define TTC_CNTR_CTRL_RST_MASK		BIT(4)
> +#define TTC_CNTR_CTRL_WAVE_EN_MASK	BIT(5)
> +#define TTC_CNTR_CTRL_WAVE_POL_MASK	BIT(6)

If you ask me do s/_OFFSET// and s/_MASK// on all these definitions.

> +#define TTC_CLK_CNTRL_PSV_SHIFT		1

This is unused.

> +
> +#define TTC_PWM_MAX_CH			3
> +
> +/**
> + * struct ttc_pwm_priv - Private data for TTC PWM drivers
> + * @chip:	PWM chip structure representing PWM controller
> + * @clk:	TTC input clock
> + * @max:	Maximum value of the counters
> + * @base:	Base address of TTC instance
> + */
> +struct ttc_pwm_priv {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	u32 max;
> +	void __iomem *base;
> +};
> +
> +static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
> +				unsigned long offset)
> +{
> +	return readl_relaxed(priv->base + offset);
> +}
> +
> +static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
> +				  unsigned long offset,
> +				  unsigned long val)
> +{
> +	writel_relaxed(val, priv->base + offset);
> +}
> +
> +static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
> +				   struct pwm_device *pwm,
> +				   unsigned long offset)
> +{
> +	unsigned long pwm_ch_offset =3D offset +
> +				       (TTC_PWM_CHANNEL_OFFSET * pwm->hwpwm);
> +
> +	return ttc_pwm_readl(priv, pwm_ch_offset);
> +}
> +
> +static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
> +				     struct pwm_device *pwm,
> +				     unsigned long offset,
> +				     unsigned long val)
> +{
> +	unsigned long pwm_ch_offset =3D offset +
> +				       (TTC_PWM_CHANNEL_OFFSET * pwm->hwpwm);
> +
> +	ttc_pwm_writel(priv, pwm_ch_offset, val);
> +}
> +
> +static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct pwm_ch=
ip *chip)
> +{
> +	return container_of(chip, struct ttc_pwm_priv, chip);
> +}
> +
> +static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct pwm_device =
*pwm)
> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> +	ctrl_reg |=3D (TTC_CNTR_CTRL_INTR_MODE_EN_MASK
> +				 | TTC_CNTR_CTRL_MATCH_MODE_EN_MASK | TTC_CNTR_CTRL_RST_MASK);
> +	ctrl_reg &=3D (~(TTC_CNTR_CTRL_DIS_MASK | TTC_CNTR_CTRL_WAVE_EN_MASK));

superflous parenthesis.

> +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
> +}
> +
> +static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct pwm_device=
 *pwm)
> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> +	ctrl_reg |=3D TTC_CNTR_CTRL_DIS_MASK;
> +
> +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
> +}
> +
> +static void ttc_pwm_rev_polarity(struct ttc_pwm_priv *priv, struct pwm_d=
evice *pwm)
> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> +	ctrl_reg ^=3D TTC_CNTR_CTRL_WAVE_POL_MASK;
> +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);

I prefer to have this more explicit like

	ttc_pwm_set_polarity(..., enum pwm_polarity polarity)

> +}
> +
> +static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
> +				 struct pwm_device *pwm,
> +				 u32 div,
> +				 u32 period_cycles,
> +				 u32 duty_cycles)
> +{
> +	u32 clk_reg;
> +
> +	/* Set up prescalar */
> +	clk_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CLK_CNTRL_OFFSET);
> +	clk_reg &=3D ~TTC_CLK_CNTRL_PSV_MASK;
> +	clk_reg |=3D div;

We have

#define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)

so the LSB of div sets a bit outside of TTC_CLK_CNTRL_PSV_MASK; that
looks wrong.

> +	ttc_pwm_ch_writel(priv, pwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
> +
> +	/* Set up period */
> +	ttc_pwm_ch_writel(priv, pwm, TTC_INTR_VAL_OFFSET, period_cycles);
> +
> +	/* Set up duty cycle */
> +	ttc_pwm_ch_writel(priv, pwm, TTC_MATCH_CNT_VAL_OFFSET, duty_cycles);

how does the output pin behave between the writes in this function (and
the others in .apply())?

> +}
> +
> +static int ttc_pwm_apply(struct pwm_chip *chip,
> +			 struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	u32 div =3D 0;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	unsigned long rate;
> +	struct pwm_state cstate;
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +
> +	pwm_get_state(pwm, &cstate);

Please don't use pwm consumer functions. You can use pwm->state
directly.

> +	if (state->polarity !=3D cstate.polarity) {
> +		if (cstate.enabled)
> +			ttc_pwm_disable(priv, pwm);
> +
> +		ttc_pwm_rev_polarity(priv, pwm);
> +
> +		if (cstate.enabled)
> +			ttc_pwm_enable(priv, pwm);

It would (probably) be nice to delay that enable until you configured
duty_cycle and period to reduce the amount of wrong signalling.

> +	}
> +

You can exit early here if state->enabled =3D=3D false.

> +	if (state->period !=3D cstate.period ||
> +	    state->duty_cycle !=3D cstate.duty_cycle) {

(With an early exit above this check becomes wrong, simply drop it.)

> +		rate =3D clk_get_rate(priv->clk);
> +
> +		/* Prevent overflow by limiting to the maximum possible period */
> +		period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +		period_cycles =3D DIV_ROUND_CLOSEST(period_cycles * rate, NSEC_PER_SEC=
);

DIV_ROUND_CLOSEST isn't suiteable to work with u64. (That's also the
reason for the build bot report.)

The usual alternative trick here is to do:

	if (rate > NSEC_PER_SEC)
		return -EINVAL;

	period_cycles =3D mul_u64_u64_div_u64(state->period, rate, NSEC_PER_SEC);

> +		if (period_cycles > priv->max) {
> +			/* prescale frequency to fit requested period cycles within limit */
> +			div =3D 1;
> +
> +			while ((period_cycles  > priv->max) && (div < 65536)) {

s/  / /

Also this can be calculated without a loop. Maybe it's easier to store
the timer width in priv instead of max =3D BIT(width) - 1.

> +				rate =3D DIV_ROUND_CLOSEST(rate, BIT(div));
> +				period_cycles =3D DIV_ROUND_CLOSEST(state->period * rate,
> +								  NSEC_PER_SEC);
> +				if (period_cycles < priv->max)
> +					break;
> +				div++;
> +			}
> +
> +			if (period_cycles  > priv->max)
> +				return -ERANGE;
> +		}
> +
> +		duty_cycles =3D DIV_ROUND_CLOSEST(state->duty_cycle * rate,
> +						NSEC_PER_SEC);

Please ensure that you configure a period that is not bigger than
state->period. Ditto for duty_cycle.

> +		if (cstate.enabled)
> +			ttc_pwm_disable(priv, pwm);
> +
> +		ttc_pwm_set_counters(priv, pwm, div, period_cycles, duty_cycles);
> +
> +		if (cstate.enabled)
> +			ttc_pwm_enable(priv, pwm);

Another possible glitch here.

> +	}
> +
> +	if (state->enabled !=3D cstate.enabled) {
> +		if (state->enabled)
> +			ttc_pwm_enable(priv, pwm);
> +		else
> +			ttc_pwm_disable(priv, pwm);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ttc_pwm_get_state(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	unsigned long rate;
> +	u32 value;
> +	u64 tmp;
> +
> +	value =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> +
> +	if (value & TTC_CNTR_CTRL_WAVE_POL_MASK)
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	if (value & TTC_CNTR_CTRL_DIS_MASK)
> +		state->enabled =3D false;
> +	else
> +		state->enabled =3D true;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +
> +	tmp =3D ttc_pwm_ch_readl(priv, pwm, TTC_INTR_VAL_OFFSET);
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	tmp =3D ttc_pwm_ch_readl(priv, pwm, TTC_MATCH_CNT_VAL_OFFSET);
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);

This looks wrong for several reasons. Have you tested with PWM_DEBUG
enabled? What is rate typically?

=2Eget_state is supposed to round up in its divisions. Also I miss a
factor of NSEC_PER_SEC here, and also div doesn't appear here?!

> +	return 0;
> +}
> +
> +static struct pwm_device *
> +ttc_pwm_of_xlate(struct pwm_chip *chip, const struct of_phandle_args *ar=
gs)
> +{
> +	struct pwm_device *pwm;
> +
> +	if (args->args[0] >=3D TTC_PWM_MAX_CH)
> +		return NULL;
> +
> +	pwm =3D pwm_request_from_chip(chip, args->args[0], NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	if (args->args[1])
> +		pwm->args.period =3D args->args[1];
> +
> +	if (args->args[2])
> +		pwm->args.polarity =3D args->args[2];
> +
> +	return pwm;
> +}

I don't see an advantage in this function over the default
of_pwm_xlate_with_flags(). (There are downsides though I think.)

If you drop this function there is only one usage of TTC_PWM_MAX_CH left
and you can drop this symbol, too. (In favour of

	priv->chip.npwm =3D 3;

=2E)

> +static const struct pwm_ops ttc_pwm_ops =3D {
> +	.apply =3D ttc_pwm_apply,
> +	.get_state =3D ttc_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int ttc_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	int clksel;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct ttc_pwm_priv *priv;
> +	u32 pwm_cells;
> +	u32 timer_width;
> +	struct clk *clk_cs;
> +

Please add a comment here about coexistence with the timer mode.

> +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret =3D=3D -EINVAL)
> +		return -ENODEV;
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret =3D of_property_read_u32(np, "timer-width", &timer_width);
> +	if (ret)
> +		timer_width =3D 16;
> +
> +	priv->max =3D BIT(timer_width) - 1;
> +
> +	clksel =3D ttc_pwm_readl(priv, TTC_CLK_CNTRL_OFFSET);

TTC_CLK_CNTRL_OFFSET is as parameter for ttc_pwm_ch_readl and
ttc_pwm_readl, is this correct?

> +	clksel =3D !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
> +	clk_cs =3D of_clk_get(np, clksel);

Can you use devm_clk_get_enabled here?

> +	if (IS_ERR(clk_cs))
> +		return dev_err_probe(dev, PTR_ERR(clk_cs),
> +				     "ERROR: timer input clock not found\n");
> +
> +	priv->clk =3D clk_cs;
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &ttc_pwm_ops;
> +	priv->chip.npwm =3D TTC_PWM_MAX_CH;
> +	priv->chip.of_xlate =3D ttc_pwm_of_xlate;
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int ttc_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ttc_pwm_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&priv->chip);
> +	clk_rate_exclusive_put(priv->clk);
> +	clk_disable_unprepare(priv->clk);

missing clk_put() (unless you switch to a devm_clk_get variant as
suggested above).

> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fkk2cdc5fe4gezxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPAercACgkQwfwUeK3K
7An+BAgAmQQehBYFh5KW7Mem48/TWC7rMwvLWl/Pa2QcoIpumzMIEv3Txg3pMbH4
BpWOiPXXtEhS+jINay0Hc5BuOWs9jA4Mt5hS/LnqFdbp01gizjR/2+i1XNzsrw4i
v5pYFKfjtSJXA5u2RvhjdPrQ+3NOUKofdezJHnJqYwWjwFROimGQg29RbdFBn+G5
mOErvhq+FBcdnlZsmYn6jMHGajvLWYQURkeIX+NUUfEuRddea1d0jhvzqtCZ+a5S
BEuWP2UruMx9GpH56Fgr8Hq3qzSiWKOOnQ7K2q6IjtOA002lqgruNev91pZU43Pa
rrxSY3K8Y4g35SrQvp8Zwl2WXP4aYg==
=GTMg
-----END PGP SIGNATURE-----

--fkk2cdc5fe4gezxe--
