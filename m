Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC5F669F25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjAMRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAMRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72D41D4F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673629857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXiyu4T9E3cHd7BmjOKGfZSf96+T1UTdr6M/Zzcd1iA=;
        b=XkRuEwriGx+ie1NUgv4flZ9Q2/luLh2sa5I4RVwqe6re/quUcuWF8FYLA9qSyJr+zhKl77
        iJgpFxz4cKPvFNZqpO4OCzoDPm47CmsYDO49Zmz8zO0zDGJIL4XC7w/is3IpFBfcanQqhX
        joZJcIzp4uuzzN4y6guXbpoNbPq/b6Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-UP7pYWA7N8-Lxng6Qfiptg-1; Fri, 13 Jan 2023 12:10:53 -0500
X-MC-Unique: UP7pYWA7N8-Lxng6Qfiptg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E39ED3C0D195;
        Fri, 13 Jan 2023 17:10:51 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8457040C2064;
        Fri, 13 Jan 2023 17:10:44 +0000 (UTC)
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
        David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 01/26] mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
Date:   Fri, 13 Jan 2023 18:10:01 +0100
Message-Id: <20230113171026.582290-2-david@redhat.com>
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

We want to implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures.
Let's extend our sanity checks, especially testing that our PTE bit
does not affect:
* is_swap_pte() -> pte_present() and pte_none()
* the swap entry + type
* pte_swp_soft_dirty()

Especially, the pfn_pte() is dodgy when the swap PTE layout differs
heavily from ordinary PTEs. Let's properly construct a swap PTE from
swap type+offset.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/debug_vm_pgtable.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bb3328f46126..a0730beffd78 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -811,13 +811,34 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 {
 #ifdef __HAVE_ARCH_PTE_SWP_EXCLUSIVE
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
+	unsigned long max_swapfile_size = generic_max_swapfile_size();
+	swp_entry_t entry, entry2;
+	pte_t pte;
 
 	pr_debug("Validating PTE swap exclusive\n");
+
+	/* Create a swp entry with all possible bits set */
+	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1,
+			  max_swapfile_size - 1);
+
+	pte = swp_entry_to_pte(entry);
+	WARN_ON(pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+
 	pte = pte_swp_mkexclusive(pte);
 	WARN_ON(!pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(pte_swp_soft_dirty(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+
 	pte = pte_swp_clear_exclusive(pte);
 	WARN_ON(pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
 #endif /* __HAVE_ARCH_PTE_SWP_EXCLUSIVE */
 }
 
-- 
2.39.0

