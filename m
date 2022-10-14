Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7115FECDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJNLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:06:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADD1C070E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:06:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so4420382pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8rrb0dIdxRXVtBDep018CGKylrrSx+6WKik+dpTnrg=;
        b=tAkhsaleBM6ZKTkMtezIIfX0dGFCE9+qmYeMmP4eug81g70YX5jrUC09V3nvUypq+p
         kx9kRd+fYDO48JK7uhrELEo4qlrzqk5otILF1jtbXI5UuDf0gb2YyNijSfEPNGsidmoY
         UE0t1fdOPlvkJOjSo5iDm40XNid8BqVL5h597urdeEjKjj2DpCdDuSQUjD79kRYjtCyA
         NSKuFaYaZ7AaUWZ5BpyocVNz7wOESngLVfGVmSx9A4dW6Hg8F0eQdRPHyWveImYybVeZ
         qLSOSj6e4ETDrXgMMbdgEBDTTFqMogwxknISg4lp5dgd42Zpg06FCm4excGWC0n9s+Gs
         JyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8rrb0dIdxRXVtBDep018CGKylrrSx+6WKik+dpTnrg=;
        b=feTVqEOBHAnD8tj3vWNADBZjtRCTBUxG0lH1on0YzduvlkKY4TuKjlFVC0BoT5hMVz
         lPyuXP8/g0YI4W/ZwYVDGdV/21SrgvfMWR26SeaIYY/oQJD95gE2lXvj2ulWfRZnqlxc
         gu6a910RD26NrFUGWQyHJoXOeO+tcQug3a1MkrKCLXZRdgngClgYGvRVobIvC2s3udEW
         Fp0aShq4mL0QCrQefZ3bdtHoQK8AiJEv9oNU7QZAcAUW508JaEDo85fuCGivcSglBbO8
         7fUuLYJPSTvKoE2XBSqnJl1pNY7/MaWJH9nqBamMLUq+ZvCE9InJPbvhBxZbEvp9gVcV
         hZ+w==
X-Gm-Message-State: ACrzQf1abObRGzvqZnq9avUjjjgz0G7igF5VHyasrNRZNXtdzkXN/TtA
        ZJb2sjgkanQf1/VfuK9C6Ox3kGAw9UkfIg==
X-Google-Smtp-Source: AMsMyM6PPlgGBq9a+t300bSqccT8dp5P3oyFe5VDwLemm8cBD1Q0kIIW9t+xSj84TgA5fvW0q/htDg==
X-Received: by 2002:a17:902:dacf:b0:185:3735:ffc7 with SMTP id q15-20020a170902dacf00b001853735ffc7mr4432058plx.147.1665745561067;
        Fri, 14 Oct 2022 04:06:01 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d21-20020a631d55000000b004597e92f99dsm1184430pgm.66.2022.10.14.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:06:00 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, quic_pkondeti@quicinc.com
Cc:     peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Date:   Fri, 14 Oct 2022 19:05:51 +0800
Message-Id: <20221014110551.22695-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

Pavan reported a problem that PSI avgs_work idle shutoff is not
working at all. Because PSI_NONIDLE condition would be observed in
psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
only the kworker running avgs_work on the CPU.

Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
still will always re-arm the avgs_work, so shutoff is not working.

This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
for other CPUs we can just check PSI_NONIDLE delta. The new flag
is only used in psi_avgs_work(), so we check in get_recent_times()
that current_work() is avgs_work.

One potential problem is that the brief period of non-idle time
incurred between the aggregation run and the kworker's dequeue will
be stranded in the per-cpu buckets until avgs_work run next time.
The buckets can hold 4s worth of time, and future activity will wake
the avgs_work with a 2s delay, giving us 2s worth of data we can leave
behind when shut off the avgs_work. If the kworker run other works after
avgs_work shut off and doesn't have any scheduler activities for 2s,
this maybe a problem.

Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - need to check NR_IOWAIT and NR_MEMSTALL of the current CPU per Pavan.
 - copy groupc->tasks[] out of the retry loop per Suren.
 - use new flag PSI_STATE_RESCHEDULE instead of PSI_NONIDLE per Suren.
 - test current_work() is avgs_work to only use PSI_STATE_RESCHEDULE
   for re-arming avgs_work per Johannes.
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 30 +++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 6e4372735068..325981833587 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -72,6 +72,9 @@ enum psi_states {
 /* Use one bit in the state mask to track TSK_ONCPU */
 #define PSI_ONCPU	(1 << NR_PSI_STATES)
 
+/* Flag whether to re-arm avgs_work, see details in get_recent_times() */
+#define PSI_STATE_RESCHEDULE	(1 << (NR_PSI_STATES + 1))
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee2ecc081422..e347e06fdd68 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -256,6 +258,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		if (cpu == current_cpu)
+			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -280,6 +284,28 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/*
+	 * When collect_percpu_times() from the avgs_work, we don't want to
+	 * re-arm avgs_work when all CPUs are IDLE. But the current CPU running
+	 * this avgs_work is never IDLE, cause avgs_work can't be shut off.
+	 * So for the current CPU, we need to re-arm avgs_work only when
+	 * (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0), for other CPUs
+	 * we can just check PSI_NONIDLE delta.
+	 */
+	if (current_work() == &group->avgs_work.work) {
+		bool reschedule;
+
+		if (cpu == current_cpu)
+			reschedule = tasks[NR_RUNNING] +
+				     tasks[NR_IOWAIT] +
+				     tasks[NR_MEMSTALL] > 1;
+		else
+			reschedule = *pchanged_states & (1 << PSI_NONIDLE);
+
+		if (reschedule)
+			*pchanged_states |= PSI_STATE_RESCHEDULE;
+	}
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
@@ -415,7 +441,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool nonidle;
 	u64 now;
 
 	dwork = to_delayed_work(work);
@@ -426,7 +451,6 @@ static void psi_avgs_work(struct work_struct *work)
 	now = sched_clock();
 
 	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	nonidle = changed_states & (1 << PSI_NONIDLE);
 	/*
 	 * If there is task activity, periodically fold the per-cpu
 	 * times and feed samples into the running averages. If things
@@ -437,7 +461,7 @@ static void psi_avgs_work(struct work_struct *work)
 	if (now >= group->avg_next_update)
 		group->avg_next_update = update_averages(group, now);
 
-	if (nonidle) {
+	if (changed_states & PSI_STATE_RESCHEDULE) {
 		schedule_delayed_work(dwork, nsecs_to_jiffies(
 				group->avg_next_update - now) + 1);
 	}
-- 
2.37.2

