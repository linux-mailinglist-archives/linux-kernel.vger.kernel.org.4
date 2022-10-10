Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC985F97D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJJFgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiJJFgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064165C8;
        Sun,  9 Oct 2022 22:36:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 67so9844720pfz.12;
        Sun, 09 Oct 2022 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8ZKVhWaIjuVaVfYj0CJ3e9zMlA2k2aSnXspmMO77sQ=;
        b=I0tB/bFds4UFrcssdMUyKIEqbRqQGTJwgFYNSDFBQ/RdNnPqo2EXRSS3ME3pEvDV/v
         5Luf0FaKq59S2zEZjhPiCABZ56GgchlGVP84Xi+vCKi6XI8ONUdP4YVGTLFBL0MtWVA8
         ZVgf4cej+dpu1XyH0rTvN1/WKlo5cHKfQdh2y4Z1sbd8AfyZCtQsHJjgsyTZOUAdel2n
         n4P/JsnrUBrZ4wEsiaNIeH13VdT5MxekCY+liCiUp+/25bDA/UpdWOxR2eDlQ+WZW330
         e65eQQ+vK6tAuIO2k4f+I8g7zGoPkf2gojatVxcjdwo8qUr+ZyblaH1XyecssPQGKzUx
         HI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8ZKVhWaIjuVaVfYj0CJ3e9zMlA2k2aSnXspmMO77sQ=;
        b=3MjGFwrQYq+ZvZOuuwJ9KNdh8l2KeiF6QGa5evu/2uwsuHKtn9tqMJwy4l/bA3yqxA
         Dj/6XKulO5UPhpiK3DpdDd+Fp+K7QaTlMXftUT48eScmkE3w4QQtH+DM0xoP5k+K6tP1
         n8Jb/EIt4s/oIBpVSZhz6cTkWc0OcyGoTIGtWEuXnpzFrvfDKfz3chpywwKAfzqnajFI
         O2GJ7Jfl82q0gzgW5N9RD2BKNCArbsruCfXy5s7DDojZQ2Je4E8ZGYfztbpuMziQm+3V
         LXR06F3t5iBJCEVZuyrJFbMOfCKK6Fcina7vmuog8Cizf/xqePPa+cnbsYPj0v2WaKVa
         1vtQ==
X-Gm-Message-State: ACrzQf1VN7v6TJq7XVKN42ceQx64kMwugFNr2647ExiamHPFcr0Xo0kQ
        auLaqVIwX8s1XwMk3ROREzE=
X-Google-Smtp-Source: AMsMyM61/X2CV2W4aPiQIW4rNOWGzMkamKLel+DW2oOBVnH5Bg5wOOfjTOhhoLbKGh+2QMefO9Hf1g==
X-Received: by 2002:a05:6a00:1486:b0:557:f3c7:219f with SMTP id v6-20020a056a00148600b00557f3c7219fmr18414114pfu.0.1665380169122;
        Sun, 09 Oct 2022 22:36:09 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:08 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 04/19] perf stat: Add aggr id for global mode
Date:   Sun,  9 Oct 2022 22:35:45 -0700
Message-Id: <20221010053600.272854-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code simpler, I'd like to use the same aggregation code for
the global mode.  We can simply add an id function to return cpu 0 and
use print_aggr().

No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++++++++--
 tools/perf/util/cpumap.c       | 10 +++++++++
 tools/perf/util/cpumap.h       |  6 +++++-
 tools/perf/util/stat-display.c |  9 ++------
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..144bb3a657f2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1330,6 +1330,15 @@ static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __
 	return aggr_cpu_id__node(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config __maybe_unused,
+						struct perf_cpu cpu __maybe_unused)
+{
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	id.cpu = (struct perf_cpu){ .cpu = 0 };
+	return id;
+}
+
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
@@ -1366,6 +1375,12 @@ static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *co
 	return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *config,
+						       struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
+}
+
 static bool term_percore_set(void)
 {
 	struct evsel *counter;
@@ -1395,6 +1410,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 
 		return NULL;
 	case AGGR_GLOBAL:
+		return aggr_cpu_id__global;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1420,6 +1436,7 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		}
 		return NULL;
 	case AGGR_GLOBAL:
+		return perf_stat__get_global_cached;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1535,6 +1552,16 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, vo
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_global_aggr_by_cpu(struct perf_cpu cpu __maybe_unused,
+							   void *data __maybe_unused)
+{
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	/* it always aggregates to the cpu 0 */
+	id.cpu = (struct perf_cpu){ .cpu = 0 };
+	return id;
+}
+
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
 						     struct perf_cpu cpu)
 {
@@ -1558,6 +1585,12 @@ static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *conf
 	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_global_file(struct perf_stat_config *config __maybe_unused,
+						     struct perf_cpu cpu)
+{
+	return perf_env__get_global_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 {
 	switch (aggr_mode) {
@@ -1569,8 +1602,9 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_core_aggr_by_cpu;
 	case AGGR_NODE:
 		return perf_env__get_node_aggr_by_cpu;
-	case AGGR_NONE:
 	case AGGR_GLOBAL:
+		return perf_env__get_global_aggr_by_cpu;
+	case AGGR_NONE:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1590,8 +1624,9 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_core_file;
 	case AGGR_NODE:
 		return perf_stat__get_node_file;
-	case AGGR_NONE:
 	case AGGR_GLOBAL:
+		return perf_stat__get_global_file;
+	case AGGR_NONE:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8486ca3bec75..60209fe87456 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -354,6 +354,16 @@ struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data __maybe_unu
 	return id;
 }
 
+struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data __maybe_unused)
+{
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	/* it always aggregates to the cpu 0 */
+	cpu.cpu = 0;
+	id.cpu = cpu;
+	return id;
+}
+
 /* setup simple routines to easily access node numbers given a cpu number */
 static int get_max_num(char *path, int *max)
 {
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 4a6d029576ee..b2ff648bc417 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -133,5 +133,9 @@ struct aggr_cpu_id aggr_cpu_id__cpu(struct perf_cpu cpu, void *data);
  * cpu. The function signature is compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data);
-
+/**
+ * aggr_cpu_id__global - Create an aggr_cpu_id for global aggregation.
+ * The function signature is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data);
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4113aa86772f..1d8e585df4ad 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1477,13 +1477,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		if (config->iostat_run)
 			iostat_print_counters(evlist, config, ts, prefix = buf,
 					      print_counter_aggr);
-		else {
-			evlist__for_each_entry(evlist, counter) {
-				print_counter_aggr(config, counter, prefix);
-			}
-			if (metric_only)
-				fputc('\n', config->output);
-		}
+		else
+			print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

