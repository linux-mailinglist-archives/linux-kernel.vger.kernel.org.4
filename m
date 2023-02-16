Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F269A2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBPX4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBPX4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:56:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4EB34F68
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676591775; x=1708127775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTjH8sjCWG8ibJ5uW/TsS619qIGDKnMfps4jWoiMNBE=;
  b=QyrM8nyFy8sbz4pPUAc/qSpMCTFF0giy7u4jcEERDxrAsmrsFf3I/e5t
   uXaSZktnLfbvym3I3jGRhAbAhQjJRR9qh0W9k4INoY7amykoD6HhYBgUR
   XqBtfZLmOJPwbyVCT7dPSwqVUd2qiLgOifHzHGdpG6iy50H0+w3TCy9Az
   CC4yVMs6Y9J9WCL0NTfGOhZmWGNBXzlq3WeLnVAYpegQbukqj+W/y7M6T
   gTYhNpr/b1ulhvcksAlIEhvd51roNeQwdELkDtrtro5ik4RxP0E3o73GW
   aAiSUJJetWeH+UJ3ffdfjaqwPYgT4LvzMxGNhWsv/k8vGVOjadr9J31jz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394342788"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394342788"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 15:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779584632"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="779584632"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 15:56:12 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 2/5] iommu/sva: Move PASID helpers to sva code
Date:   Thu, 16 Feb 2023 15:59:48 -0800
Message-Id: <20230216235951.3573059-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
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

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 include/linux/sched/mm.h  | 22 +++-------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..a3ee258936f0 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -71,6 +71,25 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
+void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+
+/* Associate a PASID with an mm_struct: */
+void mm_pasid_set(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid = pasid;
+}
+
+void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
+
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..c488c7241102 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,6 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -452,24 +451,9 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 #endif
 
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = INVALID_IOASID;
-}
-
-/* Associate a PASID with an mm_struct: */
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
-{
-	mm->pasid = pasid;
-}
-
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
+void mm_pasid_init(struct mm_struct *mm);
+void mm_pasid_set(struct mm_struct *mm, u32 pasid);
+void mm_pasid_drop(struct mm_struct *mm);
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-- 
2.25.1

