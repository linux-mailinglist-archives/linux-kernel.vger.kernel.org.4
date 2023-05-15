Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF467024FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjEOGjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEOGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:39:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B77114
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aad5245571so84490045ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684132746; x=1686724746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W70DiGj/q2nP8jtGasv9F9p6lMGC6Cif6Ya2AzHk0NQ=;
        b=SE71g8zH4uEQnUiO+eEH/bgF9Hw2s0M0nKzDPCQ5MzGjcOL+bK+Y353hzsKMSnMvI3
         /z7iqNfNNFRaPRdSnHk1uONT7hgpCOyZgkDdi43f00JSVIanIZi7nkAdZ2mqB5d1QvZI
         /NLcUYX0YQBXzDuVPiPk2eeJEmpWAefACnLxFBMAFlM6KPIeJU59oz6Pn+MbuHOkGUTd
         g6VU8NdiA21qzKtniVfvAq0zeH3LBPTzHp8YXIIn/OFBpohU8V+TVx8d/o01oijnrzZP
         4hZ+InzPY1XcHts0s5Kl6PZIBFc5edTFBN0Caxm/0bCnkDj2Dtuc3biIKOjTGE0B1SFG
         VRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132746; x=1686724746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W70DiGj/q2nP8jtGasv9F9p6lMGC6Cif6Ya2AzHk0NQ=;
        b=fzgBjWc9JRk1uUr1iPe1ImpQsOKN5lK8LW5xzokqnObfu8OwgOmvLvAWiGSp+5MoGH
         /UXpXHxrqMOqWkDqoS9o/P4qW+Vx3ZywfCOjzgtCf/MV15+QIV7PnoMZqdwNPnHAOQqx
         nLo0SZ7ev5XFtlm8HaDPU6ljOlK+D1FiuDOD7Gf343Rqi557hwUmHwQnga1KAUwK4eHu
         eEGGx4QMudboDNV2NTKWN4uqk/FIr2J+UBpK7mc80ecdMu+3VOjn8EFpJUI4uJdY5EXD
         tYY2t3moIPqKwhMQMbevWSOZZNYM52CbCxdEn5b2oC1j6u76AIFJkwJfEOhws2cGr4yB
         9f5A==
X-Gm-Message-State: AC+VfDxOl+8ugbp1NGjTgt8VXaue+e91jAppJhoudr/DBuE4t+qP/+dU
        QmIqd6EDpc0CQHbIkU0RVHDlDg==
X-Google-Smtp-Source: ACHHUZ6f0qpiolJypED7ziKzmzZ9Xo2ide3GNCJLwOxgpMFS3rHdZMuE0FV+qZumrbDua2SXkxVxpA==
X-Received: by 2002:a17:903:120d:b0:1aa:f53a:5e47 with SMTP id l13-20020a170903120d00b001aaf53a5e47mr39324265plh.16.1684132745766;
        Sun, 14 May 2023 23:39:05 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001ab01598f40sm12608543plq.173.2023.05.14.23.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:39:05 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 1/4] sched/core: Fixed missing rq clock update before calling set_rq_offline()
Date:   Mon, 15 May 2023 14:38:45 +0800
Message-Id: <20230515063848.77947-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Before calling set_rq_offline() we need to update the rq clock to avoid
using the old rq clock, and use rq_lock_irqsave()/rq_unlock_irqrestore()
to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore() to
ensure that rq->clock_update_flags are cleared before updating the rq
clock.

Steps to reproduce:
1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
3. cpupower -c all frequency-set -g powersave
4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
   system with n CPUs)
5. Offline cpu one by one until the warninng is triggered

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/topology.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..b89497696880 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -487,15 +487,17 @@ static void free_rootdomain(struct rcu_head *rcu)
 void rq_attach_root(struct rq *rq, struct root_domain *rd)
 {
 	struct root_domain *old_rd = NULL;
-	unsigned long flags;
+	struct rq_flags rf;
 
-	raw_spin_rq_lock_irqsave(rq, flags);
+	rq_lock_irqsave(rq, &rf);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
 
-		if (cpumask_test_cpu(rq->cpu, old_rd->online))
+		if (cpumask_test_cpu(rq->cpu, old_rd->online)) {
+			update_rq_clock(rq);
 			set_rq_offline(rq);
+		}
 
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
@@ -515,7 +517,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_rq_unlock_irqrestore(rq, flags);
+	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
-- 
2.37.0

