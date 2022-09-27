Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037F75EC97D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiI0Q3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiI0Q2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6711D6D3E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e68so10168527pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VnIN7aCnF5zg62leJbyDnNV6liD03aQ32fsEaaJloIU=;
        b=fsg0KihQvoWiGIhH+ksRX4pZozCAqcUXZJoJDAUOprO4czcq1U39r9FGLdAzAg5g/8
         7Mr3k/AeEoktBnacW68xdRXUhpTTZjOo/v6XuvgTVXCvS0TamvuJeCuldOKVjsQks+At
         6s7IhGc5QaPrpOUuBrs/vKjstyY+qKvpcDQ4mWOG2idoGXQy1+040YxdD+k7VDrYF/Xf
         pL0HVUEhBoStMBOrcju6EGrhEGUejxsBN4TSYYvWfmDqBdPGqt8/cbBS5FyZ7BbAjrvl
         YPIy88e3FkvrGeYVRDmc5FdhevfzNafGweJvM9nC8iLeSDz957d2fkqQEyu5j04z5F38
         Xkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VnIN7aCnF5zg62leJbyDnNV6liD03aQ32fsEaaJloIU=;
        b=m6h9XPEwP2qov+HAfMRJwicqvzCMXuaUXQw8LegZeie0heA06HEqkV9ovDYrMjS0Ba
         LaulnkU2ZSsWd66kAq3flTZ1j4fFPisSIS85NP8TxcLrFT0dOwjGuCb2WmcmjEO/ncKo
         ueJsujKioAtZP3a7FaFkjxzD3n41oIOc24eJ+toeRa7BGS0uGybWhgzqgcXPaVUbeVUS
         l0qHje/7soZ7S6JOuMPSHltuflNczTqzSU14W67MelWi30ob79LlCl/PrgqcnwgzwoDX
         3UOIu37hJVgi74AoNZMHMN/UVIS5S4t2X9HWr8I1YO/+h41GQAQm2KX9utzA5bHsW0VN
         j6Tw==
X-Gm-Message-State: ACrzQf2KP92/94pkUTu5Vu/cGm+4nCIPQ77oOi5AqQARXL6alOU/uM3B
        lMCyjdq4y2DZ7K1If6rerYc=
X-Google-Smtp-Source: AMsMyM67l7AHsumdCaArKikJNOJaaDkNNe3imQK1Gmo9dsopNJWErpmOsAxQEwlR62zMKUsb8Rld5A==
X-Received: by 2002:a63:5a44:0:b0:431:fa3a:f92c with SMTP id k4-20020a635a44000000b00431fa3af92cmr25975839pgm.471.1664296094902;
        Tue, 27 Sep 2022 09:28:14 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:28:14 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 7/9] mm: Add the break COW PTE handler
Date:   Wed, 28 Sep 2022 00:29:55 +0800
Message-Id: <20220927162957.270460-8-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
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

To handle the COW PTE with write fault, introduce the helper function
handle_cow_pte(). The function provides two behaviors. One is breaking
COW by decreasing the refcount, pgables_bytes, and RSS. Another is
copying all the information in the shared PTE table by using
copy_pte_page() with a wrapper.

Also, add the wrapper functions to help us find out the COWed or
COW-available PTE table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/pgtable.h |  75 +++++++++++++++++
 mm/memory.c             | 179 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 254 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9b08a3361d490..85255f5223ae3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -10,6 +10,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/page_ref.h>
+#include <linux/sched/coredump.h> /* For MMF_COW_PTE flag */
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <asm-generic/pgtable_uffd.h>
@@ -674,6 +675,42 @@ static inline void pmd_cow_pte_clear_mkexclusive(pmd_t *pmd)
 	set_cow_pte_owner(pmd, NULL);
 }
 
