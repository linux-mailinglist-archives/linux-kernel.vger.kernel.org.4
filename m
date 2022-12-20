Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC5651B94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiLTH0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiLTHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:33 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CF12A99
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so15617129pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM7t0EtrQCBBQ4xEzGpE7GCWeVgMcwv5i8mXTTw5aS8=;
        b=WuQtPOh65/0EpKrc7P0yc2EC2uypLOA1tW4WPA9wVc5eUXsajzPlK3K0qx9TqvzIvr
         UfpEluWZcVb39eFjiF7KN9ktADObxUZ8npZ7aXoXividYemlfPBeNe7xSx6r1oVOH4v6
         HI+gwOHeQFW2l/fPGDhUg/VtUj2HwTSDU9udfxP0L8vgxF/IB3f1MvDPDnwOGoVILN9t
         gjeTuaupWPC3lQz5UhW2SVZ0TQ52VdpHh02G4lyoGa8LnFzHU5UNlYvRVMfye5X8KpnM
         LhkS2pwujkJigAPhtPPhKx6stmuLADxmeadIdEMpbSsNTZyIWHuBPn3ZIj6XBSaepHRn
         6TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM7t0EtrQCBBQ4xEzGpE7GCWeVgMcwv5i8mXTTw5aS8=;
        b=0WEkTlD1aEE29zdyqbnpyC5aX/7GjbkRAL3uupCwoCB09ioE2oG05+6GN1uJN/ADkP
         bLl+x6YZqhBWuC6Fo/pltzSE9wTVj0pIg6jihKs4u1jsB/EaspqVMfWQRs750Z+MzMrp
         RDP1aNX77+Eb2sJXlqQbguevi9h8miy3B3LJAQdSnFsH/+r2GboZUKG1GT+2EKVld8Pz
         zU3YqPZ2ySePsp8dvWo68t28xGoKsCLKic7oWA/ReUEIJ4QJTK+qPkGWu1mwhZ+TrqJv
         BDxtSaIuVq4LNS8a3/qSvFB4jim47HARKfINe38MeA3c0S7aZMEup4ydqLz5wb4VFoSW
         pYqQ==
X-Gm-Message-State: ANoB5pmif0Q0euQ0a6hg7A3B1MkIAcNn6733jvzIGdD2MmF2Otlp2EWW
        Bk8NbNIzTk+ikGbvE+2J49I=
X-Google-Smtp-Source: AA0mqf5cdqNDRdFG4JF/+4PXyNhk67FD9r4sRL5tJFw/Rewib6A6tT2vtLtMlmFr8v7GG5F7WMCTmQ==
X-Received: by 2002:a05:6a20:9c9b:b0:a7:a3cf:ddce with SMTP id mj27-20020a056a209c9b00b000a7a3cfddcemr55454577pzb.21.1671521121584;
        Mon, 19 Dec 2022 23:25:21 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:20 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v3 02/14] mm: Add Copy-On-Write PTE to fork()
Date:   Tue, 20 Dec 2022 15:27:31 +0800
Message-Id: <20221220072743.3039060-3-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221220072743.3039060-1-shiyn.lin@gmail.com>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add copy_cow_pte_range() and recover_pte_range() for copy-on-write (COW)
PTE in fork system call. During COW PTE fork, when processing the shared
PTE, we traverse all the entries to determine current mapped page is
available to share between processes. If PTE can be shared, account
those mapped pages and then share the PTE. However, once we find out the
mapped page is unavailable, e.g., pinned page, we have to copy it via
copy_present_page(), which means that we will fall back to default path,
page table copying. And, since we may have already processed some COW-ed
PTE entries, before starting the default path, we have to recover those
entries.

All the COW PTE behaviors are protected by the pte lock.
The logic of how we handle nonpresent/present pte entries and error
in copy_cow_pte_range() is same as copy_pte_range(). But to keep the
codes clean (e.g., avoiding condition lock), we introduce new functions
instead of modifying copy_pte_range().

