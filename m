Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9C6E0696
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDMFzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDMFzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:55:54 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024864ED8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:55:52 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id AE1D7E196E; Thu, 13 Apr 2023 05:55:51 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>
Subject: [PATCH v7 3/6] ksm: add ksm zero pages for each process
Date:   Thu, 13 Apr 2023 13:55:47 +0800
Message-Id: <20230413055547.181107-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202304131346489021903@zte.com.cn>
References: <202304131346489021903@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS
        autolearn=no autolearn_force=no version=3.4.6
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
 fs/proc/base.c           |  3 +++
 include/linux/ksm.h      | 10 ++++++----
 include/linux/mm_types.h | 11 +++++++++--
 mm/ksm.c                 |  2 +-
 mm/memory.c              |  4 ++--
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ab9fa5b1b6be..235182cd143d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3211,6 +3211,9 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_merge_type %s\n", ksm_merge_type(mm));
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
+#endif
 		mmput(mm);
 	}
 
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index ea628d2a9105..2da40af9ad4d 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -100,22 +100,24 @@ static inline void folio_migrate_ksm(struct folio *newfolio, struct folio *old)
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
 #else /* !CONFIG_KSM_ZERO_PAGES_TRACK */
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
 #endif /* CONFIG_KSM_ZERO_PAGES_TRACK */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fc9e680f174..2e72329ed1a2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -766,7 +766,7 @@ struct mm_struct {
 #ifdef CONFIG_KSM
 		/*
 		 * Represent how many pages of this process are involved in KSM
-		 * merging.
+		 * merging (not including ksm_zero_pages).
 		 */
 		unsigned long ksm_merging_pages;
 		/*
@@ -774,7 +774,14 @@ struct mm_struct {
 		 * including merged and not merged.
 		 */
 		unsigned long ksm_rmap_items;
-#endif
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+		/*
+		 * Represent how many empty pages are merged with kernel zero
+		 * pages when enabling KSM use_zero_pages.
+		 */
+		unsigned long ksm_zero_pages;
+#endif /* CONFIG_KSM_ZERO_PAGES_TRACK */
+#endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN
 		struct {
 			/* this mm_struct is on lru_gen_mm_list */
diff --git a/mm/ksm.c b/mm/ksm.c
index 232680393741..7867fae3c61c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1248,7 +1248,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	} else {
 		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
-		inc_ksm_zero_pages();
+		inc_ksm_zero_pages(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
diff --git a/mm/memory.c b/mm/memory.c
index 76598287280f..ec89b81a14fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1418,7 +1418,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 						      ptent);
 			if (unlikely(!page)) {
 				if (is_ksm_zero_pte(ptent))
-					dec_ksm_zero_pages();
+					dec_ksm_zero_pages(mm);
 				continue;
 			}
 
@@ -3122,7 +3122,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
