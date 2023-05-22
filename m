Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7670CB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEVUny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjEVUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:43:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13486B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:43:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1CNh-0002dU-H8; Mon, 22 May 2023 22:43:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1CNf-0025at-Pb; Mon, 22 May 2023 22:43:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1CNf-0071zQ-08; Mon, 22 May 2023 22:43:47 +0200
Date:   Mon, 22 May 2023 22:43:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <20230522204346.krb37yyzylxokslx@pengutronix.de>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <20230522172358.bw677efyovbrfwjg@pengutronix.de>
 <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lj5vxzcts2rym2l7"
Content-Disposition: inline
In-Reply-To: <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
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


--lj5vxzcts2rym2l7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Peter,

On Mon, May 22, 2023 at 09:28:39PM +0200, Peter Rosin wrote:
> 2023-05-22 at 19:23, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
> >> I have a device with a "sound card" that has an amplifier that needs
> >> an extra boost when high amplification is requested. This extra
> >> boost is controlled with a pwm-regulator.
> >>
> >> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
> >> device no longer works. I have tracked the problem to an unfortunate
> >> interaction between the underlying PWM driver and the PWM core.
> >>
> >> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
> >> the period and/or duty_cycle from the HW when the PWM is not enabled.
> >> Because of this, I think, the driver does not fill in .period and
> >> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.
> >>
> >> However, the PWM core is not expecting these fields to be left as-is,
> >> at least not in pwm_adjust_config(), and its local state variable on
> >> the stack ends up with whatever crap was on the stack on entry for
> >> these fields. That fails spectacularly when the function continues to
> >> do math on these uninitialized values.

After looking again, I don't understand that part. Note that
pwm_get_state() doesn't call .get_state() at all. Also pwmchip_add()
zero initializes .state, then pwm_get() calls .get_state() (via
pwm_device_request() which is called in .xlate()) which (if the HW is
disabled) doesn't touch .period, so it should continue to be zero?!

So I wonder why your approach 2 works at all. Do you see what I'm
missing?

> >> In particular, I find this in the kernel log when a bad kernel runs:
> >> pwm-regulator: probe of reg-ana failed with error -22
> >>
> >> Before commit c73a3107624d this was a silent failure, and the situation
> >> "repaired itself" when the PWM was later reprogrammed, at least for my
> >> case. After that commit, the failure is fatal and the "sound card"
> >> fails to come up at all.
> >>
> >>
> >> I see a couple of adjustments that could be made.
> >>
> >> 1. Zero out some fields in the driver:
> >>
> >> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> >>  		state->enabled =3D true;
> >>  	} else {
> >> +		state->period =3D 0;
> >> +		state->duty_cycle =3D 0;
> >>  		state->enabled =3D false;
> >>  	}
> >=20
> > I don't particularily like that. While state->period is an invalid
> > value, IMHO enabled =3D false is enough information from the driver's P=
OV.
>=20
> This was the preferred approach of Thierry, and given the number of
> call sites for pwm_get_state with a local variable, I can sympathize
> with that view.

I looked a bit more into the issue and think that pwm_get_state() isn't
problematic. pwm_get_state() fully assigns *state.

> At the same time, fixing drivers one by one is not
> a fun game, so I can certainly see that approach 3 also has an appeal.

What I don't like about it is that the output of a disabled PWM doesn't
have a period. There might be one configured in hardware(, and the
=2Eget_state() callback might or might not return that), but the emitted
signal has no well-defined period.

