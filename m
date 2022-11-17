Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76CB62E65D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiKQVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbiKQVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:06:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894661516
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovm3n-0005xi-Jl; Thu, 17 Nov 2022 22:04:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovm3l-004v4s-NC; Thu, 17 Nov 2022 22:04:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovm3l-00HMbJ-FU; Thu, 17 Nov 2022 22:04:33 +0100
Date:   Thu, 17 Nov 2022 22:04:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20221117210433.n5j7upqqksld42mu@pengutronix.de>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nahsannukws2i2lv"
Content-Disposition: inline
In-Reply-To: <Y3Zxkt3OSPQc46Q2@spud>
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


--nahsannukws2i2lv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 05:38:26PM +0000, Conor Dooley wrote:
> On Thu, Nov 17, 2022 at 05:49:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Conor,
>=20
> Hello Uwe,
>=20
> > On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> > > [...]
> > > +
> > > +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > > +				 bool enable, u64 period)
> > > +{
> > > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> > > +	u8 channel_enable, reg_offset, shift;
> > > +
> > > +	/*
> > > +	 * There are two adjacent 8 bit control regs, the lower reg controls
> > > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> > > +	 * and if so, offset by the bus width.
> > > +	 */
> > > +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > > +	shift =3D pwm->hwpwm & 7;
> > > +
> > > +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> > > +	channel_enable &=3D ~(1 << shift);
> > > +	channel_enable |=3D (enable << shift);
> > > +
> > > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> > > +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> > > +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> > > +
> > > +	/*
> > > +	 * Notify the block to update the waveform from the shadow register=
s.
> > > +	 * The updated values will not appear on the bus until they have be=
en
> > > +	 * applied to the waveform at the beginning of the next period. We =
must
> > > +	 * write these registers and wait for them to be applied before
> > > +	 * considering the channel enabled.
> > > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > > +	 */
> > > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > +		u64 delay;
> > > +
> > > +		delay =3D div_u64(period, 1000u) ? : 1u;
> > > +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > > +		usleep_range(delay, delay * 2);
> > > +	}
> >=20
> > In some cases the delay could be prevented. e.g. when going from one
> > disabled state to another. If you don't want to complicate the driver
> > here, maybe point it out in a comment at least?
>=20
> Maybe this is my naivity talking, but I'd rather wait. Is there not the
> chance that we re-enter pwm_apply() before the update has actually gone
> through?

My idea was to do something like that:

	int mchp_core_pwm_apply(....)
	{
		if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
			/*
			 * We're still waiting for an update, don't
			 * interfer until it's completed.
			 */
			while (readl_relaxed(mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD)) {
				cpu_relax();
				if (waited_unreasonably_long())
					return -ETIMEOUT;
			}
		}

		update_period_and_duty(...);
		return 0;
	}

This way you don't have to wait at all if the calls to pwm_apply() are
infrequent. Of course this only works this way, if you can determine if
there is a pending update.

=46rom a simplicity POV always waiting is fine. But if you consider
periods of say 5s, letting a call to pwm_apply() do a sleep between 5
and 10 seconds at the end is quite long and blocks the caller
considerably.

