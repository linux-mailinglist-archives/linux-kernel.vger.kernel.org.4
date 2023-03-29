Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA416CDAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjC2N33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2N30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:29:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A6DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680096566; x=1711632566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANpXpH5IhohDmCJ9zVQdcPUfKpVdsYMvbnB9VnLgPeo=;
  b=X8a/Gir67kJW0gAHB5hrBiQrOCd8isMuxvkbyPdxj1OVrOn+7MpSLLjO
   Knk0L52LI8zdzajWeIV8FviKcBle1tvWKkxvfpD2rfY7NJa7nvgWp32Br
   ViwUlrcf700hWbXQvrWX1Chr5HE4RoKqLw13aoFGNgU4ZD6bTnsWEpmMV
   RcyAAlzF5zsR3L7IkRLXJ9ruB3cGCRXeu8pDpKFsc1yIzFZTWc3bq6HiG
   BTXVXy8Q1C1ollgCdxr/GouDiyyvx0rg2XnTyMXQD8WfP+c5gprrRV9wJ
   0cUZGZkp6eMCOwzfXEwQSeYWPhpw55YmLarh25yCriknAOLaDJulBLw0E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343298989"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343298989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714620100"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="714620100"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 06:29:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/2] perf: Add sched_task callback during ctx reschedule
Date:   Wed, 29 Mar 2023 06:29:20 -0700
Message-Id: <20230329132921.1429538-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Several similar kernel warnings can be triggered,

  [56605.607840] CPU0 PEBS record size 0, expected 32, config 0
  cpuc->record_size=208

when the below commands are running in parallel for a while on SPR.

  while true; do perf record --no-buildid -a --intr-regs=AX -e
  cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &

  while true; do perf record -o /tmp/out -W -d -e
  '{ld_blocks.store_forward:period=1000000,
  MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
  -c 1037 ./triad; done
  *The triad program is just the generation of loads/stores.

The warnings are triggered when an unexpected PEBS record (with a
different config and size) is found.

In a context switch, different events may be applied to the old task and
the new task. The sched_task callback is used to switch the PMU-specific
data. For the PEBS, the callback flushes the DS area and parses the PEBS
records from the old task when schedule out. The new task never sees the
stale PEBS records.

However, the exec() doesn't have similar support. The new command may
see the PEBS records from the old command. In the perf_event_exec(), the
ctx_resched() is invoked to reschedule the context. It may updates the
active events, which may change the global PEBS configuration. The PEBS
record from the old command may have a different config and size from
the new command. The warning is triggered.

The sched_task callback should be invoked in all the places where the
context can be changed. Add the sched_task callback in the ctx_resched()
as well.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..0c49183656fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2642,6 +2642,8 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
 }
 
+static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in);
+
 /*
  * We want to maintain the following priority of scheduling:
  *  - CPU pinned (EVENT_CPU | EVENT_PINNED)
@@ -2680,6 +2682,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	perf_ctx_disable(&cpuctx->ctx);
 	if (task_ctx) {
 		perf_ctx_disable(task_ctx);
+		perf_ctx_sched_task_cb(task_ctx, false);
 		task_ctx_sched_out(task_ctx, event_type);
 	}
 
@@ -2698,8 +2701,10 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	perf_event_sched_in(cpuctx, task_ctx);
 
 	perf_ctx_enable(&cpuctx->ctx);
-	if (task_ctx)
+	if (task_ctx) {
+		perf_ctx_sched_task_cb(task_ctx, true);
 		perf_ctx_enable(task_ctx);
+	}
 }
 
 void perf_pmu_resched(struct pmu *pmu)
-- 
2.35.1

