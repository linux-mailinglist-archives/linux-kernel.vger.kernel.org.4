Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15570ED77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbjEXF6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbjEXF6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:58:19 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE1132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:58:14 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id ECE64E1EE6; Wed, 24 May 2023 13:58:02 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v9 3/5] ksm: add ksm zero pages for each process
Date:   Wed, 24 May 2023 13:58:00 +0800
Message-Id: <20230524055800.20498-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305241351365661923@zte.com.cn>
References: <202305241351365661923@zte.com.cn>
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
 fs/proc/base.c           | 1 +
 include/linux/ksm.h      | 6 ++++--
 include/linux/mm_types.h | 9 +++++++--
 mm/khugepaged.c          | 2 +-
 mm/ksm.c                 | 1 +
 mm/memory.c              | 4 ++--
 6 files changed, 16 insertions(+), 7 deletions(-)

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
index f2d98c53cfec..0e6f04ac3f2b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -35,10 +35,12 @@ void __ksm_exit(struct mm_struct *mm);
 
 extern unsigned long ksm_zero_pages;
 
-static inline void ksm_notify_unmap_zero_page(pte_t pte)
+static inline void ksm_notify_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
-	if (is_ksm_zero_pte(pte))
+	if (is_ksm_zero_pte(pte)) {
 		ksm_zero_pages--;
+		mm->ksm_zero_pages--;
+	}
 }
 
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
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
index e417a928ef8d..85dc2e922f64 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -712,7 +712,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 				spin_lock(ptl);
 				ptep_clear(vma->vm_mm, address, _pte);
 				spin_unlock(ptl);
-				ksm_notify_unmap_zero_page(pteval);
+				ksm_notify_unmap_zero_page(vma->vm_mm, pteval);
 			}
 		} else {
 			src_page = pte_page(pteval);
diff --git a/mm/ksm.c b/mm/ksm.c
index d3ed90159322..07a6fe7d7c99 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1231,6 +1231,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
 		ksm_zero_pages++;
+		mm->ksm_zero_pages++;
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
diff --git a/mm/memory.c b/mm/memory.c
index 09c31160af4e..26bb291c1c72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1416,7 +1416,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
 			if (unlikely(!page)) {
-				ksm_notify_unmap_zero_page(ptent);
+				ksm_notify_unmap_zero_page(mm, ptent);
 				continue;
 			}
 
@@ -3122,7 +3122,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
-			ksm_notify_unmap_zero_page(vmf->orig_pte);
+			ksm_notify_unmap_zero_page(mm, vmf->orig_pte);
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-- 
2.15.2
