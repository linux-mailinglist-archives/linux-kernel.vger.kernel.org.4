Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B17610A81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJ1GnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJ1GmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171D129755;
        Thu, 27 Oct 2022 23:42:11 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMWKO65fY+yhjcFF62rlRZ/3VpM61mvEgbltirxSxX4=;
        b=xn4fDg49QwWXa7xrtaJ43r8gR0VUuQt84p22KD6gT8f5DWIJvVSxZSxPVDdxSbkQi4UdDu
        8tHvZ37JgGa2iJ/dbZubdmXJ3Wm2Ge+rxeVv90HytcGbexiiBD1gyWZjWTQm9UH/xfNxCb
        9ByWWOmZMJUkmOeA3Iydc1kOUcYTR83UHHpuKWdw2By/wu7S8oSyLfc4rkpBMgGkMm02a5
        ZoK3SjVqUhfzUPp6WFmwxZAv6o2DikQRXSLthTMcHkx42qQXbh9xe9hhqNRef7ccQ4wAWZ
        ke/jgkGAnJQIC8pKz217JPN42m8gTnkovTQm4dUocE41vR822iHCJGizYiWAcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMWKO65fY+yhjcFF62rlRZ/3VpM61mvEgbltirxSxX4=;
        b=RQnBs+Ix56Q8xyVkZOxFjatNd3+ruzDmLxI6zxXU5rMJSZ3/lT3OuW51BrDMmm31XlSdbi
        fq1lO3DaFKvB8cAQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221010104206.12184-1-zhouchengming@bytedance.com>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
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

Commit-ID:     7d89d7bb921c5ae5a428df282e64ee5692e26fe0
Gitweb:        https://git.kernel.org/tip/7d89d7bb921c5ae5a428df282e64ee5692e26fe0
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Mon, 10 Oct 2022 18:42:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:23 +02:00

sched/psi: Fix avgs_work re-arm in psi_avgs_work()

Pavan reported a problem that PSI avgs_work idle shutoff is not
working at all. Because PSI_NONIDLE condition would be observed in
psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
only the kworker running avgs_work on the CPU.

Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
still will always re-arm the avgs_work, so shutoff is not working.

This patch changes to consider current CPU groupc as IDLE if the
kworker running avgs_work is the only task running and no IOWAIT
or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
if other CPUs' groupc are also IDLE.

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221010104206.12184-1-zhouchengming@bytedance.com
---
 kernel/sched/psi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee2ecc0..f4cdf6f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	bool only_avgs_work = false;
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		/*
+		 * This CPU has only avgs_work kworker running, snapshot the
+		 * newest times then don't need to re-arm for this groupc.
+		 * Normally this kworker will sleep soon and won't wake
+		 * avgs_work back up in psi_group_change().
+		 */
+		if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
+		    !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
+			only_avgs_work = true;
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
+	if (only_avgs_work)
+		*pchanged_states &= ~(1 << PSI_NONIDLE);
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
