Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F36DE610
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDKU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDKU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:56:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762418E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:56:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 85-20020a250d58000000b00b8f380b2bccso206870ybn.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681246596;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEI6nzWWR+WddKH/7cQsZpyDFQ7PjyBu53tq/lHMWqI=;
        b=S7YtXkouzCnAbpJtZBh09HWdFYVUcXLmY8KbZ0Ge1slYzdZ8J7G6G+ePc6Gp73cdX9
         bGcUhueSk/z1gp1+XYdJKMcnY3A+vKPmggQs2rRvpoYkpRJ0ABSw/lNCk2tABR68iiwb
         rRN4BoEcuAzcBvmsqjSN4IjmBN7/wwPX1f2sriNm1vRqLgzITae4P3M13qFfNN7SguxG
         EazdkKt1MLfvya/PZU8EBQr6eeEDkBxfmhnSkePAsNTcKh9ASVjnXB/VRV60J9QJ3ZGq
         MUO8SGnjA+q94/XWfjTMgNb3fzulMnD/8lXqwqeGHE/j3ml8Zp5oA1u6cIFk24IcWnNk
         8TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681246596;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEI6nzWWR+WddKH/7cQsZpyDFQ7PjyBu53tq/lHMWqI=;
        b=F9x/6QJgWQG0tdoE1FUTynkJ36b2e3YgqAdDf9Gm5t5cmyCyG9bnCOQs7BeXEotl8S
         MZdfAnIbXNZ3tsj7/v/OMegyFBm8QojyoGPtFffdbg+ve3Ykrq7xQUYIdh9nSyAges1m
         GVbUHv1HJaSCujWvuGwQyyPIN4o6O4wPP3q4lWbh1V9ZA2TYP0RY5BUgZczsekXSM3zA
         4x0dBxjVJCXjXvSURyYyG5GqudhksSpfzi7TCniAqO5A1S9fvTUO7tTt3wiaoT0kvun1
         C56s89zLIHcxtJ9ZdkFikzXFxl4R/vuGaD1P9wh8ieApiJEOaXlDiFDeqoIcIKZNeU+J
         tSug==
X-Gm-Message-State: AAQBX9eBVtCnb3X+qkXFG+6dIHNlE+iEy2XJfHoNnx7d5SPAij0URueS
        0d/kJ5nLUa2gyS5rQKcXNKxoIQk+dWop
X-Google-Smtp-Source: AKy350bjWpS4nJrh1LEEwU/S+eGt0lghXqTqy2iXVDH+JoT/aZt4s0tbX+bITIF3jB0PqqQvGObwuNKuCfCx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f663:83e0:f9b2:5a17])
 (user=irogers job=sendgmr) by 2002:a81:b184:0:b0:545:f7cc:f30 with SMTP id
 p126-20020a81b184000000b00545f7cc0f30mr6810565ywh.0.1681246595935; Tue, 11
 Apr 2023 13:56:35 -0700 (PDT)
Date:   Tue, 11 Apr 2023 13:56:22 -0700
Message-Id: <20230411205622.3266490-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1] perf stat: Introduce skippable evsels
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

```
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
```

This patch adds skippable evsels that when they fail to open will be
skipped. The TopdownL1 events are marked as skippable. This turns the
failure above to:

```
$ perf stat true

 Performance counter stats for 'true':

              1.28 msec task-clock:u                     #    0.323 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                48      page-faults:u                    #   37.550 K/sec
           206,228      cycles:u                         #    0.161 GHz                         (44.07%)
           122,904      instructions:u                   #    0.60  insn per cycle
            28,263      branches:u                       #   22.110 M/sec
             2,461      branch-misses:u                  #    8.71% of all branches
     <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
     <not counted>      CPU_CLK_UNHALTED.THREAD:u
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
     <not counted>      UOPS_ISSUED.ANY:u
     <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
     <not counted>      CPU_CLK_UNHALTED.THREAD:u
     <not counted>      UOPS_ISSUED.ANY:u

       0.003958627 seconds time elapsed

       0.000000000 seconds user
       0.004263000 seconds sys

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
The events in group usually have to be from the same PMU. Try reorganizing the group.
```

When the events can have kernel/hypervisor disabled, like on
Tigerlake, then it continues to succeed as:

```
$ perf stat true

 Performance counter stats for 'true':

              0.57 msec task-clock:u                     #    0.385 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                47      page-faults:u                    #   82.329 K/sec
           287,017      cycles:u                         #    0.503 GHz
           133,318      instructions:u                   #    0.46  insn per cycle
            31,396      branches:u                       #   54.996 M/sec
             2,442      branch-misses:u                  #    7.78% of all branches
           998,790      TOPDOWN.SLOTS:u                  #     14.5 %  tma_retiring
                                                  #     27.6 %  tma_backend_bound
                                                  #     40.9 %  tma_frontend_bound
                                                  #     17.0 %  tma_bad_speculation
           144,922      topdown-retiring:u
           411,266      topdown-fe-bound:u
           258,510      topdown-be-bound:u
           184,090      topdown-bad-spec:u
             2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
             3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/u #    6.015 M/sec

       0.001480954 seconds time elapsed

       0.000000000 seconds user
       0.001686000 seconds sys
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 39 ++++++++++++++++++++++++++++++---------
 tools/perf/util/evsel.c   | 15 +++++++++++++--
 tools/perf/util/evsel.h   |  1 +
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 38133afda7fc..024fda0dd943 100644
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
@@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric("TopdownL1") &&
-		    metricgroup__parse_groups(evsel_list, "TopdownL1",
-					    /*metric_no_group=*/false,
-					    /*metric_no_merge=*/false,
-					    /*metric_no_threshold=*/true,
-					    stat_config.user_requested_cpu_list,
-					    stat_config.system_wide,
-					    &stat_config.metric_events) < 0)
-			return -1;
+		if (metricgroup__has_metric("TopdownL1")) {
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
+
 		/* Platform specific attrs */
 		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
 			return -1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dc3faf005c3b..a09654ea18ec 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->pmu_name      = NULL;
+	evsel->skippable     = false;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -1717,9 +1718,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -2101,6 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
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
index 68072ec655ce..98afe3351176 100644
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
-- 
2.40.0.577.gac1e443424-goog

