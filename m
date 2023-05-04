Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440426F6DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjEDOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:49:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B4FDCF;
        Thu,  4 May 2023 07:49:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E8F22F4;
        Thu,  4 May 2023 07:49:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 915C23F5A1;
        Thu,  4 May 2023 07:49:06 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf cs-etm: Fix contextid validation
Date:   Thu,  4 May 2023 15:48:22 +0100
Message-Id: <20230504144822.1938717-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pre 5.11 kernels don't support 'contextid1' and 'contextid2' so
validation would be skipped. By adding an additional check for
'contextid', old kernels will still have validation done even though
contextid would either be contextid1 or contextid2.

Additionally now that it's possible to override options, an existing bug
in the validation is revealed. 'val' is overwritten by the contextid1
validation, and re-used for contextid2 validation causing it to always
fail. '!val || val != 0x4' is the same as 'val != 0x4' because 0 is also
!= 4, so that expression can be simplified and the temp variable not
overwritten.

Fixes: 35c51f83dd1e ("perf cs-etm: Validate options after applying them")
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Link: https://lore.kernel.org/all/20230501073452.GA4660@leoy-yangtze.lan
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 77cb03e6ff87..9ca040bfb1aa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -78,9 +78,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 	char path[PATH_MAX];
 	int err;
 	u32 val;
-	u64 contextid =
-		evsel->core.attr.config &
-		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
+	u64 contextid = evsel->core.attr.config &
+		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
+		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
 		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
 
 	if (!contextid)
@@ -114,8 +114,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 		 *  0b00100 Maximum of 32-bit Context ID size.
 		 *  All other values are reserved.
 		 */
-		val = BMVAL(val, 5, 9);
-		if (!val || val != 0x4) {
+		if (BMVAL(val, 5, 9) != 0x4) {
 			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
 			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 			return -EINVAL;
-- 
2.34.1

