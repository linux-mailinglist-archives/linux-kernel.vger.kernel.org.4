Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2475610D69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJ1Jf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1Jf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:35:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500974DF0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6138794wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zy7QY6HAum4eocAiGxC3tA1yZA7zRnpZ3kdrW18hPm0=;
        b=upllvy9LTUqV280SjXJ2vWkMs8B52MyDHu3wt1BBEOT/wKTjagqC5NKp1Hz6fJajxX
         vkGFh+ZvA62iOszfaiWdscrssUfcW5rFJ5RZPNV+8Wu5t37O50sGCJpmLVD7MZjEaZ62
         wpIpVtI5fETI4VozRW96M5B/SMQ+O3eGpfoKbZhj0UX4U+QlyjXReLWKIrHeNk1FxeaT
         Ve+KLnHS1OnClcBRKRrbiGVVIeJV8ItSrMjYOH3nwwpWg2g2i2jPA/F3syL51yHE8Fbl
         qp26yM1IQewXaaOwyNu2TNea6wJSjtFozWYqppGqfFJd3isTrhhmH7ZSz1eSaKugFu9/
         T6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy7QY6HAum4eocAiGxC3tA1yZA7zRnpZ3kdrW18hPm0=;
        b=iCe6V10CcbYcv6WJIQLYWcQd6fQx3D7jCqFVO0jeky3KaprcapxhJ6Qgc1zFHkvQ67
         yaP+zHvLoDzQngox7k+uei3lNnty3Qr3pzyCVq+1tD8hgxxTyY7AjkDipbH8uzKoWMce
         d9mjKDW1gd7tMKN5t8+cgvilGg1JQPBbPsIZI2il5X8UiK8ONsRSNibFlNe2ddDWlgcb
         j/KbBS4ll/jcoTfb5zG3jPn2/n5HhaZMWsI9JGPRcvI3McXeGMmaD2vI7a2n5AMQeCYQ
         1wRrXgeOdAYNXtW5v9xho1E/y5i1tfAoiuHI4kgORa73qbqhaubrfvAhSUOHWE5AMOmo
         YrrA==
X-Gm-Message-State: ACrzQf0uxYYXh8g6eXzpLlmTgWJqoG8xvUB3UYHcsbzyzMQLGq4ZumHK
        e/8Rf+qLdm1wxTkVsBFka1835Q==
X-Google-Smtp-Source: AMsMyM7JEy9QidFj4K5IIHRD8gxTQ077sLRBL+QBQiZlZmZ0NNIcOHc+o1KMeXa33xJW97w5ToIhkg==
X-Received: by 2002:a5d:42c6:0:b0:235:1b3a:8d2e with SMTP id t6-20020a5d42c6000000b002351b3a8d2emr28693512wrr.689.1666949714514;
        Fri, 28 Oct 2022 02:35:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:35:13 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 9/9] sched/fair: remove check_preempt_from_others
Date:   Fri, 28 Oct 2022 11:34:03 +0200
Message-Id: <20221028093403.6673-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028093403.6673-1-vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
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
index c28992b7d1a6..9a421b49dbfd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5802,35 +5802,6 @@ static int sched_idle_cpu(int cpu)
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
@@ -5917,15 +5888,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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

