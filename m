Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196E622D3E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiKIOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiKIOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:12:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486C1902A;
        Wed,  9 Nov 2022 06:12:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72203896;
        Wed,  9 Nov 2022 15:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668003118;
        bh=AffXHvdxCHZjAgL7Z9CuecNf9qFUAfZCnvn/pjOY1HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffO7kK8Rx6z7y+oG64svjLUW+zCTHx5u6OuAQWUNDNScvBrY+gsleyDUUKvX5cVlU
         MYt4pd0CSIBLUj/vKUJDjGj0sKb0upFIGDhRskNM1cu9kAqM/N32bDqJVdOAqDNy4V
         /xJCHiPiC2LrEHsSevkMndX19TGYcsZlQlCZ2C0w=
Date:   Wed, 9 Nov 2022 16:11:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: rcar_du: DRM_RCAR_DU optionally depends on
 RCAR_MIPI_DSI
Message-ID: <Y2u1G2OBMwlBjZ+8@pendragon.ideasonboard.com>
References: <20221018181828.19528-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018181828.19528-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Tue, Oct 18, 2022 at 11:18:28AM -0700, Randy Dunlap wrote:
> When CONFIG_DRM_RCAR_DU=y and CONFIG_DRM_RCAR_MIPI_DSI=m, calls
> from the builtin driver to the mipi driver fail due to linker
> errors.
> Since the RCAR_MIPI_DSI driver is not always required, fix the
> build error by making DRM_RCAR_DU optionally depend on the
> RCAR_MIPI_DSI Kconfig symbol. This prevents the problematic
> kconfig combination without requiring that RCAR_MIPI_DSI always
> be enabled.
> 
> aarch64-linux-ld: drivers/gpu/drm/rcar-du/rcar_du_crtc.o: in function `rcar_du_crtc_atomic_enable':
> rcar_du_crtc.c:(.text+0x3a18): undefined reference to `rcar_mipi_dsi_pclk_enable'
> aarch64-linux-ld: drivers/gpu/drm/rcar-du/rcar_du_crtc.o: in function `rcar_du_crtc_atomic_disable':
> rcar_du_crtc.c:(.text+0x47cc): undefined reference to `rcar_mipi_dsi_pclk_disable'

I've already posted a fix, see

https://lore.kernel.org/dri-devel/20221001220342.5828-1-laurent.pinchart+renesas@ideasonboard.com/

It aligns with how the LVDS encoder driver is handled, so I would prefer
that. I will send a pull request shortly, as a v6.1 fix.

> Fixes: 957fe62d7d15 ("drm: rcar-du: Fix DSI enable & disable sequence")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: LUU HOAI <hoai.luu.ub@renesas.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/rcar-du/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> --- a/drivers/gpu/drm/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -4,6 +4,7 @@ config DRM_RCAR_DU
>  	depends on DRM && OF
>  	depends on ARM || ARM64
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on DRM_RCAR_MIPI_DSI || DRM_RCAR_MIPI_DSI=n
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select VIDEOMODE_HELPERS

-- 
Regards,

Laurent Pinchart
