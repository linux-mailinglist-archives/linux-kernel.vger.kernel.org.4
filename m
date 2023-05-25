Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB1710581
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjEYFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:53:47 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AE18C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:52:51 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id CEE22E1D12; Thu, 25 May 2023 13:52:28 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v10 1/5] ksm: support unsharing KSM-placed zero pages
Date:   Thu, 25 May 2023 13:52:27 +0800
Message-Id: <20230525055227.27213-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305251341580149313@zte.com.cn>
References: <202305251341580149313@zte.com.cn>
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
and unshared page).

To not blindly unshare all shared zero_pages in applicable VMAs, the patch
use pte_mkdirty (related with architecture) to mark KSM-placed zero pages.
Thus, MADV_UNMERGEABLE will only unshare those KSM-placed zero pages.

In addition, we'll reuse this mechanism to reliably identify KSM-placed
ZeroPages to properly account for them (e.g., calculating the KSM profit
that includes zeropages) in the latter patches.

The patch will not degrade the performance of use_zero_pages as it doesn't
change the way of merging empty pages in use_zero_pages's feature.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 include/linux/ksm.h |  6 ++++++
 mm/ksm.c            | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 899a314bc487..98878107244f 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -26,6 +26,12 @@ int ksm_disable(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+/*
+ * To identify zeropages that were mapped by KSM, we reuse the dirty bit
+ * in the PTE. If the PTE is dirty, the zeropage was mapped by KSM when
+ * deduplicating memory.
+ */
+#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..f31c789406b1 100644
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
@@ -1220,8 +1221,12 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
-		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
-					       vma->vm_page_prot));
+		/*
+		 * Use pte_mkdirty to mark the zero page mapped by KSM, and then
+		 * we can easily track all KSM-placed zero pages by checking if
+		 * the dirty bit in zero page's PTE is set.
+		 */
+		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
-- 
2.15.2
