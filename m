Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960A73BAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFWPDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjFWPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:03:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE51BCC;
        Fri, 23 Jun 2023 08:03:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 772FB838;
        Fri, 23 Jun 2023 17:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532591;
        bh=p+jpcDayI8eoKM1vIYcLk/Nmf5m012Wf5xfWEnnIwoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBEurA2XZTXtHd556If1I29pveYCigHPDXcQOEk4eyYUkaghD/i22N38pSNAJewii
         ZRwVYWZhhJcZpIouRUpETfoiPdV+mhPx7W2lTOxIFqJGHEYf10M9o7pl4kt7jPt8VJ
         DZPMCOAcxzUUV31QCVQhhK3+nprqeVJgW/+YPs2Q=
Date:   Fri, 23 Jun 2023 18:03:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/39] drm: renesas: shmobile: Correct encoder/connector
 types
Message-ID: <20230623150346.GH2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <2f44ca769d4f524ea475123ca987472589257e0f.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f44ca769d4f524ea475123ca987472589257e0f.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:17AM +0200, Geert Uytterhoeven wrote:
> The first encoder output on the SH-Mobile LCD Controller is a DPI
> parallel bus.  However, at the time of introduction of the driver, no
> encoder or connector types were defined yet for the DPI parallel bus,
> hence the driver used the ones for LVDS instead.
> 
> Adjust the types accordingly.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 11dd2bc803e7cb62..fbfd906844da490c 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -598,7 +598,7 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
>  	encoder->possible_crtcs = 1;
>  
>  	ret = drm_simple_encoder_init(sdev->ddev, encoder,
> -				      DRM_MODE_ENCODER_LVDS);
> +				      DRM_MODE_ENCODER_DPI);

You can use DRM_MODE_ENCODER_NONE, that will simplify the code when
adding support for additional outputs. The encoder type was exposed to
userspace by mistake, and AFAIU is unused by userspace, so it doesn't
need to be specified.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  	if (ret < 0)
>  		return ret;
>  
> @@ -684,7 +684,7 @@ int shmob_drm_connector_create(struct shmob_drm_device *sdev,
>  	connector->display_info.height_mm = sdev->pdata->panel.height_mm;
>  
>  	ret = drm_connector_init(sdev->ddev, connector, &connector_funcs,
> -				 DRM_MODE_CONNECTOR_LVDS);
> +				 DRM_MODE_CONNECTOR_DPI);
>  	if (ret < 0)
>  		return ret;
>  

-- 
Regards,

Laurent Pinchart
