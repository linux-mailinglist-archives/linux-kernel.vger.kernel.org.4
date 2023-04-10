Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE46DC434
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDJIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDJIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:12:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD64C09
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso12236788pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681114345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WO1hmjM9xrdhdfZ2YJyh200yOP7FbYCQwTl3LGlR2E=;
        b=Khr9IhgNJ5cV2AUUZJCzgmpfjQeCq5F4q0I4qkC2Xwzyy5GYhz1pImevaeLLaryBwP
         kIT2SosLbtF0XrppmFuFzkUlOVkzS/YNwUJ+A0FpHJVJKPoOulitINFM4HJ6VedovZpq
         7OxWrL2J+dE1JCY+GhOVFTqWjqh0hkdU+zI31IegsIHcjeazQWSGm9j8rJL2Pf9bOnw6
         oeUVNJNN2jiYdnQQfOvoqUvpdv+35J5crPSHXkrOyzllHZMIztAo7Vod1/NOPSblsnNR
         9XxhdXpfKDSgVieKQlQH8+Vw2jlKyNZNnxerJa28Nt7K1DrU3cVV2XKcRKIppD2IyDDV
         EHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681114345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WO1hmjM9xrdhdfZ2YJyh200yOP7FbYCQwTl3LGlR2E=;
        b=wVQDKyzq3z9UdFB+TTcFAfFEnVG9kHdBQeBxv+JD9WhvljARt/OhM+X9hcAs8FFIQA
         KEc65k0A760jDp3mc7MgRcPQpvl0ynCiI0YcPIjZSChgm06wCIwob2N/fgpkVbWL2Q1U
         TQ8go8GEExVsEcQ1iQssyycFtu6zp8qfIX9cET4Ad/JkSot9mZLXX9sV5zuj7ieTiuVu
         Ow6XGezEcnfUWeaQj1GuL1JDp7KZ+445FTeC3oucPF/XF65sEGqna9UgUaRvN66/uhqU
         mXs2TLkjpYzInYujHoCBGGTXg+yf/S0DF2yovkhWgtu78Kpj08ZhHFudxCBTs5BNBPvR
         Wezw==
X-Gm-Message-State: AAQBX9dfZKmFoK9yrZTofN5kMaI+eA79oY2raLhhvONBhEhk+zfN++/w
        phvh17H3h4K4ccYfGKccu3UKOg==
X-Google-Smtp-Source: AKy350byuRtuABVAlrZn0DwKIUpI0sdvJX5viFVca7w/NQrMi7AmjDnYwe5Mw/4918xp34f/YcL1jQ==
X-Received: by 2002:a05:6a20:3baa:b0:d8:c9f3:5107 with SMTP id b42-20020a056a203baa00b000d8c9f35107mr10330888pzh.18.1681114344846;
        Mon, 10 Apr 2023 01:12:24 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id m17-20020aa79011000000b0062d8e79ea22sm7234100pfo.40.2023.04.10.01.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:12:24 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 1/2] sched/core: Fixed missing rq clock update before calling set_rq_offline()
Date:   Mon, 10 Apr 2023 16:12:05 +0800
Message-Id: <20230410081206.23441-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230410081206.23441-1-jiahao.os@bytedance.com>
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled:

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
index 051aaf65c749..017f7583f0e2 100644
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

