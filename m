Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02B6E20D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDNKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDNKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:31:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738F212E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFFAF6603223;
        Fri, 14 Apr 2023 11:31:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681468311;
        bh=9+BjnTU2PKzLgcfmAc7Ppk7BV0SarnBlAnMFkT6+Sro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KJwTN+lqObpyJIkpZIex7p/iBPvjgDo7GjlFB6i4ud2CnlgumnXBakFwJbxOOPaKf
         I7XcfNXo1uqetIeW59Xf9kio1NPBIp+dUa31eV+1NlHzUHV+X8jlbMizLf0ZkCj4cG
         wLULtn9Hi4FA7ibenylvQxbPNqe63u6l9qInS5bKlCirFJjnUeOc1binABMSV05Gdc
         PssCdJKYuHONBH44iwItSFCsnLY0fjAmASNUFzNBTEVMVs9LbN+LFyrLQPDCeWv9tp
         0mTHqHHK4C5xopoi1Sz22iRu7o7r5dg5oQB3+8fmOveKuosMjYHeYUUArk1BgZZsEg
         izMllf2WwSBCw==
Message-ID: <ada769e0-0141-634f-3753-eb3a50f0eee3@collabora.com>
Date:   Fri, 14 Apr 2023 12:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] phy: mediatek: hdmi: mt8195: fix uninitialized
 variable usage in pll_calc
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
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
 <20230413-fixes-for-mt8195-hdmi-phy-v1-1-b8482458df0d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v1-1-b8482458df0d@baylibre.com>
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
> The ret variable in mtk_hdmi_pll_calc() was used unitialized as reported
> by the kernel test robot.
> 
> Fix the issue by removing the variable altogether and testing out the
> return value of mtk_hdmi_pll_set_hw()
> 
> Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..e10da6c4147e 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -213,7 +213,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	u64 tmds_clk, pixel_clk, da_hdmitx21_ref_ck, ns_hdmipll_ck, pcw;
>   	u8 txpredivs[4] = { 2, 4, 6, 12 };
>   	u32 fbkdiv_low;
> -	int i, ret;
> +	int i;
>   
>   	pixel_clk = rate;
>   	tmds_clk = pixel_clk;
> @@ -292,10 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	if (!(digital_div <= 32 && digital_div >= 1))
>   		return -EINVAL;
>   
> -	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +	if (mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
>   			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> -			    txposdiv, digital_div);
> -	if (ret)
> +			    txposdiv, digital_div))
>   		return -EINVAL;
>   

I don't get why we're returning -EINVAL unconditionally in the first place, here.

Function mtk_hdmi_pll_set_hw() should return zero or a negative error number: in
that case, the previous *intention* was fine, so this should be

	ret = mtk_hdmi_pll_set_hw(....)
	if (ret)
		return ret;

	return 0;


Regards,
Angelo
