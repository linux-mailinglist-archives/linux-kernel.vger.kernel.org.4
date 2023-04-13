Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E786E068C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDMFup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:50:44 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20283449C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:50:42 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 6F655E04C3; Thu, 13 Apr 2023 05:50:41 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>
Subject: [PATCH v7 1/6] ksm: support unsharing KSM-placed zero pages
Date:   Thu, 13 Apr 2023 13:50:38 +0800
Message-Id: <20230413055038.180952-1-yang.yang29@zte.com.cn>
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

The architecture must guarantee that pte_mkdirty won't treat the pte as
writable. Otherwise, it will break KSM pages state (wrprotect) and affect
the KSM functionality. For safety, we restrict this feature only to the
tested and known-working architechtures fow now.

The patch will not degrade the performance of use_zero_pages as it doesn't
change the way of merging empty pages in use_zero_pages's feature.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/ksm.h |  9 +++++++++
 mm/Kconfig          | 24 +++++++++++++++++++++++-
 mm/ksm.c            |  5 +++--
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d5f69f18ee5a..f0cc085be42a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -95,4 +95,13 @@ static inline void folio_migrate_ksm(struct folio *newfolio, struct folio *old)
 #endif /* CONFIG_MMU */
 #endif /* !CONFIG_KSM */
 
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+/* use pte_mkdirty to track a KSM-placed zero page */
+#define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
+#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
+#else /* !CONFIG_KSM_ZERO_PAGES_TRACK */
+#define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
+#define is_ksm_zero_pte(pte)	0
+#endif /* CONFIG_KSM_ZERO_PAGES_TRACK */
+
 #endif /* __LINUX_KSM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 3894a6309c41..42f69f421a03 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -666,7 +666,7 @@ config MMU_NOTIFIER
 	bool
 	select INTERVAL_TREE
 
-config KSM
+menuconfig KSM
 	bool "Enable KSM for page merging"
 	depends on MMU
 	select XXHASH
@@ -681,6 +681,28 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+if KSM
+
+config KSM_ZERO_PAGES_TRACK
+	bool "support tracking KSM-placed zero pages"
+	depends on KSM
+	depends on ARM || ARM64 || X86
+	default y
+	help
+		This allows KSM to track KSM-placed zero pages, including supporting
+		unsharing and counting the KSM-placed zero pages. if say N, then
+		madvise(,,UNMERGEABLE) can't unshare the KSM-placed zero pages, and
+		users can't know how many zero pages are placed by KSM. This feature
+		depends on pte_mkdirty (related with architecture) to mark KSM-placed
+		zero pages.
+
+		The architecture must guarantee that pte_mkdirty won't treat the pte
+		as writable. Otherwise, it will break KSM pages state (wrprotect) and
+		affect the KSM functionality. For safety, we restrict this feature only
+		to the tested and known-working architechtures.
+
+endif # KSM
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
diff --git a/mm/ksm.c b/mm/ksm.c
index 7cd7e12cd3df..1d1771a6b3fe 100644
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
@@ -1240,7 +1241,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
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
