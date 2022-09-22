Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ECC5E587E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIVCTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVCTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:19:42 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B989FE6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:19:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQQFgdF_1663813171;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQQFgdF_1663813171)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 10:19:32 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     mike.kravetz@oracle.com
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] mm/hugetlb: add available_huge_pages() func
Date:   Thu, 22 Sep 2022 10:19:29 +0800
Message-Id: <20220922021929.98961-1-xhao@linux.alibaba.com>
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
there add a new available_huge_pages() func to do these.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
Changes from v4
(https://lore.kernel.org/lkml/20220920015122.68064-1-xhao@linux.alibaba.com/)
- Add Reviewed-by other reviewers.

Changes from v3
(https://lore.kernel.org/lkml/20220917011528.11331-1-xhao@linux.alibaba.com/)
- add Reviewed-by Mike Kravetz <mike.kravetz@oracle.com>

Changes from v2
(https://lore.kernel.org/linux-mm/20220916064127.1904-1-xhao@linux.alibaba.com/)
- Convert is_resv_equal_free() to available_huge_pages()

 mm/hugetlb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b8526d27c29..99dc961d131a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }

+static unsigned long available_huge_pages(struct hstate *h)
+{
+	return h->free_huge_pages - h->resv_huge_pages;
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
+	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
 		goto err;

 	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
+	if (avoid_reserve && !available_huge_pages(h))
 		goto err;

 	gfp_mask = htlb_alloc_mask(h);
@@ -2124,7 +2128,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		if (h->free_huge_pages - h->resv_huge_pages == 0)
+		if (!available_huge_pages(h))
 			goto out;

 		/*
@@ -2311,7 +2315,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
 	spin_lock_irq(&hugetlb_lock);
-	if (h->free_huge_pages - h->resv_huge_pages > 0) {
+	if (available_huge_pages(h)) {
 		struct page *page;

 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
--
2.31.0
