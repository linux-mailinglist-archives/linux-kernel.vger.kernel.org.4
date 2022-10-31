Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A64612E78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJaBGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJaBGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:06:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40409FDC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178366; x=1698714366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUhy7+fHq9NwxbO3ARISSF+PormUfUcThyIRGtESztE=;
  b=B/7tEksZVtdc+9yRcBrkC8MvTUba7nctZy+8wTkDgKWnCuqim47nrIgq
   5ZNeCvAIldzOgV0Z+dJrzuXVAA1VywtsJ8yljIWDLyxoTm33AMELpGWia
   /TBDppXJ97gDrPBUljDFYXQy4wBPb38sMpDudpSl4sDoo2vz7p3/St7L9
   n2ulMlDrwcI74x8A3FDRqSrkA2HstNobzuejHYD6m5h7wWHXwXujkmPbh
   DFk2aImoUzJtWDdx/EnxrFerRoQuTdCX4wn9h4ZwSwRfkB1ePbbAG2s9G
   edGt4SKBirj5uwRB/nUyCkS/FTPIYsPG1uvkxHsy1xcPTRn43hvPLrQlj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373001663"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373001663"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496150"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496150"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:06:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 03/13] iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
Date:   Mon, 31 Oct 2022 08:59:07 +0800
Message-Id: <20221031005917.45690-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel DMA with PASID support is based on the SVA with a flag
SVM_FLAG_SUPERVISOR_MODE. The IOMMU driver binds the kernel memory address
space to a PASID of the device. The device driver programs the device with
kernel virtual address (KVA) for DMA access. There have been security and
functional issues with this approach:

- The lack of IOTLB synchronization upon kernel page table updates.
  (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
- Other than slight more protection, using kernel virtual address (KVA)
  has little advantage over physical address. There are also no use
  cases yet where DMA engines need kernel virtual addresses for in-kernel
  DMA.

This removes SVM_FLAG_SUPERVISOR_MODE support from the IOMMU interface.
The device drivers are suggested to handle kernel DMA with PASID through
the kernel DMA APIs.

The drvdata parameter in iommu_sva_bind_device() and all callbacks is not
needed anymore. Cleanup them as well.

Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/intel-svm.h                     | 13 -----
 include/linux/iommu.h                         |  8 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +-
 drivers/iommu/intel/iommu.h                   |  3 +-
 drivers/dma/idxd/cdev.c                       |  3 +-
 drivers/dma/idxd/init.c                       | 25 +--------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +-
 drivers/iommu/intel/svm.c                     | 55 +++++--------------
 drivers/iommu/iommu.c                         |  5 +-
 drivers/misc/uacce/uacce.c                    |  2 +-
 10 files changed, 25 insertions(+), 97 deletions(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 207ef06ba3e1..f9a0d44f6fdb 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -13,17 +13,4 @@
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
 
-/*
- * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
- * for access to kernel addresses. No IOTLB flushes are automatically done
- * for kernel mappings; it is valid only for access to the kernel's static
- * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
- * A future API addition may permit the use of such ranges, by means of an
- * explicit IOTLB flush call (akin to the DMA API's unmap method).
- *
- * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
- * do such IOTLB flushes automatically.
- */
-#define SVM_FLAG_SUPERVISOR_MODE	BIT(0)
-
 #endif /* __INTEL_SVM_H__ */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac3f6c6dcc6d..72bb0531aa76 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -247,8 +247,7 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      void *drvdata);
+	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
@@ -668,8 +667,7 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
-					void *drvdata);
+					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
@@ -1000,7 +998,7 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..d2ba86470c42 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -754,8 +754,7 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    void *drvdata);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
@@ -791,7 +790,7 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
 }
 
 static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cce0598f4109..33e5bcaf2a6c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -748,8 +748,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 void *drvdata);
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
 void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index c2808fd081d6..66720001ba1c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -6,7 +6,6 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/sched/task.h>
-#include <linux/intel-svm.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/cdev.h>
 #include <linux/fs.h>
