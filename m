Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65C62E23E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiKQQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKQQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:50:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EABB8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:50:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovi5I-0000yr-1x; Thu, 17 Nov 2022 17:49:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovi5F-004t6w-Uq; Thu, 17 Nov 2022 17:49:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovi5G-00HKLR-AY; Thu, 17 Nov 2022 17:49:50 +0100
Date:   Thu, 17 Nov 2022 17:49:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20221117164950.cssukd63fywzuwua@pengutronix.de>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfxqckqdcukevw6b"
Content-Disposition: inline
In-Reply-To: <20221110093512.333881-2-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfxqckqdcukevw6b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> [...]
> +
> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 bool enable, u64 period)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> +	shift =3D pwm->hwpwm & 7;
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> +
> +	/*
> +	 * Notify the block to update the waveform from the shadow registers.
> +	 * The updated values will not appear on the bus until they have been
> +	 * applied to the waveform at the beginning of the next period. We must
> +	 * write these registers and wait for them to be applied before
> +	 * considering the channel enabled.
> +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> +	 */
> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> +		u64 delay;
> +
> +		delay =3D div_u64(period, 1000u) ? : 1u;
> +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +		usleep_range(delay, delay * 2);
> +	}

In some cases the delay could be prevented. e.g. when going from one
disabled state to another. If you don't want to complicate the driver
here, maybe point it out in a comment at least?

It's not well defined if pwm_apply should only return when the new
setting is actually active. (e.g. mxs doesn't wait)
So I wonder: Are there any hardware restrictions between setting the
SYNC_UPD flag and modifying the registers for duty and period? (I assume
writing a new duty and period might then result in a glitch if the
period just ends between the two writes.) Can you check if the hardware
waits on such a completion, e.g. by reading that register?

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

You're doing a copy of pwm->state just to use one of the members to pass
it to mchp_core_pwm_enable.

> +	bool period_locked;
> +	u64 duty_steps, clk_rate;

I think using unsigned long for clk_rate would be beneficial. The
comparison against NSEC_PER_SEC might get cheaper (depending on how
clever the compiler is), and calling mchp_core_pwm_calc_period
should get cheaper, too. (At least on 32 bit archs.)

> +	u16 prescale;
> +	u8 period_steps;
> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If clk_rate is too big, the following multiplication might overflow.
> +	 * However this is implausible, as the fabric of current FPGAs cannot
> +	 * provide clocks at a rate high enough.
> +	 */
> +	clk_rate =3D clk_get_rate(mchp_core_pwm->clk);
> +	if (clk_rate >=3D NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	mchp_core_pwm_calc_period(state, clk_rate, &prescale, &period_steps);
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
> +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> +	}
> +
> +	duty_steps =3D mchp_core_pwm_calc_duty(state, clk_rate, prescale, perio=
d_steps);
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

Don't you need to pass the previously configured period here?

> +
> +	return 0;
> +}
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tfxqckqdcukevw6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2ZisACgkQwfwUeK3K
7AnrTgf9HYxavojYs+4gm3beFsxWaNe5EjKTGTY2LOEMUKeDrsNMsabdx/fPb04m
s9szxna/p07wQ20Kp+zDSgDlbKyeCMm2m2aHh8K65jgUEZESRNmeUy7pXBAlXwX5
9Q39d6cI2b6LOMTaTevEpBlgWDe+wkBm6lyo+cewVxZyGilCHOP37QL+fdSbs/8d
1ryTwUkRU22vO6WnVD6mVlXin+43hNGtqKfrMQCAPolzOYBWAYEAwaKvr1mAujvy
DdnRO27Zi8BQI+oyFgD3WcldC4ss+pIeP1rm4VGgh/zIkwpsuh/iDtq8SFD+VjP4
27qpCZwIsuVNH3207VMs1/0j/BChXQ==
=cnPa
-----END PGP SIGNATURE-----

--tfxqckqdcukevw6b--
