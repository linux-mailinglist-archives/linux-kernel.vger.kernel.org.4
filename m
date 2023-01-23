Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD9678A42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjAWWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjAWWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:05:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D8037F3B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674511536; x=1706047536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6cZBJye+9S/4/Mk+1QQktyLKF2mTMV32eIG7PWZWnw=;
  b=l+7WRgAbA4j36oF0Sm4/2JFPGqTavUUSanNln8Z/rhMphRy2fYuWnSIj
   b1zHurIYtctgU/vaARgimuqoD2vVhQK1b3/XpMa+p4XJDYWsUmc8+2jsZ
   JrTybwaXrNdV5TwSrfUDPvw3weQ4utmB0Mj/BLi9oCMBUJV2Qxc9/b6gP
   +OpzFAkq3qE1ihCbGj5GdDzjVNobhrlBDJPwZh/sUPIncW+h3cG60fzqO
   fE6t9jlOWsePRWQrDihCl+ySy6eIJ+Eoyfnhyq7bxoThKAudxV08p6cYW
   pBZ7BWwJd6svKwpzi3YK0mx+ue0/7LasZzvUv9oYlxWlhUV+F67VGAjMe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="327421971"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="327421971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661878116"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661878116"
Received: from ssauty-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.46.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:17 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8502610947B; Tue, 24 Jan 2023 01:05:03 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv15 10/17] iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
Date:   Tue, 24 Jan 2023 01:04:53 +0300
Message-Id: <20230123220500.21077-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
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

Kernel has few users of pasid_valid() and all but one checks if the
process has PASID allocated. The helper takes ioasid_t as the input.

Replace the helper with mm_valid_pasid() that takes mm_struct as the
argument. The only call that checks PASID that is not tied to mm_struct
is open-codded now.

This is preparatory patch. It helps avoid ifdeffery: no need to
dereference mm->pasid in generic code to check if the process has PASID.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c   | 6 +++---
 drivers/iommu/iommu-sva.c | 4 ++--
 include/linux/ioasid.h    | 9 ---------
 include/linux/sched/mm.h  | 8 +++++++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3d06a3..8b83d8fbce71 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -671,15 +671,15 @@ static bool try_fixup_enqcmd_gp(void)
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
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..4ee2929f0d7a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -34,14 +34,14 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 
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
2.39.1

