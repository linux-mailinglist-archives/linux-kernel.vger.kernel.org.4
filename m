Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468D6519D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 05:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiLTD77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiLTD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:59:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB04911A08;
        Mon, 19 Dec 2022 19:59:51 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NbjRT3jw0zHqXB;
        Tue, 20 Dec 2022 11:56:05 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 11:59:49 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <ravi.bangoria@amd.com>, <martin.lau@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <masami.hiramatsu.pt@hitachi.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 2/3] perf tools: Fix usage of the verbose variable
Date:   Tue, 20 Dec 2022 11:57:01 +0800
Message-ID: <20221220035702.188413-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221220035702.188413-1-yangjihong1@huawei.com>
References: <20221220035702.188413-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data type of the verbose variable is integer and can be negative,
replace improperly used cases in a unified manner:
 1. if (verbose)        => if (verbose > 0)
 2. if (!verbose)       => if (verbose <= 0)
 3. if (XX && verbose)  => if (XX && verbose > 0)
 4. if (XX && !verbose) => if (XX && verbose <= 0)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-lock.c                   | 6 +++---
 tools/perf/builtin-record.c                 | 4 ++--
 tools/perf/builtin-script.c                 | 2 +-
 tools/perf/builtin-stat.c                   | 4 ++--
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 2 +-
 tools/perf/tests/builtin-test.c             | 2 +-
 tools/perf/tests/dlfilter-test.c            | 2 +-
 tools/perf/util/bpf_lock_contention.c       | 2 +-
 tools/perf/util/dlfilter.c                  | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 25c0a5e5051f..6276dfbc94a1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1029,7 +1029,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		if (!ls)
 			return -ENOMEM;
 
-		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
+		if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
 			ls->callstack = get_callstack(sample, max_stack_depth);
 			if (ls->callstack == NULL)
 				return -ENOMEM;
@@ -1214,7 +1214,7 @@ static void print_bad_events(int bad, int total)
 	for (i = 0; i < BROKEN_MAX; i++)
 		broken += bad_hist[i];
 
-	if (quiet || (broken == 0 && !verbose))
+	if (quiet || (broken == 0 && verbose <= 0))
 		return;
 
 	pr_info("\n=== output for debug===\n\n");
@@ -1529,7 +1529,7 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 		}
 
-		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
+		if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
 			struct map *kmap;
 			struct symbol *sym;
 			char buf[128];
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ecffa696ce3..29dcd454b8e2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3629,7 +3629,7 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	for (t = 0; t < rec->nr_threads; t++) {
 		__set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
 		__set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
-		if (verbose) {
+		if (verbose > 0) {
 			pr_debug("thread_masks[%d]: ", t);
 			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
 			pr_debug("thread_masks[%d]: ", t);
@@ -3726,7 +3726,7 @@ static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_ma
 		}
 		rec->thread_masks = thread_masks;
 		rec->thread_masks[t] = thread_mask;
-		if (verbose) {
+		if (verbose > 0) {
 			pr_debug("thread_masks[%d]: ", t);
 			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
 			pr_debug("thread_masks[%d]: ", t);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 88888fb885c8..69394ac0a20d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2233,7 +2233,7 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(METRIC))
 		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
 
-	if (verbose)
+	if (verbose > 0)
 		fflush(fp);
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bf640abc9c41..9f3e4b257516 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -266,7 +266,7 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		evsel__group_desc(leader, buf, sizeof(buf));
 		pr_warning("  %s\n", buf);
 
-		if (verbose) {
+		if (verbose > 0) {
 			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
 			pr_warning("     %s: %s\n", leader->name, buf);
 			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
@@ -2493,7 +2493,7 @@ int cmd_stat(int argc, const char **argv)
 		if (iostat_mode == IOSTAT_LIST) {
 			iostat_list(evsel_list, &stat_config);
 			goto out;
-		} else if (verbose)
+		} else if (verbose > 0)
 			iostat_list(evsel_list, &stat_config);
 		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
 			target.system_wide = true;
diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index b17eb52a0694..b1f51efd67d6 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -119,7 +119,7 @@ struct perf_dlfilter_fns perf_dlfilter_fns;
 static int verbose;
 
 #define pr_debug(fmt, ...) do { \
-		if (verbose) \
+		if (verbose > 0) \
 			fprintf(stderr, fmt, ##__VA_ARGS__); \
 	} while (0)
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f6c16ad8ed50..cfa61493c750 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -305,7 +305,7 @@ static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
 
 	path__join(script, sizeof(script) - 3, st->dir, st->file);
 
-	if (verbose)
+	if (verbose > 0)
 		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
 
 	err = system(script);
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 99aa72e425e4..086fd2179e41 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -88,7 +88,7 @@ static __printf(1, 2) int system_cmd(const char *fmt, ...)
 	if (ret <= 0 || ret >= MAXCMD)
 		return -1;
 
-	if (!verbose)
+	if (verbose <= 0)
 		strcat(cmd, REDIRECT_TO_DEV_NULL);
 
 	pr_debug("Command: %s\n", cmd);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 8e1b791dc58f..df8dbb5191b4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -215,7 +215,7 @@ int lock_contention_read(struct lock_contention *con)
 			break;
 		}
 
-		if (verbose) {
+		if (verbose > 0) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
 				break;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 54e4d4495e00..37beb7530288 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -579,7 +579,7 @@ static void list_filters(const char *dirname)
 		if (!get_filter_desc(dirname, entry->d_name, &desc, &long_desc))
 			continue;
 		printf("  %-36s %s\n", entry->d_name, desc ? desc : "");
-		if (verbose) {
+		if (verbose > 0) {
 			char *p = long_desc;
 			char *line;
 
-- 
2.30.GIT

