Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632D74A87E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGGBf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGGBf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:35:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1BC2101
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693715; x=1720229715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1h7edKtoFv8FxuKLDfoJ9kk0foTEvF67RC9h6LudYHI=;
  b=FupDQZbQ2il+emcJsNbzJnh7q1PNZADTE1NrfJ7FYPnGsq7w2vQerWhn
   e7lFkZKYqHzqZGmJj273GfbtmqNfQiFIaEJgczfrppK8mRjA4W0J7nTeN
   unPUdmxEdGHUd8gCdkBH/BYkfw1kxbViFb8ZaAKZ2zp+ke6B5e9llS0DE
   JJlzUfU8LwnXMNplaeUFtODQI79OEY5lOM4XhhNXa/m24LeoDq+f+K0uE
   Z6S+1TWuFk3X/MV39hXlK9OEd3Ca2ZJJ8lZVbfIqTZCFY9/1RE/IAbuTe
   vgEbg9DXuhV0i2YGA6hyh1TocFtkDGU2sATcI1ngu9LXwydIkcAJKNVUz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832309"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832309"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791362"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791362"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:11 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Date:   Fri,  7 Jul 2023 09:34:40 +0800
Message-Id: <20230707013441.365583-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707013441.365583-1-tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each mm bound to devices gets a PASID and a corresponding sva domain
allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
field of the mm. And that PASID and sva domain get released in iommu_sva_
unbind_device() when no devices are binding to that mm. As a result,
during the life cycle, sva domain has 1:1 with mm PASID.

Since the required info of PASID and sva domain are kept in struct
iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
field in mm struct.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 54 +++++++++++++++++++++++++++------------
 drivers/iommu/iommu.c     |  1 +
 include/linux/iommu.h     |  8 +++---
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 7a41b6510e385..342d8ba9ab479 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
 /* Allocate a PASID for the mm within range (inclusive) */
 static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
+	struct iommu_mm_data *iommu_mm = NULL;
 	int ret = 0;
 
 	if (min == IOMMU_PASID_INVALID ||
@@ -33,9 +34,18 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
+	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
+	if (!iommu_mm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	mm->iommu_mm = iommu_mm;
+
 	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	if (ret < min) {
+		kfree(iommu_mm);
 		goto out;
+	}
 	mm_set_pasid(mm, ret);
 	ret = 0;
 out:
@@ -61,7 +71,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
-	struct iommu_domain *domain;
+	struct iommu_domain *domain, *sva_domain = mm->iommu_mm->sva_domain;
 	struct iommu_sva *handle;
 	ioasid_t max_pasids;
 	int ret;
@@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	if (domain) {
-		domain->users++;
-		goto out;
+	if (unlikely(domain)) {
+		/* Re-attach the device to the same domain? */
+		if (domain == sva_domain) {
+			goto out;
+		} else {
+			/* Didn't get detached from the previous domain? */
+			ret = -EBUSY;
+			goto out_unlock;
+		}
 	}
 
-	/* Allocate a new domain and set it on device pasid. */
-	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
-		goto out_unlock;
+	if (sva_domain) {
+		sva_domain->users++;
+	} else {
+		/* Allocate a new domain and set it on device pasid. */
+		sva_domain = iommu_sva_domain_alloc(dev, mm);
+		if (!sva_domain) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		sva_domain->users = 1;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
+	ret = iommu_attach_device_pasid(sva_domain, dev, mm_get_pasid(mm));
 	if (ret)
 		goto out_free_domain;
-	domain->users = 1;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
-	handle->domain = domain;
+	handle->domain = sva_domain;
 
 	return handle;
 
 out_free_domain:
-	iommu_domain_free(domain);
+	iommu_domain_free(sva_domain);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
@@ -136,10 +156,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
-	if (--domain->users == 0) {
-		iommu_detach_device_pasid(domain, dev, pasid);
+	iommu_detach_device_pasid(domain, dev, pasid);
+	if (--domain->users == 0)
 		iommu_domain_free(domain);
-	}
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -217,4 +236,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 		return;
 
 	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
+	kfree(mm->iommu_mm);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35fa1c1b12826..2f55a157b1f15 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3393,5 +3393,6 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->iopf_handler = iommu_sva_handle_iopf;
 	domain->fault_data = mm;
 
+	mm->iommu_mm->sva_domain = domain;
 	return domain;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20135912584ba..1511ded7bc910 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1175,20 +1175,20 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
-	mm->pasid = IOMMU_PASID_INVALID;
+	mm->iommu_mm = &default_iommu_mm;
 }
 static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
-	return mm->pasid != IOMMU_PASID_INVALID;
+	return mm->iommu_mm->pasid != IOMMU_PASID_INVALID;
 }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
-	return mm->pasid;
+	return mm->iommu_mm->pasid;
 }
 
 static inline void mm_set_pasid(struct mm_struct *mm, u32 pasid)
 {
-	mm->pasid = pasid;
+	mm->iommu_mm->pasid = pasid;
 }
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-- 
2.34.1

