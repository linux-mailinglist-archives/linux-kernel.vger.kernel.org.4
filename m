Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251026B03C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCHKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCHKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:11:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB425DBDB;
        Wed,  8 Mar 2023 02:11:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4499927C;
        Wed,  8 Mar 2023 11:11:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678270314;
        bh=W/+h4Lreayy3WufHVZSAr9X9Gvd5PYSCIAeLj2m/Scw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Xvwx8Agcwdxx+3ViuFKX1b8GsYDP4OoW43W15LFyoXQ6cCzb7RCZqBgBGGvpS1WeQ
         xlLamzdsBGCVEV1ugAMzyYoTjdErbt4cYxUlQBbQ2SANS+F6L7RNcldutSYSIKeFCv
         LWsP+S8uOAjQsIf9spZUpyMKf60xHU7vkFFsMY4A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230307163041.3815-3-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com> <20230307163041.3815-3-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 02/11] drm: rcar-du: remove R-Car H3 ES1.* workarounds
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 08 Mar 2023 10:11:51 +0000
Message-ID: <167827031185.93391.13063424473910902940@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Quoting Wolfram Sang (2023-03-07 16:30:30)
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Wow, this lets us get rid of workarounds all throughout.

This looks pretty decisive, and complete to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Please apply individually per subsystem. There are no dependencies and th=
e SoC
> doesn't boot anymore since v6.3-rc1.
>=20
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 37 ++------------------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 48 --------------------------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  2 --
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h |  3 +-
>  4 files changed, 4 insertions(+), 86 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rca=
r-du/rcar_du_crtc.c
> index 008e172ed43b..84411c452e30 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -223,20 +223,6 @@ static void rcar_du_crtc_set_display_timing(struct r=
car_du_crtc *rcrtc)
>                  * DU channels that have a display PLL can't use the inte=
rnal
>                  * system clock, and have no internal clock divider.
>                  */
> -
> -               /*
> -                * The H3 ES1.x exhibits dot clock duty cycle stability i=
ssues.
> -                * We can work around them by configuring the DPLL to twi=
ce the
> -                * desired frequency, coupled with a /2 post-divider. Res=
trict
> -                * the workaround to H3 ES1.x as ES2.0 and all other SoCs=
 have
> -                * no post-divider when a display PLL is present (as show=
n by
> -                * the workaround breaking HDMI output on M3-W during tes=
ting).
> -                */
> -               if (rcdu->info->quirks & RCAR_DU_QUIRK_H3_ES1_PCLK_STABIL=
ITY) {
> -                       target *=3D 2;
> -                       div =3D 1;
> -               }
> -
>                 extclk =3D clk_get_rate(rcrtc->extclock);
>                 rcar_du_dpll_divider(rcrtc, &dpll, extclk, target);
> =20
> @@ -245,30 +231,13 @@ static void rcar_du_crtc_set_display_timing(struct =
rcar_du_crtc *rcrtc)
>                        | DPLLCR_N(dpll.n) | DPLLCR_M(dpll.m)
>                        | DPLLCR_STBY;
> =20
> -               if (rcrtc->index =3D=3D 1) {
> +               if (rcrtc->index =3D=3D 1)
>                         dpllcr |=3D DPLLCR_PLCS1
>                                |  DPLLCR_INCS_DOTCLKIN1;
> -               } else {
> -                       dpllcr |=3D DPLLCR_PLCS0_PLL
> +               else
> +                       dpllcr |=3D DPLLCR_PLCS0
>                                |  DPLLCR_INCS_DOTCLKIN0;
> =20
> -                       /*
> -                        * On ES2.x we have a single mux controlled via b=
it 21,
> -                        * which selects between DCLKIN source (bit 21 =
=3D 0) and
> -                        * a PLL source (bit 21 =3D 1), where the PLL is =
always
> -                        * PLL1.
> -                        *
> -                        * On ES1.x we have an additional mux, controlled
> -                        * via bit 20, for choosing between PLL0 (bit 20 =
=3D 0)
> -                        * and PLL1 (bit 20 =3D 1). We always want to use=
 PLL1,
> -                        * so on ES1.x, in addition to setting bit 21, we=
 need
> -                        * to set the bit 20.
> -                        */
> -
> -                       if (rcdu->info->quirks & RCAR_DU_QUIRK_H3_ES1_PLL)
> -                               dpllcr |=3D DPLLCR_PLCS0_H3ES1X_PLL1;
> -               }
> -
>                 rcar_du_group_write(rcrtc->group, DPLLCR, dpllcr);
> =20
>                 escr =3D ESCR_DCLKSEL_DCLKIN | div;
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar=
-du/rcar_du_drv.c
> index b9a94c5260e9..1ffde19cb87f 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -16,7 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> -#include <linux/sys_soc.h>
>  #include <linux/wait.h>
> =20
>  #include <drm/drm_atomic_helper.h>
> @@ -387,43 +386,6 @@ static const struct rcar_du_device_info rcar_du_r8a7=
795_info =3D {
>         .dpll_mask =3D  BIT(2) | BIT(1),
>  };
> =20
> -static const struct rcar_du_device_info rcar_du_r8a7795_es1_info =3D {
> -       .gen =3D 3,
> -       .features =3D RCAR_DU_FEATURE_CRTC_IRQ
> -                 | RCAR_DU_FEATURE_CRTC_CLOCK
> -                 | RCAR_DU_FEATURE_VSP1_SOURCE
> -                 | RCAR_DU_FEATURE_INTERLACED
> -                 | RCAR_DU_FEATURE_TVM_SYNC,
> -       .quirks =3D RCAR_DU_QUIRK_H3_ES1_PCLK_STABILITY
> -               | RCAR_DU_QUIRK_H3_ES1_PLL,
> -       .channels_mask =3D BIT(3) | BIT(2) | BIT(1) | BIT(0),
> -       .routes =3D {
> -               /*
> -                * R8A7795 has one RGB output, two HDMI outputs and one
> -                * LVDS output.
> -                */
> -               [RCAR_DU_OUTPUT_DPAD0] =3D {
> -                       .possible_crtcs =3D BIT(3),
> -                       .port =3D 0,
> -               },
> -               [RCAR_DU_OUTPUT_HDMI0] =3D {
> -                       .possible_crtcs =3D BIT(1),
> -                       .port =3D 1,
> -               },
> -               [RCAR_DU_OUTPUT_HDMI1] =3D {
> -                       .possible_crtcs =3D BIT(2),
> -                       .port =3D 2,
> -               },
> -               [RCAR_DU_OUTPUT_LVDS0] =3D {
> -                       .possible_crtcs =3D BIT(0),
> -                       .port =3D 3,
> -               },
> -       },
> -       .num_lvds =3D 1,
> -       .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(2) | BIT(1),
> -};
> -
>  static const struct rcar_du_device_info rcar_du_r8a7796_info =3D {
>         .gen =3D 3,
>         .features =3D RCAR_DU_FEATURE_CRTC_IRQ
> @@ -614,11 +576,6 @@ static const struct of_device_id rcar_du_of_table[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(of, rcar_du_of_table);
> =20
> -static const struct soc_device_attribute rcar_du_soc_table[] =3D {
> -       { .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &rcar_d=
u_r8a7795_es1_info },
> -       { /* sentinel */ }
> -};
> -
>  const char *rcar_du_output_name(enum rcar_du_output output)
>  {
>         static const char * const names[] =3D {
> @@ -707,7 +664,6 @@ static void rcar_du_shutdown(struct platform_device *=
pdev)
> =20
>  static int rcar_du_probe(struct platform_device *pdev)
>  {
> -       const struct soc_device_attribute *soc_attr;
>         struct rcar_du_device *rcdu;
>         unsigned int mask;
>         int ret;
> @@ -725,10 +681,6 @@ static int rcar_du_probe(struct platform_device *pde=
v)
> =20
>         rcdu->info =3D of_device_get_match_data(rcdu->dev);
> =20
> -       soc_attr =3D soc_device_match(rcar_du_soc_table);
> -       if (soc_attr)
> -               rcdu->info =3D soc_attr->data;
> -
>         platform_set_drvdata(pdev, rcdu);
> =20
>         /* I/O resources */
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar=
-du/rcar_du_drv.h
> index acc3673fefe1..5cfa2bb7ad93 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -34,8 +34,6 @@ struct rcar_du_device;
>  #define RCAR_DU_FEATURE_NO_BLENDING    BIT(5)  /* PnMR.SPIM does not hav=
e ALP nor EOR bits */
> =20
>  #define RCAR_DU_QUIRK_ALIGN_128B       BIT(0)  /* Align pitches to 128 b=
ytes */
> -#define RCAR_DU_QUIRK_H3_ES1_PCLK_STABILITY BIT(1)     /* H3 ES1 has pcl=
k stability issue */
> -#define RCAR_DU_QUIRK_H3_ES1_PLL       BIT(2)  /* H3 ES1 PLL setup diffe=
rs from non-ES1 */
> =20
>  enum rcar_du_output {
>         RCAR_DU_OUTPUT_DPAD0,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rca=
r-du/rcar_du_regs.h
> index 789ae9285108..288eff12b2b1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
> @@ -283,8 +283,7 @@
>  #define DPLLCR                 0x20044
>  #define DPLLCR_CODE            (0x95 << 24)
>  #define DPLLCR_PLCS1           (1 << 23)
> -#define DPLLCR_PLCS0_PLL       (1 << 21)
> -#define DPLLCR_PLCS0_H3ES1X_PLL1       (1 << 20)
> +#define DPLLCR_PLCS0           (1 << 21)
>  #define DPLLCR_CLKE            (1 << 18)
>  #define DPLLCR_FDPLL(n)                ((n) << 12)
>  #define DPLLCR_N(n)            ((n) << 5)
> --=20
> 2.35.1
>
