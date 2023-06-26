Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8B73E62B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjFZRPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjFZRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9547010D2;
        Mon, 26 Jun 2023 10:14:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1EA1474;
        Mon, 26 Jun 2023 10:15:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80DFE3F663;
        Mon, 26 Jun 2023 10:14:47 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v1 03/10] mm: Introduce try_vma_alloc_movable_folio()
Date:   Mon, 26 Jun 2023 18:14:23 +0100
Message-Id: <20230626171430.3167004-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626171430.3167004-1-ryan.roberts@arm.com>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
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

Opportunistically attempt to allocate high-order folios in highmem,
optionally zeroed. Retry with lower orders all the way to order-0, until
success. Although, of note, order-1 allocations are skipped since a
large folio must be at least order-2 to work with the THP machinery. The
user must check what they got with folio_order().

This will be used to oportunistically allocate large folios for
anonymous memory with a sensible fallback under memory pressure.

For attempts to allocate non-0 orders, we set __GFP_NORETRY to prevent
high latency due to reclaim, instead preferring to just try for a lower
order. The same approach is used by the readahead code when allocating
large folios.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 367bbbb29d91..53896d46e686 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3001,6 +3001,39 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 	return 0;
 }
 
+static inline struct folio *vma_alloc_movable_folio(struct vm_area_struct *vma,
+				unsigned long vaddr, int order, bool zeroed)
+{
+	gfp_t gfp = order > 0 ? __GFP_NORETRY | __GFP_NOWARN : 0;
+
+	if (zeroed)
+		return vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order);
+	else
+		return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp, order, vma,
+								vaddr, false);
+}
+
+/*
+ * Opportunistically attempt to allocate high-order folios, retrying with lower
+ * orders all the way to order-0, until success. order-1 allocations are skipped
+ * since a folio must be at least order-2 to work with the THP machinery. The
+ * user must check what they got with folio_order(). vaddr can be any virtual
+ * address that will be mapped by the allocated folio.
+ */
+static struct folio *try_vma_alloc_movable_folio(struct vm_area_struct *vma,
+				unsigned long vaddr, int order, bool zeroed)
+{
+	struct folio *folio;
+
+	for (; order > 1; order--) {
+		folio = vma_alloc_movable_folio(vma, vaddr, order, zeroed);
+		if (folio)
+			return folio;
+	}
+
+	return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
+}
+
 /*
  * Handle write page faults for pages that can be reused in the current vma
  *
-- 
2.25.1

