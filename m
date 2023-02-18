Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6F69B6B1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBRA2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBRA2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2459B49
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536582abb72so22509327b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRJSWRU8dQHXXhdXAbgeFtewLtYoHueyg1zV/lollrc=;
        b=JUkI+uUZUGikStVOrWOWfUFvkifZQjdvysrYVMcxjv1b2yQplxM71vw1fjhTzhEkxI
         BEohrL6MRF518g9B3YG2ljl8T7G93FwY6nToc+IVWoDTzVPkWMKdK99Fw+Y/07yhJ3P2
         Pt0n2XoDP+p37aLwSJxXkZR/Jyh8LDLuXTOP46PclH0WaRZarQPsfJWYdmcsYTgivcxA
         V29rcePGsSV2Bm8JBI3cnvgY6VYwZ38Vy23D8uxt/hblg5U5P6fb6PnTeEwjCMXWB3jt
         Xt02v+X21m74LuwV377B2oYbsfLR/FpkRSgMkEe4zOTBZt33XomrJuA07ToJPeOqmC5B
         2qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRJSWRU8dQHXXhdXAbgeFtewLtYoHueyg1zV/lollrc=;
        b=EFhDPtIx+Qrf0TIl/4WzadxlbNvCFb/DC0O4nJH6L5mqgMMaPMCn21myVcAXUcXeEh
         RfTkfQ4w7ZrSo/ssU1dGh9y1kn8UnUJPO1DHqQeVswx94rABzuihVLJGlinpHrXcNPQC
         PeCpgxQHiAT8W9gvJDNzTuEr/5R2ICjDzaRtIv6gBH7x0W9r+kQbAvw8SV98nWtx1jWu
         qsdSJgUQAgoJDcWIxAlOvNcDUOD4uCDa5D6iPiNVwz2WB1EWm1JsxsDfWRc8za4CD/wQ
         tBvokvaP006rcr7iYsbKHDSd72up7gagteZt3Lclwwx9S2DRWB5lLgMhpe9VLQUYvTBU
         R9WA==
X-Gm-Message-State: AO0yUKXItu4v/sEEHBs8svAlKqTmYGHRsTmwIDH6YikvS8OTk9Cyvmmd
        usz/rZVcHt6xu/rt2Efoj330AKZlzMcJg5fS
X-Google-Smtp-Source: AK7set/WjcZL+XrN64oa4iFWZNoLag2qFEizB65Q47paRVpixNGKzuLMD0K/0D4ZsPotwj/bHVSjyMfKhh7AGtfF
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:4981:0:b0:527:adb4:3297 with SMTP
 id w123-20020a814981000000b00527adb43297mr1507453ywa.161.1676680124408; Fri,
 17 Feb 2023 16:28:44 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:34 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-2-jthoughton@google.com>
Subject: [PATCH v2 01/46] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

If would be bad if we actually set PageUptodate with UFFDIO_CONTINUE;
PageUptodate indicates that the page has been zeroed, and we don't want
to give a non-zeroed page to the user.

The reason this change is being made now is because UFFDIO_CONTINUEs on
subpages definitely shouldn't set this page flag on the head page.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..792cb2e67ce5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6256,7 +6256,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__folio_mark_uptodate(folio);
+	if (!is_continue)
+		__folio_mark_uptodate(folio);
+	else if (!folio_test_uptodate(folio)) {
+		/*
+		 * This should never happen; HugeTLB pages are always Uptodate
+		 * as soon as they are allocated.
+		 */
+		ret = -EFAULT;
+		goto out_release_nounlock;
+	}
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
-- 
2.39.2.637.g21b0678d19-goog

