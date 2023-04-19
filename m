Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557226E72A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDSFmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSFmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:42:31 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E440E7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:42:25 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 33J5ed12070031;
        Wed, 19 Apr 2023 13:40:39 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 19 Apr 2023 13:40:39 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: skip CMA pages when they are not available
Date:   Wed, 19 Apr 2023 13:40:24 +0800
Message-ID: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 33J5ed12070031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It is wasting of effort to reclaim CMA pages if they are not availabe
for current context during direct reclaim. Skip them when under corresponding
circumstance.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637f..04424d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
+	bool cma_cap = true;
+	struct page *page;
 	LIST_HEAD(folios_skipped);
 
 	total_scan = 0;
 	scan = 0;
+	if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
+		&& (gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE))
+		cma_cap = false;
+
 	while (scan < nr_to_scan && !list_empty(src)) {
 		struct list_head *move_to = src;
 		struct folio *folio;
@@ -2239,7 +2245,10 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
+		page = &folio->page;
+
+		if (folio_zonenum(folio) > sc->reclaim_idx ||
+			(get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
-- 
1.9.1

