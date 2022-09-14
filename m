Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524115B7E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiINBYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINBYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:24:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DA6566B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663118653; x=1694654653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJEO4d3itpLXefVeSwtwe65EXfogPWLWr30ciCn+U7I=;
  b=hG6eQ7daKhXfutPynxdVpsPaTLLz6z3DkBg9H5xk425CkPvXkadMpS8I
   nIDY2qat+j5W5YlXgOl71YdydNIrJGkGk5tzeEnEFObvs52VAlXzDX1qb
   0DaPeJVcJ/64JN86U4R8BRayI83He5dds4QvHi3Bhz5AASbKotPJW/cI2
   Z7+vupozL+GN+H5AAAi7uR3cixPtWu8x6Idmx9YRkxd3xFWTERjFibFJ9
   LVy3Kxqh+p7sviSaK9H9VrGh/H/P2meud/gDMws6ntS1sxsLf2MLgEO4Q
   2vsxUPlJx68UgkBQKxFpPA+dw+C8j9kWoDg302IQeUqqIOpkcX6mk2tJP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278032796"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278032796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 18:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="619136474"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2022 18:24:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
Date:   Wed, 14 Sep 2022 09:18:21 +0800
Message-Id: <20220914011821.400986-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/iommu/intel/iommu.h |  2 +-
 drivers/iommu/intel/svm.c   | 60 +++++--------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

Change log:
v2:
 - Move prq_seq_number to per-iommu data struct.
 - Add back the comments that were accidentally deleted.
 - Rephrased the commit message.

v1: https://lore.kernel.org/linux-iommu/20220908023557.4582-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 08618d94fbac..352f05e92f6f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -584,6 +584,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	unsigned long prq_seq_number;
 	struct completion prq_complete;
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
@@ -757,7 +758,6 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	unsigned long prq_seq_number;
 	u32 pasid;
 	int users;
 	u16 did;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b391e46e537e..e73b9a202777 100644
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
@@ -689,11 +672,10 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 
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
@@ -713,8 +695,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			pr_err("IOMMU: %s: Page request without PASID\n",
 			       iommu->name);
 bad_req:
-			svm = NULL;
-			sdev = NULL;
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 			goto prq_advance;
 		}
@@ -741,34 +721,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		if (!svm || svm->pasid != req->pasid) {
-			/*
-			 * It can't go away, because the driver is not permitted
-			 * to unbind the mm while any page faults are outstanding.
-			 */
-			svm = pasid_private_find(req->pasid);
-			if (IS_ERR_OR_NULL(svm))
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
@@ -803,8 +768,6 @@ int intel_svm_page_response(struct device *dev,
 			    struct iommu_page_response *msg)
 {
 	struct iommu_fault_page_request *prm;
-	struct intel_svm_dev *sdev = NULL;
-	struct intel_svm *svm = NULL;
 	struct intel_iommu *iommu;
 	bool private_present;
 	bool pasid_present;
@@ -823,8 +786,6 @@ int intel_svm_page_response(struct device *dev,
 	if (!msg || !evt)
 		return -EINVAL;
 
-	mutex_lock(&pasid_mutex);
-
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
@@ -841,12 +802,6 @@ int intel_svm_page_response(struct device *dev,
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
@@ -876,7 +831,6 @@ int intel_svm_page_response(struct device *dev,
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
 out:
-	mutex_unlock(&pasid_mutex);
 	return ret;
 }
 
-- 
2.34.1

