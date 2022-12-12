Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B164A7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiLLSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiLLSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80906B49F;
        Mon, 12 Dec 2022 10:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5986611D0;
        Mon, 12 Dec 2022 18:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6619C433F2;
        Mon, 12 Dec 2022 18:54:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B4DOIGAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670871250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MyHCHSK4mrN11aS3RPY+y9fIUe1YsqaR0qC7rdUeoiw=;
        b=B4DOIGAK/hZuIyf/woOr/UAsBYVm92Ejm6ubeUi4MDGWZmVexUGFoO+msNK+u2/yPUfoUA
        5Wo4eeyU2mQskkrlDNjuIhB1k4PF8wBphG7SajD8kbMelO2sW1pcTUIca5YeCbTqoSWkHP
        CHOTqobhUvGEAv4AyXhZjWvxgJp8Cfo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 545b1888 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 18:54:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: [PATCH RFC v12 1/6] mm: add VM_DROPPABLE for designating always lazily freeable mappings
Date:   Mon, 12 Dec 2022 11:53:42 -0700
Message-Id: <20221212185347.1286824-2-Jason@zx2c4.com>
In-Reply-To: <20221212185347.1286824-1-Jason@zx2c4.com>
References: <20221212185347.1286824-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO getrandom() implementation works with a buffer allocated with a
new system call that has certain requirements:

- It shouldn't be written to core dumps.
  * Easy: VM_DONTDUMP.
- It should be zeroed on fork.
  * Easy: VM_WIPEONFORK.

- It shouldn't be written to swap.
  * Uh-oh: mlock is rlimited.
  * Uh-oh: mlock isn't inherited by forks.

- It shouldn't reserve actual memory, but it also shouldn't crash when
  page faulting in memory if none is available
  * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
  * Uh-oh: VM_NORESERVE means segfaults.

It turns out that the vDSO getrandom() function has three really nice
characteristics that we can exploit to solve this problem:

1) Due to being wiped during fork(), the vDSO code is already robust to
   having the contents of the pages it reads zeroed out midway through
   the function's execution.

2) In the absolute worst case of whatever contingency we're coding for,
   we have the option to fallback to the getrandom() syscall, and
   everything is fine.

3) The buffers the function uses are only ever useful for a maximum of
   60 seconds -- a sort of cache, rather than a long term allocation.

These characteristics mean that we can introduce VM_DROPPABLE, which
has the following semantics:

a) It never is written out to swap.
b) Under memory pressure, mm can just drop the pages (so that they're
   zero when read back again).
c) If there's not enough memory to service a page fault, it's not fatal,
   and no signal is sent. Instead, writes are simply lost.
d) It is inherited by fork.
e) It doesn't count against the mlock budget, since nothing is locked.

This is fairly simple to implement, with the one snag that we have to
use 64-bit VM_* flags, but this shouldn't be a problem, since the only
consumers will probably be 64-bit anyway.

This way, allocations used by vDSO getrandom() can use:

    VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE

And there will be no problem with OOMing, crashing on overcommitment,
using memory when not in use, not wiping on fork(), coredumps, or
writing out to swap.

At the moment, rather than skipping writes on OOM, the fault handler
just returns to userspace, and the instruction is retried. This isn't
terrible, but it's not quite what is intended. The actual instruction
skipping has to be implemented arch-by-arch, but so does this whole
vDSO series, so that's fine. The following commit addresses it for x86.

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/task_mmu.c             | 3 +++
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 9 ++++++++-
 mm/Kconfig                     | 3 +++
 mm/memory.c                    | 4 ++++
 mm/mempolicy.c                 | 3 +++
 mm/mprotect.c                  | 2 +-
 mm/rmap.c                      | 5 +++--
 8 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..76bb7fd208d8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -703,6 +703,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#ifdef CONFIG_NEED_VM_DROPPABLE
+		[ilog2(VM_DROPPABLE)]	= "dp",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..0ab1539bd2c6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -314,11 +314,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -334,6 +336,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_NEED_VM_DROPPABLE
+# define VM_DROPPABLE VM_HIGH_ARCH_5
+#else
+# define VM_DROPPABLE 0
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e87cb2b80ed3..67375f8dc03c 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -162,6 +162,12 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 # define IF_HAVE_UFFD_MINOR(flag, name)
 #endif
 
+#ifdef CONFIG_NEED_VM_DROPPABLE
+# define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name}
+#else
+# define IF_HAVE_VM_DROPPABLE(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -194,7 +200,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..27bdbb886bab 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1004,6 +1004,9 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config NEED_VM_DROPPABLE
+	select ARCH_USES_HIGH_VMA_FLAGS
+	bool
 
 config VM_EVENT_COUNTERS
 	default y
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..72403585e1a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5219,6 +5219,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
+	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
+	if (vma->vm_flags & VM_DROPPABLE)
+		ret &= ~VM_FAULT_OOM;
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..5aeb85bc9627 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2172,6 +2172,9 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 	int preferred_nid;
 	nodemask_t *nmask;
 
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN | __GFP_NORETRY;
+
 	pol = get_vma_policy(vma, addr);
 
 	if (pol->mode == MPOL_INTERLEAVE) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2a..c2584e025f37 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -590,7 +590,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				may_expand_vm(mm, oldflags, nrpages))
 			return -ENOMEM;
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_HUGETLB|
-						VM_SHARED|VM_NORESERVE))) {
+				  VM_SHARED|VM_NORESERVE|VM_DROPPABLE))) {
 			charged = nrpages;
 			if (security_vm_enough_memory_mm(mm, charged))
 				return -ENOMEM;
diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..9fabd7affd3a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1260,7 +1260,8 @@ void page_add_new_anon_rmap(struct page *page,
 	int nr = compound ? thp_nr_pages(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	__SetPageSwapBacked(page);
+	if (!(vma->vm_flags & VM_DROPPABLE))
+		__SetPageSwapBacked(page);
 	if (compound) {
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
@@ -1691,7 +1692,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * plus the rmap(s) (dropped by discard:).
 				 */
 				if (ref_count == 1 + map_count &&
-				    !folio_test_dirty(folio)) {
+				    (!folio_test_dirty(folio) || (vma->vm_flags & VM_DROPPABLE))) {
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
-- 
2.38.1

