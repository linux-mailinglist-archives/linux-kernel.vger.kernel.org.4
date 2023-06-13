Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017C72EE76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjFMV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjFMVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57D1BD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6YucMw264yJynzunMB03zc5mw1fxLam6CUcenZWneI=;
        b=atXrYasODl2oXtPLbheyd6azWyJUXfhCX6jCuYWCwWqA+Qn4LydDg+h05g5rzSmXV8z4dX
        N+aQzuY/wS3FqApB04/zl5RY7bQU8zG6hxX+VAygIqLvl5veDYqzmUJ6m/06O32af7esuW
        ojqyLioy+UgTqFwKrYDvKqHtlMXB1kQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-L0cxunivNc21UapB-J4I-Q-1; Tue, 13 Jun 2023 17:54:00 -0400
X-MC-Unique: L0cxunivNc21UapB-J4I-Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3fb2e6ca6eeso2354251cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693237; x=1689285237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6YucMw264yJynzunMB03zc5mw1fxLam6CUcenZWneI=;
        b=WNC8qqe0DZkcuAguAYOKdFggas8kHMIBAOP64vBQHaWKnJW0UqTb9T9mJ5fISW7qp7
         dM2ybkf/tC1k1/jstkvpVNJLpnmeCACWzmWSyXw1ilfC9OCFXn1VbJEiY2+DzYPugwni
         X9Cijbpw83d44ZyLsmr5OthbczeTr+EtjK0yDhwrY3EQZkMXdf4jShfe4eszJkS4DXlu
         IzBo/kFsccqyPZsOD85RIodK6WFOOyMK6B5r/fPVmpAUP9rW8wL1JOLKzQNTKU+uMaa3
         3qroVFYRuMOhQahu781Q+MzzHVG0DXLzmDRwwjFzMzm6YPQFQaUXMGpG4Squ0tuTKHky
         NEmQ==
X-Gm-Message-State: AC+VfDzlU98rLvpCaLvgRD6PxcY1aJ9Y5SBAAfDP1emFwbfaLfzHG0P+
        bzq+NeXkQfwBX9XwSUxIUNWBJfTRcc5hJotkvXhuowx0vMQJcWh9ukTGoaKW1JMkAdKADKmNTLQ
        8uIC0sT4RA0wWFnc1e35HDevFUxbCjTfjOZcskHIDFoPUTQ14P4/I93qochMiOd9mVnnkdvi0bp
        iXrjl9uw==
X-Received: by 2002:ac8:5c4e:0:b0:3f6:b556:7c97 with SMTP id j14-20020ac85c4e000000b003f6b5567c97mr18596651qtj.4.1686693237116;
        Tue, 13 Jun 2023 14:53:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47VYSlqHcJsfV8CfLHB7UhI/dxHot2PSaSbvtLl2psd47hStRHqC+I7+xcOOhhfmPV53DjgA==
X-Received: by 2002:ac8:5c4e:0:b0:3f6:b556:7c97 with SMTP id j14-20020ac85c4e000000b003f6b5567c97mr18596618qtj.4.1686693236845;
        Tue, 13 Jun 2023 14:53:56 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:53:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 3/7] mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
Date:   Tue, 13 Jun 2023 17:53:42 -0400
Message-Id: <20230613215346.1022773-4-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_page() doesn't need it, but we'll start to need it when unifying gup
for hugetlb.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 +++++---
 mm/gup.c                | 3 ++-
 mm/hugetlb.c            | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 21f942025fec..0d6f389d98de 100644
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
index aa0668505d61..8d59ae4554e7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -794,7 +794,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
 	if (is_vm_hugetlb_page(vma))
-		return hugetlb_follow_page_mask(vma, address, flags);
+		return hugetlb_follow_page_mask(vma, address, flags,
+						&ctx->page_mask);
 
 	pgd = pgd_offset(mm, address);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c261921b2cf..f037eaf9d819 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6457,7 +6457,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
 }
 
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags)
+				      unsigned long address, unsigned int flags,
+				      unsigned int *page_mask)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
@@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
 		WARN_ON_ONCE(try_grab_page(page, flags));
+		*page_mask = huge_page_mask(h);
 	}
 out:
 	spin_unlock(ptl);
-- 
2.40.1

