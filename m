Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29469BF75
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBSJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBSJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7CEB75
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53687f6de13so18395537b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=McpPUh9UUbr+SfZnc3Yy3m0883o69CMJ9U4yySTvUIw=;
        b=nr+0lt5VymGETH/u61CNycPQbXKy2g0gRYNfkLIoR9cI2Xz1zqqpvRQB4b+fwUG7ST
         vok5Jj6oAiPiqTpK2qYsd0OSEZ1HtpmVkbitSOvgfeo2SX11R5cqjvdJj+7o4l3pP2Cd
         M9yIKk4dJBKlIyffdAsE5VM7TQMCqt40bg09sqWDvbX5oSWMR+QbG+cvSpUeLzk5gQ5p
         UBn4OhTfgAaRWfGzVdnvzS/ChmcUbPyAEprZQDL9beqiWSFPi01G1bQDim0d6bj9rTn3
         IfeKuaPWVMI8DkuGAhsnoD79dvPT0XMD6WCXnyrM/WWfO+5k2nksBylj3NgndWilb/m6
         cCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McpPUh9UUbr+SfZnc3Yy3m0883o69CMJ9U4yySTvUIw=;
        b=QrO8Nksi1/T5Aih5lWlcF5dMv4gP4Vndngi2MGEw3rYbRj/R0EhmK31K4hQ2Gv1NkS
         7Nsxg4SStuPfefUDcPaGbYs1DzMJtmgEY/omURFbXfwC1CVqgQTcNd2sqJp640jF1vZ1
         qAampn3PzYKWYhPlpnie9IXgbdnsRR1UBOTZCK4sYUA5WrelRkA1m3ljuXJs1ARQyvnj
         r/XCiZYG2tHixMb9YvxhHmS7yBCWdLmWiVJHCB235I5qSaDfF2O6HhrIHwSB7DNmZbOL
         3RnRQneiOPnSvbHtAdMPWAkc895i/Z85txJungU0plXBkr0YqC98j3eb8MUdFfHjYe7g
         38VA==
X-Gm-Message-State: AO0yUKW400IArChcxvPY3oUNnWT/z/E+TE+fDP65EysIbVGCGJGrS+fz
        P/LypTDoOYbQVvvyXfCZnFpRk04Zjh5A
X-Google-Smtp-Source: AK7set/tYHCebNI8ZlW9vI/je+pg1JQ3IaTCJTwemTnxp8GWFHKNPaDgKuhJe4F8qrfLAcGYZUNSXbeBpGXk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:45:b0:995:ccb:1aae with SMTP id
 m5-20020a056902004500b009950ccb1aaemr109787ybh.13.1676799000276; Sun, 19 Feb
 2023 01:30:00 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:04 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-8-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 07/51] perf expr: Make the online topology accessible globally
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Knowing the topology of online CPUs is useful for more than just expr
literals. Move to a global function that caches the value. An
additional upside is that this may also avoid computing the CPU
topology in some situations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c   |  7 ++-----
 tools/perf/util/cputopo.c | 14 ++++++++++++++
 tools/perf/util/cputopo.h |  5 +++++
 tools/perf/util/expr.c    | 16 ++++++----------
 tools/perf/util/smt.c     | 11 +++++------
 tools/perf/util/smt.h     | 12 ++++++------
 6 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index a9eb1ed6bd63..cbf0e0c74906 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -154,13 +154,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
 	{
-		struct cpu_topology *topology = cpu_topology__new();
-		bool smton = smt_on(topology);
+		bool smton = smt_on();
 		bool corewide = core_wide(/*system_wide=*/false,
-					  /*user_requested_cpus=*/false,
-					  topology);
+					  /*user_requested_cpus=*/false);
 
