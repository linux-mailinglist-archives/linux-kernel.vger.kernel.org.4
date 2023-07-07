Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4974AD35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGGIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGGIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:37:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2361997;
        Fri,  7 Jul 2023 01:37:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-32-136-nat.elisa-mobile.fi [85.76.32.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD4E7558;
        Fri,  7 Jul 2023 10:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688718991;
        bh=9K8Q5aHSXFpmzJwUwcU6XyU9oRfy/343CqkcKOqnyL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wD8Rib7xEzcbJfSAsSm9BhfSKT6wEiZyVgTq8xpDOoNCSpSWVSxpCIrElaxAlfqrV
         zJBRPpYdcwXnt0HmpgQ3+h6Bu1fmhbIhpS5U5sAWpOW/G+BHyuOSEMf6MQhKgsXxTU
         vwh6t6AhhCENi/sm2w8u4XZXnz+hso+DAnmRy+kE=
Date:   Fri, 7 Jul 2023 11:37:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] media: platform: ti: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230707083713.GB16622@pendragon.ideasonboard.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
 <20230706101100.75654-9-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706101100.75654-9-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

Thank you for the patch.

On Thu, Jul 06, 2023 at 06:10:57PM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/media/platform/ti/omap3isp/isp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
> index f3aaa9e76492..1c8e4ede29b6 100644
> --- a/drivers/media/platform/ti/omap3isp/isp.c
> +++ b/drivers/media/platform/ti/omap3isp/isp.c
> @@ -2329,9 +2329,7 @@ static int isp_probe(struct platform_device *pdev)
>  	for (i = 0; i < 2; i++) {
>  		unsigned int map_idx = i ? OMAP3_ISP_IOMEM_CSI2A_REGS1 : 0;
>  
> -		mem = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -		isp->mmio_base[map_idx] =
> -			devm_ioremap_resource(isp->dev, mem);
> +		isp->mmio_base[map_idx] = devm_platform_get_and_ioremap_resource(pdev, i, &mem);

I expect Sakari to prefer a line wrap:

		isp->mmio_base[map_idx] =
			devm_platform_get_and_ioremap_resource(pdev, i, &mem);

I assume he will be able to change this when picking up the patch,
without requiring a v2.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		if (IS_ERR(isp->mmio_base[map_idx])) {
>  			ret = PTR_ERR(isp->mmio_base[map_idx]);
>  			goto error;

-- 
Regards,

Laurent Pinchart
