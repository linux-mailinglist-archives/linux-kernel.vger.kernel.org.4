Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC96B8EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCNJpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:45:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA4911C5;
        Tue, 14 Mar 2023 02:45:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DCC3660308E;
        Tue, 14 Mar 2023 09:45:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678787129;
        bh=he80No0jUzUzFg9an8Hlqi16J8qgl1LK/+OP6SgvrHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SM1PQ4XRb7bXX5Y+R1qBLRO70QJA49V2xU3dKXFJG5YiqF7fzN68zXQx0Zu6PZniH
         yzlcwf5NdWcey+t0PdoDLaBQDp/Mfy40YBIuGRm+VoyZ2/nQydJkGviXWANAbefhiA
         2k0Vw5Eg/00bEtwWfu0fjYZVJuH0nBozeTqNz6HE7hZRa1U0+pxOcZVjITp4i8ZASf
         YwhRCoPkT06kW25Zr18ChAdTGjsWN7AqWoYJvEg7eYZITgTvrh+eFnLxk95zjSBMeV
         SMwSr1BBYg1WnxWfqj594S1/xU7vcOqB68VOYYHND/3mTwK7mnq4ay/QQAGQUmkQ0p
         hfaBv1FB07C8A==
Message-ID: <08ccf52a-39bd-ed28-d9ca-3615c4a02c09@collabora.com>
Date:   Tue, 14 Mar 2023 10:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] media: mediatek: vcodec: Force capture queue format to
 MM21
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
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
References: <20230314072557.29669-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230314072557.29669-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/03/23 08:25, Yunfei Dong ha scritto:
> Libyuv is one software library used to covert format. Only covert
> mediatek uncompressed mode MM21 to standard yuv420 for MT21 is
> compressed mode. Need to set capture queue format to MM21 in order
> to use Libyuv when scp firmware support MM21 and MT21.
> 
> Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>


After the firmware gets sent to linux-firmware *and ONLY after that*:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> changed with v2:
> - re-write commit message.
> - change the driver flow.
> changed with v1:
> - add Fixes tag.
> ---
>   .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 24 +++----------------
>   1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 641f533c417f..c99705681a03 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -39,10 +39,9 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
>   {
>   	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
>   	const struct mtk_video_fmt *fmt;
> -	struct mtk_q_data *q_data;
>   	int num_frame_count = 0, i;
> -	bool ret = true;
>   
> +	fmt = &dec_pdata->vdec_formats[format_index];
>   	for (i = 0; i < *dec_pdata->num_formats; i++) {
>   		if (dec_pdata->vdec_formats[i].type != MTK_FMT_FRAME)
>   			continue;
> @@ -50,27 +49,10 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
>   		num_frame_count++;
>   	}
>   
> -	if (num_frame_count == 1)
> +	if (num_frame_count == 1 || fmt->fourcc == V4L2_PIX_FMT_MM21)
>   		return true;
>   
> -	fmt = &dec_pdata->vdec_formats[format_index];
> -	q_data = &ctx->q_data[MTK_Q_DATA_SRC];
> -	switch (q_data->fmt->fourcc) {
> -	case V4L2_PIX_FMT_VP8_FRAME:
> -		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
> -			ret = true;
> -		break;
> -	case V4L2_PIX_FMT_H264_SLICE:
> -	case V4L2_PIX_FMT_VP9_FRAME:
> -		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
> -			ret = false;
> -		break;
> -	default:
> -		ret = true;
> -		break;
> -	}
> -
> -	return ret;
> +	return false;
>   }
>   
>   static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_ctx *ctx,


