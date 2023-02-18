Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6268069B6E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjBRAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjBRAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F168ADA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l206-20020a25ccd7000000b006fdc6aaec4fso2657430ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FTaaiplXAWGfEVqPjHy0St/TFfLKP8Xa0naqtqNKxQ=;
        b=lcSeD08U2fduS0Ppbd/dwZ1sVutpIAR5utesmektFgF0YNOfket/WkjCBRvoXlNLiV
         +o2Aogs/gc+f50ybLSWxFhCjImIYIGSTQeUOhgRWJa7vrQRBVyoRIEpYpw2YRWcA9U41
         WyAW0Ab++KWiCATJErqWrBwpBVdFZBa+QSN736IFEusFdICh8RUH5fL8c0v/Y8PEr8Br
         Qe8eJUa76VSmD3HP1n1esGFDMJpGGHWAJXm6Yqaf73w38JldN0uF+PQwqsmagB2uCrvE
         JVZuFpSJuNpEY8qrsEqwZB/8hVTroKRCuulZOvJKAfU7a7tyMxK2NmKF8QMW0V3Aw8B3
         CM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FTaaiplXAWGfEVqPjHy0St/TFfLKP8Xa0naqtqNKxQ=;
        b=K1KSJZ9YFAyJsz43Br442nFW0U4ssibTHJMG7pQsQKWIxnesYRgA4wbbqr4Z881fBX
         dK3MS7I6pU7Mx55dHflnuxeOedKjDxKBSJoOJGYlReg8dEhj6qCykr2rpqz11f20qzTZ
         AWun5V5kLmGlHHgCZjCYpqfl8TB2k5Dawf+E9Gd2W5ess2+BqOXQbbE+uKFnd6CYO+D8
         9aCpBStExiuIPJTCX3CBTPeHq959bzWB93vUGjyW9x4HU6ej3/F6bavTFZcCyAIEIObC
         CJOLuEH+XlUkokbYN48R6FMY2f/GrbrFg7fCVERIiAh+aD7nYZftpZZonr2+q0mL7Wgt
         OWzQ==
X-Gm-Message-State: AO0yUKVv8EFChHr8M62685HM6hGYzYQbGp8QJDyfAiMMJ3lH4dFHPedm
        NKs2JTgyBBwpDbe59h7dRNvmANcDObnJxF5q
X-Google-Smtp-Source: AK7set8ceT73sh6JAXytc6nngKglB94I/eez0+U3CbTB6Hmq6cgS64DE3iyooTxML7Ni0PUJg/39Zu2G+xo8+s0D
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:f49:0:b0:995:ccb:1aae with SMTP id
 y9-20020a5b0f49000000b009950ccb1aaemr85936ybr.13.1676680159411; Fri, 17 Feb
 2023 16:29:19 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:08 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-36-jthoughton@google.com>
Subject: [PATCH v2 35/46] hugetlb: add check to prevent refcount overflow via HGM
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

With high-granularity mappings, it becomes quite trivial for userspace
to overflow a page's refcount or mapcount. It can be done like so:

1. Create a 1G hugetlbfs file with a single 1G page.
2. Create 8192 mappings of the file.
3. Use UFFDIO_CONTINUE to map every mapping at entirely 4K.

Each time step 3 is done for a mapping, the refcount and mapcount will
increase by 2^19 (512 * 512). Do that 2^13 times (8192), and you reach
2^31.

To avoid this, WARN_ON_ONCE when the refcount goes negative. If this
happens as a result of a page fault, return VM_FAULT_SIGBUS, and if it
happens as a result of a UFFDIO_CONTINUE, return EFAULT.

We can also create too many mappings by fork()ing a lot with VMAs setup
such that page tables must be copied at fork()-time (like if we have
VM_UFFD_WP). Use try_get_page() in copy_hugetlb_page_range() to deal
with this.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c4d189e5f1fd..34368072dabe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5397,7 +5397,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else {
 			ptepage = pte_page(entry);
 			hpage = compound_head(ptepage);
-			get_page(hpage);
+			if (try_get_page(hpage)) {
+				ret = -EFAULT;
+				break;
+			}
 
 			/*
 			 * Failing to duplicate the anon rmap is a rare case
@@ -6132,6 +6135,30 @@ static bool hugetlb_pte_stable(struct hstate *h, struct hugetlb_pte *hpte,
 	return same;
 }
 
+/*
+ * Like filemap_lock_folio, but check the refcount of the page afterwards to
+ * check if we are at risk of overflowing refcount back to 0.
+ *
+ * This should be used in places that can be used to easily overflow refcount,
+ * like places that create high-granularity mappings.
+ */
+static struct folio *hugetlb_try_find_lock_folio(struct address_space *mapping,
+						pgoff_t idx)
+{
+	struct folio *folio = filemap_lock_folio(mapping, idx);
+
+	/*
+	 * This check is very similar to the one in try_get_page().
+	 *
+	 * This check is inherently racy, so WARN_ON_ONCE() if this condition
+	 * ever occurs.
+	 */
+	if (WARN_ON_ONCE(folio && folio_ref_count(folio) <= 0))
+		return ERR_PTR(-EFAULT);
+
+	return folio;
+}
+
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
@@ -6168,7 +6195,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = hugetlb_try_find_lock_folio(mapping, idx);
+	if (IS_ERR(folio)) {
+		/*
+		 * We don't want to invoke the OOM killer here, as we aren't
+		 * actually OOMing.
+		 */
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
 	if (!folio) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6600,8 +6635,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
-		if (!folio)
+		folio = hugetlb_try_find_lock_folio(mapping, idx);
+		if (IS_ERR_OR_NULL(folio))
 			goto out;
 		folio_in_pagecache = true;
 	} else if (!*pagep) {
-- 
2.39.2.637.g21b0678d19-goog

