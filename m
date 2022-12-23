Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C465527F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiLWP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLWP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AEB379DE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671810988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDRifkePoVbkoc0g7uxXuEvxzJ2tfw2CrPnegwMaAgc=;
        b=apHoFeSYoQuK6iEhJLGdb4sDzq+DU4dPulN0UzxRQt/RvD95s/nshgduPQBnagP5nVIjvg
        FRu2BThtpQZrN/mY0pXLRvsbEF5G/KND73ebqgkFJaq676CO0tZ1XeEnOZ7+LHhMwLfILf
        HozadMjzjDpD6etXoHhHHbmgDAnrOkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-OIt8_fafOky8eoVrOlgPCQ-1; Fri, 23 Dec 2022 10:56:22 -0500
X-MC-Unique: OIt8_fafOky8eoVrOlgPCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DC5F80D0E3;
        Fri, 23 Dec 2022 15:56:22 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77C8340C2064;
        Fri, 23 Dec 2022 15:56:20 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v1 1/2] mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()
Date:   Fri, 23 Dec 2022 16:56:15 +0100
Message-Id: <20221223155616.297723-2-david@redhat.com>
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

uffd_wp_range() currently calculates page protection manually using
vm_get_page_prot(). This will ignore any other reason for active
writenotify: one mechanism applicable to shmem is softdirty tracking.

For example, the following sequence

1) Write to mapped shmem page
2) Clear softdirty
3) Register uffd-wp covering the mapped page
4) Unregister uffd-wp covering the mapped page
5) Write to page again

will not set the modified page softdirty, because uffd_wp_range() will
ignore that writenotify is required for softdirty tracking and simply map
the page writable again using change_protection(). Similarly, instead of
unregistering, protecting followed by un-protecting the page using
uffd-wp would result in the same situation.

Now that we enable writenotify whenever enabling uffd-wp on a VMA,
vma->vm_page_prot will already properly reflect our requirements: the
default is to write-protect all PTEs. However, for shared mappings we
would now not remap the PTEs writable if possible when unprotecting, just
like for private mappings (COW). To compensate, set
MM_CP_TRY_CHANGE_WRITABLE just like mprotect() does to try mapping
individual PTEs writable.

For private mappings, this change implies that we will now always try
setting PTEs writable when un-protecting, just like when upgrading write
permissions using mprotect(), which is an improvement.

For shared mappings, we will only set PTEs writable if
can_change_pte_writable()/can_change_pmd_writable() indicates that it's
ok. For ordinary shmem, this will be the case when PTEs are dirty, which
should usually be the case -- otherwise we could special-case shmem in
can_change_pte_writable()/can_change_pmd_writable() easily, because
shmem itself doesn't require writenotify.

Note that hugetlb does not yet implement MM_CP_TRY_CHANGE_WRITABLE, so we
won't try setting PTEs writable when unprotecting or when unregistering
uffd-wp. This can be added later on top by implementing
MM_CP_TRY_CHANGE_WRITABLE.

While commit ffd05793963a ("userfaultfd: wp: support write protection for
userfault vma range") introduced that code, it should only be applicable
to uffd-wp on shared mappings -- shmem (hugetlb does not support softdirty
tracking). I don't think this corner cases justifies to cc stable. Let's
just handle it correctly and prepare for change_protection() cleanups.

Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/userfaultfd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0499907b6f1a..351e8d6b398b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -727,17 +727,25 @@ ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
 void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
+	unsigned int mm_cp_flags;
 	struct mmu_gather tlb;
-	pgprot_t newprot;
 
 	if (enable_wp)
-		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
+		mm_cp_flags = MM_CP_UFFD_WP;
 	else
-		newprot = vm_get_page_prot(dst_vma->vm_flags);
+		mm_cp_flags = MM_CP_UFFD_WP_RESOLVE;
 
+	/*
+	 * vma->vm_page_prot already reflects that uffd-wp is enabled for this
+	 * VMA (see userfaultfd_set_vm_flags()) and that all PTEs are supposed
+	 * to be write-protected as default whenever protection changes.
+	 * Try upgrading write permissions manually.
+	 */
+	if (vma_wants_manual_pte_write_upgrade(dst_vma))
+		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	tlb_gather_mmu(&tlb, dst_mm);
-	change_protection(&tlb, dst_vma, start, start + len, newprot,
-			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
+	change_protection(&tlb, dst_vma, start, start + len, vma->vm_page_prot,
+			  mm_cp_flags);
 	tlb_finish_mmu(&tlb);
 }
 
-- 
2.38.1

