Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3B664209
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjAJNg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjAJNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:37 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD776C41
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:36:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZJNexH_1673357788;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZJNexH_1673357788)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 21:36:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: compaction: Count the migration scanned pages events for proactive compaction
Date:   Tue, 10 Jan 2023 21:36:20 +0800
Message-Id: <b7f1ece1adc17defa47e3667b5f9fd61f496517a.1673342761.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
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

The proactive compaction will reuse per-node kcompactd threads, so we
should also count the KCOMPACTD_MIGRATE_SCANNED and KCOMPACTD_FREE_SCANNED
events for proactive compaction.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index f8e8addc8664..62f6bb68c9cb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2659,6 +2659,11 @@ static void proactive_compact_node(pg_data_t *pgdat)
 		cc.zone = zone;
 
 		compact_zone(&cc, NULL);
+
+		count_compact_events(KCOMPACTD_MIGRATE_SCANNED,
+				     cc.total_migrate_scanned);
+		count_compact_events(KCOMPACTD_FREE_SCANNED,
+				     cc.total_free_scanned);
 	}
 }
 
-- 
2.27.0

