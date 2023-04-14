Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF266E20DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDNKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:34:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F9EE57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:34:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BE516603222;
        Fri, 14 Apr 2023 11:34:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681468479;
        bh=Wv3E9PUWrZb1LypVjlRkJKgongoVuhTGI7YvkuT0r4E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ym8z5pIXYeL+KxgD1J/F6kLUdC8NENeAzIH6DimNp3bWQPI7DtYYqhnEEfjXzR+lg
         EKsap0k2N7IrlsgxkT1X1o+GswaNAwhC6gVQ+X2q3vBIBVR+7oW9lCUmLU8glTKtZ9
         ddf+0HVpsMl+o32s1J+cp/q/Zjbzq/lnNxH59SsTbOGtS4WbjJdRU77q33eS8YvD4B
         ad2qUc9E3vYPmAefMvBL9BkD+HUrWQus4t9zve069FCYXxN/0ON9nb0n4v1IwvEWA3
         3CYrEedDnt/9nNDbF3/iV/VoIGc9TSjhSsYw+eHpY+3xQWOOKTs9yttvjj7NRaiPB0
         bDrMCafVaienw==
Message-ID: <52440231-bbcc-48f6-fe47-a554cade8d73@collabora.com>
Date:   Fri, 14 Apr 2023 12:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] phy: mediatek: hdmi: mt8195: fix wrong pll calculus
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
 <20230413-fixes-for-mt8195-hdmi-phy-v1-2-b8482458df0d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v1-2-b8482458df0d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 14:46, Guillaume Ranquet ha scritto:
> The clock rate calculus in mtk_hdmi_pll_calc() was wrong when it has
> been replaced by 'div_u64'.
> 
> Fix the issue by multiplying the values in the denominator instead of
> dividing them.
> 
> Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index e10da6c4147e..5e84b294a43e 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -271,7 +271,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	 * [32,24] 9bit integer, [23,0]:24bit fraction
>   	 */
>   	pcw = div_u64(((u64)ns_hdmipll_ck) << PCW_DECIMAL_WIDTH,
> -		      da_hdmitx21_ref_ck / PLL_FBKDIV_HS3);
> +		      da_hdmitx21_ref_ck * PLL_FBKDIV_HS3);

How did that even work?!?!?!? Because ... it worked, I did test it. Bah!
Luck was on your side :-P

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