To track the lifetime of COW-ed PTE, introduce the refcount of PTE.
We reuse the _refcount in struct page for the page table to maintain the
number of process references to COW-ed PTE table. Doing the fork with
COW PTE will increase the refcount. And, when someone writes to the
COW-ed PTE, it will cause the write fault to break COW PTE. If the
refcount of COW-ed PTE is one, the process that triggers the fault will
reuse the COW-ed PTE. Otherwise, the process will decrease the refcount
and duplicate it.

Since we share the PTE between the parent and child, the state of the
parent's pte entries is different between COW PTE and the normal fork.
COW PTE handles all the pte entries on the child side which means it
will clear the dirty and access bit of the parent's pte entry.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h |  16 +++
 mm/memory.c        | 263 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 279 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc55654..8c6ec1da2336f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2352,6 +2352,21 @@ static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
+static inline int pmd_get_pte(pmd_t *pmd)
+{
+	return page_ref_inc_return(pmd_page(*pmd));
+}
+
+static inline bool pmd_put_pte(pmd_t *pmd)
+{
+	return page_ref_add_unless(pmd_page(*pmd), -1, 1);
+}
+
+static inline int cow_pte_count(pmd_t *pmd)
+{
+	return page_count(pmd_page(*pmd));
+}
+
 static inline void pgtable_init(void)
 {
 	ptlock_cache_init();
@@ -2364,6 +2379,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
+	set_page_count(page, 1);
 	return true;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 8a6d5c823f91b..5b474d14a5411 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -786,11 +786,17 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
+	/* With COW PTE, dst_vma is src_vma. */
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(pte);
 
+	/*
+	 * If it's COW PTE, parent shares PTE with child. Which means the
+	 * following modifications of child will also affect parent.
+	 */
+
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
@@ -937,6 +943,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 /*
  * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
  * is required to copy this pte.
+ * However, if prealloc is NULL, it is COW PTE.
  */
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
@@ -960,6 +967,14 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
 			/* Page maybe pinned, we have to copy. */
 			put_page(page);
+			/*
+			 * If prealloc is NULL, we are processing share page
+			 * table (COW PTE, in copy_cow_pte_range()). We cannot
+			 * call copy_present_page() right now, instead, we
+			 * should fall back to copy_pte_range().
+			 */
+			if (!prealloc)
+				return -EAGAIN;
 			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
 						 addr, rss, prealloc, page);
 		}
@@ -980,6 +995,11 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	}
 	VM_BUG_ON(page && PageAnon(page) && PageAnonExclusive(page));
 
+	/*
+	 * If it's COW PTE, parent shares PTE with child.
+	 * Which means the following will also affect parent.
+	 */
+
 	/*
 	 * If it's a shared mapping, mark it clean in
 	 * the child
@@ -988,6 +1008,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
+	/* For COW PTE, dst_vma is still src_vma. */
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
@@ -1014,6 +1035,8 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	return new_page;
 }
 
+
+/* copy_pte_range() will immediately allocate new page table. */
 static int
 copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -1138,6 +1161,199 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return ret;
 }
 
