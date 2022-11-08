Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8806218CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiKHPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiKHPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:50:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C51F632
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:50:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osQs7-0006XT-Lp; Tue, 08 Nov 2022 16:50:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osQs5-0035K1-ES; Tue, 08 Nov 2022 16:50:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osQs5-00FDVP-Ld; Tue, 08 Nov 2022 16:50:41 +0100
Date:   Tue, 8 Nov 2022 16:50:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20221108155041.t4oppot5wy77jzgd@pengutronix.de>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
 <20221007113512.91501-4-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwyeg54cbb5bbxrg"
Content-Disposition: inline
In-Reply-To: <20221007113512.91501-4-conor.dooley@microchip.com>
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


--hwyeg54cbb5bbxrg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 07, 2022 at 12:35:12PM +0100, Conor Dooley wrote:
> [...]
> +static u64 mchp_core_pwm_calc_duty(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   const struct pwm_state *state, u8 prescale, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 duty_steps, tmp;
> +	u16 prescale_val =3D PREG_TO_VAL(prescale);
> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 */
> +	duty_steps =3D state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
> +	tmp =3D prescale_val * NSEC_PER_SEC;
> +	return div64_u64(duty_steps, tmp);

The assignment to duty_steps can overflow. So you have to use
mul_u64_u64_div_u64 here, too.

> +}
> +
> [...]
> +
> +static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_=
device *pwm,
> +				      const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state =3D pwm->state;
> +	bool period_locked;
> +	u64 duty_steps;
> +	u16 prescale;
> +	u8 period_steps;
> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If the only thing that has changed is the duty cycle or the polarity,
> +	 * we can shortcut the calculations and just compute/apply the new duty
> +	 * cycle pos & neg edges
> +	 * As all the channels share the same period, do not allow it to be
> +	 * changed if any other channels are enabled.
> +	 * If the period is locked, it may not be possible to use a period
> +	 * less than that requested. In that case, we just abort.
> +	 */
> +	period_locked =3D mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
> +
> +	if (period_locked) {
> +		u16 hw_prescale;
> +		u8 hw_period_steps;
> +
> +		mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
> +		hw_prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCA=
LE);
> +		hw_period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PE=
RIOD);
> +
> +		if ((period_steps + 1) * (prescale + 1) <
> +		    (hw_period_steps + 1) * (hw_prescale + 1))
> +			return -EINVAL;
> +
> +		/*
> +		 * It is possible that something could have set the period_steps
> +		 * register to 0xff, which would prevent us from setting a 100%
> +		 * or 0% relative duty cycle, as explained above in
> +		 * mchp_core_pwm_calc_period().
> +		 * The period is locked and we cannot change this, so we abort.
> +		 */
> +		if (hw_period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX)
> +			return -EINVAL;
> +
> +		prescale =3D hw_prescale;
> +		period_steps =3D hw_period_steps;
> +	} else {
> +		int ret;
> +
> +		ret =3D mchp_core_pwm_calc_period(chip, state, &prescale, &period_step=
s);
> +		if (ret)
> +			return ret;
> +
> +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> +	}
> +
> +	duty_steps =3D mchp_core_pwm_calc_duty(chip, pwm, state, prescale, peri=
od_steps);

Both mchp_core_pwm_calc_period and mchp_core_pwm_calc_duty call
clk_get_rate(), I suggest call this only once and pass the rate to these
two functions.

Both branches of the if above start with calling
mchp_core_pwm_calc_period, this could be simplified, too. (Hmm, in
exactly one of them you check the return code, wouldn't that be sensible
for both callers?)

> +
> +	/*
> +	 * Because the period is per channel, it is possible that the requested
> +	 * duty cycle is longer than the period, in which case cap it to the
> +	 * period, IOW a 100% duty cycle.
> +	 */
> +	if (duty_steps > period_steps)
> +		duty_steps =3D period_steps + 1;
> +
> +	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
> +
> +	mchp_core_pwm_enable(chip, pwm, true, state->period);
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hwyeg54cbb5bbxrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNqes4ACgkQwfwUeK3K
7AnSFwf+PIkiMVA8wQBff1BA/4EoZUeIOzE45R4Uenw4pyeZzQF+CGG0E4hH8tm8
GdOxIZwi8Owh7AA+1o0Jl9Us6V+ey7ffvWrsR93+nKRi54CyG3YmMD29XyS9VZhD
jMVSf5zKT3U6q8wSGYH8g8BkCn6PWDcyhA3zJ5S9dX11Mb0nMK5UAju80CgiD6+H
TrHmio3GgOpyNLXvZ2TTz2++EjaJkKFLoUdde+XFCeZ6IfGeBgoXDsueWkn/1csZ
MUWETlSehkbdk0d0VUuQUFXYz6QI9nzQohunxcseT1dDDPt13iO/vWJg1q1RX8kR
MZAIQeFgG/is429uXJjF7hPlpLs7Lw==
=zoyj
-----END PGP SIGNATURE-----

--hwyeg54cbb5bbxrg--
