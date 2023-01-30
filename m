Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDD680F53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjA3Ntj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3Ntc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:49:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FCBF3864D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:49:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB551758;
        Mon, 30 Jan 2023 05:50:07 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98B1E3F885;
        Mon, 30 Jan 2023 05:49:24 -0800 (PST)
Message-ID: <14a5130c-3180-87db-5a14-2aaeaf97b7ce@arm.com>
Date:   Mon, 30 Jan 2023 13:49:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com> <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com> <Y9PxKLyQg/+ZrK6a@nvidia.com>
 <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-28 08:49, Baolu Lu wrote:
> On 2023/1/27 23:43, Jason Gunthorpe wrote:
>> On Fri, Jan 27, 2023 at 03:19:55PM +0000, Robin Murphy wrote:
>>
>>> The current implementation of device_iommu_mapped() just dates back 
>>> to when
>>> dev->iommu_group was the only per-device thing we had, so in principle I
>>> don't have any conceptual objection to redefining it in terms of 
>>> "device has
>>> ops" rather than "device has a group", but as things stand you'd 
>>> still have
>>> to do something about PPC first (I know Jason had been pushing on 
>>> that, but
>>> I've not kept track of where it got to).
>> PPC hasn't moved at all, AFAICT. In a few more months I'm going to
>> suggest we delete the special VFIO support due to it being broken,
>> distros already having turned it off and nobody caring enough to fix
>> it..
>>
>> What does device_iommu_mapped() even really mean?
>>
>> Looking at usages..
>>
>> These are fixing SOC HW bugs/issues - the desire seems to be "is the 
>> SOC's
>> IOMMU enabled"
>>
>> drivers/char/agp/intel-gtt.c:           
>> device_iommu_mapped(&intel_private.pcidev->dev));
>> drivers/dma/sh/rcar-dmac.c:     if (device_iommu_mapped(&pdev->dev))
>> drivers/gpu/drm/i915/i915_utils.c:      if 
>> (device_iommu_mapped(i915->drm.dev))
>> ?
>> drivers/usb/dwc3/dwc3-xilinx.c: if (of_dma_is_coherent(dev->of_node) 
>> || device_iommu_mapped(dev)) {
>> drivers/usb/host/xhci.c:        if (!(xhci->quirks & 
>> XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
>> drivers/crypto/qat/qat_common/adf_sriov.c:      if 
>> (!device_iommu_mapped(&pdev->dev))
>> ?
>>
>> These seem to be trying to decide if iommu_domain's can be used (and
>> they can't be on power):
>>
>> drivers/gpu/drm/msm/msm_drv.c:  if (device_iommu_mapped(mdp_dev))
>> drivers/gpu/drm/msm/msm_drv.c:          device_iommu_mapped(dev->dev) ||
>> drivers/gpu/drm/msm/msm_drv.c:          
>> device_iommu_mapped(dev->dev->parent);
>> drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:     if 
>> (device_iommu_mapped(dev)) {
>> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    if 
>> (!device_iommu_mapped(dev))
>> drivers/gpu/drm/tegra/uapi.c:   if 
>> (device_iommu_mapped(client->base.dev) && 
>> client->ops->can_use_memory_ctx) {
>> drivers/gpu/host1x/context.c:           if (!fwspec || 
>> !device_iommu_mapped(&ctx->dev)) {
>> drivers/infiniband/hw/usnic/usnic_ib_main.c:    if 
>> (!device_iommu_mapped(&pdev->dev)) {
>>
>> Yikes, trying to map DMA addresses programmed into devices back to CPU 
>> addresses:
>>
>> drivers/misc/habanalabs/common/debugfs.c: if (!user_address || 
>> device_iommu_mapped(&hdev->pdev->dev)) {
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:                if 
>> (!device_iommu_mapped(&hdev->pdev->dev))
>>
>> And then sequencing the call to iommu_probe_device() which doesn't
>> apply to power:
>>
>> drivers/acpi/scan.c:    if (!err && dev->bus && 
>> !device_iommu_mapped(dev))
>> drivers/iommu/of_iommu.c:       if (!err && dev->bus && 
>> !device_iommu_mapped(dev))
>>
>> Leaving these:
>>
>> arch/powerpc/kernel/eeh.c:      if (device_iommu_mapped(dev)) {
>>
>> This is only used to support eeh_iommu_group_to_pe which is only
>> caleld by vfio_iommu_spapr_tce.c. Since power vfio doesn't work right
>> now this is uncallable, and when power is fixed this will work
>> properly.

Oh wow, I should have looked at more context... Even better, this one is 
already just an elaborate "if (true)" - it has been impossible for 
dev_has_iommu_table() to return 0 since at least 2015 :D
>> arch/powerpc/kernel/iommu.c:    if (device_iommu_mapped(dev)) {
>> arch/powerpc/kernel/iommu.c:    if (!device_iommu_mapped(dev)) {
>>
>> These should both be replaced with some kind of 'device has iommu 
>> group', since
>> it is really driving ppc unique group logic.

And in fact those appear to mostly serve for printing debug messages; if 
we made iommu_group_add_device() return -EBUSY for duplicate calls (not 
necessarily a bad idea anyway vs. relying on the noisy failure of 
sysfs_create_link()), they could arguably just go.

All in all, it's only actually the habanalabs ones that I'm slightly 
wary of, since they're effectively (mis)using device_iommu_mapped() to 
infer the DMA ops implementation, which could potentially go wrong (or 
at least *more* wrong) on POWER with this change. I guess the saving 
grace is that although they are available on PCIe-interfaced modules, 
the userspace driver stack seems to be implicitly x86_64-only - as far 
as I could tell from a quick poke around their site and documentation, 
which doesn't appear to acknowledge the concept of CPU architectures at 
all - so the chances of anyone actually trying to use the kernel drivers 
in anger on POWER seem minimal.

Thanks,
Robin.

>> So, I'd say Baolu's approach is the right thing, just replace the
>> above two in ppc with something else.
> 
> Thank you both. I will follow up a series later.
> 
> Best regards,
> baolu
