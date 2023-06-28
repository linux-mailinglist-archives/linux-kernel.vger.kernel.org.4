Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA3741B34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF1VyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjF1VyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C62210E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8FL5BW3box1F48wj3b8rnHOt4NGgVkomS4C4Z085kw=;
        b=ic2L1rOpJ0/6YWQyVinnSV+wo4gaMSAydTYHE4XfVtt0UfnxJEfMyvkTsq0flqMxvHHk6R
        iC4lQAKDvClQj7YsyioEOcXpwcn4q13Og/q6pjNHhlDyHh6ivzPNwQNtP3KEFfECpyHsCh
        tgZ4CXkR+emPaYQdk7tc8UV0Fg3fX30=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-XGuUAjBEOgOhU_ifJYkfFw-1; Wed, 28 Jun 2023 17:53:14 -0400
X-MC-Unique: XGuUAjBEOgOhU_ifJYkfFw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635f8ae5f88so39216d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989194; x=1690581194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8FL5BW3box1F48wj3b8rnHOt4NGgVkomS4C4Z085kw=;
        b=aEv07ZggtSsJ5Lgec8AApn2cWsSXopBZ8N9XCAGr6UgIdsr4l0lc0hN6cyiVp1Y8Gx
         u79mdSSIFXN9Dl+hGK3DwC/Y6JcWsl50PuxCtb7pKYnY0ZBeWhpiMhMc9MfIq/0TBcjV
         uUdaWj9WOcHGF/HgpSpMuKn/S8m+mdDGw5Q7yHoedROgi7cQs2vDxmI/FyKcO6vM+91h
         B2JrCKujx7X70lIeP0L0t6kXIaQxzr+yxW3SqOfXJw1uaga5uERQ23pnvkLTst33dZpN
         FqKuresk64z02rT3hZET57Z6ouEeHsqydAt1S7XulTW0coDj1brEbTWmG11eRWWIbqpM
         bKOw==
X-Gm-Message-State: AC+VfDwJK+BG+EJ9Njfoy3VqwBtZttpDjKH1Rito48ikzMM8WhclqsbN
        aNO23qYmqAwlsFY9qVQ7uPqqGlKywAJ5Hlpvxkrktd6yWYNL/GFWmKFzlke4CuniE+OsNI74wBc
        T55TS2KlZamMZWsW/ODqhKwqG
X-Received: by 2002:a05:6214:401a:b0:62d:fdc4:1e8b with SMTP id kd26-20020a056214401a00b0062dfdc41e8bmr42375749qvb.2.1687989194251;
        Wed, 28 Jun 2023 14:53:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MC34MgzekDp0X74lVrIdzH9S5zruaiTrJfdeBf4bPnhG07fp5o87gyAcA985czOX/TxVoqw==
X-Received: by 2002:a05:6214:401a:b0:62d:fdc4:1e8b with SMTP id kd26-20020a056214401a00b0062dfdc41e8bmr42375738qvb.2.1687989194020;
        Wed, 28 Jun 2023 14:53:14 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:13 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 1/8] mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
Date:   Wed, 28 Jun 2023 17:53:03 -0400
Message-ID: <20230628215310.73782-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the no_page_table() is meaningless for hugetlb which is a no-op
there, because a hugetlb page always satisfies:

  - vma_is_anonymous() == false
  - vma->vm_ops->fault != NULL

So we can already safely remove it in hugetlb_follow_page_mask(), alongside
with the page* variable.

Meanwhile, what we do in follow_hugetlb_page() actually makes sense for a
dump: we try to fault in the page only if the page cache is already
allocated.  Let's do the same here for follow_page_mask() on hugetlb.

It should so far has zero effect on real dumps, because that still goes
into follow_hugetlb_page().  But this may start to influence a bit on
follow_page() users who mimics a "dump page" scenario, but hopefully in a
good way.  This also paves way for unifying the hugetlb gup-slow.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 9 ++-------
 mm/hugetlb.c | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a8336b39d6b5..06bc2e31f209 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -767,7 +767,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      struct follow_page_context *ctx)
 {
 	pgd_t *pgd;
-	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
 	ctx->page_mask = 0;
@@ -780,12 +779,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * hugetlb_follow_page_mask is only for follow_page() handling here.
 	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
-	if (is_vm_hugetlb_page(vma)) {
-		page = hugetlb_follow_page_mask(vma, address, flags);
-		if (!page)
-			page = no_page_table(vma, flags);
-		return page;
-	}
+	if (is_vm_hugetlb_page(vma))
+		return hugetlb_follow_page_mask(vma, address, flags);
 
 	pgd = pgd_offset(mm, address);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..d04ba5782fdd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6498,6 +6498,15 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out_unlock:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * Fixup retval for dump requests: if pagecache doesn't exist,
+	 * don't try to allocate a new page but just skip it.
+	 */
+	if (!page && (flags & FOLL_DUMP) &&
+	    !hugetlbfs_pagecache_present(h, vma, address))
+		page = ERR_PTR(-EFAULT);
+
 	return page;
 }
 
-- 
2.41.0

