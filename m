Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2B6D2976
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjCaUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjCaU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497F2221E;
        Fri, 31 Mar 2023 13:29:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x15so21681033pjk.2;
        Fri, 31 Mar 2023 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294597; x=1682886597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbGI83psWi01QhPjR2ttTrwM+cN287gT/1Q3Pzny4tc=;
        b=Ti80uQAx6OpqUQQn6abxy1r6kIrgrYp5ucXtvk9dt06p/1yVv32tGEh6g9F98fwx3X
         4ZU2Pbe//dxggcX700aMTo5Buj7wwNVrYVDcgKgq+YaP5Ww555i6KSIjOOsZMmw0nfji
         6WGO4+XKePfeeZxFXzP2MHvqnUHH14iXbQpfVtwoVEjHNGC8R2xpNa8HAtPqQclMk8Nw
         G8E7nYF68HrNV8hJIV4hXAff9O8MXr2xpgkO8QgIqm/cTpizEOz1J/iAMY8TQjtrLmuw
         tutwRo5a0SCtbL9JChQFctQ5IvH9dgkmbqLh3mQneOkri/z2K3NRcmhbZluknNz05H3I
         z1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294597; x=1682886597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbGI83psWi01QhPjR2ttTrwM+cN287gT/1Q3Pzny4tc=;
        b=LYF6zqTIdeYjLySzn7RNX8CBhQG9VgPNlfh3R+3Wifzr8RkzefWRbzRs6eLrvIXFaP
         nOKavbjawHefckgyjsEEg+Ox88kCvvztRZvYLFhYmHauYp4Czmhj1T1qLbKcicTdSmGk
         j/XJVQTcoukNq4t/iuSYYYwprC9/f4r97BqfAFScQmqZYgvXGz/2yH4SLGlscxPGfR1B
         7lNTeAcyj/btjUzAjFB7GSAMN49hrPc9za27lziPhdK9OhD6t5oXFIxz2S6beFmc9Ovv
         x9BnsXUyvzqkCKPdZiJEVcbpxH7odoNM4HMpA+AHQPshm+fQIzGhRxducumAx2CE0qsM
         ARDQ==
X-Gm-Message-State: AAQBX9ejTEVEaaHe5zwck5uYlezk8ErBTTiro9TiiWWXneI2sgJBhDgs
        Rv9ghip7uC/f0BgEMFuXKt4=
X-Google-Smtp-Source: AKy350b/pF7OzIJcVp6yjq63yeIGqqnSlGX4jZ4Gb6ee1SSYU4m0lXTFj6cS16t9Q9nb3lTUr0WS9w==
X-Received: by 2002:a17:902:ceca:b0:1a1:956e:5417 with SMTP id d10-20020a170902ceca00b001a1956e5417mr35644440plg.22.1680294597444;
        Fri, 31 Mar 2023 13:29:57 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 4/9] perf bench: Add pmu-scan benchmark
Date:   Fri, 31 Mar 2023 13:29:44 -0700
Message-Id: <20230331202949.810326-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu-scan benchmark will repeatedly scan the sysfs to get the
available PMU information.

  $ ./perf bench internals pmu-scan
  # Running 'internals/pmu-scan' benchmark:
  Computing performance of sysfs PMU event scan for 100 times
    Average PMU scanning took: 6850.990 usec (+- 48.445 usec)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/Build      |   1 +
 tools/perf/bench/bench.h    |   1 +
 tools/perf/bench/pmu-scan.c | 184 ++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c  |   1 +
 4 files changed, 187 insertions(+)
 create mode 100644 tools/perf/bench/pmu-scan.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 6b6155a8ad09..0f158dc8139b 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -15,6 +15,7 @@ perf-y += find-bit-bench.o
 perf-y += inject-buildid.o
 perf-y += evlist-open-close.o
 perf-y += breakpoint.o
+perf-y += pmu-scan.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index edfc25793cca..0d2b65976212 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -42,6 +42,7 @@ int bench_inject_build_id(int argc, const char **argv);
 int bench_evlist_open_close(int argc, const char **argv);
 int bench_breakpoint_thread(int argc, const char **argv);
 int bench_breakpoint_enable(int argc, const char **argv);
