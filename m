Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923926E670E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjDROWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDROWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DFF15A1C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681827679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dpMEk+AE9gNBV5EZL8jLZUYxXkab39JHIZx9DZ7EuD4=;
        b=MTr2aCvXY6/rqW9mScszciqvgKeaHWBvqi8FBuxE1qhWFBvz+qPci9WmkfmKXs+DajUQhO
        zHEJDr+iaSsdY3wWi5KEiA3SoC7sHe5SDXxHbOwNOfEb/LcptEjPO/RlxydEpw3Pflmbtm
        iuyjDiFj9aQCI+Lu/UFHpLkTtK1rWP0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-CACWkmrXMQK8fVt49YL9tA-1; Tue, 18 Apr 2023 10:21:16 -0400
X-MC-Unique: CACWkmrXMQK8fVt49YL9tA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44AB28135B8;
        Tue, 18 Apr 2023 14:21:15 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C57A1121314;
        Tue, 18 Apr 2023 14:21:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH mm-unstable v1] mm: don't check VMA write permissions if the PTE/PMD indicates write permissions
Date:   Tue, 18 Apr 2023 16:21:13 +0200
Message-Id: <20230418142113.439494-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Staring at the comment "Recheck VMA as permissions can change since
migration started" in remove_migration_pte() can result in confusion,
because if the source PTE/PMD indicates write permissions, then there
should be no need to check VMA write permissions when restoring migration
entries or PTE-mapping a PMD.

Commit d3cb8bf6081b ("mm: migrate: Close race between migration completion
and mprotect") introduced the maybe_mkwrite() handling in
remove_migration_pte() in 2014, stating that a race between mprotect() and
migration finishing would be possible, and that we could end up with
a writable PTE that should be readable.

However, mprotect() code first updates vma->vm_flags / vma->vm_page_prot
and then walks the page tables to (a) set all present writable PTEs to
read-only and (b) convert all writable migration entries to readable
migration entries. While walking the page tables and modifying the
entries, migration code has to grab the PT locks to synchronize against
concurrent page table modifications.

Assuming migration would find a writable migration entry (while holding
the PT lock) and replace it with a writable present PTE, surely mprotect()
code didn't stumble over the writable migration entry yet (converting it
into a readable migration entry) and would instead wait for the PT lock to
convert the now present writable PTE into a read-only PTE. As mprotect()
didn't finish yet, the behavior is just like migration didn't happen: a
writable PTE will be converted to a read-only PTE.

So it's fine to rely on the writability information in the source
PTE/PMD and not recheck against the VMA as long as we're holding the PT
lock to synchronize with anyone who concurrently wants to downgrade write
permissions (like mprotect()) by first adjusting vma->vm_flags /
vma->vm_page_prot to then walk over the page tables to adjust the page
table entries.

Running test cases that should reveal such races -- mprotect(PROT_READ)
racing with page migration or THP splitting -- for multiple hours did
not reveal an issue with this cleanup.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This is a follow-up cleanup to [1]:
	[PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not
	unconditionally allow for write access

I wanted to be a bit careful and write some test cases to convince myself
that I am not missing something important. Of course, there is still the
possibility that my test cases are buggy ;)

Test cases I'm running:
	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_migration.c
	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_thp_split.c


[1] https://lkml.kernel.org/r/20230411142512.438404-1-david@redhat.com

---
 mm/huge_memory.c | 4 ++--
 mm/migrate.c     | 5 +----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c23fa39dec92..624671aaa60d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		} else {
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
-				entry = maybe_mkwrite(entry, vma);
+				entry = pte_mkwrite(entry);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
 			if (!young)
@@ -3271,7 +3271,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
-		pmde = maybe_pmd_mkwrite(pmde, vma);
+		pmde = pmd_mkwrite(pmde);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
diff --git a/mm/migrate.c b/mm/migrate.c
index 5d95e09b1618..02cace7955d4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -213,16 +213,13 @@ static bool remove_migration_pte(struct folio *folio,
 		if (pte_swp_soft_dirty(*pvmw.pte))
 			pte = pte_mksoft_dirty(pte);
 
-		/*
-		 * Recheck VMA as permissions can change since migration started
-		 */
 		entry = pte_to_swp_entry(*pvmw.pte);
 		if (!is_migration_entry_young(entry))
 			pte = pte_mkold(pte);
 		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
-			pte = maybe_mkwrite(pte, vma);
+			pte = pte_mkwrite(pte);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte = pte_mkuffd_wp(pte);
 
-- 
2.39.2

