Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B123D725332
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjFGFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGFHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:07:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9284E7E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:07:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2292E75B;
        Wed,  7 Jun 2023 07:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686114403;
        bh=OY3A9j7LWxOtGxybg39w2drC3GWF5OQYZWWDTDkqIl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+qzQQ5Ms+6pyd+JJuGtTCMUTlrdpkI66ZpoUc0G0AIVMadYFeM6oErtqYj5rfk4r
         gj2PIIrbvDaabOh/tJ7w7tq4MBacAjZffFdzBjj2pAcdOcn4apUQjywT3SyHjLGkfN
         v59wNOfHzqgPxm4LuMifva0ZC55wPCBWEdVeCin0=
Date:   Wed, 7 Jun 2023 08:07:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hyun.kwon@xilinx.com, airlied@gmail.com, daniel@ffwll.ch,
        michal.simek@amd.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: Add missing check for
 dma_set_mask
Message-ID: <20230607050705.GF14101@pendragon.ideasonboard.com>
References: <20230607020529.22934-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607020529.22934-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiasheng,

Thank you for the patch.

On Wed, Jun 07, 2023 at 10:05:29AM +0800, Jiasheng Jiang wrote:
> Add check for dma_set_mask() and return the error if it fails.
> 
> Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index bab862484d42..068413be6527 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -227,7 +227,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	dpsub->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, dpsub);
>  
> -	dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
> +	ret = dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
> +	if (ret)
> +		return ret;

This seems reasonable.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, would you be able to quickly test this ?

>  
>  	/* Try the reserved memory. Proceed if there's none. */
>  	of_reserved_mem_device_init(&pdev->dev);

-- 
Regards,

Laurent Pinchart
