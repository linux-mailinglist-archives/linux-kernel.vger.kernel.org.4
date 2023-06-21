Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90145737CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFUHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjFUHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:39:58 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62C3E170D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:39:30 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:48856.2131214271
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id A2234280099;
        Wed, 21 Jun 2023 15:39:22 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by app0025 with ESMTP id 7601d43524a14bd38a38d662434cb33b for akpm@linux-foundation.org;
        Wed, 21 Jun 2023 15:39:25 CST
X-Transaction-ID: 7601d43524a14bd38a38d662434cb33b
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liuq <liuq131@chinatelecom.cn>
Subject: [PATCH v2] mm/min_free_kbytes: modify min_free_kbytes calculation rules
Date:   Wed, 21 Jun 2023 15:39:12 +0800
Message-Id: <20230621073912.21747-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current calculation of min_free_kbytes only uses ZONE_DMA and
ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
will also divide part of min_free_kbytes.This will cause the min
watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.

__GFP_HIGH and PF_MEMALLOC allocations usually don't need moveable
zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
value in __setup_per_zone_wmarks.

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..608384712a89 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6364,7 +6364,7 @@ static void __setup_per_zone_wmarks(void)
 
 	/* Calculate total number of !ZONE_HIGHMEM pages */
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_highmem(zone) || zone_idx(zone) != ZONE_MOVABLE)
 			lowmem_pages += zone_managed_pages(zone);
 	}
 
@@ -6374,7 +6374,7 @@ static void __setup_per_zone_wmarks(void)
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
 		do_div(tmp, lowmem_pages);
-		if (is_highmem(zone)) {
+		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
 			 * need highmem pages, so cap pages_min to a small
-- 
2.27.0

