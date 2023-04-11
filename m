Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB666DD709
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjDKJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDKJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:39:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18019AD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:38:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c08e501d2so149431587b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681205901;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OxGM7YzM2rRHTAnF4chhy2mXMvhPljCtmHwr5DY7Gmc=;
        b=JyKki5fXGNY1U3hqNkJJ6OFPHVy6t48u6Bb0xUbhEan/vovJVUWPKzFZEGU1zcskvb
         ao4hXIzmaVAzyX8w3n/79ncqqpN6TEjDcZa5Ky+nFJkXfpbTq9PHMgAE9kHCLWcEj5AP
         9Da1qw24x667qMgnjN6XEOdW5XkO9MLfsA6VTmbq9uWepV/CgUOn7Ny+TkvH7ANOE8gv
         D7it1x8cKDAFd6rlepzvPdS3fL8JP9QefotYf7uf7icLWfhlSpMRbjgX8wj6svDgyOil
         ilFDNS3gUg6LvhApTPVzif/pb7XihT6CPwIABacJkWv2iuBeV1ougWVJtB/pVlkqP0T3
         1fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681205901;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxGM7YzM2rRHTAnF4chhy2mXMvhPljCtmHwr5DY7Gmc=;
        b=YJY6AQam9gMf2uHfKPTKZS/Ly/A5+MIuf9UnBbFg1T/H4hmFSqtrx6Rxuz2BwCJ8Bw
         Y7FvC0DMMvdHR+9oLOyJZylVYCrbuGU6n9MLbzQoUFYmaighmBkcqt+q8jE8U85OkQf5
         DrM/1rihv1+4pxxdIM3I97yWvw1ERjK/XdYrJSqmlLFiF8C9aqzbFfKOJwmX9cvun017
         dDNF+qdCisLUlwlY1z9+P9nIrNmFl4xsQYtWvKj/o9QDCi/TVJOZPoUfuHrl7Rx97OMr
         fhJ5DLqPtMWMjC+9DOeNgfCdopocQ2FK+EDpXp9KmFJBGeDev4AolnO+/on4hFnNLd6b
         0srQ==
X-Gm-Message-State: AAQBX9fI53mTomAdzWhKJC/nmtfdrvzJh+2aPN6At/8cbsgYs3Zy0f9J
        9ttC+Zzks2OMIbD1jE05ZstR9TMkzvHopFXhzg==
X-Google-Smtp-Source: AKy350bXVwWl37wg5Laav8co4Jdr3w6/uG+MVoZWjEL94L46NdZ6NyoWaqDGaRHK54BHkYXTgJbvL4u5BChJnWCACQ==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:df5f:f4f2:f444:399])
 (user=peternewman job=sendgmr) by 2002:a81:414d:0:b0:544:cd0e:2f80 with SMTP
 id f13-20020a81414d000000b00544cd0e2f80mr5443853ywk.8.1681205901292; Tue, 11
 Apr 2023 02:38:21 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:38:09 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411093809.657501-1-peternewman@google.com>
Subject: [PATCH v6] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
From:   Peter Newman <peternewman@google.com>
To:     will@kernel.org
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        eranian@google.com, irogers@google.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peternewman@google.com,
        peterz@infradead.org
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

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-developed-by: Peter Newman <peternewman@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
---
v5->v6:
 - rebase on Will's for-next/perf
v4->v5:
 - update changelog tags
v3->v4:
 - splice Mark's patch with Stephane's problem statement
v2->v3:
 - removed prints per Will's suggestion
 
[v5] https://lore.kernel.org/lkml/20230403091547.441550-1-peternewman@google.com/
[v4] https://lore.kernel.org/lkml/20230327122527.3913496-1-peternewman@google.com/
[v3] https://lore.kernel.org/all/20220816130221.885920-1-peternewman@google.com/
[v2] https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/

 drivers/perf/arm_pmuv3.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 34ed0d5d7898..c98e4039386d 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -46,7 +46,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
@@ -985,6 +984,28 @@ static void armv8pmu_reset(void *info)
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
@@ -996,9 +1017,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	int hw_event_id;
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
-	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				       &armv8_pmuv3_perf_cache_map,
-				       ARMV8_PMU_EVTYPE_EVENT);
+	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it

base-commit: 4248d043e462bd43dbef60164d35b817d5664eb1
-- 
2.40.0.577.gac1e443424-goog

