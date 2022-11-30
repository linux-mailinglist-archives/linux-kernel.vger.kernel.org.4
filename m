Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94263D420
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiK3LPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiK3LPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:15:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959EE2791F;
        Wed, 30 Nov 2022 03:15:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F8B1042;
        Wed, 30 Nov 2022 03:15:42 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC2B83F73B;
        Wed, 30 Nov 2022 03:15:34 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf stat: Fix invalid output handle
Date:   Wed, 30 Nov 2022 11:15:21 +0000
Message-Id: <20221130111521.334152-2-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130111521.334152-1-james.clark@arm.com>
References: <20221130111521.334152-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this context, 'os' is already a pointer so the extra dereference
isn't required. This fixes the following test failure on aarch64:

  $ ./perf test "json output" -vvv
  92: perf stat JSON output linter                                    :
  --- start ---
  Checking json output: no args Test failed for input:
  ...
  Fatal error: glibc detected an invalid stdio handle
  ---- end ----
  perf stat JSON output linter: FAILED!

Fixes: e7f4da312259 ("perf stat: Pass struct outstate to printout()")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 847acdb5dc40..eac5ac3a734c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -741,7 +741,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		perf_stat__print_shadow_stats(config, counter, uval, map_idx,
 					      &out, &config->metric_events, &rt_stat);
 	} else {
-		pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
+		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
 
 	if (!config->metric_only) {
-- 
2.25.1

