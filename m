Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D736C51DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCVRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCVREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A16546F;
        Wed, 22 Mar 2023 10:03:54 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sFFEVBWWG4kPKKNpgGxDKlSRPvy9/vlYPq/aKAl24DE=;
        b=jQTBROYu+lIM2pNlyVxgOBLBukFsaopjBnBl4CiRixZ+cNWm8fgGj/m60gIHRX79CyW4jj
        lpoBQnaCpr3eDteQBccPc0pexO7vVCggQUyJo/YobSgJXaW+WEkk/ssFBJI7SHEYgRp0ZO
        zXqVLujoDo/TYRgdKrrg9cwzlkNYeTmVToNc/+X1yQF23aL/XpA+luJNpMKkvu0df/IOAa
        wpyYTD3/XV/XLPLuThRlrgPqBhTlqyXYH9kCU4ous6RMokJ2oywAZv6wYTyFsyL9NnYg7W
        9r/gxrqpK8US2Joc+Aso72dV5B1alM4IqtPPwPoALKUtTshh+EKK+1BK7+Y8qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sFFEVBWWG4kPKKNpgGxDKlSRPvy9/vlYPq/aKAl24DE=;
        b=JtNBSHvCSXQnap2DsDUxfXRNwsK4xTQC5/FNYTt4vaceC5SFj4T5GvgsuQtsTHYVwnk19+
        NTW1M+4YODBhWMAg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Introduce untagged_addr_remote()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458787.5837.658737830777605511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     428e106ae1ad4e45d3fd6978a753db475d0d0ec9
Gitweb:        https://git.kernel.org/tip/428e106ae1ad4e45d3fd6978a753db475d0d0ec9
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:00 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:39 -07:00

mm: Introduce untagged_addr_remote()

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230312112612.31869-6-kirill.shutemov%40linux.intel.com
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
index 94266a5..b825a5d 100644
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
index 493c31d..3d4dd94 100644
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
index 6a96e17..29fd6b1 100644
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
index 1f79667..289ae4c 100644
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
index ab97281..3064314 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -11,6 +11,28 @@
 #include <asm/uaccess.h>
 
 /*
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
+/*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
  * __copy_{to,from}_user{,_inatomic}().
diff --git a/mm/gup.c b/mm/gup.c
index eab18ba..5ee8b68 100644
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
index 340125d..d4b67f3 100644
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
index 98f1c11..8cd11bc 100644
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
