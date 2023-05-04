Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5558D6F6F96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEDQJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjEDQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:09:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3F98468D;
        Thu,  4 May 2023 09:09:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F761FB;
        Thu,  4 May 2023 09:10:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DBD23F5A1;
        Thu,  4 May 2023 09:09:45 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm64: Fix build with refcount checking
Date:   Thu,  4 May 2023 17:08:45 +0100
Message-Id: <20230504160845.2065510-1-james.clark@arm.com>
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

With EXTRA_CFLAGS=-DREFCNT_CHECKING=1 and build-test, some unwrapped
map accesses appear. Wrap it in the new accessor to fix the error:

  error: 'struct perf_cpu_map' has no member named 'map'

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 4 ++--
 tools/perf/arch/arm64/util/pmu.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index d730666ab95d..80b9f6287fe2 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -29,8 +29,8 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		char path[PATH_MAX];
 		FILE *file;
 
-		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
-				sysfs, cpus->map[cpu]);
+		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR,
+			  sysfs, RC_CHK_ACCESS(cpus)->map[cpu].cpu);
 
 		file = fopen(path, "r");
 		if (!file) {
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index fa143acb4c8d..ef1ed645097c 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -18,7 +18,7 @@ static struct perf_pmu *pmu__find_core_pmu(void)
 		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
 		 * not support some events or have different event IDs.
 		 */
-		if (pmu->cpus->nr != cpu__max_cpu().cpu)
+		if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
 			return NULL;
 
 		return pmu;
-- 
2.34.1

