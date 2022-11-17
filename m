Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A462DD72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiKQOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiKQOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:00:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BB12616
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:00:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfRJ-0001Mv-Cl; Thu, 17 Nov 2022 15:00:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfRH-004rcq-Rw; Thu, 17 Nov 2022 15:00:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfRI-00HIJJ-6F; Thu, 17 Nov 2022 15:00:24 +0100
Date:   Thu, 17 Nov 2022 15:00:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: Reduce time the pwm_lock mutex is held in
 pwmchip_add()
Message-ID: <20221117140024.o77f5prewt5clgyh@pengutronix.de>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-3-u.kleine-koenig@pengutronix.de>
 <Y3SbNM8H3QxY0XF2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlvi67qwyjkzh2na"
Content-Disposition: inline
In-Reply-To: <Y3SbNM8H3QxY0XF2@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xlvi67qwyjkzh2na
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Wed, Nov 16, 2022 at 10:11:32AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 15, 2022 at 10:15:13PM +0100, Uwe Kleine-K=F6nig wrote:
> > This simplifies error handling as the need for goto error handling goes
> > away and at the end of the function the code can be simplified as this
> > code isn't used in the error case any more.
>=20
> ...
>=20
> > +	mutex_unlock(&pwm_lock);
> > =20
> >  	if (IS_ENABLED(CONFIG_OF))
> >  		of_pwmchip_add(chip);
>=20
> Why calling this without a lock is not a problem? Commit message doesn't =
share
> a bit about this change.

Maybe add another paragraph at the end reading:

Now memory allocation and the call to of_pwmchip_add() are done without
holding the lock. Both don't access the data structures protected by
&pwm_lock.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xlvi67qwyjkzh2na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2PnQACgkQwfwUeK3K
7AlD9Af/V9thrUEFDVkdjbTeHHndr863OXZqosxUiaKfo6HtBsqPxycbu/i2NqnH
zjil8JpD32Ez5CwmGun5xyLrX/8D/7TO+G8B+l/nLOne+tDRUZEb6o0uGSBhNJA6
pA7XbTALYcZk82lmAvxgEZrItH28m3PkdZ8IM/mgOGomcgzD08wne8VmfildH0e/
ZF4nLcLTqB1LiRx+lGgIld8dT9AQN/r+5Y+2d68IM/IW4SObexD09nvL4fwW9bFq
bA/pywV/Zl5U9bq1CQTGbqjNnQpuASQY8v3Jj5V8KjexPiKC7hYAUbmlajfmwExX
S4dOsHUg4r5WfJSMHNHcjFdBS7rEVw==
=QrhV
-----END PGP SIGNATURE-----

--xlvi67qwyjkzh2na--
