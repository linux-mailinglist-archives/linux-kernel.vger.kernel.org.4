Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595226A6E42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCAOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCAOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25213346D;
        Wed,  1 Mar 2023 06:18:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d30so54425489eda.4;
        Wed, 01 Mar 2023 06:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677680293;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWzCrA1KWuD286SrbwwIFwklmVl9dNUWwjdidpvypk=;
        b=o+KGLZ9YXvF0VPzo66uI1UCU9uqh0rHczVTjbvXESHldGtXVlr0jCE8WuyCREbNVPZ
         tGauEn9RXqlZhCRcADaJmSuwclV3EHcgECcy+7yVPcvoxSwFxCLlGBdmX74YYse4/43t
         TFzapW2TqvX2AQbt4xMEchoig3r/GLaLIZHswMQRYyOvJ2fxUBrGA++vXwUqfi+Dk57U
         c4YtV1Okw0m7coiaY1fmPYlQymlFG8E/52gGcSGXfFn2z8B3cURPyFCtOJbqW2VdaFsu
         rFwpSbcaIJ2eNgecPBiiTNxe+/615igx1M2zE2R0I514CwvpA55ZY9/gxey66jm4sLAY
         Y2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677680293;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWzCrA1KWuD286SrbwwIFwklmVl9dNUWwjdidpvypk=;
        b=yiPzEqOj+i9earAFzIWqsPAoAbuuELCl2SCkrMxd69ozsiziATeho0JrCWhRmP1IeL
         JD1hGH4wnrJqocRdBIc2IGzNxf2FMYyzcWs4VevGgCAumUmUeZMluRavUzPsTTw/OzfS
         pxhuENbddQRmc04GtKJd/rbEIb6ABZoi6GOAqO19B1dtH6B1NDASeksWvnPOqz+A2swk
         zQf4xwydBvB6atJfNOgq2goZrpGWkQBHzbNk7OadzK/E2sJ/OiNOHyq6pVfZR510tCNt
         aOBXJHjseua7ZmYVV3z3f0E2oFs+4eoq1SZknAlycF3WBIZyWWCxdsi5DDvWdLUbQSXx
         4q8g==
X-Gm-Message-State: AO0yUKX1sGQQxXPs7R6ICInVC9cg8JZTjUzBh+0jXfni+np0ahnaZy0N
        oRt0V4IfY/6BdqAMl8kSvFI=
X-Google-Smtp-Source: AK7set/b5p8SvU9l81mJVbZCXeCoIqUxIPYWnJffshQ/3CzydN3SxRK0ruoaZBK1MGTbI39x/luxAA==
X-Received: by 2002:a05:6402:189:b0:4a0:e31a:434 with SMTP id r9-20020a056402018900b004a0e31a0434mr6244835edv.27.1677680292893;
        Wed, 01 Mar 2023 06:18:12 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906655400b008f2b0c6052csm5791286ejn.89.2023.03.01.06.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:18:12 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:18:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 16/19] thermal/drivers/tegra: Remove unneeded lock
 when setting a trip point
Message-ID: <Y/9eohV9h26hPuFn@orome>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-17-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Oz2Iy2f0YGfChAS0"
Content-Disposition: inline
In-Reply-To: <20230228112238.2312273-17-daniel.lezcano@linaro.org>
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


