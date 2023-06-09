Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA772A6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjFIXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:14:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C52D52;
        Fri,  9 Jun 2023 16:14:27 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 454A066058B2;
        Sat, 10 Jun 2023 00:14:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686352465;
        bh=OVbrpsZIR2JQ+RAVl4Mjyhs9Fy0GiztuJgn4U6+S2iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6mkt8NU48/8Oxba+IYnNWl245e8TAwLRbESYRY5Yt7IYvMKsKZqjZItFUFUv5xcy
         l+OW0A+nAZzWNr3sB/YLPWDsDWQtPgjIiNAT1fnZ9fA39O6ZKg+bs8ODPq4o8440XX
         ZlvwkO1kcWDyJ/R6BCL8v6QGt/UVZ6FZcw3PK0f3yBxMkznFwDbuIfhLH5jB99mzLU
         9kaSMdZuVxIFMd/Vx2BqO2fDrACyQ55TKJEBn+LXsRRm3cfJwYtyhtyXn/+1iBSFIb
         bZ/DNjL9m21Mz/JENw+Hk0xyeGlTsQkybZmbfC1uudoFnig3LiZb5IiuBzG3Y8SNE4
         vfYW6ssYdKv+g==
Received: by mercury (Postfix, from userid 1000)
        id 52FD11060921; Sat, 10 Jun 2023 01:14:22 +0200 (CEST)
Date:   Sat, 10 Jun 2023 01:14:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] power: reset: at91-reset: use driver structure as
 status parameter
Message-ID: <20230609231422.taqokbmxojbfdn2v@mercury.elektranox.org>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
 <20230609143912.849995-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulw4km3dguudpisq"
Content-Disposition: inline
In-Reply-To: <20230609143912.849995-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulw4km3dguudpisq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2023 at 04:39:11PM +0200, Miquel Raynal wrote:
> It is quite uncommon to use a driver helper with parameters like *pdev
> and __iomem *base. It is much cleaner and close to today's standards to
> provide the per-device driver structure and then access its
> internals. Let's do this with at91_resete_status() before making more
> modifications to this helper.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/power/reset/at91-reset.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 741e44a017c3..a8a6f3997768 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this, =
unsigned long mode,
>  	return NOTIFY_DONE;
>  }
> =20
> -static void __init at91_reset_status(struct platform_device *pdev,
> -				     void __iomem *base)
> +static void __init at91_reset_status(struct at91_reset *reset)
>  {
> +	u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
>  	const char *reason;
> -	u32 reg =3D readl(base + AT91_RSTC_SR);
> =20
>  	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
>  	case RESET_TYPE_GENERAL:

You also need to update the code calling this functions, otherwise
the series is not bisectable.

-- Sebastian

--ulw4km3dguudpisq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSDskoACgkQ2O7X88g7
+pqnnhAAjBSbPqAOKOaaMhYoD0mevlwW1uP7DXSkKHiKfEvaBxnNIl+pcKpw6XAd
kWR5G1HI9TDRI0sGO1rmiqElD5KkG2W9AG+N2XyQ29farZW8jgsYMKLR9o/SGkDe
SszxTRocOF3zzWsb/RCokOjHL5QJuqvaVi37mdo6/6AyjJHRN9yx5T1zY4ZexASG
xN81JWQYotuSK2yUy8wD22mmGrvHL2pAb75t3uqcVTjRvah3w9Mx4Bmc+9a9gvas
xyHp2VOdPEh/wRYMNb6h67xW2nHKWMK+Ab4uNZdoSYvFAmXKUx4gedgsMQP4ArAf
Y8OHQZmY8/bFc76SwJuZy9gD82z+iy+WLKcJFSdZmrJ1Bb/JexahHoMrLwan3wCd
/EWvrPIxgEssdJ9RL/ZURBf9OzgtUSW3k4ciGvpIO46ZHLCHYmah64BqE5eDkAzr
Pko47F+GgDHCD+KqkSIGiCM/9mmRF5FXGONZXg3paXgBaT1KtsD+VVhcdFXsM55W
vzDRWE9wNlbd/B1kDs4h6QPCSHtzD0PvnRx8Ofd8yJFFOeh9g+zhQdtJQ9cXxTG+
3rdzd1Z857Yvk6MpBTRBnC/eOkscsjIRRF2iJr0oKsQu920KS5tPP4u+JnIW6jNW
rpqq4PNqFy/QhtcCO2xvPu/MvzEjYJ5lHX/3hB5yZeQIDyH3Yc4=
=Bdzs
-----END PGP SIGNATURE-----

--ulw4km3dguudpisq--
