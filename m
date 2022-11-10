Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153DF62468E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKJQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKJQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:06:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC814193EE;
        Thu, 10 Nov 2022 08:06:03 -0800 (PST)
Received: from mercury (unknown [37.80.60.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65E9B660292B;
        Thu, 10 Nov 2022 16:06:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668096362;
        bh=00s8jQy9bbBTvPGsgrzKJ+3MnFtdFcU+J2/V0mkJyXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2cetD6xrYMUfQ6kMBxSGukPp29HnVMzEZD+1TfoWR79cB9Qlzq33hcoZCtlKH8eS
         ho7ahpaDxTbuNCXrVzzwnJXtWBoxW2Two2Cq3Ylp4ikVqGEc0977CIbhnlqud6XyV4
         JJhWx9+kEJDvTP/FbjFJQmfrMAfb+fv9Smp/aA6OB1BqHWad+nQ9DzQIde8130k77T
         aiwt8D/gyG3A0j7HdGe2VsEICvzQIXHmj2k7EJ4Bl19/Q/BEuSQa4kbmUbR4WJwCuX
         bTkOXZnkOu6Y3hCBeY+K/Y2snhWGPYPMsj6//SSKf/IEdegerSsze0IuXwqMy/qKJn
         xAaiWCUWAKhMA==
Received: by mercury (Postfix, from userid 1000)
        id A796A10672E0; Thu, 10 Nov 2022 17:05:59 +0100 (CET)
Date:   Thu, 10 Nov 2022 17:05:59 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
Message-ID: <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="chijkvcuufofrcrc"
Content-Disposition: inline
In-Reply-To: <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--chijkvcuufofrcrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 05, 2022 at 01:25:43PM +0200, Ivaylo Dimitrov wrote:
> Use the same logic to identify genuine batteries as Android does.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---

Why do we care?

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 8869067..ca6ee2b 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -422,7 +422,7 @@ static int cpcap_battery_cc_to_ua(struct cpcap_batter=
y_ddata *ddata,
> =20
>  static int cpcap_battery_match_nvmem(struct device *dev, const void *dat=
a)
>  {
> -	if (strcmp(dev_name(dev), "89-500029ba0f73") =3D=3D 0)
> +	if (strncmp(dev_name(dev), "89-500", 6) =3D=3D 0)
>  		return 1;
>  	else
>  		return 0;
> @@ -439,10 +439,19 @@ static void cpcap_battery_detect_battery_type(struc=
t cpcap_battery_ddata *ddata)
>  	if (IS_ERR_OR_NULL(nvmem)) {
>  		ddata->check_nvmem =3D true;
>  		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming=
 generic lipo battery\n");
> -	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
> -		battery_id =3D 0;
> -		ddata->check_nvmem =3D true;
> -		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming gene=
ric lipo battery\n");
> +	} else {
> +		char buf[24];
> +
> +		if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
> +		    strncmp(buf, "COPR", 4) !=3D 0 ||
> +		    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
> +		    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) !=3D 0 ||
> +		    nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
> +			battery_id =3D 0;
> +			ddata->check_nvmem =3D true;
> +			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming gen=
eric lipo battery\n");
> +		}
> +
>  	}
> =20
>  	switch (battery_id) {
> --=20
> 1.9.1
>=20

--chijkvcuufofrcrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNtIWQACgkQ2O7X88g7
+polKQ/+PqeaNQtoERs12N6FKukqcJm8e8OzE2xFCjiUANFWnA/1LqUziJQQpo3C
N7FAjvl23yu9fVmLuIs2zAK0nFRLYugkQrwxuHpZYPAS34SkyOjbUC2VEzNb7bgu
NUyW+4jhxKfdyJf0zWmRB/6RnQINx/dUqw698qEAKzbJ2jBGVIYJqXnSI5XxWJBG
HBNkt5Aj3CVftP+pzPh8Tncjc2lKtrsKWXU/3BTg8qi6/sjYdSk5DTnydz54sYrH
Tv5WSBPHSa+WyI2jNgYLAE8SB3F0dKMN8c/bWvGC4FSm+e1SzQnz7QqzEs83vM8V
SYXtWoMF8hFA7AP1a3t16neRBZlHc1ET1eazLI201NVBAYBfe7CjjGjtWKYAJx5i
yxh+YGh0WQVxZBL50vf0znL5mAm2Bnf7z/i1j92w0ofixy7m09hiyaIM8rK+qdJh
ljQGYVk0c4lqqcTv1F/6WWOkNkMHh4xCRjmVXHOXEZgfkyckFunjYqH+73UvK1ct
CxutJr3QPdxLSvkBfZpMjOaI7NMvOiqqY1KkodWRy72f15ucT7j/HVK0o9p+BA9q
iEkGHPyBf8W9zhlcOjeiy3OXhZ+Vcq8M2R78wFsgB+5CSlNHKtk2+PMsa6HKk5Le
pasFiI3BHBUhuPMPovwR48ZcJqkRIMKc7OJCY1CjkEXByvVLL5k=
=3moH
-----END PGP SIGNATURE-----

--chijkvcuufofrcrc--
