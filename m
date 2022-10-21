Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97F6074B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJUKMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJUKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905A7AB17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvbHA1NlNVduFtzvLq26bYOPMz6FpLJa39idJS7z9qQ=;
        b=D0fWQBBvQLAzhX2zjMOZNPgyUEE8F7g2aGliW+hHkYnMg5vL9pzFrRzAGm2lghQCUaoo8o
        pl9lwHe9CS/PJvjBOS8OD3hoPeSucVyz3lPMsRgNM8lVMdzU0aSLHVl7WWbf96gEd6Jtl5
        zu5Iip2VSrucIfolCPzLpdIggfG8+zo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-ViDLH6jQP72Zr-84yIPLcQ-1; Fri, 21 Oct 2022 06:12:33 -0400
X-MC-Unique: ViDLH6jQP72Zr-84yIPLcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B6183C0F242;
        Fri, 21 Oct 2022 10:12:33 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31D7B40E80E7;
        Fri, 21 Oct 2022 10:12:29 +0000 (UTC)
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
Subject: [PATCH v2 6/9] mm/pagewalk: don't trigger test_walk() in walk_page_vma()
Date:   Fri, 21 Oct 2022 12:11:38 +0200
Message-Id: <20221021101141.84170-7-david@redhat.com>
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

As Peter points out, the caller passes a single VMA and can just do that
check itself.

And in fact, no existing users rely on test_walk() getting called. So let's
just remove it and make the implementation slightly more efficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pagewalk.h | 2 ++
 mm/pagewalk.c            | 7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f3fafb731ffd..37dc0208862d 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -27,6 +27,8 @@ struct mm_walk;
  *			"do page table walk over the current vma", returning
  *			a negative value means "abort current page table walk
  *			right now" and returning 1 means "skip the current vma"
+ *			Note that this callback is not called when the caller
+ *			passes in a single VMA as for walk_page_vma().
  * @pre_vma:            if set, called before starting walk on a non-null vma.
  * @post_vma:           if set, called after a walk on a non-null vma, provided
  *                      that @pre_vma and the vma walk succeeded.
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2ff3a5bebceb..0a5d71aaf9c7 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -526,18 +526,11 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
-	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
 
 	mmap_assert_locked(walk.mm);
-
-	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
-	if (err > 0)
-		return 0;
-	if (err < 0)
-		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
-- 
2.37.3

