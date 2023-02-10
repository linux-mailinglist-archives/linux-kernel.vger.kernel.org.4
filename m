Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AD692B46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBJXeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBJXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:34:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975C831F7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:32:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04172B8261A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB79C433D2;
        Fri, 10 Feb 2023 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071975;
        bh=viXOvaeCoLP52MV8gaJBodxikjoeBS1XcEbdT3P79ZA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IFc1Yh/BULyN7rXPWP8Bc15yRXRRsuJqwPyXLCCJU14Bz3DP6/QdM9qVC1NUNyTTu
         SzO4cZyepM86ffMRAFoUYAYM/Mu/qpBxBAbYgiLMHeP0PmnZGaVfcbBQnoagQLNY/t
         qNNd2vBvlXcAi32p6mA5QdttayEyN529liiP98+Uf1Xr9TQOuNScQRVCtMy0tYhdZH
         OVz+Hl4MtOO33J/Vq2Ni4cxuKJ+qhFFXEjhRx8q7Ic3PqoiXdm/glRznb964kpaY+J
         pDMdKndLnbTzlID8rIKsqz047ALFqqdNJgXEjPtMLP82xzXXFw+yDKU6tRWT0cQa9/
         hxx/IH1E7j/xA==
Date:   Fri, 10 Feb 2023 15:32:53 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] xen/grant-dma-iommu: Implement a dummy probe_device()
 callback
In-Reply-To: <20230208153649.3604857-1-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2302101532460.4661@ubuntu-linux-20-04-desktop>
References: <20230208153649.3604857-1-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Update stub IOMMU driver (which main purpose is to reuse generic
> IOMMU device-tree bindings by Xen grant DMA-mapping layer on Arm)
> according to the recent changes done in the following
> commit 57365a04c921 ("iommu: Move bus setup to IOMMU device registration").
> 
> With probe_device() callback being called during IOMMU device registration,
> the uninitialized callback just leads to the "kernel NULL pointer
> dereference" issue during boot. Fix that by adding a dummy callback.
> 
> Looks like the release_device() callback is not mandatory to be
> implemented as IOMMU framework makes sure that callback is initialized
> before dereferencing.
> 
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/grant-dma-iommu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-iommu.c b/drivers/xen/grant-dma-iommu.c
> index 16b8bc0c0b33..6a9fe02c6bfc 100644
> --- a/drivers/xen/grant-dma-iommu.c
> +++ b/drivers/xen/grant-dma-iommu.c
> @@ -16,8 +16,15 @@ struct grant_dma_iommu_device {
>  	struct iommu_device iommu;
>  };
>  
> -/* Nothing is really needed here */
> -static const struct iommu_ops grant_dma_iommu_ops;
> +static struct iommu_device *grant_dma_iommu_probe_device(struct device *dev)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +/* Nothing is really needed here except a dummy probe_device callback */
> +static const struct iommu_ops grant_dma_iommu_ops = {
> +	.probe_device = grant_dma_iommu_probe_device,
> +};
>  
>  static const struct of_device_id grant_dma_iommu_of_match[] = {
>  	{ .compatible = "xen,grant-dma" },
> -- 
> 2.34.1
> 
