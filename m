Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73408656943
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiL0J5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiL0J43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:56:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D970B1D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:55:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA6g7-00084I-Km; Tue, 27 Dec 2022 10:55:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA6g4-0022i6-Lq; Tue, 27 Dec 2022 10:55:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA6g3-008GVS-Rf; Tue, 27 Dec 2022 10:55:19 +0100
Date:   Tue, 27 Dec 2022 10:55:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de, cocci@inria.fr
Subject: Re: coccinelle: How to remove a return at the end of a void function?
Message-ID: <20221227095517.mzjmqse5wvaielev@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
 <20221225212011.6il5egocxtx5zupa@pengutronix.de>
 <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4ou3e5qjzu7togz"
Content-Disposition: inline
In-Reply-To: <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
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


--t4ou3e5qjzu7togz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

On Mon, Dec 26, 2022 at 05:02:35PM +0100, Julia Lawall wrote:
> On Sun, 25 Dec 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello Julia,
> >
> > first of all thanks for your quick answer.
> >
> > On Sat, Dec 24, 2022 at 01:28:04PM +0100, Julia Lawall wrote:
> > > On Sat, 24 Dec 2022, Uwe Kleine-K=F6nig wrote:
> > > > A simplified spatch looks as follows:
> > > >
> > > > -------->8--------
> > > > virtual patch
> > > >
> > > > @p1@
> > > > identifier pdev;
> > > > @@
> > > > -int
> > > > +void
> > > >  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > > >  <...
> > > > -return 0;
> > > > +return;
> > > >  ...>
> > > >  }
> > > > -------->8--------
> > > >
> > > > This results in:
> > > >
> > > > -------->8--------
> > > > diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/r=
tsx_usb_sdmmc.c
> > > > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > > @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > > > +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > > >  {
> > > >         struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
> > > >         struct mmc_host *mmc;
> > > >
> > > >         if (!host)
> > > > -               return 0;
> > > > +               return;
> > > >
> > > >         mmc =3D host->mmc;
> > > >         host->host_removal =3D true;
> > > > @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
> > > >         dev_dbg(&(pdev->dev),
> > > >                 ": Realtek USB SD/MMC module has been removed\n");
> > > >
> > > > -       return 0;
> > > > +       return;
> > > >  }
> > > >
> > > >  #ifdef CONFIG_PM
> > > > -------->8--------
> > > >
> > > > which is as intended. Now I want to remove the useless "return;" at=
 the
> > > > end of the function, however adding
> > > >
> > > > -------->8--------
> > > > @p2 depends on p1@
> > > > identifier pdev;
> > > > @@
> > > >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > > >  ...
> > > > -return;
> > > >  }
> > > > -------->8--------
> > > >
> > > > to the spatch doesn't (only) do the intended:
> > >
> > > The problem is that Coccinelle is following the control-flow through =
the
> > > function, and all of the returns are at the end of a control.flow pat=
h.
> > > The simple, hacky solution is to change the return;s into some functi=
on
> > > call Return();, then do like the above for Return(); and then change =
the
> > > Return();s back to return;s
> >
> > OK, I tried, but somehow coccinelle refuse to work after I introduced
> > Return(), even replacing them by return; doesn't work:
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
> >  ...
> > -return 0;
> > +Return();
> >  ...
> >  }
> >
> > @p2@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -Return();
> > +return;
> >  ...
> >  }
>=20
> The problem is that a control-flow path at this point can have multiple
> calls to Return();  You pattern only matches when every control-flow path
> through the code has exactly one Return().

Ah, ok. This wasn't clear to me from reading the documentation (e.g.
https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html)
=20
> You should have one rule that removes the final Return();
>=20
>  @p2@
>  identifier pdev;
>  @@
>   void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>   ...
>  -Return();
>   }
>=20
> Then another rule to remove the others:
>=20
>  @p2@
>  identifier pdev;
>  @@
>   void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>   <...
>  -Return();
>  +return;
>   ...>
>   }

I now have

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
 }

@p3@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 <...
-Return();
+return;
 ...>
 }
-------->8--------

But there p2 suffers from the same problem and only matches
code paths with exactly 1 Return(). So the above results in

-------->8--------
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
        return 0;
 }

-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
        struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
        struct mmc_host *mmc;

        if (!host)
-               return 0;
+               return;

        mmc =3D host->mmc;
        host->host_removal =3D true;
@@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
        dev_dbg(&(pdev->dev),
                ": Realtek USB SD/MMC module has been removed\n");

-       return 0;
+       return;
 }

 #ifdef CONFIG_PM
-------->8--------

and only if I remove the "if (!host) return 0;" block before patch
generation, the final return is also dropped.=20

I think this is good enough for me, as there are not too many cases like
the above. If there is spatch that does the desired change (i.e.

-------->8--------
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,11 @@ static int rtsx_usb_sdmmc_drv_probe(stru
        return 0;
 }

-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
        struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
        struct mmc_host *mmc;

        if (!host)
-               return 0;
+               return;

        mmc =3D host->mmc;
        host->host_removal =3D true;
@@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
        dev_dbg(&(pdev->dev),
                ": Realtek USB SD/MMC module has been removed\n");
-
-       return 0;
 }

 #ifdef CONFIG_PM
-------->8--------
) I'd be happy to hear and learn about it.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t4ou3e5qjzu7togz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOqwQIACgkQwfwUeK3K
7AlaUQf+Pcfi/G+8ytKf0fujae79ImbfP5j3cieCyCRmFZoysWDC1zzQhhu6+Lcn
1nwIypCsa9bW7LtZ+Zuu+r8rJMF+WMRoNtFZWyxLAlrkjmLNZTiTQlKUXamBHhMS
CtqPMluANCpVzsD2lc/bM/LhrZvqt+svIYMy/8SJj8ShqC8J+kJmi8PgP0ofpBlu
b5kqRUMdkNxz3/WppZ756D5rbdqyXHAydJZvavUbzU2eOFR61kOaydACjtRyr00w
OtezgQWgrDLzcwvsfSUVD9uEV74jpYEjM57l1C2jWWHHQMVBpK6w5CNwZj5Zn3kz
B9lljLL3ZPrrVw3VLAnnWl81308ydg==
=1Wto
-----END PGP SIGNATURE-----

--t4ou3e5qjzu7togz--
