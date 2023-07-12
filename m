Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B123E7501F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGLIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGLIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:46:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1B94;
        Wed, 12 Jul 2023 01:46:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69E2F1BF205;
        Wed, 12 Jul 2023 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689151615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aibOqbCHqtQ94rqSgA1NeKBgTC97ZqqxHBicTgNuv6A=;
        b=UUueM1MlhMbkJR87nN22cscz6BjMaeuTtQFICC2Q+v2VeISpIjF8ivjCngL2bZ0D7pY4zt
        0xrJjVZI33zMvveQtlKndfcHg2hBps1mDBy2C/WdE+RnDfZ9DzVqvfZX4+pp/63V9ybl43
        WlBBVSJ7QgTZztNbJVvQWu4FW4pBEZWeA9wg6/CswSZwmo3mJWXxdnZSwL+YbgtAmCi5zx
        wvaVaieooJEAtsh559on7i1jPAFrgahRlfjsrdltJOUT3c3HppqBtiI0CgHIoXUVds32zS
        KvNEijzloMHe2y8ffIr1rVlE1Mpa9rJRYo+ynS8VM4TkHdaBSkHSzpQqFuwVVA==
Date:   Wed, 12 Jul 2023 10:46:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] thermal/drivers/armada: Convert to platform
 remove callback returning void
Message-ID: <20230712104649.3d843fb3@xps-13>
In-Reply-To: <20230712081258.29254-2-frank.li@vivo.com>
References: <20230712081258.29254-1-frank.li@vivo.com>
        <20230712081258.29254-2-frank.li@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

frank.li@vivo.com wrote on Wed, 12 Jul 2023 16:12:33 +0800:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/thermal/armada_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index 9f6dc4fc9112..94783e374d37 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -964,19 +964,17 @@ static int armada_thermal_probe(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> -static int armada_thermal_exit(struct platform_device *pdev)
> +static void armada_thermal_exit(struct platform_device *pdev)
>  {
>  	struct armada_drvdata *drvdata =3D platform_get_drvdata(pdev);
> =20
>  	if (drvdata->type =3D=3D LEGACY)
>  		thermal_zone_device_unregister(drvdata->data.tz);
> -
> -	return 0;
>  }
> =20
>  static struct platform_driver armada_thermal_driver =3D {
>  	.probe =3D armada_thermal_probe,
> -	.remove =3D armada_thermal_exit,
> +	.remove_new =3D armada_thermal_exit,
>  	.driver =3D {
>  		.name =3D "armada_thermal",
>  		.of_match_table =3D armada_thermal_id_table,


Thanks,
Miqu=C3=A8l
