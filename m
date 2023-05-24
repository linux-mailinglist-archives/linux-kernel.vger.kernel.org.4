Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7131170EDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjEXGh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbjEXGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:37:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98518D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:37:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1i7Y-0003AK-JT; Wed, 24 May 2023 08:37:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1i7X-002QOl-Gl; Wed, 24 May 2023 08:37:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1i7W-007T24-Rd; Wed, 24 May 2023 08:37:14 +0200
Date:   Wed, 24 May 2023 08:37:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <20230524063714.dkuwyyikpkfco42x@pengutronix.de>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <20230522172358.bw677efyovbrfwjg@pengutronix.de>
 <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
 <20230522204346.krb37yyzylxokslx@pengutronix.de>
 <ZG0itIIg48IGuC8R@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zmiibewdkp7eyng"
Content-Disposition: inline
In-Reply-To: <ZG0itIIg48IGuC8R@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zmiibewdkp7eyng
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, May 23, 2023 at 10:31:48PM +0200, Thierry Reding wrote:
> On Mon, May 22, 2023 at 10:43:46PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 22, 2023 at 09:28:39PM +0200, Peter Rosin wrote:
> > > 2023-05-22 at 19:23, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
> > > >> I have a device with a "sound card" that has an amplifier that nee=
ds
> > > >> an extra boost when high amplification is requested. This extra
> > > >> boost is controlled with a pwm-regulator.
> > > >>
> > > >> As of commit c73a3107624d ("pwm: Handle .get_state() failures") th=
is
> > > >> device no longer works. I have tracked the problem to an unfortuna=
te
> > > >> interaction between the underlying PWM driver and the PWM core.
> > > >>
> > > >> The driver is drivers/pwm/pwm-atmel.c which has difficulties getti=
ng
> > > >> the period and/or duty_cycle from the HW when the PWM is not enabl=
ed.
> > > >> Because of this, I think, the driver does not fill in .period and
> > > >> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enab=
led.
> > > >>
> > > >> However, the PWM core is not expecting these fields to be left as-=
is,
> > > >> at least not in pwm_adjust_config(), and its local state variable =
on
> > > >> the stack ends up with whatever crap was on the stack on entry for
> > > >> these fields. That fails spectacularly when the function continues=
 to
> > > >> do math on these uninitialized values.
> >=20
> > After looking again, I don't understand that part. Note that
> > pwm_get_state() doesn't call .get_state() at all. Also pwmchip_add()
> > zero initializes .state, then pwm_get() calls .get_state() (via
> > pwm_device_request() which is called in .xlate()) which (if the HW is
> > disabled) doesn't touch .period, so it should continue to be zero?!
> >=20
> > So I wonder why your approach 2 works at all. Do you see what I'm
> > missing?
> >=20
> > > >> In particular, I find this in the kernel log when a bad kernel run=
s:
> > > >> pwm-regulator: probe of reg-ana failed with error -22
> > > >>
> > > >> Before commit c73a3107624d this was a silent failure, and the situ=
ation
> > > >> "repaired itself" when the PWM was later reprogrammed, at least fo=
r my
> > > >> case. After that commit, the failure is fatal and the "sound card"
> > > >> fails to come up at all.
> > > >>
> > > >>
> > > >> I see a couple of adjustments that could be made.
> > > >>
> > > >> 1. Zero out some fields in the driver:
> > > >>
> > > >> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip=
 *chip, struct pwm_device *pwm,
