Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF270ED76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbjEXF6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjEXF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:58:13 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4EC1B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:58:00 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 81B28E1EE2; Wed, 24 May 2023 13:57:54 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v9 2/5] ksm: count all zero pages placed by KSM
Date:   Wed, 24 May 2023 13:57:52 +0800
Message-Id: <20230524055752.20449-1-yang.yang29@zte.com.cn>
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

As pages_sharing and pages_shared don't include the number of zero pages
merged by KSM, we cannot know how many pages are zero pages placed by KSM
when enabling use_zero_pages, which leads to KSM not being transparent with
all actual merged pages by KSM. In the early days of use_zero_pages,
zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
it's hard to count how many times one of those zeropages was then unmerged.

But now, unsharing KSM-placed zero page accurately has been achieved, so we
can easily count both how many times a page full of zeroes was merged with
zero-page and how many times one of those pages was then unmerged. and so,
it helps to estimate memory demands when each and every shared page could
get unshared.

So we add ksm_zero_pages under /sys/kernel/mm/ksm/ to show the number
of all zero pages placed by KSM. Meanwhile, we update the Documentation.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst |  7 +++++++
 include/linux/ksm.h                  | 12 ++++++++++++
 mm/khugepaged.c                      |  2 ++
 mm/ksm.c                             | 12 ++++++++++++
 mm/memory.c                          |  5 ++++-
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 7626392fe82c..6cc919dbfd55 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -173,6 +173,13 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+ksm_zero_pages
+        how many zero pages that are still mapped into processes were mapped by
+        KSM when deduplicating.
+
+When ``use_zero_pages`` is/was enabled, the sum of ``pages_sharing`` +
+``ksm_zero_pages`` represents the actual number of pages saved by KSM.
+if ``use_zero_pages`` has never been enabled, ``ksm_zero_pages`` is 0.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 4fd5f4a50bac..f2d98c53cfec 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -33,6 +33,14 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
+extern unsigned long ksm_zero_pages;
+
+static inline void ksm_notify_unmap_zero_page(pte_t pte)
+{
+	if (is_ksm_zero_pte(pte))
+		ksm_zero_pages--;
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	int ret;
@@ -103,6 +111,10 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 #define is_ksm_zero_pte(pte)	0
 
+static inline void ksm_notify_unmap_zero_page(pte_t pte)
+{
+}
+
 #ifdef CONFIG_MEMORY_FAILURE
 static inline void collect_procs_ksm(struct page *page,
 				     struct list_head *to_kill, int force_early)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9d39d65b73..e417a928ef8d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -19,6 +19,7 @@
 #include <linux/page_table_check.h>
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
+#include <linux/ksm.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -711,6 +712,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 				spin_lock(ptl);
 				ptep_clear(vma->vm_mm, address, _pte);
 				spin_unlock(ptl);
+				ksm_notify_unmap_zero_page(pteval);
 			}
 		} else {
 			src_page = pte_page(pteval);
diff --git a/mm/ksm.c b/mm/ksm.c
index f31c789406b1..d3ed90159322 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -278,6 +278,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/* The number of zero pages which is placed by KSM */
+unsigned long ksm_zero_pages;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -1227,6 +1230,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
+		ksm_zero_pages++;
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
@@ -3354,6 +3358,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(pages_volatile);
 
+static ssize_t ksm_zero_pages_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
+}
+KSM_ATTR_RO(ksm_zero_pages);
+
 static ssize_t general_profit_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
@@ -3421,6 +3432,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
 	&pages_volatile_attr.attr,
+	&ksm_zero_pages_attr.attr,
 	&full_scans_attr.attr,
 #ifdef CONFIG_NUMA
 	&merge_across_nodes_attr.attr,
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..09c31160af4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1415,8 +1415,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
-			if (unlikely(!page))
+			if (unlikely(!page)) {
+				ksm_notify_unmap_zero_page(ptent);
 				continue;
+			}
 
 			delay_rmap = 0;
 			if (!PageAnon(page)) {
@@ -3120,6 +3122,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
+			ksm_notify_unmap_zero_page(vmf->orig_pte);
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-- 
2.15.2
