Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC56B6566
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCLL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCLL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:26:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D844C6F2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620395; x=1710156395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhNKWlLSFQdtM5nCCWCne2jNIxj0oFZDDW74FDfmA8g=;
  b=FHLvCFC8vBj0bj0L3384qCGgXNGdoW8g0iM8sPO+BgKG25c4QTy83Bwc
   P+is2c16ISXepWvN8p7NMSvJy1equOXipaROPCVApzOici9WSW+awNQIp
   B7Xf8BYephg99tLsPYHb6g4Qcw00gaHwvZ5iz7KQjEuWEX9jYvhi+9NQz
   nWAddN5Rxw1CL78iiX+QyCfB9kwEBG6KJx+8ucSo74HFItvsakzB9qdIi
   +3qPWLT3dIIYhm20IKJNms9NN71hKYnhW32CLjxGkodo6N3MeODEu32fO
   dNHppXqJFHQthF3WdhiBaBUEaTF9FPsElYefZJfZn4tuin7BBV3872eB0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="339349949"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="339349949"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="852438029"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852438029"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 84A2710D7B3; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 05/17] mm: Introduce untagged_addr_remote()
Date:   Sun, 12 Mar 2023 14:26:00 +0300
Message-Id: <20230312112612.31869-6-kirill.shutemov@linux.intel.com>
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

untagged_addr() removes tags/metadata from the address and brings it to
the canonical form. The helper is implemented on arm64 and sparc. Both of
them do untagging based on global rules.

However, Linear Address Masking (LAM) on x86 introduces per-process
settings for untagging. As a result, untagged_addr() is now only
suitable for untagging addresses for the current proccess.

The new helper untagged_addr_remote() has to be used when the address
targets remote process. It requires the mmap lock for target mm to be
taken.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
---
 arch/sparc/include/asm/uaccess_64.h |  2 ++
 drivers/vfio/vfio_iommu_type1.c     |  2 +-
 fs/proc/task_mmu.c                  |  9 +++++++--
 include/linux/mm.h                  | 11 -----------
 include/linux/uaccess.h             | 22 ++++++++++++++++++++++
 mm/gup.c                            |  4 ++--
 mm/madvise.c                        |  5 +++--
 mm/migrate.c                        | 11 ++++++-----
 8 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 94266a5c5b04..b825a5dd0210 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -8,8 +8,10 @@
 
 #include <linux/compiler.h>
 #include <linux/string.h>
+#include <linux/mm_types.h>
 #include <asm/asi.h>
 #include <asm/spitfire.h>
+#include <asm/pgtable.h>
 
 #include <asm/processor.h>
 #include <asm-generic/access_ok.h>
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 493c31de0edb..3d4dd9420c30 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -580,7 +580,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		goto done;
 	}
 
-	vaddr = untagged_addr(vaddr);
+	vaddr = untagged_addr_remote(mm, vaddr);
 
 retry:
 	vma = vma_lookup(mm, vaddr);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..29fd6b1f4058 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1689,8 +1689,13 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 
 	/* watch out for wraparound */
 	start_vaddr = end_vaddr;
-	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT))
-		start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
+	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT)) {
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			goto out_free;
+		start_vaddr = untagged_addr_remote(mm, svpfn << PAGE_SHIFT);
+		mmap_read_unlock(mm);
+	}
 
 	/* Ensure the address is inside the task */
 	if (start_vaddr > mm->task_size)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..289ae4caf878 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -96,17 +96,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/page.h>
 #include <asm/processor.h>
 
-/*
- * Architectures that support memory tagging (assigning tags to memory regions,
- * embedding these tags into addresses that point to these memory regions, and
- * checking that the memory and the pointer tags match on memory accesses)
- * redefine this macro to strip tags from pointers.
- * It's defined as noop for architectures that don't support memory tagging.
- */
-#ifndef untagged_addr
-#define untagged_addr(addr) (addr)
-#endif
-
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ab9728138ad6..3064314f4832 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,6 +10,28 @@
 
 #include <asm/uaccess.h>
 
+/*
+ * Architectures that support memory tagging (assigning tags to memory regions,
+ * embedding these tags into addresses that point to these memory regions, and
+ * checking that the memory and the pointer tags match on memory accesses)
+ * redefine this macro to strip tags from pointers.
+ *
+ * Passing down mm_struct allows to define untagging rules on per-process
+ * basis.
+ *
+ * It's defined as noop for architectures that don't support memory tagging.
+ */
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
+#ifndef untagged_addr_remote
+#define untagged_addr_remote(mm, addr)	({		\
+	mmap_assert_locked(mm);				\
+	untagged_addr(addr);				\
+})
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/mm/gup.c b/mm/gup.c
index eab18ba045db..5ee8b682a0fe 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1085,7 +1085,7 @@ static long __get_user_pages(struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
-	start = untagged_addr(start);
+	start = untagged_addr_remote(mm, start);
 
 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
 
@@ -1259,7 +1259,7 @@ int fixup_user_fault(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret;
 
-	address = untagged_addr(address);
+	address = untagged_addr_remote(mm, address);
 
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..d4b67f36f70f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1402,8 +1402,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	size_t len;
 	struct blk_plug plug;
 
-	start = untagged_addr(start);
-
 	if (!madvise_behavior_valid(behavior))
 		return -EINVAL;
 
@@ -1435,6 +1433,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 		mmap_read_lock(mm);
 	}
 
+	start = untagged_addr_remote(mm, start);
+	end = start + len;
+
 	blk_start_plug(&plug);
 	error = madvise_walk_vmas(mm, start, end, behavior,
 			madvise_vma_behavior);
diff --git a/mm/migrate.c b/mm/migrate.c
index 98f1c11197a8..8cd11bc9208f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2097,15 +2097,18 @@ static int do_move_pages_to_node(struct mm_struct *mm,
  *         target node
  *     1 - when it has been queued
  */
-static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
+static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 		int node, struct list_head *pagelist, bool migrate_all)
 {
 	struct vm_area_struct *vma;
+	unsigned long addr;
 	struct page *page;
 	int err;
 	bool isolated;
 
 	mmap_read_lock(mm);
+	addr = (unsigned long)untagged_addr_remote(mm, p);
+
 	err = -EFAULT;
 	vma = vma_lookup(mm, addr);
 	if (!vma || !vma_migratable(vma))
@@ -2211,7 +2214,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
-		unsigned long addr;
 		int node;
 
 		err = -EFAULT;
@@ -2219,7 +2221,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		if (get_user(node, nodes + i))
 			goto out_flush;
-		addr = (unsigned long)untagged_addr(p);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
@@ -2247,8 +2248,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
 		 */
-		err = add_page_for_migration(mm, addr, current_node,
-				&pagelist, flags & MPOL_MF_MOVE_ALL);
+		err = add_page_for_migration(mm, p, current_node, &pagelist,
+					     flags & MPOL_MF_MOVE_ALL);
 
 		if (err > 0) {
 			/* The page is successfully queued for migration */
-- 
2.39.2

