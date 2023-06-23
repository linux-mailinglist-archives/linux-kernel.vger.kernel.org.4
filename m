Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA373BAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjFWO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFWO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:59:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4713E;
        Fri, 23 Jun 2023 07:59:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57D41440;
        Fri, 23 Jun 2023 16:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532338;
        bh=UNF4vGYdun0BL/GAZBLgK6Ry2y6OLxCuHlXyuLsgc14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxgNCOqeedk+T5onFKGHrGR1B6uHo09Rr5XjVEWKP2Vw6TDJg1PZa9rz0LRBIGc0U
         LSX3ToThkvkqZWAac65PeBC9maGNmSM0k7KPX4JI9wvUP3wkXwBAt8ud3cgtn+glT8
         XqerpJx/S9RVuZUY9gDmuBYdtxdMHT5S1re1ZdX0=
Date:   Fri, 23 Jun 2023 17:59:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/39] drm: renesas: shmobile: Fix overlay plane disable
Message-ID: <20230623145933.GG2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <9feb39aaab796fc4b59c6c83c3d96757482f714d.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9feb39aaab796fc4b59c6c83c3d96757482f714d.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:15AM +0200, Geert Uytterhoeven wrote:
> Merely writing zero to the CHn Source Image Format Register is not
> sufficient to disable a plane, as the programmed register value is not
> propagated immediately to the current side.  This can be seen when using
> the -P option of modetest: the extra plane is displayed correctly, but
> does not disappear after exit.
> 
> Fix this by doing the full update dance using the Blend Control
> Register, like is done when enabling the plane.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index 850986cee848226a..0e34573c3cb3d032 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -215,7 +215,10 @@ static int shmob_drm_plane_disable(struct drm_plane *plane,
>  
>  	splane->format = NULL;
>  
> +	lcdc_write(sdev, LDBCR, LDBCR_UPC(splane->index));
>  	lcdc_write(sdev, LDBnBSIFR(splane->index), 0);
> +	lcdc_write(sdev, LDBCR,
> +		   LDBCR_UPF(splane->index) | LDBCR_UPD(splane->index));
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
