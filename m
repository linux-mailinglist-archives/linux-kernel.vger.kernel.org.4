Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72B6446BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiLFOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiLFOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004B2F003
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzoZqZ/9WlcO6V298YVqkPqgyDG5UMzG+Jr2DTFd0D0=;
        b=JhxtcLPL2xKLM9ZwhqOs3rh3E2Hub2ebeIhS0FxSfZiam1aC92bbqlQEmRIQLrUbKjkZcr
        lGqz4+NDDU6bRyiwsTvNgVDmTpkuAfB8HmwzsI9WbzDTm2jqIRfQvHd1RLJPYT/IIGrlXq
        GVJ/f29vMPXV8R5UdAg2oKe9Jd7aOwM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-dlVVBPaEOQe7_S9LFwWrNw-1; Tue, 06 Dec 2022 09:49:23 -0500
X-MC-Unique: dlVVBPaEOQe7_S9LFwWrNw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1A5438164D9;
        Tue,  6 Dec 2022 14:49:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2826F492B07;
        Tue,  6 Dec 2022 14:49:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        David Hildenbrand <david@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH mm-unstable RFC 12/26] mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:16 +0100
Message-Id: <20221206144730.163732-13-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE.

On 64bit, steal one bit from the type. Generic MM currently only uses 5
bits for the type (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively
unused.

On 32bit we're able to locate unused bits. As the PTE layout for 32 bit
is very confusing, document it a bit better.

While at it, mask the type in __swp_entry()/mk_swap_pte().

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/mips/include/asm/pgtable-32.h | 86 ++++++++++++++++++++++++++----
 arch/mips/include/asm/pgtable-64.h | 23 ++++++--
 arch/mips/include/asm/pgtable.h    | 36 +++++++++++++
 3 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index b40a0e69fccc..c2a3b899480c 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -191,42 +191,103 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ */
 #if defined(CONFIG_CPU_R3K_TLB)
 
-/* Swap entries must have VALID bit cleared. */
+/*
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <----------- offset ------------> < type -> V G E 0 0 0 0 0 0 P
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   _PAGE_PRESENT (P), _PAGE_VALID (V) and_PAGE_GLOBAL (G) have to remain
+ *   unused.
+ */
 #define __swp_type(x)			(((x).val >> 10) & 0x1f)
 #define __swp_offset(x)			((x).val >> 15)
-#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
+#define __swp_entry(type,offset)	((swp_entry_t) { (((type) & 0x1f) << 10) | ((offset) << 15) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1 << 7)
+
 #else
 
 #if defined(CONFIG_XPA)
 
-/* Swap entries must have VALID and GLOBAL bits cleared. */
+/*
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   0 0 0 0 0 0 E P <------------------ zeroes ------------------->
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <----------------- offset ------------------> < type -> V G 0 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   _PAGE_PRESENT (P), _PAGE_VALID (V) and_PAGE_GLOBAL (G) have to remain
+ *   unused.
+ */
 #define __swp_type(x)			(((x).val >> 4) & 0x1f)
 #define __swp_offset(x)			 ((x).val >> 9)
-#define __swp_entry(type,offset)	((swp_entry_t)  { ((type) << 4) | ((offset) << 9) })
+#define __swp_entry(type,offset)	((swp_entry_t)  { (((type) & 0x1f) << 4) | ((offset) << 9) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
 
+/*
+ * We borrow bit 57 (bit 25 in the low PTE) to store the exclusive marker in
+ * swap PTEs.
+ */
+#define _PAGE_SWP_EXCLUSIVE	(1 << 25)
+
 #elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
-/* Swap entries must have VALID and GLOBAL bits cleared. */
+/*
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   <------------------ zeroes -------------------> E P 0 0 0 0 0 0
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <------------------- offset --------------------> < type -> V G
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   _PAGE_PRESENT (P), _PAGE_VALID (V) and_PAGE_GLOBAL (G) have to remain
+ *   unused.
+ */
 #define __swp_type(x)			(((x).val >> 2) & 0x1f)
 #define __swp_offset(x)			 ((x).val >> 7)
-#define __swp_entry(type, offset)	((swp_entry_t)  { ((type) << 2) | ((offset) << 7) })
+#define __swp_entry(type, offset)	((swp_entry_t)  { (((type) & 0x1f) << 2) | ((offset) << 7) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
 
+/*
+ * We borrow bit 39 (bit 7 in the low PTE) to store the exclusive marker in swap
+ * PTEs.
+ */
+#define _PAGE_SWP_EXCLUSIVE	(1 << 7)
+
 #else
 /*
- * Constraints:
- *      _PAGE_PRESENT at bit 0
- *      _PAGE_MODIFIED at bit 4
- *      _PAGE_GLOBAL at bit 6
- *      _PAGE_VALID at bit 7
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <------------- offset --------------> < type -> 0 0 0 0 0 0 E P
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   _PAGE_PRESENT (P), _PAGE_VALID (V) and_PAGE_GLOBAL (G) have to remain
+ *   unused. The location of V and G varies.
  */
 #define __swp_type(x)			(((x).val >> 8) & 0x1f)
 #define __swp_offset(x)			 ((x).val >> 13)
@@ -234,6 +295,9 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+/* We borrow bit 1 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1 << 1)
+
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32) */
 
 #endif /* defined(CONFIG_CPU_R3K_TLB) */
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index c6310192b654..98e24e3e7f2b 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -320,16 +320,31 @@ extern void pud_init(void *addr);
 extern void pmd_init(void *addr);
 
 /*
- * Non-present pages:  high 40 bits are offset, next 8 bits type,
- * low 16 bits zero.
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   <--------------------------- offset ---------------------------
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   --------------> E <-- type ---> <---------- zeroes ----------->
+ *
+ *  E is the exclusive marker that is not stored in swap entries.
  */
 static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = (type << 16) | (offset << 24); return pte; }
+{ pte_t pte; pte_val(pte) = ((type & 0x7f) << 16) | (offset << 24); return pte; }
 
-#define __swp_type(x)		(((x).val >> 16) & 0xff)
+#define __swp_type(x)		(((x).val >> 16) & 0x7f)
 #define __swp_offset(x)		((x).val >> 24)
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+/* We borrow bit 23 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1 << 23)
+
 #endif /* _ASM_PGTABLE_64_H */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index a68c0b01d8cd..711874cee8e4 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -528,6 +528,42 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 }
 #endif
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte.pte_low & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	pte.pte_low |= _PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	pte.pte_low &= ~_PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+#else
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+#endif
 
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
-- 
2.38.1

