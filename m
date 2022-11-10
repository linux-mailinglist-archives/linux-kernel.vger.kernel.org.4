Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491362460A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiKJPfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiKJPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:35:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F867262C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:35:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9aD-0003yW-6P; Thu, 10 Nov 2022 16:35:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9aB-003Tpe-Li; Thu, 10 Nov 2022 16:35:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9aB-00FfXO-V9; Thu, 10 Nov 2022 16:35:11 +0100
Date:   Thu, 10 Nov 2022 16:35:11 +0100
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
Subject: Re: [PATCH v6 04/10] pwm: dwc: move memory alloc to own function
Message-ID: <20221110153511.6ymoier2sd3fmepy@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2njqqdvwz54sbmh"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-5-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o2njqqdvwz54sbmh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 20, 2022 at 04:16:04PM +0100, Ben Dooks wrote:
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

This was a pci_set_drvdata before. While it's common knowledge (and
implicitly used in several code parts) that pci_set_drvdata(pdev, data)
is just the same as dev_set_drvdata(&pdev->dev, data), it would be nice
if the driver only used either dev_[sg]et_drvdata or pci_[sg]et_drvdata.

Using the former in dwc_pwm_resume and dwc_pwm_suspend is even a tad
shorter.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o2njqqdvwz54sbmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtGiwACgkQwfwUeK3K
7AnoPwgAkL+7zuinJe1IpOuGeYwe2mbuGFT36eazQa012oNwfGPR3bXmcmgFuoGf
5xpqZFBZWpHZ5iQ9HsnM7sBUTgbbCHfr/3N1YU5h5lFBQvjSJM999duqGXoHeuvg
uZaVGmy4bABTgU8fXB2xn1xN3vXDDb4htlYHp50uK8702AHM4jvnicnEE79ZkXHB
q+nM+PCM+FqnMJnP1J6H7P9bQZdFBk80YlCQPO9oFXSu7ytGkWJ7pc33K2Z5o7xN
NLkWqbxqivH2h55jjIPD2Zq5PpvVnKqnGqpntsHmcddogvKATg9GVlri+jgavYc9
vQGJ/KDGnDvwh2uxZqPRk+7xgSEOfQ==
=avP/
-----END PGP SIGNATURE-----

--o2njqqdvwz54sbmh--
