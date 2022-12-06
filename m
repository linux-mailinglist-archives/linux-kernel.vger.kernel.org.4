Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B564465F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiLFOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLFOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3362DA99
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x4aBtPIfkHf52VlSKEEJKfkOCdXsL5eD/veqXMcHbM=;
        b=cXDpDnsP+ywPCl8Vw/Q4kxzf6bOhYUmZ83mNRfnewBcqJ+zJkxq95J0i+TAgxCKuBP7abE
        mIksNA7vwhTt+TTwris4iUEGJmhNRa2HaOMEuhmSjtRdtH0A/GE6lGYi2yr+7obHo+JOgi
        zF3vW9EWlbF5scN7q0vOHdHcSB7rceY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-ewncontgNS2aEzlDZOh0HQ-1; Tue, 06 Dec 2022 09:48:32 -0500
X-MC-Unique: ewncontgNS2aEzlDZOh0HQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADB83101A528;
        Tue,  6 Dec 2022 14:48:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B421492B07;
        Tue,  6 Dec 2022 14:48:24 +0000 (UTC)
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
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH mm-unstable RFC 04/26] arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:08 +0100
Message-Id: <20221206144730.163732-5-david@redhat.com>
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
offset. This reduces the maximum swap space per file to 64 GiB (was 128
GiB).

While at it drop the PTE_TYPE_FAULT from __swp_entry_to_pte() which is
defined to be 0 and is rather confusing because we should be dealing
with "Linux PTEs" not "hardware PTEs". Also, properly mask the type in
__swp_entry().

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/include/asm/pgtable-2level.h |  3 +++
 arch/arm/include/asm/pgtable-3level.h |  3 +++
 arch/arm/include/asm/pgtable.h        | 35 +++++++++++++++++++++------
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92abd4cd8ca2..ce543cd9380c 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -126,6 +126,9 @@
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
 #define L_PTE_NONE		(_AT(pteval_t, 1) << 11)
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define L_PTE_SWP_EXCLUSIVE	L_PTE_RDONLY
+
 /*
  * These are the memory types, defined to be compatible with
  * pre-ARMv6 CPUs cacheable and bufferable bits: n/a,n/a,C,B
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index eabe72ff7381..106049791500 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -76,6 +76,9 @@
 #define L_PTE_NONE		(_AT(pteval_t, 1) << 57)	/* PROT_NONE */
 #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 58)	/* READ ONLY */
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define L_PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 7)
+
 #define L_PMD_SECT_VALID	(_AT(pmdval_t, 1) << 0)
 #define L_PMD_SECT_DIRTY	(_AT(pmdval_t, 1) << 55)
 #define L_PMD_SECT_NONE		(_AT(pmdval_t, 1) << 57)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 00954ab1a039..5e0446a9c667 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -269,27 +269,48 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 }
 
 /*
- * Encode and decode a swap entry.  Swap entries are stored in the Linux
- * page tables as follows:
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
  *
  *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *   <--------------- offset ------------------------> < type -> 0 0
+ *   <------------------- offset ------------------> E < type -> 0 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
  *
- * This gives us up to 31 swap files and 128GB per swap file.  Note that
+ * This gives us up to 31 swap files and 64GB per swap file.  Note that
  * the offset field is always non-zero.
  */
 #define __SWP_TYPE_SHIFT	2
 #define __SWP_TYPE_BITS		5
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
-#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT + 1)
 
 #define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
 #define __swp_offset(x)		((x).val >> __SWP_OFFSET_SHIFT)
-#define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+#define __swp_entry(type,offset) ((swp_entry_t) { (((type) & __SWP_TYPE_BITS) << __SWP_TYPE_SHIFT) | \
+						 ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(swp)	__pte((swp).val | PTE_TYPE_FAULT)
+#define __swp_entry_to_pte(swp)	__pte((swp).val)
+
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_isset(pte, L_PTE_SWP_EXCLUSIVE);
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_SWP_EXCLUSIVE));
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(L_PTE_SWP_EXCLUSIVE));
+}
 
 /*
  * It is an error for the kernel to have more swap files than we can
-- 
2.38.1

