Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B935C0508
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiIURCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiIURBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:01:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E988870BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:00:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C621F13D5;
        Wed, 21 Sep 2022 10:01:04 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939AD3F5A1;
        Wed, 21 Sep 2022 10:00:57 -0700 (PDT)
Message-ID: <574fe371-033e-a316-4ace-8a3fd9b19329@arm.com>
Date:   Wed, 21 Sep 2022 18:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
 <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 5:24 pm, Linus Torvalds wrote:
> On Wed, Sep 21, 2022 at 5:53 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>> PCI SAC address trick") and its subsequent revert, this mechanism no
>> longer serves its original purpose, but now only works around broken
>> hardware/drivers in a way that is unfortunately too impactful to remove.
> 
> I was going to test this, since the previous version failed for me.
> But it's based on linux-next, and I didn't want to fight the conflicts
> (including - but not limited to - the header file being moved) so I
> dropped that plan.
> 
> If you think it's worth testing on the setup that used to fail, and
> you send me a version that applies on my current tree, I can do so.

No great rush - in principle this one *should* be entirely safe, but I'm
not suggesting we should hurry it into 6.0 or 6.1. I mostly just wanted
to make sure you got first dibs on any objection to this new approach :)

If you do want to have a play though, compile-tested cherry-pick below.

Thanks,
Robin.

----->8-----
Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
PCI SAC address trick") and its subsequent revert, this mechanism no
longer serves its original purpose, but now only works around broken
hardware/drivers in a way that is unfortunately too impactful to remove.

This does not, however prevent us from solving the performance impact
which that workaround has on large-scale systems that don't need it.
That kicks in once the 32-bit IOVA space fills up and we keep
unsuccessfully trying to allocate from it. However, if we get to that
point then in fact it's already the endgame. The nature of the allocator
is such that the first IOVA we give to a device after the 32-bit space
runs out will be the highest possible address for that device, ever.
If that works, then great, we know we can optimise for speed by always
allocating from the full range. And if it doesn't, then the worst has
already happened and any brokenness is now showing, so there's no point
continuing to try to hide it.

To that end, implement a flag to refine this into a per-device policy
that can automatically get itself out of the way if and when it stops
being useful.

CC: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/dma-iommu.c | 5 ++++-
  drivers/iommu/iommu.c     | 3 +++
  include/linux/dma-iommu.h | 8 ++++++++
  include/linux/iommu.h     | 2 ++
  4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 17dd683b2fce..61c057aba3ad 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -642,9 +642,12 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
  		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
  
  	/* Try to get PCI devices a SAC address */
-	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
+	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_workaround) {
  		iova = alloc_iova_fast(iovad, iova_len,
  				       DMA_BIT_MASK(32) >> shift, false);
+		if (!iova)
+			dev->iommu->pci_workaround = false;
+	}
  
  	if (!iova)
  		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a808146b50f..3348a67f603d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -256,6 +256,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
  
  	iommu_device_link(iommu_dev, dev);
  
+	if (dev_is_pci(dev))
+		iommu_dma_set_pci_workaround(dev);
+
  	return 0;
  
  out_release:
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..f2968b8e9f7d 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -42,6 +42,10 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
  		struct iommu_domain *domain);
  
  extern bool iommu_dma_forcedac;
+static inline void iommu_dma_set_pci_workaround(struct device *dev)
+{
+	dev->iommu->pci_workaround = !iommu_dma_forcedac;
+}
  
  #else /* CONFIG_IOMMU_DMA */
  
@@ -89,5 +93,9 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
  {
  }
  
+static inline void iommu_dma_set_pci_workaround(struct device *dev)
+{
+}
+
  #endif	/* CONFIG_IOMMU_DMA */
  #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..eff7a53850af 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -366,6 +366,7 @@ struct iommu_fault_param {
   * @fwspec:	 IOMMU fwspec data
   * @iommu_dev:	 IOMMU device this device is linked to
   * @priv:	 IOMMU Driver private data
+ * @pci_workaround: Limit DMA allocations to 32-bit IOVAs
   *
   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
   *	struct iommu_group	*iommu_group;
@@ -377,6 +378,7 @@ struct dev_iommu {
  	struct iommu_fwspec		*fwspec;
  	struct iommu_device		*iommu_dev;
  	void				*priv;
+	bool				pci_workaround;
  };
  
  int iommu_device_register(struct iommu_device *iommu,
-- 
2.36.1.dirty
