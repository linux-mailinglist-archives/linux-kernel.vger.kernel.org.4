Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E056FBCF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjEICOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjEICOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:14:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABC9EE1;
        Mon,  8 May 2023 19:14:08 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6682385FD2;
        Tue,  9 May 2023 04:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683598446;
        bh=Ji2HhlHFfCXY74FqMvczOZ+BR43BKRG9fT3pCghkDOc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UXvkBSM7YUZrBsk3SPuAJ54ycJwY/CoXwC5HR4ZqFMNbkndwzGlW+1qC7TkjUJtup
         1ND/b9iAlZsSdqnShsm2ndKVgANyB6Ua66mwWq4W5pgfxyVEV+KQDtKYFYfH2WukPr
         /RvlF9A/TMhUVLofvdmWKphePRZm86BXC+dn2hVnEMdmFz0kGovJd0hG2jdt7SUF+t
         M7KSwldGXKDzgxhbpTNZfb4ASgxiMNKY0bHWCMQ08qS/KAiRYBF7XduOEoNNgaErYs
         Qz70fW70rkcTNIsPc0PpfFod6d/izuaSlRdyLfhP45MgGI5k4j01a8FvEbeEJi9YYI
         f6D+sZW4prluw==
Message-ID: <05b44685-d6a7-5f6e-0f55-04c96e94a9e1@denx.de>
Date:   Tue, 9 May 2023 02:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/6] drm: lcdif: Drop unnecessary NULL pointer check on
 lcdif->bridge
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
References: <20230508055740.635256-1-victor.liu@nxp.com>
 <20230508055740.635256-3-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230508055740.635256-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 07:57, Liu Ying wrote:

Hi,

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index 262bc43b1079..e54200a9fcb9 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -394,7 +394,7 @@ static void lcdif_crtc_mode_set_nofb(struct lcdif_drm_private *lcdif,
>   	struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
>   	u32 bus_flags = 0;
>   
> -	if (lcdif->bridge && lcdif->bridge->timings)
> +	if (lcdif->bridge->timings)
>   		bus_flags = lcdif->bridge->timings->input_bus_flags;
>   	else if (bridge_state)
>   		bus_flags = bridge_state->input_bus_cfg.flags;
> @@ -463,30 +463,21 @@ static void lcdif_crtc_atomic_enable(struct drm_crtc *crtc,
>   	struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
>   	struct drm_bridge_state *bridge_state = NULL;
>   	struct drm_device *drm = lcdif->drm;
> -	u32 bus_format = 0;
> +	u32 bus_format;
>   	dma_addr_t paddr;
>   
> -	/* If there is a bridge attached to the LCDIF, use its bus format */
> -	if (lcdif->bridge) {
> -		bridge_state =
> -			drm_atomic_get_new_bridge_state(state,
> -							lcdif->bridge);
> -		if (!bridge_state)
> -			bus_format = MEDIA_BUS_FMT_FIXED;
> -		else
> -			bus_format = bridge_state->input_bus_cfg.format;
> -
> -		if (bus_format == MEDIA_BUS_FMT_FIXED) {
> -			dev_warn_once(drm->dev,
> -				      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
> -				      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
> -			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> -		}
> -	}
> +	bridge_state = drm_atomic_get_new_bridge_state(state, lcdif->bridge);
> +	if (!bridge_state)
> +		bus_format = MEDIA_BUS_FMT_FIXED;
> +	else
> +		bus_format = bridge_state->input_bus_cfg.format;

The code below seems to change the logic slightly.

Could it happen that:
- bridge_state is valid (i.e. non-NULL)
- bridge_state->input_bus_cfg.format is set to 0 (i.e. not set) ?
   (note that MEDIA_BUS_FMT_FIXED is defined as 0x0001)

> -	/* If all else fails, default to RGB888_1X24 */
> -	if (!bus_format)
> +	if (bus_format == MEDIA_BUS_FMT_FIXED) {
> +		dev_warn_once(drm->dev,
> +			      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
> +			      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
>   		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +	}
>   
>   	clk_set_rate(lcdif->clk, m->crtc_clock * 1000);

[...]
