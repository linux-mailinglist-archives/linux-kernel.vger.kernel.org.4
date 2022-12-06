Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934B6446AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLFOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiLFOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BFA2EF73
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2jZN/xJpz6RKVgFkhrUzW1Vn67arYwcc9p436cZp8A=;
        b=Il94e6U0H10RrBl3nqbYS8jerifi0LfI0+7zR5hZ4gEjPwVCTN82alAP9g4VipvDRouDU1
        c33zczVOjGSJkDKw/acKad/SJMpy3qUQXgs9YO9jnzUY1DAZAZMWgyrKqUPfkpND9UiF1v
        KptzlAvmMWnRzvxorrxccGfR8E/3XPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-QRZQ13KsOnC84HyEtphmXg-1; Tue, 06 Dec 2022 09:49:17 -0500
X-MC-Unique: QRZQ13KsOnC84HyEtphmXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC1E1833A09;
        Tue,  6 Dec 2022 14:49:15 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC7F4492B07;
        Tue,  6 Dec 2022 14:49:08 +0000 (UTC)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH mm-unstable RFC 11/26] microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:15 +0100
Message-Id: <20221206144730.163732-12-david@redhat.com>
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
from the type. Generic MM currently only uses 5 bits for the type
(MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.

The shift by 2 when converting between PTE and arch-specific swap entry
makes the swap PTE layout a little bit harder to decipher.

While at it, drop the comment from paulus---copy-and-paste leftover
from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
__swp_entry_to_pte() as well.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/include/asm/mcf_pgtable.h   |  4 +--
 arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 3f8f4d0e66dd..e573d7b649f7 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -46,8 +46,8 @@
 #define _CACHEMASK040		(~0x060)
 #define _PAGE_GLOBAL040		0x400   /* 68040 global bit, used for kva descs */
 
-/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
-#define _PAGE_SWP_EXCLUSIVE	0x080
+/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	CF_PAGE_NOCACHE
 
 /*
  * Externally used page protection values.
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 42f5988e998b..7e3de54bf426 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
  * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
  * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
  * zone.
- * - PRESENT *must* be in the bottom two bits because swap cache
- * entries use the top 30 bits.  Because 4xx doesn't support SMP
- * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
- * is cleared in the TLB miss handler before the TLB entry is loaded.
+ * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
+ * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
+ * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
+ * before the TLB entry is loaded.
  * - All other bits of the PTE are loaded into TLBLO without
  *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
  * software PTE bits.  We actually use bits 21, 24, 25, and
@@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
 #define _PMD_PRESENT	PAGE_MASK
 
+/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_DIRTY
+
 /*
  * Some bits are unused...
  */
@@ -393,18 +396,40 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 /*
- * Encode and decode a swap entry.
- * Note that the bits we use in a PTE for representing a swap entry
- * must not include the _PAGE_PRESENT bit, or the _PAGE_HASHPTE bit
- * (if used).  -- paulus
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
+ *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *   <------------------ offset -------------------> E < type -> 0 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
  */
-#define __swp_type(entry)		((entry).val & 0x3f)
+#define __swp_type(entry)	((entry).val & 0x1f)
 #define __swp_offset(entry)	((entry).val >> 6)
 #define __swp_entry(type, offset) \
-		((swp_entry_t) { (type) | ((offset) << 6) })
+		((swp_entry_t) { ((type) & 0x1f) | ((offset) << 6) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) >> 2 })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val << 2 })
 
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
 extern unsigned long iopa(unsigned long addr);
 
 /* Values for nocacheflag and cmode */
-- 
2.38.1

