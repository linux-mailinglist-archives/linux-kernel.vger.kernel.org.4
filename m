Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BF6F2313
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbjD2Ff4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjD2Ffx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:35:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C0421B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso613866276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746543; x=1685338543;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DVy621GYiHB+6fU/268WLthwNlggN6c1xnlL0X7vU8=;
        b=3zxkAXyTionPYwq6VqAV6y38ic7QXoRkjN3Ueo0eOHvgW6dCKY7BMuxs8eTtVr5YdF
         WNf/wkPtd9iEb9HobaPvuYmhq99BWHHORQs6XjGMkMb1hG+iOUBwB8hf0nbYum/L/mus
         8DySC9RUw84GuCx9g/pOoRY8BQlqsxdM/A24IMu13aUAONrwJKaEvwmFKLTDU21Dbnpo
         G03tnseknDMXy6E5uNTuqGNOswOUYMzyAGOmL9NM+9EDG9FVPjwrMve7wqcAxtorMlF7
         u+6GgBbk8vUiTYzClA0vsHEBWpKR7Vy+xIV5LlXJezMNb7gpEmG9rJFBjwZnV94SEdR3
         mtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746543; x=1685338543;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DVy621GYiHB+6fU/268WLthwNlggN6c1xnlL0X7vU8=;
        b=AUdLopwkPksizm5oq4/7LsGWQzQcur6o1DQ60mehH8knFPzFcOGgs1Yu+Ky+Jpcc0z
         p5BmTOCVNdsQoDCZjN+2BjmOhgA300r5iaJwZl2fvTcODG3HqYvaoeoBYl6+TWizGppW
         kE3YiSMYn+mdIwXwkElWtyetji99L8doRLnybzOwC0uTRzB/0Pi3TaJHCyW4Kw3eAL1n
         3d3q+8Zj5+ebp6lJJEBq/IKy1WPSwPWh0h+YibXkqY6TOzbeKPI3TYJEjKuy+R3TVOzB
         +ur94nvv2U3Jr3ti18WxNxh3qUzCtcFqbGnqKFAx9yb/aIHyh8kqC9utCgWr+foF6/ct
         QDKA==
X-Gm-Message-State: AC+VfDy4Fpp4kacTkc7WJY2cuRXMrAljAXn01LDGQTtjQ2nfZeJ49bx+
        jzwDoPVCHIT6Q1+xG/DSu8rkbgCs+WoI
X-Google-Smtp-Source: ACHHUZ754wE8Dx2MKJZbupjXwxcdZB22tNtX4vkOfnILCwuLo+sw8pctzCHEJx+OgKLEJQsUYCMoC28F49N2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:b96:7fb0:f927 with SMTP id
 n184-20020a25d6c1000000b00b967fb0f927mr4517731ybg.12.1682746542787; Fri, 28
 Apr 2023 22:35:42 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:23 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-4-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 03/46] perf stat: Introduce skippable evsels
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
        autolearn=ham autolearn_force=no version=3.4.6
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
cause termination and will appear as "<not supported>" in output. The
TopdownL1 events, from the metric group, are marked as skippable. This
turns the failure above to:

'''
$ perf stat perf bench internals synthesize
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 49.287 usec (+- 0.083 usec)
  Average num. events: 3.000 (+- 0.000)
  Average time per event 16.429 usec
  Average data synthesis took: 49.641 usec (+- 0.085 usec)
  Average num. events: 11.000 (+- 0.000)
  Average time per event 4.513 usec

 Performance counter stats for 'perf bench internals synthesize':

          1,222.38 msec task-clock:u                     #    0.993 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
               162      page-faults:u                    #  132.529 /sec
       774,445,184      cycles:u                         #    0.634 GHz                         (49.61%)
     1,640,969,811      instructions:u                   #    2.12  insn per cycle              (59.67%)
       302,052,148      branches:u                       #  247.102 M/sec                       (59.69%)
         1,807,718      branch-misses:u                  #    0.60% of all branches             (59.68%)
         5,218,927      CPU_CLK_UNHALTED.REF_XCLK:u      #    4.269 M/sec
                                                  #     17.3 %  tma_frontend_bound
                                                  #     56.4 %  tma_retiring
                                                  #      nan %  tma_backend_bound
                                                  #      nan %  tma_bad_speculation      (60.01%)
       536,580,469      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  438.965 M/sec                       (60.33%)
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
         5,223,936      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u #    4.274 M/sec                       (40.31%)
       774,127,250      CPU_CLK_UNHALTED.THREAD:u        #  633.297 M/sec                       (50.34%)
     1,746,579,518      UOPS_RETIRED.RETIRE_SLOTS:u      #    1.429 G/sec                       (50.12%)
     1,940,625,702      UOPS_ISSUED.ANY:u                #    1.588 G/sec                       (49.70%)

       1.231055525 seconds time elapsed

       0.258327000 seconds user
       0.965749000 seconds sys
'''

The event INT_MISC.RECOVERY_CYCLES_ANY:u is skipped as it can't be
opened with paranoia 2 on Skylake. With a lower paranoia, or as root,
all events/metrics are computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 38 +++++++++++++++++++++++++++++---------
 tools/perf/util/evsel.c   | 15 +++++++++++++--
 tools/perf/util/evsel.h   |  1 +
 3 files changed, 43 insertions(+), 11 deletions(-)

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
-- 
2.40.1.495.gc816e09b53d-goog

