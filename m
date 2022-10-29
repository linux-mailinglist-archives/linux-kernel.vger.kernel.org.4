Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960DA611EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ2ARP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2ARN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:17:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D05AA33;
        Fri, 28 Oct 2022 17:17:13 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A56AD6602942;
        Sat, 29 Oct 2022 01:17:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667002631;
        bh=w7ba4X8MPyTvkQ4A4Oz6t+sl29x7NcjWiX53veUPMxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnEAYVtQRYd1ASJ7VI/RTnHddguySG369ooOablWWfMhrVPSZa5q3h/TBeV8sV7p6
         pXVZgMD/7UGSmIZjS9nJkU6jcVmwN4QdxjkhexamCqE7ShQ2dOCf6xkn6Vsx97xR8C
         ypK/o/jbi8UEMA2cYi0mD+vrWENICBo3OdmpD0A2bNIdWY81v7QR9JkZbIBhxzItrC
         WQr64LGaIQk6TH0F6KKHCcS3VYKCP9A05SphZSnmF8kSS0zkHfjnUvaIn2rsHpWSOM
         W2Bfa1bifqnk5MfXTRJE7/EEx+LU0OkBU9TMFBjEaAnAKRdWT9V4USM/6ZtzgbpXnk
         qQBwXAzktzR7w==
Received: by mercury (Postfix, from userid 1000)
        id DD9451060757; Sat, 29 Oct 2022 02:17:08 +0200 (CEST)
Date:   Sat, 29 Oct 2022 02:17:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH] power: supply: remove less-than-zero comparison of
 unsigned variables
Message-ID: <20221029001708.fxu6he7pbv7voiy2@mercury.elektranox.org>
References: <20221004064521.498510-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kpqij2bctgflog2o"
Content-Disposition: inline
In-Reply-To: <20221004064521.498510-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kpqij2bctgflog2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 04, 2022 at 11:45:21AM +0500, Muhammad Usama Anjum wrote:
> max_chg_vol_reg and max_chg_cur_reg are unsigned variables. The
> less-than-zero comparison of an unsigned value is never true. Remove
> these checks.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

I'm a bit hesitant to apply this. While the analysis is correct
max_chg_cur_reg is sourced from rk817_chg_cur_to_reg(). That has
has a 'u8' return value as function signature, but tries to return
-EINVAL. I think it makes sense to either fix this at the same
time or change the variable type to signed. Also please Cc the
driver author (done now).

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 635f051b0821..aa4b33f1bb83 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -951,12 +951,12 @@ static int rk817_battery_init(struct rk817_charger =
*charger,
> =20
>  	max_chg_cur_reg =3D rk817_chg_cur_to_reg(max_chg_cur_ma);
> =20
> -	if (max_chg_vol_reg < 0 || max_chg_vol_reg > 7) {
> +	if (max_chg_vol_reg > 7) {
>  		return dev_err_probe(charger->dev, -EINVAL,
>  		       "invalid max charger voltage, value %u unsupported\n",
>  		       max_chg_vol_mv * 1000);
>  	}
> -	if (max_chg_cur_reg < 0 || max_chg_cur_reg > 7) {
> +	if (max_chg_cur_reg > 7) {
>  		return dev_err_probe(charger->dev, -EINVAL,
>  		       "invalid max charger current, value %u unsupported\n",
>  		       max_chg_cur_ma * 1000);
> --=20
> 2.30.2
>=20

--kpqij2bctgflog2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNccQAACgkQ2O7X88g7
+pqYLA//VBqbwe7TYlleJXz7Cmqb0nUb+ZG9Pc6wmlWSTpitKPkc1+eAEqJ0azCY
DDZB35scSvAZAyhu/RA1W4+P/v3CW6K172UYSd3xi6IHtwLA9yBNN+k5c/bdpiBH
9nAB/FB2qVN22AHsOeYYRlQ1mTVtvqvvy4DicrM4+AH6WjakJ17QpR/g0xBfjXi/
ZYvYwpzGSGgyBL30IZqFT90dbKlUOTBU6vxsd8bDp448tPhehzfdh0oM0r8lxI34
0d8LDecZlWWY1lbFE7ChDYQ84O5AxEnPABqC3bBVAFUz0pklmAjh0c8rZU8IZcKp
Z6lkETVqwCMLb6auyZfpsbG69JmwnNa53I3qDBB7ub1BauGptcvG0vByqLS6Q7Uc
8kazcsNqiQ+Xmq9ca1rV/p/vSRfraaJJNxGb5zYID0chrsjr7QsirY2AezwgrDi9
x6XzJ1XngE7oTAzdWCfNln0TZ3vUSYOeq+oRduFj4hEEnAuIK1iLTqCUBDS9+Py6
pSho+U2PigHwnh+XTrCHJDIcU1R0By+KLOLUeXvC1k3bvw2uiUsvo2kfDXyecu+v
gsGDTwGwkf4AnMaVKUCPDFPEKhsrIGimP8Pf7I4bR+8zLRxbETznqsBIL0NX2aXa
WRviqu7C1jt3+qYX5Hd3uZgibIyE5Ovtfifa6yiJwG0VTc/ViFA=
=Ig94
-----END PGP SIGNATURE-----

--kpqij2bctgflog2o--
