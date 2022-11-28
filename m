Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1D63A925
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiK1NOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiK1NNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDB1CFCF;
        Mon, 28 Nov 2022 05:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641215; x=1701177215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=C8o1EqWi47EMS3NLEboiqwaO6Cqj8PqboSa/beXp5NY=;
  b=CIquFBhoaOO+JcnTLi7Rt1q5gZb9/AhDXDPV2ooUICbRVFq3AHQFlfSD
   WoyyIfAMrneTWaWYNTpYjfhLsB+y/nk+cVRBnNqKoOp2lOgePfoZGw9Eo
   9ysUk4bmTWUaPYoxRJ/QPmaY4QPZ7LCBei/RpGL09Wzzq62QTeGvXUQH0
   VEWBACqkmUvgwONsKSMr/FNFreA2nu+2lwo2Gjv6GjtpINguY9QUm++bO
   St+BlwWawy1G8AhdGmg491/qACjerpzgug7iF9Tz4rIk2fSJL0eQ1Y0zn
   kU2NA5JTmZF5apbH9lPXpX6NvQiyrZHSNES3n2f1Rh8P7w0QwrjnBT+K9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117084"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381335"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381335"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:32 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 04/22] sched/core: Add user_tick as argument to scheduler_tick()
Date:   Mon, 28 Nov 2022 05:20:42 -0800
Message-Id: <20221128132100.30253-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Differentiate between user and kernel ticks so that the scheduler updates
the IPC class of the current task during the latter.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * None
---
 include/linux/sched.h | 2 +-
 kernel/sched/core.c   | 2 +-
 kernel/time/timer.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 47ae3557ba07..ddabc7449edd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -293,7 +293,7 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-extern void scheduler_tick(void);
+extern void scheduler_tick(bool user_tick);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8dd43ee05534..8bb6f597c42b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5487,7 +5487,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(void)
+void scheduler_tick(bool user_tick)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..e15e24105891 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2073,7 +2073,7 @@ void update_process_times(int user_tick)
 	if (in_irq())
 		irq_work_tick();
 #endif
-	scheduler_tick();
+	scheduler_tick(user_tick);
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers();
 }
-- 
2.25.1

