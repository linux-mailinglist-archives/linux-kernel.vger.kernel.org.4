Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA16FDE77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjEJN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbjEJNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:25:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767345B96;
        Wed, 10 May 2023 06:25:55 -0700 (PDT)
Date:   Wed, 10 May 2023 13:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wCDCMVLVHkAwMTT4agPvZQd6bXtY1uPlo5JBSddpyI=;
        b=4qNVnhTCFEUDKGHJXbKI5a0lwGqp+R7m8fkL5mrAr2GhI7eeOextrxCcnbK3WQM1+XbYiX
        LzpUX4JSul74/EPXsTMZ69JLUW1nRj5RYoeYxTUwRXj0LJv0kTHF4R8FhgbsZn7/rRSZ+p
        mJhyGLnYdfUWJyvROfzSCvgU8CCPzxzrEy2DHTUYsC2fsT2BzcQCztmw0hWo+Ndd/e53Gm
        wjnCw62L2eiWOA+FPGmz0gH72D7sLhrI9iEgByKeMb02tpH22dDf5Jhsasek2YrgbMZucc
        Sj0W5SOscUOD8OlrkBRsQSfeaa4fqq9JUqBryA+eWaiP5Jl4KDcQDtp+kpVvbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wCDCMVLVHkAwMTT4agPvZQd6bXtY1uPlo5JBSddpyI=;
        b=4SU/X6289E2I+zi/BXaDKmo66YETFiIl/mrkdl/m66YRuh9clYQMySPy0rdf9rflyP7LnU
        ItVgm5ua0xVgUSCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/ds: Flush PEBS DS when changing
 PEBS_DATA_CFG
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230421184529.3320912-1-kan.liang@linux.intel.com>
References: <20230421184529.3320912-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372515266.404.11587715767446878831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b752ea0c28e3f7f0aaaad6abf84f735eebc37a60
Gitweb:        https://git.kernel.org/tip/b752ea0c28e3f7f0aaaad6abf84f735eebc37a60
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 21 Apr 2023 11:45:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:27 +02:00

perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG

Several similar kernel warnings can be triggered,

  [56605.607840] CPU0 PEBS record size 0, expected 32, config 0 cpuc->record_size=208

when the below commands are running in parallel for a while on SPR.

  while true;
  do
	perf record --no-buildid -a --intr-regs=AX  \
		    -e cpu/event=0xd0,umask=0x81/pp \
		    -c 10003 -o /dev/null ./triad;
  done &

  while true;
  do
	perf record -o /tmp/out -W -d \
		    -e '{ld_blocks.store_forward:period=1000000, \
                         MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}' \
		    -c 1037 ./triad;
  done

The triad program is just the generation of loads/stores.

The warnings are triggered when an unexpected PEBS record (with a
different config and size) is found.

A system-wide PEBS event with the large PEBS config may be enabled
during a context switch. Some PEBS records for the system-wide PEBS
may be generated while the old task is sched out but the new one
hasn't been sched in yet. When the new task is sched in, the
cpuc->pebs_record_size may be updated for the per-task PEBS events. So
the existing system-wide PEBS records have a different size from the
later PEBS records.

The PEBS buffer should be flushed right before the hardware is
reprogrammed. The new size and threshold should be updated after the
old buffer has been flushed.

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230421184529.3320912-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c        | 56 +++++++++++++++++-------------
 arch/x86/include/asm/perf_event.h |  3 ++-
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a2e566e..df88576 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1229,12 +1229,14 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 		  struct perf_event *event, bool add)
 {
 	struct pmu *pmu = event->pmu;
+
 	/*
 	 * Make sure we get updated with the first PEBS
 	 * event. It will trigger also during removal, but
 	 * that does not hurt:
 	 */
-	bool update = cpuc->n_pebs == 1;
+	if (cpuc->n_pebs == 1)
+		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
 		if (!needed_cb)
@@ -1242,7 +1244,7 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 		else
 			perf_sched_cb_dec(pmu);
 
-		update = true;
+		cpuc->pebs_data_cfg |= PEBS_UPDATE_DS_SW;
 	}
 
 	/*
@@ -1252,24 +1254,13 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	if (x86_pmu.intel_cap.pebs_baseline && add) {
 		u64 pebs_data_cfg;
 
-		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
-		if (cpuc->n_pebs == 1) {
-			cpuc->pebs_data_cfg = 0;
-			cpuc->pebs_record_size = sizeof(struct pebs_basic);
-		}
-
 		pebs_data_cfg = pebs_update_adaptive_cfg(event);
-
-		/* Update pebs_record_size if new event requires more data. */
-		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
-			cpuc->pebs_data_cfg |= pebs_data_cfg;
-			adaptive_pebs_record_size_update();
-			update = true;
-		}
+		/*
+		 * Be sure to update the thresholds when we change the record.
+		 */
+		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
+			cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
 	}
-
-	if (update)
-		pebs_update_threshold(cpuc);
 }
 
 void intel_pmu_pebs_add(struct perf_event *event)
@@ -1326,9 +1317,17 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	wrmsrl(base + idx, value);
 }
 
+static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
+{
+	if (cpuc->n_pebs == cpuc->n_large_pebs &&
+	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
+		intel_pmu_drain_pebs_buffer();
+}
+
 void intel_pmu_pebs_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 pebs_data_cfg = cpuc->pebs_data_cfg & ~PEBS_UPDATE_DS_SW;
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
 	unsigned int idx = hwc->idx;
@@ -1344,11 +1343,22 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
-		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
-			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
-			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
+		if (pebs_data_cfg != cpuc->active_pebs_data_cfg) {
+			/*
+			 * drain_pebs() assumes uniform record size;
+			 * hence we need to drain when changing said
+			 * size.
+			 */
+			intel_pmu_drain_large_pebs(cpuc);
+			adaptive_pebs_record_size_update();
+			wrmsrl(MSR_PEBS_DATA_CFG, pebs_data_cfg);
+			cpuc->active_pebs_data_cfg = pebs_data_cfg;
 		}
 	}
+	if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
+		cpuc->pebs_data_cfg = pebs_data_cfg;
+		pebs_update_threshold(cpuc);
+	}
 
 	if (idx >= INTEL_PMC_IDX_FIXED) {
 		if (x86_pmu.intel_cap.pebs_format < 5)
@@ -1391,9 +1401,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (cpuc->n_pebs == cpuc->n_large_pebs &&
-	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
-		intel_pmu_drain_pebs_buffer();
+	intel_pmu_drain_large_pebs(cpuc);
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed..abf0988 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -121,6 +121,9 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_LBR_SHIFT	24
 
+/* Steal the highest bit of pebs_data_cfg for SW usage */
+#define PEBS_UPDATE_DS_SW	BIT_ULL(63)
+
 /*
  * Intel "Architectural Performance Monitoring" CPUID
  * detection/enumeration details:
