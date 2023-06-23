Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41C73BA32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFWObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjFWOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058602139
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmCvEzGFNb0TFjW2MTydxEZnQUnXGwjoOel6yGTr3Bo=;
        b=Z3N+omf3sVH+MgXm18iZ335oYiouK50udE5U3xC/U1c1IHqysXHGZT/66D62i39eOTLQd4
        MGeRkoNQxyy/zw7V9+yty8c7D38ZWtWhCczACcFZKNGgWCmj9rZwkMHDQARQyICu2qJa1o
        BQDSsAVFvhfr62ljvh7kqR6Yl129+B8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-XcbcpbNMNdmcafwQqIAxlQ-1; Fri, 23 Jun 2023 10:29:47 -0400
X-MC-Unique: XcbcpbNMNdmcafwQqIAxlQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62ff7a8b9aeso1315546d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530586; x=1690122586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmCvEzGFNb0TFjW2MTydxEZnQUnXGwjoOel6yGTr3Bo=;
        b=d/Vi6vO05URC2xi6wX/qHZ1tS+Fz5kT7j2i89jHaFvfpyTYabgyyA9C8sQEQJrkQS2
         ew8SKfoUzNDAFBO6Cad8Uz6h3lg9fdj4kHa8uqclNvwBXNyDHnZLOzzK0ILPGNxAwtni
         mykyB8otShD2/rSBL5eLCyBgqZqYZEWcY/zY9GPq4lwyZA1xj/SoyrjJevC2Rumzjfxt
         FZ+J235mz1iKC0f69swbQUbd343EyJnF3VNf5MEG84TtSs43tWo+bA44kKLkrdT6r3co
         P0zPghR6gHIttkW9CxaYwGyoeebrnz8tpb14IqlzgjxszkhS4FNsCqyZYwPIu5ZOtiLA
         yMKA==
X-Gm-Message-State: AC+VfDxr4Za/a5BsqaZXIPiGziU1pVvU2Yp865t+5lSLdkAX1f3L3A6C
        1WoPXCkvyhmZbTvrwbJDbYRUrXd5Z9KFHzNh6NNP+ARy/1Iuq5DIuglar9p3d4TRcasZnW0oLge
        syZk9sZ4YD45d73lyvNWTIVNF
X-Received: by 2002:a05:6214:300f:b0:625:86ed:8ab4 with SMTP id ke15-20020a056214300f00b0062586ed8ab4mr4610254qvb.3.1687530586532;
        Fri, 23 Jun 2023 07:29:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oG/I/D+2ou09cQcTlfX+z4F1YPxjXAbS6ijyg5lFwMxdYPO8Sr/TxyEq0M2ORmBAvTkxKmg==
X-Received: by 2002:a05:6214:300f:b0:625:86ed:8ab4 with SMTP id ke15-20020a056214300f00b0062586ed8ab4mr4610231qvb.3.1687530586290;
        Fri, 23 Jun 2023 07:29:46 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:46 -0700 (PDT)
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
Subject: [PATCH v3 5/8] mm/gup: Accelerate thp gup even for "pages != NULL"
Date:   Fri, 23 Jun 2023 10:29:33 -0400
Message-Id: <20230623142936.268456-6-peterx@redhat.com>
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

The acceleration of THP was done with ctx.page_mask, however it'll be
ignored if **pages is non-NULL.

The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
accelerate mm_populate() treatment of THP pages").  It didn't explain why
we can't optimize the **pages non-NULL case.  It's possible that at that
time the major goal was for mm_populate() which should be enough back then.

Optimize thp for all cases, by properly looping over each subpage, doing
cache flushes, and boost refcounts / pincounts where needed in one go.

This can be verified using gup_test below:

  # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10

Before:    13992.50 ( +-8.75%)
After:       378.50 (+-69.62%)

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4a00d609033e..22e32cff9ac7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
 			goto out;
 		}
 next_page:
-		if (pages) {
-			pages[i] = page;
-			flush_anon_page(vma, page, start);
-			flush_dcache_page(page);
-			ctx.page_mask = 0;
-		}
-
 		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
+
+		if (pages) {
+			struct page *subpage;
+			unsigned int j;
+
+			/*
+			 * This must be a large folio (and doesn't need to
+			 * be the whole folio; it can be part of it), do
+			 * the refcount work for all the subpages too.
+			 *
+			 * NOTE: here the page may not be the head page
+			 * e.g. when start addr is not thp-size aligned.
+			 * try_grab_folio() should have taken care of tail
+			 * pages.
+			 */
+			if (page_increm > 1) {
+				struct folio *folio;
+
+				/*
+				 * Since we already hold refcount on the
+				 * large folio, this should never fail.
+				 */
+				folio = try_grab_folio(page, page_increm - 1,
+						       foll_flags);
+				if (WARN_ON_ONCE(!folio)) {
+					/*
+					 * Release the 1st page ref if the
+					 * folio is problematic, fail hard.
+					 */
+					gup_put_folio(page_folio(page), 1,
+						      foll_flags);
+					ret = -EFAULT;
+					goto out;
+				}
+			}
+
+			for (j = 0; j < page_increm; j++) {
+				subpage = nth_page(page, j);
+				pages[i + j] = subpage;
+				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
+				flush_dcache_page(subpage);
+			}
+		}
+
 		i += page_increm;
 		start += page_increm * PAGE_SIZE;
 		nr_pages -= page_increm;
-- 
2.40.1

