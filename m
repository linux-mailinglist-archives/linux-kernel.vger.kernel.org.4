Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0B62BFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiKPNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiKPNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:41:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4EB1E3FC;
        Wed, 16 Nov 2022 05:41:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF5B049C;
        Wed, 16 Nov 2022 14:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668606074;
        bh=7kjV9XaHGlcIvSJMo1l48yxddcL5QyvUynUQIQE/utQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PiSQRbxCpnhfvhLOvIlPUw+8d+v/T/vnY2kITjyVbbBRPRnaI26+x6KjSeEJAkFiE
         R/4WIZXhHw0F1vbQABp1Wn2bdozEEwXuxGS45peSlO4RxQUTFRRahTtr9S6UAmjYat
         S/H9lzSD7Uf3qXQDbCCMFxxR29ESVlnrcRDsinKk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221107175256.360839-7-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net> <20221107175256.360839-1-paul@crapouillou.net> <20221107175256.360839-7-paul@crapouillou.net>
Subject: Re: [PATCH 17/26] drm: rcar-du: Remove #ifdef guards for PM related functions
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed, 16 Nov 2022 13:41:12 +0000
Message-ID: <166860607235.50677.11372324946195607108@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2022-11-07 17:52:47)
> Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to handle
> the .suspend/.resume callbacks.
>=20
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
>=20
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Seems reasonable to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar=
-du/rcar_du_drv.c
> index a2776f1d6f2c..0a89094461cc 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -599,7 +599,6 @@ static const struct drm_driver rcar_du_driver =3D {
>   * Power management
>   */
> =20
> -#ifdef CONFIG_PM_SLEEP
>  static int rcar_du_pm_suspend(struct device *dev)
>  {
>         struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
> @@ -613,11 +612,9 @@ static int rcar_du_pm_resume(struct device *dev)
> =20
>         return drm_mode_config_helper_resume(&rcdu->ddev);
>  }
> -#endif
> =20
> -static const struct dev_pm_ops rcar_du_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(rcar_du_pm_suspend, rcar_du_pm_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(rcar_du_pm_ops,
> +                               rcar_du_pm_suspend, rcar_du_pm_resume);
> =20
>  /* ---------------------------------------------------------------------=
--------
>   * Platform driver
> @@ -712,7 +709,7 @@ static struct platform_driver rcar_du_platform_driver=
 =3D {
>         .shutdown       =3D rcar_du_shutdown,
>         .driver         =3D {
>                 .name   =3D "rcar-du",
> -               .pm     =3D &rcar_du_pm_ops,
> +               .pm     =3D pm_sleep_ptr(&rcar_du_pm_ops),
>                 .of_match_table =3D rcar_du_of_table,
>         },
>  };
> --=20
> 2.35.1
>
