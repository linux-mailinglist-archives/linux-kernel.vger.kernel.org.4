Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28594710C79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbjEYMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjEYMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:22 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FB3189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSJ3iS_1685019256;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSJ3iS_1685019256)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:17 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: compaction: skip fast freepages isolation if enough freepages are isolated
Date:   Thu, 25 May 2023 20:54:01 +0800
Message-Id: <f39c2c07f2dba2732fd9c0843572e5bef96f7f67.1685018752.git.baolin.wang@linux.alibaba.com>
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

I've observed that fast isolation often isolates more pages than
cc->migratepages, and the excess freepages will be released back to the
buddy system. So skip fast freepages isolation if enough freepages are
isolated to save some CPU cycles.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index eccec84dae82..3ade4c095ed2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1550,6 +1550,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+		/* Skip fast search if enough freepages isolated */
+		if (cc->nr_freepages >= cc->nr_migratepages)
+			break;
+
 		/*
 		 * Smaller scan on next order so the total scan is related
 		 * to freelist_scan_limit.
-- 
2.27.0

