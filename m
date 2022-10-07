Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB735F727D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiJGBO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJGBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CBA4B92
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4719061B8D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47A8C433C1;
        Fri,  7 Oct 2022 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665105261;
        bh=8mLAnMeo3AtHBXXkzvL+vd14+0hlje4dHLK3eWyTIpw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=o7/rj/a7pGC7DHBC2CjftJB/z3X0tMtJekp5m2kKDpIHciFRIiYrCZbndME0PYKV/
         CUh7OMeWfqTXY418PWfrGh3sbLavsoRGVCSaWVV9w7LcLHb5MG5BYZR0wA9pAW4f0m
         foEzFOehsgylAElZiYpo28bvl9SMkw/IkNZRmZeLY4s5kBMdQWYUBPgLZ9WRAOZn1y
         GTca8eCkXsFWuPSFaP5at9VL3vt0hoOqQ7x4IDYNCMxQA1jw6lF2K99HTu3dZ5SnUk
         +Kk0SCeAc6GNzgt65KvXt4Ah9iQckGyuCBsjl9qanAjTtx7lSIsqB/xbcArFVQCk5D
         /zXOw1yNBoKIg==
Date:   Thu, 6 Oct 2022 18:14:19 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
In-Reply-To: <20221006174804.2003029-1-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210061747590.3690179@ubuntu-linux-20-04-desktop>
References: <20221006174804.2003029-1-olekstysh@gmail.com>
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

On Thu, 6 Oct 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Use the same "xen-grant-dma" device concept (based on generic IOMMU
> device-tree bindings) for the PCI devices behind device-tree based
> PCI Host controller.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Slightly RFC. This is needed to support Xen grant mappings for virtio-pci devices
> on Arm at some point in the future. The Xen toolstack side is not published yet.
> Here, for PCI devices we use the same way to pass backend domid to the guest as for
> platform devices.
> 
> Depends on Juergen's series:
> https://lore.kernel.org/xen-devel/20221006071500.15689-1-jgross@suse.com/
> ---
>  drivers/xen/grant-dma-ops.c | 51 +++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index ff9be3aff87e..79d13122ec08 100644
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
> @@ -273,12 +274,28 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>  	.dma_supported = xen_grant_dma_supported,
>  };
>  
> -static bool xen_is_dt_grant_dma_device(struct device *dev)
> +static struct device_node *xen_dt_get_node(struct device *dev)
> +{
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_bus *bus = pdev->bus;
> +
> +		/* Walk up to the root bus to look for PCI Host controller */
> +		while (!pci_is_root_bus(bus))
> +			bus = bus->parent;
> +
> +		return of_node_get(bus->bridge->parent->of_node);
> +	}

Is it possible to have multiple virtio devices under a single virtio-pci
root complex? What if virtio-net has the backend in dom0 and
virtio-block has the backend in dom1?

Or each virtio PCI device shows up under a different PCI root complex?

If we can have multiple virtio PCI devices under a single PCI root
complex, then I think it would be better to check for a per-device
property, rather than a single property at the PCI root complex level.

The first thing that comes to mind is to describe each PCI device under
the root complex in device tree. Although it is uncommon (usually only
the PCI root complex is described in device tree), it is possible to
also describe in device tree all the individual PCI devices under the
root complex.

Given that the domU device tree is generated by Xen and/or the Xen
toolstack, it would be easy to arrange for it to happen.

That would solve the issue as far as I can tell, but I worry it might
not be a good idea because if we rely on the per-device device tree node
to be present then it becomes harder to implement virtio hotplug
(Virtio hotplug is important to add dom0less support.)

Let's say that we create a dom0less domU with an emulated PCI root
complex without any devices under it, then after Dom0 is fully booted,
we add a virtio-net emulated device. How do we tell the guest what is
the backend domain id?

Device tree and other firmware tables are not relevant anymore.

We could reuse a PCI config space register to expose the backend id.
However this solution requires a backend change (QEMU) to expose the
backend id via an emulated register for each emulated device.

To avoid having to introduce a special config space register in all
emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
could add a special PCI config space register at the emulated PCI Root
Complex level.

Basically the workflow would be as follow:

- Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
- Linux writes to special PCI config space register of the Xen PCI Root
  Complex the PCI device id (basically the BDF)
- The Xen PCI Root Complex emulated by Xen answers by writing back to
  the same location the backend id (domid of the backend)
- Linux reads back the same PCI config space register of the Xen PCI
  Root Complex and learn the relevant domid

What do you think?

Other ideas welcome!



> +	return of_node_get(dev->of_node);
> +}
> +
> +static bool xen_is_dt_grant_dma_device(struct device_node *np)
>  {
>  	struct device_node *iommu_np;
>  	bool has_iommu;
>  
> -	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> +	iommu_np = of_parse_phandle(np, "iommus", 0);
>  	has_iommu = iommu_np &&
>  		    of_device_is_compatible(iommu_np, "xen,grant-dma");
>  	of_node_put(iommu_np);
> @@ -288,9 +305,17 @@ static bool xen_is_dt_grant_dma_device(struct device *dev)
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
> +		ret = xen_is_dt_grant_dma_device(np);
> +		of_node_put(np);
> +		return ret;
> +	}
>  
>  	return false;
>  }
> @@ -303,20 +328,20 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
>  	return xen_is_grant_dma_device(dev->dev.parent);
>  }
>  
> -static int xen_dt_grant_setup_dma_ops(struct device *dev,
> +static int xen_dt_grant_setup_dma_ops(struct device_node *np,
>  				       struct xen_grant_dma_data *data)
>  {
>  	struct of_phandle_args iommu_spec;
>  
> -	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
> +	if (of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
>  			0, &iommu_spec)) {
> -		dev_err(dev, "Cannot parse iommus property\n");
> +		pr_err("%s: Cannot parse iommus property\n", np->name);
>  		return -ESRCH;
>  	}
>  
>  	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>  			iommu_spec.args_count != 1) {
> -		dev_err(dev, "Incompatible IOMMU node\n");
> +		pr_err("%s: Incompatible IOMMU node\n", iommu_spec.np->name);
>  		of_node_put(iommu_spec.np);
>  		return -ESRCH;
>  	}
> @@ -335,6 +360,7 @@ static int xen_dt_grant_setup_dma_ops(struct device *dev,
>  void xen_grant_setup_dma_ops(struct device *dev)
>  {
>  	struct xen_grant_dma_data *data;
> +	struct device_node *np;
>  
>  	data = find_xen_grant_dma_data(dev);
>  	if (data) {
> @@ -346,8 +372,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  	if (!data)
>  		goto err;
>  
> -	if (dev->of_node) {
> -		if (xen_dt_grant_setup_dma_ops(dev, data))
> +	np = xen_dt_get_node(dev);
> +	if (np) {
> +		int ret;
> +
> +		ret = xen_dt_grant_setup_dma_ops(np, data);
> +		of_node_put(np);
> +		if (ret)
>  			goto err;
>  	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>  		dev_info(dev, "Using dom0 as backend\n");
> -- 
> 2.25.1
> 
