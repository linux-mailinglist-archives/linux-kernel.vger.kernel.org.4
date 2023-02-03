Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA1689953
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjBCNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBCNAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:00:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F513D74;
        Fri,  3 Feb 2023 05:00:50 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B2096602F0E;
        Fri,  3 Feb 2023 13:00:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675429249;
        bh=A/jn8B8FWdXm620r8Qsxt7XexyyaId56TtoNgW3vcE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYY1YQWLY23yZ5b8Xp/MWeOTy4/TqV4xhqLqEc7Xof7bK2kYc6ueamWviuYywAIEb
         BMps1KV9exycBXpRLqa+/Lc6dH/IcBAhMGaMsXJdsDuFFhkimeqIQWESjlRG/uMEAt
         62wgIZ6Tf0UCOJ/x9+a9BBjEmBVaj2AE0Na4+QbZc6cYYm6LDs/c4wvuQQ4IZgEBcq
         S1o+p5aXSx421nflsrXkIYfjZoxO7GcI6u7WVj7XM2CNoUW9UKyqH+BmMUrZV/IX7J
         X7IoBoDpPchGtCtYlO9b1yZlkfOQXaw8x/mQ4wDiSdVDp5pK1JQwm2irjQMlhrNHlc
         4v1vbd/w5us6g==
Received: by mercury (Postfix, from userid 1000)
        id 06D1D1060930; Fri,  3 Feb 2023 14:00:45 +0100 (CET)
Date:   Fri, 3 Feb 2023 14:00:45 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cgel.zte@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] power: supply: use strscpy() is more robust and safer
Message-ID: <20230203130045.shjvwqkopic65wox@mercury.elektranox.org>
References: <20220919024919.211210-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2t2axxher2oxzor"
Content-Disposition: inline
In-Reply-To: <20220919024919.211210-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2t2axxher2oxzor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2022 at 02:49:19AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> The implementation of strscpy() is more robust and safer.
>=20
> That's now the recommended way to copy NUL terminated strings.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---

Sorry, this fell between the cracks. Applied now, thanks!

-- Sebastian

>  drivers/power/supply/max1721x_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supp=
ly/max1721x_battery.c
> index 473e53cd2801..0f948db958d5 100644
> --- a/drivers/power/supply/max1721x_battery.c
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -384,7 +384,7 @@ static int devm_w1_max1721x_add_device(struct w1_slav=
e *sl)
>  	}
> =20
>  	if (!info->ManufacturerName[0])
> -		strncpy(info->ManufacturerName, DEF_MFG_NAME,
> +		strscpy(info->ManufacturerName, DEF_MFG_NAME,
>  			2 * MAX1721X_REG_MFG_NUMB);
> =20
>  	if (get_string(info, MAX1721X_REG_DEV_STR,
> @@ -403,15 +403,15 @@ static int devm_w1_max1721x_add_device(struct w1_sl=
ave *sl)
> =20
>  		switch (dev_name & MAX172XX_DEV_MASK) {
>  		case MAX172X1_DEV:
> -			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
> +			strscpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
>  				2 * MAX1721X_REG_DEV_NUMB);
>  			break;
>  		case MAX172X5_DEV:
> -			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
> +			strscpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
>  				2 * MAX1721X_REG_DEV_NUMB);
>  			break;
>  		default:
> -			strncpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
> +			strscpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
>  				2 * MAX1721X_REG_DEV_NUMB);
>  		}
>  	}
> --=20
> 2.25.1

--f2t2axxher2oxzor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdBXUACgkQ2O7X88g7
+prhaw/9HGLScrgq/kceuN/lTUZENnhal350PLcsqUeOOTk63o7LJC2yYWf594WP
kjEyXvXocvcAyhQPoFHKXi9uhIXWtk85av/d+TyC19gnfP+GMugVGt0N0ndn98h3
fK7qpMqkvyCxSx3PeWYGP+rxzh8kf9M83k1r2LY0CSVizq4rFN88HIc19Y0nxytq
Ft4E6lsjsq+ulFMkjR2nhWy/sdJDnCzlVxlWrHzIgYa4EyuaMFqcmBHuWX6WUXlx
gJyCcwexKUVIXowL4ql4JPR6JTxsNJERtxPuLTVaEQXWh4Z0o2TFxGe0k7xrCrFP
gnHndUnhhu3vzIWTyxB5q5nl0J1oj7+mspxbmA4SthoRwrHAZj3Fgl+t+q/AZ770
kRN2Q2oOIHrK86d2dylimr2fsWiqyPB+A2HT1BfVrRUQDjhIYMRfjq6f4zWg2fTy
JSr2/Wq4g2yOxzSTdb7ln+z0taCVie23ZcHXe8ECjqDO23mfO8bjZz1u+AkmbTGY
QAAZ7O77VZx9j3OFJ6zmwQyiInutxAvcnhfcafG7Nu4mfQ0ha5inUVe8RJ9G2/vK
y66CA3HHbsC8Kc6DeR0OhajowuNsMDDkpcZHu2cf9n/KqwfjxpHLUX3BBvPxQCOT
YGMknFCklRjv5yMvmpbVjM/yKW2W9zn6Xsuv+8OPc+EMP2MEK0Y=
=+h3N
-----END PGP SIGNATURE-----

--f2t2axxher2oxzor--
