Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D336EF560
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbjDZNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbjDZNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:18:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C59170A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7jzFUV2HyNSO4J3Oa2A0SQg9y7+OYpeSpEKp3ww0c4=; b=m6z0rkqkyowXTr86u0aKKfyVeO
        K1IT6EDiPxYLcdV1NgijKVUq5FL8xW5Fw7E1eLijU2h/EHKB3nsUyuhB3X0iNNXCeedzZd9LX4ub3
        seCtY3NLtcsYoTW1nKtkVBUxZCHcNqlcFFCtYwoIrL2X5P82/AULTqE64qQXaLxXACnwZrPtvX2u8
        mka9Ah0Pf+pxlUAxuUhZUNN0RniA77K7JUsp3JTiyoQlHxQ/ehNsie5cYq8ArqTwfFOjEvSz6o3Gk
        KbROywNqxeJjPb9Tdw2jKgUSv4SgjugNVBKMSFpzWiZqXmqXrYGxBHJrfnd28euxU53ostPOb6cG0
        ZU6dAdww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prf2E-002UvU-MF; Wed, 26 Apr 2023 13:18:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3233230005E;
        Wed, 26 Apr 2023 15:18:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15FCB30B02550; Wed, 26 Apr 2023 15:18:13 +0200 (CEST)
Date:   Wed, 26 Apr 2023 15:18:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V4 1/2] perf/x86/intel/ds: Flush the PEBS buffer in PEBS
 enable
Message-ID: <20230426131812.GA1377058@hirez.programming.kicks-ass.net>
References: <20230421184529.3320912-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421184529.3320912-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:45:28AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Several similar kernel warnings can be triggered,
> 
>   [56605.607840] CPU0 PEBS record size 0, expected 32, config 0
>   cpuc->record_size=208
> 
> when the below commands are running in parallel for a while on SPR.
> 
>   while true; do perf record --no-buildid -a --intr-regs=AX -e
>   cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &
> 
>   while true; do perf record -o /tmp/out -W -d -e
>   '{ld_blocks.store_forward:period=1000000,
>   MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
>   -c 1037 ./triad; done
>   *The triad program is just the generation of loads/stores.
> 
> The warnings are triggered when an unexpected PEBS record (with a
> different config and size) is found.
> 
> A system-wide PEBS event with the large PEBS config may be enabled
> during a context switch. Some PEBS records for the system-wide PEBS may
> be generated while the old task is sched out but the new one hasn't been
> sched in yet. When the new task is sched in, the cpuc->pebs_record_size
> may be updated for the per-task PEBS events. So the existing system-wide
> PEBS records have a different size from the later PEBS records.
> 
> The PEBS buffer should be flushed right before the hardware is
> reprogrammed. The new size and threshold should be updated after the old
> buffer has been flushed.
> 
> Reported-by: Stephane Eranian <eranian@google.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

So I find it much easier to read the whole thing when collapsed.
Something like the below; that ok with you?

---
 arch/x86/events/intel/ds.c        | 56 ++++++++++++++++++++++-----------------
 arch/x86/include/asm/perf_event.h |  3 +++
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a2e566e53076..df88576d6b2a 100644
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
index 8fc15ed5e60b..abf09882f58b 100644
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
