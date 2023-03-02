Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777616A79D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCBDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBDMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:12:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D134F48E1B;
        Wed,  1 Mar 2023 19:12:23 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PRx1S4xBxz9tG7;
        Thu,  2 Mar 2023 11:10:20 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:12:19 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 1/3] perf stat: fix counting when initial delay configured
Date:   Thu, 2 Mar 2023 11:11:44 +0800
Message-ID: <20230302031146.2801588-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302031146.2801588-1-changbin.du@huawei.com>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating counters with initial delay configured, the enable_on_exec
field is not set. So we need to enable the counters later. The problem
is, when a workload is specified the target__none() is true. So we also
need to check stat_config.initial_delay.

In this change, we add a new field 'initial_delay' for struct target which
could be shared by other subcommands. And define target__enable_on_exec()
which returns whether enable_on_exec should be set on normal cases.

Before this fix the event is not counted:
$ ./perf stat -e instructions -D 100 sleep 2
Events disabled
Events enabled

 Performance counter stats for 'sleep 2':

     <not counted>      instructions

       1.901661124 seconds time elapsed

       0.001602000 seconds user
       0.000000000 seconds sys

After fix it works:
$ ./perf stat -e instructions -D 100 sleep 2
Events disabled
Events enabled

 Performance counter stats for 'sleep 2':

           404,214      instructions

       1.901743475 seconds time elapsed

       0.001617000 seconds user
       0.000000000 seconds sys

Fixes: c587e77e100f ("perf stat: Do not delay the workload with --delay")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-stat.c | 15 +++++----------
 tools/perf/util/stat.c    |  6 +-----
 tools/perf/util/stat.h    |  1 -
 tools/perf/util/target.h  | 12 ++++++++++++
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5d18a5a6f662..fa7c40956d0f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -539,12 +539,7 @@ static int enable_counters(void)
 			return err;
 	}
 
-	/*
-	 * We need to enable counters only if:
-	 * - we don't have tracee (attaching to task or cpu)
-	 * - we have initial delay configured
-	 */
-	if (!target__none(&target)) {
+	if (!target__enable_on_exec(&target)) {
 		if (!all_counters_use_bpf)
 			evlist__enable(evsel_list);
 	}
@@ -914,7 +909,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 	}
 
-	if (stat_config.initial_delay) {
+	if (target.initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 	} else {
 		err = enable_counters();
@@ -926,8 +921,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (forks)
 		evlist__start_workload(evsel_list);
 
-	if (stat_config.initial_delay > 0) {
-		usleep(stat_config.initial_delay * USEC_PER_MSEC);
+	if (target.initial_delay > 0) {
+		usleep(target.initial_delay * USEC_PER_MSEC);
 		err = enable_counters();
 		if (err)
 			return -1;
@@ -1248,7 +1243,7 @@ static struct option stat_options[] = {
 		     "aggregate counts per thread", AGGR_THREAD),
 	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
 		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
+	OPT_INTEGER('D', "delay", &target.initial_delay,
 		    "ms to wait before starting measurement after program start (-1: start with events disabled)"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 534d36d26fc3..a07473703c6d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -842,11 +842,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	if (evsel__is_group_leader(evsel)) {
 		attr->disabled = 1;
 
-		/*
-		 * In case of initial_delay we enable tracee
-		 * events manually.
-		 */
-		if (target__none(target) && !config->initial_delay)
+		if (target__enable_on_exec(target))
 			attr->enable_on_exec = 1;
 	}
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b1c29156c560..bf1794ebc916 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -166,7 +166,6 @@ struct perf_stat_config {
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-	int			 initial_delay;
 	unsigned int		 unit_width;
 	unsigned int		 metric_only_len;
 	int			 times;
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index daec6cba500d..880f1af7f6ad 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -18,6 +18,7 @@ struct target {
 	bool	     per_thread;
 	bool	     use_bpf;
 	bool	     hybrid;
+	int	     initial_delay;
 	const char   *attr_map;
 };
 
@@ -72,6 +73,17 @@ static inline bool target__none(struct target *target)
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
+static inline bool target__enable_on_exec(struct target *target)
+{
+	/*
+	 * Normally enable_on_exec should be set if:
+	 *  1) The tracee process is forked (not attaching to existed task or cpu).
+	 *  2) And initial_delay is not configured.
+	 * Otherwise, we enable tracee events manually.
+	 */
+	return target__none(target) && !target->initial_delay;
+}
+
 static inline bool target__has_per_thread(struct target *target)
 {
 	return target->system_wide && target->per_thread;
-- 
2.25.1

