Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02380655E52
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiLYVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:20:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D055AC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 13:20:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9YPo-0005qL-Hn; Sun, 25 Dec 2022 22:20:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9YPn-001j9R-2u; Sun, 25 Dec 2022 22:20:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9YPm-007tzD-Eq; Sun, 25 Dec 2022 22:20:14 +0100
Date:   Sun, 25 Dec 2022 22:20:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernel@pengutronix.de, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr
Subject: Re: coccinelle: How to remove a return at the end of a void function?
Message-ID: <20221225212011.6il5egocxtx5zupa@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ki4pjegaar3myre7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ki4pjegaar3myre7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

first of all thanks for your quick answer.

On Sat, Dec 24, 2022 at 01:28:04PM +0100, Julia Lawall wrote:
> On Sat, 24 Dec 2022, Uwe Kleine-K=F6nig wrote:
> > A simplified spatch looks as follows:
> >
> > -------->8--------
> > virtual patch
> >
> > @p1@
> > identifier pdev;
> > @@
> > -int
> > +void
> >  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  <...
> > -return 0;
> > +return;
> >  ...>
> >  }
> > -------->8--------
> >
> > This results in:
> >
> > -------->8--------
> > diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_=
usb_sdmmc.c
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
> >         return 0;
> >  }
> >
> > -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> >  {
> >         struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
> >         struct mmc_host *mmc;
> >
> >         if (!host)
> > -               return 0;
> > +               return;
> >
> >         mmc =3D host->mmc;
> >         host->host_removal =3D true;
> > @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
> >         dev_dbg(&(pdev->dev),
> >                 ": Realtek USB SD/MMC module has been removed\n");
> >
> > -       return 0;
> > +       return;
> >  }
> >
> >  #ifdef CONFIG_PM
> > -------->8--------
> >
> > which is as intended. Now I want to remove the useless "return;" at the
> > end of the function, however adding
> >
> > -------->8--------
> > @p2 depends on p1@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -return;
> >  }
> > -------->8--------
> >
> > to the spatch doesn't (only) do the intended:
>=20
> The problem is that Coccinelle is following the control-flow through the
> function, and all of the returns are at the end of a control.flow path.
> The simple, hacky solution is to change the return;s into some function
> call Return();, then do like the above for Return(); and then change the
> Return();s back to return;s

OK, I tried, but somehow coccinelle refuse to work after I introduced
Return(), even replacing them by return; doesn't work:

-------->8--------
virtual patch

@p1@
identifier pdev;
@@
-int
+void
 rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-return 0;
+Return();
 ...
 }

@p2@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-Return();
+return;
 ...
 }
-------->8--------

results in

-------->8--------
$ /usr/bin/spatch --debug -D patch --very-quiet --cocci-file scripts/coccin=
elle/api/test.cocci --patch . --dir drivers/mmc/host/rtsx_usb_sdmmc.c -I ./=
arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86=
/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./i=
nclude/generated/uapi --include ./include/linux/compiler-version.h --includ=
e ./include/linux/kconfig.h --jobs 4 --chunksize 1
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1385,7 +1385,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
 	struct mmc_host *mmc;

 	if (!host)
-		return 0;
+		Return();

 	mmc =3D host->mmc;
 	host->host_removal =3D true;
@@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
 	dev_dbg(&(pdev->dev),
 		": Realtek USB SD/MMC module has been removed\n");

-	return 0;
+	Return();
 }

 #ifdef CONFIG_PM
-------->8--------

Adding --debug doesn't give any hints.

(And if I add another hunk inbeetween removing Return at the end of the
function there is no effect either.)

Do I need to split that in two spatches to make coccinelle cooperate?

(If it matters, this is coccinelle as shipped by Debian, Version
1.1.1.deb-2)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ki4pjegaar3myre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOovogACgkQwfwUeK3K
7AkDrAgAgRfDs2k7V4+HC3weOMPwPKgObjnDeQbPp/DLiOB56rRtLYow+Tdl1Vio
v0U5HR25ngVdGO1ZbSDm5lfg0QIgv17e7+3Ko6IS/oj4JHA10MWvMZ+dcrvhT8Kz
2bu+W2EMMbDBCYVh586E3BuoQrsVysn4BFh2QKpBWjjKS2giwPaAp7n5HgjMt3Ve
iA0YGlao8I1CK/gVCu7GzVW8n/wfpatYIVts1y+P3a8bZk+SylCYAjwl0GGHq9fO
OVQmhGjvHoXuBeTGRyvgjCr3Sc/LW93rOZnyu0SQUPBsLQVtiYTASyV/jBH19wu1
Dg1+GinznKY6cCeb7vDoL/1DHpo7+g==
=Kwk3
-----END PGP SIGNATURE-----

--ki4pjegaar3myre7--
