Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB4736002
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFSXL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFSXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B654E60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00BT5P4M9oBALYuFaAi0Lj2RlKWYXU3sXFeAAd1zvs8=;
        b=f0tYTU3IzvH4uOMNyt0P+hlzEtEZI38d/jYjo6H9ZbicL5L3gPelcENF6pHDuQpqGrlqkB
        YqG95Aqb2zqhx9ez0cL7WzqFWH/febnEomXp8EQZSl5OLcqKncb4PVjAZEDTFoa9LsfdxG
        C73H4N6xdT7IQZkROB7OveoMmizkAFA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6T6UrSYSPX6oDz6AbT-ZHw-1; Mon, 19 Jun 2023 19:10:54 -0400
X-MC-Unique: 6T6UrSYSPX6oDz6AbT-ZHw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76248f3057bso37228285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216254; x=1689808254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00BT5P4M9oBALYuFaAi0Lj2RlKWYXU3sXFeAAd1zvs8=;
        b=f7PsrErmV0NWmaf+Ba5wXgnthol/rA2XpQzqS+xn/puj1ia7E1UdQC4qU4OH1BNQsn
         fU1VTiagNN9blmMKn3HfxeMFcUxasgoXxlnx4P4pS2sSBajkJBmkKXNULTvTIEx9NqMk
         Ij9ebXYbmjNf99TzxBqAJgZCkLgFEz+r4DlZPRo76BT+ezuEXAQFSsMK7J9AioaJ4ILt
         31RCIUK3jTxaSzgBt+Z2U2mgJRwn3lPP1rmM3heJJllRshnxdUc1tqDkSDcvNr4/Hgja
         u+jAsCHTELuSnqoyj+BQ7d3cNaQ3L4bPG8IYou+YfydkVSBDlSXrTTPM8JzfAV7T/cE+
         YMdQ==
X-Gm-Message-State: AC+VfDy7E0RZ8MAzHPBGUl6pUzd7Z2nOsHuiz2WjWfc6GCSIGdbM7bOI
        uaD93ANv01zkg/6gPt8Y+x68ENada5/Zp+dRqNdXrnGbDOb5kjNRfuU4NP4UIVAaZk7IcfPxgPd
        Euje83LIkDjwDKD8xsUVISRJ6
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246406qkp.5.1687216253843;
        Mon, 19 Jun 2023 16:10:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UOYeqlkYR0J6Chpj2TyYjEYwQWzUGGOpxx8Hlzqu19xtpfM0scU4fcVU/UZq38b/9mzJjIA==
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246392qkp.5.1687216253602;
        Mon, 19 Jun 2023 16:10:53 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages != NULL"
Date:   Mon, 19 Jun 2023 19:10:41 -0400
Message-Id: <20230619231044.112894-6-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4a00d609033e..b50272012e49 100644
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
+				pages[i+j] = subpage;
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

