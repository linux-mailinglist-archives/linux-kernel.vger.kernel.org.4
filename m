Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9073BBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjFWPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFWPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:41:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F4B2120;
        Fri, 23 Jun 2023 08:41:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A8EF838;
        Fri, 23 Jun 2023 17:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687534837;
        bh=ArqSpTQIPLlQGIEbrbSLaivyf0ENs3vlfTMm4U/5SAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPzsCj056QJcxMA2HRsKQPOmZF6EdhSqvtkgvaVOL7ZfFp7bzuzwZ5MKa0lCU1jft
         AXPw1OlUdeV6dOWa6nUXpNxVrtRul9BxYzLC1/jDdi9Xl/f+W1+2Fespvd0Q8WwvnD
         6dWN0vv27FDdYa8xb/VziVjWS5YWO/OoT/wCHW6A=
Date:   Fri, 23 Jun 2023 18:41:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/39] drm: renesas: shmobile: Improve error handling
Message-ID: <20230623154112.GS2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <100c650ab37ae09a142a93afa3734400a6a96757.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <100c650ab37ae09a142a93afa3734400a6a96757.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:27AM +0200, Geert Uytterhoeven wrote:
> Prepare for DT conversion, where panel probe can be deferred, by
> streamlining error propagation and handling:
>   - Use dev_err_probe() to avoid printing error messages in case of
>     probe deferral,
>   - Propagate errors where needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c |  3 ++-
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c | 14 +++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 9aa9800899976a23..50fca18282c5cb5e 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -228,7 +228,8 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  
>  	ret = shmob_drm_modeset_init(sdev);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to initialize mode setting\n");
> +		dev_err_probe(&pdev->dev, ret,
> +			      "failed to initialize mode setting\n");
>  		goto err_free_drm_dev;
>  	}
>  
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
> index 3051318ddc7999bc..1a62e7f8a8a9e6df 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
> @@ -157,9 +157,17 @@ int shmob_drm_modeset_init(struct shmob_drm_device *sdev)
>  	if (ret)
>  		return ret;
>  
> -	shmob_drm_crtc_create(sdev);
> -	shmob_drm_encoder_create(sdev);
> -	shmob_drm_connector_create(sdev, &sdev->encoder);
> +	ret = shmob_drm_crtc_create(sdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = shmob_drm_encoder_create(sdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = shmob_drm_connector_create(sdev, &sdev->encoder);
> +	if (ret < 0)
> +		return ret;
>  
>  	drm_kms_helper_poll_init(sdev->ddev);
>  

-- 
Regards,

Laurent Pinchart
