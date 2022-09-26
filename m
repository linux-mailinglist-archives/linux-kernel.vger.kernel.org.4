Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A735EACC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIZQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIZQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE371401A9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664205994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUjpPVfNq3g+nZuxz52N7YaNroA0tr6QoNT1fN2tuhM=;
        b=ciUo+1jrPTHbCv6YeQp49FlOnEzKDeFGPeMRhJX5dEBHQRg5+mA1iwjQm/4adApG17fUH5
        2sfXw1qzBxGcNpaAmFoTNOit/7QMqsH+GRRV74MtNQRgCz7zqWxNwxth3sRqiVZTP38IXD
        KM/GbDX3gRJgMT6zHR3l/Y93F5aVmos=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-2yZt-JntMraBHgXMowr4YQ-1; Mon, 26 Sep 2022 11:26:29 -0400
X-MC-Unique: 2yZt-JntMraBHgXMowr4YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FA4B3801F4C;
        Mon, 26 Sep 2022 15:26:27 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 280DEC15BA5;
        Mon, 26 Sep 2022 15:26:23 +0000 (UTC)
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
Subject: [PATCH RFC 1/5] mm/mprotect: allow clean exclusive anon pages to be writable
Date:   Mon, 26 Sep 2022 17:26:14 +0200
Message-Id: <20220926152618.194810-2-david@redhat.com>
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

From: Nadav Amit <namit@vmware.com>

Anonymous pages might have the dirty bit clear, but this should not
prevent mprotect from making them writable if they are exclusive.
Therefore, skip the test whether the page is dirty in this case.

Note that there are already other ways to get a writable PTE mapping an
anonymous page that is clean: for example, via MADV_FREE. In an ideal
world, we'd have a different indication from the FS whether writenotify
is still required.

Signed-off-by: Nadav Amit <namit@vmware.com>
[ comment for dirty/clean handling; return directly; update description ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mprotect.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ed013f836b4a..c6c13a0a4bcc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -45,7 +45,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 
 	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
 
-	if (pte_protnone(pte) || !pte_dirty(pte))
+	if (pte_protnone(pte))
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
@@ -64,11 +64,15 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 		 * the PT lock.
 		 */
 		page = vm_normal_page(vma, addr, pte);
-		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
-			return false;
+		return page && PageAnon(page) && PageAnonExclusive(page);
 	}
 
-	return true;
+	/*
+	 * Shared mapping: "clean" might indicate that the FS still has to be
+	 * notified via a write fault once first -- see vma_wants_writenotify().
+	 * If "dirty", the assumtion is that there already was a write fault.
+	 */
+	return pte_dirty(pte);
 }
 
 static unsigned long change_pte_range(struct mmu_gather *tlb,
-- 
2.37.3

