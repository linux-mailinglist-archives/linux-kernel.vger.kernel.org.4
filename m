Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F42644723
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiLFO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiLFO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4F2E9D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSPmQx9eeeBLx89henBVTxkcK4792UdAD2dJ7TXUl6g=;
        b=iLLBBo5RS+IjHRtDaaRli4XQlP+UVUtbljbAiBl/bCtiqisLqfHvnM1fcd3PxI/L2pz6cP
        BiG8BNvxGBDVw7BAt9xo8ATjfbwFy5ht6YQaFG/bbilMCtu95TkNvYKdS16QfAbHwC1k0h
        4Xfw/ybl/4nNvLlSGKPAf4dVUxXsZDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-_YI18AWSMq2fxvTojIwrDQ-1; Tue, 06 Dec 2022 09:50:27 -0500
X-MC-Unique: _YI18AWSMq2fxvTojIwrDQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04ABC101A52A;
        Tue,  6 Dec 2022 14:50:26 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 021C4492B04;
        Tue,  6 Dec 2022 14:50:19 +0000 (UTC)
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH mm-unstable RFC 22/26] sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
Date:   Tue,  6 Dec 2022 15:47:26 +0100
Message-Id: <20221206144730.163732-23-david@redhat.com>
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
(MAX_SWAPFILES_SHIFT), so the stolen bit was effectively unused.

While at it, mask the type in __swp_entry().

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/sparc/include/asm/pgtable_64.h | 38 ++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3bc9736bddb1..614fdedbb145 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -187,6 +187,9 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_SZHUGE_4U	_PAGE_SZ4MB_4U
 #define _PAGE_SZHUGE_4V	_PAGE_SZ4MB_4V
 
+/* We borrow bit 20 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_AC(0x0000000000100000,UL)
+
 #ifndef __ASSEMBLY__
 
 pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
@@ -961,18 +964,47 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
-/* Encode and de-code a swap entry */
-#define __swp_type(entry)	(((entry).val >> PAGE_SHIFT) & 0xffUL)
+/*
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
+ *   --------------------> E <-- type ---> <------- zeroes -------->
+ */
+#define __swp_type(entry)	(((entry).val >> PAGE_SHIFT) & 0x7fUL)
 #define __swp_offset(entry)	((entry).val >> (PAGE_SHIFT + 8UL))
 #define __swp_entry(type, offset)	\
 	( (swp_entry_t) \
 	  { \
-		(((long)(type) << PAGE_SHIFT) | \
+		((((long)(type) & 0x7fUL) << PAGE_SHIFT) | \
                  ((long)(offset) << (PAGE_SHIFT + 8UL))) \
 	  } )
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_EXCLUSIVE);
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SWP_EXCLUSIVE);
+}
+
 int page_in_phys_avail(unsigned long paddr);
 
 /*
-- 
2.38.1

