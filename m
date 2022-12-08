Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF96467A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLHDUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLHDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:20:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93259950E2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 19:20:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 62so149057pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 19:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcP9OjdQ5PW2QxVpoWWahvsYVEkwMxh4TexVWLLeoUg=;
        b=Fbe6IGbTVg8Z358I0mBavqz5hQZDFTyLCdQB+qpde0bt/NhoW7PnsF2vXJdcjroxFc
         8s2rniL+jd42F8Osw4wdLxDXCIQHpYe0d4Q33nkn1od0GwhSzR628sU8CtgHv2GS9Vn2
         vP2RiQ3TCyHKKWbQHHEhEXu6motfc+zzR8saZHBsd1slcHwPJixtt4Fglq+aIRdMCVK8
         bVaPJZ7/bn8RCXlGFoIwOrzb0u7tp5TMSa6pn8V3dSconkcK2DFeI2Fu2GhV0MgLsyAX
         8YK09WmFkF6kvlWGmERYLk68fj/aDS/oq+htYONRMQ9TX2ob6rOlievjctOQ6YsqtpaT
         RFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcP9OjdQ5PW2QxVpoWWahvsYVEkwMxh4TexVWLLeoUg=;
        b=skHhDcR5FIacn0HXWhU8LvG47F/9sHJzdHKq/RpOxet+fhb+FxPmjz/TQeloStLRcZ
         OUpdiB+hzITB/vKaUSschix4tWR+2fF4xapi1X3CSgIMbjJIWUsdOuoOBfjCj3XSNMIl
         gfBbpnrlOpPKOAbm2h3TQ/L4i6IpdXVVTzKJZZavuITyrAYPCgJgaHDK4ztXlTgQorS+
         /prMSeeT/tAPobKuHWfGRgTWD52KTCDhQCDZULcpmhGuZiPl6M8k74XFqJoJuYjxtJ/1
         8m/Cz2GSVurUTUPaivE07/R67Wn7RSB6hOQ5efCIbhkccsNV4mDO2MZuR1+Y2vYQj+nV
         Vf6w==
X-Gm-Message-State: ANoB5plFavO+8XR0ow+G0+kp0YJUY459oYtsl12zWs4stYP2gxYHYjOI
        E2SGVU233Er7XyP+NR0rvckOGPb5DKkTJXPG
X-Google-Smtp-Source: AA0mqf7Pb9TgDQJkQrs6rsbBvAmaDOHPz8cZASZ/Ji5XkSsNv9G6IxS1zF6xw0Rbc453Rcl8b4LzgQ==
X-Received: by 2002:a63:4861:0:b0:477:4451:d49 with SMTP id x33-20020a634861000000b0047744510d49mr67359469pgk.575.1670469640130;
        Wed, 07 Dec 2022 19:20:40 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id mm13-20020a17090b358d00b00200461cfa99sm1846781pjb.11.2022.12.07.19.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:20:39 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        yu.c.chen@intel.com, Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 2/2] sched/core: Reorganize ttwu_do_wakeup() and ttwu_do_activate()
Date:   Thu,  8 Dec 2022 11:20:07 +0800
Message-Id: <20221208032007.94459-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208032007.94459-1-zhouchengming@bytedance.com>
References: <20221208032007.94459-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttwu_do_activate() is used for a complete wakeup, in which we will
activate_task() and use ttwu_do_wakeup() to mark the task runnable
and perform wakeup-preemption, also call class->task_woken() callback
and update the rq->idle_stamp.

Since ttwu_runnable() is not a complete wakeup, don't need all those
done in ttwu_do_wakeup(), so we can move those to ttwu_do_activate()
to simplify ttwu_do_wakeup(), making it only mark the task runnable
to be reused in ttwu_runnable() and try_to_wake_up().

This patch should not have any functional changes.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60aa7774e5f4..d8216485b0ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3623,14 +3623,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 }
 
 /*
- * Mark the task runnable and perform wakeup-preemption.
+ * Mark the task runnable.
  */
-static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
-			   struct rq_flags *rf)
+static inline void ttwu_do_wakeup(struct task_struct *p)
 {
-	check_preempt_curr(rq, p, wake_flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
+}
+
+static void
+ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
+		 struct rq_flags *rf)
+{
+	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
+
+	lockdep_assert_rq_held(rq);
+
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible--;
+
+#ifdef CONFIG_SMP
+	if (wake_flags & WF_MIGRATED)
+		en_flags |= ENQUEUE_MIGRATED;
+	else
+#endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
+
+	activate_task(rq, p, en_flags);
+	check_preempt_curr(rq, p, wake_flags);
+
+	ttwu_do_wakeup(p);
 
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
@@ -3660,31 +3685,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
-static void
-ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
-		 struct rq_flags *rf)
-{
-	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
-
-	lockdep_assert_rq_held(rq);
-
-	if (p->sched_contributes_to_load)
-		rq->nr_uninterruptible--;
-
-#ifdef CONFIG_SMP
-	if (wake_flags & WF_MIGRATED)
-		en_flags |= ENQUEUE_MIGRATED;
-	else
-#endif
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
-	activate_task(rq, p, en_flags);
-	ttwu_do_wakeup(rq, p, wake_flags, rf);
-}
-
 /*
  * Consider @p being inside a wait loop:
  *
@@ -3726,8 +3726,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 			update_rq_clock(rq);
 			check_preempt_curr(rq, p, wake_flags);
 		}
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4093,8 +4092,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
-- 
2.37.2

