Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8947100BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjEXWUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjEXWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007AB1B8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8a5cbb012so2835613276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966747; x=1687558747;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvYI76SN3LSsDGBG627TEqFEqoZE169lDakPXaks7wo=;
        b=LtNd1sQ1nR/tVT5PcLtarn5jp9Pff92GyzyO3QGdW+jYyOgNiferLf2Z/5TEQDatqe
         LMBmKujbWP9OUnMx9F8cFQtFsn5JNJAknbkWSl5MCGT4mQhbj/T0bL7h3ojv0g8HscnA
         ny267xSWe+TaTr9y2L/aj1vRXrzGL7L/PiTKoex9s3fSuSICP5lqc1ly6v2Lax1VB7r2
         NIG0ltCupgrkU4ZErGXA5dNgPrJNoR2idq1/NNMtKumd/SJsE7AB1mhAPWSkZIP0yU1+
         Vtp63Lcwmh2tSYUygKQJZxpU85Zk7Xxpp7ROAFkgU5qX5bTujEIvdBL8a0H4Iem+UhNy
         zj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966747; x=1687558747;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvYI76SN3LSsDGBG627TEqFEqoZE169lDakPXaks7wo=;
        b=W+p7B7fWa5f9NgQfVuAexKI2whC4tcH95XTQ+UM3UdM6iL7xcbS39lgnp5P4er6ehh
         avC7H4e9pmvu2JOUyVoQQi9zaHt79ArSjMYug1DJMWo29IgfiWva3aWYu+mQkH0FaKmP
         uhUL4/5ctp9GEGu4sg30UgBD7heyq6t7oRBP777UJQZy41I6DxLilyyJgJ/8zp5lP0l0
         HLekCwiguIFbQoqR1xtoUjwKVXvE2MyrAYeovrJPY+le9xOcCruOmQS3nwgg77tk3FlC
         EGc1fTiV9A1V5hmfgW95Hhm6bjMhXSbV9xvUPC5MxKbhpQGSdzaA9g84US/PqeDNeSa5
         moxg==
X-Gm-Message-State: AC+VfDwpmDklbeIl+faeBM4c9oatY5ZaNUTEnCiAr081rYzjPRGMihaE
        3kRf6eIUmM4soZD0NMAFVhGTZBCnIAXr
X-Google-Smtp-Source: ACHHUZ5D/yUipWEDiqSUQ3rcMif94S1VlO1gGnqpCF1RxrNods675HwSbtRDhVW0rXw1HwI9CBryYTOySrBc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:db47:0:b0:ba8:6148:4300 with SMTP id
 g68-20020a25db47000000b00ba861484300mr577117ybf.6.1684966747454; Wed, 24 May
 2023 15:19:07 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:10 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-15-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 14/35] perf evlist: Remove __evlist__add_default
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

__evlist__add_default adds a cycles event to a typically empty evlist
and was extended for hybrid with evlist__add_default_hybrid, as more
than 1 PMU was necessary. Rather than have dedicated logic for the
cycles event, this change switches to parsing 'cycles:P' which will
handle wildcarding the PMUs appropriately for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 20 --------------
 tools/perf/builtin-record.c      | 13 +++------
 tools/perf/builtin-top.c         | 10 ++++---
 tools/perf/util/evlist-hybrid.c  | 25 -----------------
 tools/perf/util/evlist-hybrid.h  |  1 -
 tools/perf/util/evlist.c         | 22 ++++++---------
 tools/perf/util/evlist.h         |  7 -----
 tools/perf/util/evsel.c          | 46 --------------------------------
 tools/perf/util/evsel.h          |  3 ---
 9 files changed, 17 insertions(+), 130 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ea3972d785d1..153cdca94cd4 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -16,26 +16,6 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
 	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
 }
 
-void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
-{
-	struct perf_env env = { .total_mem = 0, } ;
-
-	if (!perf_env__cpuid(&env))
-		return;
-
-	/*
-	 * On AMD, precise cycles event sampling internally uses IBS pmu.
-	 * But IBS does not have filtering capabilities and perf by default
-	 * sets exclude_guest = 1. This makes IBS pmu event init fail and
-	 * thus perf ends up doing non-precise sampling. Avoid it by clearing
-	 * exclude_guest.
-	 */
-	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
-		attr->exclude_guest = 0;
-
-	free(env.cpuid);
-}
-
 /* Check whether the evsel's PMU supports the perf metrics */
 bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 88f7b4241153..d80b54a6f450 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4161,18 +4161,11 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		if (perf_pmu__has_hybrid()) {
-			err = evlist__add_default_hybrid(rec->evlist,
-							 !record.opts.no_samples);
-		} else {
-			err = __evlist__add_default(rec->evlist,
-						    !record.opts.no_samples);
-		}
+		bool can_profile_kernel = perf_event_paranoid_check(1);
 
-		if (err < 0) {
-			pr_err("Not enough memory for event selector list\n");
+		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		if (err)
 			goto out;
-		}
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 48ee49e95c5e..27a7f068207d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1653,10 +1653,12 @@ int cmd_top(int argc, const char **argv)
 	if (annotate_check_args(&top.annotation_opts) < 0)
 		goto out_delete_evlist;
 
