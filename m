Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEADE73E011
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFZND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjFZNDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:03:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D8E79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:02:49 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QqSfT2nG9zTm1s;
        Mon, 26 Jun 2023 21:01:53 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 21:02:41 +0800
Subject: Re: [RESEND PATCH v8 04/11] bus: platform, amba, fsl-mc, PCI: Add
 device DMA ownership management
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220418005000.897664-5-baolu.lu@linux.intel.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com>
Date:   Mon, 26 Jun 2023 21:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20220418005000.897664-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/18 8:49, Lu Baolu wrote:
> The devices on platform/amba/fsl-mc/PCI buses could be bound to drivers
> with the device DMA managed by kernel drivers or user-space applications.
> Unfortunately, multiple devices may be placed in the same IOMMU group
> because they cannot be isolated from each other. The DMA on these devices
> must either be entirely under kernel control or userspace control, never
> a mixture. Otherwise the driver integrity is not guaranteed because they
> could access each other through the peer-to-peer accesses which by-pass
> the IOMMU protection.
> 
> This checks and sets the default DMA mode during driver binding, and
> cleanups during driver unbinding. In the default mode, the device DMA is
> managed by the device driver which handles DMA operations through the
> kernel DMA APIs (see Documentation/core-api/dma-api.rst).
> 
> For cases where the devices are assigned for userspace control through the
> userspace driver framework(i.e. VFIO), the drivers(for example, vfio_pci/
> vfio_platfrom etc.) may set a new flag (driver_managed_dma) to skip this
> default setting in the assumption that the drivers know what they are
> doing with the device DMA.
> 
> Calling iommu_device_use_default_domain() before {of,acpi}_dma_configure
> is currently a problem. As things stand, the IOMMU driver ignored the
> initial iommu_probe_device() call when the device was added, since at
> that point it had no fwspec yet. In this situation,
> {of,acpi}_iommu_configure() are retriggering iommu_probe_device() after
> the IOMMU driver has seen the firmware data via .of_xlate to learn that
> it actually responsible for the given device. As the result, before
> that gets fixed, iommu_use_default_domain() goes at the end, and calls
> arch_teardown_dma_ops() if it fails.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60adf42460ab..b933d2b08d4d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -895,6 +895,13 @@ struct module;
>   *              created once it is bound to the driver.
>   * @driver:	Driver model structure.
>   * @dynids:	List of dynamically added device IDs.
> + * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
> + *		For most device drivers, no need to care about this flag
> + *		as long as all DMAs are handled through the kernel DMA API.
> + *		For some special ones, for example VFIO drivers, they know
> + *		how to manage the DMA themselves and set this flag so that
> + *		the IOMMU layer will allow them to setup and manage their
> + *		own I/O address space.
>   */
>  struct pci_driver {
>  	struct list_head	node;
> @@ -913,6 +920,7 @@ struct pci_driver {
>  	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;
>  	struct pci_dynids	dynids;
> +	bool driver_managed_dma;
>  };
>  
>  static inline struct pci_driver *to_pci_driver(struct device_driver *drv)

[...]

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 4ceeb75fc899..f83f7fbac68f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/iommu.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -1601,6 +1602,7 @@ static int pci_bus_num_vf(struct device *dev)
>   */
>  static int pci_dma_configure(struct device *dev)
>  {
> +	struct pci_driver *driver = to_pci_driver(dev->driver);
>  	struct device *bridge;
>  	int ret = 0;
>  
> @@ -1616,9 +1618,24 @@ static int pci_dma_configure(struct device *dev)
>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> +
> +	if (!ret && !driver->driver_managed_dma) {
> +		ret = iommu_device_use_default_domain(dev);
> +		if (ret)
> +			arch_teardown_dma_ops(dev);
> +	}
> +
>  	return ret;
>  }
>  
> +static void pci_dma_cleanup(struct device *dev)
> +{
> +	struct pci_driver *driver = to_pci_driver(dev->driver);
> +
> +	if (!driver->driver_managed_dma)
> +		iommu_device_unuse_default_domain(dev);
> +}
> +
>  struct bus_type pci_bus_type = {
>  	.name		= "pci",
>  	.match		= pci_bus_match,
> @@ -1632,6 +1649,7 @@ struct bus_type pci_bus_type = {
>  	.pm		= PCI_PM_OPS_PTR,
>  	.num_vf		= pci_bus_num_vf,
>  	.dma_configure	= pci_dma_configure,
> +	.dma_cleanup	= pci_dma_cleanup,
>  };
>  EXPORT_SYMBOL(pci_bus_type);

I (somehow forgot to delete DEBUG_TEST_DRIVER_REMOVE in my .config, and)
failed to start the guest with an assigned PCI device, with something
like:

| qemu-system-aarch64: -device 
vfio-pci,host=0000:03:00.1,id=hostdev0,bus=pci.8,addr=0x0: vfio 
0000:03:00.1: group 45 is not viable
| Please ensure all devices within the iommu_group are bound to their 
vfio bus driver.

It looks like on device probe, with DEBUG_TEST_DRIVER_REMOVE,
.dma_configure() will be executed *twice* via the
really_probe()/re_probe path, and *no* .dma_cleanup() will be executed.
The resulting dev::iommu_group::owner_cnt is 2, which will confuse the
later iommu_group_dma_owner_claimed() call from VFIO on guest startup.

I can locally workaround the problem by deleting the DEBUG option or
performing a .dma_cleanup() during test_remove'ing, but it'd be great if
you can take a look.

Thanks,
Zenghui
