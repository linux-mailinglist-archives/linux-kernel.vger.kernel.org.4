Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857156FF007
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbjEKKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEKKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:39:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FAD1FDA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:39:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1px3hk-0007Op-PQ; Thu, 11 May 2023 12:39:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px3hj-002hiF-Ty; Thu, 11 May 2023 12:39:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px3hj-003NcI-8D; Thu, 11 May 2023 12:39:23 +0200
Date:   Thu, 11 May 2023 12:39:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7m2fk3b3fmff72si"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
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


--7m2fk3b3fmff72si
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 12:18:09PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 11, 2023 at 9:34=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Many drivers that use runtime PM call pm_runtime_get_sync() or one of
> > its variants in their remove callback. So calling pm_runtime_put_sync()
> > directly before calling the remove callback results (under some
> > conditions) in the driver's suspend routine being called just to resume
> > it again afterwards.
> >
> > So delay the pm_runtime_put_sync() call until after device_remove().
> >
> > Confirmed on a stm32mp157a that doing
> >
> >         echo 4400e000.can > /sys/bus/platform/drivers/m_can_platform/un=
bind
> >
> > (starting with a runtime-pm suspended 4400e000.can) results in one call
> > less of m_can_runtime_resume() and m_can_runtime_suspend() each after
> > this change was applied.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> I'm not against this change, although I kind of expect it to trigger
> some fallout that will need to be addressed.  So caveat emtor.
>=20
> Anyway
>=20
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for your review tag. I wondered if there will be some fallout,
and don't know what to expect yet. Sounds like getting it into next soon
is a good idea?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7m2fk3b3fmff72si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRcxdkACgkQj4D7WH0S
/k7jXAgAqiN5Sx0I4QVbgbmz3wNVPRVsHVwlqohYzZRSi/SoXrO5XouqiedZTlxb
N+rfTwegroja2y5jUYhZ6t/g6G6a76fXzwgYV8Mit/bcspRd7oxAlvgGVOzzi8DC
qUEWRVzDXgTTnZO++4TIxv55SVV0+fYGi87LzObnh/Iq7URXNjlnCpLNgUZGgdoI
fUPjs6NTmEOFVh6BbC60/7ArxaLwJJLjo4gHzfjt+BaCr8GjwtUoxjgmst3kfV4x
v8Cjx6JANS4QLSPv5oZ7HGjzAZLEX5bBnvGwmEvufFPyEt04F6ypOe2k7Df9/0r0
DIZm1vX5Ce1vQEI72CJWBZPRUL0/Mw==
=Sp3J
-----END PGP SIGNATURE-----

--7m2fk3b3fmff72si--
