Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06B0744B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 00:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGAWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 18:19:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87810E6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 15:19:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFiw5-0002Ti-T2; Sun, 02 Jul 2023 00:19:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFiw2-00BRVp-5a; Sun, 02 Jul 2023 00:19:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFiw1-001QHH-48; Sun, 02 Jul 2023 00:19:17 +0200
Date:   Sun, 2 Jul 2023 00:19:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: r8a66597-hcd: host: fix port index underflow and
 UBSAN complains
Message-ID: <20230701221911.5mqh677uyhh2s67u@pengutronix.de>
References: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
 <20230701171648.orex7hx6jpkkpub3@pengutronix.de>
 <ad575ac5-fccb-4b1e-b6f4-26caa814414f@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wj7odentrecp6rj"
Content-Disposition: inline
In-Reply-To: <ad575ac5-fccb-4b1e-b6f4-26caa814414f@rowland.harvard.edu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6wj7odentrecp6rj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Sat, Jul 01, 2023 at 02:54:46PM -0400, Alan Stern wrote:
> wIndex should never be =3D=3D 0 or > max_root_hub in the cases where rh g=
ets=20
> used; such values would be meaningless.  But we don't control the value=
=20
> of wIndex, because it can come from userspace.  So we can't simply=20
> assume it will always be valid; it has to be checked.
>=20
> That being understood, the changes Zhang is making here are meant mostly=
=20
> to prevent UBSAN and the compiler from complaining or making false=20
> assumptions.  The actual checks on wIndex occur later in the subroutine.

I'm guilty of not having looked at all on that function, but it sounds
wrong to me to calculate values from some untrusted input and only
later validate the input. It should be the other way round, shouldn't
it? This is calling for compiler optimisations stepping on your toes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6wj7odentrecp6rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSgpl0ACgkQj4D7WH0S
/k7s5Af/USnPiseAlWYYwvuQXAPt3ZkNc9kuJ9OKIJWQQ6oM7HQE+6rNhYJjqhCW
LcUgbvbyNXTpg+2QjhrQ8KLCO809uzcA+EHHBjRTYBQMc953nZQrCb4co2+OJizd
lQsk4EApYEa6d8+2rTs+f5VJGYe9aW9TvrF9cqFoUMwqkIvLiVAHkR3DiTWHu1MJ
F6Qxc7OMf4GprqMR5yL/RRjA66XK2Fxz7po+Z/TBNDVevjt6uAZY5Iw6jCqvVcwz
Guu88RcWdLRtQX99yTPmr8y9ZHdACxYU8JAqLkqrA31IT88ojaiq1s7MWF5m13pD
b72qCAMrWbBix53Uqu5KzXlgakgzEA==
=If88
-----END PGP SIGNATURE-----

--6wj7odentrecp6rj--
