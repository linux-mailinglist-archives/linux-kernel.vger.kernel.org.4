Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173061F18E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKGLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKGLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:10:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B415722;
        Mon,  7 Nov 2022 03:09:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A813660239F;
        Mon,  7 Nov 2022 11:09:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667819375;
        bh=iUEjc9op+r+flRXGNk8tjNm3ukh2dbXz8V5WUA+PaYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JpDWgh3pu8wCEG9/L3nMuHxrxopf2J5cOs42iavUQyHFNXQG5kwrItGxVMdbX5gTm
         rVsuSNzjfpAWV1teDzDgdb29Lf57AqaTaROaUmUxiTuV37F1M9A4wF8mq/4NcPqRRM
         dHm+IjDLKbZ3JUQZQDRgpaOfcEpJXWSbiXjPF547XW0WbPSOzfxUOthCPIXdjG1Llq
         12+nDipef2AVJv2lI9bC2pRxzim8TaocJYnDJuK/pszItnVnaWD7XwbTbOvx40NSD9
         XxRgvfa5XHu12k1REWIqxG6Rp9bo/CdyZ7pJ+zc76IeS9S7r+XjtAj8rjKfzD5uFM1
         PMI+QzOrRKU4Q==
Message-ID: <a3472c42-ccac-7c98-a0b6-57556a348ac1@collabora.com>
Date:   Mon, 7 Nov 2022 12:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 06/12] drm/mediatek: hdmi: add frame_colorimetry flag
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
References: <20220919-v3-0-a803f2660127@baylibre.com>
 <20220919-v3-6-a803f2660127@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v3-6-a803f2660127@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/11/22 15:09, Guillaume Ranquet ha scritto:
> Add a flag to indicate support for frame colorimetry.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 11 +++++++++++
>   drivers/gpu/drm/mediatek/mtk_hdmi_common.h |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> index 3635ca66817b..933c51b5f6d7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> @@ -120,6 +120,17 @@ int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buffer, size_t bufsz
>   		return err;
>   	}
>   
> +	if (hdmi->conf->has_frame_colorimetry) {
> +		frame.colorimetry = hdmi->colorimtery;

Typo: s/colorimtery/colorimetry/g

...also, I don't see this being really used? In hdmi-v2 you're setting this param
to HDMI_COLORIMETRY_NONE and quantization ranges to always the same default value.

I wonder if this is really needed at this point.

Regards,
Angelo
