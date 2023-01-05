Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68C65E8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjAEKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjAEKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A64C731
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:18:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso36235128ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hd7V91rscRPZFZZvxWy710h4affBEizLA7fDXt78Shk=;
        b=e5/xp7qtQB20h9zFT5hG8PhvybXKj9xDQ+Q32FSU+DoEcADv55QGkwnSACPjQG/DyG
         vSRBq0IQ2N16x9PTtjdsbMAthbWAIxsOWG8qTqMi3fOpGsCfnEzbWtwY/ftO7/Aww8UO
         QDPnn5bU281BREv8ROjgTb6/jrQ4xdaIwAXCflIgBhVPfKKsCUqvAx6332vM6h13gOZT
         9fP/e7Jwx/iB0gVJpzSXmMLjDIxvFvGjRhbP16hT207hdtIUzqTLLWx1ltXn2+FmtM24
         IuRG4pS+ekNQ8KYf+xVb4krM3ZYDVnIAUyYIxI4L+mJmziZTbCp7hnTBs60V1VSV/eHb
         UOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd7V91rscRPZFZZvxWy710h4affBEizLA7fDXt78Shk=;
        b=DQNLwQRy60WD3Pc3atp8jSckK1AKWOkuZDUjEE9HyUsYEq/5Hz1R9FifM0e9+0g7w7
         6cO7p/BO9Kz+f1SynczottRdCPJEjZ8ObWXMf7hJe1NNgK4LK8ShvWL7FmkYJKNb4N9V
         yYLXhrdXRaIh3REbIgPDPK5CQCX4d4MMDwMvxBVoVR5dhVXt0LzCf6ztgPAr0DejKmHm
         sfC1C7kv5trELKkzPwOuyN95fnA5vJGmAmTGNIWkDtJXkSFmkrxqid+waLGqud8lM+N8
         GvISu2c0pecAX1fZ68isxmTyLNDwREaXvv70+eT2I4kF8jDKkEtJZBby7MZV8l602x7r
         17+w==
X-Gm-Message-State: AFqh2krYK9LroXQ3XPkOulQ/nAoEmfBStI7haQ92MvzhxUsm5fOSzvvC
        zfBS6PM/kFCANuhcjR4l1wLOtc2Fav7Xq7uD
X-Google-Smtp-Source: AMrXdXstw/w8uZgrnirlc8KaHhFpJGRLW/TRlHyKxIB3cggFw/eFDgOY+owXrL+9vF5tHSEWgJCdm1gzsJeripRO
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:ccc2:0:b0:3c3:b17a:4255 with SMTP
 id o185-20020a0dccc2000000b003c3b17a4255mr7272761ywd.38.1672913933058; Thu,
 05 Jan 2023 02:18:53 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:17:59 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-2-jthoughton@google.com>
Subject: [PATCH 01/46] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
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

If would be bad if we actually set PageUptodate with UFFDIO_CONTINUE;
PageUptodate indicates that the page has been zeroed, and we don't want
to give a non-zeroed page to the user.

The reason this change is being made now is because UFFDIO_CONTINUEs on
subpages definitely shouldn't set this page flag on the head page.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b39b74e0591a..b061e31c1fb8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6229,7 +6229,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	if (!is_continue)
+		__SetPageUptodate(page);
+	else if (!PageUptodate(page)) {
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
2.39.0.314.g84b9a713c41-goog

