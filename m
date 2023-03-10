Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1D6B4A52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjCJPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjCJPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:21:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E01CBD2;
        Fri, 10 Mar 2023 07:11:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A89DA2E5;
        Fri, 10 Mar 2023 16:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678460517;
        bh=PdhMIv1BqENXVPnM808oAbaFFFguQAJg5pti+hcZLlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9+1F8BLzjMrHWvCpTAU14Rb9jifcjI8NrrJ2PA9SY9SQaw4+KZrZGx2Hyw+z8lWW
         Jq0kvPyhAPzDBAlkE3XVTgOjTxSzCJ6Wz/Q6/yBKJ3I2qp4yINmcrnybPp4r1jCqZb
         mlohsPM5ERvAI6xrbpW1SBwP0jxecREqNum8+sRU=
Date:   Fri, 10 Mar 2023 17:02:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: Use of_property_present() for testing DT property
 presence
Message-ID: <20230310150201.GK5342@pendragon.ideasonboard.com>
References: <20230310144711.1543225-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310144711.1543225-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:47:11AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c        | 2 +-
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 +-
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 +-
>  drivers/media/platform/xilinx/xilinx-vtc.c                  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..1a2b3214b6f8 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1757,7 +1757,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>  	jpeg->vdev->device_caps = V4L2_CAP_STREAMING |
>  				  V4L2_CAP_VIDEO_M2M_MPLANE;
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
> +	if (of_property_present(pdev->dev.of_node, "dma-ranges"))
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>  
>  	ret = video_register_device(jpeg->vdev, VFL_TYPE_VIDEO, -1);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 174a6eec2f54..d2db8ccaa4c0 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -321,7 +321,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL)) {
> +	if (of_property_present(pdev->dev.of_node, "dma-ranges")) {
>  		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>  		if (ret) {
>  			mtk_v4l2_err("Failed to set mask");
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index 9095186d5495..199042034a3c 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -344,7 +344,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  		goto err_event_workq;
>  	}
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
> +	if (of_property_present(pdev->dev.of_node, "dma-ranges"))
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>  
>  	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
> diff --git a/drivers/media/platform/xilinx/xilinx-vtc.c b/drivers/media/platform/xilinx/xilinx-vtc.c
> index 0ae0208d7529..cb4b421a348d 100644
> --- a/drivers/media/platform/xilinx/xilinx-vtc.c
> +++ b/drivers/media/platform/xilinx/xilinx-vtc.c
> @@ -254,7 +254,7 @@ struct xvtc_device *xvtc_of_get(struct device_node *np)
>  	struct xvtc_device *found = NULL;
>  	struct xvtc_device *xvtc;
>  
> -	if (!of_find_property(np, "xlnx,vtc", NULL))
> +	if (!of_property_present(np, "xlnx,vtc"))
>  		return NULL;
>  
>  	xvtc_node = of_parse_phandle(np, "xlnx,vtc", 0);

-- 
Regards,

Laurent Pinchart
