Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA707773
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjERBen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjERBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:34:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D535BF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:34:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561abf855afso15762157b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684373677; x=1686965677;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCkOGnN5VV+G0vc4oBgEXNSPP/cS4uflXB2VdW0nTDc=;
        b=LV9SKqc9LLji/8d1D1nfFc5i5jRcnJLn+AfdqPiE8q/ZsW+08nHc91HNb4jIFg5d6H
         jgdmF4AsVk+sjFNbe6dNmj/yjWzAvlQoPbqzFzG1yAFkYJTm0tSE4JRPp2pkAbpk8Yzl
         sMwx5yX3xjLDUYEbTRyn1YgUs8/4CyPkDnd5i1xEg8U1TP4klX+n1KZZQP7nQ2rdYwLc
         sIkYfAezE/CJwAl1KHldUuPcIRJf1cXLC5Q2taC1S6LpVTa83YOcpVTVkwZz0l9o+njR
         AndVecG6UkuOC+ZGe3GQEYiXzhMOPnOp8lV1m5u//s0N+M6h7dNTW4jeFc87BXnBz6yA
         wdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684373677; x=1686965677;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCkOGnN5VV+G0vc4oBgEXNSPP/cS4uflXB2VdW0nTDc=;
        b=kI2c7SMIZzfwqPmR1IvP9sLx9OjG7I36bndLiZYyyZmizg4EVb+nPLEv6WsdFxvCby
         2u0futUAKUR+Vw3zqLXa+xcklGQhc7SWNfikNEZEmvv36kYS+61p11AtjgDgczNK8u4i
         mJSoRWOFbdUaSB4s2VSrBH6gNACylgfimXR4mBEvHUQc1OVIGQmlUwNqp2i+AJE9F30/
         vnojCtHPGxNve1D+Gg1u+n6dE2tRgkdu1qJ47SvhtQJZNr+hNrq+0YHLvwoxV6qUpQWh
         VY0C0wjPuCVD0rEEztrbZcj3uQBO12lKgK4AFniuesgBPBqEZEYywQZJhBS4bptdpeQ1
         t77g==
X-Gm-Message-State: AC+VfDymT0+9j45GWoX+Pp3CO1nzeVenvhvKWCyC30WQT8Oifqt7+BBj
        fJLd05gyyATQATsB0LwJ6xCX1PY4/T78
X-Google-Smtp-Source: ACHHUZ7bt+f8QxiXT175fsmY0EafL/QKka7Iiv4NmviqHBc91VEF3Nr1poC2wkO2htPa01YTPdqIgEIVw4tT
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:53e2:12a7:c986:1d79])
 (user=joshdon job=sendgmr) by 2002:a81:ae64:0:b0:561:2d82:7f08 with SMTP id
 g36-20020a81ae64000000b005612d827f08mr131225ywk.0.1684373676864; Wed, 17 May
 2023 18:34:36 -0700 (PDT)
Date:   Wed, 17 May 2023 18:34:13 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230518013414.3053254-1-joshdon@google.com>
Subject: [PATCH 1/2] sched: don't account throttle time for empty groups
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easy for a cfs_rq to become throttled even when it has no enqueued
entities (for example, if we have just put_prev()'d the last runnable
task of the cfs_rq, and the cfs_rq is out of quota).

Avoid accounting this time towards total throttle time, since it
otherwise falsely inflates the stats.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4b8b906d30a..85c2c0c3cab6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4768,6 +4768,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
 	bool curr = cfs_rq->curr == se;
+	struct rq *rq = rq_of(cfs_rq);
 
 	/*
 	 * If we're the current task, we must renormalise before calling
@@ -4816,8 +4817,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
+		} else {
+			if (!cfs_rq->throttled_clock)
+				cfs_rq->throttled_clock = rq_clock(rq);
+		}
 	}
 }
 
@@ -5423,7 +5428,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -5441,7 +5448,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
-	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+	if (cfs_rq->throttled_clock) {
+		cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+		cfs_rq->throttled_clock = 0;
+	}
 	list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
-- 
2.40.1.606.ga4b1b128d6-goog

