Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAB6B035E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCHJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCHJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:50:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB031B2F0;
        Wed,  8 Mar 2023 01:50:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67508113E;
        Wed,  8 Mar 2023 01:50:44 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 839853F71A;
        Wed,  8 Mar 2023 01:49:57 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, al.grant@arm.com,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] perf cs-etm: Reduce verbosity of ts_source warning
Date:   Wed,  8 Mar 2023 09:48:42 +0000
Message-Id: <20230308094843.287093-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is printed as a warning but it is normal behavior that users
shouldn't be expected to do anything about. Reduce the warning level to
debug3 so it's only seen in verbose mode to avoid confusion.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 7f71c8a237ff..59b50dd70330 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -694,8 +694,8 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 		data[CS_ETMV4_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
 				metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]);
 	else {
-		pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
-			   cpu);
+		pr_debug3("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
+			  cpu);
 		data[CS_ETMV4_TS_SOURCE] = (__u64) -1;
 	}
 }
@@ -729,8 +729,8 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, in
 		data[CS_ETE_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
 				metadata_ete_ro[CS_ETE_TS_SOURCE]);
 	else {
-		pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
-			   cpu);
+		pr_debug3("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
+			  cpu);
 		data[CS_ETE_TS_SOURCE] = (__u64) -1;
 	}
 }
-- 
2.34.1

