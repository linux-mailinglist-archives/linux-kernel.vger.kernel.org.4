Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227EE624632
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiKJPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKJPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:42:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5AE31211
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:42:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9h2-00053m-FT; Thu, 10 Nov 2022 16:42:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9h0-003Tql-HD; Thu, 10 Nov 2022 16:42:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9h0-00Ffwt-Id; Thu, 10 Nov 2022 16:42:14 +0100
Date:   Thu, 10 Nov 2022 16:42:14 +0100
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
Subject: Re: [PATCH v6 10/10] pwm: dwc: use clock rate in hz to avoid
 rounding issues
Message-ID: <20221110154214.pnv7rqsftomhqvmk@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-11-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b7hp3kqdeurp4e4j"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-11-ben.dooks@sifive.com>
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


--b7hp3kqdeurp4e4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Thu, Oct 20, 2022 at 04:16:10PM +0100, Ben Dooks wrote:
> As noted, the clock-rate when not a nice multiple of ns is probably
> going to end up with inacurate caculations, as well as on a non pci
> system the rate may change (although we've not put a clock rate
> change notifier in this code yet) so we also add some quick checks
> of the rate when we do any calculations with it.
>=20
> Signed-off-by; Ben Dooks <ben.dooks@sifive.com>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-dwc-of.c |  2 +-
>  drivers/pwm/pwm-dwc.c    | 29 ++++++++++++++++++++---------
>  drivers/pwm/pwm-dwc.h    |  2 +-
>  3 files changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
> index c5b4351cc7b0..5f7f066859d4 100644
> --- a/drivers/pwm/pwm-dwc-of.c
> +++ b/drivers/pwm/pwm-dwc-of.c
> @@ -50,7 +50,7 @@ static int dwc_pwm_plat_probe(struct platform_device *p=
dev)
>  		return dev_err_probe(dev, PTR_ERR(dwc->clk),
>  				     "failed to get timer clock\n");
> =20
> -	dwc->clk_ns =3D NSEC_PER_SEC / clk_get_rate(dwc->clk);
> +	dwc->clk_rate =3D clk_get_rate(dwc->clk);

Given that clk_ns is introduced only in this series, I suggest to make
it right from the start.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b7hp3kqdeurp4e4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtG9MACgkQwfwUeK3K
7AmxSQgAm6sDT3X6LYX+qAkF3XaQ+EHUYRfFAbPibXVQMzSy0B4wI645bVRO8U+s
UxMklqwLH1YzxZoAUbPVJCaMM2e3vzv0znu3awzEekMwy4wHkUPAtsOiRFFn/NUh
GLSMxSZKFiewfXKF1mro54sj5jU/zPW04lI36/uJ9/ezqqLthDCrFGezhRS3H07H
lWs3934qFzFLATB9FliY6m0FgUG3+2lg3/+YJWV8DacPqp5pYfTZSHnpLRM1B9Jg
8JDlbBz3bS/TKMMsIMrNS9tuXRlxzrZZliYqlz4i85K1vps2ODYZHFouY4IQ/b+i
rp9n0o7KIXtcVtkWF238qWx6U8vaRg==
=vCH3
-----END PGP SIGNATURE-----

--b7hp3kqdeurp4e4j--
