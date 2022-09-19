Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418755BC9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiISKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiISKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495A1EC5D;
        Mon, 19 Sep 2022 03:48:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 901AF9BA;
        Mon, 19 Sep 2022 12:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663584480;
        bh=xH0dFiynDBJvh38igkGQg8mcP/tEn+0QLkv2GwKrsOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GupHLLKhCmbowLKu/2rLAgH7lrPdvGzpo35NxtGV9CdLZPskAShPnBT+xorPQQlyt
         Szd0tRsLRRn6/P1/QlzxwhOCBeS5bVAHkIDvpnM4zDdiO/OdyKXsNPkjNiI3kg40pG
         e04YRB1vTZt4eRVIeZza44+kUH+Q4xd4SRDc+rqE=
Date:   Mon, 19 Sep 2022 13:47:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "drm/bridge: chrontel-ch7033: Add byteswap
 order setting"
Message-ID: <YyhI0/aG97cCB8DB@pendragon.ideasonboard.com>
References: <20220919102009.150503-1-robert.foss@linaro.org>
 <20220919102009.150503-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919102009.150503-3-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Sep 19, 2022 at 12:20:09PM +0200, Robert Foss wrote:
> Revert this patch since it depends on devicetree functionality that
> previously has been reverted in the below commit.
> 
> commit e798ba3374a1 ("Revert "dt-bindings: Add byteswap order to chrontel ch7033"")
> 
> This reverts commit ce9564cfc9aea65e68eb343c599317633bc2321a.
> 
> Fixes: 8c9c40ec8344 ("Revert "drm/bridge: ti-sn65dsi86: Implement bridge connector operations for DP"")

I'm not sure this Fixes tag is meaningful here. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/bridge/chrontel-ch7033.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> index c5719908ce2d..ba060277c3fd 100644
> --- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
> +++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> @@ -68,7 +68,6 @@ enum {
>  	BYTE_SWAP_GBR	= 3,
>  	BYTE_SWAP_BRG	= 4,
>  	BYTE_SWAP_BGR	= 5,
> -	BYTE_SWAP_MAX	= 6,
>  };
>  
>  /* Page 0, Register 0x19 */
> @@ -356,8 +355,6 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
>  	int hsynclen = mode->hsync_end - mode->hsync_start;
>  	int vbporch = mode->vsync_start - mode->vdisplay;
>  	int vsynclen = mode->vsync_end - mode->vsync_start;
> -	u8 byte_swap;
> -	int ret;
>  
>  	/*
>  	 * Page 4
> @@ -401,16 +398,8 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
>  	regmap_write(priv->regmap, 0x15, vbporch);
>  	regmap_write(priv->regmap, 0x16, vsynclen);
>  
> -	/* Input color swap. Byte order is optional and will default to
> -	 * BYTE_SWAP_BGR to preserve backwards compatibility with existing
> -	 * driver.
> -	 */
> -	ret = of_property_read_u8(priv->bridge.of_node, "chrontel,byteswap",
> -				  &byte_swap);
> -	if (!ret && byte_swap < BYTE_SWAP_MAX)
> -		regmap_update_bits(priv->regmap, 0x18, SWAP, byte_swap);
> -	else
> -		regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
> +	/* Input color swap. */
> +	regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
>  
>  	/* Input clock and sync polarity. */
>  	regmap_update_bits(priv->regmap, 0x19, 0x1, mode->clock >> 16);

-- 
Regards,

Laurent Pinchart
