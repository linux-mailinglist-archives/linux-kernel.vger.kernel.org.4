Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5F72F666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjFNHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjFNHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:33:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08F10E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:33:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9L0m-00057E-1l; Wed, 14 Jun 2023 09:33:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9L0k-007Ioz-E7; Wed, 14 Jun 2023 09:33:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9L0j-00E8Mv-Py; Wed, 14 Jun 2023 09:33:45 +0200
Date:   Wed, 14 Jun 2023 09:33:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: Implement .get_state()
Message-ID: <20230614073345.5ejzkbcdiel5v7zg@pengutronix.de>
References: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ft7432huag6fmx34"
Content-Disposition: inline
In-Reply-To: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ft7432huag6fmx34
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 04:06:02PM +0200, Philipp Zabel wrote:
> Stop stm32_pwm_detect_channels() from disabling all channels and count
> the number of enabled PWMs to keep the clock running. Implement the
> &pwm_ops->get_state callback so drivers can inherit PWM state set by
> the bootloader.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Make the necessary changes to allow inheriting PWM state set by the
> bootloader, for example to avoid flickering with a pre-enabled PWM
> backlight.
> ---
>  drivers/pwm/pwm-stm32.c | 75 ++++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 59 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 62e397aeb9aa..e0677c954bdf 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -52,6 +52,21 @@ static u32 active_channels(struct stm32_pwm *dev)
>  	return ccer & TIM_CCER_CCXE;
>  }
> =20
> +static int read_ccrx(struct stm32_pwm *dev, int ch, u32 *value)
> +{
> +	switch (ch) {
> +	case 0:
> +		return regmap_read(dev->regmap, TIM_CCR1, value);
> +	case 1:
> +		return regmap_read(dev->regmap, TIM_CCR2, value);
> +	case 2:
> +		return regmap_read(dev->regmap, TIM_CCR3, value);
> +	case 3:
> +		return regmap_read(dev->regmap, TIM_CCR4, value);
> +	}
> +	return -EINVAL;
> +}

I'd prefer having something like:

	#define TIM_CCR(i)	(0x30 + 4 * (i))	/* Capt/Comp Register i, for i in 1 ..=
 4 */
	#define TIM_CCR1	TIM_CCR(1)
	#define TIM_CCR2	TIM_CCR(2)
	#define TIM_CCR3	TIM_CCR(3)
	#define TIM_CCR4	TIM_CCR(4)

and then read_ccrx could be simplified to:

	return regmap_read(dev->regmap, TIM_CCR(i + 1), value);

=2E (Not sure if passing an invalid channel really needs handling.)

But given that write_ccrx looks the same, I'm ok with that.

