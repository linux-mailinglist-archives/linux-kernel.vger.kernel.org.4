Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF26E3E58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDQDwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDQDwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:52:47 -0400
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81372A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:52:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681703561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N1rIn34+I9+LMC5x+RgqWpX2I7AwIm2eyZEXSYzzQWE=;
        b=bRJ70dlyX4rS4tJEJU7dR4YfnCkk4eXbdUlgcIo9FX8iGh7GFxItdrdzozlfUkkI5Jy0+T
        Uzal4FJNdETzepC7uKDOz3XX/Xzhw273vNF3201SUXanEY2N8Hn4GXYwB2kkfvj+2x36uj
        8Qa8YzKxlyXhD/HZ54cZUmRvobMvwqw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     hannes@cmpxchg.org, vbabka@suse.cz, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] lib/show_mem.c: Use for_each_populated_zone() simplify code
Date:   Mon, 17 Apr 2023 11:52:26 +0800
Message-Id: <20230417035226.4013584-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __show_mem() needs to iterate over all zones that have memory, we can
simplify the code by using for_each_populated_zone().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 lib/show_mem.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 0d7585cde2a6..1485c87be935 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -10,26 +10,19 @@
 
 void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
-	pg_data_t *pgdat;
 	unsigned long total = 0, reserved = 0, highmem = 0;
+	struct zone *zone;
 
 	printk("Mem-Info:\n");
 	__show_free_areas(filter, nodemask, max_zone_idx);
 
-	for_each_online_pgdat(pgdat) {
-		int zoneid;
+	for_each_populated_zone(zone) {
 
-		for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-			struct zone *zone = &pgdat->node_zones[zoneid];
-			if (!populated_zone(zone))
-				continue;
+		total += zone->present_pages;
+		reserved += zone->present_pages - zone_managed_pages(zone);
 
-			total += zone->present_pages;
-			reserved += zone->present_pages - zone_managed_pages(zone);
-
-			if (is_highmem_idx(zoneid))
-				highmem += zone->present_pages;
-		}
+		if (is_highmem(zone))
+			highmem += zone->present_pages;
 	}
 
 	printk("%lu pages RAM\n", total);
-- 
2.25.1

