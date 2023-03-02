Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45C6A79D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCBDMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCBDM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:12:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675E4C6F2;
        Wed,  1 Mar 2023 19:12:24 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRx0j5BpqzfbW6;
        Thu,  2 Mar 2023 11:09:41 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:12:21 +0800
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
Subject: [PATCH v2 2/3] perf record: reuse target::initial_delay
Date:   Thu, 2 Mar 2023 11:11:45 +0800
Message-ID: <20230302031146.2801588-3-changbin.du@huawei.com>
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

This just simply replace record_opts::initial_delay with
target::initial_delay. Nothing else is changed.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-record.c | 12 ++++++------
 tools/perf/builtin-trace.c  |  8 ++++----
 tools/perf/util/evlist.c    |  6 +++---
 tools/perf/util/evsel.c     |  2 +-
 tools/perf/util/record.h    |  1 -
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..bc978bb38890 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1292,7 +1292,7 @@ static int record__open(struct record *rec)
 	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
 	 * of waiting or event synthesis.
 	 */
-	if (opts->initial_delay || target__has_cpu(&opts->target) ||
+	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmu__has_hybrid()) {
 		pos = evlist__get_tracking_event(evlist);
 		if (!evsel__is_dummy_event(pos)) {
@@ -1307,7 +1307,7 @@ static int record__open(struct record *rec)
 		 * Enable the dummy event when the process is forked for
 		 * initial_delay, immediately for system wide.
 		 */
-		if (opts->initial_delay && !pos->immediate &&
+		if (opts->target.initial_delay && !pos->immediate &&
 		    !target__has_cpu(&opts->target))
 			pos->core.attr.enable_on_exec = 1;
 		else
@@ -2522,7 +2522,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * (apart from group members) have enable_on_exec=1 set,
 	 * so don't spoil it by prematurely enabling them.
 	 */
-	if (!target__none(&opts->target) && !opts->initial_delay)
+	if (!target__none(&opts->target) && !opts->target.initial_delay)
 		evlist__enable(rec->evlist);
 
 	/*
@@ -2574,10 +2574,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		evlist__start_workload(rec->evlist);
 	}
 
-	if (opts->initial_delay) {
+	if (opts->target.initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
-		if (opts->initial_delay > 0) {
-			usleep(opts->initial_delay * USEC_PER_MSEC);
+		if (opts->target.initial_delay > 0) {
+			usleep(opts->target.initial_delay * USEC_PER_MSEC);
 			evlist__enable(rec->evlist);
 			pr_info(EVLIST_ENABLED_MSG);
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 610fb60b1c0d..b363c609818b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3993,14 +3993,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_mmap;
 
-	if (!target__none(&trace->opts.target) && !trace->opts.initial_delay)
+	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
 		evlist__enable(evlist);
 
 	if (forks)
 		evlist__start_workload(evlist);
 
-	if (trace->opts.initial_delay) {
-		usleep(trace->opts.initial_delay * 1000);
+	if (trace->opts.target.initial_delay) {
+		usleep(trace->opts.target.initial_delay * 1000);
 		evlist__enable(evlist);
 	}
 
@@ -4788,7 +4788,7 @@ int cmd_trace(int argc, const char **argv)
 			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
 		     trace__parse_cgroups),
-	OPT_INTEGER('D', "delay", &trace.opts.initial_delay,
+	OPT_INTEGER('D', "delay", &trace.opts.target.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
 	OPTS_EVSWITCH(&trace.evswitch),
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 817df2504a1e..9e4b2bb0e6fa 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2262,8 +2262,8 @@ int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *o
 	if (unset)
 		return 0;
 
-	opts->initial_delay = str_to_delay(str);
-	if (opts->initial_delay)
+	opts->target.initial_delay = str_to_delay(str);
+	if (opts->target.initial_delay)
 		return 0;
 
 	ret = parse_event_enable_times(str, NULL);
@@ -2306,7 +2306,7 @@ int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *o
 
 	eet->evlist = evlist;
 	evlist->eet = eet;
-	opts->initial_delay = eet->times[0].start;
+	opts->target.initial_delay = eet->times[0].start;
 
 	return 0;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51e8ce6edddc..462cc0673cee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1334,7 +1334,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * group leaders for traced executed by perf.
 	 */
 	if (target__none(&opts->target) && evsel__is_group_leader(evsel) &&
-	    !opts->initial_delay)
+	    !opts->target.initial_delay)
 		attr->enable_on_exec = 1;
 
 	if (evsel->immediate) {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 46212bf020cf..a6566134e09e 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -65,7 +65,6 @@ struct record_opts {
 	const char    *auxtrace_snapshot_opts;
 	const char    *auxtrace_sample_opts;
 	bool	      sample_transaction;
-	int	      initial_delay;
 	bool	      use_clockid;
 	clockid_t     clockid;
 	u64	      clockid_res_ns;
-- 
2.25.1

