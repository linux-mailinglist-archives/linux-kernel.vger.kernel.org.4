Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE826D4001
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjDCJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjDCJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:16:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0A1040D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:16:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so13119706ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680513371;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oOBOcidFD52mr0nHF1MZQO6G+xL8UJJoT29DA6+kD5M=;
        b=U+awEBpsQrO+YcypjIJ44XmrE+Z/5jhRdtWiOZu5SPfWo4nxy4kRiW0ppUZKcHmBFc
         U7wUdiQ2EkiGOMqyrcE5WNHN55LXhRVjlS67UQxgmnYrU/s4erPOIAVSsNJzQm7uG4Va
         RFTXD7fT9KQJ5butgxHOwZKepOAtbp+sVf7EITVC8q7KXGgEfkW8Epfq0q6KlRHwHzZ1
         8gAL/4c2HgyDtOT42vytqGik3ldKOAT3vnKxoiumX9oLbwJhtuSjycc8JDu0N2HcQ5KV
         rvxzgiieAcPoNgj0roKhXT0tdcH2pqgC8OjKBzNSeLBkUB0KwKq17C/O80Z4xO5HEC6D
         4Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOBOcidFD52mr0nHF1MZQO6G+xL8UJJoT29DA6+kD5M=;
        b=veJN3vKlphc22FKnM89CiOv8uunknFTOLBxG29vYBbZG0LtvIoXlpRJ3H96gREjMI5
         649jqvGfcVpjilQgEvO7k95UGyhJb5075fKIMZsnZNKakjZpO4AhAqlkqqleX11VxE1I
         MV8NQ6RyDeuSjy5hPbjZzB4SiUjo9/Y/FM1NSaA9Xj8ATg1739EBOL1IfGUwUCilgNPk
         EyYVz9rpxQaG0qlJ6fY1txSJZl9E2QGo8mIxHI6P7Oh0NquhS/dDAto59Pa8iGKvt79V
         03PbiGhZDiV7kG5isf6f37sT4MfzesjA3YEwSm/KEKnK9XX00UEsD82w9TDvHskdpTd+
         r+MA==
X-Gm-Message-State: AAQBX9fFXFpz/BiLgVrfZUsilo/Cav8me6BYvjFUWjFpLzpS+uGzL0tX
        qoTawCQu5tFHg0ZfnPs7rwPaLnQO8fSTpa3ElA==
X-Google-Smtp-Source: AKy350asH3jkh9RPehWVzkcrZy5ko5YNd2dBWf3ur6JlNEb8PyxtVSj9rcv/YcPQHLdIMMH23U8d1HYmSTnb07Z3uw==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:326b:2eb7:dac2:a97e])
 (user=peternewman job=sendgmr) by 2002:a81:af23:0:b0:541:8c77:93b1 with SMTP
 id n35-20020a81af23000000b005418c7793b1mr16834275ywh.8.1680513371147; Mon, 03
 Apr 2023 02:16:11 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:15:47 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230403091547.441550-1-peternewman@google.com>
Subject: [PATCH v5] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
From:   Peter Newman <peternewman@google.com>
To:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        eranian@google.com, irogers@google.com, jolsa@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        will@kernel.org, Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The mapping of perf_events generic hardware events to actual PMU events on
ARM PMUv3 may not always be correct. This is in particular true for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
architected event, it may not always be available. This can be seen with a
simple:

$ perf stat -e branches sleep 0
 Performance counter stats for 'sleep 0':

   <not supported>      branches

       0.001401081 seconds time elapsed

Yet the hardware does have an event that could be used for branches.

Dynamically check for a supported hardware event which can be used for
PERF_COUNT_HW_BRANCH_INSTRUCTIONS at mapping time.

And with that:

$ perf stat -e branches sleep 0

 Performance counter stats for 'sleep 0':

           166,739      branches

       0.000832163 seconds time elapsed

Co-Developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Co-Developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-Developed-by: Peter Newman <peternewman@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
---
v4->v5:
 - update changelog tags
v3->v4:
 - splice Mark's patch with Stephane's problem statement
v2->v3:
 - removed prints per Will's suggestion
 
[v4] https://lore.kernel.org/lkml/20230327122527.3913496-1-peternewman@google.com/
[v3] https://lore.kernel.org/all/20220816130221.885920-1-peternewman@google.com/
[v2] https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/

 arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index dde06c0f97f3..ee63f8e719ea 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -45,7 +45,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
@@ -1048,6 +1047,28 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_pmcr_write(pmcr);
 }
 
+static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
+				      struct perf_event *event)
+{
+	if (event->attr.type == PERF_TYPE_HARDWARE &&
+	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
+
+		return HW_OP_UNSUPPORTED;
+	}
+
+	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				&armv8_pmuv3_perf_cache_map,
+				ARMV8_PMU_EVTYPE_EVENT);
+}
+
 static int __armv8_pmuv3_map_event(struct perf_event *event,
 				   const unsigned (*extra_event_map)
 						  [PERF_COUNT_HW_MAX],
@@ -1059,9 +1080,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	int hw_event_id;
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
-	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				       &armv8_pmuv3_perf_cache_map,
-				       ARMV8_PMU_EVTYPE_EVENT);
+	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it

base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
-- 
2.40.0.423.gd6c402a77b-goog

