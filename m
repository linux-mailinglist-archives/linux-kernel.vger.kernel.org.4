Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10282690944
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBIMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBIMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:49:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27595EA03;
        Thu,  9 Feb 2023 04:48:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B58DE66020C1;
        Thu,  9 Feb 2023 12:48:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675946938;
        bh=WIeAtzp/L0JbuRqFiBgonx+z+AnLyNZgpaAp7pibERE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JW2RNBxz7CoiZuLvoGyrMCcIEQV0ybAtjZQSn6JgNbhoS5FUKoiSoe4nhhP0S27dz
         0EU6s0JDCImnCpox9hqLOsXR1sJunGIbnDiD0QiBIY++rVOXlxinYdkiOW2TcZJL3T
         0kduMSYiHv+9BVQPj31es1bOLypbx27GBdQZ2i3M1jh903LuM1iir0GlsjgrRl3c3b
         mQ0g8Qs0eaPNrwQabXcYucwPLNB5j8KGqvA+4nheccQBj4+e0S/vb1jCYL1pRTTwkL
         JLgd/KuJ2V6TViNkYe5BrTAfaUUA3tFpLW3A/Yh/JxNbI0GrhQOIy8jsL6wFfTx5yv
         DxFgqzCqX3//A==
Message-ID: <5c677b40-7bbd-5d69-9f9b-4879c8aeddf8@collabora.com>
Date:   Thu, 9 Feb 2023 13:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 10/12] remoteproc: mediatek: Handle MT8195 SCP core 1
 watchdog timeout
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230209074021.13936-1-tinghan.shen@mediatek.com>
 <20230209074021.13936-11-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209074021.13936-11-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 08:40, Tinghan Shen ha scritto:
> The MT8195 SCP core 1 watchdog timeout needs to be handled in the
> SCP core 0 IRQ handler because the MT8195 SCP core 1 watchdog timeout
> IRQ is wired on the same IRQ entry for core 0 watchdog timeout.
> MT8195 SCP has a watchdog status register to identify the watchdog
> timeout source when IRQ triggered.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |  4 ++++
>   drivers/remoteproc/mtk_scp.c    | 24 +++++++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index e4ef97f2d3a1..ca2395b98d27 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -55,6 +55,10 @@
>   #define MT8192_CORE0_WDT_IRQ		0x10030
>   #define MT8192_CORE0_WDT_CFG		0x10034
>   
> +#define MT8195_SYS_STATUS		0x4004
> +#define MT8195_CORE0_WDT		BIT(16)
> +#define MT8195_CORE1_WDT		BIT(17)
> +
>   #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
>   
>   #define MT8195_CPU1_SRAM_PD			0x1084
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index cfcb719ba50b..9fbbc4751433 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -222,6 +222,28 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
>   	}
>   }
>   
> +static void mt8195_scp_irq_handler(struct mtk_scp *scp)

Looking at the C1 interrupt handler, I don't see any WDT timeout handling, hence
a question naturally arises:

Would it ever be possible for *both* CORE0 and CORE1 WDT timeout to happen
at the same time?

Meaning that MT8195_SYS_STATUS has *both* CORE0_WDT and CORE1_WDT bits set when
we reach this interrupt handler?
In that case, the fix would be to just change....

> +{
> +	u32 scp_to_host;
> +
> +	scp_to_host = readl(scp->reg_base + MT8192_SCP2APMCU_IPC_SET);
> +
> +	if (scp_to_host & MT8192_SCP_IPC_INT_BIT) {
> +		scp_ipi_handler(scp);
> +	} else {
> +		u32 reason = readl(scp->reg_base + MT8195_SYS_STATUS);
> +
> +		if (reason & MT8195_CORE1_WDT)
> +			writel(1, scp->reg_base + MT8195_CORE1_WDT_IRQ);
> +		else

...the 'else' to another conditional :-)

Regards,
Angelo


