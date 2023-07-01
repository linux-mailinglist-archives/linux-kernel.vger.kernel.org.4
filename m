Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0F744AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGARRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGARRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:17:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B691FF2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 10:17:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFeDP-0001af-VU; Sat, 01 Jul 2023 19:16:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFeDL-00BOjc-EM; Sat, 01 Jul 2023 19:16:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qFeDK-001NDS-PY; Sat, 01 Jul 2023 19:16:50 +0200
Date:   Sat, 1 Jul 2023 19:16:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: r8a66597-hcd: host: fix port index underflow and
 UBSAN complains
Message-ID: <20230701171648.orex7hx6jpkkpub3@pengutronix.de>
References: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gywfdzj6mlm4tas5"
Content-Disposition: inline
In-Reply-To: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
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


--gywfdzj6mlm4tas5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 12:39:20AM +0800, Zhang Shurong wrote:
> If wIndex is 0 (and it often is), these calculations underflow and
> UBSAN complains, here resolve this by not decrementing the index when
> it is equal to 0.
>=20
> Similar commit 85e3990bea49 ("USB: EHCI: avoid undefined pointer
> arithmetic and placate UBSAN")
>=20
> The changes in this version:
> - fix some compile error
>=20
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/usb/host/r8a66597-hcd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-=
hcd.c
> index 9f4bf8c5f8a5..6c597c668364 100644
> --- a/drivers/usb/host/r8a66597-hcd.c
> +++ b/drivers/usb/host/r8a66597-hcd.c
> @@ -2141,10 +2141,12 @@ static int r8a66597_hub_control(struct usb_hcd *h=
cd, u16 typeReq, u16 wValue,
>  {
>  	struct r8a66597 *r8a66597 =3D hcd_to_r8a66597(hcd);
>  	int ret;
> -	int port =3D (wIndex & 0x00FF) - 1;
> -	struct r8a66597_root_hub *rh =3D &r8a66597->root_hub[port];
>  	unsigned long flags;
> +	struct r8a66597_root_hub *rh;
> +	u32 port =3D wIndex & 0xFF;
> =20
> +	port -=3D (port > 0);

I have no idea about this hardware, but it seems strange to me that
calling r8a66597_hub_control with wIndex =3D 1 should have the same effect
as with wIndex =3D 0. Is you changed backed by knowledge about the
hardware, or is that just the most obvious way to get rid of the UB
warning?

Having said that, I think

	port -=3D (port > 0);

is hard to read compared to:

	if (port > 0)
		port--;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gywfdzj6mlm4tas5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSgX38ACgkQj4D7WH0S
/k4tNgf/ep/95gzw5jQArTC3FtjO3zc3UYOBKcYpvKleZqJ4/YZnaQN9RPNFTx2Z
ZrhMB4vqbRuvBoCYn/JwXpPsj7GdQ9VvhFTy//FUmtfBMu7gcHDcMV3m9xZt0Gdx
F/aiPQU1swb+wDVoVxZUR5MB29gdmaFMw0ZX9WuX0TNiA+ZO4dV4kUnhL3f3ExaJ
xgHtvBwdLJfXZPRZCjx9IhKNAMXiqp0KsouDI73DVdpcaJzveVp8EnbWc1UeVTfc
0MwCjbcjmLDWJGfTExZWHKtp+GItQ/hZRjj35FNDiQ3bQ9N9ygn/8RoIFsbRaBdI
LYJM5m9YyBZpV+G6mSuHy7/kvSlgzw==
=ma5m
-----END PGP SIGNATURE-----

--gywfdzj6mlm4tas5--
