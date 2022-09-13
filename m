Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37E5B7BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIMT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIMT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DA74DD4;
        Tue, 13 Sep 2022 12:58:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y2so6829968qkl.11;
        Tue, 13 Sep 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yHgeZ0+Ocv6GrFoaruOXhrYrRwLmKzzR+EPUoXoCFLk=;
        b=MO7TGhjFAweThFGVYteWrV+nJ7j5y3LZRa4C7ACnJ1qWyIG54wf5kg5kO3xvw/FqDQ
         s4wKsy9yFNOEBO191kejMvdr64z7Q9PD3aPBFXDJT69Mpap/Qm7BagM/tmOC2sbVk5Ek
         f646vwKxfSqOitl6VKXJ3CuYfAma7EN7IglgyNYbVTkgDe6A8Ejr2VK5Z6ft+DXrx+l4
         fQRhw7+DxWu3uXxtthnmrlFhvdM2zwLPoqSspHMHQaTzl30h2Y5TuDS9T3a1oeXGiuia
         JD/Wvi1/kbP+I5YXUEfkPCFyR+Q73ACUQMRNqUffeivDuZhRpUvnXKzfC7RG3PK+ZTef
         LsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yHgeZ0+Ocv6GrFoaruOXhrYrRwLmKzzR+EPUoXoCFLk=;
        b=cnBDhhQIFNXguJJ23rGROJmch75Eqsn/VfAHAHyhxlDTq1/ZCt/mJ+u8LtJSYNSG7Y
         /VSibe22cxCkCk+frsTgtFPD7sppKKsow7FCaXp8IPtfNqlXeCfCifr4YCmPkO49mVvF
         tr0CyYaf+WvAsS3TRIIH+r7XiQY/v5IAxxu7rzSgkD6Eup5Sd3ob4ChU1R6cC4N3WdAC
         qnWruRmMnEmAvfdNH6FnDhbHnxqJBokE+0ojoAVZrAAhBRpscRPhr0ZjlOljSCO/RlM+
         r/XFbrjCZEp2W528aRhk2XdbfQwe6a/ibJ7nFw+H48p+eMRlZLUJjoBfHaamgNJPEsmQ
         WZaA==
X-Gm-Message-State: ACgBeo0EEXE3Rb3FJ/9hVh3SOJkUEWDhK2YpLwU3Wiv2QvI7vFQ2NDBQ
        fzaW9yYfpVFKQ3Q4E1BD++A=
X-Google-Smtp-Source: AA6agR5MEfLRKDjJcxpoJCjM2jEAW8H06DRSio04kdGXrEcQ2RvULscAsN8q5RMRJ4UP1SunQTdfRQ==
X-Received: by 2002:a05:620a:488f:b0:6ce:634e:8963 with SMTP id ea15-20020a05620a488f00b006ce634e8963mr3462100qkb.16.1663099089149;
        Tue, 13 Sep 2022 12:58:09 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:08 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 04/21] mm/hugetlb: refactor alloc_and_dissolve_huge_page
Date:   Tue, 13 Sep 2022 12:54:51 -0700
Message-Id: <20220913195508.3511038-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index a1d51a1f0404..f232a37df4b6 100644
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

