Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13672D86C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjFMEWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbjFMEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8210DA;
        Mon, 12 Jun 2023 21:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630100; x=1718166100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M3Us+Di7YVDVts2uy+SPo0Lo0L5HiLvQUCEEirPWj5g=;
  b=Hsgoigar71fWJq+9QayOUU3GDLpjRns7PPUPdk3V/Za72SlaUtL9kjas
   O/H0f6cD1XHHHIyK162Id5sr3y3vwspqtABx7X93u16l2v5Qh6pchmd5h
   puxa2hyLHt6LsBbv0kZD/ZT6tOvTdqE6FsLajtwUdKMyEzInTuaiim/CD
   LSPAR4hJZ126sti7qEJ8pHMXp/kmuqcyhHxOhKtP5R4pDIYzvcpvhQe+7
   CtFbQOxSyZE2Khsl6zhKl0P0Z7IHtuWeHjkStm+hlAr9nn+KnNvQWUIe/
   JXzjcJrPvwnzANi5k9daIlKhgW+kyec7o9lTyJ5U3To42jHQ2/s3UhfM7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222070"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222070"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854940"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854940"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:38 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 04/24] sched/core: Add user_tick as argument to scheduler_tick()
Date:   Mon, 12 Jun 2023 21:24:02 -0700
Message-Id: <20230613042422.5344-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

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
index 9fdee040f450..0e1c38ad09c2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -295,7 +295,7 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-extern void scheduler_tick(void);
+extern void scheduler_tick(bool user_tick);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77b769c23186..6ac53f01d989 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5639,7 +5639,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
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

