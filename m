Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71914617692
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKCGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiKCGGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:06:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD600193E6;
        Wed,  2 Nov 2022 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0smtlWd4HGnf6GjxBBNVPyZdRbAeNRzlEzj9TPQNMMk=; b=if61U6QEgvQm9kJwy7xXOTydGC
        wvSEX+Sc65lQ6DaGdxNDpqVT3O9Ii3+vzX8iwt53dq/VCkPFgqovdHAXVLvZZb7YpOaVl2J5sIrz3
        XHR+pa7Uyr1xgWxZdPvWDIhfzeuMSi2n6w5TyQ/FkvnM8LYh0IqmrSpdUD1FF5HdM3jxGpYrXhXFo
        LM4JynT99eU5y9Znj2/QC3tfMiAOujsISggWXubVt/JG5WIf32+VRfrudTKqT38sHTxpvgHxqRABj
        5/d+2lddCn0yQc2znpmC0kfTOapiqm+25R9bALANRqOYqi1oWSXRtvHzAnveMatnwpImW9sbgLrJX
        P1kJX6sA==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqTNJ-00GGEk-BK; Thu, 03 Nov 2022 06:06:49 +0000
Message-ID: <a68a24a0-eda3-8711-21c1-334289eca0d3@infradead.org>
Date:   Wed, 2 Nov 2022 23:06:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drm: rcar_du: DRM_RCAR_DU optionally depends on
 RCAR_MIPI_DSI
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20221018181828.19528-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221018181828.19528-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping. I have verified (on linux-next-20221103) that this is still needed.
Thanks.

On 10/18/22 11:18, Randy Dunlap wrote:
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
> 
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
~Randy
