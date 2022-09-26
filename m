Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF45EACBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIZQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIZQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83E1401BE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664205998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YyRwSI1z5dG5hj7puSlPlO6pRoISyaZbKGm8oIcb0c=;
        b=i4IZt4eRt88Z/m+XFe+fMBbHrHO3XmKbDNnVbZGQbgxP5Io7PNqdXp9wjFwRqgN4s5t3En
        F2VTNy0bv38GFMqHKlCQ7hmGKx1/ehdqN6roFTirQmCv4zKBvCIJH9zfUotIF0N2JqzqAI
        S19k5F5veHeOHtl0fePVwqaDrUjDFxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-2HhKoOwIMyWZPiLWmVBnZw-1; Mon, 26 Sep 2022 11:26:34 -0400
X-MC-Unique: 2HhKoOwIMyWZPiLWmVBnZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 911CE858F13;
        Mon, 26 Sep 2022 15:26:33 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2097C15BA5;
        Mon, 26 Sep 2022 15:26:30 +0000 (UTC)
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
Subject: [PATCH RFC 3/5] mm/huge_memory: try avoiding write faults when changing PMD protection
Date:   Mon, 26 Sep 2022 17:26:16 +0200
Message-Id: <20220926152618.194810-4-david@redhat.com>
In-Reply-To: <20220926152618.194810-1-david@redhat.com>
References: <20220926152618.194810-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's replicate what we have for PTEs in can_change_pte_writable() also
for PMDs.

While this might look like a pure performance improvement, we'll us this to
get rid of savedwrite handling in do_huge_pmd_numa_page() next. Place
do_huge_pmd_numa_page() stategicly good for that purpose.

Note that MM_CP_TRY_CHANGE_WRITABLE is currently only set when we come
via mprotect_fixup().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f18896c8f9a..e5ce3e11d4ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1386,6 +1386,36 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	return VM_FAULT_FALLBACK;
 }
 
+static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
+					   unsigned long addr, pmd_t pmd)
+{
+	struct page *page;
+
+	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+		return false;
+
+	/* Don't touch entries that are not even readable (NUMA hinting). */
+	if (pmd_protnone(pmd))
+		return false;
+
+	/* Do we need write faults for softdirty tracking? */
+	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+		return false;
+
+	/* Do we need write faults for uffd-wp tracking? */
+	if (userfaultfd_huge_pmd_wp(vma, pmd))
+		return false;
+
+	if (!(vma->vm_flags & VM_SHARED)) {
+		/* See can_change_pte_writable(). */
+		page = vm_normal_page_pmd(vma, addr, pmd);
+		return page && PageAnon(page) && !PageAnonExclusive(page);
+	}
+
+	/* See can_change_pte_writable(). */
+	return pmd_dirty(pmd);
+}
+
 /* FOLL_FORCE can write to even unwritable PMDs in COW mappings. */
 static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 					struct vm_area_struct *vma,
@@ -1889,13 +1919,17 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 */
 		entry = pmd_clear_uffd_wp(entry);
 	}
+
+	/* See change_pte_range(). */
+	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
+	    can_change_pmd_writable(vma, addr, entry))
+		entry = pmd_mkwrite(entry);
+
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 
 	if (huge_pmd_needs_flush(oldpmd, entry))
 		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
-
-	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
 	spin_unlock(ptl);
 	return ret;
-- 
2.37.3

