Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D61644696
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiLFOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiLFOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FA2EF37
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S55iuEpc5qfmZI4kjI1L5Xd1aSq5tK8vVuUg2fWhjB8=;
        b=Jg5Tt39qsMkwpPfzVMcnZhgyAcguFyiV2f3xvSQHH/qRunyRV81hdPNYARhXNCNCRxgq8n
        h71TuRyGqU7j/8lgJmKvl9VWkfDtO5KiQKwlyHmI5uydqaOHO+PrxiX8dNnMJfMdWgxkSt
        FXUwY0CfV0ImCWxKGuQDyZwgrWfBAL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-XPdnQXyyME2wCbAHNgP7hg-1; Tue, 06 Dec 2022 09:49:10 -0500
X-MC-Unique: XPdnQXyyME2wCbAHNgP7hg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90E00800159;
        Tue,  6 Dec 2022 14:49:08 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE0B492B0D;
        Tue,  6 Dec 2022 14:49:02 +0000 (UTC)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH mm-unstable RFC 10/26] m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:14 +0100
Message-Id: <20221206144730.163732-11-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
from the type. Generic MM currently only uses 5 bits for the type
(MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.

While at it, make sure for sun3 that the valid bit never gets set by
properly masking it off and mask the type in __swp_entry().

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/include/asm/mcf_pgtable.h      | 36 ++++++++++++++++++++--
 arch/m68k/include/asm/motorola_pgtable.h | 38 +++++++++++++++++++++--
 arch/m68k/include/asm/sun3_pgtable.h     | 39 ++++++++++++++++++++++--
 3 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index b619b22823f8..3f8f4d0e66dd 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -46,6 +46,9 @@
 #define _CACHEMASK040		(~0x060)
 #define _PAGE_GLOBAL040		0x400   /* 68040 global bit, used for kva descs */
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	0x080
+
 /*
  * Externally used page protection values.
  */
@@ -254,15 +257,42 @@ static inline pte_t pte_mkcache(pte_t pte)
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 
 /*
- * Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e))
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <------------------ offset -------------> 0 0 0 E <-- type --->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
  */
-#define __swp_type(x)		((x).val & 0xFF)
+#define __swp_type(x)		((x).val & 0x7f)
 #define __swp_offset(x)		((x).val >> 11)
-#define __swp_entry(typ, off)	((swp_entry_t) { (typ) | \
+#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) & 0x7f) | \
 					(off << 11) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	(__pte((x).val))
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
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
+
 #define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 7ac3d64c6b33..02896027c781 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -41,6 +41,9 @@
 
 #define _PAGE_PROTNONE	0x004
 
+/* We borrow bit 11 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	0x800
+
 #ifndef __ASSEMBLY__
 
 /* This is the cache mode to be used for pages containing page descriptors for
@@ -169,12 +172,41 @@ static inline pte_t pte_mkcache(pte_t pte)
 #define swapper_pg_dir kernel_pg_dir
 extern pgd_t kernel_pg_dir[128];
 
-/* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
-#define __swp_type(x)		(((x).val >> 4) & 0xff)
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <----------------- offset ------------> E <-- type ---> 0 0 0 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ */
+#define __swp_type(x)		(((x).val >> 4) & 0x7f)
 #define __swp_offset(x)		((x).val >> 12)
-#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 4) | ((offset) << 12) })
+#define __swp_entry(type, offset) ((swp_entry_t) { (((type) & 0x7f) << 4) | ((offset) << 12) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
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
+
 #endif	/* !__ASSEMBLY__ */
 #endif /* _MOTOROLA_PGTABLE_H */
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 90d57e537eb1..5e03ce4fd8d5 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -71,6 +71,9 @@
 #define SUN3_PMD_MASK	(0x0000003F)
 #define SUN3_PMD_MAGIC	(0x0000002B)
 
+/* We borrow bit 6 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	0x040
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -152,12 +155,42 @@ static inline pte_t pte_mkcache(pte_t pte)	{ return pte; }
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 
-/* Macros to (de)construct the fake PTEs representing swap pages. */
-#define __swp_type(x)		((x).val & 0x7F)
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   0 <--------------------- offset ----------------> E <- type -->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ */
+#define __swp_type(x)		((x).val & 0x3f)
 #define __swp_offset(x)		(((x).val) >> 7)
-#define __swp_entry(type,offset) ((swp_entry_t) { ((type) | ((offset) << 7)) })
+#define __swp_entry(type,offset) ((swp_entry_t) { (((type) & 0x3f) | \
+						  (((offset) << 7) & ~SUN3_PAGE_VALID)) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
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
+
 #endif	/* !__ASSEMBLY__ */
 #endif	/* !_SUN3_PGTABLE_H */
-- 
2.38.1

