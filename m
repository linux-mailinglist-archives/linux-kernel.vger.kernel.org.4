Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543F699EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBPVTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBPVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:19:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F94A1F1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:19:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlfB-0005Xn-0k; Thu, 16 Feb 2023 22:19:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlf8-005REf-1T; Thu, 16 Feb 2023 22:19:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlf8-0048j7-G2; Thu, 16 Feb 2023 22:19:30 +0100
Date:   Thu, 16 Feb 2023 22:19:28 +0100
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
Subject: Re: [PATCH v7 04/10] pwm: dwc: move memory alloc to own function
Message-ID: <20230216211928.53yodfcu3wjccpfq@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydxaayw27syloonj"
Content-Disposition: inline
In-Reply-To: <20221223153820.404565-5-ben.dooks@sifive.com>
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


--ydxaayw27syloonj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2022 at 03:38:14PM +0000, Ben Dooks wrote:
> In preparation for adding other bus support, move the allocation
> of the pwm struct out of the main driver code.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index c706ef9a7ba1..61f11e0a9319 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
> +{
> +	struct dwc_pwm *dwc;
> +
> +	dwc =3D devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
> +	if (!dwc)
> +		return NULL;
> +
> +	dwc->chip.dev =3D dev;
> +	dwc->chip.ops =3D &dwc_pwm_ops;
> +	dwc->chip.npwm =3D DWC_TIMERS_TOTAL;
> +
> +	dev_set_drvdata(dev, dwc);

I don't particularily like that this dev_set_drvdata is matched by
pci_get_drvdata in .remove(), but this isn't going to break I guess. So:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydxaayw27syloonj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPundwACgkQwfwUeK3K
7Alu3wf7Bw70SXKIrkUAq2DI5XEfW34R6/6Or3z+5sPMSZwpLIqWdeuXEwLskAgT
RpRLoexEppof9scc6zfxGBrqev/4edShXM26Cy9TyhdHt+GzoGeQMG/SWMf50lzB
4Adjn/efnMEU6RaMJINsFg2Xl7gLioE/7ckm3ruQPENUFayytxaYQWZ3t5JS23ca
WU6c+4QnghxpBW0n6ZbX+Sxj4zGzlxg6d5A4sAoiIQmnBWwMFEEOrRzVKvj19Z6S
4OFuuVxnyp51T/bJgGCeh1hIRfpAUMlNY/gNQH8GyTf1oAMol2om7JqcmE/Ajh0F
4obnnQXMyblpULC4U5/vdM/iElpOHw==
=DKE+
-----END PGP SIGNATURE-----

--ydxaayw27syloonj--
