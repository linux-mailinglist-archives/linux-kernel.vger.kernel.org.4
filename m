Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C12661C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjAIB6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjAIB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:58:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB62101DD
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229484; x=1704765484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBq2eOVotOHuuNbaX+AJBZNl0TFASfXTuzkriWWUcT4=;
  b=OZAxV0RgsEE3PyfJOVwOolCjD8lee4F9jRvEJ4E/VcHJly74mZhbr8vi
   WUh20d8415JsoO+3wwPYWCOkbqqubJ4VphYL+BDelKcSpiVra08DDWQfY
   /h6+tTwrGk3Ousw5iumSwlHF+yH4OgRY7j77AgLPP/rIwtMUlUmOukSwG
   GYOayvaH8Pw/ub1nWpsMTzErqJxWCSf636e7KkHe8B6JorfpHLeyrqDeX
   2ZZQ71YFeqHVDH3lcuaM2oJ/5128OJc7q718PUnVYN8KHPnhKM4yhfayM
   Y3z2kYyTCVuJ92l6jVZNPQNSFk6pXgkPylmaYSvL9x6w3GJMv7+pdfYNJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848746"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848746"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867438"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867438"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:55 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/4] iommu/vt-d: Remove sva from intel_svm_dev
Date:   Mon,  9 Jan 2023 09:49:55 +0800
Message-Id: <20230109014955.147068-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit be51b1d6bbff ("iommu/sva: Refactoring
iommu_sva_bind/unbind_device()"), the iommu driver doesn't need to
return an iommu_sva pointer anymore. This removes the sva field
from intel_svm_dev and cleanups the code accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/svm.c   | 23 +++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2a1619ff0d79..f0222ad38757 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -761,7 +761,6 @@ struct intel_svm_dev {
 	struct rcu_head rcu;
 	struct device *dev;
 	struct intel_iommu *iommu;
-	struct iommu_sva sva;
 	u16 did;
 	u16 sid, qdep;
 };
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c7dc53e40c26..e7b9bedebcc0 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -298,9 +298,8 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
-					   struct device *dev,
-					   struct mm_struct *mm)
+static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
+			     struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_svm_dev *sdev;
@@ -312,7 +311,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	if (!svm) {
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm)
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 
 		svm->pasid = mm->pasid;
 		svm->mm = mm;
@@ -322,14 +321,14 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 		ret = mmu_notifier_register(&svm->notifier, mm);
 		if (ret) {
 			kfree(svm);
-			return ERR_PTR(ret);
+			return ret;
 		}
 
 		ret = pasid_private_add(svm->pasid, svm);
 		if (ret) {
 			mmu_notifier_unregister(&svm->notifier, mm);
 			kfree(svm);
-			return ERR_PTR(ret);
+			return ret;
 		}
 	}
 
@@ -343,7 +342,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	sdev->sva.dev = dev;
 	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->qdep = info->ats_qdep;
@@ -360,7 +358,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 
 	list_add_rcu(&sdev->list, &svm->devs);
 
-	return &sdev->sva;
+	return 0;
 
 free_sdev:
 	kfree(sdev);
@@ -371,7 +369,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 		kfree(svm);
 	}
 
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /* Caller must hold pasid_mutex */
@@ -843,13 +841,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	struct iommu_sva *sva;
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&pasid_mutex);
-	sva = intel_svm_bind_mm(iommu, dev, mm);
-	if (IS_ERR(sva))
-		ret = PTR_ERR(sva);
+	ret = intel_svm_bind_mm(iommu, dev, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return ret;
-- 
2.34.1

