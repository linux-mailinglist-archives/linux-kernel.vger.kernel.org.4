Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BA669F68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAMROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAMRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA088DF4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673629895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Tra/8OvEB/D6RZgFaJhZ/NUp8ml8r1Zefl0IpfbRbo=;
        b=R0KXRaYnRHsv70keuzy9GJHA5psuRWQYwOLvaA0+5s1cVfuEG5SL+lXFm82ckkh9BWcn47
        2PR+QLF7HmivRTI/wKl4cSJpjjhl/Qr2F1ptvUuzcwpkqyOCHUKGpp8loI2e3QJF00tOZL
        f5xWjjhdqonLe+qQbveyy1ZFnjyhsUo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-XLgqcdLfMlOTpMhM2wlwUA-1; Fri, 13 Jan 2023 12:11:29 -0500
X-MC-Unique: XLgqcdLfMlOTpMhM2wlwUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD677281DE79;
        Fri, 13 Jan 2023 17:11:27 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDA340C2064;
        Fri, 13 Jan 2023 17:11:21 +0000 (UTC)
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
        Brian Cain <bcain@quicinc.com>
Subject: [PATCH mm-unstable v1 06/26] hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Fri, 13 Jan 2023 18:10:06 +0100
Message-Id: <20230113171026.582290-7-david@redhat.com>
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
offset. This reduces the maximum swap space per file to 16 GiB (was 32
GiB).

While at it, mask the type in __swp_entry().

Cc: Brian Cain <bcain@quicinc.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/hexagon/include/asm/pgtable.h | 37 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index f7048c18b6f9..7eb008e477c8 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -61,6 +61,9 @@ extern unsigned long empty_zero_page;
  * So we'll put up with a bit of inefficiency for now...
  */
 
+/* We borrow bit 6 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<6)
+
 /*
  * Top "FOURTH" level (pgd), which for the Hexagon VM is really
  * only the second from the bottom, pgd and pud both being collapsed.
@@ -359,9 +362,12 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
 
 /*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
  * Swap/file PTE definitions.  If _PAGE_PRESENT is zero, the rest of the PTE is
  * interpreted as swap information.  The remaining free bits are interpreted as
- * swap type/offset tuple.  Rather than have the TLB fill handler test
+ * listed below.  Rather than have the TLB fill handler test
  * _PAGE_PRESENT, we're going to reserve the permissions bits and set them to
  * all zeros for swap entries, which speeds up the miss handler at the cost of
  * 3 bits of offset.  That trade-off can be revisited if necessary, but Hexagon
@@ -371,9 +377,10 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * Format of swap PTE:
  *	bit	0:	Present (zero)
  *	bits	1-5:	swap type (arch independent layer uses 5 bits max)
- *	bits	6-9:	bits 3:0 of offset
+ *	bit	6:	exclusive marker
+ *	bits	7-9:	bits 2:0 of offset
  *	bits	10-12:	effectively _PAGE_PROTNONE (all zero)
- *	bits	13-31:  bits 22:4 of swap offset
+ *	bits	13-31:  bits 21:3 of swap offset
  *
  * The split offset makes some of the following macros a little gnarly,
  * but there's plenty of precedent for this sort of thing.
@@ -383,11 +390,29 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define __swp_type(swp_pte)		(((swp_pte).val >> 1) & 0x1f)
 
 #define __swp_offset(swp_pte) \
-	((((swp_pte).val >> 6) & 0xf) | (((swp_pte).val >> 9) & 0x7ffff0))
+	((((swp_pte).val >> 7) & 0x7) | (((swp_pte).val >> 10) & 0x3ffff8))
 
 #define __swp_entry(type, offset) \
 	((swp_entry_t)	{ \
-		((type << 1) | \
-		 ((offset & 0x7ffff0) << 9) | ((offset & 0xf) << 6)) })
+		(((type & 0x1f) << 1) | \
+		 ((offset & 0x3ffff8) << 10) | ((offset & 0x7) << 7)) })
+
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
 
 #endif
-- 
2.39.0

