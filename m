Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43553642146
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiLEB5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiLEB5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:57:12 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067E13D56
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:57:11 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id jr1so10529654qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 17:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zm8T1Im5lQZlS8KmDG8ug3k7vKs3MbAFvEQ/V/+qGMs=;
        b=oBiXLQ2qH0u4bTX6QnOElzutUIbpUCqJcRYVD0Rc8+cYgu8GHeNCMt2Nsg8Q6JTZpA
         gO8BvvOiANjRddJMlUsTl/CYkfqW05Xf/zq0LDB7ZBUOwynxQCkdcLQSAoqvBFGgjAyx
         Vg9LmyDDCwiY9X38XiMMewAgZC1/rw9AcayJMnNee7NuGUhSkZ5gHOC5Rt1HCcCYCSZx
         kRx1SL7HeRRvVvy37bTAPdiCx1iWbBp3n8yh1HXpJpzGNIe8Pbat5KzP7R6HP9//Vqpg
         rpFs8UzLiB9lE0IkEmRShOyrYFXHcjf3nY4pDhTkW2vO54ZYzH8YupuPBCXP8XxbwJHR
         LUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zm8T1Im5lQZlS8KmDG8ug3k7vKs3MbAFvEQ/V/+qGMs=;
        b=MUDmHDWItEUd/nNA4kchL/zKsfIHmXDMqZLAibdSAa1mcFHIBcQ6ghqgmyxUK0i/B6
         z8RprzfsuT3+CwpXbgUK+XfdYL5aj2HbCwhyxJ302XUVmhTYVL/VlXv+gvWrZrBES+DN
         nQS+u1bxvm0waJRqe+MzhXFggITa38cKec3V+1SuLBnu45gnCCpJwlJFAelz+rXcr6rS
         bdpxf0iUb4e+Prs6Y7t3ckVgvw1+9jO7lhIHkpnEWtzcVOO3wkqoMnXQ4XglXqmgOX78
         8uPA7IvB77V7bbQLQXcoQx+Ulk42rMLVMNmA5xhcvC4mQIjz9vLInEB5MzpYef/s4hcm
         TpiQ==
X-Gm-Message-State: ANoB5pnkbIYKpCtV8B/7gtNSHFgP+PTLOdGs6DsSZml6I9EbIznjwVn2
        IVdell38VAqqDcAjPbERQg7w3w==
X-Google-Smtp-Source: AA0mqf4FF+tKOxOy5vd4ImmVGJI9e9n6QvIzATrmRSsYm/4BUA9QXWDnuf5DBHmxRxo0MJsg33bcRw==
X-Received: by 2002:a05:622a:40ca:b0:3a6:328d:ee8e with SMTP id ch10-20020a05622a40ca00b003a6328dee8emr59163925qtb.421.1670205430201;
        Sun, 04 Dec 2022 17:57:10 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ck15-20020a05622a230f00b0039953dcc480sm9094377qtb.88.2022.12.04.17.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:57:09 -0800 (PST)
Date:   Sun, 4 Dec 2022 17:57:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm,thp,rmap: fix races between updates of
 subpages_mapcount
Message-ID: <4388158-3092-a960-ff2d-55f2b0fe4ef8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b51634cd16a, introducing the COMPOUND_MAPPED bit, paid attention
to the impossibility of subpages_mapcount ever appearing negative; but
did not attend to those races in which it can momentarily appear larger
than thought possible.

These arise from how page_remove_rmap() first decrements page->_mapcount
or compound_mapcount, then, if that transition goes negative (logical 0),
decrements subpages_mapcount.  The initial decrement lets a racing
page_add_*_rmap() reincrement _mapcount or compound_mapcount immediately,
and then in rare cases its corresponding increment of subpages_mapcount
may be completed before page_remove_rmap()'s decrement.  There could even
(with increasing unlikelihood) be a series of increments intermixed with
the decrements.

In practice, checking subpages_mapcount with a temporary WARN on range,
has caught values of 0x1000000 (2*COMPOUND_MAPPED, when move_pages() was
using remove_migration_pmd()) and 0x800201 (do_huge_pmd_wp_page() using
__split_huge_pmd()): page_add_anon_rmap() racing page_remove_rmap(), as
predicted.

I certainly found it harder to reason about than when bit_spin_locked,
but the easy case gives a clue to how to handle the harder case.  The
easy case being the three !(nr & COMPOUND_MAPPED) checks, which should
obviously be replaced by (nr < COMPOUND_MAPPED) checks - to count a
page as compound mapped, even while the bit in that position is 0.

The harder case is when trying to decide how many subpages are newly
covered or uncovered, when compound map is first added or last removed:
not knowing all that racily happened between first and second atomic ops.

But the easy way to handle that, is again to count the page as compound
mapped all the while that its subpages_mapcount indicates so - ignoring
the _mapcount or compound_mapcount transition while it is on the way to
being reversed.

Fixes: 4b51634cd16a ("mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if PMD-mapped")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 459dc1c44d8a..b616870a09be 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1232,7 +1232,7 @@ void page_add_anon_rmap(struct page *page,
 		if (first && PageCompound(page)) {
 			mapped = subpages_mapcount_ptr(compound_head(page));
 			nr = atomic_inc_return_relaxed(mapped);
-			nr = !(nr & COMPOUND_MAPPED);
+			nr = (nr < COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
@@ -1241,8 +1241,16 @@ void page_add_anon_rmap(struct page *page,
 		if (first) {
 			mapped = subpages_mapcount_ptr(page);
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
-			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
+				nr_pmdmapped = thp_nr_pages(page);
+				nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+				/* Raced ahead of a remove and another add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* Raced ahead of a remove of COMPOUND_MAPPED */
+				nr = 0;
+			}
 		}
 	}
 
@@ -1330,7 +1338,7 @@ void page_add_file_rmap(struct page *page,
 		if (first && PageCompound(page)) {
 			mapped = subpages_mapcount_ptr(compound_head(page));
 			nr = atomic_inc_return_relaxed(mapped);
-			nr = !(nr & COMPOUND_MAPPED);
+			nr = (nr < COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
@@ -1339,8 +1347,16 @@ void page_add_file_rmap(struct page *page,
 		if (first) {
 			mapped = subpages_mapcount_ptr(page);
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
-			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
+				nr_pmdmapped = thp_nr_pages(page);
+				nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+				/* Raced ahead of a remove and another add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* Raced ahead of a remove of COMPOUND_MAPPED */
+				nr = 0;
+			}
 		}
 	}
 
@@ -1387,7 +1403,7 @@ void page_remove_rmap(struct page *page,
 		if (last && PageCompound(page)) {
 			mapped = subpages_mapcount_ptr(compound_head(page));
 			nr = atomic_dec_return_relaxed(mapped);
-			nr = !(nr & COMPOUND_MAPPED);
+			nr = (nr < COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
@@ -1396,8 +1412,16 @@ void page_remove_rmap(struct page *page,
 		if (last) {
 			mapped = subpages_mapcount_ptr(page);
 			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
-			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+			if (likely(nr < COMPOUND_MAPPED)) {
+				nr_pmdmapped = thp_nr_pages(page);
+				nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
+				/* Raced ahead of another remove and an add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* An add of COMPOUND_MAPPED raced ahead */
+				nr = 0;
+			}
 		}
 	}
 
-- 
2.35.3
