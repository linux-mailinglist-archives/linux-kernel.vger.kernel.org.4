Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9725B42E0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIIXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiIIXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBEC112B2F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764795; x=1694300795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Yx6ioVlcL/Y+UNwfcJdgPbEuCHvV72QG5oxblnfz+xQ=;
  b=LDk/u6gq1/b4aef48btj/v/IHWw+t7VEDrNtQnp/liPKI1lGDxg9pTPi
   LYw8+Om7HSbAt3TrwpSX19bDxfixVoI8HVBBjmMaoyie2X00q3RP2loMk
   o+T/2gAi1sg946lgF2njwBUfxEfjIDFTwe+2EoVfBE8dFqYwk6g1Ob9ER
   6XUIWPwpKYTEjb/7E/yOCXVG6wHsoM13idvrwbpFOP8Ynt9jGXD1IEYe+
   ZadEjdBH0r8ZjR97uZBZBuurUGZCKID/8pf8uPaowq7/z89vQa+7NLsYY
   7nk4Z1ONMGODpPAEWqsGNxypU7R9IUmuagpCBVM6ED0FphQOyNXJCvRrv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="323803591"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="323803591"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354978"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:32 -0700
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 04/23] sched/core: Add user_tick as argument to scheduler_tick()
Date:   Fri,  9 Sep 2022 16:11:46 -0700
Message-Id: <20220909231205.14009-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Differentiate between user and kernel ticks so that the scheduler updates
the class of the current task during the latter.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/sched.h | 2 +-
 kernel/sched/core.c   | 2 +-
 kernel/time/timer.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index acc33dbaa47c..73f9e745d17d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -283,7 +283,7 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-extern void scheduler_tick(void);
+extern void scheduler_tick(bool user_tick);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db548c1a25ef..76015dbc45c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5436,7 +5436,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(void)
+void scheduler_tick(bool user_tick)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..b444b6f5f585 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1841,7 +1841,7 @@ void update_process_times(int user_tick)
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

