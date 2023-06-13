Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37D72DC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjFMIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbjFMIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:20:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE5E7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3b5a5134dso16005705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686644431; x=1689236431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRyoffq284CboESvBO4uwViVg0lQhXPKanEjNic840o=;
        b=ZrFFWMMqlDzW/IxJ/CTorbaShmg4qNP+yoEiYMzVCUc/4D54uC2dxsUL7nruNPxJbH
         k0Hjz1vyWASCrpZXGYO9KThkqqRHh6ko7UdqVZ0qSgvWH9UfqNq9eX3SpursxtPAIEax
         +ojp783TC/WJyLAecf1PFSiYtoN32PkUjYVSE3TlmcCECtnLewTdtx5DyiMHeS1kqhmK
         FnCwuM5EVNnoYLq1KXwglHs5HERoDqUCU+jYYjy2iMPRAIJWdgbo9gOuRq6IlwBaDez6
         MQ2UUmHdG1mze6PN7SDNwPrzhoOjQIaU7xGIEqVm7Jxq9nduhriRYmhPtJxjVm+ES1EW
         t/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644431; x=1689236431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRyoffq284CboESvBO4uwViVg0lQhXPKanEjNic840o=;
        b=Oa8G6QJ2FsF+sU0CPkNJ1v4tp5gc+waA6bMdyh5mIA9BzL9qfFGVK0cRzhvijOwRKX
         f2iJLoajjYJK6L36VJhPaWdc+aHREebPgWQsgj4sULcXAv1cvWKxDcWBQCXO08t9Rf8W
         9IQtg/KhpeEpFhE9fT+DH4bA4hM2TKpTpoNbnL2/U7PQMZrsc8mGcHCUUrtjHHhW6iN9
         5AEmAB2R61GWiCm2bMUIJ0DlPFgkoh+aJGp6UMMQmRTHpPWE4takOc6yptfnUOmTn9ak
         dxL2eQNgHQMdzGcaXGiZdvEzHdvXvKiu30HgiDEdjGDtzFYrftia4KmSFZTOaj0Qxj0A
         WVtw==
X-Gm-Message-State: AC+VfDxQ+fehIRLjDqYnjd73Yk1tpEXr7B41/uGJ1Erz/GuyN6M0v63n
        ZbcvIiC1QSuIyHThkhFhjjU+EQ==
X-Google-Smtp-Source: ACHHUZ7hX07mylJwRH3BKydwpui+Eb98vONdgChCioewPLAvvo2GBxZDVN8BVivA3iJ5jzzVsa7x1w==
X-Received: by 2002:a17:902:bd94:b0:1b3:d6c8:7008 with SMTP id q20-20020a170902bd9400b001b3d6c87008mr2941735pls.57.1686644431287;
        Tue, 13 Jun 2023 01:20:31 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001b027221393sm9567834plc.43.2023.06.13.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:20:30 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v5 1/4] sched/core: Fixed missing rq clock update before calling set_rq_offline()
Date:   Tue, 13 Jun 2023 16:20:09 +0800
Message-Id: <20230613082012.49615-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230613082012.49615-1-jiahao.os@bytedance.com>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled
and cpufreq is set to powersave:
------------[ cut here ]------------
rq->clock_update_flags < RQCF_ACT_SKIP
WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
enqueue_top_rt_rq+0x139/0x160
Call Trace:
 <TASK>
 ? intel_pstate_update_util+0x3b0/0x3b0
 rq_offline_rt+0x1b7/0x250
 set_rq_offline.part.120+0x28/0x60
 rq_attach_root+0xc4/0xd0
 cpu_attach_domain+0x3dc/0x7f0
 ? __schedule+0x65e/0x1310
 partition_sched_domains_locked+0x2a5/0x3c0
 rebuild_sched_domains_locked+0x477/0x830
 ? percpu_rwsem_wait+0x140/0x140
 rebuild_sched_domains+0x1b/0x30
 cpuset_hotplug_workfn+0x2ca/0xc90
 ? balance_push+0x56/0x120
 ? _raw_spin_unlock+0x15/0x30
 ? finish_task_switch+0x98/0x2f0
 ? __switch_to+0x116/0x410
 ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
 ? _raw_spin_unlock_irqrestore+0x23/0x40
 ? add_timer_on+0xd5/0x130
 process_one_work+0x1bc/0x3d0
 worker_thread+0x4c/0x380
 ? preempt_count_add+0x56/0xa0
 ? rescuer_thread+0x310/0x310
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

More detailed key function call graph:
rq_offline_rt()
  __disable_runtime()
    sched_rt_rq_enqueue()
      enqueue_top_rt_rq()
        cpufreq_update_util() <-- depends on CONFIG_CPU_FREQ
          data->func(data, *rq_clock(rq)*, flags)
            intel_pstate_update_util() <-- powersave policy callback function

Before calling rq_offline_rt() we need to update the rq clock to avoid
using the old rq clock, So we add update_rq_clock() to set_rq_offline()
to update rq clock. And we use rq_lock_irqsave()/rq_unlock_irqrestore()
to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore()
in rq_attach_root() to ensure that rq->clock_update_flags are cleared
before updating the rq clock.

Steps to reproduce:
1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
3. cpupower -c all frequency-set -g powersave
4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
   system with n CPUs)
5. Offline cpu one by one until the warninng is triggered

Suggested-by: Ben Segall <bsegall@google.com>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/topology.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..a8be5415daba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9548,6 +9548,7 @@ void set_rq_offline(struct rq *rq)
 	if (rq->online) {
 		const struct sched_class *class;
 
+		update_rq_clock(rq);
 		for_each_class(class) {
 			if (class->rq_offline)
 				class->rq_offline(rq);
@@ -9689,7 +9690,6 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
-		update_rq_clock(rq);
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..52976eadfee9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -487,9 +487,9 @@ static void free_rootdomain(struct rcu_head *rcu)
 void rq_attach_root(struct rq *rq, struct root_domain *rd)
 {
 	struct root_domain *old_rd = NULL;
-	unsigned long flags;
+	struct rq_flags rf;
 
-	raw_spin_rq_lock_irqsave(rq, flags);
+	rq_lock_irqsave(rq, &rf);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -515,7 +515,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_rq_unlock_irqrestore(rq, flags);
+	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
-- 
2.20.1