> >> 2. Don't try to "adjust" a disabled PWM:
> >>
> >> @@ -656,7 +656,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
> >>  	 * In either case, we setup the new period and polarity, and assign a
> >>  	 * duty cycle of 0.
> >>  	 */
> >> -	if (!state.period) {
> >> +	if (!state.enabled || !state.period) {
> >>  		state.duty_cycle =3D 0;
> >>  		state.period =3D pargs.period;
> >>  		state.polarity =3D pargs.polarity;
> >=20
> > In my book code that calls pwm_get_state() should consider .period
> > (and .duty_cycle) undefined if .enabled is false. So this hunk is an
>=20
> I agree fully. This feels like a good hunk.
>=20
> > improvement. Having said that, I think pwm_adjust_config() has a strange
> > semantic. I don't understand when you would want to call it, and it only
> > has one caller (i.e. pwm-regulator).
>=20
> I believe it's for a case where some bootstrap/bootloader has configured
> a PWM in order to set up a regulator for some critical component, and the
> kernel needs to cake over the responsibility seamlessly, or everything
> will take a dive. I deduced that from the description of pwm_adjust_confi=
g:

If it wants to take over seamlessly, it shouldn't call pwm_apply_state()
at all?!

>  * This function will adjust the PWM config to the PWM arguments provided
>  * by the DT or PWM lookup table. This is particularly useful to adapt
>  * the bootloader config to the Linux one.
>=20
> But what do I know?

> > So another option would be
> >=20
> > diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-=
regulator.c
> > index b64d99695b84..418aff0ddbed 100644
> > --- a/drivers/regulator/pwm-regulator.c
> > +++ b/drivers/regulator/pwm-regulator.c
> > @@ -368,10 +368,6 @@ static int pwm_regulator_probe(struct platform_dev=
ice *pdev)
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D pwm_adjust_config(drvdata->pwm);
> > -	if (ret)
> > -		return ret;
> > -
> >  	regulator =3D devm_regulator_register(&pdev->dev,
> >  					    &drvdata->desc, &config);
> >  	if (IS_ERR(regulator)) {
> >=20
> > and drop pwm_adjust_config() as a followup?!
>=20
> As described above, I think that might be too drastic?
>=20
> >> 3. Zero out the state before calling pwm_get_state:
> >>
> >> @@ -115,7 +115,7 @@ static int pwm_device_request(struct pwm_device *p=
wm, const char *label)
> >>  	}
> >> =20
> >>  	if (pwm->chip->ops->get_state) {
> >> -		struct pwm_state state;
> >> +		struct pwm_state state =3D { .enabled =3D true };
> >=20
> > I wonder why you picked .enabled =3D true here but =3D false on all oth=
er
> > code locations.
>=20
> Silly typo, soory.
>=20
> > Also you don't seem to have 1271a7b98e7989ba6bb978e14403fc84efe16e13
> > which has the same effect and is included in v6.3 and v6.2.13.
>=20
> Right, approach 3 felt so ugly and intrusive that I didn't bother to take
> it beyond the problematic commit (and hinted at that further down: "It al=
so
> needs a rebase from the culprit commit"). Having said that, 1271a7b98e79 =
is
> not enough, or else I would never have noticed the problem in the first
> place. I don't think the hunk in pwm_dbg_show() makes any difference for =
my
> case since I heven't enabled debugging, and a double-check confirms it:
> After 1271a7b98e79, zeroing "state" in pwm_adjust_config() is enough to k=
ill
> this regression.

That really puzzles me because pwm_get_state() fully overwrites state.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lj5vxzcts2rym2l7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRr1AEACgkQj4D7WH0S
/k6m9wgAqr7YBrSh855sAczvqDnp4DuhD9OPmkC6UdYrzKsVGabFIzehyOuHXBdn
7fAPf+e4iFv5WlnKpTfVk/j4VnYJYpAXCuLguE7tY88mUt0W5VsgvIdOJkRcKmXm
l8cOwl6XrJrORqbymRaiBeKheehkD73K6qaN+Pjl0OfMDu1huQWhS8eoOmByPZ8F
VRan5HWuvxZ8Fkb83QCf8VhJkJWQDaIddHqfyWg1QeSHEy3HyMMF9SzNFFaIgnNX
kivCNuib0AR18lEvPfKy9VioU1gOh3HJbhpGNSIcBvlG98PLMtOA7m3wG2YdKBIh
Z/ggvftDYw+zXnwQMGL9OMguUJ4ukg==
=HxTN
-----END PGP SIGNATURE-----

--lj5vxzcts2rym2l7--
