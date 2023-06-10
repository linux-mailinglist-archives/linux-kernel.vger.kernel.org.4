Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7872AAB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjFJJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:46:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3BF2D41;
        Sat, 10 Jun 2023 02:46:22 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QdXyb6TvkzqSJ1;
        Sat, 10 Jun 2023 17:41:27 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 17:46:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v2] perf stat: Add missing newline in pr_err messages
Date:   Sat, 10 Jun 2023 09:44:41 +0000
Message-ID: <20230610094441.221525-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
---

Changes since v1:
 - Correct commit title to `pr_err`

 tools/perf/builtin-stat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b9ad32f21e57..78644ae538c4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1398,7 +1398,7 @@ static int perf_stat_init_aggr_mode(void)
 		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
 							 get_id, /*data=*/NULL, needs_sort);
 		if (!stat_config.aggr_map) {
-			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+			pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
 			return -1;
 		}
 		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
@@ -1650,7 +1650,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
 						 get_id, env, needs_sort);
 	if (!stat_config.aggr_map) {
-		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+		pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
 		return -1;
 	}
 	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
@@ -1789,7 +1789,7 @@ static int add_default_attributes(void)
 		 * on an architecture test for such a metric name.
 		 */
 		if (!metricgroup__has_metric("transaction")) {
-			pr_err("Missing transaction metrics");
+			pr_err("Missing transaction metrics\n");
 			return -1;
 		}
 		return metricgroup__parse_groups(evsel_list, "transaction",
@@ -1805,7 +1805,7 @@ static int add_default_attributes(void)
 		int smi;
 
 		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
-			pr_err("freeze_on_smi is not supported.");
+			pr_err("freeze_on_smi is not supported.\n");
 			return -1;
 		}
 
@@ -1818,7 +1818,7 @@ static int add_default_attributes(void)
 		}
 
 		if (!metricgroup__has_metric("smi")) {
-			pr_err("Missing smi metrics");
+			pr_err("Missing smi metrics\n");
 			return -1;
 		}
 
@@ -1843,7 +1843,7 @@ static int add_default_attributes(void)
 
 		if (!max_level) {
 			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
-				"(See perf list the metric groups have names like TopdownL1)");
+				"(See perf list the metric groups have names like TopdownL1)\n");
 			return -1;
 		}
 		if (stat_config.topdown_level > max_level) {
-- 
2.30.GIT

