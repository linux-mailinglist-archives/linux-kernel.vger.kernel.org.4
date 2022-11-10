Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A66245EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiKJPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKJPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:31:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80442F74
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:29:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9Ue-00035K-Vt; Thu, 10 Nov 2022 16:29:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9Ud-003ToJ-9n; Thu, 10 Nov 2022 16:29:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9Ud-00FfWJ-Ct; Thu, 10 Nov 2022 16:29:27 +0100
Date:   Thu, 10 Nov 2022 16:29:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v6 06/10] pwm: dwc: split pci out of core driver
Message-ID: <20221110152927.olg3oqcnqvskbsli@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-7-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oazsnxqop6sntjj6"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-7-ben.dooks@sifive.com>
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


--oazsnxqop6sntjj6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 04:16:06PM +0100, Ben Dooks wrote:
> Moving towards adding non-pci support for the driver, move the pci
> parts out of the core into their own module. This is partly due to
> the module_driver() code only being allowed once in a module and also
> to avoid a number of #ifdef if we build a single file in a system
> without pci support.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v6:
>  - put DWC_PERIOD_NS back to avoid bisect issues
> v4:
>  - removed DWC_PERIOD_NS as not needed
> ---
>  drivers/pwm/Kconfig       |  14 +++-
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
>  drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
>  5 files changed, 207 insertions(+), 157 deletions(-)
>  create mode 100644 drivers/pwm/pwm-dwc-pci.c
>  create mode 100644 drivers/pwm/pwm-dwc.h
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3f3c53af4a56..a9f1c554db2b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -175,15 +175,23 @@ config PWM_CROS_EC
>  	  Controller.
> =20
>  config PWM_DWC
> -	tristate "DesignWare PWM Controller"
> -	depends on PCI || COMPILE_TEST
> +	tristate "DesignWare PWM Controller core"
>  	depends on HAS_IOMEM
>  	help
> -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> +	  PWM driver for Synopsys DWC PWM Controller.

Currently pwm-dwc doesn't contain a driver but is only a library used by
pwm-dwc-pci (and later the of driver). As such it doesn't make sense to
be user-selectible, does it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oazsnxqop6sntjj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtGNQACgkQwfwUeK3K
7AmODAf+OiOp47FcKvUT/zCWveYL2ZpZfjCfl36p70Xbm8GQqNvqoLvgE78x56CU
zsUoURfMiqgHWt1ibh0n/YL7EiK0SKVKwhtafr/MhxXhhbd27k3aHbQQL14E7dRb
lVEjCVP3cu7y4JFFtR4AFzvGBButp6WokvMhgHraKlLpSZTh8fBvn3jYUw1ql39j
iFsMQTMLMuSHDEIPIhq+Q1ieTMEy2/6odFPoLSLkSUpaxJB9gQUgL7VKrKYKhXgd
OEXoQc1tSLbiJLCRfcb+nBwz6M/cuomYwOJEwnoHb9SQw8ZM76js6CBdrbe1DPcc
35Ey4U7Qa/Wc2OlpAKmrB62Nii0oqw==
=XGUC
-----END PGP SIGNATURE-----

--oazsnxqop6sntjj6--
