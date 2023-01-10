Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FB664208
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjAJNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjAJNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:35 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD545BDB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:36:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZJNexU_1673357789;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZJNexU_1673357789)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 21:36:30 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: compaction: Add missing kcompactd wakeup trace event
Date:   Tue, 10 Jan 2023 21:36:21 +0800
Message-Id: <cbf8097a2d8a1b6800991f2a21575550d3613ce6.1673342761.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kcompactd wakeup trace event for proactive compaction, meanwhile
use order = -1 and the highest zone index of the pgdat for the kcompactd wakeup
trace event by proactive compaction.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 62f6bb68c9cb..0fd6c81a7809 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2730,6 +2730,8 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 				continue;
 
 			pgdat->proactive_compact_trigger = true;
+			trace_mm_compaction_wakeup_kcompactd(pgdat->node_id, -1,
+							     pgdat->nr_zones - 1);
 			wake_up_interruptible(&pgdat->kcompactd_wait);
 		}
 	}
-- 
2.27.0

