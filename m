Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810DE72F283
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbjFNCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbjFNCQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:16:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6E19B6;
        Tue, 13 Jun 2023 19:16:51 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qgpv5727NzTl1c;
        Wed, 14 Jun 2023 10:16:17 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:16:48 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v3] perf stat: Add missing newline in pr_err messages
Date:   Wed, 14 Jun 2023 02:15:05 +0000
Message-ID: <20230614021505.59856-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newline is missing for error messages in add_default_attributes()

Before:

  # perf stat --topdown
  Topdown requested but the topdown metric groups aren't present.
  (See perf list the metric groups have names like TopdownL1)#

After:

  # perf stat --topdown
  Topdown requested but the topdown metric groups aren't present.
  (See perf list the metric groups have names like TopdownL1)
  #

In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
have the same problem, fixed by the way.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---

Changes since v2:
 - Add Acked-by Ian Rogers
 - Add Reviewed-by James Clark
 - Format patch based on the perf-tools-next

Changes since v1:
 - Correct commit title to `pr_err`

 tools/perf/builtin-stat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fc615bdeed4f..692de772f8ae 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1594,7 +1594,7 @@ static int perf_stat_init_aggr_mode(void)
 		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
 							 get_id, /*data=*/NULL, needs_sort);
 		if (!stat_config.aggr_map) {
-			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+			pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
 			return -1;
 		}
 		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
@@ -1910,7 +1910,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
 						 get_id, env, needs_sort);
 	if (!stat_config.aggr_map) {
-		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+		pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
 		return -1;
 	}
 	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
@@ -2050,7 +2050,7 @@ static int add_default_attributes(void)
 		 * on an architecture test for such a metric name.
 		 */
 		if (!metricgroup__has_metric(pmu, "transaction")) {
-			pr_err("Missing transaction metrics");
+			pr_err("Missing transaction metrics\n");
 			return -1;
 		}
 		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
@@ -2066,7 +2066,7 @@ static int add_default_attributes(void)
 		int smi;
 
 		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
-			pr_err("freeze_on_smi is not supported.");
+			pr_err("freeze_on_smi is not supported.\n");
 			return -1;
 		}
 
@@ -2079,7 +2079,7 @@ static int add_default_attributes(void)
 		}
 
 		if (!metricgroup__has_metric(pmu, "smi")) {
-			pr_err("Missing smi metrics");
+			pr_err("Missing smi metrics\n");
 			return -1;
 		}
 
@@ -2104,7 +2104,7 @@ static int add_default_attributes(void)
 
 		if (!max_level) {
 			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
-				"(See perf list the metric groups have names like TopdownL1)");
+				"(See perf list the metric groups have names like TopdownL1)\n");
 			return -1;
 		}
 		if (stat_config.topdown_level > max_level) {
-- 
2.30.GIT

