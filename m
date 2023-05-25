Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2E710C75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbjEYMy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjEYMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:19 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46D183
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSJ3gf_1685019253;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSJ3gf_1685019253)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm: compaction: skip more fully scanned pageblock
Date:   Thu, 25 May 2023 20:53:58 +0800
Message-Id: <f4efd2fa08735794a6d809da3249b6715ba6ad38.1685018752.git.baolin.wang@linux.alibaba.com>
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

In fast_isolate_around(), it assumes the pageblock is fully scanned if
cc->nr_freepages < cc->nr_migratepages after trying to isolate some free
pages, and will set skip flag to avoid scanning in future. However this
can miss setting the skip flag for a fully scanned pageblock (returned
'start_pfn' is equal to 'end_pfn') in the case where cc->nr_freepages
is larger than cc->nr_migratepages.

So using the returned 'start_pfn' from isolate_freepages_block() and
'end_pfn' to decide if a pageblock is fully scanned makes more sense.
It can also cover the case where cc->nr_freepages < cc->nr_migratepages,
which means the 'start_pfn' is usually equal to 'end_pfn' except some
uncommon fatal error occurs after non-strict mode isolation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3737c6591bfb..1e5183f39ca9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1411,7 +1411,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
-	if (cc->nr_freepages < cc->nr_migratepages)
+	if (start_pfn == end_pfn)
 		set_pageblock_skip(page);
 
 	return;
-- 
2.27.0

