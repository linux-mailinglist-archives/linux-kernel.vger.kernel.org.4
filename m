Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227776DF227
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDLKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDLKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:46:03 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8476EAD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:45:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vfw8Fy8_1681296340;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vfw8Fy8_1681296340)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 18:45:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in __pageblock_pfn_to_page()
Date:   Wed, 12 Apr 2023 18:45:31 +0800
Message-Id: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
which checks whether the given zone contains holes, and uses pfn_valid()
to check if the end pfn is valid. However pfn_valid() can not make sure
the end pfn is not a hole if the size of a pageblock is larger than the
size of a sub-mem_section, since the struct page getting by pfn_to_page()
may represent a hole or an unusable page frame, which may cause incorrect
zone contiguous is set.

Though another user of pageblock_pfn_to_page() in compaction seems work
well now, it is better to avoid scanning or touching these offline pfns.
So like commit 2d070eab2e82 ("mm: consider zone which is not fully
populated to have holes"), we should also use pfn_to_online_page() for
the end pfn to make sure it is a valid pfn with usable page frame.
Meanwhile the pfn_valid() for end pfn can be dropped now.

Moreover we've already used pfn_to_online_page() for start pfn to make
sure it is online and valid, so the pfn_valid() for the start pfn is
unnecessary, drop it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d0eb280ec7e4..8076f519c572 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1512,9 +1512,6 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 	/* end_pfn is one past the range we are checking */
 	end_pfn--;
 
-	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
-		return NULL;
-
 	start_page = pfn_to_online_page(start_pfn);
 	if (!start_page)
 		return NULL;
@@ -1522,7 +1519,9 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 	if (page_zone(start_page) != zone)
 		return NULL;
 
-	end_page = pfn_to_page(end_pfn);
+	end_page = pfn_to_online_page(end_pfn);
+	if (!end_page)
+		return NULL;
 
 	/* This gives a shorter code than deriving page_zone(end_page) */
 	if (page_zone_id(start_page) != page_zone_id(end_page))
-- 
2.27.0

