Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23B610A86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJ1Gn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJ1GmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43EF1B8640;
        Thu, 27 Oct 2022 23:42:13 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSzMo9cK5LwhS8XGGk2a2xUnquRHNcxFX8Sw1J/a6Tw=;
        b=tPt28NRdg06Ji7S4G/eo3o4N6xJ3VHygBGGbgLi8SmS1CW5wdrzc/61rgxHXWbRzHBh3Kx
        cJ+7Lw8pKL2HdPA6PNc8O5J772GwCr2r4Y/ZT3RCSsMUzRw4ctx/BgXXHBYkPW1BW/VwMD
        nP9uwakZguoThdu3uTmj+QAhcXvgn1dGjQgkb3TCHvlZC6O2Qf0cyugyaz+Q9zqaV0n5c/
        qpNx5aGgTjXzk86uTdOJpQ9IKMvHNoXxkHgtxPNEeCY9INI0qd7d19GFFTR72zoB0eB/bx
        v53yUebs2TlNnC4nogfSV6wVMlno/X08K+wYvlsteIwOOGQFAU06cKJitWEpVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSzMo9cK5LwhS8XGGk2a2xUnquRHNcxFX8Sw1J/a6Tw=;
        b=IXbyJOyDwN/WMXV6ErBKZ2loxldNZEN+c0pp2e5IzxOLepKd/WtmwHQg4QQEpiUF51Zw3c
        BgXoNgRl5n8rEbAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Enforce user requested affinity
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922180041.1768141-4-longman@redhat.com>
References: <20220922180041.1768141-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <166693933110.29415.16593958219728582990.tip-bot2@tip-bot2>
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

Commit-ID:     da019032819a1f09943d3af676892ec8c627668e
Gitweb:        https://git.kernel.org/tip/da019032819a1f09943d3af676892ec8c627668e
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Sep 2022 14:00:39 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:22 +02:00

sched: Enforce user requested affinity

It was found that the user requested affinity via sched_setaffinity()
can be easily overwritten by other kernel subsystems without an easy way
to reset it back to what the user requested. For example, any change
to the current cpuset hierarchy may reset the cpumask of the tasks in
the affected cpusets to the default cpuset value even if those tasks
have pre-existing user requested affinity. That is especially easy to
trigger under a cgroup v2 environment where writing "+cpuset" to the
root cgroup's cgroup.subtree_control file will reset the cpus affinity
of all the processes in the system.

That is problematic in a nohz_full environment where the tasks running
in the nohz_full CPUs usually have their cpus affinity explicitly set
and will behave incorrectly if cpus affinity changes.

Fix this problem by looking at user_cpus_ptr in __set_cpus_allowed_ptr()
and use it to restrcit the given cpumask unless there is no overlap. In
that case, it will fallback to the given one. The SCA_USER flag is
reused to indicate intent to set user_cpus_ptr and so user_cpus_ptr
masking should be skipped. In addition, masking should also be skipped
if any of the SCA_MIGRATE_* flag is set.

All callers of set_cpus_allowed_ptr() will be affected by this change.
A scratch cpumask is added to percpu runqueues structure for doing
additional masking when user_cpus_ptr is set.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220922180041.1768141-4-longman@redhat.com
---
 kernel/sched/core.c  | 10 ++++++++++
 kernel/sched/sched.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67fb0e4..283bdbd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2949,6 +2949,15 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
+	/*
+	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
+	 * flags are set.
+	 */
+	if (p->user_cpus_ptr &&
+	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
+	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
+		ctx->new_mask = rq->scratch_mask;
+
 	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
 }
 
@@ -9804,6 +9813,7 @@ void __init sched_init(void)
 
 		rq->core_cookie = 0UL;
 #endif
+		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04f571d..771f8dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1151,6 +1151,9 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+	/* Scratch cpumask to be temporarily used under rq_lock */
+	cpumask_var_t		scratch_mask;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
