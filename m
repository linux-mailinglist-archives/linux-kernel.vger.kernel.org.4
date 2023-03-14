Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD46B96C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCNNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCNNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:48:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEA8E968DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:45:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397B04B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:46:00 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 548363F67D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:45:16 -0700 (PDT)
Date:   Tue, 14 Mar 2023 13:45:06 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] drm/arm/malidp: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZBB6YmrrNnufgpIh@e110455-lin.cambridge.arm.com>
References: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
 <20230314080231.20212-2-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314080231.20212-2-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:02:31PM +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Since 'struct platform_device *pdev = to_platform_device(dev)',
> 'pdev->dev' is equivalent to 'dev'.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the cleanup! I will pull this patch and the hdlcd one into
drm-misc-next by the end of the week.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index cf040e2e9efe..e220bfc85b2e 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -724,8 +724,7 @@ static int malidp_bind(struct device *dev)
>  	hwdev->hw = (struct malidp_hw *)of_device_get_match_data(dev);
>  	malidp->dev = hwdev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	hwdev->regs = devm_ioremap_resource(dev, res);
> +	hwdev->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(hwdev->regs))
>  		return PTR_ERR(hwdev->regs);
>  
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
