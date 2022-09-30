Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108C5F0C64
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiI3NYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiI3NYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:24:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2685DED0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:24:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeG0N-0003Ks-JF; Fri, 30 Sep 2022 15:24:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeG0L-003oNI-JS; Fri, 30 Sep 2022 15:24:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeG0J-004g6I-DQ; Fri, 30 Sep 2022 15:24:35 +0200
Date:   Fri, 30 Sep 2022 15:24:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <20220930132424.wnnrs4bpwiuukclk@pengutronix.de>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
 <YzbdmJvcPiYAIalt@alley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dowvqq5w23hmyog7"
Content-Disposition: inline
In-Reply-To: <YzbdmJvcPiYAIalt@alley>
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


--dowvqq5w23hmyog7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 02:14:16PM +0200, Petr Mladek wrote:
> On Fri 2022-09-30 13:10:50, Uwe Kleine-K=F6nig wrote:
> > For code that emits a string representing a usual return value it's
> > convenient to have a 0 result in a string representation of success
> > instead of "00000000".
>=20
> Does it really always mean success, please?
>=20
> IMHO, if a function returns a pointer then typically only a valid
> pointer means success. Error code means some reasonable explanation
> of the failure. And NULL should never happen.

So your example function doesn't hit the case that we're discussing here
because it will never return NULL and so the code path I added isn't
used and doesn't make a difference, right?

> For example:
>=20
> struct bla *find_bla(int key)
> {
> 	struct bla *b;
>=20
> 	/* Try to get bla using the given key */
> 	...
>=20
> 	if (succeded)
> 		return b;
>=20
> 	/* Did not find bla for the given key */
> 	return -EINVAL;

nitpick: s/-EINVAL/ERR_PTR(-EINVAL)/

>=20
> }
>=20
> It might be used:
>=20
> int process_bla()
> {
> 	struct bla *b;
>=20
> 	b =3D get_bla();
> 	if (IS_ERR(b))
> 		return PTR_ERR(b);
>=20
> 	/* do something with b */
> 	...
> }
>=20
> If get_bla() returns NULL then it means a super fault. It means
> that get_bla() failed and did not know why.

OK, I think we agree that a function that might return an error pointer
shouldn't return NULL with the semantic "This is also an error."

Only in combination with such a function you can reasonably object the
addition of PTR_ERR(0) meaning "SUCCESS". In such a case the right
action is to fix the function.

> IMHO, this patch might do more harm than good.

Hmm, do you think there are many functions that use both NULL and
error pointers to signal a failure? I don't see where the patch might do
harm otherwise.

In *my* humble opinion it's perfectly fine that a given printk feature
results in strange output when it's fed with strange input.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dowvqq5w23hmyog7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM27fkACgkQwfwUeK3K
7AnKZwf/eWmuzFciANyCiQBMxDcmzCX7AmA2zTIi2BqJyBpUw/D1DxGYVd4YVWum
gfXp8GRKHfF8c0ozVU2qTn7sn98hiwSKD+RR1dbiD31LVXmG8YVsxrtpHlFx/CrB
f4OFzWmZE7j1ZKcUuqqiLA19qTtU3b5Wnx1jcndw8qo46kD1lfB0Aofwlo/BTsR0
pHoHp8wK6kPizIoPg0+xfhdYlEkvMoHaMweQFREXEtIukS+aFcy8y9UpFC1THZDQ
kgMIM+ASX/Utt7t0vcPcjeiZt0hCvKxFJUvKs7xCtcBc0M2plTc5PlMhbhU5QTMf
qz3WQHlb4Fb8WKLuqPv/B920ZVtecw==
=PETU
-----END PGP SIGNATURE-----

--dowvqq5w23hmyog7--
