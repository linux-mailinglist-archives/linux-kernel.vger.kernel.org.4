Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433EF6074BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJUKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJUKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD0025B27E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBzNhruieU6ZfUTXGoryk7ArPTHcpoWfg1dNbBcF6Js=;
        b=AZtaZF+4iGNg24ymVruN1Tf/FWJtig4Rvz4nFUQgm28nObf6Z1VSqS06XgjShtIOaGDsfc
        qW7/4CZYC2dvO8HJ4u/Q9jWHQJ9IkHuDJE49CUKkdAFnykSk4Z9VYE6EaS1Z1iXEky5VIQ
        q5ceA2E7N5bUrvOBzdPlIAPZCXSNPWo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-nBZ72PQWNyWQLn-TMGl-EA-1; Fri, 21 Oct 2022 06:12:38 -0400
X-MC-Unique: nBZ72PQWNyWQLn-TMGl-EA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 230601C06EDC;
        Fri, 21 Oct 2022 10:12:38 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D93DC40E80E3;
        Fri, 21 Oct 2022 10:12:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 8/9] mm/ksm: convert break_ksm() to use walk_page_range_vma()
Date:   Fri, 21 Oct 2022 12:11:40 +0200
Message-Id: <20221021101141.84170-9-david@redhat.com>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_MIGRATION exists only for the purpose of break_ksm(), and
actually, there is not even the need to wait for the migration to
finish, we only want to know if we're dealing with a KSM page.

Using follow_page() just to identify a KSM page overcomplicates GUP
code. Let's use walk_page_range_vma() instead, because we don't actually
care about the page itself, we only need to know a single property --
no need to even grab a reference.

So, get rid of follow_page() usage such that we can get rid of
FOLL_MIGRATION now and eventually be able to get rid of follow_page() in
the future.

In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
a performance degradation of ~2% (old: ~5010 MiB/s, new: ~4900 MiB/s).
I don't think we particularly care for now.

Interestingly, the benchmark reduction is due to the single callback.
Adding a second callback (e.g., pud_entry()) reduces the benchmark by
another 100-200 MiB/s.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c6f58aa6e731..5cdb852ff132 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -39,6 +39,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -419,6 +420,39 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *pte;
+	int ret;
+
+	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+		return 0;
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (pte_present(*pte)) {
+		page = vm_normal_page(walk->vma, addr, *pte);
+	} else if (!pte_none(*pte)) {
+		swp_entry_t entry = pte_to_swp_entry(*pte);
+
+		/*
+		 * As KSM pages remain KSM pages until freed, no need to wait
+		 * here for migration to end.
+		 */
+		if (is_migration_entry(entry))
+			page = pfn_swap_entry_to_page(entry);
+	}
+	ret = page && PageKsm(page);
+	pte_unmap_unlock(pte, ptl);
+	return ret;
+}
+
+static const struct mm_walk_ops break_ksm_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+};
+
 /*
  * We use break_ksm to break COW on a ksm page by triggering unsharing,
  * such that the ksm page will get replaced by an exclusive anonymous page.
@@ -434,21 +468,16 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  */
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page;
 	vm_fault_t ret = 0;
 
 	do {
-		bool ksm_page = false;
+		int ksm_page;
 
 		cond_resched();
-		page = follow_page(vma, addr,
-				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
-		if (IS_ERR_OR_NULL(page))
-			break;
-		if (PageKsm(page))
-			ksm_page = true;
-		put_page(page);
-
+		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
+					       &break_ksm_ops, NULL);
+		if (WARN_ON_ONCE(ksm_page < 0))
+			return ksm_page;
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-- 
2.37.3

