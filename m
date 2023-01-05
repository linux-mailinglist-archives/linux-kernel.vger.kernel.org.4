Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1652F65E8E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjAEKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjAEKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093758304
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4755eb8a57bso287394817b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Cz37H+8pkm+eG9Z0H34ERNe8HsOxRqux6VnMQZxVI=;
        b=RZvyYiGXLrB3ETdxawuVmo48jsdy59hZOrayu4MwbFs3pJ3ttnsPWlfACHcTKuKELB
         u7elr2o9ZzrreQn73HuxEenrQvdmQK+5qRx8fmCbb3+0y2yuQjtc7Eke6FKuTchDEYK8
         YYzHLqNy10+sQRvm2sKmrDW/f1TF8kIqeHUqYRoK6qBEqz5HHAvdPBYZSb8+r9/77pgk
         lP8AdMMJCj/pfVHI2L4IlZhXYA3ZFnieW2soK/tiuKrevAeNTQ9+1Pzbbjl+RBoEO1Mv
         1xYC+3/f2aDhItaL5lZuwhNnbQvNespJUKgHC6UK4LpthFqABlyIPMSYy0cETysfVVG/
         YFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Cz37H+8pkm+eG9Z0H34ERNe8HsOxRqux6VnMQZxVI=;
        b=BIw6RbUDoSmkeR/xxKy0KvxXmuj7ZrokWTVzLtCmnPZ1w9H0SQkIUA/owE5T/Iw1cX
         FcSwrTGnw+mo0k3W0CXQpn/s+bhi9Xp79VgpuX2bsGMF8ZJI6N9KigYntcBo+08lrKOC
         Qv7NrSnUNXlfB48jSJdZs8W0fiw8aRHT6tYhbqVVduq3/U6qAQvRc48A5vpB7s23ooBA
         K6XkXu494B0T5sIzp72bjL1GcHLKdNk3QVIhwtgeLUZFTBZB4RV85NYEeVqVC8WXNtH5
         yHBa5DVGfHXLuM5Rjy61qOY8mZXzyqQK/DSl2421CFoNGliPuq+NoAI/OscO9KWjZP8S
         AG8Q==
X-Gm-Message-State: AFqh2kpSDhIHIVHyukI/N6C5I0QtDkGOw4+o7KO5ieioUguHiDb9R/eu
        Ipf8Rje/SzC/js2WXoFG+J3D51d1DNy6FIZc
X-Google-Smtp-Source: AMrXdXtZGNLt5SyLCQDlE7Cx/SKZasA9AHgebF17gcCgna+iBzg3syTx/7S3c65ST+dTPGEZeQ5Z177L8GEcKyYJ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:17d6:0:b0:3ea:9ce2:cd76 with SMTP
 id 205-20020a8117d6000000b003ea9ce2cd76mr93655ywx.217.1672913979081; Thu, 05
 Jan 2023 02:19:39 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:29 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-32-jthoughton@google.com>
Subject: [PATCH 31/46] hugetlb: sort hstates in hugetlb_init_hstates
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

When using HugeTLB high-granularity mapping, we need to go through the
supported hugepage sizes in decreasing order so that we pick the largest
size that works. Consider the case where we're faulting in a 1G hugepage
for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
a PUD. By going through the sizes in decreasing order, we will find that
PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.

This commit also changes bootmem hugepages from storing hstate pointers
directly to storing the hstate sizes. The hstate pointers used for
boot-time-allocated hugepages become invalid after we sort the hstates.
`gather_bootmem_prealloc`, called after the hstates have been sorted,
now converts the size to the correct hstate.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 49 ++++++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index daf993fdbc38..8a664a9dd0a8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -789,7 +789,7 @@ struct hstate {
 
 struct huge_bootmem_page {
 	struct list_head list;
-	struct hstate *hstate;
+	unsigned long hstate_sz;
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2fb95ecafc63..1e9e149587b3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -34,6 +34,7 @@
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
 #include <linux/memory.h>
+#include <linux/sort.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -49,6 +50,10 @@
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
+/*
+ * After hugetlb_init_hstates is called, hstates will be sorted from largest
+ * to smallest.
+ */
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
@@ -3347,7 +3352,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
-	m->hstate = h;
+	m->hstate_sz = huge_page_size(h);
 	return 1;
 }
 
@@ -3362,7 +3367,7 @@ static void __init gather_bootmem_prealloc(void)
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = page_folio(page);
-		struct hstate *h = m->hstate;
+		struct hstate *h = size_to_hstate(m->hstate_sz);
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
@@ -3478,9 +3483,38 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	kfree(node_alloc_noretry);
 }
 
+static int compare_hstates_decreasing(const void *a, const void *b)
+{
+	unsigned long sz_a = huge_page_size((const struct hstate *)a);
+	unsigned long sz_b = huge_page_size((const struct hstate *)b);
+
+	if (sz_a < sz_b)
+		return 1;
+	if (sz_a > sz_b)
+		return -1;
+	return 0;
+}
+
+static void sort_hstates(void)
+{
+	unsigned long default_hstate_sz = huge_page_size(&default_hstate);
+
+	/* Sort from largest to smallest. */
+	sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
+	     compare_hstates_decreasing, NULL);
+
+	/*
+	 * We may have changed the location of the default hstate, so we need to
+	 * update it.
+	 */
+	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
+}
+
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h, *h2;
+	struct hstate *h;
+
+	sort_hstates();
 
 	for_each_hstate(h) {
 		/* oversize hugepages were init'ed in early boot */
@@ -3499,13 +3533,8 @@ static void __init hugetlb_init_hstates(void)
 			continue;
 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
-		for_each_hstate(h2) {
-			if (h2 == h)
-				continue;
-			if (h2->order < h->order &&
-			    h2->order > h->demote_order)
-				h->demote_order = h2->order;
-		}
+		if (h - 1 >= &hstates[0])
+			h->demote_order = huge_page_order(h - 1);
 	}
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

