Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F46E0691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDMFyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMFyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:54:44 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D810E5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:54:42 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 66067E090F; Thu, 13 Apr 2023 05:54:41 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>
Subject: [PATCH v7 2/6] ksm: count all zero pages placed by KSM
Date:   Thu, 13 Apr 2023 13:54:39 +0800
Message-Id: <20230413055439.181039-1-yang.yang29@zte.com.cn>
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
of all zero pages placed by KSM.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/ksm.h | 16 ++++++++++++++++
 mm/ksm.c            | 18 ++++++++++++++++++
 mm/memory.c         |  7 ++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index f0cc085be42a..ea628d2a9105 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -99,9 +99,25 @@ static inline void folio_migrate_ksm(struct folio *newfolio, struct folio *old)
 /* use pte_mkdirty to track a KSM-placed zero page */
 #define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
+extern unsigned long ksm_zero_pages;
+static inline void inc_ksm_zero_pages(void)
+{
+	ksm_zero_pages++;
+}
+
+static inline void dec_ksm_zero_pages(void)
+{
+	ksm_zero_pages--;
+}
 #else /* !CONFIG_KSM_ZERO_PAGES_TRACK */
 #define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
 #define is_ksm_zero_pte(pte)	0
+static inline void inc_ksm_zero_pages(void)
+{
+}
+static inline void dec_ksm_zero_pages(void)
+{
+}
 #endif /* CONFIG_KSM_ZERO_PAGES_TRACK */
 
 #endif /* __LINUX_KSM_H */
diff --git a/mm/ksm.c b/mm/ksm.c
index 1d1771a6b3fe..232680393741 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -278,6 +278,11 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+/* The number of zero pages which is placed by KSM */
+unsigned long ksm_zero_pages;
+#endif
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -1243,6 +1248,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	} else {
 		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
+		inc_ksm_zero_pages();
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
@@ -3216,6 +3222,15 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(pages_volatile);
 
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+static ssize_t ksm_zero_pages_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
+}
+KSM_ATTR_RO(ksm_zero_pages);
+#endif /* CONFIG_KSM_ZERO_PAGES_TRACK */
+
 static ssize_t general_profit_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
@@ -3286,6 +3301,9 @@ static struct attribute *ksm_attrs[] = {
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
 	&pages_volatile_attr.attr,
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+	&ksm_zero_pages_attr.attr,
+#endif
 	&full_scans_attr.attr,
 #ifdef CONFIG_NUMA
 	&merge_across_nodes_attr.attr,
diff --git a/mm/memory.c b/mm/memory.c
index 42dd1ab5e4e6..76598287280f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1416,8 +1416,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
-			if (unlikely(!page))
+			if (unlikely(!page)) {
+				if (is_ksm_zero_pte(ptent))
+					dec_ksm_zero_pages();
 				continue;
+			}
 
 			delay_rmap = 0;
 			if (!PageAnon(page)) {
@@ -3118,6 +3121,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
+			if (is_ksm_zero_pte(vmf->orig_pte))
+				dec_ksm_zero_pages();
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-- 
2.15.2
