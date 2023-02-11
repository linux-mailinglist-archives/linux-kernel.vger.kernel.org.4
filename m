Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9569300B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBKKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:38:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DEC20D2B;
        Sat, 11 Feb 2023 02:38:25 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zvoRWe8d4RiHsK7K2t4FuOGTF/jtKq6uzColTL/LSJk=;
        b=uK2A267bSzItEoZx7/mC3oOOTDTrkLlbknImidujzGa38x3zpZSywkyliKGtxjPQ4+AAxq
        rMeYSOoj2A5Plywslp0vk1tVlI3UtX3CwgFuOU7Wqr+kUCVQWUYtUPG0mkm+IrdNMNa11q
        MEo4uptHikb4mZuUxE0PQEV2cKcZiRJwu3o2SAgA2kc2oShiQGQzLN5w4jFKSY7DYe56IX
        rNrJZuYhy/jJrrLJLXWKVmKxl85MbLAK2ob0ThT6t/mFKgALR10fA6sUMArsrWlROMTGuE
        6ecRjMdZkak2Ff3W4Kymw/y2RGoW4Zn+F7O+CdG0Kl3ef7c3VL78kKUaSDb7mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zvoRWe8d4RiHsK7K2t4FuOGTF/jtKq6uzColTL/LSJk=;
        b=PUcCHPchELf3k11pnpd3mDFNgOQAfI0uw+aJsfxpgvwXIbe7yejd8PZKd1TFi1SqkhfUCO
        uO8cWGOKwCprLGBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Fix the conversion from TSC to perf time
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167611190335.4906.6861477771600380027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     89e97eb8cec0f1af5ebf2380308913256ca7915a
Gitweb:        https://git.kernel.org/tip/89e97eb8cec0f1af5ebf2380308913256ca7915a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Jan 2023 12:49:25 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:12 +01:00

perf/x86/intel/ds: Fix the conversion from TSC to perf time

The time order is incorrect when the TSC in a PEBS record is used.

 $perf record -e cycles:upp dd if=/dev/zero of=/dev/null
  count=10000
 $ perf script --show-task-events
       perf-exec     0     0.000000: PERF_RECORD_COMM: perf-exec:915/915
              dd   915   106.479872: PERF_RECORD_COMM exec: dd:915/915
              dd   915   106.483270: PERF_RECORD_EXIT(915:915):(914:914)
              dd   915   106.512429:          1 cycles:upp:
 ffffffff96c011b7 [unknown] ([unknown])
 ... ...

The perf time is from sched_clock_cpu(). The current PEBS code
unconditionally convert the TSC to native_sched_clock(). There is a
shift between the two clocks. If the TSC is stable, the shift is
consistent, __sched_clock_offset. If the TSC is unstable, the shift has
to be calculated at runtime.

This patch doesn't support the conversion when the TSC is unstable. The
TSC unstable case is a corner case and very unlikely to happen. If it
happens, the TSC in a PEBS record will be dropped and fall back to
perf_event_clock().

Fixes: 47a3aeb39e8d ("perf/x86/intel/pebs: Fix PEBS timestamps overwritten")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com/
---
 arch/x86/events/intel/ds.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 183efa9..b0354dc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2,12 +2,14 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/sched/clock.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
 #include <asm/io.h>
+#include <asm/timer.h>
 
 #include "../perf_event.h"
 
@@ -1568,6 +1570,27 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+static void setup_pebs_time(struct perf_event *event,
+			    struct perf_sample_data *data,
+			    u64 tsc)
+{
+	/* Converting to a user-defined clock is not supported yet. */
+	if (event->attr.use_clockid != 0)
+		return;
+
+	/*
+	 * Doesn't support the conversion when the TSC is unstable.
+	 * The TSC unstable case is a corner case and very unlikely to
+	 * happen. If it happens, the TSC in a PEBS record will be
+	 * dropped and fall back to perf_event_clock().
+	 */
+	if (!using_native_sched_clock() || !sched_clock_stable())
+		return;
+
+	data->time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
+	data->sample_flags |= PERF_SAMPLE_TIME;
+}
+
 #define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
 				 PERF_SAMPLE_PHYS_ADDR |	\
 				 PERF_SAMPLE_DATA_PAGE_SIZE)
@@ -1715,11 +1738,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 *
 	 * We can only do this for the default trace clock.
 	 */
-	if (x86_pmu.intel_cap.pebs_format >= 3 &&
-		event->attr.use_clockid == 0) {
-		data->time = native_sched_clock_from_tsc(pebs->tsc);
-		data->sample_flags |= PERF_SAMPLE_TIME;
-	}
+	if (x86_pmu.intel_cap.pebs_format >= 3)
+		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
 		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
@@ -1781,10 +1801,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
-	if (event->attr.use_clockid == 0) {
-		data->time = native_sched_clock_from_tsc(basic->tsc);
-		data->sample_flags |= PERF_SAMPLE_TIME;
-	}
+	setup_pebs_time(event, data, basic->tsc);
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