> +
>  static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
>  {
>  	switch (ch) {
> @@ -486,9 +501,40 @@ static int stm32_pwm_apply_locked(struct pwm_chip *c=
hip, struct pwm_device *pwm,
>  	return ret;
>  }
> =20
> +static int stm32_pwm_get_state(struct pwm_chip *chip,
> +			       struct pwm_device *pwm, struct pwm_state *state)
> +{
> +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> +	int ch =3D pwm->hwpwm;
> +	unsigned long rate;
> +	u32 ccer, psc, arr, ccr;
> +	u64 dty, prd;
> +	int ret;
> +
> +	ret =3D regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	if (ret)
> +		return ret;
> +
> +	state->enabled =3D ccer & (TIM_CCER_CC1E << (ch * 4));

Other parts of the driver use the macros from <linux/bitfield.h>. With a
similar approach as suggested for TIM_CCR above, this could be made to
read as:

	state->enabled =3D FIELD_GET(TIM_CCER_CCxE(ch + 1), ccer);

> +	state->polarity =3D (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	regmap_read(priv->regmap, TIM_PSC, &psc);
> +	regmap_read(priv->regmap, TIM_ARR, &arr);
> +	read_ccrx(priv, ch, &ccr);

You don't use the return value of read_ccrx(), so make it void (or check
it)? If you check it, also do it for regmap_read().

> +	rate =3D clk_get_rate(priv->clk);
> +
> +	prd =3D (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);

This might overflow?!

> +	state->period =3D DIV_ROUND_UP_ULL(prd, rate);
> +	dty =3D (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(dty, rate);
> +
> +	return ret;
> +}

While looking at stm32_pwm_config() to check if it matches your
stm32_pwm_get_state() implementation, I noticed that for small values of
period_ns, prd might become 0 which than yields surprising effects in
combination with

	regmap_write(priv->regmap, TIM_ARR, prd - 1);

Also the driver needs locking because of the PSC and ARR registers are
shared for all channels and there are rounding issues (prd is used for
the calculation of dty).

> +
>  static const struct pwm_ops stm32pwm_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.apply =3D stm32_pwm_apply_locked,
> +	.get_state =3D stm32_pwm_get_state,
>  	.capture =3D IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
> =20
> @@ -579,30 +625,22 @@ static void stm32_pwm_detect_complementary(struct s=
tm32_pwm *priv)
>  	priv->have_complementary_output =3D (ccer !=3D 0);
>  }
> =20
> -static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
> +static int stm32_pwm_detect_channels(struct stm32_pwm *priv, int *n_enab=
led)
>  {
> -	u32 ccer;
> -	int npwm =3D 0;
> +	u32 ccer, ccer_backup;
> +	int npwm;
> =20
>  	/*
>  	 * If channels enable bits don't exist writing 1 will have no
>  	 * effect so we can detect and count them.
>  	 */
> +	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
>  	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
> -	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
> +	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
> =20
> -	if (ccer & TIM_CCER_CC1E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC2E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC3E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC4E)
> -		npwm++;
> +	npwm =3D hweight32(ccer & TIM_CCER_CCXE);
> +	*n_enabled =3D hweight32(ccer_backup & TIM_CCER_CCXE);

hweight32 returns an unsigned int. While there is probably no problem
with values that don't fit, using unsigned for *n_enabled (and also
npwm) looks better IMHO. Maybe split making npwm unsigned and using
hweight32 to assign it to a separate preparing patch? The inconsistency
between "npwm" (without underscore) and "n_enabled" (with underscore)
strikes me a bit. given that struct pwm_chip has "npwm", too, maybe drop
the _ from "n_enabled"?

>  	return npwm;
>  }
> @@ -613,7 +651,9 @@ static int stm32_pwm_probe(struct platform_device *pd=
ev)
>  	struct device_node *np =3D dev->of_node;
>  	struct stm32_timers *ddata =3D dev_get_drvdata(pdev->dev.parent);
>  	struct stm32_pwm *priv;
> +	int n_enabled;
>  	int ret;
> +	int i;
> =20
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -635,7 +675,10 @@ static int stm32_pwm_probe(struct platform_device *p=
dev)
> =20
>  	priv->chip.dev =3D dev;
>  	priv->chip.ops =3D &stm32pwm_ops;
> -	priv->chip.npwm =3D stm32_pwm_detect_channels(priv);
> +	priv->chip.npwm =3D stm32_pwm_detect_channels(priv, &n_enabled);
> +
> +	for (i =3D 0; i < n_enabled; i++)
> +		clk_enable(priv->clk);
> =20
>  	ret =3D pwmchip_add(&priv->chip);
>  	if (ret < 0)
>=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ft7432huag6fmx34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJbVgACgkQj4D7WH0S
/k7CAQf+LOMb8SCyg4OFz//TqKGYuFtuPCURdUO+TYl4RxxjFmqH6QaKeFOF1/q8
d09Z8JDg1Avk8ic5fhWW6+WzH6S5lfq0Cu0Z4B8n4ZQkiIChc8cD7D2t37mGhGDC
pnP4/MwF+sFUFl7IO5op+BoGoDivLGZjZNMn1ZdpFD9bAe2eOzrzlFGNlWnlci6b
/J/aesYtcsKgUh3es9lzklAuV6oEHvlH3o9JQT6Ow1J8Aa8iFA6csmMJR34uqwg5
dycmCEoRw4BoyPmVZoGAm72ouJbxPXoeTVa/TTWlAH1ygKTzRmeQxa76NTAWnTj/
XynF/in3Lv6NjXObPPpo8PMwv61ebQ==
=RbBO
-----END PGP SIGNATURE-----

--ft7432huag6fmx34--
