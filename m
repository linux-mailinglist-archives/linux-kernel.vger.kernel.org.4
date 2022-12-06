Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB1644732
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiLFO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLFO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A72E6B8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oemSN5709o710nny94f6FdE/uVDgJe9zCTcbeegiuBo=;
        b=ZrEwybTSOqlKK1EPzvPjM0H7TR/9dtVwoTk7aU42NajmMeX67mJUakz/gjxJ+CA3y67jet
        gvOfXhL15hCPjsqT5KdNuHiIdtgesPDnO93oWQ3JAEF6K+9C/UfyNstJoarFwKUHmFiGzQ
        8y86WLbLWnBhCWlHiep3rJoNQgpm43U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-n60e4LteMkGrDP1ZV_AJpg-1; Tue, 06 Dec 2022 09:50:48 -0500
X-MC-Unique: n60e4LteMkGrDP1ZV_AJpg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE19D833A0E;
        Tue,  6 Dec 2022 14:50:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96845492B04;
        Tue,  6 Dec 2022 14:50:40 +0000 (UTC)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH mm-unstable RFC 25/26] xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue,  6 Dec 2022 15:47:29 +0100
Message-Id: <20221206144730.163732-26-david@redhat.com>
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by using bit 1. This
bit should be safe to use for our usecase.

Most importantly, we can still distinguish swap PTEs from PAGE_NONE PTEs
(see pte_present()) and don't use one of the two reserved attribute
masks (1101 and 1111). Attribute mask 1100 and 1110 now identify swap PTEs.

While at it, remove SWP_TYPE_BITS (not really helpful as it's not used in
the actual swap macros) and mask the type in __swp_entry().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/xtensa/include/asm/pgtable.h | 32 ++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 5b5484d707b2..1025e2dc292b 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -96,7 +96,7 @@
  *		+- - - - - - - - - - - - - - - - - - - - -+
  *   (PAGE_NONE)|    PPN    | 0 | 00 | ADW | 01 | 11 | 11 |
  *		+-----------------------------------------+
- *   swap	|     index     |   type   | 01 | 11 | 00 |
+ *   swap	|     index     |   type   | 01 | 11 | e0 |
  *		+-----------------------------------------+
  *
  * For T1050 hardware and earlier the layout differs for present and (PAGE_NONE)
@@ -112,6 +112,7 @@
  *   RI         ring (0=privileged, 1=user, 2 and 3 are unused)
  *   CA		cache attribute: 00 bypass, 01 writeback, 10 writethrough
  *		(11 is invalid and used to mark pages that are not present)
+ *   e		exclusive marker in swap PTEs
  *   w		page is writable (hw)
  *   x		page is executable (hw)
  *   index      swap offset / PAGE_SIZE (bit 11-31: 21 bits -> 8 GB)
@@ -158,6 +159,9 @@
 #define _PAGE_DIRTY		(1<<7)	/* software: page dirty */
 #define _PAGE_ACCESSED		(1<<8)	/* software: page accessed (read) */
 
+/* We borrow bit 1 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<1)
+
 #ifdef CONFIG_MMU
 
 #define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -343,19 +347,37 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 }
 
 /*
- * Encode and decode a swap and file entry.
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  */
-#define SWP_TYPE_BITS		5
-#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
 
 #define __swp_type(entry)	(((entry).val >> 6) & 0x1f)
 #define __swp_offset(entry)	((entry).val >> 11)
 #define __swp_entry(type,offs)	\
-	((swp_entry_t){((type) << 6) | ((offs) << 11) | \
+	((swp_entry_t){(((type) & 0x1f) << 6) | ((offs) << 11) | \
 	 _PAGE_CA_INVALID | _PAGE_USER})
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
 #endif /*  !defined (__ASSEMBLY__) */
 
 
-- 
2.38.1

