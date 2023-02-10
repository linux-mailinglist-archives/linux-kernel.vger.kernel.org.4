Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490F369208A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBJOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjBJOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4A7407D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:09:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 436CFB8251D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9E2C4339B;
        Fri, 10 Feb 2023 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038172;
        bh=uGFctYYXWtKjvXXubFVYxBpGfYhc7n33Hu43EUXs6NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G10o5gZnxPa9cdACbV9apoHHnkc6ZHxJPdHxwQyzqZzTKAf+d+shez4QNAGy6KrIa
         CABaCi4TORQERtSoPhOwdxg0h+WjfP8bcnrRe/XTGogYvOKeIkUphZRK42U0XpUrS6
         ARilPOTRz1SGmDemN2WkSiLZ35EOwDfJ8EuGkf++OIg8WITUhoR+GEQfxPaitd2OoE
         nkPvWt7Cn/7dXQBs7GFd6SWMaCCuk0IikYF8/YrcHr1WraLSkn75m1+ftkhdEN5Cvi
         o5vkTR/Z4ZFv7ndvVTLxIX1YTjTSVFmTq/EqNK9FdXZXeoztCcLFBaCW9YneBZ+z+9
         N726M+2CSpEaA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/6] timers/nohz: Protect idle/iowait sleep time under seqcount
Date:   Fri, 10 Feb 2023 15:09:14 +0100
Message-Id: <20230210140917.279062-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210140917.279062-1-frederic@kernel.org>
References: <20230210140917.279062-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading idle/io sleep time (eg: from /proc/stat) can race with idle exit
updates because the state machine handling the stats is not atomic and
requires a coherent read batch.

As a result reading the sleep time may report irrelevant or backward
values.

Fix this with protecting the simple state machine within a seqcount.
This is expected to be cheap enough not to add measurable performance
impact on the idle path.

Note this only fixes reader VS writer condition partitially. A race
remains that involves remote updates of the CPU iowait task counter. It
can hardly be fixed.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 22 ++++++++++++++++------
 kernel/time/tick-sched.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index db22342f8948..757e03ef4409 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -646,6 +646,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 
 	delta = ktime_sub(now, ts->idle_entrytime);
 
+	write_seqcount_begin(&ts->idle_sleeptime_seq);
 	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 	else
@@ -653,14 +654,18 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 
 	ts->idle_entrytime = now;
 	ts->idle_active = 0;
+	write_seqcount_end(&ts->idle_sleeptime_seq);
 
 	sched_clock_idle_wakeup_event();
 }
 
 static void tick_nohz_start_idle(struct tick_sched *ts)
 {
+	write_seqcount_begin(&ts->idle_sleeptime_seq);
 	ts->idle_entrytime = ktime_get();
 	ts->idle_active = 1;
+	write_seqcount_end(&ts->idle_sleeptime_seq);
+
 	sched_clock_idle_sleep_event();
 }
 
@@ -669,6 +674,7 @@ static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t now, idle;
+	unsigned int seq;
 
 	if (!tick_nohz_active)
 		return -1;
@@ -677,13 +683,17 @@ static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
 
-	if (ts->idle_active && !nr_iowait_cpu(cpu)) {
-		ktime_t delta = ktime_sub(now, ts->idle_entrytime);
+	do {
+		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
-		idle = ktime_add(*sleeptime, delta);
-	} else {
-		idle = *sleeptime;
-	}
+		if (ts->idle_active && !nr_iowait_cpu(cpu)) {
+			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
+
+			idle = ktime_add(*sleeptime, delta);
+		} else {
+			idle = *sleeptime;
+		}
+	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
 
 	return ktime_to_us(idle);
 
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index c6663254d17d..5ed5a9d41d5a 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -75,6 +75,7 @@ struct tick_sched {
 	ktime_t				idle_waketime;
 
 	/* Idle entry */
+	seqcount_t			idle_sleeptime_seq;
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
-- 
2.34.1

