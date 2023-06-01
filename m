Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46871EFF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjFARAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFAQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:59:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000E184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:59:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4leP-0002af-DF; Thu, 01 Jun 2023 18:59:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4leO-004OaX-Fd; Thu, 01 Jun 2023 18:59:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4leN-00ADTs-Oz; Thu, 01 Jun 2023 18:59:47 +0200
Date:   Thu, 1 Jun 2023 18:59:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nathan Chancellor <nathan@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Message-ID: <20230601165945.f7itlyso4rbp2nbb@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
 <20230601154101.GA2368233@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfj3idh2h2hzi5yp"
Content-Disposition: inline
In-Reply-To: <20230601154101.GA2368233@dev-arch.thelio-3990X>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfj3idh2h2hzi5yp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 01, 2023 at 08:41:01AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 10, 2023 at 11:41:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > Instead of silently returning an error in the remove callback (which yi=
elds
> > a generic and little informing error message), annotate each error path=
 of
> > fsl_mc_resource_pool_remove_device() with an error message and return z=
ero
> > in the remove callback to suppress the error message.
> >=20
> > Note that changing the return value has no other effect than suppressing
> > the error message by the fsl_mc bus driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I apologize if this has already been reported or fixed somewhere, I did
> a search of lore.kernel.org and did not find anything. This change as
> commit b3134039c5b3 ("bus: fsl-mc: fsl-mc-allocator: Improve error
> reporting") causes the following warning/error with clang:
>=20
>   drivers/bus/fsl-mc/fsl-mc-allocator.c:108:12: error: variable 'mc_bus_d=
ev' is uninitialized when used here [-Werror,-Wuninitialized]
>     108 |                 dev_err(&mc_bus_dev->dev, "resource mismatch\n"=
);
>         |                          ^~~~~~~~~~
>   include/linux/dev_printk.h:144:44: note: expanded from macro 'dev_err'
>     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(=
fmt), ##__VA_ARGS__)
>         |                                                   ^~~
>   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_print=
k_index_wrap'
>     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);              =
         \
>         |                         ^~~
>   drivers/bus/fsl-mc/fsl-mc-allocator.c:100:34: note: initialize the vari=
able 'mc_bus_dev' to silence this warning
>     100 |         struct fsl_mc_device *mc_bus_dev;
>         |                                         ^
>         |                                          =3D NULL
>   1 error generated.
>=20
> Should this be using mc_dev->dev or is there a different fix?
>=20
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/f=
sl-mc-allocator.c
> index 0ad68099684e..867ac3bbeae6 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -105,7 +105,7 @@ static int __must_check fsl_mc_resource_pool_remove_d=
evice(struct fsl_mc_device
> =20
>  	resource =3D mc_dev->resource;
>  	if (!resource || resource->data !=3D mc_dev) {
> -		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
> +		dev_err(&mc_dev->dev, "resource mismatch\n");
>  		goto out;
>  	}

Hmm, clang seems to be right, and I just confirmed that gcc
(arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0) doesn't emit a
warning. :-\

My approach would be:

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl=
-mc-allocator.c
index 0ad68099684e..991273f956ce 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -103,14 +103,15 @@ static int __must_check fsl_mc_resource_pool_remove_d=
evice(struct fsl_mc_device
 	struct fsl_mc_resource *resource;
 	int error =3D -EINVAL;
=20
+	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
+	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
+
 	resource =3D mc_dev->resource;
 	if (!resource || resource->data !=3D mc_dev) {
 		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
 		goto out;
 	}
=20
-	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
-	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
 	res_pool =3D resource->parent_pool;
 	if (res_pool !=3D &mc_bus->resource_pools[resource->type]) {
 		dev_err(&mc_bus_dev->dev, "pool mismatch\n");


Should I prepare a proper patch, or is it possible to squash this change
into b3134039c5b3cf879841e3ec84c8cbf7675554ec?

@Li Yang: Please advice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tfj3idh2h2hzi5yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR4zoAACgkQj4D7WH0S
/k4QJAgAgdhaTtOuFP51jFN3ZH49AOfxtFWNhYohXkIJK59a/qYtCpdfO3jtAdlo
A6JrBlz+poU6mhAOltyPYAtfH5KlISTWD5o2Bqj89VMXQwR/c4+1sZxO36DZeSan
rKk2w0betyejdn/b9H1eo7rWtUJ5egW8c/d3fnY6X/639ViW0g+h/kSfZ7ddBIVz
ZAgXM5dUy9sAZlJNMhCi0E1ry6BAn10jiLBU+iRZOY9vvfQuuKasflS+qmvDmiiK
eaNck34AopK9yDvdb6UhPJBLms3oMkjTdAkqRjOVCRRQhyNtxZtU0OQtWVX346sX
xTP7T769ESHQ50fVAwtQsSYROvIQqQ==
=4z1g
-----END PGP SIGNATURE-----

--tfj3idh2h2hzi5yp--
