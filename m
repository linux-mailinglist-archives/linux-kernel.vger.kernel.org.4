Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B60ED9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiJ0Byi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiJ0Byd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:54:33 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C3101F2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:54:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666835668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kNJqfms1eRu/a/XyA/vXGP2HAHD0ZQEDTi1N1gMZ+lY=;
        b=JBa0f4qPXeWSmChcJLY9mHnM2Wo6w07mz/Sw5YY1N5I3/op908s3fnUwk4ATIEGg4sS4pV
        zjYUqWUFdLCkGWl00CmzGUub8B9S8sUHtePdl/ab46qxD4K54vhldMycHXSTEWE70jLLE3
        z3D8WzPgnZvYFKHTlGeUXS7/mXy3xc0=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/fair: Remove max_vruntime() and min_vruntime()
Date:   Thu, 27 Oct 2022 09:53:51 +0800
Message-Id: <20221027015351.2511149-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to write max_vruntime() and min_vruntime() functions,
we can use max_t() and min_t() instead.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/fair.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..bba8e0c43d59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -562,24 +562,6 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
 
-static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
-{
-	s64 delta = (s64)(vruntime - max_vruntime);
-	if (delta > 0)
-		max_vruntime = vruntime;
-
-	return max_vruntime;
-}
-
-static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
-{
-	s64 delta = (s64)(vruntime - min_vruntime);
-	if (delta < 0)
-		min_vruntime = vruntime;
-
-	return min_vruntime;
-}
-
 static inline bool entity_before(struct sched_entity *a,
 				struct sched_entity *b)
 {
@@ -609,12 +591,12 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 		if (!curr)
 			vruntime = se->vruntime;
 		else
-			vruntime = min_vruntime(vruntime, se->vruntime);
+			vruntime = min_t(u64, vruntime, se->vruntime);
 	}
 
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
-		      max_vruntime(cfs_rq->min_vruntime, vruntime));
+		      max_t(u64, cfs_rq->min_vruntime, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -4543,7 +4525,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	se->vruntime = max_vruntime(se->vruntime, vruntime);
+	se->vruntime = max_t(u64, se->vruntime, vruntime);
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
-- 
2.25.1

