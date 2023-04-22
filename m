Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF226EB7E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDVHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDVHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:43:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12F1BDC;
        Sat, 22 Apr 2023 00:43:25 -0700 (PDT)
Date:   Sat, 22 Apr 2023 07:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682149403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uYmE+OYmLfZ9Q+2puf8qmOrqk2xlXYlmhLyrRyCtFIY=;
        b=HP11bTZbXuDDqpHk+jfsAc/Ftd6tf9oPPS3dkpDaDaPCqVD0UB1vCBJoKmE5bchL2ZnjBf
        LiK9i8i8Xd6vuRIyiowIQWRF2Cv3hFZ+NOhOaGA3T9G1wJGLdxE4arHuzKKy2yZmWwUn/T
        imP9PnVYGqbX5Oq8i3cn4zAOjm/ghkkI28707OgGQ+pnUCmUMGjCtELm937mfS2os0cQRn
        Jw9ZDBPeJmR9zcXRvxqbPUAFJ5Ot+k3TgN3JNzYH+RezBPNyMhTKNi6N7azb0xFptJqUQx
        DkGXMmIMVmn05NyDDzjtZRapaS020YWIpyzqiNPGlv1quk12Gyd2utudB0uNyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682149403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uYmE+OYmLfZ9Q+2puf8qmOrqk2xlXYlmhLyrRyCtFIY=;
        b=ypspptsciRWVhdXfhGRc7qJAHZ5mHdiTGzSU4Oo9M5PL5dYu4PxWhrvb8XZ7KsKtr+Ag6m
        2uZOeVIbvH/dDYBg==
From:   "tip-bot2 for Schspa Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Fix bad task migration for rt tasks
Cc:     Schspa Shi <schspa@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dwaine Gonyier <dgonyier@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168214940317.404.10361238709723841210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     feffe5bb274dd3442080ef0e4053746091878799
Gitweb:        https://git.kernel.org/tip/feffe5bb274dd3442080ef0e4053746091878799
Author:        Schspa Shi <schspa@gmail.com>
AuthorDate:    Mon, 29 Aug 2022 01:03:02 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Apr 2023 13:24:21 +02:00

sched/rt: Fix bad task migration for rt tasks

Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
allows find_lock_lowest_rq() to pick a task with migration disabled.
The purpose of the commit is to push the current running task on the
CPU that has the migrate_disable() task away.

However, there is a race which allows a migrate_disable() task to be
migrated. Consider:

  CPU0                                    CPU1
  push_rt_task
    check is_migration_disabled(next_task)

                                          task not running and
                                          migration_disabled == 0

    find_lock_lowest_rq(next_task, rq);
      _double_lock_balance(this_rq, busiest);
        raw_spin_rq_unlock(this_rq);
        double_rq_lock(this_rq, busiest);
          <<wait for busiest rq>>
                                              <wakeup>
                                          task become running
                                          migrate_disable();
                                            <context out>
    deactivate_task(rq, next_task, 0);
    set_task_cpu(next_task, lowest_rq->cpu);
      WARN_ON_ONCE(is_migration_disabled(p));

Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
Signed-off-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Dwaine Gonyier <dgonyier@redhat.com>
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/rt.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4cc7e1c..5a9a4b8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2246,6 +2246,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_on_cpu(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9d67dfb..00e0e50 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2000,11 +2000,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_on_cpu(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
