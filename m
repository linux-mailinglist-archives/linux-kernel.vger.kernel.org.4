Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BB68ECEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBHKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBHKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:31:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2F46727;
        Wed,  8 Feb 2023 02:31:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m1so7591405ejx.7;
        Wed, 08 Feb 2023 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Use+lGfhfpGmOf2tR6YStivC2FXu+PHkUKhkubH8k0c=;
        b=LTjopn4bNg0VNehXGyVt+CplAIedpUPsJwGZXPpWXXyZB8NzU1tTfPAcwojZyudPEJ
         Nwm7uK3HygyWcJR1a55DO+QQbvdlcHB/K6f8DkaFGEcga4N9nQm6+SHijt2S5TM9L8nc
         kY3L1CFmcB15Kaf68CSDAFg0Cr0si8FeHgIof500mdrc2GHq6KXWPxbQ/+mw6RxLUtiX
         mF9Z2zcBLOMdTqN85Z4W3vy3ieXCZi9bh9MfuiczAYBq2pL9sxVBOHpwV1XIdgMfjjhF
         e/RLosRFk7s95W4FgUa2YkImL1dcfCOXuwgc5jenjeh+n1PJjeh1sRxRQOc87mvZSsme
         okPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Use+lGfhfpGmOf2tR6YStivC2FXu+PHkUKhkubH8k0c=;
        b=HjmeJ5su0CtP9lgHfgUQxtDfGJpyvLDcCBZc1qfGbnZC89AVuAu66DPRMvEq3h/MA2
         jYl2WgNjlbsvl3HORtAheRqQ010x8sl8+voHfJVR31/t1DR10++blk80R9A0upPYn/OC
         1pvui3X6dxu+kAIW6N2jAEur8mdbyP+dBudsgJ/JF24f38KPSPayJacIrBPubIyBrmQI
         fc2arRbtbNtqjgVqQhkUTgRjJuOX+IuvWhzOtiDWr3YmnYI3Y7DegE2z8TAnThY4OxD3
         7tZJOCqG7g0wjT0lvWOA34eCHXUj3VTINSwqJqBMElLEnoAN7X83/5b9YEYB4paUzWrK
         lrxg==
X-Gm-Message-State: AO0yUKUka8g3P3SKEZ2Vcv9IrCG/w4J+8cedT0pCEXScIHY2E5cPhHJN
        eiQfy2o4E7PRN2CsJcSEISSD0nndHJs=
X-Google-Smtp-Source: AK7set+rGfBLO3JGXPqizthSr8YueecJtUgumHo2sxy+vkBSaeEyLIFMVpXZWR1EEljgar357+WLng==
X-Received: by 2002:a17:906:3481:b0:868:b2b6:ee71 with SMTP id g1-20020a170906348100b00868b2b6ee71mr6963670ejb.6.1675852285105;
        Wed, 08 Feb 2023 02:31:25 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ac5-20020a170907344500b0088f92a2639fsm7883875ejc.17.2023.02.08.02.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:31:24 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:31:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: tegra-bpmp: Handle offline zones
Message-ID: <Y+N5+w8ePTVaZiIB@orome>
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HjTx0z3dHhZfFGiY"
Content-Disposition: inline
In-Reply-To: <20230207135610.3100865-1-cyndis@kapsi.fi>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HjTx0z3dHhZfFGiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 03:56:08PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Thermal zones located in power domains may not be accessible when
> the domain is powergated. In this situation, reading the temperature
> will return -BPMP_EFAULT and the temperature is considered to be
> -256C for calculating trips.

Where's that -256C being set? I only see THERMAL_TEMP_INVALID being set
as the default for a zone, but that's not -274C, not -256C. If that's
the temperature that you're referring to, it might be better to state
that we rely on the default temperature rather than any specific number.

Thierry

>=20
> For smooth operation, for offline zones, return -EAGAIN when reading
> the temperature and allow registration of zones even if they are
> offline during probe.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal=
/tegra/tegra-bpmp-thermal.c
> index c76e1ea62c8a..628b18818ae9 100644
> --- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
> +++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
> @@ -52,6 +52,8 @@ static int __tegra_bpmp_thermal_get_temp(struct tegra_b=
pmp_thermal_zone *zone,
>  	err =3D tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>  	if (err)
>  		return err;
> +	if (msg.rx.ret =3D=3D -BPMP_EFAULT)
> +		return -EAGAIN;
>  	if (msg.rx.ret)
>  		return -EINVAL;
> =20
> @@ -257,7 +259,12 @@ static int tegra_bpmp_thermal_probe(struct platform_=
device *pdev)
>  		zone->tegra =3D tegra;
> =20
>  		err =3D __tegra_bpmp_thermal_get_temp(zone, &temp);
> -		if (err < 0) {
> +
> +		/*
> +		 * Sensors in powergated domains may temporarily fail to be read
> +		 * (-EAGAIN), but will become accessible when the domain is powered on.
> +		 */
> +		if (err < 0 && err !=3D -EAGAIN) {
>  			devm_kfree(&pdev->dev, zone);
>  			continue;
>  		}
> --=20
> 2.39.0
>=20

--HjTx0z3dHhZfFGiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjefoACgkQ3SOs138+
s6HNvQ/8CxmmhYs401NGlAnZEwhKPe+pbajzCVbMB4cJB6yXLKRFrH9awIiSuCDR
pyYB0Fjk3MEuFazoquATiCt+O2biYJBOqiscEo8DxhNVzY37i9WxvBky6uV1bU1o
s95qpwPQJJHDJMb76qThUUJkl/5KBnYW2rBaVjSONddLykNkIuQ9bGhVVNDQcIWl
BuCtJEbA8IbWIvhhmKP49pdrOPjP3DMH2DNTeH4sEqdk6EjCYjpbaKCqDiGqU4gC
25S52UW8R0JrSkCRHpWP/68MG8TLlwOn373ZWQyVFj+WRHbIb462NaCgv7zNkEGl
3HMJlAIvTx5sEV9vrjDd6GYqwkXkJtFYq60PzL6BIVS73q8OGWEm2t8sQuZIpL+Y
WOCIQ4gg3yoUyLmy26lSMakP3csNq8zF5wgOo0MPA48KtK8fkm1uLhHzPdIt7dpT
XKVD/v0tS6vIY+5xsAho62jTYNGUSue7Y9wlxIv+XxUwEjFcAZuQ8o1MkdqoBXS4
Wu7tH6Bc8BAf9J0o3eiJvyU+/LZMD92amTKJy6GiTFmMrREhhg54l6ZBDizS6yIv
35+9I7dvLaWx87bdZM3aboUBsD6FH2cqQCrFHXeoJBQUk0yUJJDIKwAm3bCH/hvE
7aNXXzMpCu30hR4UQg6URX0x4YxfboYti5+TIJB2n4o1Yx/Nh4g=
=/bmI
-----END PGP SIGNATURE-----

--HjTx0z3dHhZfFGiY--