+static inline unsigned long get_pmd_start_edge(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	unsigned long start = addr & PMD_MASK;
+
+	if (start < vma->vm_start)
+		start = vma->vm_start;
+
+	return start;
+}
+
+static inline unsigned long get_pmd_end_edge(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	unsigned long end = (addr + PMD_SIZE) & PMD_MASK;
+
+	if (end > vma->vm_end)
+		end = vma->vm_end;
+
+	return end;
+}
+
+static inline bool is_cow_pte_available(struct vm_area_struct *vma, pmd_t *pmd)
+{
+	if (!vma || !pmd)
+		return false;
+	if (!test_bit(MMF_COW_PTE, &vma->vm_mm->flags))
+		return false;
+	if (pmd_cow_pte_exclusive(pmd))
+		return false;
+	return true;
+}
+
+int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
+		    bool alloc);
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
@@ -1002,6 +1039,44 @@ int cow_pte_handler(struct ctl_table *table, int write, void *buffer,
 
 extern int sysctl_cow_pte_pid;
 
+static inline bool __is_pte_table_cowing(struct vm_area_struct *vma, pmd_t *pmd,
+				       unsigned long addr)
+{
+	if (!vma)
+		return false;
+	if (!pmd) {
+		pgd_t *pgd;
+		p4d_t *p4d;
+		pud_t *pud;
+
+		if (addr == 0)
+			return false;
+
+		pgd = pgd_offset(vma->vm_mm, addr);
+		if (pgd_none_or_clear_bad(pgd))
+			return false;
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none_or_clear_bad(p4d))
+			return false;
+		pud = pud_offset(p4d, addr);
+		if (pud_none_or_clear_bad(pud))
+			return false;
+		pmd = pmd_offset(pud, addr);
+	}
+	if (!test_bit(MMF_COW_PTE, &vma->vm_mm->flags))
+		return false;
+	if (pmd_none(*pmd) || pmd_write(*pmd))
+		return false;
+	if (pmd_cow_pte_exclusive(pmd))
+		return false;
+	return true;
+}
+
+static inline bool is_pte_table_cowing(struct vm_area_struct *vma, pmd_t *pmd)
+{
+	return __is_pte_table_cowing(vma, pmd, 0UL);
+}
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 3e66e229f4169..4cf3f74fb183f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2911,6 +2911,185 @@ void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pmd_at(mm, addr, pmd, new);
 }
 
