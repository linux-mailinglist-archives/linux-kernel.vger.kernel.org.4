Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23DC6CCD42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1Wdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjC1Wdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:33:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721E30C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680042822; x=1711578822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANpXpH5IhohDmCJ9zVQdcPUfKpVdsYMvbnB9VnLgPeo=;
  b=Dkks03IgqPWgXH6CjRrRPfp8mv4lbNoY/3y/A7fyKgmf9/wH2sDaE9Pr
   h/5vLKzima9lJONrpNB1pDYcxfdhvt0CzKbfML+94B/nJ+Qp2zKgTTf7F
   2rxc4Jvctmn9v/TMiOHgReF6LWA89GVUwDhR7DmIr00zd+ngG3Tov4Ncg
   84FLnXcKZWJaDnlLlRzQkcYpKtkssperujj1+ydXPKc2c44+A8vnv9qJo
   8et6JuvLOpW0u6Y/wX6G+iXF5DOJNQUVh1gAHRY25fYQ0A4F0+bm0CYzH
   lDGsC6YUP5m62aweqqxwJQwQ/JpwuDdP3CV/tHkgs7aUF4LobFmb5Q/Fd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340735716"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340735716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 15:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634236278"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="634236278"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2023 15:27:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf: Add sched_task callback during ctx reschedule
Date:   Tue, 28 Mar 2023 15:27:34 -0700
Message-Id: <20230328222735.1367829-1-kan.liang@linux.intel.com>
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

