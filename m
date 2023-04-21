Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E636EB1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjDUSp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDUSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:45:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74094173A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682102753; x=1713638753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gj29/8RHpZU2aU2OLpmCoOn/WQFnEXB7WJK3pS9JWYs=;
  b=BKkfpEhlXpI9ePf4UBsr9G9omK1ZydEAXegu5y0G/cJ930jIlyNWxHor
   ZcHT+VOtxMwB35wGHdZ5LWrEzsKryjb+HVksTsLqxLgQhZrUgMPTNP65Y
   szlJs/KXK2U65l6bjRCkwoh6hEVXEHgAqDUe4l6yyIJ9JAZVWeOYNUBIE
   OlmvsYcOt3L2kOfuGr5E9TjRS/9tcS9uhgMuYgKndEawXLUu8rIAZJOTW
   J2lHrnZZICM00YztR9GWyKzxMhEptyYGxlUa7c9TR6aHh7uwHjs/m4JDD
   kWyOyC7g+og7sJKvmbpa1JDnbUlNRM9FNzAK0TdGDmr8cAMlRfBb8P3XI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348850427"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348850427"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 11:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="1022004493"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="1022004493"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2023 11:45:52 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/2] perf/x86/intel/ds: Flush the PEBS buffer in PEBS enable
Date:   Fri, 21 Apr 2023 11:45:28 -0700
Message-Id: <20230421184529.3320912-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since V3:
- update comments

 arch/x86/events/intel/ds.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a2e566e53076..94043232991c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1252,22 +1252,26 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
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
 
+	/*
+	 * For the adaptive PEBS, the threshold will be updated later
+	 * when the new pebs_data_cfg takes effect.
+	 * The threshold may not be accurate before that, but that
+	 * does not hurt.
+	 */
 	if (update)
 		pebs_update_threshold(cpuc);
 }
@@ -1326,6 +1330,13 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
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
@@ -1345,6 +1356,14 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
 		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
+			/*
+			 * drain_pebs() assumes uniform record size;
+			 * hence we need to drain when changing said
+			 * size.
+			 */
+			intel_pmu_drain_large_pebs(cpuc);
+			adaptive_pebs_record_size_update();
+			pebs_update_threshold(cpuc);
 			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
 			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
 		}
@@ -1391,9 +1410,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (cpuc->n_pebs == cpuc->n_large_pebs &&
-	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
-		intel_pmu_drain_pebs_buffer();
+	intel_pmu_drain_large_pebs(cpuc);
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
-- 
2.35.1

