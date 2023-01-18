Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98B6724D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjARR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjARR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:26:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 411E1125AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:26:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99DB92B;
        Wed, 18 Jan 2023 09:26:49 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A68C43F445;
        Wed, 18 Jan 2023 09:26:06 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3] iommu: Optimise PCI SAC address trick
Date:   Wed, 18 Jan 2023 17:26:00 +0000
Message-Id: <e9abc601b00e26fd15a583fcd55f2a8227903077.1674061620.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
PCI SAC address trick") and its subsequent revert, this mechanism no
longer serves its original purpose, but now only works around broken
hardware/drivers in a way that is unfortunately too impactful to remove.

This does not, however prevent us from solving the performance impact
which the workaround imposes on large-scale systems that don't need it.
That is felt once the 32-bit IOVA space fills up and we keep
unsuccessfully trying to allocate from it. However, if we get to that
point then in fact it's already the endgame. The nature of the allocator
is such that the first IOVA we give to a device after the 32-bit space
runs out will be the highest possible address for that device, ever.
If that works, then great, we can be pretty sure it's safe to optimise
for speed by always allocating from the full range. And if it doesn't,
then the worst has already happened and any brokenness is now showing,
so there's no point continuing to try to hide it.

To that end, implement a flag to refine this into a per-device policy
that can automatically get itself out of the way if and when it stops
being useful.

CC: John Garry <john.garry@huawei.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Expand the flag name, add a print with inline commentary for good
    measure, and refactor the code flow even more (too many ifs and
    indents...) such that I didn't presume to carry forward John's R-b.

 drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++------
 drivers/iommu/dma-iommu.h |  8 ++++++++
 drivers/iommu/iommu.c     |  3 +++
 include/linux/iommu.h     |  2 ++
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f798c44e0903..1dccee3628cf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -627,7 +627,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long shift, iova_len, iova = 0;
+	unsigned long shift, iova_len, iova;
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -642,15 +642,29 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
 
-	/* Try to get PCI devices a SAC address */
-	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
+	/*
+	 * Try to use all the 32-bit PCI addresses first. The original SAC vs.
+	 * DAC reasoning loses relevance with PCIe, but enough hardware and
+	 * firmware bugs are still lurking out there that it's safest not to
+	 * venture into the 64-bit space until necessary.
+	 *
+	 * If your device goes wrong after seeing the notice then likely either
+	 * its driver is not setting DMA masks accurately, the hardware has
+	 * some inherent bug in handling >32-bit addresses, or not all the
+	 * expected address bits are wired up between the device and the IOMMU.
+	 */
+	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
 		iova = alloc_iova_fast(iovad, iova_len,
 				       DMA_BIT_MASK(32) >> shift, false);
+		if (iova)
+			goto done;
 
-	if (!iova)
-		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
-				       true);
+		dev->iommu->pci_32bit_workaround = false;
+		dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
+	}
 
+	iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true);
+done:
 	return (dma_addr_t)iova << shift;
 }
 
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 942790009292..c829f1f82a99 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -17,6 +17,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 extern bool iommu_dma_forcedac;
+static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
+{
+	dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
+}
 
 #else /* CONFIG_IOMMU_DMA */
 
@@ -38,5 +42,9 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..b189ed345057 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -353,6 +353,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&iommu_probe_device_lock);
 	iommu_device_link(iommu_dev, dev);
 
+	if (dev_is_pci(dev))
+		iommu_dma_set_pci_32bit_workaround(dev);
+
 	return 0;
 
 out_release:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..d37bf28faf82 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -401,6 +401,7 @@ struct iommu_fault_param {
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
  * @max_pasids:  number of PASIDs this device can consume
+ * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -413,6 +414,7 @@ struct dev_iommu {
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	u32				max_pasids;
+	bool				pci_32bit_workaround;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.36.1.dirty

