Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4569A69D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBQIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBQIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:09:16 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B9F5E5B5;
        Fri, 17 Feb 2023 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676621353; x=1708157353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4LlNQesVn7hKoWLdoFsmmchC0zOflI6zSTV9xpIKZk=;
  b=ofiwuKweivUNmAwEqJg79mzpXIXIT3EXaBICVaqhx+6aNCjJP3ptny29
   wyd/3y1ms8j1lyI9Qg84nP59KZ/pCwmYjigccnfPey1nZKJXrlm5FtPDn
   amNoFz3DKdZswbgbrG8SDOktzY3Sn4uIxo8JwHte8xo62kgC1HDBbXVTd
   l7TL2dYErUJl7JkK3e4t3uVu1dIdypjiz5DY7VtA+VHNncY23A5bIhh6f
   o25wyMfLereIfJruPVCeIz1P/IKdU9gj8WY9b8NtDKFV6rXEJKagOI5Tm
   CyU+VCmnk1cyRm6zDRZlWST7g7M/JHZzlahaBywecB2EAkzJesuVDBYia
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669071600"; 
   d="scan'208";a="29147775"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Feb 2023 09:09:10 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 17 Feb 2023 09:09:10 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 17 Feb 2023 09:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676621350; x=1708157350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4LlNQesVn7hKoWLdoFsmmchC0zOflI6zSTV9xpIKZk=;
  b=k8pujjmm4MnBKYb0h4f2k233qdOqQ290tsHMW31FdqMdvWEcsIa1NsDl
   D+UP65xmV4NcH5b1Awv0kbksbV1WLxG1wcniWJk2/Umf1zu1YHnmOxAW2
   jaq8MD50yUfTFoNVVRNEvO6BmRaGqPvBX2aevqhbIYDecjIMGvKa43FNq
   ot5wu+wNOQzdy5MU6jIJxtlkWT7c8934+Q1m4wE8bPS53wcLq8Vcbbupj
   reiHBk+tKH96nW7QKchJW/1eeL0AJ/uaImHUTxW1zw4tHCGVJzrp8rr0x
   SCnOQcbhfO8ZCXTrUikpGZbNSXdSGOe0sNXpWhnc7GdBau0TO6BSk1R1A
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669071600"; 
   d="scan'208";a="29147774"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Feb 2023 09:09:10 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 762D0280056;
        Fri, 17 Feb 2023 09:09:09 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liu Ying <victor.liu@nxp.com>
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de
Subject: Re: [PATCH v4 3/6] drm: lcdif: Determine bus format and flags in ->atomic_check()
Date:   Fri, 17 Feb 2023 09:09:07 +0100
Message-ID: <5651056.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230217065407.2259731-4-victor.liu@nxp.com>
References: <20230217065407.2259731-1-victor.liu@nxp.com> <20230217065407.2259731-4-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

thanks for the update.

