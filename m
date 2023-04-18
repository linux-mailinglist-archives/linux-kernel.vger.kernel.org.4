Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E26E6792
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjDROxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjDROxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E7AD2A;
        Tue, 18 Apr 2023 07:53:34 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85JUodLV7EWbfM40Ibp7CaeedStOFvRsNIpu1aewYc8=;
        b=I6icHYbzw2mps60pQHWVw8tMzY4WON367lA/CRcH0QySPd+rrEVIed/4wd7Yc1tsBWzRxL
        xKCMr9U/Zl5jRMBXwPt+0IpQ508Gue3JQJUDTCNR8ysPOl40bmVVr6CDWBGq8jQaJp1L3/
        I1MoOBK2YLX/ptTo1NB4S2WfL0X+ZX13NSCNvvp5qEa3RP/vDdOyrdYDHYbpoxILB/TVKa
        UfSRDWEwpCuXoci9euzX0c1R9Q7crrENG39dk5hlEvQAqE0dPdbidkaXjCu8lWhsQSunKt
        1bVujyqJ30KJNk3as8NAPspKRc6/93wF5lA6Je4F0q0Sk8ew6N5bimjDA23M4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85JUodLV7EWbfM40Ibp7CaeedStOFvRsNIpu1aewYc8=;
        b=EL6BD7hTdtHDDXqVWIt5OcTVTDYsvmgYWYYGKoN/sVXsEaFr309AGyLA28k0cN9JMgWOrQ
        ojYe89l3gYH+59Cg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Protect idle/iowait sleep time under seqcount
Cc:     Yu Liao <liaoyu15@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-4-frederic@kernel.org>
References: <20230222144649.624380-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960967.404.10362810597852537883.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     620a30fa0bd14878891b22bf2261e6ed4587c2b4
Gitweb:        https://git.kernel.org/tip/620a30fa0bd14878891b22bf2261e6ed4587c2b4
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

timers/nohz: Protect idle/iowait sleep time under seqcount

Reading idle/IO sleep time (eg: from /proc/stat) can race with idle exit
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-4-frederic@kernel.org

---
 kernel/time/tick-sched.c | 22 ++++++++++++++++------
 kernel/time/tick-sched.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9058b9e..90d9b7b 100644
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
index c666325..5ed5a9d 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -75,6 +75,7 @@ struct tick_sched {
 	ktime_t				idle_waketime;
 
 	/* Idle entry */
+	seqcount_t			idle_sleeptime_seq;
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
