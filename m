Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBE73BD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjFWRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFWRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:08:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7362D4C;
        Fri, 23 Jun 2023 10:08:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97F2E838;
        Fri, 23 Jun 2023 19:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687540052;
        bh=gzhnbRo3G2xtBbekM1sXIop1Hs4168rGbYujQRn9E7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4iBS40w3cb+Oa10OPEU/i1vLanzf05nmwJssUUsDXv0ld6dQoGAUe++V52vmwXVd
         6n3ye2DIFv0+7FN7zjd0XDfbyrO9ALZPuGYyB493Ifvoc8nwQgaI87DwBLChrD8BNX
         G0VolyY1zHKhxsbJhDgLJXFzCMU7s3kYRG9g5byE=
Date:   Fri, 23 Jun 2023 20:08:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/39] drm: renesas: shmobile: Wait for page flip when
 turning CRTC off
Message-ID: <20230623170808.GH2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <0b0cc2971b2abc8fe0fc55a9ae652a7b8a7235cd.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b0cc2971b2abc8fe0fc55a9ae652a7b8a7235cd.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:42AM +0200, Geert Uytterhoeven wrote:
> Turning a CRTC off will prevent a queued page flip from ever completing,
> potentially confusing userspace.  Wait for queued page flips to complete
> before turning the CRTC off to avoid this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Given that you're duplicating the rcar-du page flip handling code, I
have a feeling core helpers would be handy. It's not a blocker for this
series though, so

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 37 +++++++++++++++++++
>  .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  3 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 1d7fcf64bf2aab80..d2a0ac5f9368c11c 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -285,11 +285,40 @@ void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
>  	scrtc->event = NULL;
>  	if (event) {
>  		drm_crtc_send_vblank_event(&scrtc->base, event);
> +		wake_up(&scrtc->flip_wait);
>  		drm_crtc_vblank_put(&scrtc->base);
>  	}
>  	spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
>  
> +static bool shmob_drm_crtc_page_flip_pending(struct shmob_drm_crtc *scrtc)
> +{
> +	struct drm_device *dev = scrtc->base.dev;
> +	unsigned long flags;
> +	bool pending;
> +
> +	spin_lock_irqsave(&dev->event_lock, flags);
> +	pending = scrtc->event != NULL;
> +	spin_unlock_irqrestore(&dev->event_lock, flags);
> +
> +	return pending;
> +}
> +
> +static void shmob_drm_crtc_wait_page_flip(struct shmob_drm_crtc *scrtc)
> +{
> +	struct drm_crtc *crtc = &scrtc->base;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
> +
> +	if (wait_event_timeout(scrtc->flip_wait,
> +			       !shmob_drm_crtc_page_flip_pending(scrtc),
> +			       msecs_to_jiffies(50)))
> +		return;
> +
> +	dev_warn(sdev->dev, "page flip timeout\n");
> +
> +	shmob_drm_crtc_finish_page_flip(scrtc);
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * CRTC Functions
>   */
> @@ -302,6 +331,12 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
>  	if (!scrtc->started)
>  		return;
>  
> +	/*
> +	 * Wait for page flip completion before stopping the CRTC as userspace
> +	 * expects page flips to eventually complete.
> +	 */
> +	shmob_drm_crtc_wait_page_flip(scrtc);
> +
>  	/* Stop the LCDC. */
>  	shmob_drm_crtc_start_stop(scrtc, false);
>  
> @@ -515,6 +550,8 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
>  	unsigned int i;
>  	int ret;
>  
> +	init_waitqueue_head(&sdev->crtc.flip_wait);
> +
>  	sdev->crtc.dpms = DRM_MODE_DPMS_OFF;
>  
>  	primary = shmob_drm_plane_create(sdev, 0);
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> index 2c6d7541427581a6..b9863e026e8a9b83 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> @@ -14,6 +14,8 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_encoder.h>
>  
> +#include <linux/wait.h>
> +
>  #include <video/videomode.h>
>  
>  struct drm_pending_vblank_event;
> @@ -24,6 +26,7 @@ struct shmob_drm_crtc {
>  	struct drm_crtc base;
>  
>  	struct drm_pending_vblank_event *event;
> +	wait_queue_head_t flip_wait;
>  	int dpms;
>  
>  	const struct shmob_drm_format_info *format;

-- 
Regards,

Laurent Pinchart
