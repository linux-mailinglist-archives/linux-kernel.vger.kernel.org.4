Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B960D7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiJYXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYXNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E91FF8C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17C661BB5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0924C433D6;
        Tue, 25 Oct 2022 23:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666739583;
        bh=Qd6iE4RAuy5ZRVM7OcQwoPbhETc72fMXCkxUe0ZuCWQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pdOhL9Z82OdmN1CvZPWmMlpejtz5j3ucXRzmSc5aD8YBFWeSsZtgeVLpkm5gX5RS4
         LQeDoxvyikqrg8wqReVsXoUdUFuknMyzp4/EmkA9nADPQ86WvImGaitaUY4DM5SGfK
         NBRX7bembHn4mM6ITrE2FwYAGGsvuopaOjpxicceRPV3qLqA5c0WmLhnUfXOqx6ygJ
         iA3aXQAUdOVNU6r7XY7Yed1i+hl28TUFTlatl6LTaM05wFL9XZbdrpwMDq4mQ44/iU
         O4bHe+Ctb0HU5yvwUC9WaMohyE8AowKombijSaMaFnfmQCnXEHz2K4mrOZo2ueL2/Q
         zYw77Vvb89DgA==
Date:   Tue, 25 Oct 2022 16:12:59 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: Re: [PATCH V4 1/2] xen/virtio: Optimize the setup of "xen-grant-dma"
 devices
