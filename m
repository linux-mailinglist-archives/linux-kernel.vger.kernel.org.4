Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD06C630B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCWJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:14:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324C118
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:14:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH1O-0002OG-Ka; Thu, 23 Mar 2023 10:14:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH1N-0067Hp-SS; Thu, 23 Mar 2023 10:14:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH1N-007IJc-6Q; Thu, 23 Mar 2023 10:14:09 +0100
Date:   Thu, 23 Mar 2023 10:14:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v14 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230323091409.rdi4bqrcsfvxnht5@pengutronix.de>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
 <20230306094858.1614819-2-conor.dooley@microchip.com>
 <20230322105536.kgt3ffowefqlg6eu@pengutronix.de>
 <48c7dbdc-04a2-42de-964f-fd86cf070797@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcpu2vbk2lpe4rlh"
Content-Disposition: inline
In-Reply-To: <48c7dbdc-04a2-42de-964f-fd86cf070797@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mcpu2vbk2lpe4rlh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Wed, Mar 22, 2023 at 10:49:40PM +0000, Conor Dooley wrote:
> On Wed, Mar 22, 2023 at 11:55:36AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Mar 06, 2023 at 09:48:58AM +0000, Conor Dooley wrote:
> > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> > > +static void mchp_core_pwm_calc_period(const struct pwm_state *state,=
 unsigned long clk_rate,
> > > +				      u16 *prescale, u16 *period_steps)
> > > +{
> > > +	u64 tmp;
> > > +
> > > +	/*
> > > +	 * Calculate the period cycles and prescale values.
> > > +	 * The registers are each 8 bits wide & multiplied to compute the p=
eriod
> > > +	 * using the formula:
> > > +	 *           (prescale + 1) * (period_steps + 1)
> > > +	 * period =3D -------------------------------------
> > > +	 *                      clk_rate
> > > +	 * so the maximum period that can be generated is 0x10000 times the
> > > +	 * period of the input clock.
> > > +	 * However, due to the design of the "hardware", it is not possible=
 to
> > > +	 * attain a 100% duty cycle if the full range of period_steps is us=
ed.
> > > +	 * Therefore period_steps is restricted to 0xFE and the maximum mul=
tiple
> > > +	 * of the clock period attainable is 0xFF00.
> > > +	 */
> > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > > +
> > > +	/*
> > > +	 * The hardware adds one to the register value, so decrement by one=
 to
> > > +	 * account for the offset
> > > +	 */
> > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > > +
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The optimal value for prescale can be calculated using the maxim=
um
> > > +	 * permitted value of period_steps, 0xff.
> >=20
> > I had to think about that one for a while. The maximal value for
> > (period_steps + 1) is 0xff with the reasoning above?! That's also what
> > the code uses.
>=20
> I've become really disenfranchised with these register/variable names.
> I feel like just changing them to disconnect the variables used for
> calculation from the register names a little, so that the "is there a +1
> needed here or not" stuff becomes a little clearer.

Full ack, I considered asking for that, but after some time I was in the
"I reviewed the patch today"-mode (which is quite similar to the mode
you described :-) and forgot. (Even in that mode the PREG_TO_VAL macro
annoyed me a bit.)

> It always makes sense to be when I am in an "I respun the patch today"
> mode, but by the time we're in the review stage I get muddled.
> God forbid I have to look at this in 10 years time.
>=20
> That said, there is a bit of a mistake here. The comment two above says
> "Therefore period_steps is restricted to 0xFE" when I'm capping things
> off. Some inaccuracies have probably snuck in during the various
> respins, and I think the comment above is "correct" but misleading, as
> it muddies the waters about variable versus register names.

I think it's sensible to only talk about either the register values or
the factors. I tend to think that talking about the register values is
easier at the end and recommend not to hide the +1 (or -1) in a macro.

Having said that here are my results of thinking a bit about how to
choose register values:

Let r(p) denote the period that is actually configured if p is
requested.

The nice properties we want (i.e. those a consumer might expect?) are:

 a) =E2=88=80p: r(p) =E2=89=A4 p
    i.e. never configure a bigger period than requested
    (This is a bit arbitrary, but nice to get a consistent behaviour for
    all drivers and easier to handle than requesting the nearest
    possible period.)

 b) =E2=88=80p, q: p =E2=89=A4 q =E2=9F=B9 r(p) =E2=89=A4 r(q)
    i.e. monotonicity

 c) =E2=88=80p: r(roundup(r(p))) =3D r(p)
    i.e. idempotency

 d) =E2=88=80p, q: r(p) =E2=89=A4 q =E2=9F=B9 r(p) =E2=89=A4 r(q)
    i.e. pick the biggest possible period

(Sidenote: d) and a) imply b) and c))

If you always set period_steps to 0xfe
(in Python syntax:

	tmp =3D p * clkrate // NSPS
	period_steps =3D 0xfe
	prescale =3D tmp // (period_steps + 1) - 1

) you get this consistent behaviour.

This has the upside of being easy to implement and cheap to run.
Downside is that it's coarse and fails to implement periods that would
require e.g prescale =3D 0 and period_steps < 0xfe. As period_steps is
big, the domain to chose the duty cycle from is good.

If you pick period_steps and prescale such that
	(period_steps + 1) * (prescale + 1)
is the maximal value that makes r(p) =E2=89=A4 p you have an increased runt=
ime
because you have to test multiple values for period_steps. I don't think
there is an algorithm without a loop to determine an optimal pair?!
Usually this gives a better match that the easy algorithm above for the
period, but the domain for duty_cycle is (usually) smaller.
I think we have a) and d) here, so that's good.

I think for most consumers a big domain for duty_cycle is more important
that a good match for the requested period. So I tend to recommend the
easy algorithm, but I'm not religious about that and open for other
opinion and reasoning.

> > > +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> >=20
> > This one is just for the case where there is an unapplied configuration
> > in the registers, right?
>=20
> No, this is me realising that I had a misconception about how that
> register works. You write the bit once, and it enables the mode for
> channels that have been configured that way at synthesis-time, rather
> than how I somehow thought it worked which was as a "flush" from the
> shadow registers into the "real" ones.

Then I think I got that wrong in the same way.  Should this be better
described in a comment then? (I didn't recheck, maybe there is a good
description already?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mcpu2vbk2lpe4rlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQcGGAACgkQj4D7WH0S
/k7AyQf/VnxyOnNUOmfJLLttKEx14VUW+0kW/dn5t7afngAGM3RlLwkqrL9Xhct8
7EyKdqi/ryR0an9FKZZEpQ5C1r84DvY0iA6G5zuh1FmJ2kedAY998etfHX9s6J5s
wXH3mmnjUgCtTeChJT+F/77vrTbQz30SFbTBPfEAFSiAevVQBcf55PR8tH4TJnEc
hB7FdJYSIwjnIwehGde4+1h4H8jjRqlicAGkUIFGVfpuvvgdMrnYxheVTLep1E3i
BJ3HDseOikZ7kEZ6mlssmboSsRGcr/iJowF8DoHJfZNDNCwGcVEsImwE/g1brd0v
hjqMBNigKpMP2gfrd5oFivgYNmEOoA==
=eb1f
-----END PGP SIGNATURE-----

--mcpu2vbk2lpe4rlh--
