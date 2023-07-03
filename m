Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1658745DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGCNyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGCNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:54:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B94910FA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:53:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6399A11FB;
        Mon,  3 Jul 2023 06:54:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF28C3F73F;
        Mon,  3 Jul 2023 06:53:46 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
Date:   Mon,  3 Jul 2023 14:53:28 +0100
Message-Id: <20230703135330.1865927-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703135330.1865927-1-ryan.roberts@arm.com>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_wants_pte_order() can be overridden by the arch to return the
preferred folio order for pte-mapped memory. This is useful as some
architectures (e.g. arm64) can coalesce TLB entries when the physical
memory is suitably contiguous.

The first user for this hint will be FLEXIBLE_THP, which aims to
allocate large folios for anonymous memory to reduce page faults and
other per-page operation costs.

Here we add the default implementation of the function, used when the
architecture does not define it, which returns the order corresponding
to 64K.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a661a17173fa..f7e38598f20b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/page_table_check.h>
+#include <linux/sizes.h>
 
 #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
 	defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
@@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
+#ifndef arch_wants_pte_order
+/*
+ * Returns preferred folio order for pte-mapped memory. Must be in range [0,
+ * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
+ * to be at least order-2.
+ */
+static inline int arch_wants_pte_order(struct vm_area_struct *vma)
+{
+	return ilog2(SZ_64K >> PAGE_SHIFT);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
-- 
2.25.1

