Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C3621B12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKHRsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiKHRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4845655A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667929637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDs1IzHuZwBiKepSKbrZlERPsRkua37TGdaig5O5yJI=;
        b=TaALZR1vtLa1pgmm7Eb+0kDsG7aHaN5qPjpRvK3aryYR6xWAX06JOcmyarUGFCquegBugr
        JxgM9eBKC+DJhyuL6n9vNg1oLrqjvhdACDHKeX0B40FtqpdqbVtc0MqqsCG91RCgGZHhlD
        R2CCIrPFNukW8+/Bp1nL08RBMZ3WN90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-wU7JcHhbNo6cqAi4ce8Eog-1; Tue, 08 Nov 2022 12:47:12 -0500
X-MC-Unique: wU7JcHhbNo6cqAi4ce8Eog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2F97811E67;
        Tue,  8 Nov 2022 17:47:11 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5E6CC15BB5;
        Tue,  8 Nov 2022 17:47:08 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Chinner <david@fromorbit.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v2 4/7] mm/mprotect: factor out check whether manual PTE write upgrades are required
Date:   Tue,  8 Nov 2022 18:46:49 +0100
Message-Id: <20221108174652.198904-5-david@redhat.com>
In-Reply-To: <20221108174652.198904-1-david@redhat.com>
References: <20221108174652.198904-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor the check out into vma_wants_manual_pte_write_upgrade(), to be
reused in NUMA hinting fault context soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 16 ++++++++++++++--
 mm/mprotect.c      | 17 ++++-------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 517c8cc8ccb9..4a7c10bed8bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1975,6 +1975,20 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
+int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
+{
+	/*
+	 * We want to check manually if we can change individual PTEs writable
+	 * if we can't do that automatically for all PTEs in a mapping. For
+	 * private mappings, that's always the case when we have write
+	 * permissions as we properly have to handle COW.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return vma_wants_writenotify(vma, vma->vm_page_prot);
+	return !!(vma->vm_flags & VM_WRITE);
+
+}
 extern unsigned long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
@@ -2114,8 +2128,6 @@ static inline int pte_devmap(pte_t pte)
 }
 #endif
 
-int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
-
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 72aabffb7871..fe22db2c9cdd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -558,8 +558,8 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
+	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
-	bool try_change_writable;
 	pgoff_t pgoff;
 	int error;
 
@@ -637,20 +637,11 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
-	/*
-	 * We want to check manually if we can change individual PTEs writable
-	 * if we can't do that automatically for all PTEs in a mapping. For
-	 * private mappings, that's always the case when we have write
-	 * permissions as we properly have to handle COW.
-	 */
-	if (vma->vm_flags & VM_SHARED)
-		try_change_writable = vma_wants_writenotify(vma, vma->vm_page_prot);
-	else
-		try_change_writable = !!(vma->vm_flags & VM_WRITE);
+	if (vma_wants_manual_pte_write_upgrade(vma))
+		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	vma_set_page_prot(vma);
 
-	change_protection(tlb, vma, start, end, vma->vm_page_prot,
-			  try_change_writable ? MM_CP_TRY_CHANGE_WRITABLE : 0);
+	change_protection(tlb, vma, start, end, vma->vm_page_prot, mm_cp_flags);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
-- 
2.38.1

