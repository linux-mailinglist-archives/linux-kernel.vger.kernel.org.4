Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF56566F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiL0DIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0DIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:08:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FD1093
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672110524; x=1703646524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73Lfy6YiNOngUHGIq+SvJHDmwJJPCjL8Zm/vzQL6EVI=;
  b=RjA+djReJLpqDM9GDVEMyPMWp5ONOXGa4jW5DXuPkmKeTCQ3i8O7Bnv3
   7Fj5qnYqohkV5pGwhCB3HjHzLjMAQnR/SehdG8WRVY7Xna9/Jh4ZeIsp+
   TYUDRToXhxl/fK72tXVnPAqeVaCkHOERiN6fPxJBVV7J037sqrIed0pyB
   G3z8kg+j9lw4tkN+y2bHd6tTjlLHHB94oFX00sAGh1+XOIRRpUf2pmShf
   /Vc+aMkvJ0Y57qeFvJOgRoXNiS9/rjFZRPmQA7K7AUJIL9r3TEAa/nTeT
   10+TavEklwR7aQu8cyMuwxFfLpVoexyuRQFxvU0h7tr5ujXHCOkatnaND
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="300994658"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="300994658"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="741605194"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="741605194"
Received: from ppogotov-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:39 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A1E7910BBB1; Tue, 27 Dec 2022 06:08:36 +0300 (+03)
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
Subject: [PATCHv13 04/16] mm: Introduce untagged_addr_remote()
Date:   Tue, 27 Dec 2022 06:08:17 +0300
Message-Id: <20221227030829.12508-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
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
---
 arch/sparc/include/asm/uaccess_64.h |  2 ++
 drivers/vfio/vfio_iommu_type1.c     |  2 +-
 fs/proc/task_mmu.c                  |  2 +-
 include/linux/mm.h                  | 11 -----------
 include/linux/uaccess.h             | 22 ++++++++++++++++++++++
 mm/debug.c                          |  1 +
 mm/gup.c                            |  4 ++--
 mm/madvise.c                        |  5 +++--
 mm/migrate.c                        |  2 +-
 9 files changed, 33 insertions(+), 18 deletions(-)

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
index e35a0398db63..25786a808901 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1693,7 +1693,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	/* watch out for wraparound */
 	start_vaddr = end_vaddr;
 	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT))
-		start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
+		start_vaddr = untagged_addr_remote(mm, svpfn << PAGE_SHIFT);
 
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
index a4d3fc65085f..2cdffeff9ffe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1839,7 +1839,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		if (get_user(node, nodes + i))
 			goto out_flush;
-		addr = (unsigned long)untagged_addr(p);
+		addr = (unsigned long)untagged_addr_remote(mm, p);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
-- 
2.38.2

