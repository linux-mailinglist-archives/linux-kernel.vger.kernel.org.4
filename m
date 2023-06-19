Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF46735063
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFSJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFSJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:33:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1491E7A;
        Mon, 19 Jun 2023 02:32:22 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28F3E6606E98;
        Mon, 19 Jun 2023 10:32:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687167140;
        bh=aNF1XWxWRzAVft7Ybg3OBBrUH7jcQWRNkcZlTCYXx7o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g6P65oyU4697HQLiasJoqjg2j/MBFI1onj9/4v11GfAyyQoe2avk6K/46pJbahk3s
         GEgCnlZf+fArK/wVzMmOgnzg+jX2wIf7F2xzzAO17K/w6TG0Gy0BYl24y/C5vE3u9u
         PG6Xymb97PAk9bRqn2wXu1DmX6uxKtHXW5US5L6Oyx+BQTS/+HADLvVCAGfRr81CnV
         zDpiuU0SDmJEkC6t75vC+AVD1eMMlgzhu2GQxCSlpIWvq9X/C7Y0xrV0eYmgvbmAIa
         RdY7WvcrEMEvU2ZH7l2WcQGDXD6G12UGnjdsu/cuxBJyWsh7hj+hfvl8AUOSzH6/Mn
         wdnhSlYeEB2Nw==
Message-ID: <3404135b-a893-523d-c776-3b6d10227049@collabora.com>
Date:   Mon, 19 Jun 2023 11:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/8] soc: mediatek: pm-domains: Move bools to a flags
 field
Content-Language: en-US
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
 <20230619085344.2885311-3-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230619085344.2885311-3-msp@baylibre.com>
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
> To simplify the macros, use a flags field for simple bools. This is in
> preparation for more flags.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c |  6 +++---
>   drivers/soc/mediatek/mtk-pm-domains.h | 19 +++++++++++--------
>   2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 354249cc1b12..aa9ab413479e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -128,7 +128,7 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>   		if (!mask)
>   			break;
>   
> -		if (bpd[i].bus_prot_reg_update)
> +		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
>   			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> @@ -165,12 +165,12 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>   		if (!mask)
>   			continue;
>   
> -		if (bpd[i].bus_prot_reg_update)
> +		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
>   			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>   
> -		if (bpd[i].ignore_clr_ack)
> +		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
>   			continue;
>   
>   		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 5ec53ee073c4..e26c8c317a6b 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -42,23 +42,27 @@
>   
>   #define SPM_MAX_BUS_PROT_DATA		6
>   
> -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
> +enum scpsys_bus_prot_flags {
> +	BUS_PROT_REG_UPDATE = BIT(1),
> +	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
> +};
> +
> +#define _BUS_PROT(_mask, _set, _clr, _sta, _flags) {		\
>   		.bus_prot_mask = (_mask),			\
>   		.bus_prot_set = _set,				\
>   		.bus_prot_clr = _clr,				\
>   		.bus_prot_sta = _sta,				\
> -		.bus_prot_reg_update = _update,			\
> -		.ignore_clr_ack = _ignore,			\
> +		.flags = _flags					\
>   	}
>   
>   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
> +		_BUS_PROT(_mask, _set, _clr, _sta, 0)
>   
>   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
> +		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_IGNORE_CLR_ACK)
>   
>   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
> +		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_REG_UPDATE)
>   
>   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>   		BUS_PROT_UPDATE(_mask,				\
> @@ -71,8 +75,7 @@ struct scpsys_bus_prot_data {
>   	u32 bus_prot_set;
>   	u32 bus_prot_clr;
>   	u32 bus_prot_sta;
> -	bool bus_prot_reg_update;
> -	bool ignore_clr_ack;
> +	u32 flags;

As far as I understand, we don't expect more than six bits to be populated as bus
protection flags, so we can save some memory by changing that to u8...

...after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo
