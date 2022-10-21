Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8D6074BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJUKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJUKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191637AB08
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jjsbfVX32kRXRzGJzqZMgspzFJroQ0YMSc5QEJ3H8s=;
        b=gcO/3AFsz3ar9p76VY8o1UnQXQvkCtMBXQ7xzXeP15/xultDfC4XSFDM4nLtf1RMQblHyL
        2o0cLOtiOaOoeUMG22b0C3Q++xpq+VyJrCk+j3Mn1jf+GoiHkRtBrawmanDYnngpCjHn9q
        16KMOHFr+gZsmlZ3adl2umOitQWPnq8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-079V-auANpW0rqJrmq2chA-1; Fri, 21 Oct 2022 06:12:36 -0400
X-MC-Unique: 079V-auANpW0rqJrmq2chA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97B9B3C0F23B;
        Fri, 21 Oct 2022 10:12:35 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A76A40E80E9;
        Fri, 21 Oct 2022 10:12:33 +0000 (UTC)
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
Subject: [PATCH v2 7/9] mm/pagewalk: add walk_page_range_vma()
Date:   Fri, 21 Oct 2022 12:11:39 +0200
Message-Id: <20221021101141.84170-8-david@redhat.com>
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

Let's add walk_page_range_vma(), which is similar to walk_page_vma(),
however, is only interested in a subset of the VMA range.

To be used in KSM code to stop using follow_page() next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pagewalk.h |  3 +++
 mm/pagewalk.c            | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 37dc0208862d..959f52e5867d 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -101,6 +101,9 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private);
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 0a5d71aaf9c7..7f1c9b274906 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -517,6 +517,26 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return walk_pgd_range(start, end, &walk);
 }
 
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= vma->vm_mm,
+		.vma		= vma,
+		.private	= private,
+	};
+
+	if (start >= end || !walk.mm)
+		return -EINVAL;
+	if (start < vma->vm_start || end > vma->vm_end)
+		return -EINVAL;
+
+	mmap_assert_locked(walk.mm);
+	return __walk_page_range(start, end, &walk);
+}
+
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private)
 {
-- 
2.37.3

