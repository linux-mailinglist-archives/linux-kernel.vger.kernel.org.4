Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3974AD5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGGIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGGIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:51:56 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957B10B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:51:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VmnvSa9_1688719909;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VmnvSa9_1688719909)
          by smtp.aliyun-inc.com;
          Fri, 07 Jul 2023 16:51:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: compaction: use the correct type of list for free pages
Date:   Fri,  7 Jul 2023 16:51:46 +0800
Message-Id: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Use the page->buddy_list instead of page->lru to clarify the correct type
of list for free pages.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index dbc9f86b1934..43358efdbdc2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1500,7 +1500,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
-		list_for_each_entry_reverse(freepage, freelist, lru) {
+		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
 			unsigned long pfn;
 
 			order_scanned++;
@@ -1883,7 +1883,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
-		list_for_each_entry(freepage, freelist, lru) {
+		list_for_each_entry(freepage, freelist, buddy_list) {
 			unsigned long free_pfn;
 
 			if (nr_scanned++ >= limit) {
-- 
2.39.3

