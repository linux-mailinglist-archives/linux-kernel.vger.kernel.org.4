Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BED66A11B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjAMRte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAMRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:48:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970F8A210
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:40:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGO2A-0003vE-0j; Fri, 13 Jan 2023 18:40:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGO29-005omv-3m; Fri, 13 Jan 2023 18:40:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGO28-00CaAt-Bg; Fri, 13 Jan 2023 18:40:04 +0100
Date:   Fri, 13 Jan 2023 18:40:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] platform: Provide a remove callback that returns no value
Message-ID: <20230113174004.cmotgiywpgy4apab@pengutronix.de>
References: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
 <Y5NSevR9kb1UPvtQ@kroah.com>
 <20221209155207.pyugk2dhpyht5gph@pengutronix.de>
 <Y5NfLponxRO7j6nd@kroah.com>
 <20230112082029.aadce6dd35y3inaf@pengutronix.de>
 <Y8FD66QlLFYiGR6+@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3zfqc2fuevgkxxn"
Content-Disposition: inline
In-Reply-To: <Y8FD66QlLFYiGR6+@kroah.com>
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


--g3zfqc2fuevgkxxn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 12:43:39PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 12, 2023 at 09:20:29AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Greg,
> >=20
> > On Fri, Dec 09, 2022 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Dec 09, 2022 at 04:52:07PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Dec 09, 2022 at 04:21:30PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Fri, Dec 09, 2022 at 04:09:14PM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > struct platform_driver::remove returning an integer made driver=
 authors
> > > > > > expect that returning an error code was proper error handling. =
However
> > > > > > the driver core ignores the error and continues to remove the d=
evice
> > > > > > because there is nothing the core could do anyhow and reenterin=
g the
> > > > > > remove callback again is only calling for trouble.
> > > > > >=20
> > > > > > So this is an source for errors typically yielding resource lea=
ks in the
> > > > > > error path.
> > > > > >=20
> > > > > > As there are too many platform drivers to neatly convert them a=
ll to
> > > > > > return void in a single go, do it in several steps after this p=
atch:
> > > > > >=20
> > > > > >  a) Convert all drivers to implement .remove_new() returning vo=
id instead
> > > > > >     of .remove() returning int;
> > > > > >  b) Change struct platform_driver::remove() to return void and =
so make
> > > > > >     it identical to .remove_new();
> > > > > >  c) Change all drivers back to .remove() now with the better pr=
ototype;
> > > > >=20
> > > > > Change c) seems like it will be just as much work as a), right?
> > > >=20
> > > > Yeah, but c) should be trivially doable per subsystem using coccine=
lle.
> > > > So my plan is to do a) per subsystem with one patch per driver and =
c)
> > > > with one patch per subsystem.
> > > >=20
> > > > > Who is going to do the work of the conversion to this new prototy=
pe?
> > > > > I'll be glad to take this, but I don't want to see a half-finished
> > > > > conversion happen and us stuck with a "new" and "old" call, as th=
at
> > > > > would just be a mess.
> > > >=20
> > > > The idea is that this becomes my new pet project once=20
> > > > https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koe=
nig.org
> > > > is complete. :-)
> > > >=20
> > > > I intend to work on that once the patch under discussion is include=
d in
> > > > an -rc1.
> > >=20
> > > Ok, I'll wait to queue this up to my tree until after 6.2-rc1 is out,
> > > thanks.
> >=20
> > We're at v6.2-rc3 now. Is this patch still in your queue and you didn't
> > come around yet to apply it, or did it fell through the cracks?
>=20
> My queue is huge right now.
>=20
> I'll work on this "soon".  Do you want this on a tag that others can
> pull into their trees, or just in my normal driver-core-next branch?
> Either is fine for me.

In my experience maintainers stumble when patches depend on patches that
are not in -rc1. So I will be patient until this hits an -rc1. Thanks
for the offer.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g3zfqc2fuevgkxxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPBl3EACgkQwfwUeK3K
7AlySAf/VXSxvD4mCt/9fNmTn6Z+v0Du8klcmSqF3cmvVOgL+oUTC8DCgtOwvKfG
oxLdXDUJ22PklXQE7/YPqZQ4MQCITon7UL4er9hHFyj71rq9+54pAIV/+o6FHdub
Htb1jEM47LQYyUkxBt9PAKmXq9+MTYTuAiQsPxB/eEBmjXZKAanmD4k5Oy9FjU2C
jYotGhoNRAPPK6vQ3UYzOn70H4sGOn0hEol+tg8Hw+MPs5JqtR3J/rfK7VyPlOi1
/NIITfOPX7HZO4c80bIkZQfQXQ0cP+JkNo8S+OeJ8ztKPaTMgyqnFI6wkwuWT9I8
dPPiHEPr21iws9b44TCP8TxF7q5B2g==
=p5oJ
-----END PGP SIGNATURE-----

--g3zfqc2fuevgkxxn--
