Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4643A655A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiLXL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:57:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3CDFE1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:57:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9399-0003j1-3j; Sat, 24 Dec 2022 12:56:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9397-001QLS-P6; Sat, 24 Dec 2022 12:56:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p9397-007ZoX-4H; Sat, 24 Dec 2022 12:56:57 +0100
Date:   Sat, 24 Dec 2022 12:56:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     cocci@inria.fr, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: coccinelle: How to remove a return at the end of a void function?
Message-ID: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2doephs5xxov5shz"
Content-Disposition: inline
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


--2doephs5xxov5shz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I work on a patch set that eventually makes the function
rtsx_usb_sdmmc_drv_remove() return void:

A simplified spatch looks as follows:

-------->8--------
virtual patch

@p1@
identifier pdev;
@@
-int
+void
 rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 <...
-return 0;
+return;
 ...>
 }
-------->8--------

This results in:

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

which is as intended. Now I want to remove the useless "return;" at the
end of the function, however adding

-------->8--------
@p2 depends on p1@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-return;
 }
-------->8--------

to the spatch doesn't (only) do the intended:

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
+               {}

        mmc =3D host->mmc;
        host->host_removal =3D true;
@@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(str

        dev_dbg(&(pdev->dev),
                ": Realtek USB SD/MMC module has been removed\n");
-
-       return 0;
 }

 #ifdef CONFIG_PM
-------->8--------

It's obvious to me, why coccinelle also removes the first return, but
it's not obvious to me, how to prevent this and only drop the 2nd one.

Do you have a hint for me?

Thanks in advance and happy holidays,
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2doephs5xxov5shz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOm6QAACgkQwfwUeK3K
7AmXNQgAn8kqiII1CT3EGLBgDhKHQWo+UUdO6Pxetus5Rf82aH3v1AzZQ2bxLZgX
F3/xoYQv4LY5qrIHOqKqCW1eNHALfZkUNaxStMSzmlae3hJARQNBb6pTVAxkBFv+
FTHeHARe+G8sj68xM2nJrliZwuPh/hRhyYCfHK/Pji02xVAYb4LdXFWH5FiPkyxG
qamoM/NnEOsnRpN/IEKTpr9RNnEEfEaC+kMP74rqJNj6iBduapPFqnJRxRuYLGRE
jQUa/avGzA2TSkPiqv7bK/CH9iYoDQgI3q5gxDF/ATH/vzuTtrGQUeEkooG6qFho
kozxAy9EPPVYs2Wx3heFWe71mb34aQ==
=Te/w
-----END PGP SIGNATURE-----

--2doephs5xxov5shz--
