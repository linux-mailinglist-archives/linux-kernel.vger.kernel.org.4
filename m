Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955966B6568
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCLL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjCLL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:26:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326052F4C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620398; x=1710156398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iKOETahP1WXZi4zcV24NixONYfrth/yIw9MG3r4KgU=;
  b=DL+rX3xjk6tEfmSRwiunsyVURZjWenxeK7sMdQo4J1oORiDy+4U2ddOh
   HOOtQ0gnEylf18KGXU6z6CeCRoKfVjOiVNKAE6wYBXqlLcy3P2akh1FUM
   pIUqc32EJnABdymrusQMjpaCGaBVXrKPUxE2E9WiaIGKHiZv0pWkb24o9
   MRuD2ObWP9x6oaUKUM40k5l3rWDjEBVyDdo5MptUdQAZ3eA4XVqM6Sg/E
   lA8xdCJGrSprFeCUzMOhAKH2zOZbxnYSRsjye8MFRbOe90yS6+ODnsSe7
   rczCTgMeZWm8cNxE00Fnw/HeD7NQisTbGlxMX9vQradhbTuf/f+4A7gLF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="339349973"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="339349973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="852438035"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852438035"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B979A10D7B8; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 10/17] iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
Date:   Sun, 12 Mar 2023 14:26:05 +0300
Message-Id: <20230312112612.31869-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
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
2.39.2

