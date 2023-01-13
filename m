Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B0669FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAMRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjAMROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:14:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6928B74B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673629941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KugC5IzCnqRMc64O7OXoMEHEE6o8464VZZ+3WYeoi2w=;
        b=Q+K/HdJ4vQwiJcAA24zancsVQ+TdVn8QctYdL/55unaj2oeGIiE6TyDO7LdRDXDHtI8L/I
        Z8NX/knh4qKjuL+eSJcBIHKAfi9ffHbQno4clORHWu07GD7qm3RZR5lLSdyhe2Zse+qnqs
        8EDPXrNaNUGw5neOMJMFyZ9SfzwLlPs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-jLSXMt2pNqeaF2AAD5XPMQ-1; Fri, 13 Jan 2023 12:12:19 -0500
X-MC-Unique: jLSXMt2pNqeaF2AAD5XPMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D212380671B;
        Fri, 13 Jan 2023 17:12:17 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02EDF40C2064;
        Fri, 13 Jan 2023 17:12:10 +0000 (UTC)
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
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable v1 13/26] nios2/mm: refactor swap PTE layout
Date:   Fri, 13 Jan 2023 18:10:13 +0100
Message-Id: <20230113171026.582290-14-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2 disables swap for a good reason: it doesn't even provide
sufficient type bits as required by core MM. However, swap entries are
nowadays also used for other purposes (migration entries,
PTE markers, HWPoison, ...), and accidential use could be problematic.

Let's properly use 5 bits for the swap type and document the layout.
Bits 26--31 should get ignored by hardware completely, so they can be
used.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/nios2/include/asm/pgtable.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index ab793bc517f5..d1e5c9eb4643 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -232,19 +232,21 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 		__FILE__, __LINE__, pgd_val(e))
 
 /*
- * Encode and decode a swap entry (must be !pte_none(pte) && !pte_present(pte):
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
- * 31 30 29 28 27 26 25 24 23 22 21 20 19 18 ...  1  0
- *  0  0  0  0 type.  0  0  0  0  0  0 offset.........
+ * Format of swap PTEs:
  *
- * This gives us up to 2**2 = 4 swap files and 2**20 * 4K = 4G per swap file.
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   0 < type -> 0 0 0 0 0 0 <-------------- offset --------------->
  *
- * Note that the offset field is always non-zero, thus !pte_none(pte) is always
- * true.
+ * Note that the offset field is always non-zero if the swap type is 0, thus
+ * !pte_none() is always true.
  */
-#define __swp_type(swp)		(((swp).val >> 26) & 0x3)
+#define __swp_type(swp)		(((swp).val >> 26) & 0x1f)
 #define __swp_offset(swp)	((swp).val & 0xfffff)
-#define __swp_entry(type, off)	((swp_entry_t) { (((type) & 0x3) << 26) \
+#define __swp_entry(type, off)	((swp_entry_t) { (((type) & 0x1f) << 26) \
 						 | ((off) & 0xfffff) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-- 
2.39.0

