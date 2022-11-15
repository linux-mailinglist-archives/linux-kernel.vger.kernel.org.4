Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6E629660
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiKOKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKOKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:51:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B526AF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:51:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outXE-00026F-LC; Tue, 15 Nov 2022 11:51:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outXC-004QF8-Tg; Tue, 15 Nov 2022 11:51:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outXD-00GlyV-13; Tue, 15 Nov 2022 11:51:19 +0100
Date:   Tue, 15 Nov 2022 11:51:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@opendingux.net,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 5/5] pwm: jz4740: Use regmap_{set,clear}_bits
Message-ID: <20221115105118.l6lbxml555wsymwh@pengutronix.de>
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gnihahu4i6fskmsc"
Content-Disposition: inline
In-Reply-To: <20221024205213.327001-6-paul@crapouillou.net>
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


--gnihahu4i6fskmsc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 24, 2022 at 09:52:13PM +0100, Paul Cercueil wrote:
> Simplify a bit the code by using regmap_set_bits() and
> regmap_clear_bits() instead of regmap_update_bits() when possible.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index c0afc0c316a8..22fcdca66081 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -88,8 +88,7 @@ static int jz4740_pwm_enable(struct pwm_chip *chip, str=
uct pwm_device *pwm)
>  	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
> =20
>  	/* Enable PWM output */
> -	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
> -			   TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
> +	regmap_set_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm), TCU_TCSR_PWM_EN);
> =20
>  	/* Start counter */
>  	regmap_write(jz->map, TCU_REG_TESR, BIT(pwm->hwpwm));
> @@ -129,8 +128,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
>  	 * counter is stopped, while in TCU1 mode the order does not matter.
>  	 */
> -	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
> -			   TCU_TCSR_PWM_EN, 0);
> +	regmap_clear_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm), TCU_TCSR_PWM_EN);
> =20
>  	/* Stop counter */
>  	regmap_write(jz->map, TCU_REG_TECR, BIT(pwm->hwpwm));
> @@ -204,8 +202,8 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
> =20
>  	/* Set abrupt shutdown */
> -	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
> -			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
> +	regmap_set_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
> +			TCU_TCSR_PWM_SD);

Nitpick: the regmap_set_bits call is short enough to be put on a single
line.

Other than that (and even if the line is kept as is):

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gnihahu4i6fskmsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNzbyQACgkQwfwUeK3K
7AmbSwf/Vbly63K/TVaQF/YqwCnO4NaI6X6YWFJGufARIlaIZaZrEjKE6vNPlZ9N
oY5JFoew3R8sORqUkCd5NYoj6I4MObKpbXYqfI3Ws23JEbdAXxNWdAmcCTJoajeu
1pT8AoKG/2oGjJymU+sX4G++cbxayOfS1C+osRll+fqJSoBibQaL8n6wu3kxp4iy
aTMHB2RMrZucPHOnGzz8tpUiiGwAT60YCiEN/bGWjen43qWxiR0F933jJXqcx2qM
ofCPSYmp1tRxdfQDXj5j4S9z4OFnIfEoTwOMJL02aXukqbZZhVELu6RjKVuQsGYF
SV3kNxtNNYUzhjfvsM5B1Kt6KiHyyw==
=CVFN
-----END PGP SIGNATURE-----

--gnihahu4i6fskmsc--