+/*
+ * copy_cow_pte_range() will try to share the page table with child.
+ * The logic of non-present, present and error handling is same as
+ * copy_pte_range() but dst_vma and dst_pte are src_vma and src_pte.
+ *
+ * We cannot preserve soft-dirty information, because PTE will share
+ * between multiple processes.
+ */
+static int
+copy_cow_pte_range(struct vm_area_struct *dst_vma,
+		   struct vm_area_struct *src_vma,
+		   pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		   unsigned long end, unsigned long *recover_end)
+{
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	struct vma_iterator vmi;
+	struct vm_area_struct *curr = src_vma;
+	pte_t *src_pte, *orig_src_pte;
+	spinlock_t *src_ptl;
+	int ret = 0;
+	int rss[NR_MM_COUNTERS];
+	swp_entry_t entry = (swp_entry_t){0};
+	unsigned long vm_end, orig_addr = addr;
+	pgtable_t pte_table = pmd_page(*src_pmd);
+
+	end = (addr + PMD_SIZE) & PMD_MASK;
+	addr = addr & PMD_MASK;
+
+	/*
+	 * Increase the refcount to prevent the parent's PTE
+	 * dropped/reused. Only increace the refcount at first
+	 * time attached.
+	 */
+	src_ptl = pte_lockptr(src_mm, src_pmd);
+	spin_lock(src_ptl);
+	pmd_get_pte(src_pmd);
+	pmd_install(dst_mm, dst_pmd, &pte_table);
+	spin_unlock(src_ptl);
+
+	/*
+	 * We should handle all of the entries in this PTE at this traversal,
+	 * since we cannot promise that the next vma will not do the lazy fork.
+	 */
+	vma_iter_init(&vmi, src_mm, addr);
+	for_each_vma_range(vmi, curr, end) {
+		vm_end = min(end, curr->vm_end);
+		addr = max(addr, curr->vm_start);
+again:
+		init_rss_vec(rss);
+		src_pte = pte_offset_map(src_pmd, addr);
+		src_ptl = pte_lockptr(src_mm, src_pmd);
+		orig_src_pte = src_pte;
+		spin_lock(src_ptl);
+
+		arch_enter_lazy_mmu_mode();
+
+		do {
+			if (pte_none(*src_pte))
+				continue;
+			if (unlikely(!pte_present(*src_pte))) {
+				/*
+				 * Although, parent's PTE is COW-ed, we should
+				 * still need to handle all the swap stuffs.
+				 */
+				ret = copy_nonpresent_pte(dst_mm, src_mm,
+							  src_pte, src_pte,
+							  curr, curr,
+							  addr, rss);
+				if (ret == -EIO) {
+					entry = pte_to_swp_entry(*src_pte);
+					break;
+				} else if (ret == -EBUSY) {
+					break;
+				} else if (!ret)
+					continue;
+				/*
+				 * Device exclusive entry restored, continue by
+				 * copying the now present pte.
+				 */
+				WARN_ON_ONCE(ret != -ENOENT);
+			}
+			/*
+			 * copy_present_pte() will determine the mapped page
+			 * should be COW or not.
+			 */
+			ret = copy_present_pte(curr, curr, src_pte, src_pte,
+					       addr, rss, NULL);
+			/*
+			 * If we need a pre-allocated page for this pte,
+			 * drop the lock, recover all the entries, fall
+			 * back to copy_pte_range(), and try again.
+			 */
+			if (unlikely(ret == -EAGAIN))
+				break;
+		} while (src_pte++, addr += PAGE_SIZE, addr != vm_end);
+
+		arch_leave_lazy_mmu_mode();
+		add_mm_rss_vec(dst_mm, rss);
+		spin_unlock(src_ptl);
+		pte_unmap(orig_src_pte);
+		cond_resched();
+
+		if (ret == -EIO) {
+			VM_WARN_ON_ONCE(!entry.val);
+			if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			entry.val = 0;
+		} else if (ret == -EBUSY) {
+			goto out;
+		} else if (ret == -EAGAIN) {
+			/*
+			 * We've to allocate the page immediately but first we
+			 * should recover the processed entries and fall back
+			 * to copy_pte_range().
+			 */
+			*recover_end = addr;
+			return -EAGAIN;
+		} else if (ret) {
+			VM_WARN_ON_ONCE(1);
+		}
+
+		/* We've captured and resolved the error. Reset, try again. */
+		ret = 0;
+		if (addr != vm_end)
+			goto again;
+	}
+
+out:
+	/*
+	 * All the pte entries are available to COW.
+	 * Now, we can share with child.
+	 */
+	pmdp_set_wrprotect(src_mm, orig_addr, src_pmd);
+	set_pmd_at(dst_mm, orig_addr, dst_pmd, pmd_wrprotect(*src_pmd));
+
+	return ret;
+}
+
+/* WHen doing the recover, we should hold the locks entirely. */
+static int
+recover_pte_range(struct vm_area_struct *dst_vma,
+		  struct vm_area_struct *src_vma,
+		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long end)
+{
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	pte_t *orig_src_pte, *orig_dst_pte;
+	pte_t *src_pte, *dst_pte;
+	spinlock_t *src_ptl, *dst_ptl;
+	unsigned long addr = end & PMD_MASK;
+	int ret = 0;
+
+	/* Before we allocate the new PTE, clear the entry. */
+	pmd_clear(dst_pmd);
+	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
+	if (!dst_pte) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	src_pte = pte_offset_map(src_pmd, addr);
+	src_ptl = pte_lockptr(src_mm, src_pmd);
+	spin_lock(src_ptl);
+
+	orig_src_pte = src_pte;
+	orig_dst_pte = dst_pte;
+	arch_enter_lazy_mmu_mode();
+
+	do {
+		if (pte_none(*src_pte))
+			continue;
+		/* COW mapping should also handled by COW PTE. */
+		set_pte_at(dst_mm, addr, dst_pte, *src_pte);
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+
+	arch_leave_lazy_mmu_mode();
+	/*
+	 * Before unlock src_ptl, release the holding from child.
+	 * Parent may still share with others, so don't make it writeable.
+	 */
+	pmd_put_pte(src_pmd);
+	spin_unlock(src_ptl);
+	pte_unmap(orig_src_pte);
+	pte_unmap_unlock(orig_dst_pte, dst_ptl);
+	cond_resched();
+out:
+
+	return ret;
+}
+
 static inline int
 copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
@@ -1166,6 +1382,53 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 				continue;
 			/* fall through */
 		}
