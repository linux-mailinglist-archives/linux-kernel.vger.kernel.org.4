Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6F6AB4CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCFC7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFC7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479110419
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071557; x=1709607557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ubDKJPz7LI3eEIbVA/X1FG8UptdiqBziq+folsggKew=;
  b=loQ2l8wtHeRqOZ1dTE+oFp22bw+gX9/iTOAgkcgjMiaF8pNTaoUYsDel
   hDTUXE7udma+Tyvvz+QcKxlXPxtEclqVyYkfVPNBqU9FzXcuFYtt10XYn
   nW+y8keBRUZ5vf1ftEVNACWjspMg1qynw/gVQCu9DYDqAjCaKQcXD1TUL
   /wSZPYbcbbJrG/K1bAQByK3eniEP3rmDtb6j1EqXnlStfx9Cux/ioQ8Jm
   8CyfUr2KrYHKB9tU2pZE4ml7akDFPJH2Hkk2AJhgxrih3V0vDCed5+agm
   vj+lNzY6fIqKTPvbiGzT+z2QmI2wooaC9/scGtpdWS6RbJgpTHT+FVHBc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071480"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071480"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072469"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072469"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:15 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/6] ARM/dma-mapping: Add arm_iommu_release_device()
Date:   Mon,  6 Mar 2023 10:57:59 +0800
Message-Id: <20230306025804.13912-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306025804.13912-1-baolu.lu@linux.intel.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is like arm_iommu_detach_device() except it handles the special case
of being called under an iommu driver's release operation. In this case
the driver must have already detached the device from any attached
domain before calling this function.

Replace arm_iommu_detach_device() with arm_iommu_release_device() in the
release path of the ipmmu-vmsa driver.

The bonus is that it also removes a obstacle of arm_iommu_detach_device()
re-entering the iommu core during release_device. With this removed, the
iommu core code could be simplified a lot.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/arm/include/asm/dma-iommu.h |  1 +
 arch/arm/mm/dma-mapping.c        | 25 +++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c       | 15 +++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index fe9ef6f79e9c..ea7198a17861 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -31,6 +31,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
+void arm_iommu_release_device(struct device *dev);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8bc01071474a..96fa27f4a164 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1682,6 +1682,31 @@ int arm_iommu_attach_device(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
+/**
+ * arm_iommu_release_device
+ * @dev: valid struct device pointer
+ *
+ * This is like arm_iommu_detach_device() except it handles the special
+ * case of being called under an iommu driver's release operation. In this
+ * case the driver must have already detached the device from any attached
+ * domain before calling this function.
+ */
+void arm_iommu_release_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping;
+
+	mapping = to_dma_iommu_mapping(dev);
+	if (!mapping) {
+		dev_warn(dev, "Not attached\n");
+		return;
+	}
+
+	kref_put(&mapping->kref, release_iommu_mapping);
+	to_dma_iommu_mapping(dev) = NULL;
+	set_dma_ops(dev, NULL);
+}
+EXPORT_SYMBOL_GPL(arm_iommu_release_device);
+
 /**
  * arm_iommu_detach_device
  * @dev: valid struct device pointer
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..de9c74cf61a4 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -30,7 +30,7 @@
 #define arm_iommu_create_mapping(...)	NULL
 #define arm_iommu_attach_device(...)	-ENODEV
 #define arm_iommu_release_mapping(...)	do {} while (0)
-#define arm_iommu_detach_device(...)	do {} while (0)
+#define arm_iommu_release_device(...)	do {} while (0)
 #endif
 
 #define IPMMU_CTX_MAX		16U
@@ -820,7 +820,18 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	arm_iommu_detach_device(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	unsigned int i;
+
+	for (i = 0; i < fwspec->num_ids; ++i) {
+		unsigned int utlb = fwspec->ids[i];
+
+		ipmmu_imuctr_write(mmu, utlb, 0);
+		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
+	}
+
+	arm_iommu_release_device(dev);
 }
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
-- 
2.34.1

