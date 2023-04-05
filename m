Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A146D72CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjDED75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbjDED7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:59:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3330ED;
        Tue,  4 Apr 2023 20:59:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B76C905;
        Wed,  5 Apr 2023 05:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680667185;
        bh=Dxm79oyRJT9b8gKrOzRwmkfugRaKtT8JuVJT6m5bmPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PflqIUVBytlCg/mnUlz2Ripb1HKoq+KPIyBjcpKkQh/fkoLDQPonMbaKh/n934pJj
         hwifEitd/j17VXEWQ65Qk15EGoo1OhWQWW3gdgcm+OBVcayKu2jAQVC1FtGgEysmhk
         jTXJ3+mJCPoqToU8Mzf1Eq8uER/2UYLFH00Tnpp8=
Date:   Wed, 5 Apr 2023 06:59:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm: shmobile: Switch to drm_crtc_init_with_planes()
Message-ID: <20230405035952.GI9915@pendragon.ideasonboard.com>
References: <cover.1680273039.git.geert+renesas@glider.be>
 <df4099d79c985c73bdc890eb0e026494b7fa5c96.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df4099d79c985c73bdc890eb0e026494b7fa5c96.1680273039.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Mar 31, 2023 at 04:48:09PM +0200, Geert Uytterhoeven wrote:
> The SH-Mobile DRM driver uses the legacy drm_crtc_init(), which
> advertizes only the formats in safe_modeset_formats[] (XR24 and AR24) as
> being supported.
> 
> Switch to drm_crtc_init_with_planes(), and advertize all supported
> (A)RGB modes, so we can use RGB565 as the default mode for the console.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 30 +++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> index 08dc1428aa16caf0..11dd2bc803e7cb62 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>
> @@ -478,16 +479,41 @@ static const struct drm_crtc_funcs crtc_funcs = {
>  	.disable_vblank = shmob_drm_disable_vblank,
>  };
>  
> +static const uint32_t modeset_formats[] = {
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const struct drm_plane_funcs primary_plane_funcs = {
> +	DRM_PLANE_NON_ATOMIC_FUNCS,
> +};
> +
>  int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
>  {
>  	struct drm_crtc *crtc = &sdev->crtc.crtc;
> +	struct drm_plane *primary;
>  	int ret;
>  
>  	sdev->crtc.dpms = DRM_MODE_DPMS_OFF;
>  
> -	ret = drm_crtc_init(sdev->ddev, crtc, &crtc_funcs);
> -	if (ret < 0)
> +	primary = __drm_universal_plane_alloc(sdev->ddev, sizeof(*primary), 0,
> +					      0, &primary_plane_funcs,
> +					      modeset_formats,
> +					      ARRAY_SIZE(modeset_formats),
> +					      NULL, DRM_PLANE_TYPE_PRIMARY,
> +					      NULL);
> +	if (IS_ERR(primary))
> +		return PTR_ERR(primary);

This seems like a bit of a hack to me. Why don't you use the planes
created by shmob_drm_plane_create() instead of allocating a new one ?

> +
> +	ret = drm_crtc_init_with_planes(sdev->ddev, crtc, primary, NULL,
> +					&crtc_funcs, NULL);
> +	if (ret < 0) {
> +		drm_plane_cleanup(primary);
> +		kfree(primary);
>  		return ret;
> +	}
>  
>  	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
>  

-- 
Regards,

Laurent Pinchart