-	if (!top.evlist->core.nr_entries &&
-	    evlist__add_default(top.evlist) < 0) {
-		pr_err("Not enough memory for event selector list\n");
-		goto out_delete_evlist;
+	if (!top.evlist->core.nr_entries) {
+		bool can_profile_kernel = perf_event_paranoid_check(1);
+		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+
+		if (err)
+			goto out_delete_evlist;
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 0f59c80f27b2..64f78d06fe19 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -16,31 +16,6 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 
-int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
-{
-	struct evsel *evsel;
-	struct perf_pmu *pmu;
-	__u64 config;
-	struct perf_cpu_map *cpus;
-
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		config = PERF_COUNT_HW_CPU_CYCLES |
-			 ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
-		evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
-					  config);
-		if (!evsel)
-			return -ENOMEM;
-
-		cpus = perf_cpu_map__get(pmu->cpus);
-		evsel->core.cpus = cpus;
-		evsel->core.own_cpus = perf_cpu_map__get(cpus);
-		evsel->pmu_name = strdup(pmu->name);
-		evlist__add(evlist, evsel);
-	}
-
-	return 0;
-}
-
 bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index 4b000eda6626..0cded76eb344 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -7,7 +7,6 @@
 #include "evlist.h"
 #include <unistd.h>
 
-int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
 bool evlist__has_hybrid(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9dfa977193b3..63f8821a5395 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -93,8 +93,15 @@ struct evlist *evlist__new(void)
 struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
+	bool can_profile_kernel;
+	int err;
+
+	if (!evlist)
+		return NULL;
 
-	if (evlist && evlist__add_default(evlist)) {
+	can_profile_kernel = perf_event_paranoid_check(1);
+	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+	if (err) {
 		evlist__delete(evlist);
 		evlist = NULL;
 	}
@@ -237,19 +244,6 @@ static void evlist__set_leader(struct evlist *evlist)
 	perf_evlist__set_leader(&evlist->core);
 }
 
-int __evlist__add_default(struct evlist *evlist, bool precise)
-{
-	struct evsel *evsel;
-
-	evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
-				  PERF_COUNT_HW_CPU_CYCLES);
-	if (evsel == NULL)
-		return -ENOMEM;
-
-	evlist__add(evlist, evsel);
-	return 0;
-}
-
 static struct evsel *evlist__dummy_event(struct evlist *evlist)
 {
 	struct perf_event_attr attr = {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5e7ff44f3043..664c6bf7b3e0 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -100,13 +100,6 @@ void evlist__delete(struct evlist *evlist);
 void evlist__add(struct evlist *evlist, struct evsel *entry);
 void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
-int __evlist__add_default(struct evlist *evlist, bool precise);
-
-static inline int evlist__add_default(struct evlist *evlist)
-{
-	return __evlist__add_default(evlist, true);
-}
-
 int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
 
 int __evlist__add_default_attrs(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8c8f371ea2b5..1df8f967d2eb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -316,48 +316,6 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
 	return evsel;
 }
 
-static bool perf_event_can_profile_kernel(void)
-{
-	return perf_event_paranoid_check(1);
-}
-
-struct evsel *evsel__new_cycles(bool precise __maybe_unused, __u32 type, __u64 config)
-{
-	struct perf_event_attr attr = {
-		.type	= type,
-		.config	= config,
-		.exclude_kernel	= !perf_event_can_profile_kernel(),
-	};
-	struct evsel *evsel;
-
-	event_attr_init(&attr);
-
-	/*
-	 * Now let the usual logic to set up the perf_event_attr defaults
-	 * to kick in when we return and before perf_evsel__open() is called.
-	 */
-	evsel = evsel__new(&attr);
-	if (evsel == NULL)
-		goto out;
-
-	arch_evsel__fixup_new_cycles(&evsel->core.attr);
-
-	evsel->precise_max = true;
-
-	/* use asprintf() because free(evsel) assumes name is allocated */
-	if (asprintf(&evsel->name, "cycles%s%s%.*s",
-		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
-		     attr.exclude_kernel ? "u" : "",
-		     attr.precise_ip ? attr.precise_ip + 1 : 0, "ppp") < 0)
-		goto error_free;
-out:
-	return evsel;
-error_free:
-	evsel__delete(evsel);
-	evsel = NULL;
-	goto out;
-}
-
 int copy_config_terms(struct list_head *dst, struct list_head *src)
 {
 	struct evsel_config_term *pos, *tmp;
@@ -1131,10 +1089,6 @@ void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
 	evsel__set_sample_bit(evsel, WEIGHT);
 }
 
-void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_unused)
-{
-}
-
 void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
 				    struct perf_event_attr *attr __maybe_unused)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index df8928745fc6..429b172cc94d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -243,8 +243,6 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 }
 #endif
 
-struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
-
 #ifdef HAVE_LIBTRACEEVENT
 struct tep_event *event_format__new(const char *sys, const char *name);
 #endif
@@ -312,7 +310,6 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
 void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
-void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
 void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
-- 
2.40.1.698.g37aff9b760-goog

