Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204665E8B65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIXKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIXKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:14:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1E2A276
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:14:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc2BS-0001oE-L1; Sat, 24 Sep 2022 12:14:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc2BT-002d6I-0H; Sat, 24 Sep 2022 12:14:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc2BQ-003CNw-Sq; Sat, 24 Sep 2022 12:14:52 +0200
Date:   Sat, 24 Sep 2022 12:14:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 9/9] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <20220924101449.bpfcitsmd2nnk3md@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jesukxwa5mdfb57g"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-10-andriy.shevchenko@linux.intel.com>
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


--jesukxwa5mdfb57g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Sep 08, 2022 at 04:56:58PM +0300, Andy Shevchenko wrote:
> The PWM LPSS device can be embedded in another device.
> In order to enable it, allow that drivers to probe
> a corresponding device.

There is no in-tree user of this. Do you plan to add one?
=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.h                        | 26 ++--------------
>  .../linux/platform_data/x86}/pwm-lpss.h       | 30 ++++---------------
>  2 files changed, 7 insertions(+), 49 deletions(-)
>  copy {drivers/pwm =3D> include/linux/platform_data/x86}/pwm-lpss.h (52%)
>=20
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 0249c01befd5..fe32e336db8e 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -13,11 +13,9 @@
>  #include <linux/pwm.h>
>  #include <linux/types.h>
> =20
> -#define MAX_PWMS			4
> -
> -struct device;
> +#include <linux/platform_data/x86/pwm-lpss.h>
> =20
> -struct pwm_lpss_boardinfo;
> +#define MAX_PWMS			4

Side-note orthogonal to this patch series: IMHO this is a bad name for a
driver specific constant. Without a driver prefix you could easily
misjudge this as e.g. maximal number of PWMs a machine can have. This
should better be named LPSS_MAX_PWMS or similar.

> =20
>  struct pwm_lpss_chip {
>  	struct pwm_chip chip;
> @@ -25,29 +23,9 @@ struct pwm_lpss_chip {
>  	const struct pwm_lpss_boardinfo *info;
>  };
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
>  extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
>  extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
>  extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
>  extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
> =20
> -struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *b=
ase,
> -				     const struct pwm_lpss_boardinfo *info);
> -
>  #endif	/* __PWM_LPSS_H */
> diff --git a/drivers/pwm/pwm-lpss.h b/include/linux/platform_data/x86/pwm=
-lpss.h
> similarity index 52%
> copy from drivers/pwm/pwm-lpss.h
> copy to include/linux/platform_data/x86/pwm-lpss.h
> index 0249c01befd5..296bd837ddbb 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/include/linux/platform_data/x86/pwm-lpss.h
> @@ -1,29 +1,14 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel Low Power Subsystem PWM controller driver
> - *
> - * Copyright (C) 2014, Intel Corporation
> - *
> - * Derived from the original pwm-lpss.c
> - */
> +/* Intel Low Power Subsystem PWM controller driver */
> =20
> -#ifndef __PWM_LPSS_H
> -#define __PWM_LPSS_H
> +#ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
> +#define __PLATFORM_DATA_X86_PWM_LPSS_H
> =20
> -#include <linux/pwm.h>
>  #include <linux/types.h>
> =20
> -#define MAX_PWMS			4
> -
>  struct device;
> =20
> -struct pwm_lpss_boardinfo;
> -

So the declaration you added before and I doubted is gone again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jesukxwa5mdfb57g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu2JcACgkQwfwUeK3K
7AkBTQf7BHM2gTXAqA2h+z94t13cCO3Oxe8FuRbKXZWSLyEZ9IiaU64tgO5dWg4+
NYkGXwmNdcA044qyUhcasf+dr4F87piy+cxL1eJSd5JaZbZPX8B+NkSaQjuzkYww
Xj1DltTCLUxjGLLuuKvMvu140dOt4Y/s72oEmkNta8nTc/9E/aW0FbqgdBW+WBH3
A62L5BIvNLyA0+W+dO3tcP9IlSkzHqUNaOCwjIf+2Qt5e4sFo5/sidUYp3lohB7v
WbnrKSSGsmiTHElt80zal4FmGl+gKhLnstoAcuiFCv3sIPs8n94rZ/S5S8C8bLQi
16/kuLmbf66+OnMj5fJbhlyMLBwKQw==
=688C
-----END PGP SIGNATURE-----

--jesukxwa5mdfb57g--
