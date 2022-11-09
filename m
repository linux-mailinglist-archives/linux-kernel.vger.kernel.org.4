Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE9622B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKIMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:01:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56BB2AC67
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:01:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osjlQ-0002aS-2z; Wed, 09 Nov 2022 13:01:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osjlO-003F1T-48; Wed, 09 Nov 2022 13:01:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osjlO-00FPUZ-53; Wed, 09 Nov 2022 13:01:02 +0100
Date:   Wed, 9 Nov 2022 13:01:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state
 succeed
Message-ID: <20221109120102.ylnseq2w33rvt7fz@pengutronix.de>
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4dabd3upl2gtggj"
Content-Disposition: inline
In-Reply-To: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
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


--t4dabd3upl2gtggj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Emil,

On Wed, Nov 09, 2022 at 12:37:24PM +0100, Emil Renner Berthing wrote:
> Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
> RGB and green PWM controlled LEDs on the HiFive Unmatched board
> managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
> All three colours of the RGB LED and the green LED run from different
> lines of the same PWM, but with the same period so this works fine when
> the LED drivers are loaded one after the other.
>=20
> Unfortunately it does expose a race in the PWM driver when both LED
> drivers are loaded at roughly the same time. Here is an example:
>=20
>   |          Thread A           |          Thread B           |
>   |  led_pwm_mc_probe           |  led_pwm_probe              |
>   |    devm_fwnode_pwm_get      |                             |
>   |      pwm_sifive_request     |                             |
>   |        ddata->user_count++  |                             |
>   |                             |    devm_fwnode_pwm_get      |
>   |                             |      pwm_sifive_request     |
>   |                             |        ddata->user_count++  |
>   |         ...                 |          ...                |
>   |    pwm_state_apply          |    pwm_state_apply          |
>   |      pwm_sifive_apply       |      pwm_sifive_apply       |
>=20
> Now both calls to pwm_sifive_apply will see that ddata->approx_period,
> initially 0, is different from the requested period and the clock needs
> to be updated. But since ddata->user_count >=3D 2 both calls will fail
> with -EBUSY, which will then cause both LED drivers to fail to probe.
>=20
> Fix it by letting the first call to pwm_sifive_apply update the clock
> even when ddata->user_count !=3D 1.
>=20
> Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/pwm/pwm-sifive.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 2d4fa5e5fdd4..b3c60ec72a6e 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  	mutex_lock(&ddata->lock);
>  	if (state->period !=3D ddata->approx_period) {
> -		if (ddata->user_count !=3D 1) {
> +		/*
> +		 * Don't let a 2nd user change the period underneath the 1st user.
> +		 * However if ddate->approx_period =3D=3D 0 this is the first time we =
set
> +		 * any period, so let whoever gets here first set the period so other
> +		 * users who agree on the period won't fail.
> +		 */
> +		if (ddata->user_count !=3D 1 && ddata->approx_period) {

While I'm convinced this works, we'd get some more uniform behaviour
compared to other hardwares with similar restrictions if you lock the
period on enabling the PWM instead of at request time. See for example
drivers/pwm/pwm-pca9685.c.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t4dabd3upl2gtggj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNrlnsACgkQwfwUeK3K
7AlrkQf9G9GElGNux4M68pXQEPSZJDjAV8oO0gxmQfv43z3is9nY68QEjQOD2paF
W31xuYFlImgRADsdTkBUOzijEhjiT35uOA6+9kKJYKfCth5e+7fq0hP57tWwzPCH
P21bpasJQr4VPiyUH6HLkQ4Pkh1twZuopyKSvhvWYne8GwxXbab2tq+mRGSQRP1r
I1bJbN/sLipjdWm0JEFicEPQbgxlRQzkH/4NK4h/nPlnByGmRFzHYYPQJtbabi4O
8cODRp/W85fl99I0SIXr/cRA0CILPSebb+M/KaMZHhjURQUIFB+UswJ77bT+jQl3
6uVWQ4qAMZlNDH0u+kTZSKOJC2cNBQ==
=hPjF
-----END PGP SIGNATURE-----

--t4dabd3upl2gtggj--
