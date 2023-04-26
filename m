Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176A6EEEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbjDZHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbjDZHBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:01:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5C3AA1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:01:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552f2f940edso110715167b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492475; x=1685084475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuydG1qFgo9tyCKpvgTGlzApy9btpH2tAmMEOTJR24Y=;
        b=cClS+4JmyXFo4D91gaV1IjGXoOh/ZjxLLqUowhiYwSFQxbTq8LG2HjSjQ5k3Y0aPjP
         xNqfTFHShpcgVb1ykJ8FiLBuLWGAK6GyDKTkrpToV0egqHJcQuS5+WueqXxrXfh7sbuH
         EDEuSwDyB1ySs33ud2PeVFSSQlZKpSRaq3ZHIZn6VAS24jOk2GGnSHFhHA/WSk8hC/du
         8m4XsJtXdElEUBemv98WyoZINRGs58e6YDflVHJl23MNvXSlaEF52ERddFvMOqBVmulF
         GP+zpD6CapzDm7uYot1XOuZGL/cA8ZgbYsCpY3ErJ9CtU5PdjhH3W5jRwMPch8B+SB2e
         NwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492475; x=1685084475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuydG1qFgo9tyCKpvgTGlzApy9btpH2tAmMEOTJR24Y=;
        b=ezmQeH9KVHI9tUX9i4SQ54y34S2EvSuskUHrkk5VEE9nqMelk1hLwPr9i78bB/a9vP
         DiGD+y0SHh0ZDqp1+K+2bXKi5HrmhXC/WFjZwt9+PFMTES9uL/PtwPqZfCp6TEDb0XY0
         QuBNRNWitPw2Xysmzy3DDSZyCtv4//P+YyzOtCXxoXBa9z8UpphQTYeZ4txpH8rwir2V
         E0DoeRlF3U5hstogVoLD31Fudset3VIOOMm/KE7luvEtWl6cXj8NiC3qqZdY5BJWE6o6
         TLO/cQjw3DQ2k4Ahl14/0p+DLO2VCzG4sKnXfpjyAzqwppQKCGprAGaMy+/5AxOTtBR5
         Hklg==
X-Gm-Message-State: AAQBX9cDCGW9JdZSnnvafRGm+ySLfa8Q5oy3V6cpKyxMu67D4kjxta7C
        sVR4BkcJUkio3U5WbbKxVwU9QXqM11bB
X-Google-Smtp-Source: AKy350aFTsWEldPbnTT3nJnOWArVaA3Z7agxrrJZRsvztigre/Iddq2xjG957c+4CLvamBe2lu2sWfcfblgH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:451d:0:b0:54e:e490:d190 with SMTP id
 s29-20020a81451d000000b0054ee490d190mr9601655ywa.4.1682492475668; Wed, 26 Apr
 2023 00:01:15 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:11 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-2-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 01/40] perf stat: Introduce skippable evsels
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

This patch adds skippable evsels that when they fail to open won't
fail and won't appear in output. The TopdownL1 events, from the metric
group, are marked as skippable. This turns the failure above to:

```
$ perf stat true

 Performance counter stats for 'true':

              1.26 msec task-clock:u                     #    0.328 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                49      page-faults:u                    #   38.930 K/sec
           176,449      cycles:u                         #    0.140 GHz                         (48.99%)
           122,905      instructions:u                   #    0.70  insn per cycle
            28,264      branches:u                       #   22.456 M/sec
             2,405      branch-misses:u                  #    8.51% of all branches

       0.003834565 seconds time elapsed

       0.000000000 seconds user
       0.004130000 seconds sys
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

And this likewise works if paranoia allows or running as root.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
 tools/perf/util/evsel.c        | 15 +++++++++++--
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/stat-display.c |  4 ++++
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index efda63f6bf32..eb34f5418ad3 100644
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
index e6035ecbeee8..6b46bbb3d322 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	struct perf_cpu cpu;
 	int idx;
 
+	/* Skip counters that were speculatively/default enabled rather than requested. */
+	if (counter->skippable)
+		return true;
+
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
-- 
2.40.1.495.gc816e09b53d-goog

