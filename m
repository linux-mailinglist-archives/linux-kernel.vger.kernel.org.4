Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A706EB1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjDUSqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjDUSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:46:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EE1BD4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682102757; x=1713638757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtXqDpaUMTDNmzTTwXyzsupMupYjcyBu6Vb73+EN3Mg=;
  b=jqHYkohTjoK+GuHLcpkPMR8AoUaDMvWpk3DRyOgeXOj+BOLYGO4v1q3R
   XF4Ee8Mo05M1toA2VZbquwt/LfQ/q7crKa5j4LKI3E0Ydocgtt5zp2tHp
   v2zE+r7fU12h9JPkvQuiTsPPKfTpwio3qJdoM8kog9fjKwGtDzaiByz25
   C5JCk6JnEBjLoLgnFec+iUA/dhjXw7lG8cY+2pX5xeiimbq0iFtdiL41t
   d5NvhK3SsygoyQFJxbfrcljeyEWyHQoPWWKaXZk1NbcRTUyEnouhBZufg
   6xncMaIqBEMt6+HOQRpERkojFjOS+5sfPQZ1MZHUPfmvNPqImn1DuJzUB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348850432"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348850432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 11:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="1022004494"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="1022004494"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2023 11:45:53 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
Date:   Fri, 21 Apr 2023 11:45:29 -0700
Message-Id: <20230421184529.3320912-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230421184529.3320912-1-kan.liang@linux.intel.com>
References: <20230421184529.3320912-1-kan.liang@linux.intel.com>
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

The update of the pebs_record_size has been delayed to the place right
before the new pebs_data_cfg takes effect for the adaptive PEBS. But the
update of the DS threshold is still in the event_add stage. The
threshold is calculated from the pebs_record_size. So it may contain
inaccurate data. The data will be corrected in the event_enable stage.
So there is no real harm. But the logic is quite a mess and hard to
follow.

Move the threshold update to the event_enable stage where all the
configures have been settled down.

Steal the highest bit of cpuc->pebs_data_cfg to track whether the
threshold update is required. Just need to update the threshold once.

It's possible that the first event is eligible for the large PEBS,
while the second event is not. The current perf implementation may
update the threshold twice in the event_add stage. This patch could
also improve such kind of cases by avoiding the extra update.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

This is a cleanup patch to address the comment.
https://lore.kernel.org/lkml/20230414102908.GC83892@hirez.programming.kicks-ass.net/
It doesn't fix any real issues. It just tries to make the logic clear and
consistent.

 arch/x86/events/intel/ds.c        | 34 ++++++++++++-------------------
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 94043232991c..554a58318787 100644
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
@@ -1252,28 +1254,15 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	if (x86_pmu.intel_cap.pebs_baseline && add) {
 		u64 pebs_data_cfg;
 
-		/* Clear pebs_data_cfg for first PEBS. */
-		if (cpuc->n_pebs == 1)
-			cpuc->pebs_data_cfg = 0;
-
 		pebs_data_cfg = pebs_update_adaptive_cfg(event);
 
 		/*
 		 * Only update the pebs_data_cfg here. The pebs_record_size
 		 * will be updated later when the new pebs_data_cfg takes effect.
 		 */
-		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
-			cpuc->pebs_data_cfg |= pebs_data_cfg;
+		if (pebs_data_cfg & ~get_pebs_datacfg_hw(cpuc->pebs_data_cfg))
+			cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
 	}
-
-	/*
-	 * For the adaptive PEBS, the threshold will be updated later
-	 * when the new pebs_data_cfg takes effect.
-	 * The threshold may not be accurate before that, but that
-	 * does not hurt.
-	 */
-	if (update)
-		pebs_update_threshold(cpuc);
 }
 
 void intel_pmu_pebs_add(struct perf_event *event)
@@ -1355,7 +1344,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
-		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
+		if (get_pebs_datacfg_hw(cpuc->pebs_data_cfg) != cpuc->active_pebs_data_cfg) {
 			/*
 			 * drain_pebs() assumes uniform record size;
 			 * hence we need to drain when changing said
@@ -1363,11 +1352,14 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 			 */
 			intel_pmu_drain_large_pebs(cpuc);
 			adaptive_pebs_record_size_update();
-			pebs_update_threshold(cpuc);
-			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
-			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
+			wrmsrl(MSR_PEBS_DATA_CFG, get_pebs_datacfg_hw(cpuc->pebs_data_cfg));
+			cpuc->active_pebs_data_cfg = get_pebs_datacfg_hw(cpuc->pebs_data_cfg);
 		}
 	}
+	if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
+		cpuc->pebs_data_cfg &= ~PEBS_UPDATE_DS_SW;
+		pebs_update_threshold(cpuc);
+	}
 
 	if (idx >= INTEL_PMC_IDX_FIXED) {
 		if (x86_pmu.intel_cap.pebs_format < 5)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..259a2a8afe2b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -121,6 +121,14 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_LBR_SHIFT	24
 
+/* Steal the highest bit of pebs_data_cfg for SW usage */
+#define PEBS_UPDATE_DS_SW	BIT_ULL(63)
+
+static inline u64 get_pebs_datacfg_hw(u64 config)
+{
+	return config & ~PEBS_UPDATE_DS_SW;
+}
+
 /*
  * Intel "Architectural Performance Monitoring" CPUID
  * detection/enumeration details:
-- 
2.35.1

