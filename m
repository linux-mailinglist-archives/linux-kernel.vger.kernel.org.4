Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD8689E32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjBCPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBCPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:25:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57047082;
        Fri,  3 Feb 2023 07:24:43 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3331B890;
        Fri,  3 Feb 2023 16:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675437566;
        bh=vO1iP+NF+Oi0VA4WkYdcl/j2+EiaN4yWypeyWE4iz+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bP4N54/N8NOyPrgESAcbg+KcHKMGWtaGa+Hn9u2XJUypS8Z6SH/EYQXaJfe1WzmBU
         lO5gMOMbc5X4a4sQrK9eidhTf6dygr4UsGutcZwHFgkMD1EjYcyEbl1wCKI+J82LiR
         CyLYBh36ZvcRWAeyKq4Y5/bF+NMLSBT8fReB9Tro=
Message-ID: <0dc36f3c-22c8-7440-96a6-7d3ad96daf40@ideasonboard.com>
Date:   Fri, 3 Feb 2023 17:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/6] drm/tidss: Add IO CTRL and Power support for OLDI
 TX in am625
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
 <20230125113529.13952-6-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230125113529.13952-6-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 13:35, Aradhya Bhatia wrote:
> The ctrl mmr module of the AM625 is different from the AM65X SoC. Thus
> the ctrl mmr registers that supported the OLDI TX power have become
> different in AM625 SoC.
> 
> The common mode voltage of the LVDS buffers becomes random when the
> bandgap reference is turned off. This causes uncertainity in the LVDS
> Data and Clock signal outputs, making it behave differently under
> different conditions and panel setups. The bandgap reference must be
> powered on before using the OLDI IOs, to keep the common voltage trimmed
> down to desired levels.
> 
> Add support to enable/disable OLDI IO signals as well as the bandgap
> reference circuit for the LVDS signals.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> 
> Note:
> - Dropped Tomi Valkeinen's reviewed-by tag in this patch because I did
>    not implement one of his comments which suggested to remove the
>    'oldi_supported' variable. While the oldi support is indeed based on
>    SoC variations, keeping that variable helps take into account the case
>    where an OLDI supporting SoC by-passes OLDI TXes and gives out DPI
>    video signals straight from DSS.

Hmm why is that relevent for this patch? It doesn't use oldi_supported 
or the new has_oldi.

>   drivers/gpu/drm/tidss/tidss_dispc.c      | 57 +++++++++++++++++++-----
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h | 40 ++++++++++++-----
>   2 files changed, 76 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 37a73e309330..0e03557bc142 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -934,21 +934,56 @@ int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
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

Slight nitpick, but I think switch-case makes sense for the subrev. Even 
if there are just two options here, using switch makes the structure 
clearer.

> +		val = power ? 0 : AM65X_OLDI_PWRDN_TX;
> +
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM65X_OLDI_DAT0_IO_CTRL,
> +				   AM65X_OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM65X_OLDI_DAT1_IO_CTRL,
> +				   AM65X_OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM65X_OLDI_DAT2_IO_CTRL,
> +				   AM65X_OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM65X_OLDI_DAT3_IO_CTRL,
> +				   AM65X_OLDI_PWRDN_TX, val);
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM65X_OLDI_CLK_IO_CTRL,
> +				   AM65X_OLDI_PWRDN_TX, val);
> +
> +	} else if (dispc->feat->subrev == DISPC_AM625) {
> +		if (power) {
> +			switch (dispc->oldi_mode) {
> +			case OLDI_MODE_SINGLE_LINK:
> +				/* Power down OLDI TX 1 */
> +				val = AM625_OLDI1_PWRDN_TX;
> +				break;
> +
> +			case OLDI_MODE_CLONE_SINGLE_LINK:
> +			case OLDI_MODE_DUAL_LINK:
> +				/* No Power down */
> +				val = 0;
> +				break;
> +
> +			default:
> +				/* Power down both OLDI TXes and LVDS Bandgap */
> +				val = AM625_OLDI0_PWRDN_TX | AM625_OLDI1_PWRDN_TX |
> +				      AM625_OLDI_PWRDN_BG;
> +				break;
> +			}
> +
> +		} else {
> +			/* Power down both OLDI TXes and LVDS Bandgap */
> +			val = AM625_OLDI0_PWRDN_TX | AM625_OLDI1_PWRDN_TX |
> +			      AM625_OLDI_PWRDN_BG;
> +		}
> +
> +		regmap_update_bits(dispc->oldi_io_ctrl, AM625_OLDI_PD_CTRL,
> +				   AM625_OLDI0_PWRDN_TX | AM625_OLDI1_PWRDN_TX |
> +				   AM625_OLDI_PWRDN_BG, val);
> +	}
>   }
>   
>   static void dispc_set_num_datalines(struct dispc_device *dispc,
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 13feedfe5d6d..b2a148e96022 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -227,17 +227,37 @@ enum dispc_common_regs {
>   #define DISPC_VP_DSS_DMA_THREADSIZE_STATUS	0x174 /* J721E */
>   
>   /*
> - * OLDI IO_CTRL register offsets. On AM654 the registers are found
> - * from CTRL_MMR0, there the syscon regmap should map 0x14 bytes from
> - * CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
> - * register range.
> + * OLDI IO and PD CTRL register offsets.
> + * These registers are found in the CTRL_MMR0, where the syscon regmap should map
> + *
> + * 1. 0x14 bytes from CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
> + * register range for the AM65X DSS, and
> + *
> + * 2. 0x200 bytes from OLDI0_DAT0_IO_CTRL to OLDI_LB_CTRL register range for the
> + * AM625 DSS.
>    */
> -#define OLDI_DAT0_IO_CTRL			0x00
> -#define OLDI_DAT1_IO_CTRL			0x04
> -#define OLDI_DAT2_IO_CTRL			0x08
> -#define OLDI_DAT3_IO_CTRL			0x0C
> -#define OLDI_CLK_IO_CTRL			0x10
>   
> -#define OLDI_PWRDN_TX				BIT(8)
> +/* -- For AM65X OLDI TX -- */
> +/* Register offsets */
> +#define AM65X_OLDI_DAT0_IO_CTRL			0x00
> +#define AM65X_OLDI_DAT1_IO_CTRL			0x04
> +#define AM65X_OLDI_DAT2_IO_CTRL			0x08
> +#define AM65X_OLDI_DAT3_IO_CTRL			0x0C
> +#define AM65X_OLDI_CLK_IO_CTRL			0x10
> +
> +/* Power control bits */
> +#define AM65X_OLDI_PWRDN_TX			BIT(8)
> +
> +/* -- For AM625 OLDI TX -- */
> +/* Register offsets */
> +#define AM625_OLDI_PD_CTRL			0x100
> +#define AM625_OLDI_LB_CTRL			0x104
> +
> +/* Power control bits */
> +#define AM625_OLDI0_PWRDN_TX			BIT(0)
> +#define AM625_OLDI1_PWRDN_TX			BIT(1)
> +
> +/* LVDS Bandgap reference Enable/Disable */
> +#define AM625_OLDI_PWRDN_BG			BIT(8)
>   
>   #endif /* __TIDSS_DISPC_REGS_H */

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

