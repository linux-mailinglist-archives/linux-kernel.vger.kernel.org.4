Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0372EE74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFMV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjFMVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8651BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0Si/SHg9D7WH2a+07u6wT7XlhbAs86SLIvfSHyM0qs=;
        b=Q+yqSOV/aOY7Sh0HTAof0g4Dq66dDfhZ2HEBLLoxBL37r3htqeL1BsxK5jCEIPGI22IRm6
        Kkwa0UjbOVwfYra6oAvx2ZNkb+4T5ajn29pitmBhr1fBQhOVVrmWYsprv/55gMca3nR/UT
        xmzZ3AEZThijUO8Id74qRYTlJikR02o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-IykalVUaMxOB3S1dbCrppA-1; Tue, 13 Jun 2023 17:53:56 -0400
X-MC-Unique: IykalVUaMxOB3S1dbCrppA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f86a3ce946so13356701cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693234; x=1689285234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0Si/SHg9D7WH2a+07u6wT7XlhbAs86SLIvfSHyM0qs=;
        b=FgriEwdbUn4IhSel/Uo2tynK9r7/EHvkCyk8DnX/M/638+guuuOQFlycGiMESIR5e/
         WNFcucWcvabdUSXLeKjYNnKas/24XpmOHKqQDRUxZHxCyrqUXQzEZymJFpQeABIIZ9Z3
         Lm64oAuyScP7p53mPyLzM7yCY2Z93BmqxgLtODTa0DyHkLs/svzu6KVXwijr5izBx5hk
         hGYhOLyfwO5Uw2CWwTyAdvRQFXN+oamjsar+OACWiNC7Sr4rJ1z9fePDLmGgfc0FU9pl
         ZradThL1PpXbm3FBqMcDVKTo/46vlYb2S8IZLJokBCNkOvdFl1VadUHjAi6AgFCVWYN4
         R26w==
X-Gm-Message-State: AC+VfDzVfdbFq58DPGSzODxdv1Mh1vy5hyDTFrtME6SDn9KMKn25wLhJ
        ZdU5dKaireBKyz85Xn0wJvXzP3kDdfEBB2YjMEY/QIoybGMLx9dxXIyzZ/65bRNCxXgeO4tPoCu
        ZpENv2Xy19AZuCr3Sd4+6J/+Qv39KiUi8BZmp/Pynv9tOdH12ambh5VZmr2BSdf90w2ufGz7etP
        k/AoV2cQ==
X-Received: by 2002:a05:622a:1981:b0:3f5:315f:5c1d with SMTP id u1-20020a05622a198100b003f5315f5c1dmr16598129qtc.4.1686693234514;
        Tue, 13 Jun 2023 14:53:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tfbjVj7iW6/DtRd/s2e+Ti93d6WI6EV2BJqT02+lq+41oEnqcND6tzmbEH3x8gd+k6nduCQ==
X-Received: by 2002:a05:622a:1981:b0:3f5:315f:5c1d with SMTP id u1-20020a05622a198100b003f5315f5c1dmr16598098qtc.4.1686693234224;
        Tue, 13 Jun 2023 14:53:54 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:53:53 -0700 (PDT)
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
Subject: [PATCH 2/7] mm/hugetlb: Fix hugetlb_follow_page_mask() on permission checks
Date:   Tue, 13 Jun 2023 17:53:41 -0400
Message-Id: <20230613215346.1022773-3-peterx@redhat.com>
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

It seems hugetlb_follow_page_mask() was missing permission checks.  For
example, one follow_page() can get the hugetlb page with FOLL_WRITE even if
the page is read-only.

And it wasn't there even in the old follow_page_mask(), where we can
reference from before commit 57a196a58421 ("hugetlb: simplify hugetlb
handling in follow_page_mask").

Let's add them, namely, either the need to CoW due to missing write bit, or
proper CoR on !AnonExclusive pages over R/O pins to reject the follow page.
That brings this function closer to follow_hugetlb_page().

I just doubt how many of us care for that, for FOLL_PIN follow_page doesn't
really happen at all.  But we'll care, and care more if we switch over
slow-gup to use hugetlb_follow_page_mask().  We'll also care when to return
-EMLINK then, as that's the gup internal api to mean "we should do CoR".

When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
clear that it just should never fail.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 82dfdd96db4c..9c261921b2cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6481,8 +6481,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
 	if (pte_present(entry)) {
-		page = pte_page(entry) +
-				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page = pte_page(entry);
+
+		if (gup_must_unshare(vma, flags, page)) {
+			/* Tell the caller to do Copy-On-Read */
+			page = ERR_PTR(-EMLINK);
+			goto out;
+		}
+
+		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
+			page = NULL;
+			goto out;
+		}
+
+		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
 		 * optimizations the page struct may be read only.
@@ -6492,10 +6505,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * try_grab_page() should always be able to get the page here,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
-		if (try_grab_page(page, flags)) {
-			page = NULL;
-			goto out;
-		}
+		WARN_ON_ONCE(try_grab_page(page, flags));
 	}
 out:
 	spin_unlock(ptl);
-- 
2.40.1

