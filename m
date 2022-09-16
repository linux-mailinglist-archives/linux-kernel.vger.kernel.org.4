Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C85BA6E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIPGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIPGgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:36:01 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC99C8D9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:35:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPvv1h1_1663310153;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPvv1h1_1663310153)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 14:35:54 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] mm/hugetlb: add mis_resv_equal_free() func
Date:   Fri, 16 Sep 2022 14:35:50 +0800
Message-Id: <20220916063550.1650-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hugetlb.c file, there are several places to compare the values of
'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
there add a new mis_resv_equal_free() func to do these.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/hugetlb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 66496fc424f4..db6f63fb083f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 
+static inline bool is_resv_equal_free(struct hstate *h)
+{
+	return (h->free_huge_pages - h->resv_huge_pages == 0) ? true : false;
+}
+
 static struct page *dequeue_huge_page_vma(struct hstate *h,
 				struct vm_area_struct *vma,
 				unsigned long address, int avoid_reserve,
@@ -1207,12 +1212,11 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	 * have no page reserves. This check ensures that reservations are
 	 * not "stolen". The child may still get SIGKILLed
 	 */
-	if (!vma_has_reserves(vma, chg) &&
-			h->free_huge_pages - h->resv_huge_pages == 0)
+	if (!vma_has_reserves(vma, chg) && is_resv_equal_free(h))
 		goto err;
 
 	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
+	if (avoid_reserve && is_resv_equal_free(h))
 		goto err;
 
 	gfp_mask = htlb_alloc_mask(h);
@@ -2105,7 +2109,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		if (h->free_huge_pages - h->resv_huge_pages == 0)
+		if (is_resv_equal_free(h))
 			goto out;
 
 		/*
@@ -2315,7 +2319,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
 	spin_lock_irq(&hugetlb_lock);
-	if (h->free_huge_pages - h->resv_huge_pages > 0) {
+	if (!is_resv_equal_free(h)) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
-- 
2.31.0

