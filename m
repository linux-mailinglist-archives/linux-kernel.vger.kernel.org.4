Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF68B643ED9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiLFIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiLFIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:37:54 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC01CFF3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:37:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670315835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rziPuY01KKfy8j2XSe8zzbR1uYlLxhOS82Ju9DQEie0=;
        b=nryMVGmkL9uPJ4ZdK9rNDqaeTLYy6XSqxo0F+d8J7kJCWgeipUNGXsAeIrK6/AAzMZI/eC
        PIezq6NB2SNo9csOCLKnw5Vo1klZDYo2pnceZPAIH3Pn8CveAR5enFGYhgFEKzc+U5aqJL
        /7JGkyTJS8DWJm3ts4yWwbq6hs9/lTA=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: Add pid and comm when RT throttling activated
Date:   Tue,  6 Dec 2022 16:36:41 +0800
Message-Id: <20221206083641.103832-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is difficult to know which process consumes time when RT throttling
activated.

So add pid and comm for this case.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..1f267ab1b59a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1012,6 +1012,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 
 	if (rt_rq->rt_time > runtime) {
 		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
+		struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
 
 		/*
 		 * Don't actually throttle groups that have no runtime assigned
@@ -1019,7 +1020,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
+			printk_deferred_once("pid: %d, comm: %s, sched: RT throttling activated\n",
+					     curr->pid, curr->comm);
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
-- 
2.25.1

