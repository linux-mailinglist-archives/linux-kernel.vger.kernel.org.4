Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0841C623C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKJH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiKJH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:28:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9C25DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:28:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1yu-0000SQ-Lu; Thu, 10 Nov 2022 08:28:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1ys-003PD0-DD; Thu, 10 Nov 2022 08:28:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1ys-00FaM2-GK; Thu, 10 Nov 2022 08:28:10 +0100
Date:   Thu, 10 Nov 2022 08:28:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/6] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <20221110072810.meu3cxh5repuglk3@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isolpfvlhxvjwqhj"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-5-andriy.shevchenko@linux.intel.com>
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


--isolpfvlhxvjwqhj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 04:22:24PM +0200, Andy Shevchenko wrote:
> The PWM LPSS device can be embedded in another device.
> In order to enable it, allow that drivers to probe
> a corresponding device.

"probe" isn't the right term here. The other driver only creates the
device.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.h                        | 22 +--------------
>  .../linux/platform_data/x86}/pwm-lpss.h       | 28 ++++---------------
>  2 files changed, 6 insertions(+), 44 deletions(-)
>  copy {drivers/pwm =3D> include/linux/platform_data/x86}/pwm-lpss.h (53%)
>=20
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 4561d229b27d..b721532c6c3c 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -13,27 +13,10 @@
>  #include <linux/pwm.h>
>  #include <linux/types.h>
> =20
> -struct device;
> +#include <linux/platform_data/x86/pwm-lpss.h>
> =20
>  #define LPSS_MAX_PWMS			4
> =20
> -struct pwm_lpss_boardinfo {
> -	unsigned long clk_rate;
> -	unsigned int npwm;
> -	unsigned long base_unit_bits;
> -	/*
> -	 * Some versions of the IP may stuck in the state machine if enable
> -	 * bit is not set, and hence update bit will show busy status till
> -	 * the reset. For the rest it may be otherwise.
> -	 */
> -	bool bypass;
> -	/*
> -	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
> -	 * messes with the PWM0 controllers state,
> -	 */
> -	bool other_devices_aml_touches_pwm_regs;
> -};
> -

Now that pwm_lpss_boardinfo lives in a different file, this makes the
move of pwm_lpss_chip in patch 3 somewhat redundant.

>  extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
>  extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
>  extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
> @@ -45,7 +28,4 @@ struct pwm_lpss_chip {
>  	const struct pwm_lpss_boardinfo *info;
>  };
> =20
> -struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *b=
ase,
> -				     const struct pwm_lpss_boardinfo *info);
> -
>  #endif	/* __PWM_LPSS_H */

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--isolpfvlhxvjwqhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNsqAcACgkQwfwUeK3K
7AniDwf8CAt4pIjlZJuaECU1H6LjV59v9ejF+7Gjk24cwpEtOLQWyTKZf8zRnCBB
QRRWH/RklxYYTzdzZNU1374ObPCFzusHBA2qALbdNq/pf8/E1uZ+HlVagGqBxAcA
f4YKnEiZv5V34+3kE8RI5eS/KaK3BlIne+QL0zMJLwiJoY1MSlzv+F+xxZOQMi/E
2CYxpRGiz3hV0E1PikDNYYmA/Y54HjhPi2pBuFi7TEROWFYcAxjBiQilv8q124EM
R1cOMy5uN6X5J+7nGmwEH5kDlDRUFXC5syKJcnX6/6jG7ABOyaqhKs2rPfMvxB7M
J9v1os3jQEUqxmlzASnSbnGhJGntCA==
=pvIs
-----END PGP SIGNATURE-----

--isolpfvlhxvjwqhj--
