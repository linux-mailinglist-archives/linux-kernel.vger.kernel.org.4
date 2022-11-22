Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF906348EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiKVVFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiKVVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:05:14 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838E7C00D;
        Tue, 22 Nov 2022 13:05:12 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F107D1C09DB; Tue, 22 Nov 2022 22:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669151109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttJdIr7VJP72KR28pV2fqwcDiwD/jJbuWCy8v5aljwI=;
        b=MGLRveaPtLAn1l3DCG/w1EmQQTFxekG3EIlyiVNlB7kLwxC2Pkd7N63JKM4fX2ha30kYhd
        ZTOAHAVURCGhAfJi3xUXAyUeiBB/xM+vXe1piICnX17egz8bcizMMnyDI25cH4LL1I0MuR
        Ue+CDl0VqGQUUfsVjkCCZ9wI0s3dBF4=
Date:   Tue, 22 Nov 2022 22:05:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: leds-wm831x-status: init chip_pdata before access
Message-ID: <Y305hfVdhs9zwOi/@duo.ucw.cz>
References: <20221122204837.11611-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FhXHQk6+4qe/wr65"
Content-Disposition: inline
In-Reply-To: <20221122204837.11611-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FhXHQk6+4qe/wr65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> wm831x_status_probe() accesses status from chip_pdata before
> initializing it. Fix it.
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Does it? ARRAY_SIZE() will be compile-time constant, no?

What is the bug? Did you test the code?

Best regards,
								Pavel


> +++ b/drivers/leds/leds-wm831x-status.c
> @@ -212,7 +212,7 @@ static int wm831x_status_probe(struct platform_device=
 *pdev)
>  	struct wm831x_status_pdata pdata;
>  	struct wm831x_status *drvdata;
>  	struct resource *res;
> -	int id =3D pdev->id % ARRAY_SIZE(chip_pdata->status);
> +	int id;
>  	int ret;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_REG, 0);
> @@ -229,9 +229,10 @@ static int wm831x_status_probe(struct platform_devic=
e *pdev)
>  	drvdata->wm831x =3D wm831x;
>  	drvdata->reg =3D res->start;
> =20
> -	if (dev_get_platdata(wm831x->dev))
> +	if (dev_get_platdata(wm831x->dev)) {
>  		chip_pdata =3D dev_get_platdata(wm831x->dev);
> -	else
> +		id =3D pdev->id % ARRAY_SIZE(chip_pdata->status);
> +	} else
>  		chip_pdata =3D NULL;
> =20
>  	memset(&pdata, 0, sizeof(pdata));

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--FhXHQk6+4qe/wr65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY305hQAKCRAw5/Bqldv6
8vzcAKCF1Sez4V/92wP9hgxf2QbQ2Je2mgCgtnjWyFA3hXxYfD2gV32HBrCRHL8=
=ZoaS
-----END PGP SIGNATURE-----

--FhXHQk6+4qe/wr65--