--Oz2Iy2f0YGfChAS0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 12:22:35PM +0100, Daniel Lezcano wrote:
> The function tegra_tsensor_enable_hw_channel() takes the thermal zone
> lock to prevent "a potential" race with a call to set_trips()
> callback.
>=20
> The driver must not play with the thermal framework core code
> internals.
>=20
> The tegra_tsensor_enable_hw_channel() is called by:
>=20
>  - the suspend / resume callbacks
>  - the probe function after the thermal zones are registered
>=20
> The thermal zone lock taken in this function is supposed to protect
> from a call to the set_trips() callback which writes in the same
> register.
>=20
> The potential race is when suspend / resume are called at the same
> time as set_trips. This one is called only in
> thermal_zone_device_update().
>=20
>  - At suspend time, the 'in_suspend' is set, thus the
>    thermal_zone_device_update() bails out immediately and set_trips is
>    not called during this moment.
>=20
>  - At resume time, the thermal zone is updated at PM_POST_SUSPEND,
>    thus the driver has already set the TH2 temperature.
>=20
>  - At probe time, we register the thermal zone and then we set the
>    TH2. The only scenario I can see so far is the interrupt fires, the
>    thermal_zone_update() is called exactly at the moment
>    tegra_tsensor_enable_hw_channel() a few lines after registering it.
>=20
> Disable the interrupt before setting up the hw channels and then
> enable it. We close the potential race window without using the
> thermal zone's lock.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/te=
gra/tegra30-tsensor.c
> index 4b2ea17910cd..3506c3f3c474 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -359,9 +359,6 @@ static int tegra_tsensor_enable_hw_channel(const stru=
ct tegra_tsensor *ts,
> =20
>  	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
> =20
> -	/* prevent potential racing with tegra_tsensor_set_trips() */
> -	mutex_lock(&tzd->lock);
> -
>  	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %dC\n",
>  		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
> =20
> @@ -404,8 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const stru=
ct tegra_tsensor *ts,
>  	val |=3D FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
>  	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
> =20
> -	mutex_unlock(&tzd->lock);
> -
>  	err =3D thermal_zone_device_enable(tzd);
>  	if (err) {
>  		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
> @@ -592,12 +587,24 @@ static int tegra_tsensor_probe(struct platform_devi=
ce *pdev)
>  		return dev_err_probe(&pdev->dev, err,
>  				     "failed to request interrupt\n");
> =20
> +	/*
> +	 * Disable the interrupt so set_trips() can not be called
> +	 * while we are setting up the register
> +	 * TSENSOR_SENSOR0_CONFIG1. With this we close a potential
> +	 * race window where we are setting up the TH2 and the
> +	 * temperature hits TH1 resulting to an update of the
> +	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
> +	 */
> +	disable_irq(irq);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(ts->ch); i++) {
>  		err =3D tegra_tsensor_enable_hw_channel(ts, i);
>  		if (err)
>  			return err;
>  	}
> =20
> +	enable_irq(irq);

Instead of disabling and reenabling the interrupt, could we simply move
the channel enabling code a couple of lines above, before the IRQ
request call? If enabling the channels were to trigger an interrupt, it
should get triggered right after requesting the IRQ.

Thierry

--Oz2Iy2f0YGfChAS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/XqIACgkQ3SOs138+
s6EHzg/+LaKObM7XgPPaPoY5q+ysmHSQcIRHMxssUaekCxLbpDECR24adyRLcaJG
65KIHqtorgjPRYW2z6jIpC3xUjCokMZhbkwL5tbaoywsbm5xiajiJXiHIXc8kWQX
Hm6DJZi0J4V0aqsk1c1IAKFAjSdiN3NY3qky+2/SQSQqmveD4Ojkd/3fdUL1NkuD
txRaKkNQYshjQxqhP5I5U5Di33YRS3J1OtJDBR+Nk49mNVTH11MyOmqoYmRCBu7N
YwOSUB5gu0XlzxRz2awyb2/y6B+dQ5WudhTUD1DFIi0tUD1WlilyCwDhdrBITyUJ
b27iHxBuWq2D2gIEh8TNydbK5kH2NDhFWhXqVJnpdFe8O4C2DSM24B8Px/J6+f0K
kTTxBRDjT2+6IVRpYLGnzWx1PPYQ6bhj7txzvHL717ZPrOJPb1CjilhLtFIYe/PU
5/XHZoHIr9tPpZYVz9WMlFpMVKj7PmKnNygh/4jWH+n4sj3PpiWv4N7OBVJ4D6e2
LNxxxDTraEK1QGwANEs6abt5MFrtwb27qrhxA5b4Kexosx/hh4pKSU3XSsYZW++d
QGm3B2qqXdkM3YIgdH+8BLDsa/P7rcIvJt7A2Tc1r6G65oOhCiwcFml50exlXv18
VES1C9HrS75Y/j8UBgW6km1xlM4nMfaMIurUNcuOVkRp91JbIyQ=
=W4bx
-----END PGP SIGNATURE-----

--Oz2Iy2f0YGfChAS0--
