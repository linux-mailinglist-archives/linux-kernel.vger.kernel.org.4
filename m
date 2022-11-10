Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160986248A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKJRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiKJRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E24B9A4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so3337746wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eKRDIrK6+9JpxczLCDYf+I+TauedG4U/HEai4Cf8rvo=;
        b=cai+412mPBIM/ZU05LnrpGJuBoUbQunUn+PqMS7ewH09C41D7pj4tPDKTiMzWcjVPt
         pxlV3Rs2lT0I4VGRLZdYdHxEKOVWY1SV/Hp8tFBqOZnMOcTXIXiRGw16ooPxkxeGn1Cf
         AdZQ0TmPKk3NAiFU8QU6PB5tms2YbQyUKyV7BY5HLibiiiiT19kwmGapDL3fBTSPgTvP
         WZGIZvZiA8q7ovYLCGtWjjjVj/Cep8vzhSAAynNdz5yEQJOPma/acfgYk47KeOqpe4Zs
         99qsBxxVIL5kCLDsXXxkjLxo2se2TrsrkQKD04e7jheo1vC+QzG2Z55YyXiviDx3+D/f
         fjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKRDIrK6+9JpxczLCDYf+I+TauedG4U/HEai4Cf8rvo=;
        b=CQ/o1scj8AZ0MPi/znrYv3yrSNM1kF3J3Qsen5a9G1+GAy9Jyp62xn9Mn5OphtIJ3N
         D/7T4Arc3ECBgiLiYlEswfXwujRfdH+FwofYzhdFGjNuJnv9xxTc2fP0RfIC353fcBbK
         2nmCKWLvARVNs4mm0rglbthSbtFEnbCKyuUW/irZWzYgd6xiQMQZBMYD7Og4jQrSClez
         kwg+rGTgiQrm8qkshoJphl7UGje6wQGJ7PVO5aFS7CJotr0ZJdz6FilxqCtgBw/COpdH
         Zbp9EQHFwD/1XSwqQfR0imIejzacTYiXgqhaa8Pai+C8f2Lae34KV0fCt+8qe6pyktHw
         54pg==
X-Gm-Message-State: ACrzQf2vRo2dHYGZaQiBEvrZVJ5q6cF3Mzbjz1RvhZzw/+CK1DciGof0
        hdO+20lcVyj795D9oeJqcg53UA==
X-Google-Smtp-Source: AMsMyM5IGRbkNN+AthkzYdgiG2JQjHzQp/HS6uoAnf4UivVS8Og33/kMW4SAboqWUahi2YHoXcTZLw==
X-Received: by 2002:adf:f84c:0:b0:236:6e52:504 with SMTP id d12-20020adff84c000000b002366e520504mr40614748wrq.564.1668102635719;
        Thu, 10 Nov 2022 09:50:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v8 9/9] sched/fair: remove check_preempt_from_others
Date:   Thu, 10 Nov 2022 18:50:09 +0100
Message-Id: <20221110175009.18458-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the dedicated latency list, we don't have to take care of this special
case anymore as pick_next_entity checks for a runnable latency sensitive
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb4973a87f25..c2c75d531612 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5801,35 +5801,6 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
-static void set_next_buddy(struct sched_entity *se);
-
-static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
-{
-	struct sched_entity *next;
-
-	if (se->latency_offset >= 0)
-		return;
-
-	if (cfs->nr_running <= 1)
-		return;
-	/*
-	 * When waking from another class, we don't need to check to preempt at
-	 * wakeup and don't set next buddy as a candidate for being picked in
-	 * priority.
-	 * In case of simultaneous wakeup when current is another class, the
-	 * latency sensitive tasks lost opportunity to preempt non sensitive
-	 * tasks which woke up simultaneously.
-	 */
-
-	if (cfs->next)
-		next = cfs->next;
-	else
-		next = __pick_first_entity(cfs);
-
-	if (next && wakeup_preempt_entity(next, se) == 1)
-		set_next_buddy(se);
-}
-
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5916,15 +5887,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
-	if (rq->curr->sched_class != &fair_sched_class)
-		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
-
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
 
+static void set_next_buddy(struct sched_entity *se);
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
-- 
2.17.1

