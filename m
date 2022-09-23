Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF425E70D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIWAsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiIWAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:48:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8B111DFB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894085; x=1695430085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sCEnmrg9GWDdV+abb6W1IKSbIi92j5+nKGixxLBe/4o=;
  b=Xs6lJdWCDY/3hpct+5ItR9bTipdPIZW8ruivGLGFJpJXQsKhs2+6kMBP
   rPUhua/uNoYJuUxgzjDPuA61wUv8t10YyU/hkYTnskwms9CYJTD9A+qen
   i/s+Iw7HCZIvRezwKNdJ05qeSa87uVv5MBgPIwdEIrb5ZUaZvOXh10Pda
   hkPQsU+aeE3MsSAPnpAWY+W4jG6VWkoP1GunesnIL186EFeIeqNTdPVIH
   sq+IDwV6WhLQM8/c0+Inipb1eM6CF1fgX4sCIUhyWsQdQ26vBMn7RC1LS
   SLgfAWxUDIwEQCrrsqsDO31uzz5Tb/tyRDmjWJA5nYHbkP5Gh7ZGH7y9p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278844"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759932"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
Date:   Fri, 23 Sep 2022 08:42:01 +0800
Message-Id: <20220923004206.3630441-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
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

The existing I/O page fault handling code accesses the per-PASID SVA data
structures. This is unnecessary and makes the fault handling code only
suitable for SVA scenarios. This removes the SVA data accesses from the
I/O page fault reporting and responding code, so that the fault handling
code could be generic.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220914011821.400986-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  2 +-
 drivers/iommu/intel/svm.c   | 60 +++++--------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 74b0e19e23ee..b5fb7706e97c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -586,6 +586,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	unsigned long prq_seq_number;
 	struct completion prq_complete;
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
@@ -761,7 +762,6 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	unsigned long prq_seq_number;
 	u32 pasid;
 	int users;
 	u16 did;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8bcfb93dda56..d1cab931dcb0 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -48,23 +48,6 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
-static struct intel_svm_dev *
-svm_lookup_device_by_sid(struct intel_svm *svm, u16 sid)
-{
-	struct intel_svm_dev *sdev = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, list) {
-		if (t->sid == sid) {
-			sdev = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return sdev;
-}
-
 static struct intel_svm_dev *
 svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
 {
@@ -706,11 +689,10 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
-	struct intel_svm_dev *sdev = NULL;
 	struct intel_iommu *iommu = d;
-	struct intel_svm *svm = NULL;
 	struct page_req_dsc *req;
 	int head, tail, handled;
+	struct pci_dev *pdev;
 	u64 address;
 
 	/*
@@ -730,8 +712,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			pr_err("IOMMU: %s: Page request without PASID\n",
 			       iommu->name);
 bad_req:
-			svm = NULL;
-			sdev = NULL;
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 			goto prq_advance;
 		}
@@ -758,34 +738,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		if (!svm || svm->pasid != req->pasid) {
-			/*
-			 * It can't go away, because the driver is not permitted
-			 * to unbind the mm while any page faults are outstanding.
-			 */
-			svm = pasid_private_find(req->pasid);
-			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
-				goto bad_req;
-		}
-
-		if (!sdev || sdev->sid != req->rid) {
-			sdev = svm_lookup_device_by_sid(svm, req->rid);
-			if (!sdev)
-				goto bad_req;
-		}
-
-		sdev->prq_seq_number++;
-
+		pdev = pci_get_domain_bus_and_slot(iommu->segment,
+						   PCI_BUS_NUM(req->rid),
+						   req->rid & 0xff);
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (intel_svm_prq_report(iommu, sdev->dev, req))
+		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 
-		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
+		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 				 req->priv_data[0], req->priv_data[1],
-				 sdev->prq_seq_number);
+				 iommu->prq_seq_number++);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
@@ -881,8 +846,6 @@ int intel_svm_page_response(struct device *dev,
 			    struct iommu_page_response *msg)
 {
 	struct iommu_fault_page_request *prm;
-	struct intel_svm_dev *sdev = NULL;
-	struct intel_svm *svm = NULL;
 	struct intel_iommu *iommu;
 	bool private_present;
 	bool pasid_present;
@@ -901,8 +864,6 @@ int intel_svm_page_response(struct device *dev,
 	if (!msg || !evt)
 		return -EINVAL;
 
-	mutex_lock(&pasid_mutex);
-
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
@@ -919,12 +880,6 @@ int intel_svm_page_response(struct device *dev,
 		goto out;
 	}
 
-	ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
-	if (ret || !sdev) {
-		ret = -ENODEV;
-		goto out;
-	}
-
 	/*
 	 * Per VT-d spec. v3.0 ch7.7, system software must respond
 	 * with page group response if private data is present (PDP)
@@ -954,6 +909,5 @@ int intel_svm_page_response(struct device *dev,
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
 out:
-	mutex_unlock(&pasid_mutex);
 	return ret;
 }
-- 
2.34.1

