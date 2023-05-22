Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2370BB91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjEVLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjEVLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:16:53 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4D269F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:11:08 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 6B89DE1EE9; Mon, 22 May 2023 18:53:06 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v8 3/6] ksm: add ksm zero pages for each process
Date:   Mon, 22 May 2023 18:53:05 +0800
Message-Id: <20230522105305.4126-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305221842587200002@zte.com.cn>
References: <202305221842587200002@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

As the number of ksm zero pages is not included in ksm_merging_pages per
process when enabling use_zero_pages, it's unclear of how many actual
pages are merged by KSM. To let users accurately estimate their memory
demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
pages per process. In addition, it help users to know the actual KSM
profit because KSM-placed zero pages are also benefit from KSM.

since unsharing zero pages placed by KSM accurately is achieved, then
tracking empty pages merging and unmerging is not a difficult thing any
longer.

Since we already have /proc/<pid>/ksm_stat, just add the information of
'ksm_zero_pages' in it.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 fs/proc/base.c           |  1 +
 include/linux/ksm.h      | 10 ++++++----
 include/linux/mm_types.h |  9 +++++++--
 mm/khugepaged.c          |  2 +-
 mm/ksm.c                 |  2 +-
 mm/memory.c              |  4 ++--
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..e407a34a46e8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3209,6 +3209,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
 		mmput(mm);
 	}
 
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 1adcae0205e3..ca29e95481b0 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -30,14 +30,16 @@ void __ksm_exit(struct mm_struct *mm);
 #define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 extern unsigned long ksm_zero_pages;
-static inline void inc_ksm_zero_pages(void)
+static inline void inc_ksm_zero_pages(struct mm_struct *mm)
 {
 	ksm_zero_pages++;
+	mm->ksm_zero_pages++;
 }
 
-static inline void dec_ksm_zero_pages(void)
+static inline void dec_ksm_zero_pages(struct mm_struct *mm)
 {
 	ksm_zero_pages--;
+	mm->ksm_zero_pages--;
 }
 
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
@@ -110,11 +112,11 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 #define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
 #define is_ksm_zero_pte(pte)	0
-static inline void inc_ksm_zero_pages(void)
+static inline void inc_ksm_zero_pages(struct mm_struct *mm)
 {
 }
 
-static inline void dec_ksm_zero_pages(void)
+static inline void dec_ksm_zero_pages(struct mm_struct *mm)
 {
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..14f781509812 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -777,7 +777,7 @@ struct mm_struct {
 #ifdef CONFIG_KSM
 		/*
 		 * Represent how many pages of this process are involved in KSM
-		 * merging.
+		 * merging (not including ksm_zero_pages).
 		 */
 		unsigned long ksm_merging_pages;
 		/*
@@ -785,7 +785,12 @@ struct mm_struct {
 		 * including merged and not merged.
 		 */
 		unsigned long ksm_rmap_items;
-#endif
+		/*
+		 * Represent how many empty pages are merged with kernel zero
+		 * pages when enabling KSM use_zero_pages.
+		 */
+		unsigned long ksm_zero_pages;
+#endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN
 		struct {
 			/* this mm_struct is on lru_gen_mm_list */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ba0d077b6951..5cd6ac70261e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -713,7 +713,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 				ptep_clear(vma->vm_mm, address, _pte);
 				spin_unlock(ptl);
 				if (is_ksm_zero_pte(pteval))
-					dec_ksm_zero_pages();
+					dec_ksm_zero_pages(vma->vm_mm);
 			}
 		} else {
 			src_page = pte_page(pteval);
diff --git a/mm/ksm.c b/mm/ksm.c
index 2ca7e8860faa..4e510f5c5938 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1226,7 +1226,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	} else {
 		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
-		inc_ksm_zero_pages();
+		inc_ksm_zero_pages(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
diff --git a/mm/memory.c b/mm/memory.c
index 058b416adf24..2603dad833d0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1417,7 +1417,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 						      ptent);
 			if (unlikely(!page)) {
 				if (is_ksm_zero_pte(ptent))
-					dec_ksm_zero_pages();
+					dec_ksm_zero_pages(mm);
 				continue;
 			}
 
@@ -3124,7 +3124,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			}
 		} else {
 			if (is_ksm_zero_pte(vmf->orig_pte))
-				dec_ksm_zero_pages();
+				dec_ksm_zero_pages(mm);
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-- 
2.15.2
