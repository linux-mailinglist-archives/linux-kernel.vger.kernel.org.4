Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6967F67A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjA1ItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1ItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:49:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C31D91E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674895757; x=1706431757;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mR5VBMjCs+XRveeUOubky32oufU08sOYbLJ69XTsVo8=;
  b=OHv7aNrNdD5kGlSjR6/hxX0k8BeAJcieAXEp0aV7lEERd+2lvMNlvWi+
   or4uF+gbNT57EhOfe+BrRPAsMWaB/CgzInYYqlcOBT5bEfzGbQ7yoKo/b
   UqeX4EvwO4f+6GjaGoL4TZkg+h9MMTMywj5a6vgrCGBiaiABDfG8XdskZ
   7UKR8LvDvHW5EoR7pwoi9UvMkpFLTzAu1q5MWqXnHmE5fDcaZzklzEpQf
   kBH0JZVfqVZUK/kwCvegzDcmbwRmsaHwvxqEtzmbNrarRymfsskLCerOV
   eAlCfBdJ8FLuiC0soqsEmQBlCWafLHSqf9Uv18xS6TDHoHniACES0ouA3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329403532"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="329403532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:49:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726957023"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="726957023"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:49:14 -0800
Message-ID: <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com>
Date:   Sat, 28 Jan 2023 16:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com> <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com> <Y9PxKLyQg/+ZrK6a@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y9PxKLyQg/+ZrK6a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 23:43, Jason Gunthorpe wrote:
> On Fri, Jan 27, 2023 at 03:19:55PM +0000, Robin Murphy wrote:
> 
>> The current implementation of device_iommu_mapped() just dates back to when
>> dev->iommu_group was the only per-device thing we had, so in principle I
>> don't have any conceptual objection to redefining it in terms of "device has
>> ops" rather than "device has a group", but as things stand you'd still have
>> to do something about PPC first (I know Jason had been pushing on that, but
>> I've not kept track of where it got to).
> PPC hasn't moved at all, AFAICT. In a few more months I'm going to
> suggest we delete the special VFIO support due to it being broken,
> distros already having turned it off and nobody caring enough to fix
> it..
> 
> What does device_iommu_mapped() even really mean?
> 
> Looking at usages..
> 
> These are fixing SOC HW bugs/issues - the desire seems to be "is the SOC's
> IOMMU enabled"
> 
> drivers/char/agp/intel-gtt.c:           device_iommu_mapped(&intel_private.pcidev->dev));
> drivers/dma/sh/rcar-dmac.c:     if (device_iommu_mapped(&pdev->dev))
> drivers/gpu/drm/i915/i915_utils.c:      if (device_iommu_mapped(i915->drm.dev))
> ?
> drivers/usb/dwc3/dwc3-xilinx.c: if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
> drivers/usb/host/xhci.c:        if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
> drivers/crypto/qat/qat_common/adf_sriov.c:      if (!device_iommu_mapped(&pdev->dev))
> ?
> 
> These seem to be trying to decide if iommu_domain's can be used (and
> they can't be on power):
> 
> drivers/gpu/drm/msm/msm_drv.c:  if (device_iommu_mapped(mdp_dev))
> drivers/gpu/drm/msm/msm_drv.c:          device_iommu_mapped(dev->dev) ||
> drivers/gpu/drm/msm/msm_drv.c:          device_iommu_mapped(dev->dev->parent);
> drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:     if (device_iommu_mapped(dev)) {
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    if (!device_iommu_mapped(dev))
> drivers/gpu/drm/tegra/uapi.c:   if (device_iommu_mapped(client->base.dev) && client->ops->can_use_memory_ctx) {
> drivers/gpu/host1x/context.c:           if (!fwspec || !device_iommu_mapped(&ctx->dev)) {
> drivers/infiniband/hw/usnic/usnic_ib_main.c:    if (!device_iommu_mapped(&pdev->dev)) {
> 
> Yikes, trying to map DMA addresses programmed into devices back to CPU addresses:
> 
> drivers/misc/habanalabs/common/debugfs.c: if (!user_address || device_iommu_mapped(&hdev->pdev->dev)) {
> drivers/misc/habanalabs/gaudi2/gaudi2.c:                if (!device_iommu_mapped(&hdev->pdev->dev))
> 
> And then sequencing the call to iommu_probe_device() which doesn't
> apply to power:
> 
> drivers/acpi/scan.c:    if (!err && dev->bus && !device_iommu_mapped(dev))
> drivers/iommu/of_iommu.c:       if (!err && dev->bus && !device_iommu_mapped(dev))
> 
> Leaving these:
> 
> arch/powerpc/kernel/eeh.c:      if (device_iommu_mapped(dev)) {
> 
> This is only used to support eeh_iommu_group_to_pe which is only
> caleld by vfio_iommu_spapr_tce.c. Since power vfio doesn't work right
> now this is uncallable, and when power is fixed this will work
> properly.
> 
> arch/powerpc/kernel/iommu.c:    if (device_iommu_mapped(dev)) {
> arch/powerpc/kernel/iommu.c:    if (!device_iommu_mapped(dev)) {
> 
> These should both be replaced with some kind of 'device has iommu group', since
> it is really driving ppc unique group logic.
> 
> So, I'd say Baolu's approach is the right thing, just replace the
> above two in ppc with something else.

Thank you both. I will follow up a series later.

Best regards,
baolu
