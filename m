Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD768CE81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBGFCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBGFBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF374C0A;
        Mon,  6 Feb 2023 21:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746109; x=1707282109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iDkGE/mIiTsNfeFOnUGlfr0oeLSL2C0UHOku/Uu39Qo=;
  b=ep/FwozEgPY3+GMxNFBQI7DFYoIlSGA70lZmUH/CqwfRw4+z9+c6iLY0
   qw3YJw+vjvQqbe8YZ3NucEpnWmJDcS3Q1osfUPoU4+75i7tKjzhgNcnxo
   y9VJWF+4v/zKyJOqHcO4PQnyEHZigA5nMwYUuE1pbuEx7l9fM4PMzGuBc
   ipo0hQ8/lbMeugQxE5DAoepBYKL2GCo+1Pjs6OaOaOUGgMLeS7wzaNPmo
   HiMbNsbxb9FtzqTP2T0MUfoEdnAMo0v8AhzCurAn7bhez6Cf0KAsoaZT6
   05BFJy61P30OuxiJgsxtNWYgw38oyKW1EwLDPz7Ae9fh0RoL4ej2TXL2K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625771"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625771"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657699"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657699"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:40 -0800
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 04/24] sched/core: Add user_tick as argument to scheduler_tick()
Date:   Mon,  6 Feb 2023 21:10:45 -0800
Message-Id: <20230207051105.11575-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Differentiate between user and kernel ticks so that the scheduler updates
the IPC class of the current task during the former.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
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
Changes since v2:
 * Corrected error in the changeset description: the IPC class of the
   current task is updated at user tick. (Dietmar)

Changes since v1:
 * None
---
 include/linux/sched.h | 2 +-
 kernel/sched/core.c   | 2 +-
 kernel/time/timer.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 98f84f90a01d..10c6abdc3465 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -293,7 +293,7 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-extern void scheduler_tick(void);
+extern void scheduler_tick(bool user_tick);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ed1549d28090..39d218a2f243 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5555,7 +5555,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
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

