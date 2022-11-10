Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231F623CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiKJHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKJHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:45:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAA65C2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:45:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot2F8-0002m0-1n; Thu, 10 Nov 2022 08:44:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot2F5-003PFR-PN; Thu, 10 Nov 2022 08:44:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot2F6-00FaOy-4w; Thu, 10 Nov 2022 08:44:56 +0100
Date:   Thu, 10 Nov 2022 08:44:56 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when
 community has a capabilitty
Message-ID: <20221110074456.hgmu7d5mn5kndc66@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7dgaqdlxnsjz4iv"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
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


--e7dgaqdlxnsjz4iv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 04:22:26PM +0200, Andy Shevchenko wrote:
> Some of the Communities may have PWM capability. In such cases,
> enumerate PWM device via respective driver. User is still responsible
> for setting correct pin muxing for the line that needs to output the
> signal.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/inte=
l/pinctrl-intel.c
> index 6e630e87fed6..6b685ff7041f 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -24,6 +24,8 @@
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> =20
> +#include <linux/platform_data/x86/pwm-lpss.h>
> +
>  #include "../core.h"
>  #include "pinctrl-intel.h"
> =20
> @@ -49,6 +51,8 @@
>  #define PADOWN_MASK(p)			(GENMASK(3, 0) << PADOWN_SHIFT(p))
>  #define PADOWN_GPP(p)			((p) / 8)
> =20
> +#define PWMC				0x204
> +
>  /* Offset from pad_regs */
>  #define PADCFG0				0x000
>  #define PADCFG0_RXEVCFG_SHIFT		25
> @@ -1502,6 +1506,27 @@ static int intel_pinctrl_pm_init(struct intel_pinc=
trl *pctrl)
>  	return 0;
>  }
> =20
> +static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
> +				   struct intel_community *community)
> +{
> +	static const struct pwm_lpss_boardinfo info =3D {
> +		.clk_rate =3D 19200000,
> +		.npwm =3D 1,
> +		.base_unit_bits =3D 22,
> +		.bypass =3D true,
> +	};
> +	struct pwm_lpss_chip *pwm;
> +
> +	if (!(community->features & PINCTRL_FEATURE_PWM))
> +		return 0;
> +
> +	pwm =3D pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
> +	if (IS_ERR(pwm) && PTR_ERR(pwm) !=3D -ENODEV)
> +		return PTR_ERR(pwm);

Linus and Andy already agreed that this patch is ugly. I wonder if this
here would be a bit less ugly if you do:

	if (IS_REACHABLE(...)) {
		pwm =3D pwm_lpss_probe(...);
		...


	}

and drop the check PTR_ERR(pwm) !=3D -ENODEV (which might have a different
semantic than "the pwm driver isn't available").

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e7dgaqdlxnsjz4iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNsq/UACgkQwfwUeK3K
7AketggAhXuuzr7oA2h+A09ZTVm5VyruBbM75FTg0Ufp7T5uCo5IqRC1ToC7wOaF
LKiJGvBHC8I/wnOqSTlVIPYzlW8OBdZ5rgddWQj11P9pZAqb4hfNHDUNmWgn6p9V
am1Wg+CUesObx+ghN3K+zpFSwJGk7x8uoIZ0YU7ONU0jKvipPTyKLs1VqOqD0pad
XbGVi32RrcUXZPfPKf8g8xi8ILNodOS4wbKMXPXtPjuujLU3iwKfSey27RwiMqsb
+6E6QDh8R/E9F9lFsBn+vkU2bZCrihMLUrOwWIgmSZjcvRi0pwiGCtRT+SvBF1Ve
IVbl0hHLGGeATSXF+/AeySnjYRr7fA==
=zYJq
-----END PGP SIGNATURE-----

--e7dgaqdlxnsjz4iv--