+static inline int copy_cow_pte_range(struct vm_area_struct *vma,
+				     pmd_t *dst_pmd, pmd_t *src_pmd,
+				     unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	int ret;
+	bool is_cow;
+
+	is_cow = is_cow_mapping(vma->vm_flags);
+	if (is_cow) {
+		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
+					0, vma, mm, start, end);
+		mmu_notifier_invalidate_range_start(&range);
+		mmap_assert_write_locked(mm);
+		raw_write_seqcount_begin(&mm->write_protect_seq);
+	}
+
+	ret = copy_pte_range(vma, vma, dst_pmd, src_pmd, start, end);
+
+	if (is_cow) {
+		raw_write_seqcount_end(&mm->write_protect_seq);
+		mmu_notifier_invalidate_range_end(&range);
+	}
+
+	return ret;
+}
+
+/*
+ * Break COW PTE, two state here:
+ *   - After fork :   [parent, rss=1, ref=2, write=NO , owner=parent]
+ *                 to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
+ *                    COW PTE become [ref=1, write=NO , owner=NULL  ]
+ *                    [child , rss=0, ref=2, write=NO , owner=parent]
+ *                 to [child , rss=1, ref=1, write=YES, owner=NULL  ]
+ *                    COW PTE become [ref=1, write=NO , owner=parent]
+ *   NOTE
+ *     - Copy the COW PTE to new PTE.
+ *     - Clear the owner of COW PTE and set PMD entry writable when it is owner.
+ *     - Increase RSS if it is not owner.
+ */
+static int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+			 unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long pte_start, pte_end;
+	unsigned long start, end;
+	struct vm_area_struct *prev = vma->vm_prev;
+	struct vm_area_struct *next = vma->vm_next;
+	pmd_t cowed_entry = *pmd;
+
+	if (cow_pte_count(&cowed_entry) == 1) {
+		cow_pte_fallback(vma, pmd, addr);
+		return 1;
+	}
+
+	pte_start = start = addr & PMD_MASK;
+	pte_end = end = (addr + PMD_SIZE) & PMD_MASK;
+
+	pmd_clear(pmd);
+	/*
+	 * If the vma does not cover the entire address range of the PTE table,
+	 * it should check the previous and next.
+	 */
+	if (start < vma->vm_start && prev) {
+		/* The part of address range is covered by previous. */
+		if (start < prev->vm_end)
+			copy_cow_pte_range(prev, pmd, &cowed_entry,
+					   start, prev->vm_end);
+		start = vma->vm_start;
+	}
+	if (end > vma->vm_end && next) {
+		/* The part of address range is covered by next. */
+		if (end > next->vm_start)
+			copy_cow_pte_range(next, pmd, &cowed_entry,
+					   next->vm_start, end);
+		end = vma->vm_end;
+	}
+	if (copy_cow_pte_range(vma, pmd, &cowed_entry, start, end))
+		return -ENOMEM;
+
+	/*
+	 * Here, it is the owner, so clear the ownership. To keep RSS state and
+	 * page table bytes correct, it needs to decrease them.
+	 * Also, handle the address range issue here.
+	 */
+	if (cow_pte_owner_is_same(&cowed_entry, pmd)) {
+		set_cow_pte_owner(&cowed_entry, NULL);
+		if (pte_start < vma->vm_start && prev &&
+		    pte_start < prev->vm_end)
+			cow_pte_rss(mm, vma->vm_prev, pmd,
+				    pte_start, prev->vm_end, false /* dec */);
+		if (pte_end > vma->vm_end && next &&
+		    pte_end > next->vm_start)
+			cow_pte_rss(mm, vma->vm_next, pmd,
+				    next->vm_start, pte_end, false /* dec */);
+		cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
+		mm_dec_nr_ptes(mm);
+	}
+
+	/* Already handled it, don't reuse cowed table. */
+	pmd_put_pte(vma, &cowed_entry, addr, false);
+
+	VM_BUG_ON(cow_pte_count(pmd) != 1);
+
+	return 0;
+}
+
+static int zap_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		       unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long start, end;
+
+	if (pmd_put_pte(vma, pmd, addr, true)) {
+		/* fallback, reuse pgtable */
+		return 1;
+	}
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+
+	/*
+	 * If PMD entry is owner, clear the ownership,
+	 * and decrease RSS state and pgtable_bytes.
+	 */
+	if (cow_pte_owner_is_same(pmd, pmd)) {
+		set_cow_pte_owner(pmd, NULL);
+		cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
+		mm_dec_nr_ptes(mm);
+	}
+
+	pmd_clear(pmd);
+	return 0;
+}
+
+/**
+ * handle_cow_pte - Break COW PTE, copy/dereference the shared PTE table
+ * @vma: target vma want to break COW
+ * @pmd: pmd index that maps to the shared PTE table
+ * @addr: the address trigger the break COW
+ * @alloc: copy PTE table if alloc is true, otherwise dereference
+ *
+ * The address needs to be in the range of the PTE table that the pmd index
+ * mapped. If pmd is NULL, it will get the pmd from vma and check it is COWing.
+ */
+int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
+		    bool alloc)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	struct mm_struct *mm = vma->vm_mm;
+	int ret = 0;
+
+	if (!pmd) {
+		pgd = pgd_offset(mm, addr);
+		if (pgd_none_or_clear_bad(pgd))
+			return 0;
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none_or_clear_bad(p4d))
+			return 0;
+		pud = pud_offset(p4d, addr);
+		if (pud_none_or_clear_bad(pud))
+			return 0;
+		pmd = pmd_offset(pud, addr);
+	}
+
+	if (!is_pte_table_cowing(vma, pmd))
+		return 0;
+
+	if (alloc)
+		ret = break_cow_pte(vma, pmd, addr);
+	else
+		ret = zap_cow_pte(vma, pmd, addr);
+
+	return ret;
+}
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.37.3

