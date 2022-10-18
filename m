Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CDC6020F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJRCKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiJRCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:09:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A165E2098D;
        Mon, 17 Oct 2022 19:08:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98761042;
        Mon, 17 Oct 2022 19:08:54 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BB133F7D8;
        Mon, 17 Oct 2022 19:08:48 -0700 (PDT)
Message-ID: <78bfa591-fa77-bbf1-3371-8a2b0b39c44a@arm.com>
Date:   Mon, 17 Oct 2022 21:08:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
Content-Language: en-US
To:     Jianmin Lv <lvjianmin@loongson.cn>, lpieralisi@kernel.org,
        robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
 <20220911090635.5559-2-lvjianmin@loongson.cn>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220911090635.5559-2-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well it seems this patch regresses support for the size and offset 
fields (as mentioned in the comment) which causes boot failures on 
platform which utilize those fields.

ex: The UEFI/ACPI rpi4, which tosses the following on boot when the SD 
(emmc2) controller is started:

    15.630456] ------------[ cut here ]------------
[   15.630479] sdhci-iproc BRCME88C:00: swiotlb addr 
0xffffffffffffffff+65536 overflow (mask ffffffff, bus limit 0).
[   15.630513] WARNING: CPU: 1 PID: 8 at kernel/dma/swiotlb.c:879 
swiotlb_map+0x370/0x37c
[   15.630531] Modules linked in: sdhci_iproc xhci_plat_hcd(+) dwc2(+) 
mdio_bcm_unimac sdhci_pltfm udc_core sdhci
[   15.630574] CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 
6.0.0-rc6bisect+ #315
[   15.630582] Hardware name: Raspberry Pi Foundation Raspberry Pi 4 
Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 10/03/2022
[   15.630590] Workqueue: events_unbound async_run_entry_fn
[   15.630603] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   15.630610] pc : swiotlb_map+0x370/0x37c
[   15.630619] lr : swiotlb_map+0x370/0x37c
[   15.630627] sp : ffff800008063a10
[   15.630632] x29: ffff800008063a10 x28: ffffb5f93db97008 x27: 
ffffb5f93e4a8000
[   15.630650] x26: ffffffffffffffff x25: ffffb5f93e4a8518 x24: 
0000000000000000
[   15.630668] x23: ffff44bb838bc010 x22: 0000000000000000 x21: 
0000000000000000
[   15.630685] x20: 0000000000010000 x19: 0000000117aa0080 x18: 
ffffffffffffffff
[   15.630702] x17: 6b61773d4d455453 x16: 0000000000000080 x15: 
ffff800008063628
[   15.630719] x14: 0000000000000001 x13: ffffb5f93ff0fca2 x12: 
6f6c667265766f20
[   15.630736] x11: 656820747563205b x10: 000000000000000a x9 : 
ffffb5f93bb2f024
[   15.630753] x8 : ffff8000080637a8 x7 : 0000000000000000 x6 : 
ffff800008063830
[   15.630770] x5 : ffff800008060000 x4 : 0000000000000000 x3 : 
0000000000000027
[   15.630787] x2 : 0000000000000001 x1 : ffff44bb80334000 x0 : 
0000000000000065
[   15.630804] Call trace:
[   15.630809]  swiotlb_map+0x370/0x37c
[   15.630818]  dma_direct_map_page+0x1f0/0x210
[   15.630825]  dma_map_page_attrs+0x58/0xc0
[   15.630833]  sdhci_allocate_bounce_buffer+0xa4/0x19c [sdhci]
[   15.630858]  sdhci_setup_host+0xa94/0xe3c [sdhci]
[   15.630875]  sdhci_add_host+0x20/0x60 [sdhci]
[   15.630892]  sdhci_iproc_probe+0x114/0x180 [sdhci_iproc]
[   15.630906]  platform_probe+0x70/0xcc
[   15.630916]  really_probe+0xc8/0x3e0
[   15.630924]  __driver_probe_device+0x84/0x190
[   15.630932]  driver_probe_device+0x44/0x100
[   15.630940]  __driver_attach_async_helper+0x5c/0x100
[   15.630949]  async_run_entry_fn+0x40/0x16c
[   15.630956]  process_one_work+0x2b8/0x704
[   15.630966]  worker_thread+0x7c/0x42c
[   15.630973]  kthread+0xf8/0x104
[   15.630981]  ret_from_fork+0x10/0x20
[   15.630990] irq event stamp: 525362
[   15.630996] hardirqs last  enabled at (525361): [<ffffb5f93bb30724>] 
console_trylock_spinning+0x194/0x1a0
[   15.631005] hardirqs last disabled at (525362): [<ffffb5f93cb44df4>] 
el1_dbg+0x24/0xa0
[   15.631016] softirqs last  enabled at (476786): [<ffffb5f93b9f0a78>] 
__do_softirq+0x4b8/0x6a0
[   15.631023] softirqs last disabled at (476703): [<ffffb5f93ba887a0>] 
__irq_exit_rcu+0x13c/0x22c
[   15.631033] ---[ end trace 0000000000000000 ]---
[   15.632538] xhci-hcd PNP0D10:00: xHCI Host Controller
[   15.635534] xhci-hcd PNP0D10:00: new USB bus registered, assigned bus 
number 1
[   15.642726] dwc2 BCM2848:00: supply vusb_a not found, using dummy 
regulator
[   15.679592] bcmgenet BCM6E4E:00: GENET 5.0 EPHY: 0x0000
[   15.734563] mmc0: SDHCI controller on BCM2847:00 [BCM2847:00] using PIO
[   15.748640] mmc1: SDHCI controller on BRCME88C:00 [BRCME88C:00] using DMA
[   15.844849] xhci-hcd PNP0D10:00: can't setup: -12
[   16.275199] xhci-hcd PNP0D10:00: USB bus 1 deregistered
[   16.303108] ------------[ cut here ]------------
[   16.303791] WARNING: CPU: 1 PID: 21 at drivers/mmc/host/sdhci.c:1152 
sdhci_prepare_data.isra.0+0x288/0x660 [sdhci]
[   16.303878] Modules linked in: genet(+) sdhci_iproc xhci_plat_hcd(+) 
dwc2(+) mdio_bcm_unimac sdhci_pltfm udc_core sdhci
[   16.303947] CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G        W 
      6.0.0-rc6bisect+ #315
