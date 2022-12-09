Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446526485F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLIPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiLIPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:52:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1773882
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3ffV-0005Gx-SP; Fri, 09 Dec 2022 16:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3ffT-003ONv-W5; Fri, 09 Dec 2022 16:52:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p3ffT-003o2v-He; Fri, 09 Dec 2022 16:52:07 +0100
Date:   Fri, 9 Dec 2022 16:52:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] platform: Provide a remove callback that returns no value
Message-ID: <20221209155207.pyugk2dhpyht5gph@pengutronix.de>
References: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
 <Y5NSevR9kb1UPvtQ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6vfgruhanaz7egz"
Content-Disposition: inline
In-Reply-To: <Y5NSevR9kb1UPvtQ@kroah.com>
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


--g6vfgruhanaz7egz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Fri, Dec 09, 2022 at 04:21:30PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 09, 2022 at 04:09:14PM +0100, Uwe Kleine-K=F6nig wrote:
> > struct platform_driver::remove returning an integer made driver authors
> > expect that returning an error code was proper error handling. However
> > the driver core ignores the error and continues to remove the device
> > because there is nothing the core could do anyhow and reentering the
> > remove callback again is only calling for trouble.
> >=20
> > So this is an source for errors typically yielding resource leaks in the
> > error path.
> >=20
> > As there are too many platform drivers to neatly convert them all to
> > return void in a single go, do it in several steps after this patch:
> >=20
> >  a) Convert all drivers to implement .remove_new() returning void inste=
ad
> >     of .remove() returning int;
> >  b) Change struct platform_driver::remove() to return void and so make
> >     it identical to .remove_new();
> >  c) Change all drivers back to .remove() now with the better prototype;
>=20
> Change c) seems like it will be just as much work as a), right?

Yeah, but c) should be trivially doable per subsystem using coccinelle.
So my plan is to do a) per subsystem with one patch per driver and c)
with one patch per subsystem.

> Who is going to do the work of the conversion to this new prototype?
> I'll be glad to take this, but I don't want to see a half-finished
> conversion happen and us stuck with a "new" and "old" call, as that
> would just be a mess.

The idea is that this becomes my new pet project once=20
https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.org
is complete. :-)

I intend to work on that once the patch under discussion is included in
an -rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g6vfgruhanaz7egz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOTWaQACgkQwfwUeK3K
7AmSVwf/ejJOQweFdqwYLKLY4leXQrQQzVFBOFvfv4KBpW65Mz2VJA23j0yQfClt
GvWpDD24ECKBFlPfliFc2vR/1IkkPb7XFsE6pRhlwUD+dIIfpq8qufdYqT0bWM6j
bEgnZbLrbCnv9eqch/jUde4nAB9gzgDEe7DuZYl/SI1GqVeqRnz3xhHqDV/qRX0u
1s04+PwstJfOqZ/ViVPxRXZ2U2AgSl334mDy63CdqHmF3AyuGL6CnZQMN3VV5oT/
yRBXWpHyVE/81Y7MrS/R2VrO9PIC8HyVX6+tGiKPXqx4y/XpRYDf9FUoqog9QMVm
dE3kOnEoiIRSvMX+Rxq2k6pnuMCGVA==
=q3FO
-----END PGP SIGNATURE-----

--g6vfgruhanaz7egz--
