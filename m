Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB66699E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjAMOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbjAMONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11559687BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so11975715wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfA7fOK3LCcmN6R2CxD4VildndRtCjudzidz68b+vdE=;
        b=fO5NzU8X5twvuoxI8ACLZI8Gu+yGI2YSIMh067qxr7DL8dFlZI5g+mHS2UiYb3j4to
         viZ2CnpjxEKrL4kusySj8Ic40GZF0LCq6Pid4UYvGWpYSlfZG3oDxZMImm0B0G/GpiaG
         +jZNS0FPJfq1VMX4bBosB3QxN3Uu+giZgBLYATIUEDdo3b5Zo+EYbPhB8lqESdE6UhEF
         3sBoCYdB68/uJ7bLSp6cFBWw+8VO5THrtEPNMT2PIq8tCHB+0A24FKS+30Kp1NY3pW6c
         3pxx1WaKh3wiEW0dHOvJhV7cLSmKPwk9PSPtYeI1T3EH1zPMSYWrY+l5SHSQrsvI2htA
         /ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfA7fOK3LCcmN6R2CxD4VildndRtCjudzidz68b+vdE=;
        b=a+p1UVd2gcQ6Q5jcGofkRAowPGtQCsxVk/aoF+hzw34Wjzmqf2UERF1LJwrF0Y7OqK
         w0ohXo20f8HN4Y2vBdDUZt7/clAhE02dJ/2t5z0o0tAeP4CTPD1CCk7dwqAw1ISSqev/
         Uvb5Ym5fkp19J6hxetXMIaA0Bp+9jrhPAeot4w0pRib7o+anHG6GQxAzXw1BghVkB5Mo
         1UxAvDOOJcnCdaGGdgD12DYBs+ybLkXs2c6QVm3jzwIQGZlRjSnOzjwNgFWABkug7Fdz
         p7+K7ZchXT+4oCZr5JCjHS4ucgJS3m5q01n5/Jg5l6ZmSQuEBVpmeuECemdSwygqbutO
         O15w==
X-Gm-Message-State: AFqh2krQTqsOSN7T9NICFjMDNbPb8Kbb82vmjE/pciBQGjksgHJN5J3P
        4Xpl8regNeXQx2KDt0Q4XzqbhA==
X-Google-Smtp-Source: AMrXdXt8zsIpuEkpxLQRExZJ6xt5328moIhVjqal/WnZQOovbnt2aN+Ev3S+ae1amiTke6izdm5bVg==
X-Received: by 2002:a05:6000:806:b0:293:1868:3a14 with SMTP id bt6-20020a056000080600b0029318683a14mr32347854wrb.0.1673619173276;
        Fri, 13 Jan 2023 06:12:53 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:51 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 9/9] sched/fair: remove check_preempt_from_others
Date:   Fri, 13 Jan 2023 15:12:34 +0100
Message-Id: <20230113141234.260128-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the dedicated latency list, we don't have to take care of this special
case anymore as pick_next_entity checks for a runnable latency sensitive
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8f0e32431e2..fb2a5b2e3440 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6240,35 +6240,6 @@ static int sched_idle_cpu(int cpu)
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
@@ -6355,15 +6326,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
2.34.1

