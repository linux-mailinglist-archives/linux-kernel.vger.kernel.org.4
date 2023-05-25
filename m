Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB1710C74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjEYMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjEYMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:20 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A44183
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSJ3hf_1685019254;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSJ3hf_1685019254)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:15 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: compaction: only set skip flag if cc->no_set_skip_hint is false
Date:   Thu, 25 May 2023 20:53:59 +0800
Message-Id: <0eb2cd2407ffb259ae6e3071e10f70f2d41d0f3e.1685018752.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
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

To keep the same logic as test_and_set_skip(), only set the skip flag
if cc->no_set_skip_hint is false, which makes code more reasonable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e5183f39ca9..65d8d9223acc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1223,7 +1223,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	 * rescanned twice in a row.
 	 */
 	if (low_pfn == end_pfn && (!nr_isolated || cc->finish_pageblock)) {
-		if (valid_page && !skip_updated)
+		if (!cc->no_set_skip_hint && valid_page && !skip_updated)
 			set_pageblock_skip(valid_page);
 		update_cached_migrate(cc, low_pfn);
 	}
-- 
2.27.0

