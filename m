Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7D720002
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjFBLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjFBLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:06:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2667E49;
        Fri,  2 Jun 2023 04:06:21 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 163206E0;
        Fri,  2 Jun 2023 13:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685703958;
        bh=H0LfW0kt48rXXIsADqS7s4ieQRL9M5rRvbwHyylFCDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSc7QFvzSUD390rJN/7Lpo6HN6lMixboT3h+VA4W1fr3wM1fZmlPN4W9Wc1hIGUxj
         yb7lgSEZ8OnBGjhiRUrTbwqWbiuwJfhEIVHeAo7V0XTfinpVPuVSaslFA67SRCAJ2o
         idax+IsxVl7nzOVOnFMRMc4vzDrNVxT6gZ8/IDwA=
Date:   Fri, 2 Jun 2023 14:06:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm: Fix references to drm_plane_helper_check_state()
Message-ID: <20230602110618.GD26944@pendragon.ideasonboard.com>
References: <cover.1685696114.git.geert+renesas@glider.be>
 <2408d7841c91e98e9a2b24b1b4df9b2b865519a6.1685696114.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2408d7841c91e98e9a2b24b1b4df9b2b865519a6.1685696114.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Jun 02, 2023 at 11:11:36AM +0200, Geert Uytterhoeven wrote:
> As of commit a01cb8ba3f628293 ("drm: Move drm_plane_helper_check_state()
> into drm_atomic_helper.c"), drm_plane_helper_check_state() no longer
> exists, but is part of drm_atomic_helper_check_plane_state().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Interestingly, all these comments appeared only after the commit that
> removed the function...
> 
> This is against next-20230602, which does not have the
> drivers/gpu/drm/{ => renesas}/rcar-du move yet.
> 
> Biju: you're adding a new copy in
> drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 3 ++-
>  drivers/gpu/drm/tidss/tidss_plane.c     | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> index d759e019218181ce..e445fac8e0b46c21 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -600,7 +600,8 @@ int __rcar_du_plane_atomic_check(struct drm_plane *plane,
>  	if (!state->crtc) {
>  		/*
>  		 * The visible field is not reset by the DRM core but only
> -		 * updated by drm_plane_helper_check_state(), set it manually.
> +		 * updated by drm_atomic_helper_check_plane_state(), set it
> +		 * manually.
>  		 */
>  		state->visible = false;
>  		*format = NULL;
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index 6bdd6e4a955ab3cc..e1c0ef0c3894c855 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -38,7 +38,8 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
>  	if (!new_plane_state->crtc) {
>  		/*
>  		 * The visible field is not reset by the DRM core but only
> -		 * updated by drm_plane_helper_check_state(), set it manually.
> +		 * updated by drm_atomic_helper_check_plane_state(), set it
> +		 * manually.
>  		 */
>  		new_plane_state->visible = false;
>  		return 0;

-- 
Regards,

Laurent Pinchart