[   16.303962] Hardware name: Raspberry Pi Foundation Raspberry Pi 4 
Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 10/03/2022
[   16.303976] Workqueue: events_freezable mmc_rescan
[   16.304001] pstate: a04000c5 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   16.304013] pc : sdhci_prepare_data.isra.0+0x288/0x660 [sdhci]
[   16.304032] lr : sdhci_prepare_data.isra.0+0x280/0x660 [sdhci]
[   16.304049] sp : ffff8000080e38e0
[   16.304057] x29: ffff8000080e38e0 x28: 0000000000000000 x27: 
ffff44bc76a3a205
[   16.304077] x26: 0000000000000000 x25: ffff44bb96bb4dc8 x24: 
ffff8000080e3ab0
[   16.304097] x23: 000000000000000b x22: 0000000000000000 x21: 
0000000000000000
[   16.304116] x20: ffff8000080e3ae8 x19: ffff44bb96bb49c0 x18: 
0000000000000000
[   16.304134] x17: ffff8ec338cc9000 x16: 0000000000000060 x15: 
0000000000030300
[   16.304153] x14: 0000000000000018 x13: 001fffffffffffff x12: 
0000000000000001
[   16.304171] x11: fffffbffefa66a48 x10: ffff44bc7efc5ee8 x9 : 
ffffb5f93bb64948
[   16.304189] x8 : ffffb5f93e9b3d38 x7 : 0000000000000018 x6 : 
0000000070ce6ce5
[   16.304206] x5 : 00ffffffffffffff x4 : 0000000000000020 x3 : 
0000000000000002
[   16.304224] x2 : 0000000000000000 x1 : fffffffffffdfbfe x0 : 
00000000ffffffe4
[   16.304243] Call trace:
[   16.304254]  sdhci_prepare_data.isra.0+0x288/0x660 [sdhci]
[   16.304276]  sdhci_send_command+0x220/0x330 [sdhci]
[   16.304294]  sdhci_send_command_retry+0x48/0x15c [sdhci]
[   16.304311]  sdhci_request+0x78/0xd0 [sdhci]
[   16.304329]  __mmc_start_request+0x7c/0x150
[   16.304352]  mmc_start_request+0x9c/0xc4
[   16.304364]  mmc_wait_for_req+0x78/0x10c
[   16.304373]  mmc_app_send_scr+0xf8/0x140
[   16.304385]  mmc_sd_setup_card+0x108/0x350
[   16.304394]  mmc_sd_init_card+0x148/0x4e0
[   16.304403]  mmc_attach_sd+0xc4/0x160
[   16.304411]  mmc_rescan_try_freq+0xe8/0x180
[   16.304420]  mmc_rescan+0x18c/0x1fc
[   16.304426]  process_one_work+0x2b8/0x704
[   16.304440]  worker_thread+0x7c/0x42c
[   16.304448]  kthread+0xf8/0x104
[   16.304459]  ret_from_fork+0x10/0x20
[   16.304476] irq event stamp: 11012
[   16.304484] hardirqs last  enabled at (11011): [<ffffb5f93cb58564>] 
_raw_spin_unlock_irqrestore+0x74/0x90
[   16.304504] hardirqs last disabled at (11012): [<ffffb5f93cb58cb0>] 
_raw_spin_lock_irqsave+0xe0/0x100
[   16.304513] softirqs last  enabled at (5926): [<ffffb5f93b9f0a78>] 
__do_softirq+0x4b8/0x6a0
[   16.304524] softirqs last disabled at (5917): [<ffffb5f93ba887a0>] 
__irq_exit_rcu+0x13c/0x22c
[   16.304536] ---[ end trace 0000000000000000 ]---
[   16.311207] ------------[ cut here ]------------


