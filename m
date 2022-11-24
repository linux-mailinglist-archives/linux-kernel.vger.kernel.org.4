Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA86379C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKXNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:16:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7B7FC720
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:16:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A0323A;
        Thu, 24 Nov 2022 05:17:00 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.42.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E38053F73B;
        Thu, 24 Nov 2022 05:16:51 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Rename pmd_to_page() as pmd_pgtable_page()
Date:   Thu, 24 Nov 2022 18:46:41 +0530
Message-Id: <20221124131641.1523772-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pmd_to_page(), which derives the page table page containing the pmd
address has a very misleading name. The problem being, it sounds similar to
pmd_page() which derives page embedded in a given pmd entry either for next
level page or a mapped huge page. Rename it as pmd_pgtable_page() instead.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6

 include/linux/mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..e9e387caffac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2403,7 +2403,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static struct page *pmd_to_page(pmd_t *pmd)
+static struct page *pmd_pgtable_page(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
 	return virt_to_page((void *)((unsigned long) pmd & mask));
@@ -2411,7 +2411,7 @@ static struct page *pmd_to_page(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_to_page(pmd));
+	return ptlock_ptr(pmd_pgtable_page(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2430,7 +2430,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_to_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.25.1

