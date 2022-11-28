Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1693A63A23C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiK1Hnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Hnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:43:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475232BF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:43:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1ECCA501;
        Mon, 28 Nov 2022 08:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669621416;
        bh=JKQPHHZZhD4m5jviZGkXGPGW3MyixyKT0ajEkDv2CwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFl87EvA7iIADwK67gz+MgxF7h/Wsng0UHQJnieoVmQlIcvuTAiuxDGgIjyfWR/JX
         +lNBQlwGuKt+fRrmXkWbGj+0jSQnKx9q4By9NIXlct1+9sXBuEFDMa7o4NWwGj3BLb
         INq51KxtmbbnQPtbh0Dukz1LFhCfEo/mb1XDY6hw=
Date:   Mon, 28 Nov 2022 09:43:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Qiqi Zhang <eddy.zhang@rock-chips.com>
Cc:     dianders@chromium.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
Message-ID: <Y4RmmXHDCxH09eJ+@pendragon.ideasonboard.com>
References: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Tomi to the CC list. Tomi, would you be able to test this ?

On Fri, Nov 25, 2022 at 06:45:58PM +0800, Qiqi Zhang wrote:
> According to the description in ti-sn65dsi86's datasheet:
> 
> CHA_HSYNC_POLARITY:
> 0 = Active High Pulse. Synchronization signal is high for the sync
> pulse width. (default)
> 1 = Active Low Pulse. Synchronization signal is low for the sync
> pulse width.
> 
> CHA_VSYNC_POLARITY:
> 0 = Active High Pulse. Synchronization signal is high for the sync
> pulse width. (Default)
> 1 = Active Low Pulse. Synchronization signal is low for the sync
> pulse width.
> 
> We should only set these bits when the polarity is negative.
> Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 3c3561942eb6..eb24322df721 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -931,9 +931,9 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
>  		&pdata->bridge.encoder->crtc->state->adjusted_mode;
>  	u8 hsync_polarity = 0, vsync_polarity = 0;
>  
> -	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>  		hsync_polarity = CHA_HSYNC_POLARITY;
> -	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
>  		vsync_polarity = CHA_VSYNC_POLARITY;
>  
>  	ti_sn65dsi86_write_u16(pdata, SN_CHA_ACTIVE_LINE_LENGTH_LOW_REG,

-- 
Regards,

Laurent Pinchart
