Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568E9734F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFSJWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFSJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:22:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A783;
        Mon, 19 Jun 2023 02:22:23 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 496AA6606E98;
        Mon, 19 Jun 2023 10:22:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687166541;
        bh=zLjRj3WSaKuGlgYqMVIfTgOq1QN75uhZ6wvkJa/Q7Qs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJOMen5BsHbC1Ttsc7jEs0Hcu1i6qj94S7y7pJ6V/tj/7koAow+7kEuCE9xnuIEvq
         frMhvKMaAfm7Kyew0p0Ghl9uSsmn39uVyOPMzs2znWeD4l8brOIz4OU3Y4oJzerrF/
         GX1BfXBcTuhn49WHCVuprl095Uw0rsoa7HwkTeBlEHjNmAFFYMWTIGI81vsoknrkXo
         46S6B/19DFTecx09ZIDraL3G1Oc8xkG5lSunSw/+/f1B8j2Ub8ZFa+zVCgAhktDEY4
         clwIWzODessFWR8689aBf1wExPsiFf89HBi2Bjab3Pgl6vvyuoP5SHQof3uNIb1PBU
         1Xal7SVVMpy5g==
Message-ID: <b53d201d-6906-12f4-2f72-506fb742c585@collabora.com>
Date:   Mon, 19 Jun 2023 11:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 5/8] soc: mediatek: pm-domains: Unify configuration for
 infracfg and smi
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230619085344.2885311-1-msp@baylibre.com>
 <20230619085344.2885311-6-msp@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230619085344.2885311-6-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/06/23 10:53, Markus Schneider-Pargmann ha scritto:
> Use flags to distinguish between infracfg and smi subsystem for a bus
> protection configuration. It simplifies enabling/disabling and prepares
> the driver for the use of another regmap for mt8365.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mt6795-pm-domains.h |  16 +-
>   drivers/soc/mediatek/mt8167-pm-domains.h |  20 +-
>   drivers/soc/mediatek/mt8173-pm-domains.h |  16 +-
>   drivers/soc/mediatek/mt8183-pm-domains.h | 198 ++++-----
>   drivers/soc/mediatek/mt8186-pm-domains.h | 212 +++++-----
>   drivers/soc/mediatek/mt8188-pm-domains.h | 518 +++++++++++------------
>   drivers/soc/mediatek/mt8192-pm-domains.h | 262 ++++++------
>   drivers/soc/mediatek/mt8195-pm-domains.h | 464 ++++++++++----------
>   drivers/soc/mediatek/mtk-pm-domains.c    |  64 ++-
>   drivers/soc/mediatek/mtk-pm-domains.h    |  37 +-
>   10 files changed, 908 insertions(+), 899 deletions(-)
> 

..snip..

> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 4b6ae56e7c95..356788263db2 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -45,6 +45,8 @@
>   enum scpsys_bus_prot_flags {
>   	BUS_PROT_REG_UPDATE = BIT(1),
>   	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
> +	BUS_PROT_COMPONENT_INFRA = BIT(3),
> +	BUS_PROT_COMPONENT_SMI = BIT(4),
>   };
>   
>   #define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
> @@ -56,17 +58,30 @@ enum scpsys_bus_prot_flags {
>   		.flags = _flags					\
>   	}
>   
> -#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, 0)
> +#define BUS_PROT_INFRA_WR(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_INFRA)
>   

What about doing that like

#define BUS_PROT_WR(_hwip, _mask, _set, _clr, _sta)
	_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_##_hwip)

...so that instead of defining BUS_PROT_INFRA_WR, BUS_PROT_SMI_WR and
BUS_PROT_ANOTHERIP_WR, we keep just one macro?

That'd be then like:

	.bp_cfg = {
		BUS_PROT_WR(INFRA, MT8183_TOP_AXI_PROT_EN_1_DISP,
			    MT8183_TOP_AXI_PROT_EN_....
			    ....),
		BUS_PROT_WR(SMI, MT8183_SMI_COMMON_SMI_CLAMP_DISP,
			    .....),
	}

IMO, that's cleaner, less lines of code and more flexible for eventual
future new variations of that.

Cheers,
Angelo

> -#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_IGNORE_CLR_ACK)
> +#define BUS_PROT_INFRA_WR_IGN(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> +			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_IGNORE_CLR_ACK)
>   
> -#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_REG_UPDATE)
> +#define BUS_PROT_INFRA_UPDATE(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> +			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_REG_UPDATE)
>   
> -#define BUS_PROT_UPDATE_TOPAXI(_mask)				\
> -		BUS_PROT_UPDATE(_mask,				\
> +#define BUS_PROT_SMI_WR(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_SMI)
> +
> +#define BUS_PROT_SMI_WR_IGN(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> +			  BUS_PROT_COMPONENT_SMI | BUS_PROT_IGNORE_CLR_ACK)
> +
> +#define BUS_PROT_SMI_UPDATE(_mask, _set, _clr, _sta) \
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> +			  BUS_PROT_COMPONENT_SMI | BUS_PROT_REG_UPDATE)
> +
> +#define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)				\
> +		BUS_PROT_INFRA_UPDATE(_mask,				\
>   				INFRA_TOPAXI_PROTECTEN,		\
>   				INFRA_TOPAXI_PROTECTEN,		\
>   				INFRA_TOPAXI_PROTECTSTA1)
> @@ -90,8 +105,7 @@ struct scpsys_bus_prot_data {
>    * @ext_buck_iso_offs: The offset for external buck isolation
>    * @ext_buck_iso_mask: The mask for external buck isolation
>    * @caps: The flag for active wake-up action.
> - * @bp_infracfg: bus protection for infracfg subsystem
> - * @bp_smi: bus protection for smi subsystem
> + * @bp_cfg: bus protection configuration for any subsystem
>    */
>   struct scpsys_domain_data {
>   	const char *name;
> @@ -102,8 +116,7 @@ struct scpsys_domain_data {
>   	int ext_buck_iso_offs;
>   	u32 ext_buck_iso_mask;
>   	u8 caps;
> -	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
> -	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
> +	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
>   	int pwr_sta_offs;
>   	int pwr_sta2nd_offs;
>   };

