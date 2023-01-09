Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7ED661C29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjAIB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjAIB6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:58:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C991101DC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229484; x=1704765484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDYJ6Y89oJ5wOsjNTY7g9ajEpmKqwp+GoMmPOL3dWqA=;
  b=j7qHp4Srfs6buZIe/EC0QuQLO3ZsAiYKVx5u9nPErXp8z3LHKRvjhVxg
   glqmPFApKNccqHQKCnXge4gBSrZDFleI++Ha2jUOiv7+tIeMbO5/UEWVy
   wIimRgvaqkZ4BAYdYAGnI/qLIZQh6WoJ9XSsrr8FOAc0IhDrfNmcXcHFy
   jq1QSgYSnajV6jEggrgv5J00Wj1NMxAhwmAh4+GuAlYXYR0ntD//5iMQ0
   +FALEKeJkQODDC/yO3+Zwp+x56U/bVx5bQx9ET8821ziq7rLb6H4CXj8g
   mMJFgD9h8FblHnzj62X0+Z2wret4MYg5lTL3eKNj4PpxItt1nahACdmM4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848739"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848739"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867430"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867430"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Remove users from intel_svm_dev
Date:   Mon,  9 Jan 2023 09:49:54 +0800
Message-Id: <20230109014955.147068-4-baolu.lu@linux.intel.com>
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

It was used as a reference counter of an existing bond between device
and user application memory address. Commit be51b1d6bbff ("iommu/sva:
Refactoring iommu_sva_bind/unbind_device()") has added this in iommu
core. Remove it to avoid duplicate code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/svm.c   | 62 ++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e7c732979364..2a1619ff0d79 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -762,7 +762,6 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	int users;
 	u16 did;
 	u16 sid, qdep;
 };
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d1e445f03aa6..c7dc53e40c26 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -333,13 +333,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 		}
 	}
 
-	/* Find the matching device in svm list */
-	sdev = svm_lookup_device_by_dev(svm, dev);
-	if (sdev) {
-		sdev->users++;
-		goto success;
-	}
-
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
 	if (!sdev) {
 		ret = -ENOMEM;
@@ -350,7 +343,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	sdev->users = 1;
 	sdev->sva.dev = dev;
 	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
@@ -367,7 +359,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 		goto free_sdev;
 
 	list_add_rcu(&sdev->list, &svm->devs);
-success:
+
 	return &sdev->sva;
 
 free_sdev:
@@ -401,32 +393,32 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 	mm = svm->mm;
 
 	if (sdev) {
-		sdev->users--;
-		if (!sdev->users) {
-			list_del_rcu(&sdev->list);
-			/* Flush the PASID cache and IOTLB for this device.
-			 * Note that we do depend on the hardware *not* using
-			 * the PASID any more. Just as we depend on other
-			 * devices never using PASIDs that they have no right
-			 * to use. We have a *shared* PASID table, because it's
-			 * large and has to be physically contiguous. So it's
-			 * hard to be as defensive as we might like. */
-			intel_pasid_tear_down_entry(iommu, dev,
-						    svm->pasid, false);
-			intel_svm_drain_prq(dev, svm->pasid);
-			kfree_rcu(sdev, rcu);
-
-			if (list_empty(&svm->devs)) {
-				if (svm->notifier.ops)
-					mmu_notifier_unregister(&svm->notifier, mm);
-				pasid_private_remove(svm->pasid);
-				/* We mandate that no page faults may be outstanding
-				 * for the PASID when intel_svm_unbind_mm() is called.
-				 * If that is not obeyed, subtle errors will happen.
-				 * Let's make them less subtle... */
-				memset(svm, 0x6b, sizeof(*svm));
-				kfree(svm);
-			}
+		list_del_rcu(&sdev->list);
+		/*
+		 * Flush the PASID cache and IOTLB for this device.
+		 * Note that we do depend on the hardware *not* using
+		 * the PASID any more. Just as we depend on other
+		 * devices never using PASIDs that they have no right
+		 * to use. We have a *shared* PASID table, because it's
+		 * large and has to be physically contiguous. So it's
+		 * hard to be as defensive as we might like.
+		 */
+		intel_pasid_tear_down_entry(iommu, dev, svm->pasid, false);
+		intel_svm_drain_prq(dev, svm->pasid);
+		kfree_rcu(sdev, rcu);
+
+		if (list_empty(&svm->devs)) {
+			if (svm->notifier.ops)
+				mmu_notifier_unregister(&svm->notifier, mm);
+			pasid_private_remove(svm->pasid);
+			/*
+			 * We mandate that no page faults may be outstanding
+			 * for the PASID when intel_svm_unbind_mm() is called.
+			 * If that is not obeyed, subtle errors will happen.
+			 * Let's make them less subtle...
+			 */
+			memset(svm, 0x6b, sizeof(*svm));
+			kfree(svm);
 		}
 	}
 out:
-- 
2.34.1

