Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86905F7278
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiJGBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiJGBIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:08:14 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CB1142C6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:08:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665104886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/dwFpFC4Jl+/5BYR7ViqxOjBJv16jZNstVV68ys3pg=;
        b=Mk1jxetoSVdDcTMBJ+PpG/gYV8cJJ5FKramb9A0H/MOXpcFwujJA38pFUPIx7+W8FMNs5t
        xFc1DudXkj3cvQ4u/8VfRbEDN8hzq5zZRLPee1NO3p3pGqKXF6YBP5S9WWtLO3rAAmOxe8
        aB1N3iWXUDadxu7+LkkxExq/FJ8rgLk=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
Date:   Fri,  7 Oct 2022 10:07:04 +0900
Message-Id: <20221007010706.2916472-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

These interfaces will be used by drivers/base/memory.c by later patch, so as a
preparatory work move them to more common header file visible to the file.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
ChangeLog v3 -> v6:
- remove static in definition of num_poisoned_pages_inc() to fix build error.

ChangeLog v2 -> v3:
- added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
---
 arch/parisc/kernel/pdt.c |  3 +--
 include/linux/mm.h       |  5 +++++
 include/linux/swapops.h  | 24 ++----------------------
 mm/memory-failure.c      | 10 ++++++++++
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index e391b175f5ec..fdc880e2575a 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -18,8 +18,7 @@
 #include <linux/kthread.h>
 #include <linux/initrd.h>
 #include <linux/pgtable.h>
-#include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/mm.h>
 
 #include <asm/pdc.h>
 #include <asm/pdcpat.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3264bf993ad8..782ab29bb1fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3279,12 +3279,17 @@ extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
+extern void num_poisoned_pages_inc(void);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared)
 {
 	return 0;
 }
+
+static inline void num_poisoned_pages_inc(void)
+{
+}
 #endif
 
 #ifndef arch_memory_failure
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a91dd08e107b..3e58a812399a 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -581,8 +581,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 
 #ifdef CONFIG_MEMORY_FAILURE
 
-extern atomic_long_t num_poisoned_pages __read_mostly;
-
 /*
  * Support for hardware poisoned pages
  */
@@ -610,17 +608,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 	return p;
 }
 
-static inline void num_poisoned_pages_inc(void)
-{
-	atomic_long_inc(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-	atomic_long_sub(i, &num_poisoned_pages);
-}
-
-#else  /* CONFIG_MEMORY_FAILURE */
+#else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
 {
@@ -636,15 +624,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 {
 	return NULL;
 }
-
-static inline void num_poisoned_pages_inc(void)
-{
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-}
-#endif  /* CONFIG_MEMORY_FAILURE */
+#endif
 
 static inline int non_swap_entry(swp_entry_t entry)
 {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d4fef56c0438..323e0a21833f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,6 +74,16 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
+inline void num_poisoned_pages_inc(void)
+{
+	atomic_long_inc(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
 /*
  * Return values:
  *   1:   the page is dissolved (if needed) and taken off from buddy,
-- 
2.25.1

