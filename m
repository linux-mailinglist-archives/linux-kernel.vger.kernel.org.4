Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B46BA980
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjCOHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCOHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:40:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD382A6C8;
        Wed, 15 Mar 2023 00:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82531B81CD1;
        Wed, 15 Mar 2023 07:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EA7C433D2;
        Wed, 15 Mar 2023 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678865966;
        bh=7ZQwAEI6pHf40qs7Wc1GLPddnkDUNdAFyfddgNyouZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkpBEKI10SNOCsHQOvp97N0A73oCG65sHifppYHIOFnlqRQdT3wRc3K5QEQ246RT5
         y1bOqfLD56Gc0kZh3TSz+FTRw9xSZltRZ/O8oFmMTa7cUwQVSozZAEd4LGEkGpl76E
         7opE6+ZUpNb7ZlPA0PeHjovAy7/4BEJa1XSvIza/f2ibyUjMJnyA74NuVJvBTJLQ1I
         Q1cNmKX65nGKT8UkKbNck7B9EZ6TAugyvgUJIl6TshJPN/T4u2pZf8kxh37caH2zNA
         JU+LliHheSljJn99NjDHMtg8nrk3CnzQGLtPUG0qJpIaL/ZWh4UmTRUVBCmzAk2P8C
         3b8H3RjL0jmtw==
Date:   Wed, 15 Mar 2023 13:09:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     ulf.hansson@linaro.org, afaerber@suse.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mmc: owl-mmc: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230315073912.GA25575@thinkpad>
References: <20230315054113.48898-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315054113.48898-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:41:13PM +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/mmc/host/owl-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 3dc143b03939..6f9d31a886ba 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -578,8 +578,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
>  	owl_host->mmc = mmc;
>  	spin_lock_init(&owl_host->lock);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

You forgot to remove the local variable which is now unused.

Thanks,
Mani

> -	owl_host->base = devm_ioremap_resource(&pdev->dev, res);
> +	owl_host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(owl_host->base)) {
>  		ret = PTR_ERR(owl_host->base);
>  		goto err_free_host;
> -- 
> 2.20.1.7.g153144c
> 

-- 
மணிவண்ணன் சதாசிவம்
