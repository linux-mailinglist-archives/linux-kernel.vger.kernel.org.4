Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E3669F30
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAMRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAMRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02988A21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673629865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U3pYo5y6zzHhtAhfPB+ppqMEJelTMM0ZMYgpBnRMmY=;
        b=R7fQpupZJTyaz/HwNgmX2XeNoJHXWI6tVrCqPHolO8dDvN6UXZ4BgF7FHzFiWiSTQtX3QP
        pfzf7wRp9AVY6/YAylMicWCK//kIOh9lwU7+N5LoJhsZY9xcdnWLevWnD3h6iz7aMQwln6
        ZwixFJxn5i6DhE19h4pFdOGikqmMmgE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-lgz3QbC4OT6mzf0WDlrJUQ-1; Fri, 13 Jan 2023 12:11:01 -0500
X-MC-Unique: lgz3QbC4OT6mzf0WDlrJUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6F651C05136;
        Fri, 13 Jan 2023 17:10:59 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5142640C2064;
        Fri, 13 Jan 2023 17:10:52 +0000 (UTC)
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
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH mm-unstable v1 02/26] alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Fri, 13 Jan 2023 18:10:02 +0100
Message-Id: <20230113171026.582290-3-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

While at it, mask the type in mk_swap_pte() as well.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/alpha/include/asm/pgtable.h | 41 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 9e45f6735d5d..970abf511b13 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -74,6 +74,9 @@ struct vm_area_struct;
 #define _PAGE_DIRTY	0x20000
 #define _PAGE_ACCESSED	0x40000
 
+/* We borrow bit 39 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	0x8000000000UL
+
 /*
  * NOTE! The "accessed" bit isn't necessarily exact:  it can be kept exactly
  * by software (use the KRE/URE/KWE/UWE bits appropriately), but I'll fake it.
@@ -301,18 +304,48 @@ extern inline void update_mmu_cache(struct vm_area_struct * vma,
 }
 
 /*
- * Non-present pages:  high 24 bits are offset, next 8 bits type,
- * low 32 bits zero.
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   <------------------- offset ------------------> E <--- type -->
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <--------------------------- zeroes -------------------------->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
+{ pte_t pte; pte_val(pte) = ((type & 0x7f) << 32) | (offset << 40); return pte; }
 
-#define __swp_type(x)		(((x).val >> 32) & 0xff)
+#define __swp_type(x)		(((x).val >> 32) & 0x7f)
 #define __swp_offset(x)		((x).val >> 40)
 #define __swp_entry(type, off)	((swp_entry_t) { pte_val(mk_swap_pte((type), (off))) })
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
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
-- 
2.39.0

