Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8A6C6238
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCWIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:50:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57EFF08;
        Thu, 23 Mar 2023 01:50:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF21866030A0;
        Thu, 23 Mar 2023 08:50:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679561415;
        bh=QIBKAQHW32VhrQ9F/PA56aH9RAmzOMMZUYdACgC+B1s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mwb4QJCI2JydeBqPu+fOE24Rn80hslFg1H3yZVG6Mhns6XSWMHJ1r6OC5UtsP/aOP
         S0wC8esmqkzea/hgPtOuJWom4aQaMLjQYTQcH4Q/bhtSJSgxfNGi/AO0NZEzeAU0Tt
         yzEaukHMhNaceaaAPH7ytDvVqsW2nSq+7g17lXBkzl8HgG6X97kGQWIgC1qVWkHFLa
         guSexaIYVwMv350ogss0M7cQPMgCOh95Pl46W1KSjPZqN8yHfhdbSUXWJqCbysSWrK
         PJhD38qF5Ooyg5kbu/r4W6EWiDdt8qTtiMOBLQRchnBfgwaAvIPhGb0uoNCqZI3QjQ
         zTMOX9XDbeFHQ==
Message-ID: <5202922d-9cc3-8aac-4193-ee463b255846@collabora.com>
Date:   Thu, 23 Mar 2023 09:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: Remove decoder 'dma-ranges'
 conditon when set dma mask
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Yong Wu <yong.wu@mediatek.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230323083810.21912-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230323083810.21912-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/03/23 09:38, Yunfei Dong ha scritto:
> After commit f1ad5338a4d5("of: Fix "dma-ranges" handling for bus controllers"),
> the dma-ranges is not allowed in decoder dts node. But the driver still need
> to set dma mask, remove "dma-ranges" condition in prob function.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> Reference series:
> [1]: v5 of this series is present by Yong Wu.
>       20230307023507.13306-1-yong.wu@mediatek.com
> ---
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index bba7b932f4fa..2c3a4c2cdaee 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -137,6 +137,20 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
>   	return 0;
>   }
>   
> +static int mtk_vcodec_dec_set_dma_mask(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	return !(of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec") ||
> +	       of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"));

Like that, you're never reaching the code below...

Anyway, at a first glance, it looked like you were sending the same commit twice,
but then I noticed... so... I would propose to change the commit title(s) to follow
this format:

media: mediatek: vcodec: enc: Set DMA mask only for MT8173 and MT8183

(but then, why mt8173/83 and not the others? this deserves an explanation...)


Regards,
Angelo

