Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1EA6F4D15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjEBWok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjEBWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:44:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0F3C19
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:43:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552cb28adfeso46982197b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067369; x=1685659369;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nd3SY7n/4GmW7g26C/L+L2VFGm0wHwLBiLx1Iujwe/4=;
        b=yB8bEGP7mbNhr19aLbzpFI0YeixPdCy75g+/nWqphXrruE0wxjHpGMNLBrh1RsPauN
         v5rz0NfFXRmAWRmrisaj9kJoT9tXvoztVXiQU/oG6rWFagvze2af2mmzw+DTjDthg4lj
         jSxjh2oRC7lrfyax1SQVfJDvCdQbVPNV4CbiPPvZ0EEuFh0/VDoj4DgXt09PLH6hrJV6
         yoQszFNRKufHa1F5CWylIQ/nN8OK3liWkIsicT2gLMyPesiGW5F5XSe+egHwxTVRHu0Q
         vJQQP6so+ehxGEkNQFvAhUb/CCakkrZcJd6ZGE7G2eXC9Nsh6S2/luV81KhVQtla1nOJ
         Fybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067369; x=1685659369;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd3SY7n/4GmW7g26C/L+L2VFGm0wHwLBiLx1Iujwe/4=;
        b=c/BhRj4shcwF7zrGP40mFLZxSrjCYItmi9gqgQhOYaY/57EzmKj/+cNElBu2qq43Ks
         hD+vwIijPiRLdxtB/iEJSyr0A9lXmqOWYbhZmka2WJhBSQAnw8NpnSHD7PsvrKSMmlBb
         4HnTjcQJ8OcjqDv4GPe1OcN9LC6dK20B7adbXSrQw86Jp4ze4yphx+NEwkf/JcnwLn9i
         EJ/UcJBNBSVS5yIwRWSOYmgz5rZ2kJ5QtMdbDicJAYcq3rs6rfpEQUcz/DhUQomSYMLV
         9mC9ZK63+vsaGh/GGT5DfvnmxJwvFP8WM3apPk3WtbLgtQqWa5rUN1xslkqyFqOHjTji
         FbRA==
X-Gm-Message-State: AC+VfDwW2DqJHzGFLnNZ4SIo63DogcTA2jG3cBPkhVdCnp9zVPRy5Ivt
        NC82IIyIrvKZBknFRI6iMQK3yBBuSvBm
X-Google-Smtp-Source: ACHHUZ5WIEuhiDyV14paA0txvMApoSS/nTbiLNIO8J6hKnF/yuV6jFifvjtZ7XcdDGKUFRjlMerq0QXpcbm0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:b708:0:b0:559:ed25:34cb with SMTP id
 v8-20020a81b708000000b00559ed2534cbmr6992044ywh.2.1683067369148; Tue, 02 May
 2023 15:42:49 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:37 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-31-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 30/44] perf stat: Make cputype filter generic
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

Rather than limit the --cputype argument for "perf list" and "perf
stat" to hybrid PMUs of just cpu_atom and cpu_core, allow any PMU.

Note, that if cpu_atom isn't mounted but a filter of cpu_atom is
requested, then this will now fail. As such a filter would never
succeed, no events can come from that unmounted PMU, then this
behavior could never have been useful and failing is clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c    | 21 +++++++++++++--------
 tools/perf/builtin-stat.c    | 12 +++++++-----
 tools/perf/util/pmu-hybrid.c | 20 --------------------
 tools/perf/util/pmu-hybrid.h |  1 -
 tools/perf/util/pmus.c       | 25 ++++++++++++++++++++++++-
 tools/perf/util/pmus.h       |  3 +++
 6 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 1f5dbd5f0ba4..c6bd0aa4a56e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -11,8 +11,8 @@
 #include "builtin.h"
 
 #include "util/print-events.h"
+#include "util/pmus.h"
 #include "util/pmu.h"
-#include "util/pmu-hybrid.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include "util/string2.h"
@@ -429,7 +429,7 @@ int cmd_list(int argc, const char **argv)
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
 	};
