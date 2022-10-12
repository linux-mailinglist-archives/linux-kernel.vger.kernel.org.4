Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3CA5FC551
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJLMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJLM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:29:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DFAD76;
        Wed, 12 Oct 2022 05:29:45 -0700 (PDT)
Received: from [192.168.1.15] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42C864D3;
        Wed, 12 Oct 2022 14:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665577783;
        bh=FkBCv6pEvsGGQqHOfNJdbLxsNAfo7ByjcETs+0FV8AQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UdoUWbG1UZr3SiMqrKWoL+LkDVtWju/PBA7ZEx6RIh9BCdoUQ5qjH6zYl3/5Xp9Ke
         uZ9zryUClhATO4npOY8580r+g8fezLS68ldLmgrdSg0ZlDb5/k3H6k1EVuEKckzL7f
         TEBIJXgIKbZATPIGmH7WODzKRm8wl8elYGdaMx+w=
Message-ID: <708ae70e-dc1b-1079-8442-06cbea228e99@ideasonboard.com>
Date:   Wed, 12 Oct 2022 15:29:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v5 5/6] drm/tidss: Add IO CTRL and Power support for
 OLDI TX in am625
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220928175223.15225-1-a-bhatia1@ti.com>
 <20220928175223.15225-6-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220928175223.15225-6-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 20:52, Aradhya Bhatia wrote:
> The ctrl mmr module of the AM625 is different from the AM65X SoC. Thus
> the ctrl mmr registers that supported the OLDI TX power have become
> different in AM625 SoC.
> 
> Add IO CTRL support and control the OLDI TX power for AM625.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c      | 55 ++++++++++++++++++------
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h |  6 +++
>   2 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 88008ad39b55..68444e0cd8d7 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -921,21 +921,52 @@ int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
>   
>   static void dispc_oldi_tx_power(struct dispc_device *dispc, bool power)
>   {
> -	u32 val = power ? 0 : OLDI_PWRDN_TX;
> +	u32 val;
>   
>   	if (WARN_ON(!dispc->oldi_io_ctrl))
>   		return;
>   
> -	regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT0_IO_CTRL,
> -			   OLDI_PWRDN_TX, val);
> -	regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT1_IO_CTRL,
> -			   OLDI_PWRDN_TX, val);
> -	regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT2_IO_CTRL,
> -			   OLDI_PWRDN_TX, val);
> -	regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT3_IO_CTRL,
> -			   OLDI_PWRDN_TX, val);
> -	regmap_update_bits(dispc->oldi_io_ctrl, OLDI_CLK_IO_CTRL,
> -			   OLDI_PWRDN_TX, val);
> +	if (dispc->feat->subrev == DISPC_AM65X) {
> +		val = power ? 0 : OLDI_PWRDN_TX;
> +
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT0_IO_CTRL,
> +				   OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT1_IO_CTRL,
> +				   OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT2_IO_CTRL,
> +				   OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_DAT3_IO_CTRL,
> +				   OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_CLK_IO_CTRL,
> +				   OLDI_PWRDN_TX, val);
> +
> +	} else if (dispc->feat->subrev == DISPC_AM625) {
> +		if (power) {
> +			switch (dispc->oldi_mode) {
> +			case OLDI_SINGLE_LINK_SINGLE_MODE:
> +				/* Power down OLDI TX 1 */
> +				val = OLDI1_PWRDN_TX;
> +				break;
> +
> +			case OLDI_SINGLE_LINK_CLONE_MODE:
> +			case OLDI_DUAL_LINK_MODE:
> +				/* No Power down */
> +				val = 0;
> +				break;
> +
> +			default:
> +				/* Power down both the OLDI TXes */
> +				val = OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
> +				break;
> +			}
> +		} else {
> +			/* Power down both the OLDI TXes */
> +			val = OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
> +		}

Ugh, I hate power-down bits. So you "enable" it to disable it =). What's 
the default value or the register here? Or will this always be called? 
I.e. if we only use DPI, do we power down the OLDIs somewhere (or does 
it matter)?

> +
> +		regmap_update_bits(dispc->oldi_io_ctrl, OLDI_PD_CTRL,
> +				   OLDI0_PWRDN_TX | OLDI1_PWRDN_TX, val);
> +	}
>   }
>   
>   static void dispc_set_num_datalines(struct dispc_device *dispc,
> @@ -2831,7 +2862,7 @@ int dispc_init(struct tidss_device *tidss)
>   		dispc->vp_data[i].gamma_table = gamma_table;
>   	}
>   
> -	if (feat->subrev == DISPC_AM65X) {
> +	if (feat->subrev == DISPC_AM65X || feat->subrev == DISPC_AM625) {
>   		r = dispc_init_am65x_oldi_io_ctrl(dev, dispc);
>   		if (r)
>   			return r;
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 13feedfe5d6d..510bee70b3b8 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -238,6 +238,12 @@ enum dispc_common_regs {
>   #define OLDI_DAT3_IO_CTRL			0x0C
>   #define OLDI_CLK_IO_CTRL			0x10
>   
> +/* Only for AM625 OLDI TX */
> +#define OLDI_PD_CTRL				0x100
> +#define OLDI_LB_CTRL				0x104
> +
>   #define OLDI_PWRDN_TX				BIT(8)
> +#define OLDI0_PWRDN_TX				BIT(0)
> +#define OLDI1_PWRDN_TX				BIT(1)

Maybe these (the new and old ones) should be platform-prefixed. And 
organized so that the register and its bits are together.

  Tomi

