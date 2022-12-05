Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C298864253D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiLEI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiLEI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:58:15 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222ADEF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=K7LkyI3EyZtAporb19ChbmQpds4O
        ChSNzIOkIRouAdM=; b=gmo3iwVfGineystUR+8I7+fJPbd1BFQVff/L03zkTjqv
        rY8Qn3/XjmRIuQGwgw0KEbGni7ctVfKgwZ/mf6PaZ0KPygxI6ttt0xbqA2BxH5Nv
        VmuDr3NYgMkq8rJPkPiU6j7T5rcDGoQJwm/WuuRqrV6TPFwcy0CFZJc7Zr74a2Y=
Received: (qmail 2245272 invoked from network); 5 Dec 2022 09:56:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Dec 2022 09:56:37 +0100
X-UD-Smtp-Session: l3s3148p1@0ulr3RDvRIRehhrO
Date:   Mon, 5 Dec 2022 09:56:36 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc
 cleanups
Message-ID: <Y42yRFSai6XKnLiC@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1669213027.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3141AOsAMOMu/lh9"
Content-Disposition: inline
In-Reply-To: <cover.1669213027.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3141AOsAMOMu/lh9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 03:41:16PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> The Renesas RPC-IF provides either HyperFlash or SPI host access.
> To handle this, three drivers are used:
>   1. The RPC-IF core diver,
>   2. An HyperFlash child driver,
>   3. An SPI child driver.
>=20
> Currently this driver collection suffers from a sub-optimal division of
> roles and reponsibilities, leading to (un)bind issues: after manually
> unbinding the child driver, rebinding the child driver fails with
> -EBUSY.
>=20
> This patch series aims to fix this, by splitting off private data and
> making the RPC-IF core driver responsible for resource acquisition.
> After that, a few customary cleanups are provided.
>=20
> This has been tested on the Salvator-X(S) and Ebisu-4D (HyperFlash) and
> White-Hawk (QSPI FLASH) development boards.

Sadly, I don't have the bandwidth to do a full review. But from a
glimpse, it all looks good. And from a high level PoV, this all makes a
lot of sense. So:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--3141AOsAMOMu/lh9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmONskQACgkQFA3kzBSg
KbYZCQ/+J9lcmKr9+8n+KR8ECOOyla6PiySP7OhFib9ryO+tOUhFcBwRrNJaDj0J
Q58ZuHzdo9mDoHct3MZaDuurFDKydb0VtUh/KBfrygvI4iSPK8KKELc3NXMyjBuY
fdHISN3kPD8dZ4kER+g6NuQ/9xFI2QRfFSFYQm4BsztJgenHkqeVbgERs8j5zBZF
I49AiK7zYq1bwRSOHV7T2ZVzUB1wpzDIHJNOBdZiXyeVejkB3stHfRvASlksFF6g
VTTPsBLQ79mZV6o/+FiFYotY+wv34mqkBykBd6wxxcUqjusgW3ty33iyALUHySEK
P2UrNBxUcNW9NHBh5FDhXaF8Wo9tHjYbdtZuRfKkvIqLVEJye7RkJ+wbDdG3QKyd
z7BLyFGL4e0+2L18ClK3DzUV+sJYY1a8jw6aKZNKlrjbdirKwq9ZtIlvo9FtrzHM
7a6jHGH88QpD0nsSBZt5llMqileVG75EiyrY/VsWRZZKYk1kP+qw6boK7y1HZcmu
uKjPqtHVDPXnZAWJh8KkgV9ogYnwaqijxqt9SPlaB7bJoUOA1pXLNeyXZj+UTMHd
hR+xmD/u5Q//rJ+wiO3HXfofl/ql4r2l/p67FRmVnKlFg0k75cYEddOYu2PXxGtU
B64Za2UdTYGdXm0XUPJptoOeajBRo6FlSggm9q+kDCOfeSOw41Q=
=QLgK
-----END PGP SIGNATURE-----

--3141AOsAMOMu/lh9--
