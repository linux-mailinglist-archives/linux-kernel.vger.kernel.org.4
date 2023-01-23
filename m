Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9B678A47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjAWWGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjAWWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:06:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9238022
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674511542; x=1706047542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x4eTiqqg8GV8B3k8LuKHAxCNwFiXmamwhK2QFN6bvNg=;
  b=iqhJUat5fjKouqDJDxjTW7x4Iz1qJSF4gAGEuDEMpLvWYB0F1DoUVAAV
   rs9lc0iQWfk5xceOkqJkbNslTQ2NJpu1WGf65uMfUwySJoYPLGpBGCTcA
   JtUa6XvqsaH8axnGvneijGHv3CAosBFSvJpgMPmqjJA6mINzhQWbg3Yya
   s1w8sLzzHjDMHgKe8EEtSGTLq2PFG1lNAuGcWrPfOdfZUF9AS8DTW92G9
   0QIj+R5MCRM9ml2AkD0igji/TaMe9Kot5zI+lXRE0kmWzAOT3aVn5r6NF
   XtJcFKBY2ptVHgoR5QSkCrWWqZh1MidTYbPlq93PiuIQdJ/Zt2e+Oe/Yo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326198199"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326198199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694103437"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694103437"
Received: from ssauty-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.46.171])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:17 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4E9AA10943C; Tue, 24 Jan 2023 01:05:03 +0300 (+03)
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
Subject: [PATCHv15 05/17] mm: Introduce untagged_addr_remote()
Date:   Tue, 24 Jan 2023 01:04:48 +0300
Message-Id: <20230123220500.21077-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
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

Export dump_mm() as there's now the first user for it: VFIO can be
compiled as module and untagged_addr_remote() triggers dump_mm() via
mmap_assert_locked().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/uaccess_64.h |  2 ++
 drivers/vfio/vfio_iommu_type1.c     |  2 +-
 fs/proc/task_mmu.c                  |  9 +++++++--
 include/linux/mm.h                  | 11 -----------
 include/linux/uaccess.h             | 22 ++++++++++++++++++++++
 mm/debug.c                          |  1 +
 mm/gup.c                            |  4 ++--
 mm/madvise.c                        |  5 +++--
 mm/migrate.c                        | 11 ++++++-----
 9 files changed, 44 insertions(+), 23 deletions(-)

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
index 23c24fe98c00..daf34f957b7b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -573,7 +573,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		goto done;
 	}
 
-	vaddr = untagged_addr(vaddr);
+	vaddr = untagged_addr_remote(mm, vaddr);
 
 retry:
 	vma = vma_lookup(mm, vaddr);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a0398db63..df139a717230 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1692,8 +1692,13 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 
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
index f3f196e4d66d..6b28eb9c6ea2 100644
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
index afb18f198843..bfdadf5f8bbb 100644
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
diff --git a/mm/debug.c b/mm/debug.c
index 7f8e5f744e42..3c1b490c7e2b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -215,6 +215,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL_GPL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..e28d787ba8f8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1091,7 +1091,7 @@ static long __get_user_pages(struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
-	start = untagged_addr(start);
+	start = untagged_addr_remote(mm, start);
 
 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
 
@@ -1265,7 +1265,7 @@ int fixup_user_fault(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret;
 
-	address = untagged_addr(address);
+	address = untagged_addr_remote(mm, address);
 
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
diff --git a/mm/madvise.c b/mm/madvise.c
index a56a6d17e201..90cd4a442fd2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1407,8 +1407,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	size_t len;
 	struct blk_plug plug;
 
-	start = untagged_addr(start);
-
 	if (!madvise_behavior_valid(behavior))
 		return -EINVAL;
 
@@ -1440,6 +1438,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 		mmap_read_lock(mm);
 	}
 
+	start = untagged_addr_remote(mm, start);
+	end = start + len;
+
 	blk_start_plug(&plug);
 	error = madvise_walk_vmas(mm, start, end, behavior,
 			madvise_vma_behavior);
diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..dae5022d94b0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1719,14 +1719,17 @@ static int do_move_pages_to_node(struct mm_struct *mm,
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
 
 	mmap_read_lock(mm);
+	addr = (unsigned long)untagged_addr_remote(mm, p);
+
 	err = -EFAULT;
 	vma = vma_lookup(mm, addr);
 	if (!vma || !vma_migratable(vma))
@@ -1831,7 +1834,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
-		unsigned long addr;
 		int node;
 
 		err = -EFAULT;
@@ -1839,7 +1841,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		if (get_user(node, nodes + i))
 			goto out_flush;
-		addr = (unsigned long)untagged_addr(p);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
@@ -1867,8 +1868,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
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
2.39.1

