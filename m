Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292EF5E564C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiIUWh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIUWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:37:18 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3989A2A84
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x18so5042600qkn.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W65OPn/JICs8j0QopHJv5kNae6yu6rzXZKtwjhKQdDM=;
        b=BJt7G/2c59nwBSk8Q0V3/7HnKDO6LesViA0xuVg+AKKCX+h2EeeBYkeXg6TsoAjlVC
         Kib+ror8qjzjovAiAcLv1qxgl61JtBdSuWNin5zR6mKlz5IaSzErcjv/YpMPdKimVqk9
         V6p0PisB7NFwu+6MsTMW0YBvCWFQ6g+5q/GnTMHJzHvw2ZxG+o1Aa4b6LHlvAWogYl/S
         Hr4kS8K6rhVR6CSn5aeSA0GnQKzcFVoawtIeiRgdn6w+ONR+upm/zFSZI7s5R9zcI7iV
         fFAN2mAfWX1wHgNMjY+Xen1iIvDy1Wd8PQkGAnIihgOh6KtFnNxdX7iQmG+ZNvQfEhmm
         IJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W65OPn/JICs8j0QopHJv5kNae6yu6rzXZKtwjhKQdDM=;
        b=uniDZcBtTOCcnyA7IgDccH9DMGXuD20rJF+j0lv64QtDm48VaxOXH/Wxy3rRqE4tfT
         m28/W5ucJbnYeFHAaKYd0eUPbQKmf4lqlEyrPACff6rrT2wGx9tikCy4vLo8sZTOs+oN
         oQs97XUdbAf8wL140KwYV65cPl40Cl2i/fDjob9gxc863ZDxdu89gSD/TmnfqDaifwxO
         eT8Z0/8pRihe+eYi08XONnMmiUVrlTR2dHuTxNMWO1hN7rOc6BgZn4qijbILcgk5XGVo
         /kehT6oNSbhsNtcSKB8gSyip8iErR8kbU+mk7cWbtfbBHItO90bJYVy7PGPuo5S8fcly
         Ka+Q==
X-Gm-Message-State: ACrzQf2RvkPUO9OLn1k8WniNocnnPaRj4+o/jOk8VjeE0o099x3Irvzc
        QCwQNhowOyufy7M/I0VwwVs=
X-Google-Smtp-Source: AMsMyM7dWSkzW1KyqoUVlKGHvNPTSTszHVZixiUm4p91nyjOSPM1g3zSIZHi3b8z8mqKUFlf+7gJoQ==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr275973qko.260.1663799836698;
        Wed, 21 Sep 2022 15:37:16 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006cea2984c9bsm2731540qkp.100.2022.09.21.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:37:14 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 1/3] mm/hugetlb: refactor alloc_and_dissolve_huge_page
Date:   Wed, 21 Sep 2022 15:36:37 -0700
Message-Id: <20220921223639.1152392-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921223639.1152392-1-opendmb@gmail.com>
References: <20220921223639.1152392-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_replacement_page() and replace_hugepage() functions are
created from code in the alloc_and_dissolve_huge_page() function
to allow their reuse by the next commit.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 84 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..2b60de78007c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2709,32 +2709,22 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 }
 
 /*
- * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
- * @h: struct hstate old page belongs to
- * @old_page: Old page to dissolve
- * @list: List to isolate the page in case we need to
- * Returns 0 on success, otherwise negated error.
+ * Before dissolving the page, we need to allocate a new one for the
+ * pool to remain stable.  Here, we allocate the page and 'prep' it
+ * by doing everything but actually updating counters and adding to
+ * the pool.  This simplifies and let us do most of the processing
+ * under the lock.
  */
-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
-					struct list_head *list)
+static struct page *alloc_replacement_page(struct hstate *h, int nid)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	int nid = page_to_nid(old_page);
 	bool alloc_retry = false;
 	struct page *new_page;
-	int ret = 0;
 
-	/*
-	 * Before dissolving the page, we need to allocate a new one for the
-	 * pool to remain stable.  Here, we allocate the page and 'prep' it
-	 * by doing everything but actually updating counters and adding to
-	 * the pool.  This simplifies and let us do most of the processing
-	 * under the lock.
-	 */
 alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	/*
 	 * If all goes well, this page will be directly added to the free
 	 * list in the pool.  For this the ref count needs to be zero.
@@ -2748,7 +2738,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	SetHPageTemporary(new_page);
 	if (!put_page_testzero(new_page)) {
 		if (alloc_retry)
-			return -EBUSY;
+			return ERR_PTR(-EBUSY);
 
 		alloc_retry = true;
 		goto alloc_retry;
@@ -2757,6 +2747,48 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 	__prep_new_huge_page(h, new_page);
 
+	return new_page;
+}
+
+static void replace_hugepage(struct hstate *h, int nid, struct page *old_page,
+			     struct page *new_page)
+{
+	lockdep_assert_held(&hugetlb_lock);
+	/*
+	 * Ok, old_page is still a genuine free hugepage. Remove it from
+	 * the freelist and decrease the counters. These will be
+	 * incremented again when calling __prep_account_new_huge_page()
+	 * and enqueue_huge_page() for new_page. The counters will remain
+	 * stable since this happens under the lock.
+	 */
+	remove_hugetlb_page(h, old_page, false);
+
+	/*
+	 * Ref count on new page is already zero as it was dropped
+	 * earlier.  It can be directly added to the pool free list.
+	 */
+	__prep_account_new_huge_page(h, nid);
+	enqueue_huge_page(h, new_page);
+}
+
+/*
+ * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * @h: struct hstate old page belongs to
+ * @old_page: Old page to dissolve
+ * @list: List to isolate the page in case we need to
+ * Returns 0 on success, otherwise negated error.
+ */
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
+					struct list_head *list)
+{
+	int nid = page_to_nid(old_page);
+	struct page *new_page;
+	int ret = 0;
+
+	new_page = alloc_replacement_page(h, nid);
+	if (IS_ERR(new_page))
+		return PTR_ERR(new_page);
+
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(old_page)) {
@@ -2783,21 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		cond_resched();
 		goto retry;
 	} else {
-		/*
-		 * Ok, old_page is still a genuine free hugepage. Remove it from
-		 * the freelist and decrease the counters. These will be
-		 * incremented again when calling __prep_account_new_huge_page()
-		 * and enqueue_huge_page() for new_page. The counters will remain
-		 * stable since this happens under the lock.
-		 */
-		remove_hugetlb_page(h, old_page, false);
-
-		/*
-		 * Ref count on new page is already zero as it was dropped
-		 * earlier.  It can be directly added to the pool free list.
-		 */
-		__prep_account_new_huge_page(h, nid);
-		enqueue_huge_page(h, new_page);
+		replace_hugepage(h, nid, old_page, new_page);
 
 		/*
 		 * Pages have been replaced, we can safely free the old one.
-- 
2.25.1

