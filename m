Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E6607C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiJUQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiJUQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452927B578
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36a4089328dso14607417b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=scj2/ZcN7CmnhbVTPEMSvCXttKvb/J7A59aTeFA+Dhs=;
        b=S0gGSTHVvjAreWqeZs5A9raMMMeKXhXFwUCqBkMsUskY4XwYA32hBXLRGplHk45QeI
         5hNgcngQPNVjy5Kk2gQ5YzOxS99JOyMMSdcynaw9rmdXfKkiFEtbFwINokhrgbql0JE2
         0sKmbmef0q7IWIbffBh2wHykR88/4gHiqdd0pAw6PZWkeF9kCARu3pi/qAdcULFiEFK2
         zqn43ZTH5u5pcpqC+v95dptWRM8ktSEwZXJsat+d9M6BgvVw7Tq+4w0GYsymA05kIp1Y
         kIdA/tQpriZyd9lUub9jcQWZ1R2v+B1qZdNcMF4fmnajZ6EhnPh0qg0O2vMtK7smyeOR
         wLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scj2/ZcN7CmnhbVTPEMSvCXttKvb/J7A59aTeFA+Dhs=;
        b=rrXwX1lRb14DyLDW+ahSWsuFgkSX0RikrKWi9X2RCOQDzJDhwTHazZhhoYvs9jjhyS
         x1pAPNAyY+6fGFZgdsEtPixueteJCGnokFhMn01aqyIokL52GP/AlkB1t1hCpPoeuf81
         oagFBxbo86jCflgfu+h5OXbLPzCe2eMZglQIzYEBvdcssU8tOu8WqA6QGIouOXOXuQ5U
         qZOwz4suFktuVWFu9WQm/vKuOQgwTjVx3PaTv2QkI0faoQch2r6VwxYqde6+IGLXCdi3
         y2KpSYP8YzkB+zsTbqgtsea8VcLCgmtAE9gnsNqp+QjVP4RS1EG1EWIIg5g0jh4XMn+W
         CVoQ==
X-Gm-Message-State: ACrzQf3/TkBkvYRPFN/RI37ALjFEp/CILkzk1xudk0zrd1xX0FzgyyQy
        8N/dKcBbJf3f0208OsfkBWUr7TTDhPppuKG1
X-Google-Smtp-Source: AMsMyM4ktFt5TlSATVEDX64pMc+gxEkbubGz5MVYH6J1QITcv/uZTkTFvGYjWRDFvS1XdP3P3wGfcec2WQcdi1Y5
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c713:0:b0:6ca:203:504f with SMTP id
 w19-20020a25c713000000b006ca0203504fmr11754100ybe.574.1666370265356; Fri, 21
 Oct 2022 09:37:45 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:47 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-32-jthoughton@google.com>
Subject: [RFC PATCH v2 31/47] hugetlb: sort hstates in hugetlb_init_hstates
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
index d305742e9d44..e25f97cdd086 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -772,7 +772,7 @@ struct hstate {
 
 struct huge_bootmem_page {
 	struct list_head list;
-	struct hstate *hstate;
+	unsigned long hstate_sz;
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb0005d57cab..d6f07968156c 100644
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
@@ -3189,7 +3194,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
-	m->hstate = h;
+	m->hstate_sz = huge_page_size(h);
 	return 1;
 }
 
@@ -3203,7 +3208,7 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
-		struct hstate *h = m->hstate;
+		struct hstate *h = size_to_hstate(m->hstate_sz);
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(page_count(page) != 1);
@@ -3319,9 +3324,38 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
@@ -3340,13 +3374,8 @@ static void __init hugetlb_init_hstates(void)
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
2.38.0.135.g90850a2211-goog