> IIRC, but I'll have to confirm it, when the "shadow registers" are
> enabled reads show the values that the hardware is using rather than the
> values that are queued in the shadow registers. I'd rather avoid that
> sort of mess and always sleep.
>=20
> Now that I think of it, the reason I moved to unconditionally sleeping
> was that if I turned on the PWM debugging it'd get tripped up. When it
> tried to read the state, it got the old one rather than what'd just been
> written.
>=20
> Pasting my comment from above:
> > > +	/*
> > > +	 * Notify the block to update the waveform from the shadow register=
s.
> > > +	 * The updated values will not appear on the bus until they have be=
en
>=20
> By "bus" in this statement, I meant on the AXI/AHB etc bus that the IP
> core is connected to the CPUs on rather than the output. Perhaps my
> wording of the comment could be improved and replace the word "bus" with
> some wording containing "CPU" instead. "The updated values will not
> appear to the CPU until" maybe.

I'd write: Reading the registers yields the currently implemented
settings, the new ones are only readable once the current period ended.

> I can also add some words relating to unconditionally sleeping w.r.t to
> disabled states.
>=20
> > > +	 * applied to the waveform at the beginning of the next period. We =
must
> > > +	 * write these registers and wait for them to be applied before
> > > +	 * considering the channel enabled.
> > > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > > +	 */
>=20
> > It's not well defined if pwm_apply should only return when the new
> > setting is actually active. (e.g. mxs doesn't wait)
> > So I wonder: Are there any hardware restrictions between setting the
> > SYNC_UPD flag and modifying the registers for duty and period? (I assume
> > writing a new duty and period might then result in a glitch if the
> > period just ends between the two writes.) Can you check if the hardware
> > waits on such a completion, e.g. by reading that register?
>=20
> Not entirely sure by what you mean: "waits on such a completion".

I wanted to say that it's okish to return from .apply() without the
sleep and so return to the caller before the requested setting appears
on the output. At least your driver wouldn't be the first to do it that
way.

> The hardware updates the registers at the first end-of-period after
> SYNC_UPD is set. Don't write the bit, nothing happens. From the docs:
>=20
> > > A shadow register holds all values and writes them when the SYNC_UPDA=
TE
> > > register is set to 1. In other words, for all channel synchronous
> > > updates, write a "1" to the SYNC_UPDATE register after writing to all
> > > the channel registers.
>=20
> The docs also say:
> > > SYNC_UPDATE: When this bit is set to "1" and SHADOW_REG_EN
> > > is selected, all POSEDGE and NEGEDGE registers are updated
> > > synchronously. Synchronous updates to the PWM waveform occur only
> > > when SHADOW_REG_EN is asserted and SYNC_UPDATE is set to =E2=80=9C1=
=E2=80=9D.
> > >
> > > When this bit is set to "0", all the POSEDGE and NEGEDGE registers
> > > are updated asynchronously
>=20
> The second statement is at best vague (if the this bit in "when this
> bit" refers to the bit in SHADOW_REG_EN) or contradictory at worse.
> I suspect it's the former meaning, as shadow registers are a per-channel
> thing. I suppose I have to go get some docs changed, **sigh**. It
> doesn't make all that much sense to me, SHADOW_REG_EN is a RTL parameter
> not a register that can be accessed from the AXI interface.
>=20
> Anyways, back to the topic at hand.. if you were to do the following
> (in really pseudocode form..):
> 	write(SYNC_UPD)
> 	write(period)
> 	<end-of-period>
> 	write(duty)
>=20
> Then the duty cycle would not get updated, ever. At least, per doc
> comment #1 & my "experimental" data. The RTL is rather dumb, since
> AFAICT, this is meant to be cheap to implement in FPGA fabric.
> Hence the default core configuration option is no shadow registers
> & just immediately updates the output, waveform glitches be damned.
>=20
> Hopefully that all helps?

I already understood it that way. I hope I was able to clarify my
thoughts above.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nahsannukws2i2lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2od0ACgkQwfwUeK3K
7AkmIgf/QDnwDWEy63v0DTdlBr8KYNZcGvSmG2iAH+MSGkq04vdNf7nRn3DpA4Ly
Up8fG0bGvILO2oJM2Tr+I2/PC74IFr79Sl663KSpWZ+IJx5UVhBWyTmq6T0wqR3I
nz745fsukB8BtKmV1YFQqclvtczdgfw0mypqK39qaapZrqJVEg6Shn4jLBRvgjPZ
cY1gsiTWb45D3SeiHNDM0ZUOKwA2fgInfFEIsuArJ62Yzy4GGL7iFvw8GlAW2tSK
wFXOLJ//XK4qcHQcEn+4q2QWOqmqatBvluXUVhriHYy4b2jhuQNXRr+qSe2OsJPt
qdHO0aGzN36TTot+RG5xvHjE0BtX4A==
=5Vm0
-----END PGP SIGNATURE-----

--nahsannukws2i2lv--