-	const char *hybrid_name = NULL;
+	const char *cputype = NULL;
 	const char *unit_name = NULL;
 	bool json = false;
 	struct option list_options[] = {
@@ -443,8 +443,8 @@ int cmd_list(int argc, const char **argv)
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
-		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
-			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
+		OPT_STRING(0, "cputype", &cputype, "cpu type",
+			   "Limit PMU or metric printing to the given PMU (e.g. cpu, core or atom)."),
 		OPT_STRING(0, "unit", &unit_name, "PMU name",
 			   "Limit PMU or metric printing to the specified PMU."),
 		OPT_INCR(0, "debug", &verbose,
@@ -484,10 +484,15 @@ int cmd_list(int argc, const char **argv)
 		assert(default_ps.visited_metrics);
 		if (unit_name)
 			default_ps.pmu_glob = strdup(unit_name);
-		else if (hybrid_name) {
-			default_ps.pmu_glob = perf_pmu__hybrid_type_to_pmu(hybrid_name);
-			if (!default_ps.pmu_glob)
-				pr_warning("WARNING: hybrid cputype is not supported!\n");
+		else if (cputype) {
+			const struct perf_pmu *pmu = perf_pmus__pmu_for_pmu_filter(cputype);
+
+			if (!pmu) {
+				pr_err("ERROR: cputype is not supported!\n");
+				ret = -1;
+				goto out;
+			}
+			default_ps.pmu_glob = pmu->name;
 		}
 	}
 	print_cb.print_start(ps);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3b25fcab5cd1..06a1d71a49a5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -44,6 +44,7 @@
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
+#include "util/pmus.h"
 #include "util/pmu.h"
 #include "util/event.h"
 #include "util/evlist.h"
@@ -69,7 +70,6 @@
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
-#include "util/pmu-hybrid.h"
 #include "util/util.h"
 #include "asm/bug.h"
 
@@ -1089,10 +1089,11 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
-static int parse_hybrid_type(const struct option *opt,
+static int parse_cputype(const struct option *opt,
 			     const char *str,
 			     int unset __maybe_unused)
 {
+	const struct perf_pmu *pmu;
 	struct evlist *evlist = *(struct evlist **)opt->value;
 
 	if (!list_empty(&evlist->core.entries)) {
@@ -1100,11 +1101,12 @@ static int parse_hybrid_type(const struct option *opt,
 		return -1;
 	}
 
-	parse_events_option_args.pmu_filter = perf_pmu__hybrid_type_to_pmu(str);
-	if (!parse_events_option_args.pmu_filter) {
+	pmu = perf_pmus__pmu_for_pmu_filter(str);
+	if (!pmu) {
 		fprintf(stderr, "--cputype %s is not supported!\n", str);
 		return -1;
 	}
+	parse_events_option_args.pmu_filter = pmu->name;
 
 	return 0;
 }
@@ -1230,7 +1232,7 @@ static struct option stat_options[] = {
 	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 		     "Only enable events on applying cpu with this type "
 		     "for hybrid platform (e.g. core or atom)",
-		     parse_hybrid_type),
+		     parse_cputype),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index 38628805a952..bc4cb0738c35 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -50,23 +50,3 @@ bool perf_pmu__is_hybrid(const char *name)
 {
 	return perf_pmu__find_hybrid_pmu(name) != NULL;
 }
-
-char *perf_pmu__hybrid_type_to_pmu(const char *type)
-{
-	char *pmu_name = NULL;
-
-	if (asprintf(&pmu_name, "cpu_%s", type) < 0)
-		return NULL;
-
-	if (perf_pmu__is_hybrid(pmu_name))
-		return pmu_name;
-
-	/*
-	 * pmu may be not scanned, check the sysfs.
-	 */
-	if (perf_pmu__hybrid_mounted(pmu_name))
-		return pmu_name;
-
-	free(pmu_name);
-	return NULL;
-}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 2b186c26a43e..206b94931531 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -17,7 +17,6 @@ bool perf_pmu__hybrid_mounted(const char *name);
 
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
-char *perf_pmu__hybrid_type_to_pmu(const char *type);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
 {
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 7f3b93c4d229..140e11f00b29 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,5 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
-#include <pmus.h>
+#include <string.h>
+#include "pmus.h"
+#include "pmu.h"
 
 LIST_HEAD(pmus);
+
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!strcmp(pmu->name, str))
+			return pmu;
+		/* Ignore "uncore_" prefix. */
+		if (!strncmp(pmu->name, "uncore_", 7)) {
+			if (!strcmp(pmu->name + 7, str))
+				return pmu;
+		}
+		/* Ignore "cpu_" prefix on Intel hybrid PMUs. */
+		if (!strncmp(pmu->name, "cpu_", 4)) {
+			if (!strcmp(pmu->name + 4, str))
+				return pmu;
+		}
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 5ec12007eb5c..d475e2960c10 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -3,7 +3,10 @@
 #define __PMUS_H
 
 extern struct list_head pmus;
+struct perf_pmu;
 
 #define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
 
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
+
 #endif /* __PMUS_H */
-- 
2.40.1.495.gc816e09b53d-goog

