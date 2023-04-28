Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD86F1280
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbjD1Hiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbjD1Hiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:38:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D74C10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so13431935276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667525; x=1685259525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlP1+jkLJwX0MTPH0YShpJosym8eHMXRN6UqFdBME8k=;
        b=mHP7EGGLFqbtvlDTG7cGSiHJYzO/cgT2Z/oELq4fv6SDDwPz7NVxKwGbcXwzdabaTz
         kkvgxIMXi2E6pfNEsNIxziROrZ3Hatx0j5oVLL5wOF+JZ8/wdbx5wRNJneKW3caalrcD
         /oTqruCPi5Jm5FVCZB28BLhaqGCMWxhCqYGRnBr/Yi+O8C0oxF6Sxhjc9uquhBJDZrqf
         g04mKcbfOxj76aj1uB+I0pibOTgdQ41Jh9OtgmocPZv308d7lb9M6t7xfuojiRNj+zul
         yHlFNVBiiQgr4CEsy0AP8cM+YjkQYn9T2oGfDVxSbXSHUGYDOQQg04iP5Y0SfFZpY+By
         dl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667525; x=1685259525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlP1+jkLJwX0MTPH0YShpJosym8eHMXRN6UqFdBME8k=;
        b=jjMCKPH9GbDSKvtGykp3VsjvmMMKIAIeC7NqiVULDvy9yPXtVC4x5Pq7FzdxXaSxZS
         pMtbcWUcN97M6OtF4C6RAQCk4Fyele7nHh7NhDtR2HN0Fpu7u6amfPbrf/J95Jn36AZc
         HBVgaxULz/y3p3tiaoCfzIZUh+Ql+8xRIsUDd8P5PGqK2lztQbNZE7/m+3N0WNL+nNfd
         AvMNMY/xIrgEZTxOA/N/Xu9hf4l/mdOjRhM7YVOtBNpAX8SHLu0cTVYB119+nGaZa6gl
         bcXHLGf7pRyWQQEIRkARZacs/qtoH5Ou9kmP8lwNXh7wL6D3EUPy5URdNmsM3oR1G9HD
         Y6wg==
X-Gm-Message-State: AC+VfDxX3salXiJW8BDxclOL4tAWD35oTxTozSXrFSq31aA3zSC+ELnx
        HXeGbBAF/H/yemVukNOM1dWoT3o98cpc
X-Google-Smtp-Source: ACHHUZ65GmVRRdA+IjgMR2OyQucpZPoqt9RqJcIb5vyJnPhlePbJtLeGf7VQpImiyqn1wqfvygOr7Tu8kkch
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:1183:0:b0:b8f:4f1d:be06 with SMTP id
 125-20020a251183000000b00b8f4f1dbe06mr2410763ybr.11.1682667524749; Fri, 28
 Apr 2023 00:38:44 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:28 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-3-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 02/43] perf stat: Introduce skippable evsels
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf stat with no arguments will use default events and metrics. These
events may fail to open even with kernel and hypervisor disabled. When
these fail then the permissions error appears even though they were
implicitly selected. This is particularly a problem with the automatic
selection of the TopdownL1 metric group on certain architectures like
Skylake:

'''
$ perf stat true
Error:
Access to performance monitoring and observability operations is limited.
Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
access to performance monitoring and observability operations for processes
without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
More information can be found at 'Perf events and tool security' document:
https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
perf_event_paranoid setting is 2:
  -1: Allow use of (almost) all events by all users
      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>= 0: Disallow raw and ftrace function tracepoint access
>= 1: Disallow CPU event access
>= 2: Disallow kernel profiling
To make the adjusted perf_event_paranoid setting permanent preserve it
in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
'''

This patch adds skippable evsels that when they fail to open won't
fail and won't appear in output. The TopdownL1 events, from the metric
group, are marked as skippable. This turns the failure above to:

'''
$ perf stat true

 Performance counter stats for 'true':

              1.26 msec task-clock:u                     #    0.389 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                48      page-faults:u                    #   38.068 K/sec
           264,719      cycles:u                         #    0.210 GHz                         (78.34%)
           122,746      instructions:u                   #    0.46  insn per cycle
            28,219      branches:u                       #   22.380 M/sec
             2,526      branch-misses:u                  #    8.95% of all branches
             4,712      CPU_CLK_UNHALTED.REF_XCLK:u      #    3.737 M/sec
           350,040      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  277.610 M/sec
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD:u                                               (0.00%)
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u                                             (0.00%)
     <not counted>      UOPS_ISSUED.ANY:u                                                       (0.00%)

       0.003238907 seconds time elapsed

       0.000000000 seconds user
       0.003412000 seconds sys
'''

Some events aren't counted leading to <not counted>/0 counts which
then lead to divides by zero in the metric and no display - running a
longer running program corrects that and is shown next. The event
INT_MISC.RECOVERY_CYCLES_ANY:u is skipped as it can't be opened with
paranoia 2 on Skylake.

