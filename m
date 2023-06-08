Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB898728B59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjFHWyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFHWyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:54:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879772D63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:54:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7OW0-00013w-5z; Fri, 09 Jun 2023 00:54:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7OVy-0064OJ-Gg; Fri, 09 Jun 2023 00:53:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7OVx-00CRF7-Lm; Fri, 09 Jun 2023 00:53:57 +0200
Date:   Fri, 9 Jun 2023 00:53:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Message-ID: <20230608225355.3raozoq3v6teft7q@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
 <20230601154101.GA2368233@dev-arch.thelio-3990X>
 <20230601165945.f7itlyso4rbp2nbb@pengutronix.de>
 <AM0PR04MB6289C7212F52C7A9DA4951D38F50A@AM0PR04MB6289.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m53nyjv77nkhb4ke"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6289C7212F52C7A9DA4951D38F50A@AM0PR04MB6289.eurprd04.prod.outlook.com>
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


--m53nyjv77nkhb4ke
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 08, 2023 at 10:00:13PM +0000, Leo Li wrote:
> > Hmm, clang seems to be right, and I just confirmed that gcc (arm-linux-
> > gnueabihf-gcc (Debian 12.2.0-14) 12.2.0) doesn't emit a warning. :-\
> >=20
> > My approach would be:
> >=20
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc=
/fsl-mc-
> > allocator.c
> > index 0ad68099684e..991273f956ce 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > @@ -103,14 +103,15 @@ static int __must_check
> > fsl_mc_resource_pool_remove_device(struct fsl_mc_device
> >  	struct fsl_mc_resource *resource;
> >  	int error =3D -EINVAL;
> >=20
> > +	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> > +	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
> > +
> >  	resource =3D mc_dev->resource;
> >  	if (!resource || resource->data !=3D mc_dev) {
> >  		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
> >  		goto out;
> >  	}
> >=20
> > -	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> > -	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
> >  	res_pool =3D resource->parent_pool;
> >  	if (res_pool !=3D &mc_bus->resource_pools[resource->type]) {
> >  		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
> >=20
> >=20
> > Should I prepare a proper patch, or is it possible to squash this chang=
e into
> > b3134039c5b3cf879841e3ec84c8cbf7675554ec?
> >=20
> > @Li Yang: Please advice.
>=20
> This looks fine.  Please send a new patch and I can squash it to the orig=
inal commit.

I did send a proper patch already, see=20

	https://lore.kernel.org/all/20230605112025.80061-1-u.kleine-koenig@pengutr=
onix.de

You can apply that on top of the broken commit, or if you prefer also
squash it into the offending commit. Note that in the above thread there
is another fix for an older commit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m53nyjv77nkhb4ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSCXAIACgkQj4D7WH0S
/k5/5wf8DGlJwZYFYcc47hF6t2PxNG6THgaqO/YKmcRqPnXo/9Zag0rBz8iAjVAi
JGhnAECibEsDkFltWPjG4Uq/eBoMb8bY1zXTahbeglyJyXitkL+L8Btuf7eXs+CB
jUPeVGZwLpGk/hhKHI95JLCcxKHBbf1L4WJ11hJ9nDm6H3PXqcmXUflE+Tc4BbrQ
6oFOs1X+nBf7oepALE9odIxmqBapkkQ5hd7zf3JNLatwLxr7omnwT3ZBzrJc+p/e
kBslHcFSFgALPA1fsRwj/ytqf/QeU0oS7boscRu0r+Rnyo0IV5fO6o5frjZ6Zlk6
j+MjCEQyIYmcEqrDlZnRRfP9Ll/QpQ==
=tye5
-----END PGP SIGNATURE-----

--m53nyjv77nkhb4ke--