Am Freitag, 17. Februar 2023, 07:54:04 CET schrieb Liu Ying:
> Instead of determining LCDIF output bus format and bus flags in
> ->atomic_enable(), do that in ->atomic_check().  This is a
> preparation for the upcoming patch to check consistent bus format
> and bus flags across all first downstream bridges in ->atomic_check().
> New lcdif_crtc_state structure is introduced to cache bus format
> and bus flags states in ->atomic_check() so that they can be read
> in ->atomic_enable().
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Look good to me.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> v3->v4:
> * Use 'new_{c,p}state' instead of 'new_{crtc,plane}_state'. (Alexander)
> * Simplify lcdif_crtc_reset() by calling lcdif_crtc_atomic_destroy_state(=
).
>   (Alexander)
> * Add '!crtc->state' check in lcdif_crtc_atomic_duplicate_state().
> (Alexander)
>=20
> v2->v3:
> * No change.
>=20
> v1->v2:
> * Split from patch 2/2 in v1. (Marek, Alexander)
> * Add comment on the 'base' member of lcdif_crtc_state structure to
>   note it should always be the first member. (Lothar)
>=20
>  drivers/gpu/drm/mxsfb/lcdif_kms.c | 134 ++++++++++++++++++++++--------
>  1 file changed, 99 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> b/drivers/gpu/drm/mxsfb/lcdif_kms.c index e54200a9fcb9..d46de433cd8e 1006=
44
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -30,6 +30,18 @@
>  #include "lcdif_drv.h"
>  #include "lcdif_regs.h"
>=20
> +struct lcdif_crtc_state {
> +	struct drm_crtc_state	base;	/* always be the first=20
member */
> +	u32			bus_format;
> +	u32			bus_flags;
> +};
> +
> +static inline struct lcdif_crtc_state *
> +to_lcdif_crtc_state(struct drm_crtc_state *s)
> +{
> +	return container_of(s, struct lcdif_crtc_state, base);
> +}
> +
>  /*
> -------------------------------------------------------------------------=
=2D-
> -- * CRTC
>   */
> @@ -385,48 +397,72 @@ static void lcdif_reset_block(struct lcdif_drm_priv=
ate
> *lcdif) readl(lcdif->base + LCDC_V8_CTRL);
>  }
>=20
> -static void lcdif_crtc_mode_set_nofb(struct lcdif_drm_private *lcdif,
> -				     struct drm_plane_state=20
*plane_state,
> -				     struct drm_bridge_state=20
*bridge_state,
> -				     const u32 bus_format)
> +static void lcdif_crtc_mode_set_nofb(struct drm_crtc_state *crtc_state,
> +				     struct drm_plane_state=20
*plane_state)
>  {
> -	struct drm_device *drm =3D lcdif->crtc.dev;
> -	struct drm_display_mode *m =3D &lcdif->crtc.state->adjusted_mode;
> -	u32 bus_flags =3D 0;
> -
> -	if (lcdif->bridge->timings)
> -		bus_flags =3D lcdif->bridge->timings->input_bus_flags;
> -	else if (bridge_state)
> -		bus_flags =3D bridge_state->input_bus_cfg.flags;
> +	struct lcdif_crtc_state *lcdif_crtc_state =3D
> to_lcdif_crtc_state(crtc_state); +	struct drm_device *drm =3D
> crtc_state->crtc->dev;
> +	struct lcdif_drm_private *lcdif =3D to_lcdif_drm_private(drm);
> +	struct drm_display_mode *m =3D &crtc_state->adjusted_mode;
>=20
>  	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)
\n",
>  			     m->crtc_clock,
>  			     (int)(clk_get_rate(lcdif->clk) / 1000));
>  	DRM_DEV_DEBUG_DRIVER(drm->dev, "Bridge bus_flags: 0x%08X\n",
> -			     bus_flags);
> +			     lcdif_crtc_state->bus_flags);
>  	DRM_DEV_DEBUG_DRIVER(drm->dev, "Mode flags: 0x%08X\n", m->flags);
>=20
>  	/* Mandatory eLCDIF reset as per the Reference Manual */
>  	lcdif_reset_block(lcdif);
>=20
> -	lcdif_set_formats(lcdif, plane_state, bus_format);
> +	lcdif_set_formats(lcdif, plane_state, lcdif_crtc_state->bus_format);
>=20
> -	lcdif_set_mode(lcdif, bus_flags);
> +	lcdif_set_mode(lcdif, lcdif_crtc_state->bus_flags);
>  }
>=20
>  static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
>  				   struct drm_atomic_state *state)
>  {
> +	struct drm_device *drm =3D crtc->dev;
> +	struct lcdif_drm_private *lcdif =3D to_lcdif_drm_private(drm);
>  	struct drm_crtc_state *crtc_state =3D=20
drm_atomic_get_new_crtc_state(state,
>  							=09
	  crtc);
> +	struct lcdif_crtc_state *lcdif_crtc_state =3D
> to_lcdif_crtc_state(crtc_state); bool has_primary =3D crtc_state->plane_m=
ask
> &
>  			   drm_plane_mask(crtc->primary);
> +	struct drm_bridge_state *bridge_state;
> +	struct drm_bridge *bridge =3D lcdif->bridge;
> +	int ret;
>=20
>  	/* The primary plane has to be enabled when the CRTC is active. */
>  	if (crtc_state->active && !has_primary)
>  		return -EINVAL;
>=20
> -	return drm_atomic_add_affected_planes(state, crtc);
> +	ret =3D drm_atomic_add_affected_planes(state, crtc);
> +	if (ret)
> +		return ret;
> +
> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
> +	if (!bridge_state)
> +		lcdif_crtc_state->bus_format =3D MEDIA_BUS_FMT_FIXED;
> +	else
> +		lcdif_crtc_state->bus_format =3D bridge_state-
>input_bus_cfg.format;
> +
> +	if (lcdif_crtc_state->bus_format =3D=3D MEDIA_BUS_FMT_FIXED) {
> +		dev_warn_once(drm->dev,
> +			      "Bridge does not provide bus format,=20
assuming
> MEDIA_BUS_FMT_RGB888_1X24.\n" +			      "Please fix=20
bridge driver by
> handling atomic_get_input_bus_fmts.\n"); +		lcdif_crtc_state-
>bus_format =3D
> MEDIA_BUS_FMT_RGB888_1X24;
> +	}
> +
> +	if (bridge->timings)
> +		lcdif_crtc_state->bus_flags =3D bridge->timings-
>input_bus_flags;
> +	else if (bridge_state)
> +		lcdif_crtc_state->bus_flags =3D bridge_state-
>input_bus_cfg.flags;
> +	else
> +		lcdif_crtc_state->bus_flags =3D 0;
> +
> +	return 0;
>  }
>=20
>  static void lcdif_crtc_atomic_flush(struct drm_crtc *crtc,
> @@ -458,32 +494,18 @@ static void lcdif_crtc_atomic_enable(struct drm_crtc
> *crtc, struct drm_atomic_state *state)
>  {
>  	struct lcdif_drm_private *lcdif =3D to_lcdif_drm_private(crtc->dev);
> +	struct drm_crtc_state *new_cstate =3D=20
drm_atomic_get_new_crtc_state(state,
> crtc); struct drm_plane_state *new_pstate =3D
> drm_atomic_get_new_plane_state(state, crtc->primary);
>  	struct drm_display_mode *m =3D &lcdif->crtc.state->adjusted_mode;
> -	struct drm_bridge_state *bridge_state =3D NULL;
>  	struct drm_device *drm =3D lcdif->drm;
> -	u32 bus_format;
>  	dma_addr_t paddr;
>=20
> -	bridge_state =3D drm_atomic_get_new_bridge_state(state, lcdif-
>bridge);
> -	if (!bridge_state)
> -		bus_format =3D MEDIA_BUS_FMT_FIXED;
> -	else
> -		bus_format =3D bridge_state->input_bus_cfg.format;
> -
> -	if (bus_format =3D=3D MEDIA_BUS_FMT_FIXED) {
> -		dev_warn_once(drm->dev,
> -			      "Bridge does not provide bus format,=20
assuming
> MEDIA_BUS_FMT_RGB888_1X24.\n" -			      "Please fix=20
bridge driver by
> handling atomic_get_input_bus_fmts.\n"); -		bus_format =3D
> MEDIA_BUS_FMT_RGB888_1X24;
> -	}
> -
>  	clk_set_rate(lcdif->clk, m->crtc_clock * 1000);
>=20
>  	pm_runtime_get_sync(drm->dev);
>=20
> -	lcdif_crtc_mode_set_nofb(lcdif, new_pstate, bridge_state,=20
bus_format);
> +	lcdif_crtc_mode_set_nofb(new_cstate, new_pstate);
>=20
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
>  	paddr =3D drm_fb_dma_get_gem_addr(new_pstate->fb, new_pstate, 0);
> @@ -520,6 +542,48 @@ static void lcdif_crtc_atomic_disable(struct drm_crtc
> *crtc, pm_runtime_put_sync(drm->dev);
>  }
>=20
> +static void lcdif_crtc_atomic_destroy_state(struct drm_crtc *crtc,
> +					    struct drm_crtc_state=20
*state)
> +{
> +	__drm_atomic_helper_crtc_destroy_state(state);
> +	kfree(to_lcdif_crtc_state(state));
> +}
> +
> +static void lcdif_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct lcdif_crtc_state *state;
> +
> +	if (crtc->state)
> +		lcdif_crtc_atomic_destroy_state(crtc, crtc->state);
> +
> +	crtc->state =3D NULL;
> +
> +	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (state)
> +		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +}
> +
> +static struct drm_crtc_state *
> +lcdif_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
> +{
> +	struct lcdif_crtc_state *old =3D to_lcdif_crtc_state(crtc->state);
> +	struct lcdif_crtc_state *new;
> +
> +	if (WARN_ON(!crtc->state))
> +		return NULL;
> +
> +	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return NULL;
> +
> +	__drm_atomic_helper_crtc_duplicate_state(crtc, &new->base);
> +
> +	new->bus_format =3D old->bus_format;
> +	new->bus_flags =3D old->bus_flags;
> +
> +	return &new->base;
> +}
> +
>  static int lcdif_crtc_enable_vblank(struct drm_crtc *crtc)
>  {
>  	struct lcdif_drm_private *lcdif =3D to_lcdif_drm_private(crtc->dev);
> @@ -548,12 +612,12 @@ static const struct drm_crtc_helper_funcs
> lcdif_crtc_helper_funcs =3D { };
>=20
>  static const struct drm_crtc_funcs lcdif_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.reset =3D lcdif_crtc_reset,
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
> -	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
> -	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
> +	.atomic_duplicate_state =3D lcdif_crtc_atomic_duplicate_state,
> +	.atomic_destroy_state =3D lcdif_crtc_atomic_destroy_state,
>  	.enable_vblank =3D lcdif_crtc_enable_vblank,
>  	.disable_vblank =3D lcdif_crtc_disable_vblank,
>  };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


