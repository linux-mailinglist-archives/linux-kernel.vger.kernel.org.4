Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B937260286E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJRJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJRJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:33:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2FAE848;
        Tue, 18 Oct 2022 02:33:52 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms7w73yZyz9t8W;
        Tue, 18 Oct 2022 17:33:43 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:33:44 +0800
CC:     <yangyicong@hisilicon.com>, <lpieralisi@kernel.org>,
        <chenhuacai@loongson.cn>, <robin.murphy@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <loongarch@lists.linux.dev>, liulongfang <liulongfang@huawei.com>
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Jianmin Lv <lvjianmin@loongson.cn>
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
 <20220911090635.5559-2-lvjianmin@loongson.cn>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
Date:   Tue, 18 Oct 2022 17:33:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220911090635.5559-2-lvjianmin@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/11 17:06, Jianmin Lv wrote:
> In DT systems configurations, of_dma_get_range() returns struct
> bus_dma_region DMA regions; they are used to set-up devices
> DMA windows with different offset available for translation between DMA
> address and CPU address.
> 
> In ACPI systems configuration, acpi_dma_get_range() does not return
> DMA regions yet and that precludes setting up the dev->dma_range_map
> pointer and therefore DMA regions with multiple offsets.
> 
> Update acpi_dma_get_range() to return struct bus_dma_region
> DMA regions like of_dma_get_range() does.
> 
> After updating acpi_dma_get_range(), acpi_arch_dma_setup() is changed for
> ARM64, where the original dma_addr and size are removed as these
> arguments are now redundant, and pass 0 and U64_MAX for dma_base
> and size of arch_setup_dma_ops; this is a simplification consistent
> with what other ACPI architectures also pass to iommu_setup_dma_ops().
> 

Hi,

With this patch we met problem as well. The DMA coherent mask is not set correctly
for a ehci usb controller and lead to the below calltrace:

[   16.699259] ------------[ cut here ]------------
[   16.703855] WARNING: CPU: 0 PID: 853 at kernel/dma/mapping.c:499 dma_alloc_attrs+0xc0/0xf0
[   16.712082] Modules linked in:
[   16.715124] CPU: 0 PID: 853 Comm: kworker/0:3 Not tainted 6.1.0-rc1-pipe-deadlock+ #5
[   16.722916] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
[   16.731745] Workqueue: events work_for_cpu_fn
[   16.736083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.743013] pc : dma_alloc_attrs+0xc0/0xf0
[   16.747091] lr : dma_pool_alloc+0x11c/0x200
[   16.751255] sp : ffff80001e46bb50
[   16.754554] x29: ffff80001e46bb50 x28: 0000000000000000 x27: 0000000000000000
[   16.761657] x26: ffff80000b33ce18 x25: ffff800009cc6c48 x24: 0000000000000000
[   16.768759] x23: ffff00208c830918 x22: 0000000000001000 x21: 0000000000000cc0
[   16.775861] x20: ffff00208ae82080 x19: ffff0020865c40d0 x18: 0000000000000030
[   16.782964] x17: 626d756e20737562 x16: 2064656e67697373 x15: ffff00208ae82640
[   16.790066] x14: 0000000000000000 x13: 646e756f72616b72 x12: 6f77204348207379
[   16.797167] x11: 73706f6e79532067 x10: ffff205f43980000 x9 : ffff80000830b3ac
[   16.804269] x8 : ffff0020861b1b00 x7 : 0000000000000000 x6 : 0000000000000000
[   16.811371] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000cc0
[   16.818472] x2 : ffff00208c830918 x1 : 0000000000001000 x0 : 0000000000000000
[   16.825574] Call trace:
[   16.828009]  dma_alloc_attrs+0xc0/0xf0
[   16.831741]  dma_pool_alloc+0x11c/0x200
[   16.835559]  ehci_qh_alloc+0x60/0x12c
[   16.839207]  ehci_setup+0x18c/0x40c
[   16.842680]  ehci_pci_setup+0xb8/0x680
[   16.846412]  usb_add_hcd+0x310/0x5c0
[   16.849973]  usb_hcd_pci_probe+0x254/0x36c
[   16.854051]  ehci_pci_probe+0x40/0x60
[   16.857698]  local_pci_probe+0x48/0xb4
[   16.861431]  work_for_cpu_fn+0x24/0x40
[   16.865163]  process_one_work+0x1e0/0x450
[   16.869155]  worker_thread+0x2cc/0x44c
[   16.872886]  kthread+0x114/0x120
[   16.876099]  ret_from_fork+0x10/0x20
[   16.879657] ---[ end trace 0000000000000000 ]---

After reverting this patch the problem resolved. Tested on the latest 6.1-rc1.
Some investigation below...


> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  drivers/acpi/arm64/dma.c | 28 ++++++++++++---------
>  drivers/acpi/scan.c      | 53 +++++++++++++++++-----------------------
>  include/acpi/acpi_bus.h  |  3 +--
>  include/linux/acpi.h     |  7 +++---
>  4 files changed, 44 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index f16739ad3cc0..93d796531af3 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -4,11 +4,12 @@
>  #include <linux/device.h>
>  #include <linux/dma-direct.h>
>  
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +void acpi_arch_dma_setup(struct device *dev)
>  {
>  	int ret;
>  	u64 end, mask;
> -	u64 dmaaddr = 0, size = 0, offset = 0;
> +	u64 size = 0;
> +	const struct bus_dma_region *map = NULL;
>  
>  	/*
>  	 * If @dev is expected to be DMA-capable then the bus code that created
> @@ -26,7 +27,19 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  	else
>  		size = 1ULL << 32;
>  
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	ret = acpi_dma_get_range(dev, &map);
> +	if (!ret && map) {
> +		const struct bus_dma_region *r = map;
> +
> +		for (end = 0; r->size; r++) {
> +			if (r->dma_start + r->size - 1 > end)
> +				end = r->dma_start + r->size - 1;
> +		}
> +

DSDT reports a window of [mem 0x00000000-0xffffffff pref] in _DMA for the target device
but we're not retriving it correctly here. After adding some messages, it shows we haven't
enter this loop and make size as 1 and mask to 0 finally.

Please let me know if you need more information.

Thanks.

> +		size = end + 1;
> +		dev->dma_range_map = map;
> +	}
> +
>  	if (ret == -ENODEV)
>  		ret = iort_dma_get_ranges(dev, &size);
>  	if (!ret) {
> @@ -34,17 +47,10 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  		 * Limit coherent and dma mask based on size retrieved from
>  		 * firmware.
>  		 */
> -		end = dmaaddr + size - 1;
> +		end = size - 1;
>  		mask = DMA_BIT_MASK(ilog2(end) + 1);
>  		dev->bus_dma_limit = end;
>  		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>  		*dev->dma_mask = min(*dev->dma_mask, mask);
>  	}
> -
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
>  }
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 42cec8120f18..f96ef8536037 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pgtable.h>
>  #include <linux/crc32.h>
> +#include <linux/dma-direct.h>
>  
>  #include "internal.h"
>  
> @@ -1467,25 +1468,21 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>   * acpi_dma_get_range() - Get device DMA parameters.
>   *
>   * @dev: device to configure
> - * @dma_addr: pointer device DMA address result
> - * @offset: pointer to the DMA offset result
> - * @size: pointer to DMA range size result
> + * @map: pointer to DMA ranges result
>   *
> - * Evaluate DMA regions and return respectively DMA region start, offset
> - * and size in dma_addr, offset and size on parsing success; it does not
> - * update the passed in values on failure.
> + * Evaluate DMA regions and return pointer to DMA regions on
> + * parsing success; it does not update the passed in values on failure.
>   *
>   * Return 0 on success, < 0 on failure.
>   */
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size)
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  {
>  	struct acpi_device *adev;
>  	LIST_HEAD(list);
>  	struct resource_entry *rentry;
>  	int ret;
>  	struct device *dma_dev = dev;
> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> +	struct bus_dma_region *r;
>  
>  	/*
>  	 * Walk the device tree chasing an ACPI companion with a _DMA
> @@ -1510,31 +1507,28 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  
>  	ret = acpi_dev_get_dma_resources(adev, &list);
>  	if (ret > 0) {
> +		r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
> +		if (!r) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
>  		list_for_each_entry(rentry, &list, node) {
> -			if (dma_offset && rentry->offset != dma_offset) {
> +			if (rentry->res->start >= rentry->res->end) {
> +				kfree(r);
>  				ret = -EINVAL;
> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>  				goto out;
>  			}
> -			dma_offset = rentry->offset;
>  
> -			/* Take lower and upper limits */
> -			if (rentry->res->start < dma_start)
> -				dma_start = rentry->res->start;
> -			if (rentry->res->end > dma_end)
> -				dma_end = rentry->res->end;
> -		}
> -
> -		if (dma_start >= dma_end) {
> -			ret = -EINVAL;
> -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> -			goto out;
> +			r->cpu_start = rentry->res->start;
> +			r->dma_start = rentry->res->start - rentry->offset;
> +			r->size = resource_size(rentry->res);
> +			r->offset = rentry->offset;
> +			r++;
>  		}
>  
> -		*dma_addr = dma_start - dma_offset;
> -		len = dma_end - dma_start;
> -		*size = max(len, len + 1);
> -		*offset = dma_offset;
> +		*map = r;
>  	}
>   out:
>  	acpi_dev_free_resource_list(&list);
> @@ -1624,20 +1618,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  			  const u32 *input_id)
>  {
>  	const struct iommu_ops *iommu;
> -	u64 dma_addr = 0, size = 0;
>  
>  	if (attr == DEV_DMA_NOT_SUPPORTED) {
>  		set_dma_ops(dev, &dma_dummy_ops);
>  		return 0;
>  	}
>  
> -	acpi_arch_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev);
>  
>  	iommu = acpi_iommu_configure_id(dev, input_id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>  
> -	arch_setup_dma_ops(dev, dma_addr, size,
> +	arch_setup_dma_ops(dev, 0, U64_MAX,
>  				iommu, attr == DEV_DMA_COHERENT);
>  
>  	return 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e7d27373ff71..73ac4a1d6947 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -613,8 +613,7 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
>  int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>  			   struct fwnode_handle *fwnode,
>  			   const struct iommu_ops *ops);
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size);
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  			   const u32 *input_id);
>  static inline int acpi_dma_configure(struct device *dev,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6f64b2f3dc54..bb41623dab77 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -281,12 +281,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>  
>  #ifdef CONFIG_ARM64
>  void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
> +void acpi_arch_dma_setup(struct device *dev);
>  #else
>  static inline void
>  acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>  static inline void
> -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
> +acpi_arch_dma_setup(struct device *dev) { }
>  #endif
>  
>  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> @@ -977,8 +977,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>  	return DEV_DMA_NOT_SUPPORTED;
>  }
>  
> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> -				     u64 *offset, u64 *size)
> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  {
>  	return -ENODEV;
>  }
> 
