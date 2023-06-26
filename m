Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A073E635
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFZRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjFZRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:15:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E080D10C0;
        Mon, 26 Jun 2023 10:15:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2AB21596;
        Mon, 26 Jun 2023 10:15:49 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8DE63F663;
        Mon, 26 Jun 2023 10:15:02 -0700 (PDT)
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
Subject: [PATCH v1 08/10] mm: Kconfig hooks to determine max anon folio allocation order
Date:   Mon, 26 Jun 2023 18:14:28 +0100
Message-Id: <20230626171430.3167004-9-ryan.roberts@arm.com>
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

For variable-order anonymous folios, we need to determine the order that
we will allocate. From a SW perspective, the higher the order we
allocate, the less overhead we will have; fewer faults, fewer folios in
lists, etc. But of course there will also be more memory wastage as the
order increases.

From a HW perspective, there are memory block sizes that can be
beneficial to reducing TLB pressure. arm64, for example, has the ability
to map "contpte" sized chunks (64K for a 4K base page, 2M for 16K and
64K base pages) such that one of these chunks only uses a single TLB
entry.

So we let the architecture specify the order of the maximally beneficial
mapping unit when PTE-mapped. Furthermore, because in some cases, this
order may be quite big (and therefore potentially wasteful of memory),
allow the arch to specify 2 values; One is the max order for a mapping
that _would not_ use THP if all size and alignment constraints were met,
and the other is the max order for a mapping that _would_ use THP if all
those constraints were met.

Implement this with Kconfig by introducing some new options to allow the
architecture to declare that it supports large anonymous folios along
with these 2 preferred max order values. Then introduce a user-facing
option, LARGE_ANON_FOLIO, which defaults to disabled and can only be
enabled if the architecture has declared its support. When disabled, it
forces the max order values, LARGE_ANON_FOLIO_NOTHP_ORDER_MAX and
LARGE_ANON_FOLIO_THP_ORDER_MAX to 0, meaning only a single page is ever
allocated.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/Kconfig  | 39 +++++++++++++++++++++++++++++++++++++++
 mm/memory.c |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..f4ba48c37b75 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1208,4 +1208,43 @@ config PER_VMA_LOCK
 
 source "mm/damon/Kconfig"
 
+config ARCH_SUPPORTS_LARGE_ANON_FOLIO
+	def_bool n
+	help
+	  An arch should select this symbol if wants to allow LARGE_ANON_FOLIO
+	  to be enabled. It must also set the following integer values:
+	  - ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
+	  - ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
+
+config ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
+	int
+	help
+	  The maximum size of folio to allocate for an anonymous VMA PTE-mapping
+	  that does not have the MADV_HUGEPAGE hint set.
+
+config ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
+	int
+	help
+	  The maximum size of folio to allocate for an anonymous VMA PTE-mapping
+	  that has the MADV_HUGEPAGE hint set.
+
+config LARGE_ANON_FOLIO
+	bool "Allocate large folios for anonymous memory"
+	depends on ARCH_SUPPORTS_LARGE_ANON_FOLIO
+	default n
+	help
+	  Use large (bigger than order-0) folios to back anonymous memory where
+	  possible. This reduces the number of page faults, as well as other
+	  per-page overheads to improve performance for many workloads.
+
+config LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
+	int
+	default 0 if !LARGE_ANON_FOLIO
+	default ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
+
+config LARGE_ANON_FOLIO_THP_ORDER_MAX
+	int
+	default 0 if !LARGE_ANON_FOLIO
+	default ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
+
 endmenu
diff --git a/mm/memory.c b/mm/memory.c
index 9165ed1b9fc2..a8f7e2b28d7a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3153,6 +3153,14 @@ static struct folio *try_vma_alloc_movable_folio(struct vm_area_struct *vma,
 	return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
 }
 
+static inline int max_anon_folio_order(struct vm_area_struct *vma)
+{
+	if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
+		return CONFIG_LARGE_ANON_FOLIO_THP_ORDER_MAX;
+	else
+		return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
+}
+
 /*
  * Handle write page faults for pages that can be reused in the current vma
  *
-- 
2.25.1

