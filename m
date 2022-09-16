Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631685BABFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiIPLGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiIPLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:06:02 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F933FA26
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:59:10 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28GAwVml097851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 18:58:31 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 16 Sep 2022 18:58:31 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [RFC PATCH] mm: check global free_list if there is ongoing reclaiming when pcp fail
Date:   Fri, 16 Sep 2022 18:58:12 +0800
Message-ID: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28GAwVml097851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Check the global free list again even if rmqueue_bulk failed for pcp pages when
there is ongoing reclaiming, which could eliminate potential direct reclaim by
chance.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3d..7e99f7d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3729,7 +3729,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
 					gfp_flags, migratetype, alloc_flags);
-			goto out;
+			if (page || !test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
+				goto out;
 		}
 	}
 
-- 
1.9.1

