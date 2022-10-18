Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEA602CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJRN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:29:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE21005C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:29:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1okmeq-0000U6-8n; Tue, 18 Oct 2022 15:29:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okmeo-002Hwp-Pu; Tue, 18 Oct 2022 15:29:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okmeo-008os2-1H; Tue, 18 Oct 2022 15:29:22 +0200
Date:   Tue, 18 Oct 2022 15:29:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: sifive: Always let the first pwm_apply_state
 succeed
Message-ID: <20221018132921.5fsbiz254npk2fci@pengutronix.de>
References: <20221018091316.415685-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4mm6vvxtocb2k52r"
Content-Disposition: inline
In-Reply-To: <20221018091316.415685-1-emil.renner.berthing@canonical.com>
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


--4mm6vvxtocb2k52r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 18, 2022 at 11:13:16AM +0200, Emil Renner Berthing wrote:
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
>  drivers/pwm/pwm-sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 2d4fa5e5fdd4..ccdf92045f34 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -159,7 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> =20
>  	mutex_lock(&ddata->lock);
>  	if (state->period !=3D ddata->approx_period) {
> -		if (ddata->user_count !=3D 1) {
> +		if (ddata->user_count !=3D 1 && ddata->approx_period) {

IMHO this needs a code comment. It should among others mention that
approx_period is only zero if .apply() wasn't called before.

Let me note this is inconsistent. I didn't check the details, but let's
assume the PWM can implement .period =3D 500 and .period =3D 514 and nothing
in between. So if the the first PWM requests 512 ns it gets (I hope) 500
ns. Then when the second requests comes in requesting 511 it fails and
if it requests 512 is succeeds also getting 500 ns. Hmm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4mm6vvxtocb2k52r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNOqi8ACgkQwfwUeK3K
7AkPuwf/aMdvPVFLhS+ygY/c1Guwk89BPz1Yy9kO0c0YNna1B6Vp8f02XEeGMeK7
hirxK+eqKE+2mhj/4Ma1kqkcDCA11curbutAxiKlBo13FGJsSYGfI6fPQIb4QFc2
B2dbxcF7MkJaDJ9+1RB5FhaK84cfJ0YSXvt0zC2MXzUQUaKQYXsO8KRIcExrmsSY
3qni4f8ZGIojR/5BSW4wxZvdok3rt4LqAYKavkVwXsPM1gAC7QzW8bM5ian2Qz5u
TGE+O9jX2frictFolA3vL8dW/Ums8MziSnncS1VhCKjW0Z0Hwu4JePf8Jc8Fofbq
a9UJSsy7sT/d+Zj+1Nu7DOgPmoT8LQ==
=ysZi
-----END PGP SIGNATURE-----

--4mm6vvxtocb2k52r--
