Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DA5F42C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJDMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJDMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:15:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C014205D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:15:46 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 93F2A84C46;
        Tue,  4 Oct 2022 14:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664885744;
        bh=kLElnWcLVzkRAI4byMC1AbvFJpSiN4dUlaF+2MNRz0s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PBnj5S/SPelGWBXLQgsAsRMAHJqg3a2V5xNi5xozDoMZCK3NHFS9WhAHBkKKBMVkF
         jrdHcn23KFdiBW1t36tv0rbLQR2ZhClZKrHKZ/Zv5Yc3Sc7tHG5b+rKDrFapsfd2gO
         mrbqA2bqwNduzDGH0PQE+bHmTm+JBAgFj9Cab2jmlcGrpoEelo4bPHV7KoTml9nade
         zTLJntTu33uigROjx9ONfe5ViLHADqxeQWAEtvdmkOyRD6po8CH5Q8jcf2ke10i12r
         QB3/u5JZ7UBqnO4EQvSYGqgp42EQRfkmx64rte1Y5m5173FBdV9ioXhi6Rj3qyXUMA
         3d27KR5SIbGfA==
Message-ID: <28a468ec-615a-9a9a-109e-cae21aef317e@denx.de>
Date:   Tue, 4 Oct 2022 14:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 1/1] drm/bridge: ti-sn65dsi83: Remove burst mode
Content-Language: en-US
To:     estl@gmx.net, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        linux-kernel@vger.kernel.org
References: <20221004115710.1553357-1-estl@gmx.net>
 <20221004115710.1553357-2-estl@gmx.net>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221004115710.1553357-2-estl@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 13:57, estl@gmx.net wrote:
> From: Eberhard Stoll <eberhard.stoll@kontron.de>
> 
> Remove LVDS panel overclocking for some configurations by disabling
> burst mode for this chip
> 
> With burst mode enabled, some DSI controllers increase their DSI lane
> clock beyond the clock which is needed to transfer all pixel data.
> 
> But this driver operates with a pixel clock derived from the DSI lane
> clock by a fixed prescaler. So, every increase of the DSI clock also
> increases the LVDS pixel clock. In this case, the LVDS pixel clock is
> overclocked.
> 
> This is the case e.g. for synopsys stm DSI bridge
> (drm/stm/dw_mipi_dsi-stm.c). With burst mode the DSI clock is
> increased by 20% and therefore also for the LVDS panel.
> 
> Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index c901c0e1a3b0..ffc39208536e 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -272,7 +272,7 @@ static int sn65dsi83_attach(struct drm_bridge *bridge,
> 
>   	dsi->lanes = ctx->dsi_lanes;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
> 
>   	ret = mipi_dsi_attach(dsi);
>   	if (ret < 0) {

The burst mode is the most efficient mode, so please keep it. This patch 
is the wrong approach.

The problem with DSI HS clock is known and long standing, I tried to 
solve it twice, but neither solution made it in. It is probably a good 
idea to read through the suggestions and try to follow the latest one by 
negotiating the link clock via bridge state:

https://lore.kernel.org/dri-devel/20220801131113.182487-1-marex@denx.de/
https://lore.kernel.org/all/20220219002844.362157-1-marex@denx.de/
