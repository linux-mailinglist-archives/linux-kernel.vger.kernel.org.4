Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439D4601FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJRAgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiJRAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94C613D45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38E9661309
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069AC433D6;
        Tue, 18 Oct 2022 00:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666053230;
        bh=s8Ob3Xrk7tyLWJ7Xn4reoQ1dzzjGxajI/oJLYN0+MuE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Xj5Ux9KgDYEZGY6LVpo7mp1bwA/gxjzQhEEUR60vl/f83SfM3nPTo0XHlINhnXG/Z
         BhhcYyrzLjQEr0Z+JpiwxrGfb6Bt/veMiczXkUi1PQBAcR3FSWq87KbulLA6bfTZG3
         tYje0HlpPAeqTzKWGNoMmE1KM/zq24qJohlstfmRtimWJo6GXF4w3GoaSUEyqsqfCD
         q80F/en95pj3E2Q0sSxMuEOib0pgBukCd/E2pNe3YTzijSU0wvuEpJ/zEQ2BhHnEWg
         EdtDOKQmjBQ0Pp7JPPwlR8KASO0kjD+JJnQCwVcgIxSAGyt3zBOHKX/hYcTE9j6aRg
         O8U7lfdIxVmlA==
Date:   Mon, 17 Oct 2022 17:33:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V2] xen/virtio: Handle PCI devices which Host controller
 is described in DT
In-Reply-To: <20221015153409.918775-1-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210171731110.4587@ubuntu-linux-20-04-desktop>
References: <20221015153409.918775-1-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Use the same "xen-grant-dma" device concept for the PCI devices
> behind device-tree based PCI Host controller, but with one modification.
> Unlike for platform devices, we cannot use generic IOMMU bindings
> (iommus property), as we need to support more flexible configuration.
> The problem is that PCI devices under the single PCI Host controller
> may have the backends running in different Xen domains and thus have
> different endpoints ID (backend domains ID).

Hi Oleksandr,

From another email I understood that you successfully managed to
describe in device tree all the individual virtio pci devices so that
you can have iommu-map/iommu-map-mask properties under each virtio
device node. Is that right?

If that is the case, then I would rather jump straight to that approach
because I think it is far better than this one.

Cheers,

Stefano



> So use generic PCI-IOMMU bindings instead (iommu-map/iommu-map-mask
> properties) which allows us to describe relationship between PCI
> devices and backend domains ID properly.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Slightly RFC. This is needed to support Xen grant mappings for virtio-pci devices
> on Arm at some point in the future. The Xen toolstack side is not completely ready yet.
> Here, for PCI devices we use more flexible way to pass backend domid to the guest
> than for platform devices.
> 
> Changes V1 -> V2:
>    - update commit description
>    - rebase
>    - rework to use generic PCI-IOMMU bindings instead of generic IOMMU bindings
> 
> Previous discussion is at:
> https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/
> 
> Based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1
> ---
>  drivers/xen/grant-dma-ops.c | 87 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index daa525df7bdc..b79d9d6ce154 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/of.h>
> +#include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/xarray.h>
>  #include <linux/virtio_anchor.h>
> @@ -292,12 +293,55 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>  	.dma_supported = xen_grant_dma_supported,
>  };
>  
> +static struct device_node *xen_dt_get_pci_host_node(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_bus *bus = pdev->bus;
> +
> +	/* Walk up to the root bus to look for PCI Host controller */
> +	while (!pci_is_root_bus(bus))
> +		bus = bus->parent;
> +
> +	return of_node_get(bus->bridge->parent->of_node);
> +}
> +
> +static struct device_node *xen_dt_get_node(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return xen_dt_get_pci_host_node(dev);
> +
> +	return of_node_get(dev->of_node);
> +}
> +
> +static int xen_dt_map_id(struct device *dev, struct device_node **iommu_np,
> +			 u32 *sid)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	struct device_node *host_np;
> +	int ret;
> +
> +	host_np = xen_dt_get_pci_host_node(dev);
> +	if (!host_np)
> +		return -ENODEV;
> +
> +	ret = of_map_id(host_np, rid, "iommu-map", "iommu-map-mask", iommu_np, sid);
> +	of_node_put(host_np);
> +
> +	return ret;
> +}
> +
>  static bool xen_is_dt_grant_dma_device(struct device *dev)
>  {
> -	struct device_node *iommu_np;
> +	struct device_node *iommu_np = NULL;
>  	bool has_iommu;
>  
> -	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> +	if (dev_is_pci(dev)) {
> +		if (xen_dt_map_id(dev, &iommu_np, NULL))
> +			return false;
> +	} else
> +		iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> +
>  	has_iommu = iommu_np &&
>  		    of_device_is_compatible(iommu_np, "xen,grant-dma");
>  	of_node_put(iommu_np);
> @@ -307,9 +351,17 @@ static bool xen_is_dt_grant_dma_device(struct device *dev)
>  
>  bool xen_is_grant_dma_device(struct device *dev)
>  {
> +	struct device_node *np;
> +
>  	/* XXX Handle only DT devices for now */
> -	if (dev->of_node)
> -		return xen_is_dt_grant_dma_device(dev);
> +	np = xen_dt_get_node(dev);
> +	if (np) {
> +		bool ret;
> +
> +		ret = xen_is_dt_grant_dma_device(dev);
> +		of_node_put(np);
> +		return ret;
> +	}
>  
>  	return false;
>  }
> @@ -325,12 +377,19 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
>  static int xen_dt_grant_init_backend_domid(struct device *dev,
>  					   struct xen_grant_dma_data *data)
>  {
> -	struct of_phandle_args iommu_spec;
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
>  
> -	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
> -			0, &iommu_spec)) {
> -		dev_err(dev, "Cannot parse iommus property\n");
> -		return -ESRCH;
> +	if (dev_is_pci(dev)) {
> +		if (xen_dt_map_id(dev, &iommu_spec.np, iommu_spec.args)) {
> +			dev_err(dev, "Cannot translate ID\n");
> +			return -ESRCH;
> +		}
> +	} else {
> +		if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
> +				0, &iommu_spec)) {
> +			dev_err(dev, "Cannot parse iommus property\n");
> +			return -ESRCH;
> +		}
>  	}
>  
>  	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
> @@ -354,6 +413,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>  void xen_grant_setup_dma_ops(struct device *dev)
>  {
>  	struct xen_grant_dma_data *data;
> +	struct device_node *np;
>  
>  	data = find_xen_grant_dma_data(dev);
>  	if (data) {
> @@ -365,8 +425,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  	if (!data)
>  		goto err;
>  
> -	if (dev->of_node) {
> -		if (xen_dt_grant_init_backend_domid(dev, data))
> +	np = xen_dt_get_node(dev);
> +	if (np) {
> +		int ret;
> +
> +		ret = xen_dt_grant_init_backend_domid(dev, data);
> +		of_node_put(np);
> +		if (ret)
>  			goto err;
>  	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>  		dev_info(dev, "Using dom0 as backend\n");
> -- 
> 2.25.1
> 
