Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C37627C44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiKNL2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiKNL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:27:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52F12D35;
        Mon, 14 Nov 2022 03:26:46 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B80E6660231A;
        Mon, 14 Nov 2022 11:26:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668425204;
        bh=XifCq/axZLBlXf4U0/opeUK0341SCz1UOz+Nkb9EfVg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aDUvkxXsUxmHSLgh1elCk9KmlE2qa5h/iiL5HMRv+CEd0pihqpgJuEIN+EhABBEXA
         zWkRKkrbNNWCS8YkUzgkuRncYJBO1tPi70p8I430FopA2p1xEObQJQd8lkFPknre+B
         p5869i/ddLmyvysVN3eA51JM79Ruol7+7YsTCLnHVOtmzCfyKFVUnFQAA43/OWQmZe
         2KLSOZrWh67v0Rva6eJH6+UPQQuoCS55O9+6WQo6LoOndsHvawzTMCtsIh+voBnbAC
         P5Ti8ukVINdsGdorg5KvZonlU7dhCa7IUJQmqyt9N3Kb/V2bBRrYrHbk+1PHqFjd4w
         mY7ZHo+D/M4Zg==
Message-ID: <11a5fbb6-f462-bdc5-1592-32e8f2664a48@collabora.com>
Date:   Mon, 14 Nov 2022 12:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/5] media: mediatek: vcodec: Fix h264 set lat buffer
 error
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221112094144.4256-1-yunfei.dong@mediatek.com>
 <20221112094144.4256-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112094144.4256-4-yunfei.dong@mediatek.com>
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

Il 12/11/22 10:41, Yunfei Dong ha scritto:
> Will set lat buffer to lat_list two times when lat decode timeout for
> inner racing mode.
> 
> If core thread can't get frame buffer, need to return error value.
> 
> Fixes: 59fba9eed5a7 ("media: mediatek: vcodec: support stateless H.264 decoding for mt8192")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../vcodec/vdec/vdec_h264_req_multi_if.c      | 23 ++++++++++++-------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> index 4cc92700692b..2b7576265f48 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> @@ -471,6 +471,12 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
>   	       sizeof(share_info->h264_slice_params));
>   
>   	fb = ctx->dev->vdec_pdata->get_cap_buffer(ctx);
> +	if (!fb) {
> +		err = -EBUSY;
> +		mtk_vcodec_err(inst, "fb buffer is NULL");
> +		goto vdec_dec_end;
> +	}
> +
>   	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;

If you're jumping to vdec_dec_end, this check becomes pointless as y_fb_dma
will never be set to 0, so you can remove the conditional on assigning
the dma address to `y_fb_dma`.

Same comment a few lines later for `c_fb_dma`.

Regards,
Angelo

