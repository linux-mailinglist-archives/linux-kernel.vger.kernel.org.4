Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84115B3A24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiIIOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiIIOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63B69F67;
        Fri,  9 Sep 2022 07:00:17 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0XNCQumM3ZmPliHOe2J8VJTpa0JmziMmEEQbqTzp1I=;
        b=QRvV7AYP+GVYwQTSyV+iYAwhg1SCirmCIxe08aIMR4wG88Zw52trAKB17ANA3EkxXzC32D
        yur/ecibJGgIvUSTLfKex3tfEZpngo7pijMIVL/YCP8BxRjJK3BOFkcFa0m9a0rpnxXMtJ
        LwEomoMS6hxkYLJ+kHSWodYbLx+YSdkj5yetK0/UPgMBQDiEgIRWy/tNCkReAxV8S8V75V
        bLal+fOVWA2XBu2OOhN7gHwFfkN0+rwE2Ni9sLxLopIpzJ+o5cCwbhEnx+b2s8CCGxmOAO
        RQawCN+VpkLwdxEL9T8lV/Kpe3eQEtNItewGs4Fjus0s1lcQJdfd/gYcsLDE2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0XNCQumM3ZmPliHOe2J8VJTpa0JmziMmEEQbqTzp1I=;
        b=QmZTsn7tck92kuh+Ult1o3CgKXGgaz0O8r0pZd3nlUO5vOES+PlpS+TxRHoexx/58DVLvr
        7WnmLai4Vm9EcqBw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Optimize task switch inside shared cgroups again
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-6-zhouchengming@bytedance.com>
References: <20220825164111.29534-6-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201483.401.2387194534220486421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     65176f59a18d888684525658a1d0b8bf749d24f3
Gitweb:        https://git.kernel.org/tip/65176f59a18d888684525658a1d0b8bf749d24f3
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:32 +02:00

sched/psi: Optimize task switch inside shared cgroups again

Way back when PSI_MEM_FULL was accounted from the timer tick, task
switching could simply iterate next and prev to the common ancestor to
update TSK_ONCPU and be done.

Then memstall ticks were replaced with checking curr->in_memstall
directly in psi_group_change(). That meant that now if the task switch
was between a memstall and a !memstall task, we had to iterate through
the common ancestors at least ONCE to fix up their state_masks.

We added the identical_state filter to make sure the common ancestor
elimination was skipped in that case. It seems that was always a
little too eager, because it caused us to walk the common ancestors
*twice* instead of the required once: the iteration for next could
have stopped at the common ancestor; prev could have updated TSK_ONCPU
up to the common ancestor, then finish to the root without changing
any flags, just to get the new curr->in_memstall into the state_masks.

This patch recognizes this and makes it so that we walk to the root
exactly once if state_mask needs updating, which is simply catching up
on a missed optimization that could have been done in commit 7fae6c8171d2
("psi: Use ONCPU state tracking machinery to detect reclaim") directly.

Apart from this, it's also necessary for the next patch "sched/psi: remove
NR_ONCPU task accounting". Suppose we walk the common ancestors twice:

(1) psi_group_change(.clear = 0, .set = TSK_ONCPU)
(2) psi_group_change(.clear = TSK_ONCPU, .set = 0)

We previously used tasks[NR_ONCPU] to record TSK_ONCPU, tasks[NR_ONCPU]++
in (1) then tasks[NR_ONCPU]-- in (2), so tasks[NR_ONCPU] still be correct.

The next patch change to use one bit in state mask to record TSK_ONCPU,
PSI_ONCPU bit will be set in (1), but then be cleared in (2), which cause
the psi_group_cpu has task running on CPU but without PSI_ONCPU bit set!

With this patch, we will never walk the common ancestors twice, so won't
have above problem.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-6-zhouchengming@bytedance.com
---
 kernel/sched/psi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 77d53c0..d71dbc2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -820,20 +820,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
-		bool identical_state;
-
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
-		 * When switching between tasks that have an identical
-		 * runtime state, the cgroup that contains both tasks
-		 * we reach the first common ancestor. Iterate @next's
-		 * ancestors only until we encounter @prev's ONCPU.
+		 * Set TSK_ONCPU on @next's cgroups. If @next shares any
+		 * ancestors with @prev, those will already have @prev's
+		 * TSK_ONCPU bit set, and we can stop the iteration there.
 		 */
-		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (identical_state &&
-			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
@@ -877,10 +872,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 			psi_group_change(group, cpu, clear, set, now, wake_clock);
 
 		/*
-		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
-		 * with dequeuing too, finish that for the rest of the hierarchy.
+		 * TSK_ONCPU is handled up to the common ancestor. If there are
+		 * any other differences between the two tasks (e.g. prev goes
+		 * to sleep, or only one task is memstall), finish propagating
+		 * those differences all the way up to the root.
 		 */
-		if (sleep) {
+		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
 				psi_group_change(group, cpu, clear, set, now, wake_clock);
