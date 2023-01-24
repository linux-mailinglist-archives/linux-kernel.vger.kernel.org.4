Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66FE679621
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjAXLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAXLFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:05:03 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1016325;
        Tue, 24 Jan 2023 03:05:01 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7D9314000F;
        Tue, 24 Jan 2023 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674558300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5b17gTu1Sy9bBEbtdI72ad6ZsLU6SuiKe4CSVzX2go=;
        b=ERSrbbZrVaakWmVNJXSJzVKng+PG139vcB9TrESG1ssY2GoES/aFd/6/IB0wyFBPj/E270
        U3vaOMKJFMrp99TGelOQp/7SSR0NrpA+XHMrB/u7mvN+JBs4TIQozveXOaeXKg3PD938lb
        DtQoh06uHUy/XwIWvTNfikyZvYhycGOFB0E4oM3VMGO4s5yoydbxPuxoyi+m3moPBB/1/O
        kp4Yr3k1ZyeGpNmU+jArHUSs5A7/jdHN6trpXfUr+8J5nYzCXCf0aNczWOs/n7yDAM6kT4
        fWnx7WFsnEqu/1Ca4q6eu18nX/YmmhRvabIwWRtfIhw/MtuLnBnfurSqhCwlFg==
Date:   Tue, 24 Jan 2023 12:04:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] thermal/drivers/armada: Use the
 thermal_zone_get_crit_temp()
Message-ID: <20230124120458.412fc528@xps-13>
In-Reply-To: <20230118222610.186088-1-daniel.lezcano@linaro.org>
References: <20230118222610.186088-1-daniel.lezcano@linaro.org>
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

daniel.lezcano@linaro.org wrote on Wed, 18 Jan 2023 23:26:10 +0100:

> The driver browses the trip point to find out the critical trip
> temperature. However the function thermal_zone_get_crit_temp() does
> already that, so the routine is pointless in the driver.
>=20
> Use thermal_zone_get_crit_temp() instead of inspecting all the trip
> points.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/armada_thermal.c | 38 +++++++++++++-------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index db040dbdaa0a..c6d51d8acbf0 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -784,34 +784,26 @@ static int armada_configure_overheat_int(struct arm=
ada_thermal_priv *priv,
>  					 int sensor_id)
>  {
>  	/* Retrieve the critical trip point to enable the overheat interrupt */
> -	struct thermal_trip trip;
> +	int temperature;
>  	int ret;
> -	int i;
> -
> -	for (i =3D 0; i < thermal_zone_get_num_trips(tz); i++) {
> -
> -		ret =3D thermal_zone_get_trip(tz, i, &trip);
> -		if (ret)
> -			return ret;
> -
> -		if (trip.type !=3D THERMAL_TRIP_CRITICAL)
> -			continue;
> -
> -		ret =3D armada_select_channel(priv, sensor_id);
> -		if (ret)
> -			return ret;
> =20
> -		armada_set_overheat_thresholds(priv, trip.temperature,
> -					       trip.hysteresis);
> -		priv->overheat_sensor =3D tz;
> -		priv->interrupt_source =3D sensor_id;
> +	ret =3D thermal_zone_get_crit_temp(tz, &temperature);
> +	if (ret)
> +		return ret;
> =20
> -		armada_enable_overheat_interrupt(priv);
> +	ret =3D armada_select_channel(priv, sensor_id);
> +	if (ret)
> +		return ret;
> =20
> -		return 0;
> -	}
> +	/*
> +	 * A critical temperature does not have a hysteresis
> +	 */

Makes sense.

Nit: I would actually put that comment in the commit log rather than
keeping it in the code, but whatever, that's a nice simplification.

> +	armada_set_overheat_thresholds(priv, temperature, 0);
> +	priv->overheat_sensor =3D tz;
> +	priv->interrupt_source =3D sensor_id;
> +	armada_enable_overheat_interrupt(priv);
> =20
> -	return -EINVAL;
> +	return 0;
>  }
> =20
>  static int armada_thermal_probe(struct platform_device *pdev)

LGTM so,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
