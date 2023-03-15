Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09B6BB9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCOQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCOQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:36:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34BE41ADC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A37C4B3;
        Wed, 15 Mar 2023 09:36:53 -0700 (PDT)
Received: from [10.57.53.168] (unknown [10.57.53.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318643F67D;
        Wed, 15 Mar 2023 09:36:04 -0700 (PDT)
Message-ID: <56c16706-4e2d-7ab8-6325-48d06b129c50@arm.com>
Date:   Wed, 15 Mar 2023 16:36:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/5] iommu: Retire detach_dev callback
Content-Language: en-GB
To:     Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230110025408.667767-1-baolu.lu@linux.intel.com>
 <26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com>
 <1f697bcf-31f9-7e04-a8e7-1609cf330af3@arm.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <1f697bcf-31f9-7e04-a8e7-1609cf330af3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 15:57, Robin Murphy wrote:
> On 2023-03-15 15:49, Steven Price wrote:
>> On 10/01/2023 02:54, Lu Baolu wrote:
>>> Hi folks,
>>>
>>> The iommu core calls the driver's detach_dev domain op callback only
>>> when
>>> a device is finished assigning to user space and
>>> iommu_group_release_dma_owner() is called to return the device to the
>>> kernel, where iommu core wants to set the default domain to the
>>> device but
>>> the driver didn't provide one. The code looks like:
>>>
>>>          /*
>>>           * New drivers should support default domains and so the
>>> detach_dev() op
>>>           * will never be called. Otherwise the NULL domain
>>> represents some
>>>           * platform specific behavior.
>>>           */
>>>          if (!new_domain) {
>>>                  if (WARN_ON(!group->domain->ops->detach_dev))
>>>                          return -EINVAL;
>>>                  __iommu_group_for_each_dev(group, group->domain,
>>>                                            
>>> iommu_group_do_detach_device);
>>>                  group->domain = NULL;
>>>                  return 0;
>>>          }
>>>
>>> In other words, if the iommu driver provides default domains, the
>>> .detach_dev callback will never be called; Otherwise, the .detach_dev
>>> callback is actually called to return control back to the platform DMA
>>> ops, other than detaching the domain from device.
>>>
>>> This series cleanups this by:
>>>
>>> - If the IOMMU driver provides default domains, remove .detach_dev
>>>    callback.
>>> - Adds a new set_platform_dma iommu op. Any IOMMU driver that doesn't
>>>    provide default domain should implement set_platform_dma callback
>>>    instead.
>>> - Retire .detach_dev callback.
>>>
>>> This series originates from various discussion in the community. Thanks
>>> to Jason, Robin and all others for their ideas.
>>>
>>> The whole series is available on github:
>>> https://github.com/LuBaolu/intel-iommu/commits/iommu-retire-detach_dev-v5
>>>
>>> Change log:
>>> v5:
>>>   - Merge some patches to make the series cute. No functionality
>>> changes.
>>>   - Check the op directly and WARN_ON the lack of any necessary
>>>     callbacks. Get rid of the ret and EINVAL.
>>>
>>> v4:
>>>   -
>>> https://lore.kernel.org/linux-iommu/20230104125725.271850-1-baolu.lu@linux.intel.com/
>>>   - Drop the patch which renamed .attach_dev to .set_dev. As Robin said,
>>>     "... I also wouldn't say that "attach" loses its meaning in a
>>> context
>>>     where an equivalent "detach" operation is only ever implicit in
>>>     reattaching to something else...". If we have a better name in the
>>>     future, we can do it in other series.
>>>   - Adjust the patch of "iommu: Add set_platform_dma_ops iommu ops"
>>>     according to Jason's following suggestion " ... This is a bit ugly,
>>>     it would be better to make the previous patch call set_platform_dma
>>>     if it is set instead of detach_dev and then these patches should
>>> just
>>>     rename the driver's fsl_pamu_detach_device to
>>>     fsl_pamu_set_platform_dma ..."
>>>   - Add a new patch to remove deferred attach check from
>>>     __iommu_detach_domain() path. Make it a separate patch as the
>>>     prerequisite to remove __iommu_detach_device() helper.
>>>   - Rename set_platform_dma to set_platform_dma_ops to make it more
>>>     meaningful.
>>>
>>> v3:
>>>   -
>>> https://lore.kernel.org/linux-iommu/20221128064648.1934720-1-baolu.lu@linux.intel.com/
>>>   - Setting blocking domain is not conceptually equal to detach_dev.
>>>     Dropped all blocking domain related staffs in the previous version.
>>>
>>> v2:
>>>   -
>>> https://lore.kernel.org/linux-iommu/20220826123014.52709-1-baolu.lu@linux.intel.com/
>>>   - Replace .detach_dev callback with static block domain ops;
>>>   - Rename .attach_dev to .set_dev.
>>>
>>> v1:
>>>   -
>>> https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/
>>>
>>> Jason Gunthorpe (1):
>>>    iommu: Remove deferred attach check from __iommu_detach_device()
>>>
>>> Lu Baolu (4):
>>>    iommu: Remove detach_dev callbacks
>>>    iommu: Add set_platform_dma_ops iommu ops
>>>    iommu: Add set_platform_dma_ops callbacks
>>>    iommu: Remove detach_dev callback
>>>
>>>   include/linux/iommu.h                   |  8 ++-
>>>   include/trace/events/iommu.h            |  7 --
>>>   drivers/iommu/amd/iommu.c               | 26 -------
>>>   drivers/iommu/apple-dart.c              | 24 -------
>>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 ------
>>>   drivers/iommu/exynos-iommu.c            |  1 -
>>>   drivers/iommu/fsl_pamu_domain.c         |  6 +-
>>>   drivers/iommu/iommu-traces.c            |  1 -
>>>   drivers/iommu/iommu.c                   | 94 ++++++++++++-------------
>>>   drivers/iommu/ipmmu-vmsa.c              | 16 -----
>>>   drivers/iommu/msm_iommu.c               |  6 +-
>>>   drivers/iommu/mtk_iommu.c               |  9 ---
>>>   drivers/iommu/mtk_iommu_v1.c            |  4 +-
>>>   drivers/iommu/omap-iommu.c              |  6 +-
>>>   drivers/iommu/rockchip-iommu.c          |  1 -
>>>   drivers/iommu/s390-iommu.c              |  7 +-
>>>   drivers/iommu/sprd-iommu.c              | 16 -----
>>>   drivers/iommu/sun50i-iommu.c            |  1 -
>>>   drivers/iommu/tegra-gart.c              |  6 +-
>>>   drivers/iommu/tegra-smmu.c              |  5 +-
>>>   20 files changed, 69 insertions(+), 198 deletions(-)
>>>
>>
>> I hit a problem with this series on a Firefly-RK3288, I bisected down to
>> 1b932ceddd19 ("iommu: Remove detach_dev callbacks"). The first splat is:
>>
>> [    7.227853] ------------[ cut here ]------------
>> [    7.227900] WARNING: CPU: 0 PID: 9 at drivers/iommu/iommu.c:2198
>> __iommu_group_set_domain+0xb4/0xc8
>> [    7.227920] Modules linked in:
>> [    7.227935] CPU: 0 PID: 9 Comm: kworker/u8:0 Not tainted 6.3.0-rc1 #1
>> [    7.227942] Hardware name: Rockchip (Device Tree)
>> [    7.227948] Workqueue: events_unbound deferred_probe_work_func
>> [    7.227964]  unwind_backtrace from show_stack+0x10/0x14
>> [    7.227978]  show_stack from dump_stack_lvl+0x58/0x70
>> [    7.227992]  dump_stack_lvl from __warn+0x7c/0x1dc
>> [    7.228008]  __warn from warn_slowpath_fmt+0xbc/0x1a0
>> [    7.228022]  warn_slowpath_fmt from __iommu_group_set_domain+0xb4/0xc8
>> [    7.228035]  __iommu_group_set_domain from
>> iommu_detach_device+0x84/0xf8
>> [    7.228046]  iommu_detach_device from
>> arm_iommu_detach_device+0x24/0xc4
>> [    7.228057]  arm_iommu_detach_device from
>> rockchip_drm_dma_attach_device+0x30/0x74
>> [    7.228073]  rockchip_drm_dma_attach_device from
>> vop_crtc_atomic_enable+0xf8/0xab0
>> [    7.228085]  vop_crtc_atomic_enable from
>> drm_atomic_helper_commit_modeset_enables+0xb0/0x2a0
>> [    7.228097]  drm_atomic_helper_commit_modeset_enables from
>> drm_atomic_helper_commit_tail_rpm+0x44/0x8c
>> [    7.228111]  drm_atomic_helper_commit_tail_rpm from
>> commit_tail+0x9c/0x184
>> [    7.228124]  commit_tail from drm_atomic_helper_commit+0x164/0x18c
>> [    7.228137]  drm_atomic_helper_commit from drm_atomic_commit+0xb0/0xe8
>> [    7.228153]  drm_atomic_commit from
>> drm_client_modeset_commit_atomic+0x240/0x288
>> [    7.228166]  drm_client_modeset_commit_atomic from
>> drm_client_modeset_commit_locked+0x60/0x1cc
>> [    7.228174]  drm_client_modeset_commit_locked from
>> drm_client_modeset_commit+0x24/0x40
>> [    7.228183]  drm_client_modeset_commit from
>> drm_fb_helper_set_par+0xb8/0xf8
>> [    7.228197]  drm_fb_helper_set_par from fbcon_init+0x2a0/0x534
>> [    7.228211]  fbcon_init from visual_init+0xc0/0x108
>> [    7.228224]  visual_init from do_bind_con_driver+0x1bc/0x3a8
>> [    7.228237]  do_bind_con_driver from do_take_over_console+0x134/0x1d4
>> [    7.228251]  do_take_over_console from do_fbcon_takeover+0x6c/0xcc
>> [    7.228264]  do_fbcon_takeover from fbcon_fb_registered+0x198/0x1a8
>> [    7.228277]  fbcon_fb_registered from register_framebuffer+0x1d0/0x268
>> [    7.228292]  register_framebuffer from
>> __drm_fb_helper_initial_config_and_unlock+0x358/0x578
>> [    7.228308]  __drm_fb_helper_initial_config_and_unlock from
>> drm_fbdev_client_hotplug+0x6c/0xa8
>> [    7.228322]  drm_fbdev_client_hotplug from
>> drm_fbdev_generic_setup+0x84/0x174
>> [    7.228335]  drm_fbdev_generic_setup from
>> rockchip_drm_bind+0x1dc/0x200
>> [    7.228349]  rockchip_drm_bind from
>> try_to_bring_up_aggregate_device+0x200/0x2d8
>> [    7.228368]  try_to_bring_up_aggregate_device from
>> component_master_add_with_match+0xc4/0xf8
>> [    7.228380]  component_master_add_with_match from
>> rockchip_drm_platform_probe+0x150/0x254
>> [    7.228392]  rockchip_drm_platform_probe from platform_probe+0x5c/0xb8
>> [    7.228405]  platform_probe from really_probe+0xe0/0x400
>> [    7.228417]  really_probe from __driver_probe_device+0x9c/0x1fc
>> [    7.228431]  __driver_probe_device from driver_probe_device+0x30/0xc0
>> [    7.228445]  driver_probe_device from
>> __device_attach_driver+0xa8/0x120
>> [    7.228460]  __device_attach_driver from bus_for_each_drv+0x84/0xdc
>> [    7.228474]  bus_for_each_drv from __device_attach+0xb0/0x20c
>> [    7.228488]  __device_attach from bus_probe_device+0x8c/0x90
>> [    7.228502]  bus_probe_device from deferred_probe_work_func+0x98/0xe0
>> [    7.228515]  deferred_probe_work_func from
>> process_one_work+0x290/0x740
>> [    7.228528]  process_one_work from worker_thread+0x54/0x518
>> [    7.228536]  worker_thread from kthread+0xf0/0x110
>> [    7.228548]  kthread from ret_from_fork+0x14/0x2c
>> [    7.228561] Exception stack(0xf084dfb0 to 0xf084dff8)
>> [    7.228567] dfa0:                                     00000000
>> 00000000 00000000 00000000
>> [    7.228573] dfc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [    7.228579] dfe0: 00000000 00000000 00000000 00000000 00000013
>> 00000000
>> [    7.228585] irq event stamp: 138379
>> [    7.228592] hardirqs last  enabled at (138385): [<c03c42ac>]
>> vprintk_emit+0x330/0x354
>> [    7.228606] hardirqs last disabled at (138390): [<c03c4268>]
>> vprintk_emit+0x2ec/0x354
>> [    7.228617] softirqs last  enabled at (137258): [<c03016ac>]
>> __do_softirq+0x2f8/0x548
>> [    7.228628] softirqs last disabled at (137253): [<c0350218>]
>> __irq_exit_rcu+0x14c/0x170
>> [    7.228639] ---[ end trace 0000000000000000 ]---
>>
>> (complete log attached)
>>
>> I'm not sure how to debug this. From the callstack I can see that
>> __iommu_group_set_domain is getting a NULL new_domain which triggers
>> a call to __iommu_group_do_set_platform_dma which is WARNing because
>> there is no set_platform_dma_ops callback. The NULL new_domain is
>> because group->default_domain is NULL in __iommu_group_set_core_domain.
>>
>> So is the logic in the first patch that there is a default domain
>> incorrect for this rockchip driver? Or is this callpath just hitting
>> the function before the default domain can be created?
>>
>> Help debugging this would be appreciated - I'm not very familiar
>> with this area of code.
> 
> It's the same thing Marek hit on Exynos: drivers which run on 32-bit Arm
> need a .set_platform_dma op, regardless of whether they support default
> domains on other platforms which use those.

Ah, that seems to be it. I'll post a patch.

Thanks,

Steve

