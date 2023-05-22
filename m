Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F253870BA53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjEVKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEVKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:49:14 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD538DC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:49:13 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 5EA9FE0CF6; Mon, 22 May 2023 18:49:11 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
Date:   Mon, 22 May 2023 18:49:08 +0800
Message-Id: <20230522104908.3999-1-yang.yang29@zte.com.cn>
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

When use_zero_pages of ksm is enabled, madvise(addr, len, MADV_UNMERGEABLE)
and other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger
unsharing will *not* actually unshare the shared zeropage as placed by KSM
(which is against the MADV_UNMERGEABLE documentation). As these KSM-placed
zero pages are out of the control of KSM, the related counts of ksm pages
don't expose how many zero pages are placed by KSM (these special zero
pages are different from those initially mapped zero pages, because the
zero pages mapped to MADV_UNMERGEABLE areas are expected to be a complete
and unshared page)

To not blindly unshare all shared zero_pages in applicable VMAs, the patch
use pte_mkdirty (related with architecture) to mark KSM-placed zero pages.
Thus, MADV_UNMERGEABLE will only unshare those KSM-placed zero pages.

The patch will not degrade the performance of use_zero_pages as it doesn't
change the way of merging empty pages in use_zero_pages's feature.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/ksm.h | 6 ++++++
 mm/ksm.c            | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 899a314bc487..7989200cdbb7 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -26,6 +26,9 @@ int ksm_disable(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+/* use pte_mkdirty to track a KSM-placed zero page */
+#define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
+#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
@@ -95,6 +98,9 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+#define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
+#define is_ksm_zero_pte(pte)	0
+
 #ifdef CONFIG_MEMORY_FAILURE
 static inline void collect_procs_ksm(struct page *page,
 				     struct list_head *to_kill, int force_early)
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..9962f5962afd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -447,7 +447,8 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 		if (is_migration_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
 	}
-	ret = page && PageKsm(page);
+	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
+	ret = (page && PageKsm(page)) || is_ksm_zero_pte(*pte);
 	pte_unmap_unlock(pte, ptl);
 	return ret;
 }
@@ -1220,7 +1221,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
-		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
+		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
-- 
2.15.2

