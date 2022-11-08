Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3777C621B10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiKHRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiKHRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8D5B840
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667929633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ7PDKfmtoPRA+bF4Km9GFm2Sx9d/OhosQnplgpAu2o=;
        b=Jekiw+h9aBb10IjC2aQDwUTBjuMJC7V7freo68Dy2LWdImpJj2vS8KrrHr+X5frlDmCljM
        B0sOEGQGiN32dNXtKZmYW2Z7i+N7xA1cht+VXJkEOE+v4WOxs/tkEg3uCkR2CYxoMzQuK4
        Hx2WtMcXhDepRFAwklYLl+i1rvppiMs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-GTbBNtcrM_6NpAte7C8S-Q-1; Tue, 08 Nov 2022 12:47:06 -0500
X-MC-Unique: GTbBNtcrM_6NpAte7C8S-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC2DA3C0F7EA;
        Tue,  8 Nov 2022 17:47:04 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0672C15BB5;
        Tue,  8 Nov 2022 17:47:01 +0000 (UTC)
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
Subject: [PATCH v2 2/7] mm/mprotect: minor can_change_pte_writable() cleanups
Date:   Tue,  8 Nov 2022 18:46:47 +0100
Message-Id: <20221108174652.198904-3-david@redhat.com>
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

We want to replicate this code for handling PMDs soon.

(1) No need to crash the kernel, warning and rejecting is good enough. As
    this will no longer get optimized out, drop the pte_write() check: no
    harm would be done.

(2) Add a comment why PROT_NONE mapped pages are excluded.

(3) Add a comment regarding MAP_SHARED handling and why we rely on the
    dirty bit in the PTE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mprotect.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 86a28c0e190f..72aabffb7871 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -44,8 +44,10 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
+	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+		return false;
 
+	/* Don't touch entries that are not even readable. */
 	if (pte_protnone(pte))
 		return false;
 
@@ -59,15 +61,22 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 
 	if (!(vma->vm_flags & VM_SHARED)) {
 		/*
-		 * We can only special-case on exclusive anonymous pages,
-		 * because we know that our write-fault handler similarly would
-		 * map them writable without any additional checks while holding
-		 * the PT lock.
+		 * Writable MAP_PRIVATE mapping: We can only special-case on
+		 * exclusive anonymous pages, because we know that our
+		 * write-fault handler similarly would map them writable without
+		 * any additional checks while holding the PT lock.
 		 */
 		page = vm_normal_page(vma, addr, pte);
 		return page && PageAnon(page) && PageAnonExclusive(page);
 	}
 
+	/*
+	 * Writable MAP_SHARED mapping: "clean" might indicate that the FS still
+	 * needs a real write-fault for writenotify
+	 * (see vma_wants_writenotify()). If "dirty", the assumption is that the
+	 * FS was already notified and we can simply mark the PTE writable
+	 * just like the write-fault handler would do.
+	 */
 	return pte_dirty(pte);
 }
 
-- 
2.38.1

