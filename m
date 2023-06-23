Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9473BA30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjFWOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFWOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85322681
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqyY+x2QLggisqHxk6p5/e1iQd0i792KL+XWdM1gQLA=;
        b=NYgDEUlu7/1y4OvD/pIcnpYOeQNQTjIlkpHLvKIl5eStysE7ntzvhuaHcxZE6t4n2G9CgF
        R7UMpCh1NznQaXtWeRL9jAJguT8NdhuyKEJtYhHjDIRCPcfLzFGd0IdQunk0M4JrcVjC4P
        4FunL9MOEH3DIG4yhMmlAUiHBLtIAD0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-rwDXeA9mOmG1LnIQeY9osg-1; Fri, 23 Jun 2023 10:29:44 -0400
X-MC-Unique: rwDXeA9mOmG1LnIQeY9osg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f8283a3a7aso1822091cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530584; x=1690122584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqyY+x2QLggisqHxk6p5/e1iQd0i792KL+XWdM1gQLA=;
        b=mHS1QSlwPkT4DoxpOmz4Yd2W90r1rn65J0dBpx6uD0zoW0VdnpycMYzGovMEJg4Sne
         RVfl/oUiwRyFQitSO9oztFY1igHCP7eK9dnq/P+T4HDgKAzJUI7YkR64yFxqWu5aztFv
         YXvepvwH1IbpaIaHhJOLKADyOuoRu25lKxjM0iqusgBX9kdTCPb2M3yutGcfcUBnOZge
         BZSVkBtRtjEaV1wfRsp27wi0dPTLXxABD59Dy6J/jiIszvhk89D8HkuXZqsCX9BTK6fe
         YNB3dYvYR3rLNNtjbtc2TDklMbJSxrcfYOFd4x+f9klGb+c1sK0rUw+z7myWNa9ibbM/
         zCSQ==
X-Gm-Message-State: AC+VfDyDCCWGOUQhwo2WvthaXpS0L/ZAYxBDTlwfaXIikp6BQ/MGmVw5
        jRWSyZHMtQLmvCofD7KzUF72xoLGF4fEBjob6xnPGr+7FqQTZr7mxqlLAzs/L11NNvkOwUOVxoJ
        g8RMHielV6rGdzxJO9WZxhAlh
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25208991qvp.5.1687530583984;
        Fri, 23 Jun 2023 07:29:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73mR/vS6ro7yIhMCL42Ko8gAJI2pqYLlmvye+6zRW8sb2ZlI2HrV+rMo76OgVpAmu4iXJJhg==
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25208969qvp.5.1687530583682;
        Fri, 23 Jun 2023 07:29:43 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:43 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 3/8] mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
Date:   Fri, 23 Jun 2023 10:29:31 -0400
Message-Id: <20230623142936.268456-4-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
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

follow_page() doesn't need it, but we'll start to need it when unifying gup
for hugetlb.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 +++++---
 mm/gup.c                | 3 ++-
 mm/hugetlb.c            | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index beb7c63d2871..2e2d89e79d6c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags);
+				      unsigned long address, unsigned int flags,
+				      unsigned int *page_mask);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, unsigned long *, unsigned long *,
 			 long, unsigned int, int *);
@@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
-static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags)
+static inline struct page *hugetlb_follow_page_mask(
+    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
+    unsigned int *page_mask)
 {
 	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
 }
diff --git a/mm/gup.c b/mm/gup.c
index abcd841d94b7..9fc9271cba8d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -780,7 +780,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
 	if (is_vm_hugetlb_page(vma))
-		return hugetlb_follow_page_mask(vma, address, flags);
+		return hugetlb_follow_page_mask(vma, address, flags,
+						&ctx->page_mask);
 
 	pgd = pgd_offset(mm, address);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 27367edf5c72..b4973edef9f2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6454,7 +6454,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
 }
 
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags)
+				      unsigned long address, unsigned int flags,
+				      unsigned int *page_mask)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
@@ -6502,6 +6503,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = ERR_PTR(ret);
 			goto out;
 		}
+
+		*page_mask = (1U << huge_page_order(h)) - 1;
 	}
 out:
 	spin_unlock(ptl);
-- 
2.40.1

