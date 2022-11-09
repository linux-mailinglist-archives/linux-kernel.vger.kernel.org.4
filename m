Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222EE6225A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKIIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:40:45 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C317E29
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:40:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUNFg20_1667983240;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VUNFg20_1667983240)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 16:40:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     haiyue.wang@intel.com, ying.huang@intel.com,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "mm: migration: fix the FOLL_GET failure on following huge page"
Date:   Wed,  9 Nov 2022 16:40:27 +0800
Message-Id: <496786039852aba90ffa68f10d0df3f4236a990b.1667983080.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit 831568214883 ("mm: migration: fix the FOLL_GET failure on
following huge page"), since after commit 1a6baaa0db73 ("s390/hugetlb:
switch to generic version of follow_huge_pud()") and commit 57a196a58421
("hugetlb: simplify hugetlb handling in follow_page_mask") were merged,
now all the following huge page routines can support FOLL_GET operation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1317e5c..53af072 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1908,7 +1908,6 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 
 	for (i = 0; i < nr_pages; i++) {
 		unsigned long addr = (unsigned long)(*pages);
-		unsigned int foll_flags = FOLL_DUMP;
 		struct vm_area_struct *vma;
 		struct page *page;
 		int err = -EFAULT;
@@ -1917,12 +1916,8 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (!vma)
 			goto set_status;
 
-		/* Not all huge page follow APIs support 'FOLL_GET' */
-		if (!is_vm_hugetlb_page(vma))
-			foll_flags |= FOLL_GET;
-
 		/* FOLL_DUMP to ignore special (like zero) pages */
-		page = follow_page(vma, addr, foll_flags);
+		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
@@ -1935,8 +1930,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (!is_zone_device_page(page))
 			err = page_to_nid(page);
 
-		if (foll_flags & FOLL_GET)
-			put_page(page);
+		put_page(page);
 set_status:
 		*status = err;
 
-- 
1.8.3.1

