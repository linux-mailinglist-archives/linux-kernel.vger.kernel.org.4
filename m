Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A56CDAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjC2N3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjC2N33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:29:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA09170F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680096568; x=1711632568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1IYLgCLH+VNADPhtdOOthJgLYH4EhZPq7JuM4tmKjF0=;
  b=QcMGafW93hf0lmdikNEVEzIW2OjXygzNYAtOm1+4AWfg9aSNeDVeERcN
   qH12Vu79ZlgXFPgNtV6RQt4BCzUCGFSLbFMbsr9k1sLIddFr95rIt+dIz
   yQLrc3nCsQzkPYrvu3SvKCd22SNZLtTbDXDz9CORWDu7+aCv6FoSRRLPn
   vsHAQFDG07IIbNI8KTTbF5Aud9THfGQNLJ73GUTevXvkTXwm93toZA2qE
   xF3ojkvkBkXeuQk0Q42tgyrc3RuGG2eyAKzY96XiiMXIBPlYef2wP/FTl
   DHM3L5rw4oJomKFcc9BnFBYY7WMtG9bAf5F0DTo0BIJy8aCWAiavvlJ4w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343299011"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343299011"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714620102"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="714620102"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 06:29:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/2] perf/x86/intel/ds: Use the size from each PEBS record
Date:   Wed, 29 Mar 2023 06:29:21 -0700
Message-Id: <20230329132921.1429538-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230329132921.1429538-1-kan.liang@linux.intel.com>
References: <20230329132921.1429538-1-kan.liang@linux.intel.com>
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

The kernel warning for the unexpected PEBS record can also be observed
during a context switch, when the below commands are running in parallel
for a while on SPR.

  while true; do perf record --no-buildid -a --intr-regs=AX -e
  cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &

  while true; do perf record -o /tmp/out -W -d -e
  '{ld_blocks.store_forward:period=1000000,
  MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
  -c 1037 ./triad; done
  *The triad program is just the generation of loads/stores.

The current PEBS code assumes that all the PEBS records in the DS buffer
have the same size, aka cpuc->pebs_record_size. It's true for the most
cases, since the DS buffer is always flushed in every context switch.

However, there is a corner case that breaks the assumption.
A system-wide PEBS event with the large PEBS config may be enabled
during a context switch. Some PEBS records for the system-wide PEBS may
be generated while the old task is sched out but the new one hasn't been
sched in yet. When the new task is sched in, the cpuc->pebs_record_size
may be updated for the per-task PEBS events. So the existing system-wide
PEBS records have a different size from the later PEBS records.

Two methods were considered to fix the issue.
One is to flush the DS buffer for the system-wide PEBS right before the
new task sched in. It has to be done in the generic code via the
sched_task() call back. However, the sched_task() is shared among
different ARCHs. The movement may impact other ARCHs, e.g., AMD BRS
requires the sched_task() is called after the PMU has started on a
ctxswin. The method is dropped.

The other method is implemented here. It doesn't assume that all the
PEBS records have the same size any more. The size from each PEBS record
is used to parse the record. For the previous platform (PEBS format < 4),
which doesn't support adaptive PEBS, there is nothing changed.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Del the unused variable 'cpuc'

 arch/x86/events/intel/ds.c        | 32 +++++++++++++++++++++++++------
 arch/x86/include/asm/perf_event.h |  6 ++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a2e566e53076..d34a610c93f9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1546,6 +1546,15 @@ static inline u64 get_pebs_status(void *n)
 	return ((struct pebs_basic *)n)->applicable_counters;
 }
 
+static inline u64 get_pebs_size(void *n)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (x86_pmu.intel_cap.pebs_format < 4)
+		return cpuc->pebs_record_size;
+	return intel_adaptive_pebs_size(((struct pebs_basic *)n)->format_size);
+}
+
 #define PERF_X86_EVENT_PEBS_HSW_PREC \
 		(PERF_X86_EVENT_PEBS_ST_HSW | \
 		 PERF_X86_EVENT_PEBS_LD_HSW | \
@@ -1903,9 +1912,9 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
-	WARN_ONCE(next_record != __pebs + (format_size >> 48),
+	WARN_ONCE(next_record != __pebs + intel_adaptive_pebs_size(format_size),
 			"PEBS record size %llu, expected %llu, config %llx\n",
-			format_size >> 48,
+			intel_adaptive_pebs_size(format_size),
 			(u64)(next_record - __pebs),
 			basic->format_size);
 }
@@ -1927,7 +1936,7 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	if (base == NULL)
 		return NULL;
 
-	for (at = base; at < top; at += cpuc->pebs_record_size) {
+	for (at = base; at < top; at += get_pebs_size(at)) {
 		unsigned long status = get_pebs_status(at);
 
 		if (test_bit(bit, (unsigned long *)&status)) {
@@ -2030,7 +2039,6 @@ __intel_pmu_pebs_event(struct perf_event *event,
 					    struct perf_sample_data *,
 					    struct pt_regs *))
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
@@ -2054,7 +2062,7 @@ __intel_pmu_pebs_event(struct perf_event *event,
 	while (count > 1) {
 		setup_sample(event, iregs, at, data, regs);
 		perf_event_output(event, data, regs);
-		at += cpuc->pebs_record_size;
+		at += get_pebs_size(at);
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		count--;
 	}
@@ -2278,7 +2286,19 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		return;
 	}
 
-	for (at = base; at < top; at += cpuc->pebs_record_size) {
+	/*
+	 * The cpuc->pebs_record_size may be different from the
+	 * size of each PEBS record. For example, a system-wide
+	 * PEBS event with the large PEBS config may be enabled
+	 * during a context switch. Some PEBS records for the
+	 * system-wide PEBS may be generated while the old task
+	 * is sched out but the new one isn't sched in. When the
+	 * new task is sched in, the cpuc->pebs_record_size may
+	 * be updated for the per-task PEBS events. So the
+	 * existing system-wide PEBS records have a different
+	 * size from the later PEBS records.
+	 */
+	for (at = base; at < top; at += get_pebs_size(at)) {
 		u64 pebs_status;
 
 		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..ad5655bb90f6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -386,6 +386,12 @@ static inline bool is_topdown_idx(int idx)
 /*
  * Adaptive PEBS v4
  */
+#define INTEL_ADAPTIVE_PEBS_SIZE_OFF		48
+
+static inline u64 intel_adaptive_pebs_size(u64 format_size)
+{
+	return (format_size >> INTEL_ADAPTIVE_PEBS_SIZE_OFF);
+}
 
 struct pebs_basic {
 	u64 format_size;
-- 
2.35.1