In-Reply-To: <20221025162004.8501-2-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210251612530.1397955@ubuntu-linux-20-04-desktop>
References: <20221025162004.8501-1-olekstysh@gmail.com> <20221025162004.8501-2-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> This is needed to avoid having to parse the same device-tree
> several times for a given device.
> 
> For this to work we need to install the xen_virtio_restricted_mem_acc
> callback in Arm's xen_guest_init() which is same callback as x86's
> PV and HVM modes already use and remove the manual assignment in
> xen_setup_dma_ops(). Also we need to split the code to initialize
> backend_domid into a separate function.
> 
> Prior to current patch we parsed the device-tree three times:
> 1. xen_setup_dma_ops()->...->xen_is_dt_grant_dma_device()
> 2. xen_setup_dma_ops()->...->xen_dt_grant_init_backend_domid()
> 3. xen_virtio_mem_acc()->...->xen_is_dt_grant_dma_device()
> 
> With current patch we parse the device-tree only once in
> xen_virtio_restricted_mem_acc()->...->xen_dt_grant_init_backend_domid()
> 
> Other benefits are:
> - Not diverge from x86 when setting up Xen grant DMA ops
> - Drop several global functions
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> New patch
> ---
>  arch/arm/xen/enlighten.c    |  2 +-
>  drivers/xen/grant-dma-ops.c | 77 ++++++++++++++-----------------------
>  include/xen/arm/xen-ops.h   |  4 +-
>  include/xen/xen-ops.h       | 16 --------
>  4 files changed, 30 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 93c8ccbf2982..7d59765aef22 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -445,7 +445,7 @@ static int __init xen_guest_init(void)
>  		return 0;
>  
>  	if (IS_ENABLED(CONFIG_XEN_VIRTIO))
> -		virtio_set_mem_acc_cb(xen_virtio_mem_acc);
> +		virtio_set_mem_acc_cb(xen_virtio_restricted_mem_acc);
>  
>  	if (!acpi_disabled)
>  		xen_acpi_guest_init();
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index daa525df7bdc..1e797a043980 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -292,50 +292,20 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>  	.dma_supported = xen_grant_dma_supported,
>  };
>  
> -static bool xen_is_dt_grant_dma_device(struct device *dev)
> -{
> -	struct device_node *iommu_np;
> -	bool has_iommu;
> -
> -	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> -	has_iommu = iommu_np &&
> -		    of_device_is_compatible(iommu_np, "xen,grant-dma");
> -	of_node_put(iommu_np);
> -
> -	return has_iommu;
> -}
> -
> -bool xen_is_grant_dma_device(struct device *dev)
> -{
> -	/* XXX Handle only DT devices for now */
> -	if (dev->of_node)
> -		return xen_is_dt_grant_dma_device(dev);
> -
> -	return false;
> -}
> -
> -bool xen_virtio_mem_acc(struct virtio_device *dev)
> -{
> -	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
> -		return true;
> -
> -	return xen_is_grant_dma_device(dev->dev.parent);
> -}
> -
>  static int xen_dt_grant_init_backend_domid(struct device *dev,
> -					   struct xen_grant_dma_data *data)
> +					   domid_t *backend_domid)
>  {
>  	struct of_phandle_args iommu_spec;
>  
>  	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
>  			0, &iommu_spec)) {
> -		dev_err(dev, "Cannot parse iommus property\n");
> +		dev_dbg(dev, "Cannot parse iommus property\n");
>  		return -ESRCH;
>  	}
>  
>  	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>  			iommu_spec.args_count != 1) {
> -		dev_err(dev, "Incompatible IOMMU node\n");
> +		dev_dbg(dev, "Incompatible IOMMU node\n");
>  		of_node_put(iommu_spec.np);
>  		return -ESRCH;
>  	}
> @@ -346,12 +316,28 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>  	 * The endpoint ID here means the ID of the domain where the
>  	 * corresponding backend is running
>  	 */
> -	data->backend_domid = iommu_spec.args[0];
> +	*backend_domid = iommu_spec.args[0];
>  
>  	return 0;
>  }
>  
> -void xen_grant_setup_dma_ops(struct device *dev)
> +static int xen_grant_init_backend_domid(struct device *dev,
> +					domid_t *backend_domid)
> +{
> +	int ret = -ENODEV;
> +
> +	if (dev->of_node) {
> +		ret = xen_dt_grant_init_backend_domid(dev, backend_domid);
> +	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain()) {
> +		dev_info(dev, "Using dom0 as backend\n");
> +		*backend_domid = 0;
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static void xen_grant_setup_dma_ops(struct device *dev, domid_t backend_domid)
>  {
>  	struct xen_grant_dma_data *data;
>  
> @@ -365,16 +351,7 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  	if (!data)
>  		goto err;
>  
> -	if (dev->of_node) {
> -		if (xen_dt_grant_init_backend_domid(dev, data))
> -			goto err;
> -	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
> -		dev_info(dev, "Using dom0 as backend\n");
> -		data->backend_domid = 0;
> -	} else {
> -		/* XXX ACPI device unsupported for now */
> -		goto err;
> -	}
> +	data->backend_domid = backend_domid;
>  
>  	if (store_xen_grant_dma_data(dev, data)) {
>  		dev_err(dev, "Cannot store Xen grant DMA data\n");
> @@ -392,12 +369,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  
>  bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
>  {
> -	bool ret = xen_virtio_mem_acc(dev);
> +	domid_t backend_domid;
>  
> -	if (ret)
> -		xen_grant_setup_dma_ops(dev->dev.parent);
> +	if (!xen_grant_init_backend_domid(dev->dev.parent, &backend_domid)) {
> +		xen_grant_setup_dma_ops(dev->dev.parent, backend_domid);
> +		return true;
> +	}
>  
> -	return ret;
> +	return false;
>  }
>  
>  MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
> index b0766a660338..70073f5a2b54 100644
> --- a/include/xen/arm/xen-ops.h
> +++ b/include/xen/arm/xen-ops.h
> @@ -8,9 +8,7 @@
>  static inline void xen_setup_dma_ops(struct device *dev)
>  {
>  #ifdef CONFIG_XEN
> -	if (xen_is_grant_dma_device(dev))
> -		xen_grant_setup_dma_ops(dev);
> -	else if (xen_swiotlb_detect())
> +	if (xen_swiotlb_detect())
>  		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  }
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index a34f4271a2e9..47f11bec5e90 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -216,26 +216,10 @@ static inline void xen_preemptible_hcall_end(void) { }
>  #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
>  
>  #ifdef CONFIG_XEN_GRANT_DMA_OPS
> -void xen_grant_setup_dma_ops(struct device *dev);
> -bool xen_is_grant_dma_device(struct device *dev);
> -bool xen_virtio_mem_acc(struct virtio_device *dev);
>  bool xen_virtio_restricted_mem_acc(struct virtio_device *dev);
>  #else
> -static inline void xen_grant_setup_dma_ops(struct device *dev)
> -{
> -}
> -static inline bool xen_is_grant_dma_device(struct device *dev)
> -{
> -	return false;
> -}
> -
>  struct virtio_device;
>  
> -static inline bool xen_virtio_mem_acc(struct virtio_device *dev)
> -{
> -	return false;
> -}
> -
>  static inline bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
>  {
>  	return false;
> -- 
> 2.25.1
> 
