Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4C746E88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGDKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGDKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:25:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1843184;
        Tue,  4 Jul 2023 03:25:40 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79EC26606FA4;
        Tue,  4 Jul 2023 11:25:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688466339;
        bh=OK1hVnQx2+QUut5ekc5MMXkV5OBtCioWQbQvC+CYWOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AAvx7lsehf+CnXxI5/sKpl2B5gtl72kS9T7gr//4AF3eLhN9/q+jS4IaO3wUGZIId
         wAY67Qm+rGP4bAHSmoc8YiH4XNn3ZGQL1orgBhzNIf/C/UmQbAHlewEvgEgjQXH81G
         w1RXBoXgIcachDJ2kCxNjPFcFxV30FhwjDbDjbvj/Cqa6Qlp2DjDJxvPiLCOjUz1Yg
         6oTz+1M9Z5iftOxrUl6pk1y3I8YJykugGeuVy0zSQP3U18A87MUSvPJk5WI06+gh8U
         goqnrgntzicd0wfPgqinNDdDznm5Ib5x8gQfP/k00B5nL7SX4Ywvg+KBlxcb6pLdKP
         3dL7OYFfji1sA==
Message-ID: <59b1b17b-64f8-1f60-7206-4d0a03e4eecb@collabora.com>
Date:   Tue, 4 Jul 2023 12:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 3/8] soc: mediatek: pm-domains: Split bus_prot_mask
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
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-4-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230627131040.3418538-4-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/23 15:10, Markus Schneider-Pargmann ha scritto:
> bus_prot_mask is used for all operations, set clear and acknowledge. In
> preparation of m8365 power domain support split this one mask into two,
> one mask for set and clear, another one for acknowledge.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 24 ++++++++++++++----------
>   drivers/soc/mediatek/mtk-pm-domains.h | 14 ++++++++------
>   2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index aa9ab413479e..c801fa763e89 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -123,18 +123,20 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>   	int i, ret;
>   
>   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 val;
> +		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> +		u32 sta_mask = bpd[i].bus_prot_sta_mask;
>   
> -		if (!mask)
> +		if (!set_clr_mask)
>   			break;
>   
>   		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> +			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
>   		else
> -			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> +			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
>   
>   		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, (val & mask) == mask,
> +					       val, (val & sta_mask) == sta_mask,
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
>   			return ret;
> @@ -160,21 +162,23 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>   	int i, ret;
>   
>   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 val;
> +		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> +		u32 sta_mask = bpd[i].bus_prot_sta_mask;

Only one nitpick: val should be declared after the others....
That's just for readability and nothing else, obviously.

Anyway, after that change:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


