Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C96FD993
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjEJIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbjEJIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:36:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AB618F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6439f186366so4105313b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683707707; x=1686299707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKvBdWCQe6NR9bPAB1Yd9GU29BaBelbXv6fzSXWSFGw=;
        b=fTGYy6lz1Zo0rwRAie0oFz83glwFk6cMA0nbQPjXjbVcsHxWUFTrFZRA5awx/xPsbR
         s30hF+laZzIvG2wcfgYgYtvkxSTigE1OAonRS/QqPkul/hWmfZZLxZiy4bbEmy4/EfQp
         eIlzDBA5wY9FDjQEPVp7Em5WBpytY0HnusmJoG8EP7AefNADsDPb74/CWzYA4br+P1Ml
         isKCZSZSvYcRSCnnlvxzb3D7Z2HezhXf4KXpeTTLEWUSKIIJCT8S6uh8+Win7T4Dok/p
         vP4kp5iIxV0oLPCkidS77i5EtYzQ7iPI3oPMP78q9vnN4/w1oNGb2DmN42dFm1EYkqwY
         Ehfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707707; x=1686299707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKvBdWCQe6NR9bPAB1Yd9GU29BaBelbXv6fzSXWSFGw=;
        b=YdsPRyjraSI6mRIyCwhp9lU5LUzc8fOdBaLKOD57JayIfmmqnZTkSRYm3gkPbrHktO
         dQZuYzuGrR4jQECwJZJZVt23NssTbLJzO9f3mXDgakaFeG8PCXSya1+gfSVD8Ty+zSeE
         qIL7R5RtkRO3itrERww0OrCbykrocnkQg1aAzJLbOK6guEhyba3/25t1R1pc0IQEA1ZX
         qGXhueK+LdC5t6Gu7syadisWI1SNM8wm0uFxZNUYYjVE4OIXs7l0r20LGykajuZgrQDa
         0L44YBGlFazHz2qg818MX4YhKCHdCDM+ZwHiXJfZwmMjET3LZWDQbjtwP7aZ7MDyySUR
         n7JA==
X-Gm-Message-State: AC+VfDwQiZ7Cmxt3Vq8sGVyVZbV0/XGnQuGv+/7AlrrQByMOygs2OB6I
        Sreh8CeLZVxf7NOyUPq+dWKVpw==
X-Google-Smtp-Source: ACHHUZ7k06pQfkQuexLYqWMHCbhPuesuIePQEzZEtcxRTnJztaZ4YK2cAV0p3S5+c5D5f8fPl8c5dA==
X-Received: by 2002:a05:6a20:3d27:b0:100:99a:7f71 with SMTP id y39-20020a056a203d2700b00100099a7f71mr15753980pzi.2.1683707707668;
        Wed, 10 May 2023 01:35:07 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a668200b002504a1a5d1asm7588359pjj.29.2023.05.10.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:35:07 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 1/2] sched/core: Fixed missing rq clock update before calling set_rq_offline()
Date:   Wed, 10 May 2023 16:34:49 +0800
Message-Id: <20230510083450.62334-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230510083450.62334-1-jiahao.os@bytedance.com>
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
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

