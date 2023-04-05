Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D86D72A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbjDEDFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDEDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:05:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A03AAD;
        Tue,  4 Apr 2023 20:05:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D401C905;
        Wed,  5 Apr 2023 05:05:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680663910;
        bh=7Q6te+srG/YQdMjnP9zmGIwnmU0iy8ZmFiqkBUkPSuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gg/FhMUGg5AYJeuHo5MXTd29ntJknBw+mZ2gjT3cFKXTjhCFIcLSan7RalR6gZBWi
         MOnXoM5d8bJWZ/iV5qG8v8wlDtqSwjfRbBIIXPMpjc1Aq9DfIlfVxvaLnSdhe0RAGP
         ZMGiR/vXU0i57pYqnkixScAUM83zMoUScls+Ua/o=
Date:   Wed, 5 Apr 2023 06:05:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm: shmobile: Use %p4cc to print fourcc codes
Message-ID: <20230405030516.GG9915@pendragon.ideasonboard.com>
References: <cover.1680273039.git.geert+renesas@glider.be>
 <1912536b0972568efc3d4f96c89de96b2abd7510.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1912536b0972568efc3d4f96c89de96b2abd7510.1680273039.git.geert+renesas@glider.be>
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

On Fri, Mar 31, 2023 at 04:48:07PM +0200, Geert Uytterhoeven wrote:
> Replace the printing of hexadecimal fourcc format codes by
> pretty-printed format names, using the "%p4cc" format specifier.

I really like %p4cc :-) I makes things much neater.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 4 ++--
>  drivers/gpu/drm/shmobile/shmob_drm_kms.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> index d354ab3077cecf94..713a7612244c647a 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> @@ -355,8 +355,8 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
>  
>  	format = shmob_drm_format_info(crtc->primary->fb->format->format);
>  	if (format == NULL) {
> -		dev_dbg(sdev->dev, "mode_set: unsupported format %08x\n",
> -			crtc->primary->fb->format->format);
> +		dev_dbg(sdev->dev, "mode_set: unsupported format %p4cc\n",
> +			&crtc->primary->fb->format->format);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
> index 60a2c8d8a0d947d2..3c5fe3bc183c7c13 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
> @@ -96,8 +96,8 @@ shmob_drm_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>  
>  	format = shmob_drm_format_info(mode_cmd->pixel_format);
>  	if (format == NULL) {
> -		dev_dbg(dev->dev, "unsupported pixel format %08x\n",
> -			mode_cmd->pixel_format);
> +		dev_dbg(dev->dev, "unsupported pixel format %p4cc\n",
> +			&mode_cmd->pixel_format);
>  		return ERR_PTR(-EINVAL);
>  	}
>  

-- 
Regards,

Laurent Pinchart
