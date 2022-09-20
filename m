Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA185BE36E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiITKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:36:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F7F0E;
        Tue, 20 Sep 2022 03:34:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 640596601F3B;
        Tue, 20 Sep 2022 11:34:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663670071;
        bh=Ly/Gd/BN8cZIA8HYYtUp7eyC8GP8ws7pSAuEwyx/X5o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XUSr6mTZd0KrAR17T81pA/3sXiF88jPHisabDNPtgK3vjBm3IG4jNbju3JvH2nZ1P
         vkjCshGNakNla1CP5FeOMLER2lO0EdPtfRbeeSz0m3uuA0H9MF7x+cF668zOxeur3g
         PcYf0wAG6mA/uVRZ9WLVy1aK+cop7Auxnv7zaV9k5znPLe/5wKf60oDe4b62eBspxM
         +gh5SAN6aq7CYRHpff/mvhCcNF4ORhPVxJ1/AbSYaNx066mGNdqXuGC+nMLRqi+Z9G
         6FwhjDGNmmvMgSZ0AjrScXDd+7tP+yWpAeEQCOPBpUdv24dBszOkTV0H/462MD0Jpd
         WHNRBP8jig7xA==
Message-ID: <b2ab259b-404d-a267-6fef-913c4514b078@collabora.com>
Date:   Tue, 20 Sep 2022 12:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 08/17] drm/mediatek: hdmi: add cec flag
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-8-4844816c9808@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v1-8-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
> Add a flag to indicate support for cec.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> index bfcca6f8b839..86653ebaacfd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> @@ -154,35 +154,38 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
>   		return ret;
>   	}
>   
> -	/* The CEC module handles HDMI hotplug detection */
> -	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
> -	if (!cec_np) {
> -		dev_err(dev, "Failed to find CEC node\n");
> -		return -EINVAL;
> -	}
> +	if (hdmi->conf->has_cec) {

I think that's a pointless overcomplication: I know why you're doing this but I'm
not sure that this is a good solution.

I would simply disable CEC support if there is no CEC child node and that's it...

Regards,
Angelo
