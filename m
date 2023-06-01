Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCC71A2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjFAPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjFAPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531312C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0799563A24
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E0BC433D2;
        Thu,  1 Jun 2023 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634063;
        bh=7xY+u4JxmBE6NT/YTHi3IL1X1Lgg7woZjL73nmOBOnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCFsc6RCloNkVlMfcUoDOwSCGeYHgmOnqTtFxLj9omS1r7XEk+SSHCF7owrpZAv33
         wiYZPZ0XH6r/Xp/p4XCPPWQpnoODOcnHdnKn78Xhv3hT7rbrO7RcHAorVeTpN6fLqM
         XCnXp1jkUliSdID0oPET9ocblTY5mvGoqQ8MjEfNJau5w6I0u3VVkrqj5MsTHrjVI3
         FIQn4rz5pL8HFtBjgNXcr1k7Q0fwhAmwr30dYa26GpzymzmTMDdgf1rZj1Ht0u2EO/
         Gg6jWugKIbTtz5HlBmN0Md6ro6199VPQ+XGHRlD9vzLHqrgOeBKT+dSbzl3eVE/cca
         dmE28sECzdjLw==
Date:   Thu, 1 Jun 2023 08:41:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Message-ID: <20230601154101.GA2368233@dev-arch.thelio-3990X>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Fri, Mar 10, 2023 at 11:41:26PM +0100, Uwe Kleine-König wrote:
> Instead of silently returning an error in the remove callback (which yields
> a generic and little informing error message), annotate each error path of
> fsl_mc_resource_pool_remove_device() with an error message and return zero
> in the remove callback to suppress the error message.
> 
> Note that changing the return value has no other effect than suppressing
> the error message by the fsl_mc bus driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I apologize if this has already been reported or fixed somewhere, I did
a search of lore.kernel.org and did not find anything. This change as
commit b3134039c5b3 ("bus: fsl-mc: fsl-mc-allocator: Improve error
reporting") causes the following warning/error with clang:

  drivers/bus/fsl-mc/fsl-mc-allocator.c:108:12: error: variable 'mc_bus_dev' is uninitialized when used here [-Werror,-Wuninitialized]
    108 |                 dev_err(&mc_bus_dev->dev, "resource mismatch\n");
        |                          ^~~~~~~~~~
  include/linux/dev_printk.h:144:44: note: expanded from macro 'dev_err'
    144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
        |                                                   ^~~
  include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
    110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
        |                         ^~~
  drivers/bus/fsl-mc/fsl-mc-allocator.c:100:34: note: initialize the variable 'mc_bus_dev' to silence this warning
    100 |         struct fsl_mc_device *mc_bus_dev;
        |                                         ^
        |                                          = NULL
  1 error generated.

Should this be using mc_dev->dev or is there a different fix?

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 0ad68099684e..867ac3bbeae6 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -105,7 +105,7 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
 
 	resource = mc_dev->resource;
 	if (!resource || resource->data != mc_dev) {
-		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
+		dev_err(&mc_dev->dev, "resource mismatch\n");
 		goto out;
 	}
 

Cheers,
Nathan

> ---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index e60faf8edaa1..36f70e5e418b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -104,22 +104,30 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
>  	int error = -EINVAL;
>  
>  	resource = mc_dev->resource;
> -	if (!resource || resource->data != mc_dev)
> +	if (!resource || resource->data != mc_dev) {
> +		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
>  		goto out;
> +	}
>  
>  	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
>  	mc_bus = to_fsl_mc_bus(mc_bus_dev);
>  	res_pool = resource->parent_pool;
> -	if (res_pool != &mc_bus->resource_pools[resource->type])
> +	if (res_pool != &mc_bus->resource_pools[resource->type]) {
> +		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
>  		goto out;
> +	}
>  
>  	mutex_lock(&res_pool->mutex);
>  
> -	if (res_pool->max_count <= 0)
> +	if (res_pool->max_count <= 0) {
> +		dev_err(&mc_bus_dev->dev, "max_count underflow\n");
>  		goto out_unlock;
> +	}
>  	if (res_pool->free_count <= 0 ||
> -	    res_pool->free_count > res_pool->max_count)
> +	    res_pool->free_count > res_pool->max_count) {
> +		dev_err(&mc_bus_dev->dev, "free_count mismatch\n");
>  		goto out_unlock;
> +	}
>  
>  	/*
>  	 * If the device is currently allocated, its resource is not
> @@ -613,7 +621,7 @@ static int fsl_mc_allocator_remove(struct fsl_mc_device *mc_dev)
>  	if (mc_dev->resource) {
>  		error = fsl_mc_resource_pool_remove_device(mc_dev);
>  		if (error < 0)
> -			return error;
> +			return 0;
>  	}
>  
>  	dev_dbg(&mc_dev->dev,
> -- 
> 2.39.1
> 
