Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055B06D7C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjDEMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjDEMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:14:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A083C22;
        Wed,  5 Apr 2023 05:14:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso23600300wms.1;
        Wed, 05 Apr 2023 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680696840;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdZN+OaYBGqujKD5R9k9qcJDjZo3DT83mr53rt5m3DA=;
        b=IXHlf5a/wfSJlitOn1KM3JLDauYy0wQSWASL2GLbxwUuQiavL2Q9iee5HL5CZTcYt6
         NClCJflpdI6egXtbSMZ6I5QzqEGndAaUEooH7TqqqDWUlZGsLx8PrAKGlp2jOQCqQHS3
         NMiZNfnREhxeQwfVBEs2kadqkLTb/uG1cO7mP1c55sDi0bFDPlq61iUyq78NDpUXkoci
         rw45ZUP9bI3AIC37ctPKxiBEANSCIuVgUUBxqcHwvN/fsBaxu368zbjpbs4WTYxQEjoz
         2h8ZyuSYbln99xlQTE12YdAoOBGp+CfidihVJyOb4W6ax6179hAtmOTffOIi9wE4CGlv
         +mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696840;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdZN+OaYBGqujKD5R9k9qcJDjZo3DT83mr53rt5m3DA=;
        b=yP2yOUhBmmcZ8MHwho58IqtDZ0c7ye0K5UUYZLlppMl/ox7p/iq6k+AwV4aCmKEhQg
         g0gw77XMXqeWPSJRwOotAiBLMDZkW64MgjXy4XVS7BitOwmjQZqIV0iBljNFltZ7RCYM
         xwOk397D5RR1/cxALPoqp/6emaR1dKmAL5tIEbGIvMI4QptJQhozvEAqGqTlN/Mpsnty
         RSUP7c8myqOpH5Hyvpb29FUHhT0/ktigJt4+E2O/Uoh0fpIpODIwmhsFcA4R/o+gnOuv
         acpBCwREZ8UVfuZtWXvKEMovnCpKaYVhxLBzr8V8Si6lRDyeGSSXzKzwvRklMWdoW5Q/
         VmbA==
X-Gm-Message-State: AAQBX9cd8PmJVxykvCIgeJY8T7Pgzwf84ZkNj57KJAAnYyn3EecZjrlk
        o3f+MdMmAUU0UU2Ad99DojM=
X-Google-Smtp-Source: AKy350bY2g9mxsmYFguHsT6G8kdF2sj8uXpLbF8EPfagq8E7dEGJjz6Z0YgazY89BbcpGtBx5TXEZA==
X-Received: by 2002:a05:600c:b4f:b0:3ed:d64f:ec30 with SMTP id k15-20020a05600c0b4f00b003edd64fec30mr4366586wmr.33.1680696839878;
        Wed, 05 Apr 2023 05:13:59 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y9-20020a1c4b09000000b003edf2dc7ca3sm2011444wma.34.2023.04.05.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:13:59 -0700 (PDT)
Date:   Wed, 5 Apr 2023 14:13:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] thermal/drivers/tegra: remove redundant msg in
 tegra_tsensor_register_channel()
Message-ID: <ZC1mBUMF3MWmNqY5@orome>
References: <20230318144412.75046-1-frank.li@vivo.com>
 <20230318144412.75046-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gjylHNenLSUt247p"
Content-Disposition: inline
In-Reply-To: <20230318144412.75046-6-frank.li@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjylHNenLSUt247p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2023 at 10:44:09PM +0800, Yangtao Li wrote:
> The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
> print error information.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/te=
gra/tegra30-tsensor.c
> index cb584a5735ed..c243e9d76d3c 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -523,8 +523,7 @@ static int tegra_tsensor_register_channel(struct tegr=
a_tsensor *ts,
>  		return 0;
>  	}
> =20
> -	if (devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd))
> -		dev_warn(ts->dev, "failed to add hwmon sysfs attributes\n");
> +	devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd);

I don't see any error messages output by devm_thermal_add_hwmon_sysfs()
nor any of the functions that it calls. Did I miss something?

Thierry

--gjylHNenLSUt247p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQtZgUACgkQ3SOs138+
s6GpURAAk+YDurZ447gp7uDTxfOaYD/WaSUnwC9TvOJ2fpt9y+YhH2otMIF8WAPM
lqfAnEYnCHORqpww0ARzYmoVtQ9m4QlaFSRzV7Wefu0q0EZvd2ao2Diw3h9Z2zaH
kqbwDxQVceIidxpdbodxpe3OuiZyPDc4D9mE7xCdg7ze+7mE+Ysht2eTks6LTJIr
GEB0Cso93K6QBcVYYHO3NAdMXQI9c79z5l4uovKBNLFM2Mqapy/JIVzo6zVEIBPM
fq7g2kaF54WlNBYRF73mM6x7dxJD4KQUK2Y0Va1OSE2zhvxiWnGg4EizY+VPKwys
9JKYv1/fDUj0oNzmBPO2kwBscNTfLKJJF6XBLDXPHaguO9CDWDEomFsXIenuAicB
hkQuOTwo9K6FTggivUZvZQiRn3HMFJf34Yv2E4LSZ/u6AjfrfT66/FEKlDKZFvON
WM0RK3OXHJm3Fo6pv1nE3mZz1+YMC9wVO0ZI9fFv7XW00WUVh5PFBdYDd+dWc8Y7
AAfZ3Q0RG/sIKfTCHXnOoHpRZfR52aHqV1taiK2wvV1+nD79S4SwAgTWbUJ+acbN
ClSTpbO4GlIvliyJnlt60ObPTNB6vOuI5M6nLNsNx6mUEo2K1JA/BkBU38G62isz
FldRzpXNAXQZ/YR5NUA2ybN1h3KmJvcgydL3Yc7Ml/HkXr2IXjw=
=uiiy
-----END PGP SIGNATURE-----

--gjylHNenLSUt247p--
