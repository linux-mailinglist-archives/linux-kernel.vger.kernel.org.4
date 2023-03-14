Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00756B96A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCNNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCNNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:44:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFCA7AFBAE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:41:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC1CF4B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:42:04 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D734A3F67D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:41:20 -0700 (PDT)
Date:   Tue, 14 Mar 2023 13:41:18 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next 2/2] drm/arm/hdlcd: Use
 devm_platform_ioremap_resource()
Message-ID: <ZBB5fnTQM/QDvgxu@e110455-lin.cambridge.arm.com>
References: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:02:30PM +0800, Yang Li wrote:
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to Use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Since 'struct platform_device *pdev = to_platform_device(drm->dev)',
> 'drm->dev' is equivalent to 'pdev->deva'.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for cleaning this up!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index e3507dd6f82a..a86b317c1312 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -100,7 +100,6 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
>  {
>  	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
>  	struct platform_device *pdev = to_platform_device(drm->dev);
> -	struct resource *res;
>  	u32 version;
>  	int ret;
>  
> @@ -115,8 +114,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
>  	atomic_set(&hdlcd->dma_end_count, 0);
>  #endif
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	hdlcd->mmio = devm_ioremap_resource(drm->dev, res);
> +	hdlcd->mmio = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(hdlcd->mmio)) {
>  		DRM_ERROR("failed to map control registers area\n");
>  		ret = PTR_ERR(hdlcd->mmio);
> -- 
> 2.20.1.7.g153144c
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
