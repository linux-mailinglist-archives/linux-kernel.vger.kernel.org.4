Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81E737D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFUIPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFUIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:14:46 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634CCC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:14:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlfF3q2_1687335280;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VlfF3q2_1687335280)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:14:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: use the correct type of list for free pages
Date:   Wed, 21 Jun 2023 16:14:28 +0800
Message-Id: <7e7ab533247d40c0ea0373c18a6a48e5667f9e10.1687333557.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf75f200569d ("mm/page_alloc: add page->buddy_list and page->pcp_list")
introduces page->buddy_list and page->pcp_list as a union with page->lru, but
missed to change get_page_from_free_area() to use page->buddy_list to clarify
the correct type of list for a free page.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5c691426822a..c1839a53326c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -727,7 +727,7 @@ static inline struct page *get_page_from_free_area(struct free_area *area,
 					    int migratetype)
 {
 	return list_first_entry_or_null(&area->free_list[migratetype],
-					struct page, lru);
+					struct page, buddy_list);
 }
 
 /*
-- 
2.27.0

