Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC4611E95
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ2AE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ2AEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:04:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448F3740D;
        Fri, 28 Oct 2022 17:04:52 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B1E06602942;
        Sat, 29 Oct 2022 01:04:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667001891;
        bh=N/y7U/Okdvo3CXVLovtSFdb9ULZV0KM7M5mV6wzzd+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=od03TChcm26PnFRBuIxGENz/XdB14TrhfNjelcIfoS0F1hwZBW0yz5f8L1VES0KJE
         bvSxMV8oyglk8hCfqaBXuxttQQJtCNhOF2uuDNdrVtYYWXxA/cEYs+hsrC0NKAR/XA
         UBTDQlgppmxudInnokcyDHj2FJoGDlIeM1lLatBaFtYWdX3RlVFTdTSY9un5Tbj/3m
         8LlH5qPocYrsrecWhQ57MQADlE2S88nBW5gZSo7uLY9m52ONfH6RJkkNg/DK4p7sjm
         jG3BDZPaWxrGVTdfptBZcJtA7eGHDZ3Psi6fFJvLXooKXQmqu7bduep65EG3TkrUf3
         4lrcS4EkOLbYA==
Received: by mercury (Postfix, from userid 1000)
        id 94E241060757; Sat, 29 Oct 2022 02:04:48 +0200 (CEST)
Date:   Sat, 29 Oct 2022 02:04:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: remove dead code
Message-ID: <20221029000448.zanbx2cdb6woxw36@mercury.elektranox.org>
References: <20221004073652.568681-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpqim7ikonix4hlu"
Content-Disposition: inline
In-Reply-To: <20221004073652.568681-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zpqim7ikonix4hlu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 04, 2022 at 12:36:51PM +0500, Muhammad Usama Anjum wrote:
> tmp is an unsigned variable. It can never be less than zero. Remove the
> dead code.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Right, but the return value of regmap_bulk_read() should be checked
instead.

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index aa4b33f1bb83..ba3f5ccaeacd 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -785,8 +785,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_ch=
arger *charger,
>  		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>  				 bulk_reg, 4);
>  		tmp =3D get_unaligned_be32(bulk_reg);
> -		if (tmp < 0)
> -			tmp =3D 0;
>  		boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp,
>  						    charger->res_div) / 1000;
>  		/*
> @@ -825,8 +823,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_ch=
arger *charger,
>  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>  			 bulk_reg, 4);
>  	tmp =3D get_unaligned_be32(bulk_reg);
> -	if (tmp < 0)
> -		tmp =3D 0;
>  	boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
>  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
>  			 bulk_reg, 2);
> --=20
> 2.30.2
>=20

--zpqim7ikonix4hlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNcbh0ACgkQ2O7X88g7
+prK4xAAp6R66xdKiJ+FGOpxmJeMQwpCWEbEbP6OQms2yhUH7sC8gAf4hJVIt+Ee
68BsaBG+FElQP1Ocj7aWn+6Up2ZXpX9oEpJ3DFr9zzD6Pw+zQqXl2Wc4TEldQVjq
u3/vc0vcSpxVrCbGcaedKjXt2yvTWN0Wrr7S2SljalxV8XhgeypeTW0ZvxGDB6pR
RXyf1qSwvOrNuv5sf816DbS27TaN/ALr8fjjVRTH3frn7K778a3tWVf7TdBXeq70
y87rwQaPAa1TY4bgk5Cai5a80h7VlVmzznCl4HDqwMoe0DlFZnX2Zq6YzfxmPDer
x1+PDqarZTxDO/EmA6fyWAXi/UD1zBsEYAaMOb0P/HBplagio6FoUw4/LIz/P3+y
iPFV7GxIPjLwzyz7gRE517dKI4WVnkiyV8cAgfbR7cLpqgFq4G9vIbMHE8tNNvPp
XcIwwEjPxSSic0G8aWQHW537BceBBX/INZxgnOFKO9lVKJUf3qzc/m20ylL4N918
2uG/LHffzoXVOFQv2XuOr6ECwW+SppZ/uauv+7HA7UVxWc5zyswDhUThx47PpW8f
x+cShq3izB13CMKEvndmXMxccjhd39MTZEw2V9vZMNbMzT7oFWJWtUh9C0bjDRWx
MPTBUfZGN2jMI9NM6YWUrIV5D62LXW7VXCC4O2+DKPV/MWzM8y4=
=UJ8c
-----END PGP SIGNATURE-----

--zpqim7ikonix4hlu--
