Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082063D129
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiK3I4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK3I4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:56:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C82D1C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:56:17 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A59955A;
        Wed, 30 Nov 2022 09:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669798576;
        bh=P+QWGX/RuFzHin2xHy5lZrSKi8lf7M6oOuqsIDQL71s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iinw8v1TZlf82C3F6KLpPTT4awQuoJ0TuhLJB+QL6FKLdSXFIxK1AAJfK1BulEGl9
         4Oi61qc1iN5g5eRa/GgwWr6uEHjK/fkZMgx8hl8VaNsyDSQsAmyE8qTqbePGTohuHA
         2rz7x3iKC9LrXNJzAZIqwcLgsnflmdmESBHqeoJY=
Message-ID: <58cff9e3-2488-5119-40ba-070ae930906d@ideasonboard.com>
Date:   Wed, 30 Nov 2022 10:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Fix issue with phy init
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com
References: <20221115083918.23192-1-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221115083918.23192-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/11/2022 10:39, Rahul T R wrote:
> Phy is not being initialized after suspend resume. Fix this by setting
> phy_initialized flag to false in suspend callback
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   drivers/gpu/drm/bridge/cdns-dsi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 20bece84ff8c..1a988f53424a 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -1187,6 +1187,7 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
>   	clk_disable_unprepare(dsi->dsi_p_clk);
>   	reset_control_assert(dsi->dsi_p_rst);
>   	dsi->link_initialized = false;
> +	dsi->phy_initialized = false;
>   	return 0;
>   }
>   

I'm not familiar with the IP, but the code related to enable/disable 
looks a bit odd.

Why does cdns_dsi_bridge_enable() do:
	cdns_dsi_hs_init(dsi);
	cdns_dsi_init_link(dsi);
but then in cdns_dsi_bridge_pre_enable():
	cdns_dsi_init_link(dsi);
	cdns_dsi_hs_init(dsi);

Doesn't the order matter? Why are the same functions called in both places?

cdns_dsi_hs_init() seems to do enabling, like locking the PLL. But 
there's no counterpart, hs_uninit(). I see cdns_dsi_bridge_disable() 
doing some clearing of the registers, so perhaps that's where the 
disabling happens. But cdns_dsi_hs_init() is called from the pre-enable, 
and post-disable doesn't do anything else but pm_runtime_put().

More or less the same comments apply to cdns_dsi_init_link(), but it's a 
bit worse as it's also called in cdns_dsi_transfer(), and then there's 
no uninit counterpart that I can see.

Well, maybe both functions are only doing configuration, not enabling 
this as such, and so it's fine to just turn off the IP without any 
uninit step. If that's the case, then probably this patch is fine.

  Tomi

