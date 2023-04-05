Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5A6D72B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjDED22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjDED2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:28:24 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9751213D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:28:22 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 71B2084D0F;
        Wed,  5 Apr 2023 05:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680665298;
        bh=bKaTZMpFYkkLbnTYZecYxf3MB9y5kfCDupMMfLfXpec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SRSFRYw+B7BCKAMQGuNszmJfxCKUw8xpESwBLDobDLGggNqSijncjsjAC84Crjpgo
         w8rtVnifU14r/xmjMfM2b8lcJGzXhfkWI3uZbC7CADQ1fKig5u7dWDL70+aXz/63pE
         4548q2niUkmSsy+Y7LoFYz35mAhwc7dzPIoo2WhIaqTz+XrTGQhq5QDhuQdEh0Kh2a
         +T2/4kFpQAD+ogPw6cxm2HXr/ukyd8Nw4FUIdVxcWhkhUTFgyD78M4axcmBLYOXsV7
         Hajdoqo39t8uzXr7UYrXKbrLl5weRrKvp3ykTGEQYPOYLRxAwnkwdG5hZRm0l9IA+m
         LUSSOWPTe4f4g==
Message-ID: <5b514970-cfc8-41de-7ae6-f608f5187860@denx.de>
Date:   Wed, 5 Apr 2023 05:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm: bridge: ldb: add support for using channel 1 only
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230404073720.1465552-1-luca.ceresoli@bootlin.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230404073720.1465552-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 09:37, Luca Ceresoli wrote:

[...]

> @@ -177,28 +183,25 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>   	clk_prepare_enable(fsl_ldb->clk);
>   
>   	/* Program LDB_CTRL */
> -	reg = LDB_CTRL_CH0_ENABLE;
> -
> -	if (fsl_ldb->lvds_dual_link)
> -		reg |= LDB_CTRL_CH1_ENABLE | LDB_CTRL_SPLIT_MODE;
> -
> -	if (lvds_format_24bpp) {
> -		reg |= LDB_CTRL_CH0_DATA_WIDTH;
> -		if (fsl_ldb->lvds_dual_link)
> -			reg |= LDB_CTRL_CH1_DATA_WIDTH;
> -	}
> -
> -	if (lvds_format_jeida) {
> -		reg |= LDB_CTRL_CH0_BIT_MAPPING;
> -		if (fsl_ldb->lvds_dual_link)
> -			reg |= LDB_CTRL_CH1_BIT_MAPPING;
> -	}
> -
> -	if (mode->flags & DRM_MODE_FLAG_PVSYNC) {
> -		reg |= LDB_CTRL_DI0_VSYNC_POLARITY;
> -		if (fsl_ldb->lvds_dual_link)
> -			reg |= LDB_CTRL_DI1_VSYNC_POLARITY;
> -	}
> +	reg =

Cosmetic nit, do we need the newline here , can't we just move the first 
'(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_ENABLE : 0) |' on the same line as 
'reg =' ? It might need a bit of indent with spaces, but that should be OK.

> +		(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_ENABLE : 0) |
> +		(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_ENABLE : 0) |
> +		(fsl_ldb_is_dual(fsl_ldb) ? LDB_CTRL_SPLIT_MODE : 0);
> +
> +	if (lvds_format_24bpp)
> +		reg |=
> +			(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_DATA_WIDTH : 0) |
> +			(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_DATA_WIDTH : 0);
> +
> +	if (lvds_format_jeida)
> +		reg |=
> +			(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_BIT_MAPPING : 0) |
> +			(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_BIT_MAPPING : 0);
> +
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +		reg |=
> +			(fsl_ldb->ch0_enabled ? LDB_CTRL_DI0_VSYNC_POLARITY : 0) |
> +			(fsl_ldb->ch1_enabled ? LDB_CTRL_DI1_VSYNC_POLARITY : 0);
>   
>   	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->ldb_ctrl, reg);

[...]

> @@ -311,10 +314,23 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>   	if (IS_ERR(fsl_ldb->regmap))
>   		return PTR_ERR(fsl_ldb->regmap);
>   
> -	/* Locate the panel DT node. */
> -	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);
> -	if (!panel_node)
> -		return -ENXIO;
> +	/* Locate the remote ports and the panel node */
> +	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
> +	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
> +	fsl_ldb->ch0_enabled = (remote1 != NULL);
> +	fsl_ldb->ch1_enabled = (remote2 != NULL);
> +	panel_node = of_node_get(remote1 ? remote1 : remote2);

You can even do this without the middle 'remote1' I think:

panel_node = of_node_get(remote1 ? : remote2);

> +	of_node_put(remote1);
> +	of_node_put(remote2);
> +
> +	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> +		of_node_put(panel_node);
> +		return dev_err_probe(dev, -ENXIO, "No panel node found");
> +	}
> +
> +	dev_dbg(dev, "Using %s\n",
> +		fsl_ldb_is_dual(fsl_ldb) ? "dual mode" :

I think this is called "dual-link mode" , maybe update the string .

> +		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
>   
>   	panel = of_drm_find_panel(panel_node);
>   	of_node_put(panel_node);
> @@ -325,20 +341,26 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>   	if (IS_ERR(fsl_ldb->panel_bridge))
>   		return PTR_ERR(fsl_ldb->panel_bridge);
>   
> -	/* Determine whether this is dual-link configuration */
> -	port1 = of_graph_get_port_by_id(dev->of_node, 1);
> -	port2 = of_graph_get_port_by_id(dev->of_node, 2);
> -	dual_link = drm_of_lvds_get_dual_link_pixel_order(port1, port2);
> -	of_node_put(port1);
> -	of_node_put(port2);
>   
> -	if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
> -		dev_err(dev, "LVDS channel pixel swap not supported.\n");
> -		return -EINVAL;
> -	}
> +	if (fsl_ldb_is_dual(fsl_ldb)) {
> +		struct device_node *port1, *port2;
> +
> +		port1 = of_graph_get_port_by_id(dev->of_node, 1);
> +		port2 = of_graph_get_port_by_id(dev->of_node, 2);
> +		dual_link = drm_of_lvds_get_dual_link_pixel_order(port1, port2);
> +		of_node_put(port1);
> +		of_node_put(port2);
>   
> -	if (dual_link == DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS)
> -		fsl_ldb->lvds_dual_link = true;
> +		if (dual_link < 0)
> +			return dev_err_probe(dev, dual_link,
> +					     "Error getting dual link configuration");

Does this need a trailing '\n' in the formatting string or not ? I think 
yes.

The rest looks good, with the few details fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
