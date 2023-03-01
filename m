Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1F6A6E72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCAOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCAOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:30:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895E2749F;
        Wed,  1 Mar 2023 06:29:59 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o15so52044790edr.13;
        Wed, 01 Mar 2023 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677680998;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9o3hZPNMcnjEvQLT7zvsQFze9KI4ZbCYG+IKIaPiIE=;
        b=T9KR8mFVX6XTKWhELNUOcVDwEhNcTuopZrKL6DQowLA+CCj9yQRNlbRT6jtPk2+BPl
         Rf9/8yGd+NCyKeuLoub2st3aoVT5d4Cr1vR0w/RAIT64bzUhtqRDK46P5fwrJzYmI/EE
         ZGJMOmpb/EIBoqZC3s84c2yd6J7mYJrt3DXMvMbAoas5m8/aCcKxpoMrhW4SqqSckcOG
         5UjQ8SlWSGdcC576bJ+iFWBh7ekoqBXmCf2I3pTL+9mQG+2O05P5T+huBl4G5x4dsuIu
         BZ+AtLg8D0zl7CgQFTp+rP5eQzOuymSJn+L47JQLvnD+4gvvN5zwhN+N6JVFLmE4l0Mr
         rsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677680998;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9o3hZPNMcnjEvQLT7zvsQFze9KI4ZbCYG+IKIaPiIE=;
        b=f38eIJEev8VWAmedX4LcZypByZH5glKutFZWkom4bxHViBKCOHhW0hrHfaoSlKNBZ1
         zFh8Ut5TBjA4gB8nLIGyUrvqRY8xONUmxRPCRF40j3+8Uoi+g40bxRHmdufWgJmz2Rae
         EwhR355KRH7AKnaCbvhZTI6574l3+oPl06QgdUEB2xFDyeZBYhZg/RR5WKTZrkvsGrSr
         Wmkstdy+Vko5wUAmtnWcVl1B2HnMQJcd/NCztLrO5+Hb92lFxbVTHMpYQtgLB0ejRv5f
         Xn5+RgGXFdyB8UCPOVatKUn6lFllUXHKK7pCWHerGSkK+wttyhmbNSyeXljE8cEAAx2Z
         smPw==
X-Gm-Message-State: AO0yUKWdTexcm0sV+txQUWRLiztBB9DNjtupMaDO581lBygcpaTB36Tb
        pq7W0arQFJBtkZLSDAIeKNk=
X-Google-Smtp-Source: AK7set+ElzJI8KqoA/dC6iK8uCH+TnYojLj/OdNRp7S4oGjx+qlBK3/CSfmi8aRw610hGp2Wmu603Q==
X-Received: by 2002:a17:907:767a:b0:8b2:e92:41e1 with SMTP id kk26-20020a170907767a00b008b20e9241e1mr6896091ejc.9.1677680998402;
        Wed, 01 Mar 2023 06:29:58 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gx18-20020a170906f1d200b008d2d2d617ccsm6009215ejb.17.2023.03.01.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:29:57 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:29:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 17/19] thermal/tegra: Do not enable the thermal zone,
 it is already enabled
Message-ID: <Y/9hZFfRWLNHMbxe@orome>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-18-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/FgaCS/nnqqQf+a"
Content-Disposition: inline
In-Reply-To: <20230228112238.2312273-18-daniel.lezcano@linaro.org>
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


--2/FgaCS/nnqqQf+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 12:22:36PM +0100, Daniel Lezcano wrote:
> The code enables the thermal zone after setting it up. But the thermal
> zone is already enabled by thermal_of_zone_register() function.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/tegra/tegra30-tsensor.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/te=
gra/tegra30-tsensor.c
> index 3506c3f3c474..e38902abf207 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -346,7 +346,7 @@ static int tegra_tsensor_enable_hw_channel(const stru=
ct tegra_tsensor *ts,
>  {
>  	const struct tegra_tsensor_channel *tsc =3D &ts->ch[id];
>  	struct thermal_zone_device *tzd =3D tsc->tzd;
> -	int err, hot_trip =3D 0, crit_trip =3D 0;
> +	int hot_trip =3D 0, crit_trip =3D 0;
>  	u32 val;
> =20
>  	if (!tzd) {
> @@ -401,12 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const str=
uct tegra_tsensor *ts,
>  	val |=3D FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
>  	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
> =20
> -	err =3D thermal_zone_device_enable(tzd);
> -	if (err) {
> -		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
> -		return err;
> -	}
> -
>  	return 0;
>  }

This function is called in tegra_tsensor_resume() and balances out the
tegra_tsensor_hw_channel() calls from tegra_tsensor_suspend(). If we
remove the call from here, we'll likely end up with the zones disabled
after a resume.

This ends up calling thermal_zone_device_set_mode(), which is a no-op,
basically, if the mode is unchanged, so this seems harmless.

If you need this to change anyway, I suppose we could move the calls to
thermal_zone_device_enable() and move them into suspend/resume instead.
That's a bit tricky to undo in the error recovery paths, but should be
doable.

Thierry

--2/FgaCS/nnqqQf+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/YWIACgkQ3SOs138+
s6EjvQ//TG4Y9PWRAFjYc4KItj+lcgjVK3rv1bnPSkolJ7aAHkSc9mnkrz8NP+le
adXN4EJ0xdcouPOslRQdaGFnAhr8+e8TK1LtJa/ReUuY4ZAP7PQzK+b4Y4SYlegd
GK7Ei9Oe6OFS3vhoK96DuZJyiBAZA2dDTUSaW+N6tlMl4wBrbIxupb2FI7X1w+Vu
vXFbIoqSGi7pR7vsYerMjGA9nuGe36Kgq2dmGs5pax6C/oYMo1s5+hcllxFsIjb4
+FbGrnNNBXYqN/erAnAmPm5LzqxBOgf1RJEOyXf1xuFo+HdEaIretcq6pF3PiPiy
SAcE6RRaA6dCZVkgNxd6qVgDohdrulcP4JqY7cIECnWFY6X1z1AChT6X6UJ0dHah
VcoJvzEHFTQ3UuqXttflNh/lMHxwGkiEi86Tk5NtfjerJMwwcmUVWfkQUZTC+UhS
dABwWSKc0c+aKgt4O6y9YbqjU9dZ9y7ko9kgr+Yv5SM8oLGdavAT+0+3jmfWvPTT
BY+L589PebEwpexP31d6LUDxr9Ifha/gvu4MXbIh93eCLt2DX73hlVuRiof4DFt3
V2atdEQ4ygf2GKGIfvLCOWmak4S3T4sXBpX0Bp+1Y3Dza7mulJaBj/GxJx6rYxBF
xdLPxBwbxiO+egs3nKioP+4LgrsGB6m+MXFvwe2swwbWMjklfSc=
=Ggnj
-----END PGP SIGNATURE-----

--2/FgaCS/nnqqQf+a--
