Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C6750A24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjGLN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGLN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:56:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC0E74
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:56:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJaJw-00063o-9Q; Wed, 12 Jul 2023 15:55:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJaJv-00Du13-80; Wed, 12 Jul 2023 15:55:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJaJt-004JiZ-W3; Wed, 12 Jul 2023 15:55:54 +0200
Date:   Wed, 12 Jul 2023 15:55:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     thierry.reding@gmail.com, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <20230712135553.trqkxtcuiemwzgwe@pengutronix.de>
References: <20230712134347.14897-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bq7xgtgt4lzusxg7"
Content-Disposition: inline
In-Reply-To: <20230712134347.14897-1-aarongt.shen@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bq7xgtgt4lzusxg7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 09:43:47PM +0800, Guiting Shen wrote:
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the PWM
> clock already disabled" when turning off the PWM channel.
>=20
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
> the PWM channel was already enabled in bootloader.
>=20
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index cdbc23649032..28ea0f7267ca 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -36,7 +36,7 @@
>  #define PWM_SR			0x0C
>  #define PWM_ISR			0x1C
>  /* Bit field in SR */
> -#define PWM_SR_ALL_CH_ON	0x0F
> +#define PWM_SR_ALL_CH_MASK	0x0F
> =20
>  /* The following register is PWM channel related registers */
>  #define PWM_CH_REG_OFFSET	0x200
> @@ -464,6 +464,37 @@ static const struct of_device_id atmel_pwm_dt_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
> =20
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
> +{
> +	unsigned int i;
> +	int err;
> +	u32 sr;
> +
> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR);
> +	if (!(sr & PWM_SR_ALL_CH_MASK))
> +		return 0;
> +
> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> +		if (!(sr & (1 << i)))
> +			continue;
> +
> +		err =3D clk_enable(atmel_pwm->clk);
> +		if (err) {
> +			dev_err(atmel_pwm->chip.dev,
> +				"failed to enable clock for pwm #%d: %pe\n",
> +							i, ERR_PTR(err));
> +
> +			while (i--) {
> +				if (sr & (1 << i))
> +					clk_disable(atmel_pwm->clk);
> +			}
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int atmel_pwm_probe(struct platform_device *pdev)
>  {
>  	struct atmel_pwm_chip *atmel_pwm;
> @@ -504,8 +535,15 @@ static int atmel_pwm_probe(struct platform_device *p=
dev)
> =20
>  	platform_set_drvdata(pdev, atmel_pwm);
> =20
> +	ret =3D atmel_pwm_enable_clk_if_on(atmel_pwm);
> +	if (ret < 0)
> +		goto remove_pwmchip;
> +
>  	return ret;
> =20
> +remove_pwmchip:
> +	pwmchip_remove(&atmel_pwm->chip);
> +

I'd consider it more natural to do the atmel_pwm_enable_clk_if_on() call
before registering the pwmchip. But I guess it works like this, too.
(Well unless it's possible that there are set bits in PWM_SR and the
clock is off.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bq7xgtgt4lzusxg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSusOgACgkQj4D7WH0S
/k6plgf/d0M/JWWv6RhsftHVKBbI2LRjln4d8uZhGCHkzt6UtSXQpc4n+eocnaWb
fUraq4V0u7CEqaaKHFlC5LbCWq2OE3hfw0egCRAEo63c7HJs1Tzs6nmglGv4NWlO
c1tiOfXute9EsJvQD1bfKN0WUET8lTn+T6ytDjjQAG/hLfGVDSPNrui37aw02ZwU
Uzyi3x+wznEN7gvAw0mRXHpe8iLXBP7WC2vGUBeWDDJ9omaJ46YjKGR6KpL+r/MW
V6vs5N2tcHM63CueQTi3hIaP4fZba2FGZ3wKTuRJAVOY9wfrdFI4u2ytBpG/fKlk
qwsFBmN9eFlfKCthd6i37oy2+JmnFw==
=LQrl
-----END PGP SIGNATURE-----

--bq7xgtgt4lzusxg7--
