Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752568A134
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjBCSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBCSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:09:02 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B771F4B6;
        Fri,  3 Feb 2023 10:08:59 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED5DDFF804;
        Fri,  3 Feb 2023 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675447737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3mfgEsqRwW7r5t8xzQ+IZQ4s+ZYtKBLc2gjze21Uu0=;
        b=fxUnC136FHpOrCjYLohtdOEosv7uWKS0rvVgty01f2OjrGwPuidis02eKeNDwx+m2Te6iZ
        /nD4RyF+zqA0H1WiLlmZ8xlPgRsb5lc4aVFHUoZpt93V/sCTP9y/QdDFo0r4eAwg5G3E35
        KmuNKT9XzmYMXM98gDvaWwXFgTAEcaA3OtvXkHYUvU+Xpm43TOHiAWTQxxZ3Kj72DQ0dhm
        OFEgcuJ2msuF2rCVmBworWGh7lx4YMaDSQ56oV2V0LN5rFupfh1e+YnVboAhBhYzn51B51
        G2OswAl8MmekCdR2friE1YpgPjJxpyf6ay8SvTn9lov5UHd3XHaAYuvs/2xL6g==
Date:   Fri, 3 Feb 2023 19:08:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
Message-ID: <20230203190852.12396f8a@xps-13>
In-Reply-To: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel.lezcano@linaro.org wrote on Fri,  3 Feb 2023 18:58:31 +0100:

> Some drivers are declaring a thermal zone without any thermal trip
> points.
>=20
> On the other side, we are introducing the function
> thermal_zone_device_register_with_trips() which provides an array of
> generic thermal trip points. When all the drivers will be converted to
> the generic trip points, keeping two functions will be useless.
>=20
> Most of the drivers are now using
> thermal_zone_device_register_with_trips() with the generic trip
> points. As soon as the remaining drivers are merged, the
> thermal_zone_device_register_with_trips() will be renamed to
> thermal_zone_device_register().
>=20
> Obviously this renaming can only happen if there are no more user of
> the thermal_zone_device_register() function.
>=20
> This change uses thermal_zone_device_register_with_trips() with a NULL
> parameter for the trip point array instead of
> thermal_zone_device_register().
>=20
> No functional change intended.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/power/supply/power_supply_core.c                | 2 +-
>  drivers/thermal/armada_thermal.c                        | 4 ++--
>  drivers/thermal/dove_thermal.c                          | 4 ++--
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 6 +++---
>  drivers/thermal/kirkwood_thermal.c                      | 4 ++--
>  drivers/thermal/spear_thermal.c                         | 5 +++--
>  6 files changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 7c790c41e2fe..208a849a71d9 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1166,7 +1166,7 @@ static int psy_register_thermal(struct power_supply=
 *psy)
> =20
>  	/* Register battery zone device psy reports temperature */
>  	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> -		psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> +		psy->tzd =3D thermal_zone_device_register_with_trips(psy->desc->name, =
NULL,
>  				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
>  		if (IS_ERR(psy->tzd))
>  			return PTR_ERR(psy->tzd);
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index 99e86484a55c..83a4080bffc7 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -856,8 +856,8 @@ static int armada_thermal_probe(struct platform_devic=
e *pdev)
>  		/* Wait the sensors to be valid */
>  		armada_wait_sensor_validity(priv);
> =20
> -		tz =3D thermal_zone_device_register(priv->zone_name, 0, 0, priv,
> -						  &legacy_ops, NULL, 0, 0);
> +		tz =3D thermal_zone_device_register_with_trips(priv->zone_name, NULL, =
0, 0, priv,
> +							     &legacy_ops, NULL, 0, 0);
>  		if (IS_ERR(tz)) {
>  			dev_err(&pdev->dev,
>  				"Failed to register thermal zone device\n");

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
