Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AAC69CB36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjBTMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjBTMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A921C32E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B88ECB80D1D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ABAC433D2;
        Mon, 20 Feb 2023 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896905;
        bh=5sxyMTW09Kl3ct1nkcDaj+gcruIUS7UwkGWllRn6QWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhSXVcdgC6xEPlUxPKP49VgnejEr9wrqf4dGce43aXAn2W68mjRZi3Z51o58oLw0i
         ePRSOGz/OIswWofrZXxN5RNZi8lt7FAaefHaTsu+kZqp7MJ7knumFmhcvnI1B7jizk
         2IlEOtdEArdBjsbsSbD9jhCo6PUBKB6X2iJT8Cp5TkT3BnDFydel2Vmt5C04p4+Rzj
         Vk9l5bbyYT0G0tLK8Oj4H889QtilvdxjzAydXpb3FLJE8MDHGxxcVlFRcRV2D5ZdgB
         nN03UHuOd9HOj6Y6rblB1FNd9+5h2p/qeymTk61SmAmYDpu+WCOQ7DGrgO1SJRTvJ5
         8a97N3yOdP4Hg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/7] timers/nohz: Protect idle/iowait sleep time under seqcount
Date:   Mon, 20 Feb 2023 13:41:25 +0100
Message-Id: <20230220124129.519477-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220124129.519477-1-frederic@kernel.org>
References: <20230220124129.519477-1-frederic@kernel.org>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 22 ++++++++++++++++------
 kernel/time/tick-sched.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9058b9eb8bc1..90d9b7b29875 100644
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
 
@@ -668,6 +673,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 				 bool compute_delta, u64 *last_update_time)
 {
 	ktime_t now, idle;
+	unsigned int seq;
 
 	if (!tick_nohz_active)
 		return -1;
@@ -676,13 +682,17 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
 
-	if (ts->idle_active && compute_delta) {
-		ktime_t delta = ktime_sub(now, ts->idle_entrytime);
+	do {
+		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
-		idle = ktime_add(*sleeptime, delta);
-	} else {
-		idle = *sleeptime;
-	}
+		if (ts->idle_active && compute_delta) {
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