+int bench_pmu_scan(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
new file mode 100644
index 000000000000..f0f007843bb8
--- /dev/null
+++ b/tools/perf/bench/pmu-scan.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark scanning sysfs files for PMU information.
+ *
+ * Copyright 2023 Google LLC.
+ */
+#include <stdio.h>
+#include "bench.h"
+#include "util/debug.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
+#include "util/stat.h"
+#include <linux/atomic.h>
+#include <linux/err.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+
+static unsigned int iterations = 100;
+
+struct pmu_scan_result {
+	char *name;
+	int nr_aliases;
+	int nr_formats;
+	int nr_caps;
+};
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		"Number of iterations used to compute average"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals pmu-scan <options>",
+	NULL
+};
+
+static int nr_pmus;
+static struct pmu_scan_result *results;
+
+static int save_result(void)
+{
+	struct perf_pmu *pmu;
+	struct list_head *list;
+	struct pmu_scan_result *r;
+
+	perf_pmu__scan(NULL);
+
+	perf_pmus__for_each_pmu(pmu) {
+		r = realloc(results, (nr_pmus + 1) * sizeof(*r));
+		if (r == NULL)
+			return -ENOMEM;
+
+		results = r;
+		r = results + nr_pmus;
+
+		r->name = strdup(pmu->name);
+		r->nr_caps = pmu->nr_caps;
+
+		r->nr_aliases = 0;
+		list_for_each(list, &pmu->aliases)
+			r->nr_aliases++;
+
+		r->nr_formats = 0;
+		list_for_each(list, &pmu->format)
+			r->nr_formats++;
+
+		pr_debug("pmu[%d] name=%s, nr_caps=%d, nr_aliases=%d, nr_formats=%d\n",
+			nr_pmus, r->name, r->nr_caps, r->nr_aliases, r->nr_formats);
+		nr_pmus++;
+	}
+
+	perf_pmu__destroy();
+	return 0;
+}
+
+static int check_result(void)
+{
+	struct pmu_scan_result *r;
+	struct perf_pmu *pmu;
+	struct list_head *list;
+	int nr;
+
+	for (int i = 0; i < nr_pmus; i++) {
+		r = &results[i];
+		pmu = perf_pmu__find(r->name);
+		if (pmu == NULL) {
+			pr_err("Cannot find PMU %s\n", r->name);
+			return -1;
+		}
+
+		if (pmu->nr_caps != (u32)r->nr_caps) {
+			pr_err("Unmatched number of event caps in %s: expect %d vs got %d\n",
+				pmu->name, r->nr_caps, pmu->nr_caps);
+			return -1;
+		}
+
+		nr = 0;
+		list_for_each(list, &pmu->aliases)
+			nr++;
+		if (nr != r->nr_aliases) {
+			pr_err("Unmatched number of event aliases in %s: expect %d vs got %d\n",
+				pmu->name, r->nr_aliases, nr);
+			return -1;
+		}
+
+		nr = 0;
+		list_for_each(list, &pmu->format)
+			nr++;
+		if (nr != r->nr_formats) {
+			pr_err("Unmatched number of event formats in %s: expect %d vs got %d\n",
+				pmu->name, r->nr_formats, nr);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static void delete_result(void)
+{
+	for (int i = 0; i < nr_pmus; i++)
+		free(results[i].name);
+	free(results);
+
+	results = NULL;
+	nr_pmus = 0;
+}
+
+static int run_pmu_scan(void)
+{
+	struct stats stats;
+	struct timeval start, end, diff;
+	double time_average, time_stddev;
+	u64 runtime_us;
+	unsigned int i;
+	int ret;
+
+	init_stats(&stats);
+	pr_info("Computing performance of sysfs PMU event scan for %u times\n",
+		iterations);
+
+	if (save_result() < 0) {
+		pr_err("Failed to initialize PMU scan result\n");
+		return -1;
+	}
+
+	for (i = 0; i < iterations; i++) {
+		gettimeofday(&start, NULL);
+		perf_pmu__scan(NULL);
+		gettimeofday(&end, NULL);
+
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&stats, runtime_us);
+
+		ret = check_result();
+		perf_pmu__destroy();
+		if (ret < 0)
+			break;
+	}
+
+	time_average = avg_stats(&stats);
+	time_stddev = stddev_stats(&stats);
+	pr_info("  Average PMU scanning took: %.3f usec (+- %.3f usec)\n",
+		time_average, time_stddev);
+
+	delete_result();
+	return 0;
+}
+
+int bench_pmu_scan(int argc, const char **argv)
+{
+	int err = 0;
+
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	err = run_pmu_scan();
+
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index d0fcc3cdc185..58f1cfe1eb34 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -92,6 +92,7 @@ static struct bench internals_benchmarks[] = {
 	{ "kallsyms-parse", "Benchmark kallsyms parsing",	bench_kallsyms_parse	},
 	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
 	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
+	{ "pmu-scan", "Benchmark sysfs PMU info scanning",	bench_pmu_scan		},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.40.0.348.gf938b09366-goog

