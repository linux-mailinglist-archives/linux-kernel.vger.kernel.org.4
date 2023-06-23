Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BC73BB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjFWPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFWPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:07:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024919B;
        Fri, 23 Jun 2023 08:07:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A5A5838;
        Fri, 23 Jun 2023 17:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532827;
        bh=oD4kG/c9kCvZMwIuxM4/Cnj6csQMpqebLk5VGFFXC8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMJ4V7DWDxc2tAdcxE1nBJGIx3mcwonccDHBxz2tWwbvfmSiP0dA712+jvEf/NiqD
         0zhdutTaI7JF5GweYH2qcgjygTY3IkEyNAckH8XDBM7BZ2LY1VlViSCFrzIioJFAHc
         PfN4E/02XQtkjHLeJU6C9P1DHoPp5uyAeVn70VQA=
Date:   Fri, 23 Jun 2023 18:07:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/39] drm: renesas: shmobile: Add support for Runtime PM
Message-ID: <20230623150742.GK2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <742b3351c1aed1f546ac2dcc1de15e0d04cc24d4.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <742b3351c1aed1f546ac2dcc1de15e0d04cc24d4.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:18AM +0200, Geert Uytterhoeven wrote:
> The SH-Mobile LCD Controller is part of a PM Domain on all relevant SoCs
> (clock domain on all, power domain on some).  Hence it may not be
> sufficient to manage the LCDC module clock explicitly (e.g. if the
> selected clock source differs from SHMOB_DRM_CLK_BUS).
> 
> Fix this by using Runtime PM instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 11 ++++++++++-
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  5 +++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index fbfd906844da490c..84dbf35025d7be63 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/backlight.h>
>  #include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -170,10 +171,16 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
>  	if (WARN_ON(format == NULL))
>  		return;
>  
> +	ret = pm_runtime_resume_and_get(sdev->dev);
> +	if (ret)
> +		return;
> +
>  	/* Enable clocks before accessing the hardware. */
>  	ret = shmob_drm_clk_on(sdev);

This would be best located in the runtime PM resume handler. Same for
disabling clocks in the runtime PM suspend handler.

> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(sdev->dev);
>  		return;
> +	}
>  
>  	/* Reset and enable the LCDC. */
>  	lcdc_write(sdev, LDCNT2R, lcdc_read(sdev, LDCNT2R) | LDCNT2R_BR);
> @@ -271,6 +278,8 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
>  	/* Stop clocks. */
>  	shmob_drm_clk_off(sdev);
>  
> +	pm_runtime_put(sdev->dev);
> +
>  	scrtc->started = false;
>  }
>  
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 30493ce874192e3e..4f01caa119637032 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
>  #include <drm/drm_drv.h>
> @@ -216,6 +217,10 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdev->mmio))
>  		return PTR_ERR(sdev->mmio);
>  
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +

I would move this after shmob_drm_setup_clocks(), to ensure that the
runtime PM suspend and resume handlers will have access to clocks.

>  	ret = shmob_drm_setup_clocks(sdev, pdata->clk_source);
>  	if (ret < 0)
>  		return ret;

-- 
Regards,

Laurent Pinchart
