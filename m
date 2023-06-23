Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D56773BD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjFWQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:53:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5B1BDF;
        Fri, 23 Jun 2023 09:53:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CF28440;
        Fri, 23 Jun 2023 18:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687539171;
        bh=0o5JXOyLxku6NoKd+xArlaIIcndsIh5cFOxDa+QQXmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkSy1I1YN/pSgE1/ghr0KqD6SzCfxezy5+NgpQygi8qcGa2hwSsE42cn8R7HCYRXz
         51hNQt5eInxYwMC2MgpKau/QRneOArV4riw8C9N+iCCxGcrrcA9drz00cObYia2agT
         4g2eAEgqQ7E055GmF83ChaZpGss66M+Eauk7bWgI=
Date:   Fri, 23 Jun 2023 19:53:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/39] drm: renesas: shmobile: Use
 drm_crtc_handle_vblank()
Message-ID: <20230623165326.GF2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <7b6ffa43307522833103fe29ec6a084b7d621a16.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b6ffa43307522833103fe29ec6a084b7d621a16.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:40AM +0200, Geert Uytterhoeven wrote:
> Replace the call to the legacy drm_handle_vblank() function with a call
> to the new drm_crtc_handle_vblank() helper.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index c98e2bdd888c3274..6eaf2c5a104f451a 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -86,7 +86,7 @@ static irqreturn_t shmob_drm_irq(int irq, void *arg)
>  	spin_unlock_irqrestore(&sdev->irq_lock, flags);
>  
>  	if (status & LDINTR_VES) {
> -		drm_handle_vblank(dev, 0);
> +		drm_crtc_handle_vblank(&sdev->crtc.base);
>  		shmob_drm_crtc_finish_page_flip(&sdev->crtc);
>  	}
>  

-- 
Regards,

Laurent Pinchart
