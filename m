Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD465B8827
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiINMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:24:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411A804AC;
        Wed, 14 Sep 2022 05:24:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l8so6085174wmi.2;
        Wed, 14 Sep 2022 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wBt4MJoWl/XDT9vy+Q1AkMM9o2ZOPWW9WHkHGa3sxhY=;
        b=nWOFaA7ZwGlz54U+SMdBLHOLHi6dnpfbv8fIqYBxxOW7NbDJXlYLquPSy48OUCdZt1
         Dv7sX4p+Y4QIr2EcuR/JksuUoWXbrhJuLvyqAC8j4HQNSDCnc2ZfmaXODU+e0eW/uL1i
         uGaNnEZ3fBAvKzPqCnnUuglAHi5HCBa3J9Bed/b5v2WWx8Um0xORLaVCUSlalMEj5+YQ
         H5anYejOx5PZUlxiDCsIxrB0Gj9lJ6akBja5oGxX4u4zBPoh5x1cPARYspxuGKB+9zha
         5MwGqvab7xw90HlTnebqvoWf2IlVXD+VyxvOCrtnVogECUnV53Vz+hBspF7s6jUmNUXz
         UIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wBt4MJoWl/XDT9vy+Q1AkMM9o2ZOPWW9WHkHGa3sxhY=;
        b=QH7uOMhuAInBqXsYk4luszCPOGQdeyFUANLPBEQHCJdid4k/MabQvUblFoEbFBEe1y
         Sqok6Wgcio1ZRheOJpMTqSsmHcH41KHAxpEZebzLpOmQjT31Dkak+Xz0cIsRKW6GVYrj
         MhbL2PPS/pgj5UIuA9JkBJYCfOpMQ2Lw7mfFNOiwRomUAXGbJqN1LNyYaaZrEPKWKAG+
         XsMnDcvVjS7FQvjvvTuC092tj5rW0utgRToahebbfEeujVHf3+2VxP4C+kEjIO9Fsfgm
         zCqPZK7kvn7HVRByQRPUYHytuzDc2WW0Pc07m2GbVKGP6Jo79+JIgEVa+XGup+IEVkOp
         2KAg==
X-Gm-Message-State: ACgBeo106QJTEJinW7gI70zqHJEpDFzt/MWoqtBn5+D0XwocNbn48wUf
        /YcPL3+FoyyDql5CKKn9QFF28nXREwI=
X-Google-Smtp-Source: AA6agR5lupUogktVVOUvlWGaHhyOnVIxvwSjXlBRX6nCtOvIt8osQVcYYAWHrnhszVIBSsLTEhP5ZQ==
X-Received: by 2002:a05:600c:3d0e:b0:3b4:9bd1:10be with SMTP id bh14-20020a05600c3d0e00b003b49bd110bemr2854372wmb.101.1663158249798;
        Wed, 14 Sep 2022 05:24:09 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b00228692033dcsm13236893wrr.91.2022.09.14.05.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:24:08 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:24:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 4/4] mmc: sdhci-tegra: Use actual clock rate for SW
 tuning correction
Message-ID: <YyHH5i3Hon/QRxLF@orome>
References: <20220914095628.26093-1-pshete@nvidia.com>
 <20220914095628.26093-4-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zOKpBxCMi8Uq2OO3"
Content-Disposition: inline
In-Reply-To: <20220914095628.26093-4-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zOKpBxCMi8Uq2OO3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 03:26:28PM +0530, Prathamesh Shete wrote:
> Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
> instead of requested clock rate for proper use during tuning correction
> algorithm.

Ideally there shouldn't be a deviation between host_clk and the actual
clock rate that was set. Perhaps it'd be good to provide a bit more
information on what the deviation can be and when that happens, as well
as what the consequences are. That would make it a bit more obvious why
this fix is needed.

Thierry

>=20
> Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
>=20
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7d16dc41fe91..42b018d4ebc3 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -778,7 +778,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
>  		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
>  			host_clk, err);
> =20
> -	tegra_host->curr_clk_rate =3D host_clk;
> +	tegra_host->curr_clk_rate =3D clk_get_rate(pltfm_host->clk);
>  	if (tegra_host->ddr_signaling)
>  		host->max_clk =3D host_clk;
>  	else
> --=20
> 2.17.1
>=20

--zOKpBxCMi8Uq2OO3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMhx+YACgkQ3SOs138+
s6HfBxAAnPdKARLXzcEwbcSdBGD3yO9uo9oEcuzg73LbgObCNv59HF6nhTNxXW+S
qZ2zUtF0sGpTkWFgMCW1BepxdMe5VrsrDLPJizMVALY+bOvDamzpFOz68gRd/g7B
lJaRRWhpTbnZmYuk6M7u9NHRTkwFfbgbruRscwfEjAV2dFYBAPatYLd0OS+cqhyC
137ug/6Dtftt4qtd3Wva6EnxHf14HOI/DlrvsnnQr1BLYxYR5lExIvViJmqlKT9N
2ALPizSJPovNoQdUU76+VJrY+4Q2edqTV+26KIiVUdnsbFznmZos5Gfi92tCXi+K
atf4Cch3S6eUKjEFcJUGLWPwOvr2wCwl6J+5Tt+pr9YNZX7Sa5A2ftYf8g3IGr+l
iWI5RUNXoAWdcG7Xq4ut/dJblSXj+al527q4Cnt8hkTmadMyWRJanIBjuyTcF3hD
3h4oVnaAF2aS9hmGvt/3B9YdEucXk3OPLva7lZTMype95/E5BvQNZswMTTSHPr65
4zVIetLfStlYtzTAp3sDmgtksmRz3Ksn9amp0pJGuFcLMw6VXKBiAcWPtHQ4epH5
ID/Kbv/zOIIWbOnFcXAsEN5A+EB7bQR1tP/MvGTITaD+0rZMSatbkSBmp6y2yyFM
1U7h12sAuo2gi3jHGBw9cCkX3uZv8mjJCAEU1w3Lhsi/eASM8oc=
=RpCl
-----END PGP SIGNATURE-----

--zOKpBxCMi8Uq2OO3--
