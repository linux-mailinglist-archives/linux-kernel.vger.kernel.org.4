Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D80165527E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiLWP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE078379E0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671810986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBT0ZAHzVTRfbP+Wl+fN0VxUXB1ayM6xOLWbOB1BDws=;
        b=EZW9OiqnOgSLYjlLRFt05MLGSgDAVVlwlZQDW6lTbclUy+NDwem0MV2tm2AO0QYcgRd2hi
        SRv6LY45aWYuOwxPPRHNas3dpOpNifLQZt0Q0ecandqCgwn65zLnlM+/k/bW7sx3xZMux+
        fLhZog2npCP8yybIsYNjJQoOq+Rn0Xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-A-8EU6qTONi9mcOonSs4-Q-1; Fri, 23 Dec 2022 10:56:24 -0500
X-MC-Unique: A-8EU6qTONi9mcOonSs4-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DAA3185A794;
        Fri, 23 Dec 2022 15:56:24 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE6A240C2064;
        Fri, 23 Dec 2022 15:56:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v1 2/2] mm/mprotect: drop pgprot_t parameter from change_protection()
Date:   Fri, 23 Dec 2022 16:56:16 +0100
Message-Id: <20221223155616.297723-3-david@redhat.com>
In-Reply-To: <20221223155616.297723-1-david@redhat.com>
References: <20221223155616.297723-1-david@redhat.com>
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

Being able to provide a custom protection opens the door for
inconsistencies and BUGs: for example, accidentally allowing for more
permissions than desired by other mechanisms (e.g., softdirty tracking).
vma->vm_page_prot should be the single source of truth.

Only PROT_NUMA is special: there is no way we can erroneously allow
for more permissions when removing all permissions. Special-case using
the MM_CP_PROT_NUMA flag.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  3 +--
 mm/mempolicy.c     |  3 +--
 mm/mprotect.c      | 14 +++++++++++---
 mm/userfaultfd.c   |  3 +--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e4d66d..b8be8c33ca20 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,8 +2148,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 extern unsigned long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
-			      unsigned long end, pgprot_t newprot,
-			      unsigned long cp_flags);
+			      unsigned long end, unsigned long cp_flags);
 extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..c3f02703a710 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -635,8 +635,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
-	nr_updated = change_protection(&tlb, vma, addr, end, PAGE_NONE,
-				       MM_CP_PROT_NUMA);
+	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
 	if (nr_updated)
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 908df12caa26..569cefa668a6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -503,13 +503,21 @@ static unsigned long change_protection_range(struct mmu_gather *tlb,
 
 unsigned long change_protection(struct mmu_gather *tlb,
 		       struct vm_area_struct *vma, unsigned long start,
-		       unsigned long end, pgprot_t newprot,
-		       unsigned long cp_flags)
+		       unsigned long end, unsigned long cp_flags)
 {
+	pgprot_t newprot = vma->vm_page_prot;
 	unsigned long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
+	/*
+	 * Ordinary protection updates (mprotect, uffd-wp, softdirty tracking)
+	 * are expected to reflect their requirements via VMA flags such that
+	 * vma_set_page_prot() will adjust vma->vm_page_prot accordingly.
+	 */
+	if (cp_flags & MM_CP_PROT_NUMA)
+		newprot = PAGE_NONE;
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot,
 						  cp_flags);
@@ -638,7 +646,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	vma_set_page_prot(vma);
 
-	change_protection(tlb, vma, start, end, vma->vm_page_prot, mm_cp_flags);
+	change_protection(tlb, vma, start, end, mm_cp_flags);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 351e8d6b398b..be7ee9d82e72 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -744,8 +744,7 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	if (vma_wants_manual_pte_write_upgrade(dst_vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	tlb_gather_mmu(&tlb, dst_mm);
-	change_protection(&tlb, dst_vma, start, start + len, vma->vm_page_prot,
-			  mm_cp_flags);
+	change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
 	tlb_finish_mmu(&tlb);
 }
 
-- 
2.38.1

