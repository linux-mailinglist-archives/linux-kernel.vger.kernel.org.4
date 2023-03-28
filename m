Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F16CBDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjC1LjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjC1LjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:39:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA544BE;
        Tue, 28 Mar 2023 04:39:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so48429408edo.2;
        Tue, 28 Mar 2023 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680003547;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOfo5niDhVB2rNm6ThwA9sjDrQ1crl5bz8GyIJFAEQs=;
        b=JNW1iiNcHi9ShnTMR/dd7r/ATh8iLz3U6suVuZib5AWR3UUdEl1pzszJI5RZUg697Y
         p4Uln3NMWyNR+9fzQLdPd0kfwKnqzNueujq7jWloCTp06LHb672XnsGyNQGXPfz/9xoD
         bKrsEsZ9ZUe//nvnJesDNNEz1F8Y6aDEus1c5zCVeXbXBXg2miPP/0jou6qMtLM0zgF9
         5NN1hjnyU5kSqjphsRGbb89MLhV0Ivh/Buf0jQp0hlpka3L8PWeEsa3C7bQv5ljUn4U8
         Njg3wFsGlksi1t7BenqEivMhHojHBFnd8kfn0efe7UpxdNhvWxHF0uTbzT76GkYbnzli
         RYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680003547;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOfo5niDhVB2rNm6ThwA9sjDrQ1crl5bz8GyIJFAEQs=;
        b=dQGBymm4cNRe/JfhbEIxDsch4MgiZBdXE6+HranMDw3f5EiY8uKP/apuphEx+ggsMC
         sVdr9n0vhSTeagnuYc+S0+oAOF63luxBt3IAFY+/ihde8WFpetNTIJWxzuwW9qEEFu95
         Nco8nAyQvcqmTfgCz+biFpLZYMP0vBQz4PI1M/R3tbXKgxpLrEYdoPID2ladGeNoZbwv
         rpRQ4xb1/Tw2aJXL7CDZX85t5MS0S71nMEFBMvU8uZiDRzo5rViylRSEXSsFshg/ZCqG
         kq9iWW4UkGeMro0KT0+RGO/qq2MrabtjOBfYj9MPaqhA+Q6NyV9dXuFbRhMV5IPM4g8j
         fIRg==
X-Gm-Message-State: AAQBX9cVXIXDw8DXcEdEqN25/dS41cikqGAKLW6+sPDk04vrjU/ze18m
        DP9JMuxxmEAfRuhfKNzHxuw=
X-Google-Smtp-Source: AKy350Z9SnDe1qGgvJfbBe+Ocul3ghtzrr6xamProPjybLz9jyL0Kb/3t/eblrHw0RWnHOP1Lz4fpA==
X-Received: by 2002:a17:906:3590:b0:8b1:75a0:e5c6 with SMTP id o16-20020a170906359000b008b175a0e5c6mr16168498ejb.18.1680003546937;
        Tue, 28 Mar 2023 04:39:06 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm14402287eje.129.2023.03.28.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:39:06 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:39:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: tegra: transformer: use labels for mmc in
 aliases
Message-ID: <ZCLR2XYBrOVuJHL3@orome>
References: <20230304084319.18424-1-clamor95@gmail.com>
 <20230304084319.18424-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7hXrrpViK7lmN/l4"
Content-Disposition: inline
In-Reply-To: <20230304084319.18424-4-clamor95@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7hXrrpViK7lmN/l4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2023 at 10:43:17AM +0200, Svyatoslav Ryhel wrote:
> Since mmc devices in common dtsi are labeled let's use labels
> for simpler comprehension of tree.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arc=
h/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> index 08ea9cb32d0e..70f7f279fd35 100644
> --- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> +++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> @@ -12,9 +12,9 @@ / {
>  	chassis-type =3D "convertible";
> =20
>  	aliases {
> -		mmc0 =3D "/mmc@78000600"; /* eMMC */
> -		mmc1 =3D "/mmc@78000000"; /* uSD slot */
> -		mmc2 =3D "/mmc@78000400"; /* WiFi */
> +		mmc0 =3D &sdmmc4; /* eMMC */
> +		mmc1 =3D &sdmmc1; /* uSD slot */
> +		mmc2 =3D &sdmmc3; /* WiFi */

I find it hard to see the improvement here. If you really need this,
please merge this with the patch that adds the labels and add them on an
as-needed basis. That is, if you want to replace the paths by phandle
references here, then introduce the sdmmc{1,3,4} labels, but not the
other ones which aren't used.

Thierry

--7hXrrpViK7lmN/l4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQi0dYACgkQ3SOs138+
s6HrVA/+Km3OB1YYUeGd4+77nCO847LN8NdGvwGivbwClB7eSWBbdR6AinIPlsps
oJjLP4fIPcQ8T6p+QKPf2L4MT0AgQZZWJYcBg2EH7zMY1uaoZIyCE9B/e2jsEWz+
Vw3h/gt35XSVM0wVKkcuVDNlQWw7j+65C+u+xkAVh8v8tZrGEscgy0zz7a0001e8
Kk1yEkl+rAqqMaIMNrxxmlKW7X+JOOS1upfSGj8PgbRulCSkHOvbwaLPo/S2mvSI
Bbynh7E4wQ0MWm9eUMi2YRgdrPg4CFGj+PPjk7Xndg0OQZwbtFMmMdfP/Z7FStyI
MkCnlcwqiyfTzdGoWNKm052RTc1AjgXxVcoqfgkyptcB1zTXsRS2VWpJENF0PMMQ
mUeFD6idkJ6xufr6la2w+olnOprhaQNvnu/X7eAgHZqNN1ueLxeCMSUUf+sU6j+7
7RrbW9w4MEyOS1NzNphmjE5C3X0EtFfx3r1lVe4v7P0U3sB7BLGB30LCOaH21JCL
/1p8pDeM6jd9/G193BMr8gr1NPcw+lTJScU1khUUZEVXVoYbUkuA1NKm3DghyJmf
Gp3mkvvt5t6/A1fSOpgv8yYRvcjcaq22vS2AzMcsvbyJB5tcKHDkfmI0SCHpDyNb
bc/eT35SSUgT7WKvi1R1MNCZ8NfVHvoT1iwhPP6CCpgzdCbwv00=
=FM0o
-----END PGP SIGNATURE-----

--7hXrrpViK7lmN/l4--
