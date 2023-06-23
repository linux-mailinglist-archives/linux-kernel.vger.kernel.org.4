Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C473BD45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjFWQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjFWQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:54:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7292942;
        Fri, 23 Jun 2023 09:53:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D24A4440;
        Fri, 23 Jun 2023 18:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687539202;
        bh=3QdgbBKNiVmTM+3oQfUmbPGWfcpAOaIZaauIsW7EWQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+EYxAGo5ZkyUW08R1BH0AkF+HIF+oqx1+cp3Lt+HHfXmsDZ8gs9/YDejrdHfx8XP
         LTUaFoaVZad3dMEJpYIpB/zrJXiYdXcd52lpGN7w6edg6aabPb2dJDztpi5WBnOA3i
         Doj1kUrLZPxzbtZpH9FCjFz8hW8931cwX3yNM1gc=
Date:   Fri, 23 Jun 2023 19:53:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/39] drm: renesas: shmobile: Move
 shmob_drm_crtc_finish_page_flip()
Message-ID: <20230623165357.GG2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <e51f11814e6db911123f938c5bb1d73814fc6731.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e51f11814e6db911123f938c5bb1d73814fc6731.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:41AM +0200, Geert Uytterhoeven wrote:
> Move the shmob_drm_crtc_finish_page_flip() function up, to avoid having
> to move it during the modification in the next change.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 40 +++++++++++--------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 2c0ca802d36026f4..1d7fcf64bf2aab80 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -270,6 +270,30 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
>  	scrtc->started = true;
>  }
>  
> +/* -----------------------------------------------------------------------------
> + * Page Flip
> + */
> +
> +void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
> +{
> +	struct drm_pending_vblank_event *event;
> +	struct drm_device *dev = scrtc->base.dev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->event_lock, flags);
> +	event = scrtc->event;
> +	scrtc->event = NULL;
> +	if (event) {
> +		drm_crtc_send_vblank_event(&scrtc->base, event);
> +		drm_crtc_vblank_put(&scrtc->base);
> +	}
> +	spin_unlock_irqrestore(&dev->event_lock, flags);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * CRTC Functions
> + */
> +
>  static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
>  {
>  	struct drm_crtc *crtc = &scrtc->base;
> @@ -412,22 +436,6 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
>  	.mode_set_base = shmob_drm_crtc_mode_set_base,
>  };
>  
> -void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
> -{
> -	struct drm_pending_vblank_event *event;
> -	struct drm_device *dev = scrtc->base.dev;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&dev->event_lock, flags);
> -	event = scrtc->event;
> -	scrtc->event = NULL;
> -	if (event) {
> -		drm_crtc_send_vblank_event(&scrtc->base, event);
> -		drm_crtc_vblank_put(&scrtc->base);
> -	}
> -	spin_unlock_irqrestore(&dev->event_lock, flags);
> -}
> -
>  static int shmob_drm_crtc_page_flip(struct drm_crtc *crtc,
>  				    struct drm_framebuffer *fb,
>  				    struct drm_pending_vblank_event *event,

-- 
Regards,

Laurent Pinchart
