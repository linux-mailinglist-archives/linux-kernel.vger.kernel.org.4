Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A41607C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJUQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJUQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597BE26B6FE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 189-20020a2516c6000000b006bbbcc3dd9bso3751596ybw.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyHYN0BZDkl5R+we+ok2phOJ6Br6Eo9HknyqZ/f6blI=;
        b=k4YSYz8Eqmi/g8cLFz6T0cXUQewY5TrykcLo3J6vLFEFW+zVg07R+6L2pGz4hYkpjh
         YeRSCb3IFz9Lx2ADjHguv3Bcl2NzvlSG0UaHoorM2hx35cBJZbjKBwoRh5rxOv53PUtH
         6JfJ5o1zynpQr144bkb1sr56ifBdHTV2T5B0ZasYzlZTGp6KE2/lEQXR+tm8Fb9Lka+0
         ayKHUamTEhmRm9nNm0eDQcbCVIN9xZXd7NlM3NhcPsDm0mH+iuwgerGgDIztDwXkgbUe
         GoioeQ/qERTklWRzJZVlo//zRoztIQ/e5hovtXxIkbCWhIHv+mW+9bZYapriY1Hylf8f
         cQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyHYN0BZDkl5R+we+ok2phOJ6Br6Eo9HknyqZ/f6blI=;
        b=M/7XFWEEWXPAwLkTN5fa931ccBYhOHovW3gYxyyZCKZMjxk4IB9n+LzWGYoQJhQef+
         xc4VK/jWCgvMhyHIerWdslKj77BYKnRawUa3u1OKFpMmQ0P7K4BcBjmDkSf/ugYDQ+BT
         BwufZdS08PA7MJp1KAYLCuGYRynxzrUG19DBHeTXNqvGsoaGxQH5oNVJySI8JWpbTmQ/
         OZGUcZJah0q1/umWDVQITq8PXjsgpnWu9+a11EpBH1/lmBPxPkyM2EyQ+2TO+BC1zI3b
         8ThG2JRZ1f0ZZFX0R2hkoPj9KpGwZxIfy9q6MMELzGsuBnTOghkC08c8LOhvpQtjeP5d
         7tLQ==
X-Gm-Message-State: ACrzQf2tsD01D5VtFxZ2J0Eokeu7ZHQ2sc5ms5h217nm/5ajPf7o2L63
        ZoMlq0Gte/bgIOvnAD0U/C4ZUnlEwMLZDKAl
X-Google-Smtp-Source: AMsMyM71R8GW+ChtJoWlK0QDaMYn9Alr4ayX6EmYtj3WLRdsrGZ2zJ8HM0W8AKSaOIsOoFkltQC4RNu16EZ4KvtE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:6a8b:0:b0:6c0:5610:b6f1 with SMTP
 id f133-20020a256a8b000000b006c05610b6f1mr17608546ybc.273.1666370235466; Fri,
 21 Oct 2022 09:37:15 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:17 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-2-jthoughton@google.com>
Subject: [RFC PATCH v2 01/47] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is how it should have been to begin with. It would be very bad if
we actually set PageUptodate with a UFFDIO_CONTINUE, as UFFDIO_CONTINUE
doesn't actually set/update the contents of the page, so we would be
exposing a non-zeroed page to the user.

The reason this change is being made now is because UFFDIO_CONTINUEs on
subpages definitely shouldn't set this page flag on the head page.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a7dc7b2e16c..650761cdd2f6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6097,7 +6097,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	if (!is_continue)
+		__SetPageUptodate(page);
+	else
+		VM_WARN_ON_ONCE_PAGE(!PageUptodate(page), page);
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
-- 
2.38.0.135.g90850a2211-goog

