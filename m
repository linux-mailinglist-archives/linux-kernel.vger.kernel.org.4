Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6D74ACF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjGGIdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGGIdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:33:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764AE90;
        Fri,  7 Jul 2023 01:33:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-32-136-nat.elisa-mobile.fi [85.76.32.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B31B558;
        Fri,  7 Jul 2023 10:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688718768;
        bh=MhmJ9pJ9a55aNDKmho1ipzodgSmPCUeGpN8jVIoi1BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6TfX1n7nEa3q8K8A56uubRqLS51TypqiKorlVPT5ruw7+2Fx6CS2/44IOziX9RUg
         y31CoOkEi+cNPZYSpdlRghX7/+jd7UaKoryNvLoFOt5GNcz05qobXUF15z7r5lI29j
         nS5pcxwa0r0lMb3N5mkXwrnyNU9U3GWafE6j+Fjk=
Date:   Fri, 7 Jul 2023 11:33:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] drm/renesas: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230707083329.GA16622@pendragon.ideasonboard.com>
References: <20230707072034.48977-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707072034.48977-1-frank.li@vivo.com>
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

On Fri, Jul 07, 2023 at 03:20:17PM +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index e10e4d4b89a2..4bf9f5d15fa8 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> @@ -1002,7 +1002,6 @@ static int rcar_mipi_dsi_get_clocks(struct rcar_mipi_dsi *dsi)
>  static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>  {
>  	struct rcar_mipi_dsi *dsi;
> -	struct resource *mem;
>  	int ret;
>  
>  	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
> @@ -1019,8 +1018,7 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* Acquire resources. */
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dsi->mmio = devm_ioremap_resource(dsi->dev, mem);
> +	dsi->mmio = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dsi->mmio))
>  		return PTR_ERR(dsi->mmio);
>  

-- 
Regards,

Laurent Pinchart
