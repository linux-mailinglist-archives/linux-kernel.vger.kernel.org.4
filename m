Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347F7100BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjEXWUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjEXWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946810D2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb79a17b8so2054212276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966742; x=1687558742;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlI6oimZU02XfkfcVbSHs4R5neH26SuCZgaFNSdpQYk=;
        b=DKXkRqv1ZpFDBXPBbHvAsR5GLgDQ1Q4zIP7i5X3T8m8nggvzvpIaJyoGZ2WZ//Ab7x
         6wL05ioSwA8Yuhoq9Ck+gDaCuRoiLEg7AOksOsjSziglNLfjYO8mljHjfxsjlHLwOlkd
         QBrl4T4wKeKTjsQLEYJVkjLO1HPG9xK3lTEO6zHTzaK1g8fuuReOaTy7Qkv/dW4xDgCs
         XHnj9UcZI6SwsmSOKOwewR9sTPIQVLZgTSzdF3KWTINSt7MWYWRisJg5iV30zlzZQnLz
         H2s6rw/ZFgzTlKS9ON7iXPAHxcPQDXjXm/8RBYj0ebUr2LdAwOk+LU9gtDyODj3vMO34
         tqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966742; x=1687558742;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlI6oimZU02XfkfcVbSHs4R5neH26SuCZgaFNSdpQYk=;
        b=WXdH7fKQZzg7GRt2jUz41xcMgANk2otOkYkV9BbdXpkcWpXC1VCpnWarBmEkjHd0wS
         y2ZO8ntSZWWw4B5wDgWlFaQBuYeWgFv2g3qEV3qHrn9F4E7DN4+HgGgEhoeUf9rlWi9Z
         KQQSs9TWPTdHERCZ2pKeWyBoTnJfisFpcXTdxJIJ1AWk8tuI7cybcsD7Bi9/69WuDd+B
         Zr/+QkZo/8VbwUMY29bNfFS0irQOU0Ag7zS9WeXrc7KnYvWs0BldP8ptSyU95sVR7PUw
         CYPdqSeVYNRofySjTd1OYT0TVe6k62W2g7QYqDvLIaNaz8uD/fdxbsi+isum47Inx6yw
         PH+w==
X-Gm-Message-State: AC+VfDxf4mw0T+WZuykmCCyfYMCFtsoLrY/CgzZ8Mydetzua4ONfAZst
        jIYmzgk5XXvaHDmQPcTGM/RP45oxgBd3
X-Google-Smtp-Source: ACHHUZ7CFO4HRgNI2Rgb125/Y1HoOSJlFJc2haWEQzZ8q55MKD1ASrhcsNacYnOX66MFC30xQhhTH+HfuZ6D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ca:b0:ba1:6f1b:8905 with SMTP id
 v10-20020a05690204ca00b00ba16f1b8905mr782762ybs.4.1684966742565; Wed, 24 May
 2023 15:19:02 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:08 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-13-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 12/35] perf tools: Warn if no user requested CPUs match
 PMU's CPUs
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

In commit 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybrid")
perf on hybrid will warn if a user requested CPU doesn't match the PMU
of the given event but only for hybrid PMUs. Make the logic generic
for all PMUs and remove the hybrid logic.

Warn if a CPU is requested that isn't present/offline for events not
on the core. Warn if a CPU is requested for a core PMU, but the CPU
isn't within the cpu map of that PMU.

For example on a 16 (0-15) CPU system:
```
$ perf stat -e imc_free_running/data_read/,cycles -C 16 true
WARNING: A requested CPU in '16' is not supported by PMU 'uncore_imc_free_running_1' (CPUs 0-15) for event 'imc_free_running/data_read/'
WARNING: A requested CPU in '16' is not supported by PMU 'uncore_imc_free_running_0' (CPUs 0-15) for event 'imc_free_running/data_read/'
WARNING: A requested CPU in '16' is not supported by PMU 'cpu' (CPUs 0-15) for event 'cycles'

 Performance counter stats for 'CPU(s) 16':

   <not supported> MiB  imc_free_running/data_read/
   <not supported>      cycles

       0.000575312 seconds time elapsed
```

Remove evlist__fix_hybrid_cpus that previously produced the warnings
and also perf_pmu__cpus_match that worked with evlist__fix_hybrid_cpus
to change CPU maps for hybrid CPUs, something that is no longer
necessary as CPU map propagation properly intersects user requested
CPUs with the core PMU's CPU map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c     |  6 +--
 tools/perf/builtin-stat.c       |  5 +--
 tools/perf/util/evlist-hybrid.c | 74 ---------------------------------
 tools/perf/util/evlist-hybrid.h |  1 -
 tools/perf/util/evlist.c        | 39 +++++++++++++++++
 tools/perf/util/evlist.h        |  2 +
 tools/perf/util/pmu.c           | 33 ---------------
 tools/perf/util/pmu.h           |  4 --
 8 files changed, 43 insertions(+), 121 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d152ab04a209..88f7b4241153 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4198,11 +4198,7 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
-	if (evlist__fix_hybrid_cpus(rec->evlist, rec->opts.target.cpu_list)) {
-		pr_err("failed to use cpu list %s\n",
-		       rec->opts.target.cpu_list);
-		goto out;
-	}
+	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
 	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
 		arch__add_leaf_frame_record_opts(&rec->opts);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c70cb0990661..04c9289e6ceb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2462,10 +2462,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
-		pr_err("failed to use cpu list %s\n", target.cpu_list);
-		goto out;
-	}
+	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 57f02beef023..db3f5fbdebe1 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -86,77 +86,3 @@ bool evlist__has_hybrid(struct evlist *evlist)
 
 	return false;
 }
