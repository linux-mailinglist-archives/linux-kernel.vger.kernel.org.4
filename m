Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550569B6D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBRAbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47786ABE8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o137-20020a25418f000000b009419f64f6afso2165216yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5QeZmWStm8MBBmvLyhf4o+hksgZUS71zRGtmoeJ5N4=;
        b=iqrumGyh+1DXgn+jsoYD5tlyxEnhTKa0RiDswgYlulz2R+ePcUkS4hk7pJr1l5TN4Z
         t4OGyf3Ee88VCdy7Q/P2cmEh2dAWdOVlOvBP1o2vJ8WyqBhGxkkoh3k8/Itb4ZdbmqKm
         cc2rGHBwWYUHY+CQ/nhxnlepr/hLoBQcN2mefhb5d+Skxpoc3mQ6YYqwqicwAf3fMJi9
         IbApGiC57N5YDkCsKcP9870idXAalXkC8/897RuNBgRUzMFJC0wrZjC6bZRbVALKQPA4
         KUFkbVYqdOLVPYutCh7Ev7uHgUEdcvwEGi0C/ONTXZeJkJHpEuUFB85nzCIxbQ0alG9k
         tAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5QeZmWStm8MBBmvLyhf4o+hksgZUS71zRGtmoeJ5N4=;
        b=HqcE7V/mOynNTi4Zfix8nkvSx5PtsBEOrGTWEu4TQXqYEzEp8U4xkROeLkztMjHf1p
         yIjMDZc5pzw3j06TNkFDRU7UWKEFImW8MEUDn4rf4KftV26Wc6DRBusyxRHmzVOn0jKg
         oYDxGhBbhLkXcQaJZTtKufEnYdFhOTbM6E2Y0OEZ0GwekjXcimyMYNx7P2ZbRYaEVG8V
         8QlC6SbpWmu1LJ2HYo7Vqo2k6mtypnPqy30gV4k6iIlgHvsYs16uWyaMh3/O/nh75Hnw
         aGk/F60D7gKRBtImVR+HfkpKYokBaqxpq74/9j4+qLA9VkC2jFSnQQknJvVekYCdsSHD
         3LHg==
X-Gm-Message-State: AO0yUKV7EV/bGmkUlOhWyLNUIbi2MqZPsiU0cLnY1o5BJUkgQrY2EtZ3
        6VujJs9X1Hx71/sFrt3okEuSjqBggfrUlxV1
X-Google-Smtp-Source: AK7set8cs/bMSPkcig+yHBN2nUuLXJMfaVz/DRZ9ytGQCyW0wyjGaQbg0OHjwkIcX38+L9v/Io1eBcNX9GOn9imw
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:e211:0:b0:872:465e:2cbf with SMTP
 id h17-20020a25e211000000b00872465e2cbfmr1298716ybe.264.1676680154885; Fri,
 17 Feb 2023 16:29:14 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:04 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-32-jthoughton@google.com>
Subject: [PATCH v2 31/46] hugetlb: sort hstates in hugetlb_init_hstates
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

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2fe1eb6897d4..a344f9d9eba1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -766,7 +766,7 @@ struct hstate {
 
 struct huge_bootmem_page {
 	struct list_head list;
-	struct hstate *hstate;
+	unsigned long hstate_sz;
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 39f541b4a0a8..e20df8f6216e 100644
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
@@ -3464,7 +3469,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
-	m->hstate = h;
+	m->hstate_sz = huge_page_size(h);
 	return 1;
 }
 
@@ -3479,7 +3484,7 @@ static void __init gather_bootmem_prealloc(void)
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = page_folio(page);
-		struct hstate *h = m->hstate;
+		struct hstate *h = size_to_hstate(m->hstate_sz);
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
@@ -3595,9 +3600,38 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
@@ -3616,13 +3650,8 @@ static void __init hugetlb_init_hstates(void)
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
2.39.2.637.g21b0678d19-goog