The first part of the kernel log can be found here (until it expires in 
a day or so) https://paste.centos.org/view/5437f080

and the ACPI/SSDT description of the devices with the size+translations 
can be found here:

https://github.com/tianocore/edk2-platforms/blob/4d99e0382809d2adfa289285b3efb57fdffa4598/Platform/RaspberryPi/AcpiTables/Emmc.asl#L36

On 9/11/22 04:06, Jianmin Lv wrote:
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
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>   drivers/acpi/arm64/dma.c | 28 ++++++++++++---------
>   drivers/acpi/scan.c      | 53 +++++++++++++++++-----------------------
>   include/acpi/acpi_bus.h  |  3 +--
>   include/linux/acpi.h     |  7 +++---
>   4 files changed, 44 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index f16739ad3cc0..93d796531af3 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -4,11 +4,12 @@
>   #include <linux/device.h>
>   #include <linux/dma-direct.h>
>   
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +void acpi_arch_dma_setup(struct device *dev)
>   {
>   	int ret;
>   	u64 end, mask;
> -	u64 dmaaddr = 0, size = 0, offset = 0;
> +	u64 size = 0;
> +	const struct bus_dma_region *map = NULL;
>   
>   	/*
>   	 * If @dev is expected to be DMA-capable then the bus code that created
> @@ -26,7 +27,19 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	else
>   		size = 1ULL << 32;
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
> +		size = end + 1;
> +		dev->dma_range_map = map;
> +	}
> +
>   	if (ret == -ENODEV)
>   		ret = iort_dma_get_ranges(dev, &size);
>   	if (!ret) {
> @@ -34,17 +47,10 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   		 * Limit coherent and dma mask based on size retrieved from
>   		 * firmware.
>   		 */
> -		end = dmaaddr + size - 1;
> +		end = size - 1;
>   		mask = DMA_BIT_MASK(ilog2(end) + 1);
>   		dev->bus_dma_limit = end;
>   		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>   		*dev->dma_mask = min(*dev->dma_mask, mask);
>   	}
> -
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
>   }
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 42cec8120f18..f96ef8536037 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -20,6 +20,7 @@
>   #include <linux/platform_data/x86/apple.h>
>   #include <linux/pgtable.h>
>   #include <linux/crc32.h>
> +#include <linux/dma-direct.h>
>   
>   #include "internal.h"
>   
> @@ -1467,25 +1468,21 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>    * acpi_dma_get_range() - Get device DMA parameters.
>    *
>    * @dev: device to configure
> - * @dma_addr: pointer device DMA address result
> - * @offset: pointer to the DMA offset result
> - * @size: pointer to DMA range size result
> + * @map: pointer to DMA ranges result
>    *
> - * Evaluate DMA regions and return respectively DMA region start, offset
> - * and size in dma_addr, offset and size on parsing success; it does not
> - * update the passed in values on failure.
> + * Evaluate DMA regions and return pointer to DMA regions on
> + * parsing success; it does not update the passed in values on failure.
>    *
>    * Return 0 on success, < 0 on failure.
>    */
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size)
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	struct acpi_device *adev;
>   	LIST_HEAD(list);
>   	struct resource_entry *rentry;
>   	int ret;
>   	struct device *dma_dev = dev;
> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> +	struct bus_dma_region *r;
>   
>   	/*
>   	 * Walk the device tree chasing an ACPI companion with a _DMA
> @@ -1510,31 +1507,28 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   
>   	ret = acpi_dev_get_dma_resources(adev, &list);
>   	if (ret > 0) {
> +		r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
> +		if (!r) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
>   		list_for_each_entry(rentry, &list, node) {
> -			if (dma_offset && rentry->offset != dma_offset) {
> +			if (rentry->res->start >= rentry->res->end) {
> +				kfree(r);
>   				ret = -EINVAL;
> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>   				goto out;
>   			}
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
>   		}
>   
> -		*dma_addr = dma_start - dma_offset;
> -		len = dma_end - dma_start;
> -		*size = max(len, len + 1);
> -		*offset = dma_offset;
> +		*map = r;
>   	}
>    out:
>   	acpi_dev_free_resource_list(&list);
> @@ -1624,20 +1618,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			  const u32 *input_id)
>   {
>   	const struct iommu_ops *iommu;
> -	u64 dma_addr = 0, size = 0;
>   
>   	if (attr == DEV_DMA_NOT_SUPPORTED) {
>   		set_dma_ops(dev, &dma_dummy_ops);
>   		return 0;
>   	}
>   
> -	acpi_arch_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev);
>   
>   	iommu = acpi_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>   		return -EPROBE_DEFER;
>   
> -	arch_setup_dma_ops(dev, dma_addr, size,
> +	arch_setup_dma_ops(dev, 0, U64_MAX,
>   				iommu, attr == DEV_DMA_COHERENT);
>   
>   	return 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e7d27373ff71..73ac4a1d6947 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -613,8 +613,7 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>   			   struct fwnode_handle *fwnode,
>   			   const struct iommu_ops *ops);
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size);
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			   const u32 *input_id);
>   static inline int acpi_dma_configure(struct device *dev,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6f64b2f3dc54..bb41623dab77 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -281,12 +281,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>   
>   #ifdef CONFIG_ARM64
>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
> +void acpi_arch_dma_setup(struct device *dev);
>   #else
>   static inline void
>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>   static inline void
> -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
> +acpi_arch_dma_setup(struct device *dev) { }
>   #endif
>   
>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> @@ -977,8 +977,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>   	return DEV_DMA_NOT_SUPPORTED;
>   }
>   
> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> -				     u64 *offset, u64 *size)
> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	return -ENODEV;
>   }

