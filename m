Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F065B8D98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiINQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiINQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:54:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A767080E84
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:54:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVeJ-0000Lm-Rc; Wed, 14 Sep 2022 18:54:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVeK-000jKl-5S; Wed, 14 Sep 2022 18:54:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVeH-000uIr-T1; Wed, 14 Sep 2022 18:54:05 +0200
Date:   Wed, 14 Sep 2022 18:54:05 +0200
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
Subject: Re: [RFC v4 09/10] pwm: dwc: add snps,pwm-number to limit pwm count
Message-ID: <20220914165405.ae5nfi5336nsttkc@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-10-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36k6bcw7m2zpaz4h"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-10-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36k6bcw7m2zpaz4h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 10:14:53PM +0100, Ben Dooks wrote:
> Add snps,pwm-number property to indicate if the block does not have
> all 8 of the PWM blocks.
>=20
> Not sure if this should be a general PWM property consider optional
> for all PWM types, so have added a specific one here (there is only
> one other controller with a property for PWM count at the moment)
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/pwm/pwm-dwc-of.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
> index d18fac287325..65c7e6621bba 100644
> --- a/drivers/pwm/pwm-dwc-of.c
> +++ b/drivers/pwm/pwm-dwc-of.c
> @@ -21,12 +21,20 @@ static int dwc_pwm_plat_probe(struct platform_device =
*pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct dwc_pwm *dwc;
> +	u32 nr_pwm;
>  	int ret;
> =20
>  	dwc =3D dwc_pwm_alloc(dev);
>  	if (!dwc)
>  		return -ENOMEM;
> =20
> +	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
> +		if (nr_pwm > DWC_TIMERS_TOTAL)
> +			dev_err(dev, "too many PWMs specified (%d)\n", nr_pwm);

Maybe

	dev_err(dev, "too many PWMs specified (%d), falling back to " #DWC_TIMERS_=
TOTAL "\n", nr_pwm);

to make it obvious the error doesn't prevent probing the device.

Or you believe the dtb and use whatever it specifies.

> +		else
> +			dwc->chip.npwm =3D nr_pwm;
> +	}
> +
>  	dwc->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dwc->base))
>  		return dev_err_probe(dev, PTR_ERR(dwc->base),

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--36k6bcw7m2zpaz4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMiByoACgkQwfwUeK3K
7AkV0Qf/eVEG0nhiWAz6LiL8jmkmVnatH/Y3mWr98oMaYWOu2IIgBEE1Legbv3sz
nyAgiaykgZ3QWmD9IT1a1VTAIcaAiuEHxQDlJtGDzk6mKSSFrbgJgQpHSlQ1c1yY
ZQ7vpIEPwRl9fptawrEy3HAL4yWI5LXY5nvFQ4yZ8jpCMmfylrBpK5XAuUFOAlCO
Uzt4pwMkVSAM+V08JdIYbIMofZb++0Uzn1eakZ8k0jk6cVCqhjD7RPcNhq+D47nb
oxcMnMAHLCTZDguZDLfRwiildvBhQ+RIKzjuBq0aPIOv6jJyxt6D2Ig3CQYcVWlh
KYGCYdfGeuzr2/I9fNI4uUzOQPSVQg==
=b6cx
-----END PGP SIGNATURE-----

--36k6bcw7m2zpaz4h--
