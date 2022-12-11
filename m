Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD487649666
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLKU5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:57:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDBA457
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:57:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4TNX-00068D-Hz; Sun, 11 Dec 2022 21:56:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4TNV-003s9n-5S; Sun, 11 Dec 2022 21:56:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4TNU-004Jgu-Nx; Sun, 11 Dec 2022 21:56:52 +0100
Date:   Sun, 11 Dec 2022 21:56:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] media: rc: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221211205648.hdv5haufqwfoxzu2@pengutronix.de>
References: <20221121170911.7cd72bfc@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j7f5jlshgvp4l24r"
Content-Disposition: inline
In-Reply-To: <20221121170911.7cd72bfc@endymion.delvare>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j7f5jlshgvp4l24r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 05:09:11PM +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>=20
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
>=20
> As a minor optimization, this also lets us drop of_match_ptr(), as we
> now know what it will resolve to, we might as well save cpp some work.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Sean Young <sean@mess.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/media/rc/Kconfig     |    4 ++--
>  drivers/media/rc/pwm-ir-tx.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> --- linux-6.0.orig/drivers/media/rc/Kconfig
> +++ linux-6.0/drivers/media/rc/Kconfig
> @@ -314,7 +314,7 @@ config IR_PWM_TX
>  	tristate "PWM IR transmitter"
>  	depends on LIRC
>  	depends on PWM
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	help
>  	   Say Y if you want to use a PWM based IR transmitter. This is
>  	   more power efficient than the bit banging gpio driver.
> @@ -361,7 +361,7 @@ config IR_SERIAL_TRANSMITTER
>  config IR_SPI
>  	tristate "SPI connected IR LED"
>  	depends on SPI && LIRC
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	help
>  	  Say Y if you want to use an IR LED connected through SPI bus.
> =20
> --- linux-6.0.orig/drivers/media/rc/pwm-ir-tx.c
> +++ linux-6.0/drivers/media/rc/pwm-ir-tx.c
> @@ -120,7 +120,7 @@ static struct platform_driver pwm_ir_dri
>  	.probe =3D pwm_ir_probe,
>  	.driver =3D {
>  		.name	=3D DRIVER_NAME,
> -		.of_match_table =3D of_match_ptr(pwm_ir_of_match),
> +		.of_match_table =3D pwm_ir_of_match,
>  	},
>  };
>  module_platform_driver(pwm_ir_driver);

That hunk makes sense even without the Kconfig change. ACPI makes use of
=2Eof_match_table, so

	.of_match_table =3D of_match_ptr(pwm_ir_of_match),

is (almost?) always wrong.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j7f5jlshgvp4l24r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOWRA0ACgkQwfwUeK3K
7AknWgf/ck761EhUuzG0AEhzRR6X1vuIy/3Tydbnkf2GvDBxgkQdOORa/UIe5Yf8
UHrsK3XjzQ3ZO/PAl6UFfvDm4G8ivbIkmFWrlEKKxyR2dvBlkLzCt5I8+AsJDoTv
+E+Q8uxSIiN3ULYttziSnWvSuUYG6mi5TtE7DImmeYbzV4cWbErGYJQp9J7mowTj
FrdDGPLST7nUzsYI9Qy190BuHaHD/Jr1sriOxc3YBnCgQUcP7pDnXU9BZKyVY/GR
9oBi2m8a9IDyCZvXTpSZsn4KD2TyxMnhgmqxocKcjTmW1Jh9HFUcB/sRMFvGqM01
wEkJfpn6qbM2Hs0qwQM1jSAo04I3iw==
=6Ei6
-----END PGP SIGNATURE-----

--j7f5jlshgvp4l24r--