> > > >>  		state->enabled =3D true;
> > > >>  	} else {
> > > >> +		state->period =3D 0;
> > > >> +		state->duty_cycle =3D 0;
> > > >>  		state->enabled =3D false;
> > > >>  	}
> > > >=20
> > > > I don't particularily like that. While state->period is an invalid
> > > > value, IMHO enabled =3D false is enough information from the driver=
's POV.
> > >=20
> > > This was the preferred approach of Thierry, and given the number of
> > > call sites for pwm_get_state with a local variable, I can sympathize
> > > with that view.
> >=20
> > I looked a bit more into the issue and think that pwm_get_state() isn't
> > problematic. pwm_get_state() fully assigns *state.
> >=20
> > > At the same time, fixing drivers one by one is not
> > > a fun game, so I can certainly see that approach 3 also has an appeal.
> >=20
> > What I don't like about it is that the output of a disabled PWM doesn't
> > have a period. There might be one configured in hardware(, and the
> > .get_state() callback might or might not return that), but the emitted
> > signal has no well-defined period.
>=20
> Well, this is a bit of a gray area, admittedly. .get_state() was not
> designed with regards to drivers that are unable to read the hardware
> state. Essentially if you can't read the full hardware state, the
> assumption was that you just shouldn't provide a .get_state() callback
> at all.
>=20
> In retrospect that's perhaps not ideal, and as you pointed out this is
> all a bit moot as of v6.3 because the initial state is now effectively
> zeroed out already.
>=20
> But just to address your point about enabled =3D false being enough: it's
> not. The reason is that consumers should be able to do something along
> these lines:
>=20
> 	pwm_get_state(pwm, &state);
> 	state.enabled =3D true;
> 	pwm_apply_state(pwm, &state);
>=20
> And expect the device to do something reasonable. If the PWM isn't
> properly configured, that pwm_apply_state() should return an error. If
> ->get_state() returned random values, that may not be guaranteed. With
> v6.3, the above should return -EINVAL for pwm-atmel because period ends
> up being 0 and we check for that explicitly. And that's really the only
> sane behavior for drivers that can't read back the full hardware state.

This is something that we don't agree about. IMHO it's better if
consumers specify the state they want to apply completely themselves
without using pwm_get_state(). I'm convinced that many people don't
understand pwm_get_state() and the resulting corner cases.

One such corner case is the one we hit here, that pwm_get_state() can
return a state that cannot be reapplied. Another common misunderstanding
is that (apart from directly after driver init (or was it after each
request?)) pwm_get_state() isn't about the actual HW state, but about
the state that was last applied successfully.

Do you think that I should be able to do:

	pwm_apply(mypwm, &(struct pwm_state){ .period =3D 0, .duty_cycle =3D 0, .e=
nabled =3D false, .polarity =3D PWM_POLARITY_NORMAL });

? This should be enough for a driver to know what to do. After that,
what is the "reasonable" thing that should happen if I follow up with

 	pwm_get_state(pwm, &state);
 	state.enabled =3D true;
 	pwm_apply_state(pwm, &state);

?

The current state is that the first pwm_apply() fails. I didn't check,
but I can imagine that there are other combinations of (state, lowlevel
driver) where pwm_apply() succeeds with .enabled =3D false but not with
=2Eenabled =3D true. (For example consider a driver that can only do
inversed polarity, or polarity > 100000. What should happen when I call

	pwm_apply(mypwm, &(struct pwm_state){ .period =3D 100, .duty_cycle =3D 20,=
 .enabled =3D false, .polarity =3D PWM_POLARITY_NORMAL });

?)

If I was to design a PWM API today, I'd consider to not put .enabled
into pwm_state. With that enabled =3D true would be implied for
pwm_apply_state(), and there would be a separate pwm_disable().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4zmiibewdkp7eyng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRtsJkACgkQj4D7WH0S
/k7rDggArf5zaA2qcXfUd+ZJgysORb7RYwPUMGU7Hh9sSyT3OEnd9vaW/sDXlKZu
O+3UE8x4oni9BwS9NFRhdIJ0l4gw9If8YCJIGNuwyI1WCnHSo5uUr1TZNYIlUl3a
lolISPQ8OI5Zenilhsci0LkxS1dhk0TX7B75ICyPPxgmC6YbLzoZ+kXmlSx0FcwO
Mhpctrbe0we3qkqdQ2wAUNfx/XqqOrHOvTPvz6JxTFPQcfrvKYng1zvnZ2029oXW
KHKXQ4t8QoNisMBvxexWUsbCf7cQm/2H4SBMd//H9KIKzRrEYa78lcKbU60ZGV/R
TznTIVgRmX81xqNvRn2iM5AcEI3/rQ==
=ykOq
-----END PGP SIGNATURE-----

--4zmiibewdkp7eyng--
