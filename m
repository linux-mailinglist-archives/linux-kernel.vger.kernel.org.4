Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF470C434
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEVRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjEVRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:24:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1C11A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:24:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q19GL-0002hq-61; Mon, 22 May 2023 19:24:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q19GJ-0023ol-Lc; Mon, 22 May 2023 19:23:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q19GI-006zWk-RO; Mon, 22 May 2023 19:23:58 +0200
Date:   Mon, 22 May 2023 19:23:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <20230522172358.bw677efyovbrfwjg@pengutronix.de>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ct6t2sgx5zajyak2"
Content-Disposition: inline
In-Reply-To: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
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


--ct6t2sgx5zajyak2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Peter,

On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
> I have a device with a "sound card" that has an amplifier that needs
> an extra boost when high amplification is requested. This extra
> boost is controlled with a pwm-regulator.
>=20
> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
> device no longer works. I have tracked the problem to an unfortunate
> interaction between the underlying PWM driver and the PWM core.
>=20
> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
> the period and/or duty_cycle from the HW when the PWM is not enabled.
> Because of this, I think, the driver does not fill in .period and
> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.
>=20
> However, the PWM core is not expecting these fields to be left as-is,
> at least not in pwm_adjust_config(), and its local state variable on
> the stack ends up with whatever crap was on the stack on entry for
> these fields. That fails spectacularly when the function continues to
> do math on these uninitialized values.
>=20
> In particular, I find this in the kernel log when a bad kernel runs:
> pwm-regulator: probe of reg-ana failed with error -22
>=20
> Before commit c73a3107624d this was a silent failure, and the situation
> "repaired itself" when the PWM was later reprogrammed, at least for my
> case. After that commit, the failure is fatal and the "sound card"
> fails to come up at all.
>=20
>=20
> I see a couple of adjustments that could be made.
>=20
> 1. Zero out some fields in the driver:
>=20
> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  		state->enabled =3D true;
>  	} else {
> +		state->period =3D 0;
> +		state->duty_cycle =3D 0;
>  		state->enabled =3D false;
>  	}

I don't particularily like that. While state->period is an invalid
value, IMHO enabled =3D false is enough information from the driver's POV.
=20
> 2. Don't try to "adjust" a disabled PWM:
>=20
> @@ -656,7 +656,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
>  	 * In either case, we setup the new period and polarity, and assign a
>  	 * duty cycle of 0.
>  	 */
> -	if (!state.period) {
> +	if (!state.enabled || !state.period) {
>  		state.duty_cycle =3D 0;
>  		state.period =3D pargs.period;
>  		state.polarity =3D pargs.polarity;

In my book code that calls pwm_get_state() should consider .period
(and .duty_cycle) undefined if .enabled is false. So this hunk is an
improvement. Having said that, I think pwm_adjust_config() has a strange
semantic. I don't understand when you would want to call it, and it only
has one caller (i.e. pwm-regulator).

So another option would be

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regu=
lator.c
index b64d99695b84..418aff0ddbed 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -368,10 +368,6 @@ static int pwm_regulator_probe(struct platform_device =
*pdev)
 		return ret;
 	}
=20
-	ret =3D pwm_adjust_config(drvdata->pwm);
-	if (ret)
-		return ret;
-
 	regulator =3D devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {

and drop pwm_adjust_config() as a followup?!

> 3. Zero out the state before calling pwm_get_state:
>=20
> @@ -115,7 +115,7 @@ static int pwm_device_request(struct pwm_device *pwm,=
 const char *label)
>  	}
> =20
>  	if (pwm->chip->ops->get_state) {
> -		struct pwm_state state;
> +		struct pwm_state state =3D { .enabled =3D true };

I wonder why you picked .enabled =3D true here but =3D false on all other
code locations.

Also you don't seem to have 1271a7b98e7989ba6bb978e14403fc84efe16e13
which has the same effect and is included in v6.3 and v6.2.13.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ct6t2sgx5zajyak2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRrpS0ACgkQj4D7WH0S
/k4Emgf/TpFzqInEN8384Yxl4FNTRnNNNeP5Q+tXuQABE2v0mbyjPWyZWa9MWN2v
Pz04/t0haINZnUtvCpDVqnSpGHLiZEYhyA75jqySOjQxkF63FCrHQNweBSwx59io
jvjOcsTYyd++Es1nKzaKVUha/FtnHw1QVm2k7yUeJhQCsdeITTWVxUJaSJGW54Kq
8n+grk5hGdX4la9THRTr4h4p4bGMacnX9V/BZW7IPYjrD7WUIatb+PaWZlmceLCM
D2p0h/flIUXdLSAA7Vu9WSS4UynM1wpPCI47QTL9V/spRBKAka00hjwy7maDpBWq
Y9S/M5yoAqkmNU4nV9mMSgqB8YtRHg==
=uSTk
-----END PGP SIGNATURE-----

--ct6t2sgx5zajyak2--
