Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCD6ACB35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCFRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCFRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:48:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400E43464
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:48:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEvl-0003LN-91; Mon, 06 Mar 2023 18:47:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEvj-002IlX-L7; Mon, 06 Mar 2023 18:47:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEvi-002lWe-SK; Mon, 06 Mar 2023 18:47:22 +0100
Date:   Mon, 6 Mar 2023 18:47:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel@pengutronix.de, Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: s3c2410_wdt: Fold
 s3c2410_get_wdt_drv_data() into only caller
Message-ID: <20230306174722.rl2fws2p7pseo465@pengutronix.de>
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
 <20230306090919.2206871-2-u.kleine-koenig@pengutronix.de>
 <312e57b8-d47f-1269-a463-d2a4ef19b212@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2tswwbb25t54ljm"
Content-Disposition: inline
In-Reply-To: <312e57b8-d47f-1269-a463-d2a4ef19b212@roeck-us.net>
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


--p2tswwbb25t54ljm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 09:17:23AM -0800, Guenter Roeck wrote:
> On 3/6/23 01:09, Uwe Kleine-K=F6nig wrote:
> > s3c2410_get_wdt_drv_data() is only called by s3c2410wdt_probe(), so the
> > implementation of the former can move to the latter.
> >=20
> > scripts/bloat-o-meter reports for this change (on an ARCH=3Darm
> > allmodconfig build):
> >=20
> > 	add/remove: 1/1 grow/shrink: 0/2 up/down: 4/-129 (-125)
> >=20
>=20
> The reason for separating functions in this case wasn't that the separate=
 function
> would be called several times. It was to improve code readability. If any=
thing,
> I would argue that it might sense to split the already lengthy probe func=
tion
> further instead of combining it.

Agreed. For dev_err_probe() to work the following would be alternatively
possible:

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 58b262ca4e88..564919717761 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -579,8 +579,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(st=
ruct s3c2410_wdt *wdt)
 	return 0;
 }
=20
-static inline const struct s3c2410_wdt_variant *
-s3c2410_get_wdt_drv_data(struct platform_device *pdev)
+static inline int
+s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt =
*wdt)
 {
 	const struct s3c2410_wdt_variant *variant;
 	struct device *dev =3D &pdev->dev;
@@ -603,24 +603,26 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 					   "samsung,cluster-index", &index);
 		if (err) {
 			dev_err(dev, "failed to get cluster index\n");
-			return NULL;
+			return -EINVAL;
 		}
=20
 		switch (index) {
 		case 0:
-			return variant;
+			break;
 		case 1:
-			return (variant =3D=3D &drv_data_exynos850_cl0) ?
+			variant =3D (variant =3D=3D &drv_data_exynos850_cl0) ?
 				&drv_data_exynos850_cl1 :
 				&drv_data_exynosautov9_cl1;
+			break;
 		default:
 			dev_err(dev, "wrong cluster index: %u\n", index);
-			return NULL;
+			return -EINVAL;
 		}
 	}
 #endif
+	wdt->drv_data =3D variant;
=20
-	return variant;
+	return 0;
 }
=20
 static void s3c2410wdt_wdt_disable_action(void *data)
@@ -644,9 +646,9 @@ static int s3c2410wdt_probe(struct platform_device *pde=
v)
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device =3D s3c2410_wdd;
=20
-	wdt->drv_data =3D s3c2410_get_wdt_drv_data(pdev);
-	if (!wdt->drv_data)
-		return -EINVAL;
+	ret =3D s3c2410_get_wdt_drv_data(pdev, wdt);
+	if (ret)
+		return ret;
=20
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg =3D syscon_regmap_lookup_by_phandle(dev->of_node,

I didn't check if it's the same as for my initial patch #1, but for an
allmodconfig ARCH=3Darm build this also has a nice bloatometer output:

	add/remove: 1/1 grow/shrink: 0/1 up/down: 4/-104 (-100)

This would allow to make use of dev_err_probe() in
s3c2410_get_wdt_drv_data() and still maintain the split into two
functions.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p2tswwbb25t54ljm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQGJycACgkQwfwUeK3K
7Alr9gf/TQZveDmZyuBBis7A0wGdjBGMgJFriU0A0pmrcViPf5mABkH/xvhJNC+f
tvAj/fZu4qibRDYRV7tCXf0JpDOY8kYHRyMhcWGkb2rnSKNBTgCXDqHHzPCCmuMb
n0VmhTvaJ7ju7HY6s6CO4sBmffEeqp2dhC+UIoPudAzNLNRWb9p4b/Daf7EXDs3P
7trtsKYa1y35Cle92KMPwq+i/ap0SdvimXFqHtZR4SzNYkPL2WGfYYE1tmJk+FmT
47rDzkDHg6FObcdhVtdGSHxPND9mBdZ9aDh9zoXr4fKNROUYPn8K57Bq4fHwZt1W
HwYZSmx/1jXZhkgYwdIKGYaJ17RLww==
=9P0q
-----END PGP SIGNATURE-----

--p2tswwbb25t54ljm--