@@ -100,7 +99,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_user_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, NULL);
+		sva = iommu_sva_bind_device(dev, current->mm);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2b18d512cbfc..2c0fcfdc75c7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -14,7 +14,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/idr.h>
-#include <linux/intel-svm.h>
 #include <linux/iommu.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
@@ -502,29 +501,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	int flags;
-	unsigned int pasid;
-	struct iommu_sva *sva;
-
-	flags = SVM_FLAG_SUPERVISOR_MODE;
-
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
-	if (IS_ERR(sva)) {
-		dev_warn(&idxd->pdev->dev,
-			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
-		return PTR_ERR(sva);
-	}
-
-	pasid = iommu_sva_get_pasid(sva);
-	if (pasid == IOMMU_PASID_INVALID) {
-		iommu_sva_unbind_device(sva);
-		return -ENODEV;
-	}
-
-	idxd->sva = sva;
-	idxd->pasid = pasid;
-	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 5968a568aae2..8fcf0df4bd0e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -367,8 +367,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	return ERR_PTR(ret);
 }
 
-struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	struct iommu_sva *handle;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..94bc47b68c93 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -296,8 +296,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
-				 unsigned int flags)
+static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 {
 	ioasid_t max_pasid = dev_is_pci(dev) ?
 			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
@@ -307,8 +306,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
-					   struct mm_struct *mm,
-					   unsigned int flags)
+					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_svm_dev *sdev;
@@ -324,22 +322,18 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 
 		svm->pasid = mm->pasid;
 		svm->mm = mm;
-		svm->flags = flags;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
-		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
-			svm->notifier.ops = &intel_mmuops;
-			ret = mmu_notifier_register(&svm->notifier, mm);
-			if (ret) {
-				kfree(svm);
-				return ERR_PTR(ret);
-			}
+		svm->notifier.ops = &intel_mmuops;
+		ret = mmu_notifier_register(&svm->notifier, mm);
+		if (ret) {
+			kfree(svm);
+			return ERR_PTR(ret);
 		}
 
 		ret = pasid_private_add(svm->pasid, svm);
 		if (ret) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
+			mmu_notifier_unregister(&svm->notifier, mm);
 			kfree(svm);
 			return ERR_PTR(ret);
 		}
@@ -374,9 +368,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
-	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
@@ -390,8 +382,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	kfree(sdev);
 free_svm:
 	if (list_empty(&svm->devs)) {
-		if (svm->notifier.ops)
-			mmu_notifier_unregister(&svm->notifier, mm);
+		mmu_notifier_unregister(&svm->notifier, mm);
 		pasid_private_remove(mm->pasid);
 		kfree(svm);
 	}
@@ -780,40 +771,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	return IRQ_RETVAL(handled);
 }
 
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	unsigned int flags = 0;
 	struct iommu_sva *sva;
 	int ret;
 
-	if (drvdata)
-		flags = *(unsigned int *)drvdata;
-
-	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap)) {
-			dev_err(dev, "%s: Supervisor PASID not supported\n",
-				iommu->name);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-
-		if (mm) {
-			dev_err(dev, "%s: Supervisor PASID with user provided mm\n",
-				iommu->name);
-			return ERR_PTR(-EINVAL);
-		}
-
-		mm = &init_mm;
-	}
-
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_alloc_pasid(dev, mm, flags);
+	ret = intel_svm_alloc_pasid(dev, mm);
 	if (ret) {
 		mutex_unlock(&pasid_mutex);
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 297ac79bc21c..a94ec648c88b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2750,7 +2750,6 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
- * @drvdata: opaque data pointer to pass to bind callback
  *
  * Create a bond between device and address space, allowing the device to access
  * the mm using the returned PASID. If a bond already exists between @device and
@@ -2763,7 +2762,7 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
@@ -2788,7 +2787,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	handle = ops->sva_bind(dev, mm, drvdata);
+	handle = ops->sva_bind(dev, mm);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b70a013139c7..905eff1f840e 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -108,7 +108,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
 
-	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
+	handle = iommu_sva_bind_device(uacce->parent, current->mm);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-- 
2.34.1