+
+		/*
+		 * If MMF_COW_PTE set, copy_pte_range() will try to share
+		 * the PTE page table first. In other words, it attempts to
+		 * do COW on PTE (and mapped pages). However, if there has
+		 * any unshareable page (e.g., pinned page, device private
+		 * page), it will fall back to the default path, which will
+		 * copy the page table immediately.
+		 * In such a case, it stores the address of first unshareable
+		 * page to recover_end then goes back to the beginning of PTE
+		 * and recovers the COW-ed PTE entries until it meets the same
+		 * unshareable page again. During the recovering, because of
+		 * COW-ed PTE entries are logical same as COW mapping, so it
+		 * only needs to allocate the new PTE and sets COW-ed PTE
+		 * entries to new PTE (which will be same as COW mapping).
+		 */
+		if (test_bit(MMF_COW_PTE, &src_mm->flags)) {
+			unsigned long recover_end = 0;
+			int ret;
+
+			/*
+			 * Setting wrprotect with normal PTE to pmd entry
+			 * will trigger pmd_bad(). Skip bad checking here.
+			 */
+			if (pmd_none(*src_pmd))
+				continue;
+			/* Skip if the PTE already did COW PTE this time. */
+			if (!pmd_none(*dst_pmd) && !pmd_write(*dst_pmd))
+				continue;
+
+			ret = copy_cow_pte_range(dst_vma, src_vma,
+						 dst_pmd, src_pmd,
+						 addr, next, &recover_end);
+			if (!ret) {
+				/* COW PTE succeeded. */
+				continue;
+			} else if (ret == -EAGAIN) {
+				/* fall back to normal copy method. */
+				if (recover_pte_range(dst_vma, src_vma,
+						      dst_pmd, src_pmd,
+						      recover_end))
+					return -ENOMEM;
+				addr = recover_end;
+				/* fall through */
+			} else if (ret)
+				return -ENOMEM;
+		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-- 
2.37.3

