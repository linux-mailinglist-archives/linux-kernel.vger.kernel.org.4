Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E601660E17
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjAGKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BB1AD9F;
        Sat,  7 Jan 2023 02:53:02 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0hbxGvGjMIjbt4FTfD3Ps6daJ72yuL+fgskg9oAX1U=;
        b=H6YqhTbd/u28DWwnVjmhCSi9Vu78Zaqc6moAxlAM3gcAedZ6t9gexZOlDKFhZI9rpSnscL
        3P/d4rcB7k4E4va1Z2Pz8jQzlf94nj+FaeqP2J4wMXs8titnxLlDejVgG/kHXR/ThxpRMT
        uyIcb3PPo+FaiTDBb/GQb8anrInNkQ3GPxCheDmfrwW1GrRuu4NlkdtWlJ+Qb7KC/BGFfr
        LLuGiKXmMUyEYS3N7mp7RvGy2GjnMrNt0Bi6tmE+26GZJHBb/ud8gxfqlFLOPqjtUukdaw
        eiGeKD/A5KV4zAVKWCOFxAdXy3YSXLxKQASNRIb4Pf81hNs86OxeB357pZHN/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0hbxGvGjMIjbt4FTfD3Ps6daJ72yuL+fgskg9oAX1U=;
        b=MjyibKepqwBhBAagsbJWCGA3udE36swVvZSwHyzJeQpsA2Y4ieR+FebWlSUkxkQdGU+Kpa
        eVMv7I6hnzM2OECQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Micro-optimize ttwu_runnable()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221223103257.4962-1-zhouchengming@bytedance.com>
References: <20221223103257.4962-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <167308878060.4906.15196822670119776065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     efe09385864f3441c71711f91e621992f9423c01
Gitweb:        https://git.kernel.org/tip/efe09385864f3441c71711f91e621992f9423c01
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 23 Dec 2022 18:32:56 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 10:48:38 +01:00

sched/core: Micro-optimize ttwu_runnable()

ttwu_runnable() is used as a fast wakeup path when the wakee task
is running on CPU or runnable on RQ, in both cases we can just
set its state to TASK_RUNNING to prevent a sleep.

If the wakee task is on_cpu running, we don't need to update_rq_clock()
or check_preempt_curr().

But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
the task got to schedule() and the task been preempted), we should
check_preempt_curr() to see if it can preempt the current running.

This also removes the class->task_woken() callback from ttwu_runnable(),
which wasn't required per the RT/DL implementations: any required push
operation would have been queued during class->set_next_task() when p
got preempted.

ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
the rq cannot be idle in this scenario.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20221223103257.4962-1-zhouchengming@bytedance.com
---
 kernel/sched/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f99ee69..255a318 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3720,9 +3720,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		if (!task_on_cpu(rq, p)) {
+			/*
+			 * When on_rq && !on_cpu the task is preempted, see if
+			 * it should preempt the task that is current now.
+			 */
+			update_rq_clock(rq);
+			check_preempt_curr(rq, p, wake_flags);
+		}
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		trace_sched_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
