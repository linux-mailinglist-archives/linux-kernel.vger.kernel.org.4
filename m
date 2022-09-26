Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E345EACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIZQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIZQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E113FB6B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664205996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzTxRsO9Y8SBM3+5dXXY7X+zNQ7CrC7lsh1iB+qx+p0=;
        b=QJSAKadtMo1r7OA2hRyzMJfL1+tZnezdQUZurZ3KN713/9WSyUlIeGVav6TeK1QK1rkSGB
        7qrotmVdgMlN+CBXF+C+KU4vj5ho7YQrr05GFjuIUJOu+TpejdV9wvYAWfKVhNgzQLBM/w
        lsasitq8CX800F7kaEwqvnVklAPtXEk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-ozXPzZguOvCPaIuPr2SQTA-1; Mon, 26 Sep 2022 11:26:31 -0400
X-MC-Unique: ozXPzZguOvCPaIuPr2SQTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 801D63C6EAA2;
        Mon, 26 Sep 2022 15:26:30 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9948BC15BA5;
        Mon, 26 Sep 2022 15:26:27 +0000 (UTC)
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
Subject: [PATCH RFC 2/5] mm/mprotect: minor can_change_pte_writable() cleanups
Date:   Mon, 26 Sep 2022 17:26:15 +0200
Message-Id: <20220926152618.194810-3-david@redhat.com>
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

We want to replicate this code for handling PMDs soon. No need to crash
the kernel, warning and rejecting is good enough. As this will no longer
get optimized out, drop the pte_write() check: no harm would be done.

While at it, add a comment why PROT_NONE mapped pages are excluded.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mprotect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index c6c13a0a4bcc..95323bc9a951 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -43,8 +43,10 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
+	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+		return false;
 
+	/* Don't touch entries that are not even readable (NUMA hinting). */
 	if (pte_protnone(pte))
 		return false;
 
-- 
2.37.3

