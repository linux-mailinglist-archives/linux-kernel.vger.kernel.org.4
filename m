Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A82644666
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiLFOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiLFOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D512E683
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m667yVBx2IVyTiq/RwCkjJ3H3w4clpAfkhfbZM5/ykg=;
        b=ULeq8xfFTC2IrGX55V1Oic8HE67JFHDcwhkOS2O8mLIIdYp/fxU/5jPsur/zVj3sQ7DqXc
        DHslu1hf5/HeCjs+FAifYWrfrCBffA3wcSRWZN8NC7Qj+za6C/U4VcmPGI7OUZ+/y5vMvx
        On4n1FbITPF+ZIXHNvRAN1Sp1j0MIyU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-c9LqIQ1cNnSkTaaD7Ye9vg-1; Tue, 06 Dec 2022 09:48:38 -0500
X-MC-Unique: c9LqIQ1cNnSkTaaD7Ye9vg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05DA038164C0;
        Tue,  6 Dec 2022 14:48:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00479492B04;
        Tue,  6 Dec 2022 14:48:30 +0000 (UTC)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCH mm-unstable RFC 05/26] csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:09 +0100
Message-Id: <20221206144730.163732-6-david@redhat.com>
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
offset. This reduces the maximum swap space per file to 16 GiB (was 32
GiB).

We might actually be able to reuse one of the other software bits
(_PAGE_READ / PAGE_WRITE) instead, because we only have to keep
pte_present(), pte_none() and HW happy. For now, let's keep it simple
because there might be something non-obvious.

Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 13 +++++++++----
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 19 ++++++++++++-------
 arch/csky/include/asm/pgtable.h        | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index 752c8b3f9194..ae7a2f76dd42 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -10,6 +10,9 @@
 #define _PAGE_ACCESSED		(1<<3)
 #define _PAGE_MODIFIED		(1<<4)
 
+/* We borrow bit 9 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<9)
+
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<6)
 #define _PAGE_VALID		(1<<7)
@@ -26,7 +29,8 @@
 #define _PAGE_PROT_NONE		_PAGE_READ
 
 /*
- * Encode and decode a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Format of swap PTE:
  *     bit          0:    _PAGE_PRESENT (zero)
@@ -35,15 +39,16 @@
  *     bit          6:    _PAGE_GLOBAL (zero)
  *     bit          7:    _PAGE_VALID (zero)
  *     bit          8:    swap type[4]
- *     bit     9 - 31:    swap offset
+ *     bit          9:    exclusive marker
+ *     bit    10 - 31:    swap offset
  */
 #define __swp_type(x)			((((x).val >> 2) & 0xf) | \
 					(((x).val >> 4) & 0x10))
-#define __swp_offset(x)			((x).val >> 9)
+#define __swp_offset(x)			((x).val >> 10)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 					((type & 0xf) << 2) | \
 					((type & 0x10) << 4) | \
-					((offset) << 9)})
+					((offset) << 10)})
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index 7e7f389f546f..526152bd2156 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -10,6 +10,9 @@
 #define _PAGE_PRESENT		(1<<10)
 #define _PAGE_MODIFIED		(1<<11)
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<7)
+
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<0)
 #define _PAGE_VALID		(1<<1)
@@ -26,23 +29,25 @@
 #define _PAGE_PROT_NONE		_PAGE_WRITE
 
 /*
- * Encode and decode a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Format of swap PTE:
  *     bit          0:    _PAGE_GLOBAL (zero)
  *     bit          1:    _PAGE_VALID (zero)
  *     bit      2 - 6:    swap type
- *     bit      7 - 8:    swap offset[0 - 1]
+ *     bit          7:    exclusive marker
+ *     bit          8:    swap offset[0]
  *     bit          9:    _PAGE_WRITE (zero)
  *     bit         10:    _PAGE_PRESENT (zero)
- *     bit    11 - 31:    swap offset[2 - 22]
+ *     bit    11 - 31:    swap offset[1 - 21]
  */
 #define __swp_type(x)			(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)			((((x).val >> 7) & 0x3) | \
-					(((x).val >> 9) & 0x7ffffc))
+#define __swp_offset(x)			((((x).val >> 8) & 0x1) | \
+					(((x).val >> 10) & 0x3ffffe))
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 					((type & 0x1f) << 2) | \
-					((offset & 0x3) << 7) | \
-					((offset & 0x7ffffc) << 9)})
+					((offset & 0x1) << 8) | \
+					((offset & 0x3ffffe) << 10)})
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 77bc6caff2d2..574c97b9ecca 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -200,6 +200,24 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
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
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
2.38.1

