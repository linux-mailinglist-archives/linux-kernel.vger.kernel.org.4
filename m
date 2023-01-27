Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774D467E10C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjA0KGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjA0KGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:06:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A4CA0D;
        Fri, 27 Jan 2023 02:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C2361AA9;
        Fri, 27 Jan 2023 10:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13075C433D2;
        Fri, 27 Jan 2023 10:06:43 +0000 (UTC)
Message-ID: <47840969-364e-e5a2-d78b-967542a78eb6@xs4all.nl>
Date:   Fri, 27 Jan 2023 11:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [V4] media: mtk-jpeg: Fixes jpeghw multi-core judgement
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20230103034213.18573-1-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230103034213.18573-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui, Kyrie,

On 03/01/2023 04:42, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> some chips have multi-hw, but others have only one,
> modify the condition of multi-hw judgement
> 
> Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |  4 +++-
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..56b27ecd61ec 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1692,7 +1692,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	if (list_empty(&pdev->dev.devres_head)) {
> +	if (jpeg->variant->hw_arch) {
>  		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
>  				  mtk_jpeg_job_timeout_work);
>  
> @@ -1885,6 +1885,7 @@ static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
>  	.ioctl_ops = &mtk_jpeg_enc_ioctl_ops,
>  	.out_q_default_fourcc = V4L2_PIX_FMT_YUYV,
>  	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
> +	.hw_arch = MTK_JPEG_HW_MULTI_CORE,
>  };
>  
>  static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
> @@ -1896,6 +1897,7 @@ static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
>  	.ioctl_ops = &mtk_jpeg_dec_ioctl_ops,
>  	.out_q_default_fourcc = V4L2_PIX_FMT_JPEG,
>  	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
> +	.hw_arch = MTK_JPEG_HW_MULTI_CORE,
>  };

So presumably the mtk8195 is multi core and the other variants are single core, but...

>  
>  #if defined(CONFIG_OF)
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index b9126476be8f..ead47e11dd48 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -46,6 +46,16 @@ enum mtk_jpeg_ctx_state {
>  	MTK_JPEG_SOURCE_CHANGE,
>  };
>  
> +/**
> + * enum mtk_jpeg_hw_arch - arch of the jpeg hw
> + * @MTK_JPEG_HW_MULTI_CORE:	jpeg hw is mluti-core

mluti -> multi

> + * @MTK_JPEG_HW_SINGLE_CORE:	jpeg hw is single core
> + */
> +enum mtk_jpeg_hw_arch {
> +	MTK_JPEG_HW_MULTI_CORE = 0,

...this has value 0, so multi core is the default. This means that all variants are
seen as multi core.

> +	MTK_JPEG_HW_SINGLE_CORE = 1,
> +};
> +
>  /**
>   * struct mtk_jpeg_variant - mtk jpeg driver variant
>   * @clks:			clock names
> @@ -60,6 +70,7 @@ enum mtk_jpeg_ctx_state {
>   * @ioctl_ops:			the callback of jpeg v4l2_ioctl_ops
>   * @out_q_default_fourcc:	output queue default fourcc
>   * @cap_q_default_fourcc:	capture queue default fourcc
> + * @hw_arch:            mark jpeg hw arch

I think this is a poorly chosen name: wouldn't it be better
to just make this a 'bool multi_core;'?

>   */
>  struct mtk_jpeg_variant {
>  	struct clk_bulk_data *clks;
> @@ -74,6 +85,7 @@ struct mtk_jpeg_variant {
>  	const struct v4l2_ioctl_ops *ioctl_ops;
>  	u32 out_q_default_fourcc;
>  	u32 cap_q_default_fourcc;
> +	enum mtk_jpeg_hw_arch hw_arch;
>  };
>  
>  struct mtk_jpeg_src_buf {

In any case, this patch doesn't look right.

Regards,

	Hans
