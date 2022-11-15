Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7761462A025
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiKORUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiKORTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7115FED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o30so10127105wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEkS8i7tIYgboxjzKf+DHpXTxKISIyLo6Edt1lmPKQc=;
        b=tjPVju3AGCAvlDVjVG5Z3kU1qxXIcz4EbJ0YzmvnkyOM7QTzLHV3iZYpxiagmelITC
         RUX9pdeixkhk28fIEsDi+xcAYl7tscemdKuB+0CmrUkUfJBqBlf14kJA9O7/a8rBmn6S
         anVdPmczbtuQdG6+ISMYeeKN1oryogoGOkp5fPkGdF8/aomsS7V06TASBJOCTlQF4mF7
         Y0slf3EhfAOB0zrTflVJ059oEIg5lMN3mzRXf1pzYdJtKSzS5A4JRZjt9p6k5SQ/SSI9
         nvJXS7i/byjVk6tvOP27i/U/WAWgOpcvFuWx04Vflp3sOXjv+BpjKrO4ISCC3zxbsMtq
         BFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEkS8i7tIYgboxjzKf+DHpXTxKISIyLo6Edt1lmPKQc=;
        b=jfScwWNJu9AzM7hyj5DM+Kg4JjP5gBviDTS+UmonSLDAA2l2wpjKljvOqqMKcinODw
         2DWfMy49F5BqXxPgN/1ZtZlW1mQf/qTF6+p034Mhd6z9Xt9XcNEjQqloYI3EAZJJspba
         pOQjFQvYUjmg2YN0x4bjDKaKEmthFGGCvY2nr0KzqyB2T6nrmMOKNaiFOqmql4pvFtJJ
         HD4KTO3rUSdCkO3VHj4rk2ya40tItpiaA61vkEWsjwZjz+PJMX/+OoAUvHTVvY6HTsmQ
         F7bv9U3ql2F2oDvb7ILkc+QipIEhjgcmRnyaZ0/m6tPvOCLpPpDYfkxlHAHGryV/8iI0
         PL4A==
X-Gm-Message-State: ANoB5plky/6mu2p1BjPyb3TNEFkcZv6FdJ1MUAl1tW1BZvNToiwc8kvl
        W/sbzIb4xsF0OjsUYwswXFIFWA==
X-Google-Smtp-Source: AA0mqf56oiRJLB1/ENBsh2USqP12nfyAUKMi4mypykD5SYdXWWlCTpr/D+II/BPeJxEPQwKqWhLC6Q==
X-Received: by 2002:a05:600c:42c6:b0:3cf:6b14:1033 with SMTP id j6-20020a05600c42c600b003cf6b141033mr2302248wme.103.1668532757749;
        Tue, 15 Nov 2022 09:19:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:16 -0800 (PST)
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
Subject: [PATCH v9 9/9] sched/fair: remove check_preempt_from_others
Date:   Tue, 15 Nov 2022 18:18:51 +0100
Message-Id: <20221115171851.835-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
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
index 76da7c7a13ab..466a2fee1592 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6104,35 +6104,6 @@ static int sched_idle_cpu(int cpu)
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
@@ -6219,15 +6190,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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

