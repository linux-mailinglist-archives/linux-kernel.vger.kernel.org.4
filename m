Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456C05BE317
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiITKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiITKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:25:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4335E674;
        Tue, 20 Sep 2022 03:25:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F07716600368;
        Tue, 20 Sep 2022 11:25:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663669549;
        bh=pJFt8yhuO+61RNQoKu/PstmWS0PBWMsonGq/dnFhPCY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R2oc5TOvtqehwVdIVv4+ZI4lKyrDIUceJdbxMi/4V4X4XDvk3e3SdGay/LYNOYzrC
         DXxdJO5MyIrCLEkMrhjlY1u96S1/affuMfe8RaXDP7nFTXFnZ4MWC3M1xOzBDeK5m8
         lEuvNw5Aggj73VIO/CLscBO+EUrcp+7eCblSGS1sIssmA6ELNjdJebtJWOjsFVDR/j
         uyJbu45SEV9y71RXViboId+7Z/hCjzmzlJV1enTIUR5hQfvCVBwLXemvji4sqsnqRl
         11BEWGHHH9GsllzQ/+5YTNdKLeZ4jQHIN3tTk5EKUrTsggQa9wzRKM5YpE1h9seXu4
         qpub0SjqOUUWg==
Message-ID: <153dcb4f-4583-427e-83c7-bdd33e3b11aa@collabora.com>
Date:   Tue, 20 Sep 2022 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 07/17] drm/mediatek: extract common functions from the
 mtk hdmi driver
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
 <20220919-v1-7-4844816c9808@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v1-7-4844816c9808@baylibre.com>
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
> Create a common "framework" that can be used to add support for
> different hdmi IPs within the mediatek range of products.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index d4d193f60271..008ec69da67b 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -22,7 +22,8 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
>   
>   mediatek-drm-hdmi-objs := mtk_cec.o \
>   			  mtk_hdmi.o \

abcd ... mtk_hdmi_common.o goes here :-)

> -			  mtk_hdmi_ddc.o
> +			  mtk_hdmi_ddc.o \
> +			  mtk_hdmi_common.o \
>   
>   obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
>   
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 5cd05d4fe1a9..837d36ec4d64 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -32,187 +32,18 @@
>   #include <drm/drm_probe_helper.h>
>   
>   #include "mtk_cec.h"
> -#include "mtk_hdmi.h"
>   #include "mtk_hdmi_regs.h"
> +#include "mtk_hdmi_common.h"
>   
>   #define NCTS_BYTES	7
>   
> -enum mtk_hdmi_clk_id {
> -	MTK_HDMI_CLK_HDMI_PIXEL,
> -	MTK_HDMI_CLK_HDMI_PLL,
> -	MTK_HDMI_CLK_AUD_BCLK,
> -	MTK_HDMI_CLK_AUD_SPDIF,
> -	MTK_HDMI_CLK_COUNT
> +const char * const mtk_hdmi_clk_names_mt8183[MTK_MT8183_HDMI_CLK_COUNT] = {

Why MT8183? This can be either MT8167 or MT2701... or, IMO more appropriately, you
should name the IP version.
Example: MTK_HDMIV123_CLK_COUNT (I don't know what IP version would that be!).

> +	[MTK_MT8183_HDMI_CLK_HDMI_PIXEL] = "pixel",
> +	[MTK_MT8183_HDMI_CLK_HDMI_PLL] = "pll",
> +	[MTK_MT8183_HDMI_CLK_AUD_BCLK] = "bclk",
> +	[MTK_MT8183_HDMI_CLK_AUD_SPDIF] = "spdif",
>   };
>   

Regards,
Angelo


