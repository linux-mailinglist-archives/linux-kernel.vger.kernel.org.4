Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4E65E8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjAEKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjAEKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46E551F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a259006000000b00706c8bfd130so36459466ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBa/YNOWHc8BdkByQMj3j16NgHnHDUWMHmpwThmwYW8=;
        b=XMejQEid82qJD40DqqAVmKO7KaK2I6fqGVaQFn3qa+xsUhE5GeK5QsvXmIgXrlYAYp
         ZglFLDAuM74Ul8HnkiBVKndyeFl7TfYD6lrTc+G+Y0y5590vBgUhLji2pkV/uo0dTtba
         JOhfbgAT9W5Ih3mvcLPzzoGXyJzqEfRKoNqybN3iBy+HEU29ORkAZ56QrvlR8wMgJBPv
         /fiJ3Qjur/kHePLpxQf6mexQ2zmKFEUxMYH6n8AvNHRLmu3tqS42gPfHnw2VZCW+sun6
         KjrZlQt7j8nYKl5hgQmUrLHKrYGRJUYde6DMPUl9jm0rRYEyRoygWOPbOjS00/ls6W8J
         sVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBa/YNOWHc8BdkByQMj3j16NgHnHDUWMHmpwThmwYW8=;
        b=D4RD7j7Ekivsr4r2NsylfwUwbgTqsia9/1zw9jii9p+vvBfoJdqD5eb6SXHydy6FA/
         vm5rbp0QsfLsoRmSIE20NoTmYBJQsgdDJkwU9Ib6n+VLFgaz8SQ6XVeGUK3ZslsoRWdX
         BbGpoAMiudw93TRqnHfHkXkk+6UKHRCFJPVGW7jFHYU+Z/d4ddGXnj++8X9xsfMvOWmH
         MXL+N2zdFbhpP6lYP3e2PXUclxVHYfqOlsN1GUW5D2kuXYb0USfbYe7CBZlAVN3QfPOO
         vGCjUmmBgzKK214ZrLG+zYTD4oNiQkj3uoaFzVLfe30fmA87JTzwrs97VKEElHvAcRog
         +kkQ==
X-Gm-Message-State: AFqh2krUTD4u5LrTe0bAitJJIQkD6jmMvaxStRTPJlTPJDYTzJLB2J7h
        hIPk1jwM/QMV0kCEPY9uF5znIXyruGT4OyTC
X-Google-Smtp-Source: AMrXdXvV0r/wfkEbgjE+pvWMQzkSz+gLHIZu+cb6EHqmZiUJTMqvVQaEsHt/42vL01/hmp945pzEpgFSvftYQi7k
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:b14:b0:6fc:c88a:1c6d with SMTP
 id ch20-20020a0569020b1400b006fcc88a1c6dmr5728371ybb.486.1672913959168; Thu,
 05 Jan 2023 02:19:19 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:14 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-17-jthoughton@google.com>
Subject: [PATCH 16/46] hugetlbfs: do a full walk to check if vma maps a page
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

Because it is safe to do so, we can do a full high-granularity page
table walk to check if the page is mapped.

If it were not safe to do so, we could bail out early in the case of a
high-granularity mapped PTE, indicating that the page could have been
mapped.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/hugetlbfs/inode.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 48f1a8ad2243..d34ce79da595 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -386,17 +386,24 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
 static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
-	pte_t *ptep, pte;
+	pte_t pte;
+	struct hugetlb_pte hpte;
 
-	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
-	if (!ptep)
+	if (hugetlb_full_walk(&hpte, vma, addr))
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(hpte.ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
-	if (pte_page(pte) == page)
+	if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte)))
+		/*
+		 * We raced with someone splitting us, and the only case
+		 * where this is impossible is when the pte was none.
+		 */
+		return false;
+
+	if (compound_head(pte_page(pte)) == page)
 		return true;
 
 	return false;
-- 
2.39.0.314.g84b9a713c41-goog

