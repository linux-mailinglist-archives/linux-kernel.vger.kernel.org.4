Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295E5EC979
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiI0Q2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiI0Q2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55D1D627A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so9875542pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qtDTgqvL6bCy2no1plZzpxkuhtLBIBb+n3/hplN/Z/Y=;
        b=FzFtQXjj92j3O/H1zVoIJZp8ly+GIWZRl3xTccpG09pEOnFdvbMOlsIcUIBeNI/v3B
         UD1S8mWZ2yXBrb3n6jgJSt0E5RF+gXqgGtuh86h2BpC3F3FRMrrWsXamK9xElcwQqols
         jPrnfjL1eCfd1DqzvEYirEyTIVoeW5jBow7P94Ini/tlROY4ZMG0DYedWqT3RcRe+iui
         +It/6Wdgz5o7ZszruRcP1toM0eek1btHojwSLVbC4aUpskYK4HHxV8x1NH+R9xk+kX6Q
         EaYJWFpB9iayD9ALgD3Mh1qmX+HqtmsGlOhWtft/GRaOkkauRHPGjUXzF7Uy1ap1K/AG
         nPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qtDTgqvL6bCy2no1plZzpxkuhtLBIBb+n3/hplN/Z/Y=;
        b=aU+EL2d99vFaxkiw/8wolMiEm19RL7cEr0Qjo8aWlJTeVPPrAAtlAWRVUMoJjGEOb0
         beYIxqo1w/JnnfNwTckh7wla0wFYFhtzZ2qitfADfb9unYER50ZrF9Dl1wRJ9QfIwqSi
         f1tlGGyBLw0Hmf/m8KY4HXRTYpAmwSP6WeDDMBcvLIlmzXR6l0BdOO59Q3QxPl6F3PHC
         cMkyDzuStuKoeEmBU6+xDaW6h5Yl3y/IIqGz7Jr8EdSOHQZXSNyB8nyuBmF0eBO/xRlK
         1CtyOiiZZjvlzGALAwFm1FxBLU4P/wJVq28Sbn3vK7jBbHsdxjiTHJJc5/TOPmr4Pyn3
         pRBQ==
X-Gm-Message-State: ACrzQf1RGxQ9kfecXJC5+rZlI54LD82n3g0sLlrFzokk6qWS5CwF1sxl
        FbNwg2fquUUuzxcxKjtr23g=
X-Google-Smtp-Source: AMsMyM76qYcRgHJgPAFLzh39+ye4Tgr8AF4QcPQDirN61vSKKf/FpRs4uUf3Owokdc+QLh8yo/Czvg==
X-Received: by 2002:a63:500d:0:b0:439:dcdd:87af with SMTP id e13-20020a63500d000000b00439dcdd87afmr25634968pgb.231.1664296078073;
        Tue, 27 Sep 2022 09:27:58 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:27:57 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/9] mm: Add COW PTE fallback functions
Date:   Wed, 28 Sep 2022 00:29:52 +0800
Message-Id: <20220927162957.270460-5-shiyn.lin@gmail.com>
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

The lifetime of COWed PTE table will handle by a reference count.
When the process wants to write the COWed PTE table, which refcount
is 1, it will reuse the shared PTE.

Since only the owner will update their page table state. the fallback
function also needs to handle the situation of non-owner COWed PTE table
fallback to normal PTE.

This commit prepares for the following implementation of the reference
count for COW PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/pgtable.h |  3 ++
 mm/memory.c             | 93 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9dca787a3f4dd..25c1e5c42fdf3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -615,6 +615,9 @@ static inline int pte_unused(pte_t pte)
 }
 #endif
 
+void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
+		      unsigned long addr);
+
 static inline void set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
 {
 	smp_store_release(&pmd_page(*pmd)->cow_pte_owner, owner);
diff --git a/mm/memory.c b/mm/memory.c
index 4ba73f5aa8bb7..d29f84801f3cd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -509,6 +509,37 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 			add_mm_counter(mm, i, rss[i]);
 }
 
+static void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma,
+			       pmd_t *pmdp, unsigned long addr,
+			       unsigned long end, bool inc_dec)
+{
+	int rss[NR_MM_COUNTERS];
+	spinlock_t *ptl;
+	pte_t *orig_ptep, *ptep;
+	struct page *page;
+
+	init_rss_vec(rss);
+
+	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	orig_ptep = ptep;
+	arch_enter_lazy_mmu_mode();
+	do {
+		if (pte_none(*ptep))
+			continue;
+
+		page = vm_normal_page(vma, addr, *ptep);
+		if (page) {
+			if (inc_dec)
+				rss[mm_counter(page)]++;
+			else
+				rss[mm_counter(page)]--;
+		}
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+	arch_leave_lazy_mmu_mode();
+	pte_unmap_unlock(orig_ptep, ptl);
+	add_mm_rss_vec(mm, rss);
+}
+
 /*
  * This function is called to print an error when a bad pte
  * is found. For example, we might have a PFN-mapped pte in
@@ -2817,6 +2848,68 @@ int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
+/**
+ * cow_pte_fallback - reuse the shared PTE table
+ * @vma: vma that coever the shared PTE table
+ * @pmd: pmd index maps to the shared PTE table
+ * @addr: the address trigger the break COW,
+ *
+ * Reuse the shared (COW) PTE table when the refcount is equal to one.
+ * @addr needs to be in the range of the shared PTE table that @vma and
+ * @pmd mapped to it.
+ *
+ * COW PTE fallback to normal PTE:
+ * - two state here
+ *   - After break child :   [parent, rss=1, ref=1, write=NO , owner=parent]
+ *                        to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
+ *   - After break parent:   [child , rss=0, ref=1, write=NO , owner=NULL  ]
+ *                        to [child , rss=1, ref=1, write=YES, owner=NULL  ]
+ */
+void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
+		      unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *prev = vma->vm_prev;
+	struct vm_area_struct *next = vma->vm_next;
+	unsigned long start, end;
+	pmd_t new;
+
+	VM_WARN_ON(pmd_write(*pmd));
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+
+	/*
+	 * If pmd is not owner, it needs to increase the rss.
+	 * Since only the owner has the RSS state for the COW PTE.
+	 */
+	if (!cow_pte_owner_is_same(pmd, pmd)) {
+		/* The part of address range is covered by previous. */
+		if (start < vma->vm_start && prev && start < prev->vm_end) {
+			cow_pte_rss(mm, prev, pmd,
+				    start, prev->vm_end, true /* inc */);
+			start = vma->vm_start;
+		}
+		/* The part of address range is covered by next. */
+		if (end > vma->vm_end && next && end > next->vm_start) {
+			cow_pte_rss(mm, next, pmd,
+				    next->vm_start, end, true /* inc */);
+			end = vma->vm_end;
+		}
+		cow_pte_rss(mm, vma, pmd, start, end, true /* inc */);
+
+		mm_inc_nr_ptes(mm);
+		/* Memory barrier here is the same as pmd_install(). */
+		smp_wmb();
+		pmd_populate(mm, pmd, pmd_page(*pmd));
+	}
+
+	/* Reuse the pte page */
+	set_cow_pte_owner(pmd, NULL);
+	new = pmd_mkwrite(*pmd);
+	set_pmd_at(mm, addr, pmd, new);
+}
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.37.3

