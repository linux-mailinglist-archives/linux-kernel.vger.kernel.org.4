Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73860C08B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJYBJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJYBIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:08:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BB60C9B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657065; x=1698193065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xa2QDdupIWc8VqMdeXFZWdKQnRlx2ren8j3nAoeW+Vo=;
  b=EmVENUx9j+qgH/kxK9UtgokWNoz8LlcruoxrjHVGFOPqeN213Bcebwab
   A9leE+mL470El9FMSTx4/rfdne1XcMtd6ubdgxuoSFqatltnBtFPoJC75
   khDWGgaKhwIAPtaxNHe9BE9wV3HIC/CSuPNp9hZ2IZ8MfjRan8FP4ILUs
   anBpSebOgLtsPTqkf+DBpX6ydgcIirWzgoJibjKSPIovsTBMAx9p19fze
   08kEj4ctPGgyNAUAIPdtOgxHBNhqCNOyXmuN8BB50w5CQuOUz7YXjITlr
   eAyMR4aTm3ghvzGUzh9O8n6aIOBtngktFLC2wYRCy5/1Szed30Jh/F3YM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308644668"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308644668"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582587483"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582587483"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.118])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0E9E91095BF; Tue, 25 Oct 2022 03:17:26 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv11 10/16] iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
Date:   Tue, 25 Oct 2022 03:17:16 +0300
Message-Id: <20221025001722.17466-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel has few users of pasid_valid() and all but one checks if the
process has PASID allocated. The helper takes ioasid_t as the input.

Replace the helper with mm_valid_pasid() that takes mm_struct as the
argument. The only call that checks PASID that is not tied to mm_struct
is open-codded now.

This is preparatory patch. It helps avoid ifdeffery: no need to
dereference mm->pasid in generic code to check if the process has PASID.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c       | 6 +++---
 drivers/iommu/iommu-sva-lib.c | 4 ++--
 include/linux/ioasid.h        | 9 ---------
 include/linux/sched/mm.h      | 8 +++++++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f0..3bdc37ae7d1c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -664,15 +664,15 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
 		return false;
 
-	pasid = current->mm->pasid;
-
 	/*
 	 * If the mm has not been allocated a
 	 * PASID, the #GP can not be fixed up.
 	 */
-	if (!pasid_valid(pasid))
+	if (!mm_valid_pasid(current->mm))
 		return false;
 
+	pasid = current->mm->pasid;
+
 	/*
 	 * Did this thread already have its PASID activated?
 	 * If so, the #GP must be from something else.
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..27be6b81e0b5 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -33,14 +33,14 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
-	if (pasid_valid(mm->pasid)) {
+	if (mm_valid_pasid(mm)) {
 		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
 		goto out;
 	}
 
 	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
+	if (pasid == INVALID_IOASID)
 		ret = -ENOMEM;
 	else
 		mm_pasid_set(mm, pasid);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d62e642..836ae09e92c2 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -74,10 +70,5 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return false;
-}
-
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..b69fe7e8c0ac 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -457,6 +457,11 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 	mm->pasid = INVALID_IOASID;
 }
 
+static inline bool mm_valid_pasid(struct mm_struct *mm)
+{
+	return mm->pasid != INVALID_IOASID;
+}
+
 /* Associate a PASID with an mm_struct: */
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 {
@@ -465,13 +470,14 @@ static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 
 static inline void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (pasid_valid(mm->pasid)) {
+	if (mm_valid_pasid(mm)) {
 		ioasid_free(mm->pasid);
 		mm->pasid = INVALID_IOASID;
 	}
 }
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
-- 
2.38.0

