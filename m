Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335CE7480B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGEJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:22:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA7E5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:22:26 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A76BF6606FAB;
        Wed,  5 Jul 2023 10:22:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688548945;
        bh=9JHc5dxF9kL0BlFs4YhHrNU5Gaeu5yKjERb1y27tW7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lYRg7E0hTw89N/bxg+8ufv9nqta3h9zrkjkhTlW7yGzVm6qQD3WJFT681azn9O7wk
         sowieypkzR2oii0YwBNMNwfTAXVOF8hvu56YVVedKnMYxORQv6LlLiy+ml9oZvmb/x
         GjHPSd7JJv6Usc0mDz/Z8BRyCzvSGaKXBn9d04OsKLcFLUAg6dfzmPJgFDkKxQ5prk
         0uQeQkNy5dSQQ/maGZ2O+527IjTcc/SuOYsiP88TK7Idpn+dPlxyqHjyegtW1E0BbT
         oO5jCvz/D3YcWUH7d+dvxe0PcRVLME4PnVXRGXhhgyTEyxMnondQ/ASbr3S7Wnk6eB
         ye0DE/X2xVEsw==
Message-ID: <ddc05f70-7075-97ab-1c94-cb3d5839ef2b@collabora.com>
Date:   Wed, 5 Jul 2023 11:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] phy: mediatek: tphy: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230705090126.26854-1-frank.li@vivo.com>
 <20230705090126.26854-4-frank.li@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230705090126.26854-4-frank.li@vivo.com>
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

Il 05/07/23 11:01, Yangtao Li ha scritto:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 0d110e50bbfd..cb7a4e6ea017 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -1554,7 +1554,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>   	struct device_node *np = dev->of_node;
>   	struct device_node *child_np;
>   	struct phy_provider *provider;
> -	struct resource *sif_res;
>   	struct mtk_tphy *tphy;
>   	struct resource res;
>   	int port, retval;
> @@ -1576,15 +1575,12 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>   	tphy->dev = dev;
>   	platform_set_drvdata(pdev, tphy);
>   
> -	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	/* SATA phy of V1 needn't it if not shared with PCIe or USB */
> -	if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
> +	if (tphy->pdata->version == MTK_PHY_V1) {
>   		/* get banks shared by multiple phys */
> -		tphy->sif_base = devm_ioremap_resource(dev, sif_res);
> -		if (IS_ERR(tphy->sif_base)) {
> -			dev_err(dev, "failed to remap sif regs\n");
> +		tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tphy->sif_base) && PTR_ERR(tphy->sif_base) != -EINVAL)

That's wrong. You want to return any error unconditionally, as the V1 PHY *needs*
the sif iospace and there's nothing afterwards retrying this.

Please fix.

Regards,
Angelo

>   			return PTR_ERR(tphy->sif_base);
> -		}
>   	}
>   
>   	if (tphy->pdata->version < MTK_PHY_V3) {