-
-int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
-{
-	struct perf_cpu_map *cpus;
-	struct evsel *evsel, *tmp;
-	struct perf_pmu *pmu;
-	int ret, unmatched_count = 0, events_nr = 0;
-
-	if (!perf_pmu__has_hybrid() || !cpu_list)
-		return 0;
-
-	cpus = perf_cpu_map__new(cpu_list);
-	if (!cpus)
-		return -1;
-
-	/*
-	 * The evsels are created with hybrid pmu's cpus. But now we
-	 * need to check and adjust the cpus of evsel by cpu_list because
-	 * cpu_list may cause conflicts with cpus of evsel. For example,
-	 * cpus of evsel is cpu0-7, but the cpu_list is cpu6-8, we need
-	 * to adjust the cpus of evsel to cpu6-7. And then propatate maps
-	 * in evlist__create_maps().
-	 */
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
-		char buf1[128], buf2[128];
-
-		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
-		if (!pmu)
-			continue;
-
-		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
-					   &unmatched_cpus);
-		if (ret)
-			goto out;
-
-		events_nr++;
-
-		if (perf_cpu_map__nr(matched_cpus) > 0 &&
-		    (perf_cpu_map__nr(unmatched_cpus) > 0 ||
-		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(cpus) ||
-		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(pmu->cpus))) {
-			perf_cpu_map__put(evsel->core.cpus);
-			perf_cpu_map__put(evsel->core.own_cpus);
-			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
-			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
-
-			if (perf_cpu_map__nr(unmatched_cpus) > 0) {
-				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
-				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
-					   buf1, pmu->name, evsel->name);
-			}
-		}
-
-		if (perf_cpu_map__nr(matched_cpus) == 0) {
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-
-			cpu_map__snprint(cpus, buf1, sizeof(buf1));
-			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
-			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
-				   buf1, pmu->name, pmu->name, buf2);
-			unmatched_count++;
-		}
-
-		perf_cpu_map__put(matched_cpus);
-		perf_cpu_map__put(unmatched_cpus);
-	}
-	if (events_nr)
-		ret = (unmatched_count == events_nr) ? -1 : 0;
-out:
-	perf_cpu_map__put(cpus);
-	return ret;
-}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index aacdb1b0f948..19f74b4c340a 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -10,6 +10,5 @@
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
 void evlist__warn_hybrid_group(struct evlist *evlist);
 bool evlist__has_hybrid(struct evlist *evlist);
-int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2e2c3509bec3..9dfa977193b3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2465,3 +2465,42 @@ void evlist__check_mem_load_aux(struct evlist *evlist)
 		}
 	}
 }
+
+/**
+ * evlist__warn_user_requested_cpus() - Check each evsel against requested CPUs
+ *     and warn if the user CPU list is inapplicable for the event's PMU's
+ *     CPUs. Not core PMUs list a CPU in sysfs, but this may be overwritten by a
+ *     user requested CPU and so any online CPU is applicable. Core PMUs handle
+ *     events on the CPUs in their list and otherwise the event isn't supported.
+ * @evlist: The list of events being checked.
+ * @cpu_list: The user provided list of CPUs.
+ */
+void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list)
+{
+	struct perf_cpu_map *user_requested_cpus;
+	struct evsel *pos;
+
+	if (!cpu_list)
+		return;
+
+	user_requested_cpus = perf_cpu_map__new(cpu_list);
+	if (!user_requested_cpus)
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct perf_cpu_map *intersect, *to_test;
+		const struct perf_pmu *pmu = evsel__find_pmu(pos);
+
+		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
+		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
+		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
+			char buf[128];
+
+			cpu_map__snprint(to_test, buf, sizeof(buf));
+			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
+				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
+		}
+		perf_cpu_map__put(intersect);
+	}
+	perf_cpu_map__put(user_requested_cpus);
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e7e5540cc970..5e7ff44f3043 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -447,4 +447,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
+void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
+
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d992f5242d99..cd94abe7a87a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2046,39 +2046,6 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 	return 0;
 }
 
-int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
-			 struct perf_cpu_map **mcpus_ptr,
-			 struct perf_cpu_map **ucpus_ptr)
-{
-	struct perf_cpu_map *pmu_cpus = pmu->cpus;
-	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
-	struct perf_cpu cpu;
-	int i, matched_nr = 0, unmatched_nr = 0;
-
-	matched_cpus = perf_cpu_map__default_new();
-	if (!matched_cpus)
-		return -1;
-
-	unmatched_cpus = perf_cpu_map__default_new();
-	if (!unmatched_cpus) {
-		perf_cpu_map__put(matched_cpus);
-		return -1;
-	}
-
-	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
-		if (!perf_cpu_map__has(pmu_cpus, cpu))
-			RC_CHK_ACCESS(unmatched_cpus)->map[unmatched_nr++] = cpu;
-		else
-			RC_CHK_ACCESS(matched_cpus)->map[matched_nr++] = cpu;
-	}
-
-	perf_cpu_map__set_nr(unmatched_cpus, unmatched_nr);
-	perf_cpu_map__set_nr(matched_cpus, matched_nr);
-	*mcpus_ptr = matched_cpus;
-	*ucpus_ptr = unmatched_cpus;
-	return 0;
-}
-
 double __weak perf_pmu__cpu_slots_per_cycle(void)
 {
 	return NAN;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 96236a79c6fd..af10d137e2b5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -265,10 +265,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
-int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
-			 struct perf_cpu_map **mcpus_ptr,
-			 struct perf_cpu_map **ucpus_ptr);
-
 char *pmu_find_real_name(const char *name);
 char *pmu_find_alias_name(const char *name);
 double perf_pmu__cpu_slots_per_cycle(void);
-- 
2.40.1.698.g37aff9b760-goog

