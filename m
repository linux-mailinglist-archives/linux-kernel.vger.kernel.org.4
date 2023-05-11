Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D716FF4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbjEKOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbjEKOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:49:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50812E95
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:47:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1px7Z5-0007VI-Fa; Thu, 11 May 2023 16:46:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px7Z4-002kWX-L4; Thu, 11 May 2023 16:46:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px7Z3-003QwV-PY; Thu, 11 May 2023 16:46:41 +0200
Date:   Thu, 11 May 2023 16:46:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <20230511144641.rhp2xjc24fu6h5nh@pengutronix.de>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2r64mnjufswhfhxc"
Content-Disposition: inline
In-Reply-To: <ZFzWCey825wSlr2v@hovoldconsulting.com>
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


--2r64mnjufswhfhxc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johan,

On Thu, May 11, 2023 at 01:48:25PM +0200, Johan Hovold wrote:
> On Thu, May 11, 2023 at 12:39:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, May 11, 2023 at 12:18:09PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 11, 2023 at 9:34=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Many drivers that use runtime PM call pm_runtime_get_sync() or one =
of
> > > > its variants in their remove callback. So calling pm_runtime_put_sy=
nc()
> > > > directly before calling the remove callback results (under some
> > > > conditions) in the driver's suspend routine being called just to re=
sume
> > > > it again afterwards.
> > > >
> > > > So delay the pm_runtime_put_sync() call until after device_remove().
> > > >
> > > > Confirmed on a stm32mp157a that doing
> > > >
> > > >         echo 4400e000.can > /sys/bus/platform/drivers/m_can_platfor=
m/unbind
> > > >
> > > > (starting with a runtime-pm suspended 4400e000.can) results in one =
call
> > > > less of m_can_runtime_resume() and m_can_runtime_suspend() each aft=
er
> > > > this change was applied.
> > > >
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > >=20
> > > I'm not against this change, although I kind of expect it to trigger
> > > some fallout that will need to be addressed.  So caveat emtor.
> > >=20
> > > Anyway
> > >=20
> > > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> >=20
> > Thanks for your review tag. I wondered if there will be some fallout,
> > and don't know what to expect yet. Sounds like getting it into next soon
> > is a good idea?!
>=20
> No, this seems like very bad idea and even violates the documentation
> which clearly states that the usage counter is balanced before calling
> remove() so that drivers can use pm_runtime_suspend() to put devices
> into suspended state.

I grepped around a bit and found:

	To allow bus types and drivers to put devices into the suspended state by
	calling pm_runtime_suspend() from their ->remove() routines, the driver co=
re
	executes pm_runtime_put_sync() after running the BUS_NOTIFY_UNBIND_DRIVER
	notifications in __device_release_driver().  This requires bus types and
	drivers to make their ->remove() callbacks avoid races with runtime PM dir=
ectly,
	but it also allows more flexibility in the handling of devices during the
	removal of their drivers.

Hmm, while I see your point, it's still ugly. I'll think about it.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2r64mnjufswhfhxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRc/9AACgkQj4D7WH0S
/k56Mgf/YftJ3fDMA9Ym/QCQJxmIm5XW5t8qQgjc7LGRjthi2GfgzxIFJAU5cEkJ
9YjkEcOD5H+tLX3bvon7Jg50gCq9dT8Cg2WcN4FbPt35bbGQ8nBuXH20KwgmC5in
SOzSpqwfeXUxTF4V9UI/M1snKJDzV1IgZVkHbmPvEaffi4ReNCfo/1SFLue2SZ4c
6KUZcqmoyDiJZRD2SafE0i7nnkUcu5PfF4txM7p/bO+Kfa3jAx9weT85syRYPa4n
sS7tjY3WUlJGzNyA8zqj5OAiX+qXWRWFdVeOgqJFWQI6CFj1oJUq4t63sLAS2UHK
y4AjS6Pv1EOgP0FVQfN9X45EzLJjgQ==
=axaw
-----END PGP SIGNATURE-----

--2r64mnjufswhfhxc--
