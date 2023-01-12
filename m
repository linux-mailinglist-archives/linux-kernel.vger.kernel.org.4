Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9852F6671AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjALMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjALMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:07:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7EB58311
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:01:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFwH9-0005Oy-92; Thu, 12 Jan 2023 13:01:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFwH8-005WoO-9s; Thu, 12 Jan 2023 13:01:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFwH7-00CFus-H2; Thu, 12 Jan 2023 13:01:41 +0100
Date:   Thu, 12 Jan 2023 13:01:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230112120141.fpjwhtjuaxrwqt5m@pengutronix.de>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4lhg7s5jl5wrhlm7"
Content-Disposition: inline
In-Reply-To: <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
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


--4lhg7s5jl5wrhlm7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Conor,
>=20
> On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
> > +static void mchp_core_pwm_calc_period(const struct pwm_state *state, u=
nsigned long clk_rate,
> > +				      u16 *prescale, u8 *period_steps)
> > +{
> > +	u64 tmp;
> > +
> > +	/*
> > +	 * Calculate the period cycles and prescale values.
> > +	 * The registers are each 8 bits wide & multiplied to compute the per=
iod
> > +	 * using the formula:
> > +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> > +	 * so the maximum period that can be generated is 0x10000 times the
> > +	 * period of the input clock.
> > +	 * However, due to the design of the "hardware", it is not possible to
> > +	 * attain a 100% duty cycle if the full range of period_steps is used.
> > +	 * Therefore period_steps is restricted to 0xFE and the maximum multi=
ple
> > +	 * of the clock period attainable is 0xFF00.
> > +	 */
> > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > +
> > +	/*
> > +	 * The hardware adds one to the register value, so decrement by one to
> > +	 * account for the offset
> > +	 */
> > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > +
> > +		return;
> > +	}
> > +
> > +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> > +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> > +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
>=20
> This looks wrong, but I didn't think long about that. Did we discuss
> this already and/or are you sure this is correct?
>=20
> (We have:
> 	          (prescale + 1) * (period_steps + 1)
> 	period =3D ------------------------------------
> 	                       clk_rate
>=20

We want prescale small such that period_steps can be big to give
fine-grained control over the available duty_cycles. period_steps is a
8-bit value < 0xff, so we get:

                    period * clk_rate  =20
	prescale =3D ------------------- - 1
                   NSEC_PER_SEC * 0xff

which in code then reads:

	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX)
	if (*prescale)
		*prescale -=3D 1;


> You calculate
> 	            period * clk_rate
> 	prescale =3D -------------------
> 	           NSEC_PER_SEC * 0xff
>=20
> 	                     period * clk_rate
> 	period_steps =3D ----------------------------- - 1
> 	               NSEC_PER_SEC * (prescale + 1)

The formula for period_steps is right.

Please double-check!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4lhg7s5jl5wrhlm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO/9qIACgkQwfwUeK3K
7AmFOAf+LcIW/Q/o41Jo0SYTIKqNiVc8MCJ8FSZ5v0SSqxa4ucwpuLJub1/1dJQq
cGWtSHYNYfGguHiOa0vThFj4khBmXNqrnd87loLrKUJudDghyDOkeg78tdFBmUkR
Ha7gBC8VgtVevpY5ovGfx3vvNmqR4pw1rfin31XX6ZZ1CgQ7Wgi94rOev/DDzmbF
TD35FRy8IR95bbtXN7Rjr7UoulZakG1I32fDIV8UBCnWbNdjW35iJ43nX/ZCroNw
DgaRMyARSEbk8nZUWS2/3xl4CuPpbJFFW8MaKUoJRzgUKU8gu4ssVNPxtqmfDMhC
jQTFIN9SQbXfO02y36hg64cBQ5DcOA==
=xjC9
-----END PGP SIGNATURE-----

--4lhg7s5jl5wrhlm7--