-		cpu_topology__delete(topology);
 		expr__ctx_clear(ctx);
 		TEST_ASSERT_VAL("find ids",
 				expr__find_ids("EVENT1 if #smt_on else EVENT2",
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e08797c3cdbc..ca1d833a0c26 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -238,6 +238,20 @@ static bool has_die_topology(void)
 	return true;
 }
 
+const struct cpu_topology *online_topology(void)
+{
+	static const struct cpu_topology *topology;
+
+	if (!topology) {
+		topology = cpu_topology__new();
+		if (!topology) {
+			pr_err("Error creating CPU topology");
+			abort();
+		}
+	}
+	return topology;
+}
+
 struct cpu_topology *cpu_topology__new(void)
 {
 	struct cpu_topology *tp = NULL;
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 969e5920a00e..8d42f6102954 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -56,6 +56,11 @@ struct hybrid_topology {
 	struct hybrid_topology_node	nodes[];
 };
 
+/*
+ * The topology for online CPUs, lazily created.
+ */
+const struct cpu_topology *online_topology(void);
+
 struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 /* Determine from the core list whether SMT was enabled. */
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c1da20b868db..d46a1878bc9e 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -402,7 +402,7 @@ double arch_get_tsc_freq(void)
 
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
-	static struct cpu_topology *topology;
+	const struct cpu_topology *topology;
 	double result = NAN;
 
 	if (!strcmp("#num_cpus", literal)) {
@@ -421,31 +421,27 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	 * these strings gives an indication of the number of packages, dies,
 	 * etc.
 	 */
-	if (!topology) {
-		topology = cpu_topology__new();
-		if (!topology) {
-			pr_err("Error creating CPU topology");
-			goto out;
-		}
-	}
 	if (!strcasecmp("#smt_on", literal)) {
-		result = smt_on(topology) ? 1.0 : 0.0;
+		result = smt_on() ? 1.0 : 0.0;
 		goto out;
 	}
 	if (!strcmp("#core_wide", literal)) {
-		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list, topology)
+		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
 		goto out;
 	}
 	if (!strcmp("#num_packages", literal)) {
+		topology = online_topology();
 		result = topology->package_cpus_lists;
 		goto out;
 	}
 	if (!strcmp("#num_dies", literal)) {
+		topology = online_topology();
 		result = topology->die_cpus_lists;
 		goto out;
 	}
 	if (!strcmp("#num_cores", literal)) {
+		topology = online_topology();
 		result = topology->core_cpus_lists;
 		goto out;
 	}
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 994e9e418227..650e804d0adc 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -4,7 +4,7 @@
 #include "cputopo.h"
 #include "smt.h"
 
-bool smt_on(const struct cpu_topology *topology)
+bool smt_on(void)
 {
 	static bool cached;
 	static bool cached_result;
@@ -16,22 +16,21 @@ bool smt_on(const struct cpu_topology *topology)
 	if (sysfs__read_int("devices/system/cpu/smt/active", &fs_value) >= 0)
 		cached_result = (fs_value == 1);
 	else
-		cached_result = cpu_topology__smt_on(topology);
+		cached_result = cpu_topology__smt_on(online_topology());
 
 	cached = true;
 	return cached_result;
 }
 
-bool core_wide(bool system_wide, const char *user_requested_cpu_list,
-	       const struct cpu_topology *topology)
+bool core_wide(bool system_wide, const char *user_requested_cpu_list)
 {
 	/* If not everything running on a core is being recorded then we can't use core_wide. */
 	if (!system_wide)
 		return false;
 
 	/* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
-	if (!smt_on(topology))
+	if (!smt_on())
 		return true;
 
-	return cpu_topology__core_wide(topology, user_requested_cpu_list);
+	return cpu_topology__core_wide(online_topology(), user_requested_cpu_list);
 }
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
index ae9095f2c38c..01441fd2c0a2 100644
--- a/tools/perf/util/smt.h
+++ b/tools/perf/util/smt.h
@@ -2,16 +2,16 @@
 #ifndef __SMT_H
 #define __SMT_H 1
 
-struct cpu_topology;
-
-/* Returns true if SMT (aka hyperthreading) is enabled. */
-bool smt_on(const struct cpu_topology *topology);
+/*
+ * Returns true if SMT (aka hyperthreading) is enabled. Determined via sysfs or
+ * the online topology.
+ */
+bool smt_on(void);
 
 /*
  * Returns true when system wide and all SMT threads for a core are in the
  * user_requested_cpus map.
  */
-bool core_wide(bool system_wide, const char *user_requested_cpu_list,
-	       const struct cpu_topology *topology);
+bool core_wide(bool system_wide, const char *user_requested_cpu_list);
 
 #endif /* __SMT_H */
-- 
2.39.2.637.g21b0678d19-goog

