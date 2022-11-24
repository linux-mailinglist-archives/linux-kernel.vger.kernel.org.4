Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD901637EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKXRyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKXRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:54:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3256314
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:53:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A0DB82898
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229FAC433D6;
        Thu, 24 Nov 2022 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669312406;
        bh=0CkHSWHK0YdycIG/SfO26rBNHInfTiEV4KS+PF+SzUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4jWlBBlJByIYSN68t3DNK9LN4bNW0O1ifsqo9VkFJLLrC8uN//iE2yD6G/S1yKpl
         Fuu+Y9PIYBwOQ73akQvI/cr6IuvrGOXMwmwS1tx86yUsz8v058DYX1rZYx35J1q7kP
         KgQ7C8K4rHPsddgGm6S1KyOsoBg1YEc6oTK7RnWC81RMSM8pdkfg5y90Egs5yNCiiX
         qIBwuTHHbkyU/eQJmUulWj+Im7BPDdhB6+htPyPyBgnNQhPYkWi9gIrSth1bFBLd1u
         9X74AQvCXrOEX4aXgDU5ICH0nGqX6Zv9+gCOJI+b87wOScjooUQMMutWCbPbzg0JOb
         o5E9LuV+BqOyQ==
Date:   Thu, 24 Nov 2022 23:23:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: use devm_platform_get_and_ioremap_resource()
Message-ID: <Y3+vklHsXk+FftOe@matsya>
References: <202211171411439883050@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211171411439883050@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-22, 14:11, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

Applied, thanks

> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/phy/marvell/phy-mmp3-hsic.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
> index 7cccf01848d8..f2537fdcc3ab 100644
> --- a/drivers/phy/marvell/phy-mmp3-hsic.c
> +++ b/drivers/phy/marvell/phy-mmp3-hsic.c
> @@ -41,12 +41,10 @@ static int mmp3_hsic_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *provider;
> -	struct resource *resource;
>  	void __iomem *base;
>  	struct phy *phy;
> 
> -	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, resource);
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 
> -- 
> 2.25.1

-- 
~Vinod
