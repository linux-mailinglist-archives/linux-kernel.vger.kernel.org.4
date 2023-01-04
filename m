Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F665D28F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjADMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjADMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:25:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53583C57;
        Wed,  4 Jan 2023 04:25:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61B236C7;
        Wed,  4 Jan 2023 13:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672835136;
        bh=ISQ3UHUxD3o+GfzGM62iW4mcXRNTs4TvFWcCqoYdqXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeuO6Qr1Z3eP8plgokW0EbiJHCHc2DNV6y4CvsdinT81q6ZYkvPl2sOrKwiEfIk5S
         yss9I6tlrskfEsJjplYLYEI2MJQ1T0Fe+MoVg+mP4Pso6ZOAiNda2mgs/BmNrT+rsl
         UqWs68gatBldVyS9eAuqeCQ3rBpTLMA8nYCqNnmU=
Date:   Wed, 4 Jan 2023 14:25:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: platform: ti: Add missing check for
 devm_regulator_get
Message-ID: <Y7VwPOQtKC1eDGg+@pendragon.ideasonboard.com>
References: <20230104085537.20646-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104085537.20646-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

Thank you for the patch.

On Wed, Jan 04, 2023 at 04:55:37PM +0800, Jiasheng Jiang wrote:
> Add check for the return value of devm_regulator_get since it may return
> error pointer.
> 
> Fixes: 448de7e7850b ("[media] omap3isp: OMAP3 ISP core")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/ti/omap3isp/isp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
> index 1d40bb59ff81..e7327e38482d 100644
> --- a/drivers/media/platform/ti/omap3isp/isp.c
> +++ b/drivers/media/platform/ti/omap3isp/isp.c
> @@ -2307,7 +2307,16 @@ static int isp_probe(struct platform_device *pdev)
>  
>  	/* Regulators */
>  	isp->isp_csiphy1.vdd = devm_regulator_get(&pdev->dev, "vdd-csiphy1");
> +	if (IS_ERR(isp->isp_csiphy1.vdd)) {
> +		ret = PTR_ERR(isp->isp_csiphy1.vdd);
> +		goto error;
> +	}
> +
>  	isp->isp_csiphy2.vdd = devm_regulator_get(&pdev->dev, "vdd-csiphy2");
> +	if (IS_ERR(isp->isp_csiphy2.vdd)) {
> +		ret = PTR_ERR(isp->isp_csiphy2.vdd);
> +		goto error;
> +	}
>  
>  	/* Clocks
>  	 *

-- 
Regards,

Laurent Pinchart
