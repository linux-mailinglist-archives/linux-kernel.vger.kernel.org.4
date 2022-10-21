Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BA6077EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJUNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJUNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:12:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7224CC97;
        Fri, 21 Oct 2022 06:12:09 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7C2D31C09DC; Fri, 21 Oct 2022 15:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666357905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zg4PrWxuduqxqLDtInDipEZNmxUDTweIQdr8yWnhWmg=;
        b=Eb3zfnQehT0rvrVisbI4xGkTvqFh8mo8ejg/XWIjyuCuHuzA0QO1eW1pp3gLe+Qt3yK+4Z
        VBzCGJCk/T1Tl6oFSmOzqNCGWAlDEn/ntA+efnmbXs0Zz9IWdk5s6erlgjq7c/rXLZilw+
        sJDlOmih6l/8yqfaYAqCammdJR0ZGO0=
Date:   Fri, 21 Oct 2022 15:11:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] leds: max8997: Don't error if there is no pdata
Message-ID: <20221021131145.GB16264@duo.ucw.cz>
References: <20221020114442.22215-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20221020114442.22215-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-10-20 12:44:42, Paul Cercueil wrote:
> The driver works just fine if no platform data is supplied.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Does it? Bad Paul, bad Andy.

> +++ b/drivers/leds/leds-max8997.c
> @@ -238,11 +238,6 @@ static int max8997_led_probe(struct platform_device =
*pdev)
>  	char name[20];
>  	int ret =3D 0;
> =20
> -	if (pdata =3D=3D NULL) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -ENODEV;
> -	}
> -
>  	led =3D devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
>  	if (led =3D=3D NULL)
>  		return -ENOMEM;
> @@ -258,7 +253,7 @@ static int max8997_led_probe(struct platform_device *=
pdev)
>  	led->iodev =3D iodev;
> =20
>  	/* initialize mode and brightness according to platform_data */
> -	if (pdata->led_pdata) {
> +	if (pdata && pdata->led_pdata) {
>  		u8 mode =3D 0, brightness =3D 0;
> =20
>  		mode =3D pdata->led_pdata->mode[led->id];

I see pdata being dereferenced here.
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1KakQAKCRAw5/Bqldv6
8uWdAJ4r3w3LJxWPWNYjMp+fGc4O4FZWvQCfci+XGUMtv+6dxa67iUkJQU+Udzk=
=RRfb
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
