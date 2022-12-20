Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B2652138
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiLTNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiLTNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:04:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218BF167F9;
        Tue, 20 Dec 2022 05:04:17 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82A6056D;
        Tue, 20 Dec 2022 14:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671541456;
        bh=ZvxB9T70TZ+qvTHqWsyTCrDs0kOqGqkVtT2zxrsKU+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hfe8povylTwTJG50jVH0Tn86842ASz9JpSTsbusSKKZes9PP6XL5b5jd/sDohCNTq
         vyb1DV8if6dwIrMQ37CmKoPNnxvP2rjgWz59tfsW8UG/PgasyHhqBQvWWwB1FG+N57
         FjRtiEzmfPSgLw0YXs9+kWhWajNsiJo2fq6HYRA4=
Message-ID: <84977593-4671-7582-d5f2-cf69755f1145@ideasonboard.com>
Date:   Tue, 20 Dec 2022 15:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 5/5] drm/tidss: Enable Dual and Duplicate Modes for
 OLDI
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20221119173019.15643-1-a-bhatia1@ti.com>
 <20221119173019.15643-6-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221119173019.15643-6-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 19:30, Aradhya Bhatia wrote:
> The AM625 DSS IP contains 2 OLDI TXes which can work together to enable 2
> cloned displays of or even a single dual-link display with higher
> resolutions like WUXGA (1920x1200@60fps) with a reduced OLDI clock
> frequency.
> 
> Configure the necessary register to enable and disable the OLDI TXes
> with required modes configurations.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index f26129fb1d8f..cf43de6216a5 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1012,8 +1012,8 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
>   	int count = 0;
>   
>   	/*
> -	 * For the moment DUALMODESYNC, MASTERSLAVE, MODE, and SRC
> -	 * bits of DISPC_VP_DSS_OLDI_CFG are set statically to 0.
> +	 * For the moment MASTERSLAVE, and SRC bits of DISPC_VP_DSS_OLDI_CFG are
> +	 * always set to 0.
>   	 */
>   
>   	if (fmt->data_width == 24)
> @@ -1030,6 +1030,26 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
>   
>   	oldi_cfg |= BIT(0); /* ENABLE */
>   
> +	switch (dispc->oldi_mode) {
> +	case OLDI_SINGLE_LINK_SINGLE_MODE:
> +		/* All configuration is done for this mode.  */
> +		break;
> +
> +	case OLDI_SINGLE_LINK_CLONE_MODE:
> +		oldi_cfg |= BIT(5); /* CLONE MODE */
> +		break;
> +
> +	case OLDI_DUAL_LINK_MODE:
> +		oldi_cfg |= BIT(11); /* DUALMODESYNC */
> +		oldi_cfg |= BIT(3); /* data-mapping field also indicates dual-link mode */
> +		break;
> +
> +	default:
> +		dev_warn(dispc->dev, "%s: Incorrect oldi mode. Returning.\n",
> +			 __func__);
> +		return;
> +	}
> +
>   	dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
>   
>   	while (!(oldi_reset_bit & dispc_read(dispc, DSS_SYSSTATUS)) &&

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

