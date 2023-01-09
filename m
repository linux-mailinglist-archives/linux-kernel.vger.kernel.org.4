Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D4662088
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjAIItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbjAIIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:47:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153C164A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEnkX-0001vC-S4; Mon, 09 Jan 2023 09:43:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEnkW-004oA6-Rx; Mon, 09 Jan 2023 09:43:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEnkW-00BJig-4K; Mon, 09 Jan 2023 09:43:20 +0100
Date:   Mon, 9 Jan 2023 09:43:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] leds: trigger/tty: Use led_set_brightness() to support
 all use cases
Message-ID: <20230109084320.nj7erwh3eu4jlw7y@pengutronix.de>
References: <20210503092542.14497-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gljqu4j54k7ygkjk"
Content-Disposition: inline
In-Reply-To: <20210503092542.14497-1-jbe@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gljqu4j54k7ygkjk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello J=FCrgen,

On Mon, May 03, 2021 at 11:25:42AM +0200, Juergen Borleis wrote:
> Using led_set_brightness_sync() only works for LEDs which are connected
> via some kind of external bus like I=B2C or SPI. But it doesn't work for
> the simple use case of directly connected LEDs via GPIOs.
> Because this function only honors the led_classdev::brightness_set_blocki=
ng
> callback. But the LED-GPIO driver registers the
> led_classdev::brightness_set member if the GPIO can be modified directly
> and thus, TTY triggers fail silently with -ENOTSUPP.
>=20
> With the previously used led_set_brightness() it works for both use cases.
> This function first checks for the simple case where the GPIO can be chan=
ged
> without additional overhead, and if it fails, does the modification via a
> workqueue.
>=20
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> ---
>  drivers/leds/trigger/ledtrig-tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
> index f62db7e..af61281 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -122,12 +122,12 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
> =20
>  	if (icount.rx !=3D trigger_data->rx ||
>  	    icount.tx !=3D trigger_data->tx) {
> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +		led_set_brightness(trigger_data->led_cdev, LED_ON);
> =20
>  		trigger_data->rx =3D icount.rx;
>  		trigger_data->tx =3D icount.tx;
>  	} else {
> -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> +		led_set_brightness(trigger_data->led_cdev, LED_OFF);
>  	}

This problem still exists, right?

I think the right thing here is to call led_set_brightness_nosleep()
however.

Having said that, I think there are too many variants of
led_set_brightness which makes it difficult to pick the right one.

(I'm aware of
 - led_set_brightness_nosleep
 - led_set_brightness_nopm
 - led_set_brightness_sync
 - led_set_brightness

and there are a few more static variants in led-core.c
(__led_set_brightness, __led_set_brightness_blocking,
set_brightness_delayed).)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gljqu4j54k7ygkjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO706UACgkQwfwUeK3K
7AkLZwf2OjQUllc8n30dbTN3s2uvDhD4b70Gd6KfUS8OLqyen8zYbLhynaKCnVi/
sfe/ZgOzh8hI2JahMYQUyNvLmtTEzRikM2/Rrf8bkKuQ7IUNdrVs8EtiTjzjFioC
DGdcQvI/UAVCaL/5Gy4iiB+OGK0dXExULPdwpSB8SaqezX6yiYmzR27m4EU76wOJ
KDGL2YRnkL6BSDjINpTpHIqM1eOY0QwUzR9v16R9T4kaDLvUN/vl8iuaB+aY5c1K
TGQGBvwf+RDqz9RfLQjQwPuSWPGazhSAjpKZdgz4rapcYvYsIkO3OKhqSTAY/tRN
6efz0Fu2deDz9SVulj9Dm/mR9ZKu
=4Sqz
-----END PGP SIGNATURE-----

--gljqu4j54k7ygkjk--
