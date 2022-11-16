Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849A62BFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKPNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiKPNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:42:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196624385E;
        Wed, 16 Nov 2022 05:42:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 24E5649C;
        Wed, 16 Nov 2022 14:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668606121;
        bh=ly9CkcS/E6lEtVCZSc//19c85px1pIbhycLP/DAh1Cw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lEFmnNRZreTfZ1Wat9uytAN4TR+xMZC/JVaIbPKtEvSGqBRy/IhoWFRtzZ7mXkIa/
         HB1SorTuNEvROnYNcS7LTtV5FZD4dsHgjctEbqWuzA4FrKl1fAg3+q0YK1FtfUxILc
         SZND94ydG+7VJuIGW9NulFOzO2SBMknNiJHxA0I8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221107175256.360839-9-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net> <20221107175256.360839-1-paul@crapouillou.net> <20221107175256.360839-9-paul@crapouillou.net>
Subject: Re: [PATCH 19/26] drm: shmobile: Remove #ifdef guards for PM related functions
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
Date:   Wed, 16 Nov 2022 13:41:58 +0000
Message-ID: <166860611898.50677.15769438490654163273@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2022-11-07 17:52:49)
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

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/s=
hmobile/shmob_drm_drv.c
> index 3d511fa38913..337040fa6438 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -143,7 +143,6 @@ static const struct drm_driver shmob_drm_driver =3D {
>   * Power management
>   */
> =20
> -#ifdef CONFIG_PM_SLEEP
>  static int shmob_drm_pm_suspend(struct device *dev)
>  {
>         struct shmob_drm_device *sdev =3D dev_get_drvdata(dev);
> @@ -165,11 +164,9 @@ static int shmob_drm_pm_resume(struct device *dev)
>         drm_kms_helper_poll_enable(sdev->ddev);
>         return 0;
>  }
> -#endif
> =20
> -static const struct dev_pm_ops shmob_drm_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(shmob_drm_pm_suspend, shmob_drm_pm_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(shmob_drm_pm_ops,
> +                               shmob_drm_pm_suspend, shmob_drm_pm_resume=
);
> =20
>  /* ---------------------------------------------------------------------=
--------
>   * Platform driver
> @@ -292,7 +289,7 @@ static struct platform_driver shmob_drm_platform_driv=
er =3D {
>         .remove         =3D shmob_drm_remove,
>         .driver         =3D {
>                 .name   =3D "shmob-drm",
> -               .pm     =3D &shmob_drm_pm_ops,
> +               .pm     =3D pm_sleep_ptr(&shmob_drm_pm_ops),
>         },
>  };
> =20
> --=20
> 2.35.1
>
