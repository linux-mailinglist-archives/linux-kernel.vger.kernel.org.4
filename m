Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716FB6E1B97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNFTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDNFTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:19:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978381FDD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:19:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t66-20020a254645000000b00b74680a7904so18106848yba.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681449574; x=1684041574;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZN0KrSk1AKnFNSB72kcX62XgJdFVwOXUb3M1gO+VdvI=;
        b=JtoN07lzy/LWocNk3YQqBERH0B9EdumYsWPH5coxtsoyrMSjPikTt1UYNWGVUczEJg
         lfG70iYPPYQjPj7iQ79fZKBVbeaNO8wdKOdp0QkER6lv2XSAp9e4MWB5qCRjg6ntcZTU
         lTYjcGzk11127kpSRdSx7evOGuORZdmWg7PC7iMynzfXgkUSMLPsMH/g6iOcRGkULVSl
         1tBqPDg+TCYlgnvXr9YuSp3MObthROWjc5VtBgvTtVE4i3B2FdDVdgW1/+f6J9a98iVk
         xrts7QOd/K+dBNZ3cvGcnBbcz1VohgHknmFcn8YRcEIRf0yzFg/JeBlq0gUgYUjTdXDp
         GuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681449574; x=1684041574;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZN0KrSk1AKnFNSB72kcX62XgJdFVwOXUb3M1gO+VdvI=;
        b=X+a0wQeSjC6ozI+ptbw/DI+hjiPBckA3FMBBHAwKLZhHHA+x5B/ZBPFL98LXyp6hz1
         Sih4n1qGqASK89zwpm2pCg0hkKzyRKloxQT0wqd7PZyhFKHMwjrKJMSBMN+HLxtd9scB
         oYXck2HBe+8vl71KQzpopRJsPyz3jy5unm0lmhEtIVunjxzE7byUa0eSDNud5foW4bJy
         K4JaLDzTz/bjW8KipuI94yZGgCqVNkak4MgDvqrRaQylNrsIn1IvE2ppWkoYce/SGyya
         IAK3dxtlRMR4odS24+psgA5tJIqEDi2xynLVp+LxhM7ricDm8RMqlbPX/snh0boHyndv
         T3kQ==
X-Gm-Message-State: AAQBX9dU7LRQD1xhMaa2/47UoXzs1Wdwhjgc5IjltO1O73mRAUv+4Tkv
        sJCTW989rE/eQRGCDZFjLevvVI6icZKI
X-Google-Smtp-Source: AKy350aYq0+BLH6Jltmyi1HYzgATy/bKlvzbweWSUN/AzmlAT3+34tCvXPAHZj8c0uFmsNm3ZIhzfb8U2mh2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf01:5cd6:80d7:abdf])
 (user=irogers job=sendgmr) by 2002:a81:b667:0:b0:54f:cc40:cf68 with SMTP id
 h39-20020a81b667000000b0054fcc40cf68mr2300082ywk.7.1681449573850; Thu, 13 Apr
 2023 22:19:33 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:19:22 -0700
Message-Id: <20230414051922.3625666-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v2] perf stat: Introduce skippable evsels
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

v2. Don't display the skipped events as <not counted> or <not supported>.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
 tools/perf/util/evsel.c        | 15 +++++++++++--
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/stat-display.c |  4 ++++
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d3cbee7460fc..7a641a67486d 100644
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
index a85a987128aa..83a65f771666 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->pmu_name      = NULL;
+	evsel->skippable     = false;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -1720,9 +1721,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -2104,6 +2109,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
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
2.40.0.634.g4ca3ef3211-goog

