Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4225FC792
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJLOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJLOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:39:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08E844DF0B;
        Wed, 12 Oct 2022 07:39:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DE5113E;
        Wed, 12 Oct 2022 07:39:11 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67A133F792;
        Wed, 12 Oct 2022 07:39:02 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] perf: Fix missing raw data on tracepoint events
Date:   Wed, 12 Oct 2022 15:38:57 +0100
Message-Id: <20221012143857.48198-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
field not being set. Fix this by setting it for tracepoint events.

This fixes the following test failure:

  perf test "sched_switch" -vvv

   35: Track with sched_switch
  --- start ---
  test child forked, pid 1828
  ...
  Using CPUID 0x00000000410fd400
  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
  Missing sched_switch events
  4613 events recorded
  test child finished with -1
  ---- end ----
  Track with sched_switch: FAILED!

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b981b879bcd8..824c23830272 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9759,6 +9759,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
+	data.sample_flags |= PERF_SAMPLE_RAW;
 
 	perf_trace_buf_update(record, event_type);
 
-- 
2.28.0

