Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BA666C51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjALIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjALIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:22:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4714FD51
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:20:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFsp4-0003JP-Sq; Thu, 12 Jan 2023 09:20:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFsp4-005Udy-5S; Thu, 12 Jan 2023 09:20:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFsp3-00CCSu-61; Thu, 12 Jan 2023 09:20:29 +0100
Date:   Thu, 12 Jan 2023 09:20:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] platform: Provide a remove callback that returns no value
Message-ID: <20230112082029.aadce6dd35y3inaf@pengutronix.de>
References: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
 <Y5NSevR9kb1UPvtQ@kroah.com>
 <20221209155207.pyugk2dhpyht5gph@pengutronix.de>
 <Y5NfLponxRO7j6nd@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wfbdbied5k52n7oz"
Content-Disposition: inline
In-Reply-To: <Y5NfLponxRO7j6nd@kroah.com>
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


--wfbdbied5k52n7oz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Fri, Dec 09, 2022 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 09, 2022 at 04:52:07PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 09, 2022 at 04:21:30PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Dec 09, 2022 at 04:09:14PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > struct platform_driver::remove returning an integer made driver aut=
hors
> > > > expect that returning an error code was proper error handling. Howe=
ver
> > > > the driver core ignores the error and continues to remove the device
> > > > because there is nothing the core could do anyhow and reentering the
> > > > remove callback again is only calling for trouble.
> > > >=20
> > > > So this is an source for errors typically yielding resource leaks i=
n the
> > > > error path.
> > > >=20
> > > > As there are too many platform drivers to neatly convert them all to
> > > > return void in a single go, do it in several steps after this patch:
> > > >=20
> > > >  a) Convert all drivers to implement .remove_new() returning void i=
nstead
> > > >     of .remove() returning int;
> > > >  b) Change struct platform_driver::remove() to return void and so m=
ake
> > > >     it identical to .remove_new();
> > > >  c) Change all drivers back to .remove() now with the better protot=
ype;
> > >=20
> > > Change c) seems like it will be just as much work as a), right?
> >=20
> > Yeah, but c) should be trivially doable per subsystem using coccinelle.
> > So my plan is to do a) per subsystem with one patch per driver and c)
> > with one patch per subsystem.
> >=20
> > > Who is going to do the work of the conversion to this new prototype?
> > > I'll be glad to take this, but I don't want to see a half-finished
> > > conversion happen and us stuck with a "new" and "old" call, as that
> > > would just be a mess.
> >=20
> > The idea is that this becomes my new pet project once=20
> > https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.=
org
> > is complete. :-)
> >=20
> > I intend to work on that once the patch under discussion is included in
> > an -rc1.
>=20
> Ok, I'll wait to queue this up to my tree until after 6.2-rc1 is out,
> thanks.

We're at v6.2-rc3 now. Is this patch still in your queue and you didn't
come around yet to apply it, or did it fell through the cracks?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wfbdbied5k52n7oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO/wskACgkQwfwUeK3K
7AkRHQf3QaY4LAaAicxdFMOah3kcV3LXA+7CimrK+AQjfs+DAV7w7v0qiAd2eVLg
+p1fU5G7yUSXmMfVTk1QaZ+zMlHcv9MmeSRQtN/N34jHyoj+lzUhq8VFHbbMRNjb
tUf4riW+fdOFrs+5R1Y9GAp/aMFmlCvlBsZPL6PwDS0YHmHH/Ky4lsWbDtU+6WTH
bg0F7sLB/jJdUpG5gA1PLOV2FXWjXLncj9wPXa36TcfyEB18Tz76AwJfMR6vAdt/
KrIuTdn4qRKTO6XllDqqtyDUaKbRZhkfsY6A5J3LaIRNeMyvjbMIT2OhP226duzi
hCZA85T6qzehidWE75ALfj/vgBlT
=PTDo
-----END PGP SIGNATURE-----

--wfbdbied5k52n7oz--