'''
$ perf stat perf bench internals synthesize
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 49.840 usec (+- 0.084 usec)
  Average num. events: 3.000 (+- 0.000)
  Average time per event 16.613 usec
  Average data synthesis took: 50.131 usec (+- 0.087 usec)
  Average num. events: 11.000 (+- 0.000)
  Average time per event 4.557 usec

 Performance counter stats for '/tmp/perf/perf bench internals synthesize':

          1,232.99 msec task-clock:u                     #    0.993 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
               162      page-faults:u                    #  131.388 /sec
       786,004,400      cycles:u                         #    0.637 GHz                         (50.05%)
     1,640,825,583      instructions:u                   #    2.09  insn per cycle              (60.01%)
       301,257,667      branches:u                       #  244.330 M/sec                       (60.02%)
         1,808,506      branch-misses:u                  #    0.60% of all branches             (59.99%)
         5,321,529      CPU_CLK_UNHALTED.REF_XCLK:u      #    4.316 M/sec
                                                  #     16.5 %  tma_frontend_bound
                                                  #     55.0 %  tma_retiring
                                                  #     22.5 %  tma_backend_bound
                                                  #      6.0 %  tma_bad_speculation      (59.99%)
       523,301,560      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  424.416 M/sec                       (60.05%)
         5,373,764      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u #    4.358 M/sec                       (39.98%)
       789,470,378      CPU_CLK_UNHALTED.THREAD:u        #  640.288 M/sec                       (49.93%)
     1,744,823,827      UOPS_RETIRED.RETIRE_SLOTS:u      #    1.415 G/sec                       (50.06%)
     1,934,825,111      UOPS_ISSUED.ANY:u                #    1.569 G/sec                       (49.91%)

       1.242166915 seconds time elapsed

       0.274824000 seconds user
       0.959892000 seconds sys
'''

And this likewise works if paranoia allows or running as root.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 38 ++++++++++++++++++++++++++--------
 tools/perf/util/evsel.c        | 15 ++++++++++++--
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/stat-display.c | 11 +++++++++-
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index be9677aa642f..ffb47b166098 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 			evsel_list->core.threads->err_thread = -1;
 			return COUNTER_RETRY;
 		}
+	} else if (counter->skippable) {
+		if (verbose > 0)
+			ui__warning("skipping event %s that kernel failed to open .\n",
+				    evsel__name(counter));
+		counter->supported = false;
+		counter->errored = true;
+		return COUNTER_SKIP;
 	}
 
 	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
@@ -1890,15 +1897,28 @@ static int add_default_attributes(void)
 		 * caused by exposing latent bugs. This is fixed properly in:
 		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
 		 */
-		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid() &&
-		    metricgroup__parse_groups(evsel_list, "TopdownL1",
-					    /*metric_no_group=*/false,
-					    /*metric_no_merge=*/false,
-					    /*metric_no_threshold=*/true,
-					    stat_config.user_requested_cpu_list,
-					    stat_config.system_wide,
-					    &stat_config.metric_events) < 0)
-			return -1;
+		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid()) {
+			struct evlist *metric_evlist = evlist__new();
+			struct evsel *metric_evsel;
+
+			if (!metric_evlist)
+				return -1;
+
+			if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
+							/*metric_no_group=*/false,
+							/*metric_no_merge=*/false,
+							/*metric_no_threshold=*/true,
+							stat_config.user_requested_cpu_list,
+							stat_config.system_wide,
+							&stat_config.metric_events) < 0)
+				return -1;
+
+			evlist__for_each_entry(metric_evlist, metric_evsel) {
+				metric_evsel->skippable = true;
+			}
+			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
+			evlist__delete(metric_evlist);
+		}
 
 		/* Platform specific attrs */
 		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 356c07f03be6..1cd04b5998d2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->pmu_name      = NULL;
+	evsel->skippable     = false;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -1725,9 +1726,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 		return -1;
 
 	fd = FD(leader, cpu_map_idx, thread);
-	BUG_ON(fd == -1);
+	BUG_ON(fd == -1 && !leader->skippable);
 
-	return fd;
+	/*
+	 * When the leader has been skipped, return -2 to distinguish from no
+	 * group leader case.
+	 */
+	return fd == -1 ? -2 : fd;
 }
 
 static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int thread_idx)
@@ -2109,6 +2114,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			group_fd = get_group_fd(evsel, idx, thread);
 
+			if (group_fd == -2) {
+				pr_debug("broken group leader for %s\n", evsel->name);
+				err = -EINVAL;
+				goto out_close;
+			}
+
 			test_attr__ready();
 
 			/* Debug message used by test scripts */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35805dcdb1b9..bf8f01af1c0b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -95,6 +95,7 @@ struct evsel {
 		bool			weak_group;
 		bool			bpf_counter;
 		bool			use_config_name;
+		bool			skippable;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e6035ecbeee8..df6337f2480b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -7,6 +7,7 @@
 #include <perf/cpumap.h>
 #include "color.h"
 #include "counts.h"
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
@@ -791,6 +792,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
  * should_skip_zero_count() - Check if the event should print 0 values.
  * @config: The perf stat configuration (including aggregation mode).
  * @counter: The evsel with its associated cpumap.
+ * @ena: The enabled time for the counter.
  * @id: The aggregation id that is being queried.
  *
  * Due to mismatch between the event cpumap or thread-map and the
@@ -805,11 +807,18 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
  */
 static bool should_skip_zero_counter(struct perf_stat_config *config,
 				     struct evsel *counter,
+				     u64 ena,
 				     const struct aggr_cpu_id *id)
 {
 	struct perf_cpu cpu;
 	int idx;
 
+	/* Skip counters that were speculatively/default enabled rather than requested. */
+	if (ena == 0 && counter->skippable) {
+		pr_debug("Skipping counter '%s'\n", evsel__name(counter));
+		return true;
+	}
+
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
@@ -859,7 +868,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (val == 0 && should_skip_zero_counter(config, counter, &id))
+	if (val == 0 && should_skip_zero_counter(config, counter, ena, &id))
 		return;
 
 	if (!metric_only) {
-- 
2.40.1.495.gc816e09b53d-goog

