Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6A6DCA90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDJSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:13:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FA1BD6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681150409; x=1712686409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8GBRU9LWaVgQWgbRBjeCeoZvhh7l+d7u9NegbBgbBfw=;
  b=HKr2t8ThcIrEcda2EmTwnF3aNpZOMShyrPHvCKWXWol3EckIMZBEXmvx
   iMDMMHVaSnrw8qXASkdmUEWDNUHenwjMIM6WFv5zhFJOxZfzv/FQg4vyb
   EwTBlPBbC9TvNXvHjUy9JOjU+Cwbkh7a0ZUJuYPTKv8ICCQzm2hB4fw8f
   sqHXsA1dpWjsCkhGQDTlGIhdy9j1So6ZSCAjLj5pg3qHwl0a5n2qYlWwn
   tX08NzBJC9828wSAA3bZ4APkJOCT3FtpRH4IJIl9f3FUgBLwvUv8Xu0Sl
   Ov8kb/q6Gv4s0XewhmzmAzEthSvBhHAc6PHYHmcGewbnmnfnBBo2p6/U3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408559380"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408559380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 11:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="799583519"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799583519"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 11:13:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3] perf/x86/intel/ds: Flush the PEBS buffer in PEBS enable
Date:   Mon, 10 Apr 2023 11:13:09 -0700
Message-Id: <20230410181309.827175-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

A system-wide PEBS event with the large PEBS config may be enabled
during a context switch. Some PEBS records for the system-wide PEBS may
be generated while the old task is sched out but the new one hasn't been
sched in yet. When the new task is sched in, the cpuc->pebs_record_size
may be updated for the per-task PEBS events. So the existing system-wide
PEBS records have a different size from the later PEBS records.

The PEBS buffer should be flushed right before the hardware is
reprogrammed. The new size and threshold should be updated after the old
buffer has been flushed.

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Flush the buffer when the hardware is reprogrammed.
https://lore.kernel.org/lkml/1185d81f-71cc-0428-881a-db4f2cbac823@linux.intel.com/

 arch/x86/events/intel/ds.c | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3a77f4336df7..4639d4c1e98d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1257,20 +1257,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	if (x86_pmu.intel_cap.pebs_baseline && add) {
 		u64 pebs_data_cfg;
 
-		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
-		if (cpuc->n_pebs == 1) {
+		/* Clear pebs_data_cfg for first PEBS. */
+		if (cpuc->n_pebs == 1)
 			cpuc->pebs_data_cfg = 0;
-			cpuc->pebs_record_size = sizeof(struct pebs_basic);
-		}
 
 		pebs_data_cfg = pebs_update_adaptive_cfg(event);
 
-		/* Update pebs_record_size if new event requires more data. */
-		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
+		/*
+		 * Only update the pebs_data_cfg here. The pebs_record_size
+		 * will be updated later when the new pebs_data_cfg takes effect.
+		 */
+		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
 			cpuc->pebs_data_cfg |= pebs_data_cfg;
-			adaptive_pebs_record_size_update();
-			update = true;
-		}
 	}
 
 	if (update)
@@ -1331,6 +1329,13 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
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
@@ -1350,6 +1355,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
 		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
+			/*
+			 * A system-wide PEBS event with the large PEBS
+			 * config may still be enabled when switching the
+			 * context. Some PEBS records for the system-wide
+			 * PEBS may be generated while the old event has
+			 * been scheduled out but the new one hasn't been
+			 * scheduled in. It's not enough to only flush the
+			 * buffer when a PEBS event is disable.
+			 */
+			intel_pmu_drain_large_pebs(cpuc);
+			adaptive_pebs_record_size_update();
+			pebs_update_threshold(cpuc);
 			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
 			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
 		}
@@ -1396,9 +1413,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (cpuc->n_pebs == cpuc->n_large_pebs &&
-	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
-		intel_pmu_drain_pebs_buffer();
+	intel_pmu_drain_large_pebs(cpuc);
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
-- 
2.35.1

