Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7564827F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLIMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:41:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16066CBF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:41:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3cgW-0003Sv-Hx; Fri, 09 Dec 2022 13:41:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3cgU-003Mfi-7i; Fri, 09 Dec 2022 13:40:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3cgU-003lnM-7P; Fri, 09 Dec 2022 13:40:58 +0100
Date:   Fri, 9 Dec 2022 13:40:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     Qingtao Cao <qingtao.cao@digi.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: ledtrig-tty.c: call led_set_brightness() when
 the blocking callback is not available
Message-ID: <20221209124058.dwez7wohs7dfeiik@pengutronix.de>
References: <20221209001039.7287-1-qingtao.cao@digi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="565mh7mmkut75gk2"
Content-Disposition: inline
In-Reply-To: <20221209001039.7287-1-qingtao.cao@digi.com>
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


--565mh7mmkut75gk2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 10:10:38AM +1000, Qingtao Cao wrote:
> The Marvell GPIO controller's driver will setup its struct gpio_chip's ca=
n_sleep
> false, making create_gpio_led() setting up the brightness_set function po=
inter
> instead of the brightness_set_blocking function pointer. In this case the
> nonblocking version led_set_brightness() should be fallen back on by ledt=
rig_tty_work()
>=20
> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> ---
>  drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
> index f62db7e520b5..e43d285b5d06 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
> =20
>  	if (icount.rx !=3D trigger_data->rx ||
>  	    icount.tx !=3D trigger_data->tx) {
> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +		if (trigger_data->led_cdev->brightness_set_blocking)
> +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +		else if (trigger_data->led_cdev->brightness_set)
> +			led_set_brightness(trigger_data->led_cdev, LED_ON);

I had similar issues in the past where a function call worked for
sleeping LEDs but not atomic ones (or the other way around? Don't
remember the details.)

I wonder if there isn't a function that does the right thing no matter
what type the LED is. The other triggers should have the same issue, and
doing the above check in all of them just looks wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--565mh7mmkut75gk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOTLNcACgkQwfwUeK3K
7AncHgf+MX7UU32R1xOxDn2kHRK45G5QRz1Iog0wvmFwNW3dXft+e8rrIm66X897
xAc6AleuqAM2Hos8NGFAsehr3StUD1yXSvtR3wAxKCJ3USmF26DOMAXsCZe6UoPb
Shu1sFSeZApZQRdvWHJxI1OXanh1CjfEbar4i6YLsqa4saGlQ+3tbVVqX75Z8F1O
J0fWjZk0LO4a0rsaThYj7qPymqm7VsDDuEVfIMiatH3tIOL5PxfUqm/SRenpPDlF
jJw49kf6xiw6GAJCWdHh3ke3Fo8L0tte+iUpYDLOyW/QOpyxr0akm81Ylc/1Wpnp
4QGxcs+BQiVBFxIV27xyy+8h8+N0Pw==
=2hSk
-----END PGP SIGNATURE-----

--565mh7mmkut75gk2--
