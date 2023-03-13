Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF56B788F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCMNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCMNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263203609E;
        Mon, 13 Mar 2023 06:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6579B80DFD;
        Mon, 13 Mar 2023 13:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743B3C433EF;
        Mon, 13 Mar 2023 13:12:23 +0000 (UTC)
Message-ID: <b3a32197-c15d-bfdb-051d-724c63ad8cf0@xs4all.nl>
Date:   Mon, 13 Mar 2023 14:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: mediatek: vcodec: Use 4K frame size when supported
 by stateful decoder
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230302131821.2060936-1-treapking@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230302131821.2060936-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 14:18, Pin-yen Lin wrote:
> After commit b018be06f3c7 ("media: mediatek: vcodec: Read max resolution
> from dec_capability"), the stateful video decoder driver never really
> sets its output frame size to 4K.
> 
> Parse the decoder capability reported by the firmware, and update the
> output frame size in mtk_init_vdec_params to enable 4K frame size when
> available.
> 
> Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
>  .../mediatek/vcodec/mtk_vcodec_dec_stateful.c        | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> index 035c86e7809f..679f4dc9acfb 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> @@ -11,7 +11,7 @@
>  #include "mtk_vcodec_dec_pm.h"
>  #include "vdec_drv_if.h"
>  
> -static const struct mtk_video_fmt mtk_video_formats[] = {
> +static struct mtk_video_fmt mtk_video_formats[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_H264,
>  		.type = MTK_FMT_DEC,
> @@ -580,6 +580,16 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
>  
>  static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
>  {
> +	unsigned int i;
> +
> +	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
> +		for (i = 0; i < num_supported_formats; i++) {
> +			mtk_vdec_framesizes[i].stepwise.max_width =
> +				VCODEC_DEC_4K_CODED_WIDTH;
> +			mtk_vdec_framesizes[i].stepwise.max_height =
> +				VCODEC_DEC_4K_CODED_HEIGHT;
> +		}
> +	}

This doesn't apply: commit cfce5b186537 ("media: mediatek: vcodec: decoder: Embed
framesize inside mtk_video_fmt") removed mtk_vdec_framesizes.

Please post a v2 if this is still relevant.

Regards,

	Hans

>  }
>  
>  static struct vb2_ops mtk_vdec_frame_vb2_ops = {

