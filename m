Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84FD5F5D99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJFATR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJFATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:19:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601A74CDB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 585C5CE13D9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A161DC433D6;
        Thu,  6 Oct 2022 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665015550;
        bh=gNH9JFMRj4028X6vghjl+A/oKEsjEpj+6Qt/m1foJc4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sjA7iFR0DU+H8mqfrY4QeN/vh/sdujzUR/RI4Ja/fRy1jhEOxTS3JsxSkk/gm56Wg
         LjOaaSVKwLbUrF0rwmNhrDuxAjRVWVHBPoFhFOy12E4OafGNJZgY3obwPjSQ7exUnb
         HCJ035iqG1pPJIV/pJPnv1Wq/+6RM/hDsfB3rNcCk48TUU8nQ9bOXWqjqRsfSyJG+0
         ICf6RpzSXUQvmS6Zg6b7+4Z07Ps08YYM/+i3vfePRwruzuSCN38SR6jSDTQQcSGE4U
         Q5I+Ht1gsxadn6LZ9BkMJJJuesKzmT3X0FbNTqExf67hXN+7wvRyA+NyAEqYgtsCoj
         AR/dGeOsNiksA==
Date:   Wed, 5 Oct 2022 17:19:07 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Fix potential deadlock when accessing
 xen_grant_dma_devices
In-Reply-To: <20221005174823.1800761-3-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210051719000.3690179@ubuntu-linux-20-04-desktop>
References: <20221005174823.1800761-1-olekstysh@gmail.com> <20221005174823.1800761-3-olekstysh@gmail.com>
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

On Wed, 5 Oct 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> As find_xen_grant_dma_data() is called from both interrupt and process
> contexts, the access to xen_grant_dma_devices XArray must be protected
> by xa_lock_irqsave to avoid deadlock scenario.
> As XArray API doesn't provide xa_store_irqsave helper, call lockless
> __xa_store directly and guard it externally.
> 
> Also move the storage of the XArray's entry to a separate helper.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Fixes: d6aca3504c7d ("xen/grant-dma-ops: Add option to restrict memory access under Xen")

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/grant-dma-ops.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 1998d0e8ce82..c66f56d24013 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -25,7 +25,7 @@ struct xen_grant_dma_data {
>  	bool broken;
>  };
>  
> -static DEFINE_XARRAY(xen_grant_dma_devices);
> +static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices, XA_FLAGS_LOCK_IRQ);
>  
>  #define XEN_GRANT_DMA_ADDR_OFF	(1ULL << 63)
>  
> @@ -42,14 +42,29 @@ static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>  static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
>  {
>  	struct xen_grant_dma_data *data;
> +	unsigned long flags;
>  
> -	xa_lock(&xen_grant_dma_devices);
> +	xa_lock_irqsave(&xen_grant_dma_devices, flags);
>  	data = xa_load(&xen_grant_dma_devices, (unsigned long)dev);
> -	xa_unlock(&xen_grant_dma_devices);
> +	xa_unlock_irqrestore(&xen_grant_dma_devices, flags);
>  
>  	return data;
>  }
>  
> +static int store_xen_grant_dma_data(struct device *dev,
> +				    struct xen_grant_dma_data *data)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	xa_lock_irqsave(&xen_grant_dma_devices, flags);
> +	ret = xa_err(__xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
> +			GFP_ATOMIC));
> +	xa_unlock_irqrestore(&xen_grant_dma_devices, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * DMA ops for Xen frontends (e.g. virtio).
>   *
> @@ -338,8 +353,7 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  	 */
>  	data->backend_domid = iommu_spec.args[0];
>  
> -	if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
> -			GFP_KERNEL))) {
> +	if (store_xen_grant_dma_data(dev, data)) {
>  		dev_err(dev, "Cannot store Xen grant DMA data\n");
>  		goto err;
>  	}
> -- 
> 2.25.1
> 
