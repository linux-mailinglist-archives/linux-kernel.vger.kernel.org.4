Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093F5F1393
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiI3UV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiI3UVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30651E9046;
        Fri, 30 Sep 2022 13:21:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so4896931plo.3;
        Fri, 30 Sep 2022 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=iiDxTp/ApqKz1ydeVD0pYoiLL9SAE+fh3JAl3VvTtcI=;
        b=mDYjwdMVykJEZayLCtxREizVwst0Ik1NCDyduXAqjgLVVFYKslD0f234GIIqIaFTYs
         j2DE6uR6qIytNBwwiJpkGigG6pPC7v+xVREVytRrchO/zt739AD7ZOsOx3+g8kwACdiE
         cYI+Y/8LWjb0CSIJyP5y/GCjm5MbaQTgFP2H8bWDg8lmd0s41tnmWLC6Oc8cjsfbCHqS
         dCjgNAkXqROyoYOUURgkl6QEHRW/T9B9HAOHrX+RHEi//DHEzzkep7Ro7HdGaoFKnpk0
         pkKUTE0QJmJX1j5BC2DkOglvH6cFuM+qSPRPnLutv3bSmZqPvut61vRPi0lWwuD05y4M
         REqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=iiDxTp/ApqKz1ydeVD0pYoiLL9SAE+fh3JAl3VvTtcI=;
        b=z7zxTfUAVVxIFjtH1LlV65ZFYTUB6OQrp4Z5grGXIrjDanePpUB9gxcvRY9xBKtHzt
         MmleUc1WObAC/++geZmPy5WrLP2MBkFjFCG70IgFOdRqTK5CsrMuV/UppmajdPnyt9dh
         Eq8kTSO7Y2tFansFFp6EvmBuALFT2lYc+KMe4/OGXGdK7PzeXYGHo0qE4zjEkJvbxNYS
         QizIfnDvX+Q5DUUNdxBRiF6f3Z3u/e39gXhjhXjXcl5jD6zukdPHKQVTOHjl4U13hPDK
         hu9BR1I80p8/qWVg8y5pchfcEISP0cCwb+XhU4eIq4BFFwyrQkz1GwjFFh+8RrKPlpYv
         nnEg==
X-Gm-Message-State: ACrzQf2UOEdLFmYE/FOllQlqkc+8pQiWmRcaTzpkwWl1oBMFR54iWdhs
        +DqyiAWYLUOPlS8QchMitAqnIeJIC/M=
X-Google-Smtp-Source: AMsMyM50etQ+fxaz7WnJr6Dwv6re+yvrrWq5arYOtMT5xE+DMoGp9Dz+fSxCwMORGZyGAaX84bSTrg==
X-Received: by 2002:a17:902:cecf:b0:178:3fa3:1583 with SMTP id d15-20020a170902cecf00b001783fa31583mr10576518plg.141.1664569290658;
        Fri, 30 Sep 2022 13:21:30 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:30 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 7/7] perf stat: Rename to aggr_cpu_id.thread_idx
Date:   Fri, 30 Sep 2022 13:21:10 -0700
Message-Id: <20220930202110.845199-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930202110.845199-1-namhyung@kernel.org>
References: <20220930202110.845199-1-namhyung@kernel.org>
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

The aggr_cpu_id has a thread value but it's actually an index to the
thread_map.  To reduce possible confusion, rename it to thread_idx.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/topology.c    | 10 +++++-----
 tools/perf/util/cpumap.c       |  8 ++++----
 tools/perf/util/cpumap.h       |  2 +-
 tools/perf/util/stat-display.c | 12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 0b4f61b6cc6b..c4630cfc80ea 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -147,7 +147,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
 			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
-		TEST_ASSERT_VAL("Cpu map - Thread is set", id.thread == -1);
+		TEST_ASSERT_VAL("Cpu map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that core ID contains socket, die and core
@@ -163,7 +163,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
-		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
+		TEST_ASSERT_VAL("Core map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that die ID contains socket and die
@@ -179,7 +179,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
 		TEST_ASSERT_VAL("Die map - CPU is set", id.cpu.cpu == -1);
-		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
+		TEST_ASSERT_VAL("Die map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -193,7 +193,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - Core is set", id.core == -1);
 		TEST_ASSERT_VAL("Socket map - CPU is set", id.cpu.cpu == -1);
-		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
+		TEST_ASSERT_VAL("Socket map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that node ID contains only node
@@ -205,7 +205,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
 		TEST_ASSERT_VAL("Node map - CPU is set", id.cpu.cpu == -1);
-		TEST_ASSERT_VAL("Node map - Thread is set", id.thread == -1);
+		TEST_ASSERT_VAL("Node map - Thread IDX is set", id.thread_idx == -1);
 	}
 	perf_session__delete(session);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 2389bd3e19b8..8486ca3bec75 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -229,7 +229,7 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 	else if (a->core != b->core)
 		return a->core - b->core;
 	else
-		return a->thread - b->thread;
+		return a->thread_idx - b->thread_idx;
 }
 
 struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
@@ -667,7 +667,7 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b)
 {
-	return a->thread == b->thread &&
+	return a->thread_idx == b->thread_idx &&
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
@@ -677,7 +677,7 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 {
-	return a->thread == -1 &&
+	return a->thread_idx == -1 &&
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
@@ -688,7 +688,7 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 struct aggr_cpu_id aggr_cpu_id__empty(void)
 {
 	struct aggr_cpu_id ret = {
-		.thread = -1,
+		.thread_idx = -1,
 		.node = -1,
 		.socket = -1,
 		.die = -1,
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index fa8a5acdcae1..4a6d029576ee 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -10,7 +10,7 @@
 /** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
 	/** A value in the range 0 to number of threads. */
-	int thread;
+	int thread_idx;
 	/** The numa node X as read from /sys/devices/system/node/nodeX. */
 	int node;
 	/**
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 570e2c04d47d..df26fb5eb072 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -189,14 +189,14 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_THREAD:
 		if (config->json_output) {
 			fprintf(config->output, "\"thread\" : \"%s-%d\", ",
-				perf_thread_map__comm(evsel->core.threads, id.thread),
-				perf_thread_map__pid(evsel->core.threads, id.thread));
+				perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+				perf_thread_map__pid(evsel->core.threads, id.thread_idx));
 		} else {
 			fprintf(config->output, "%*s-%*d%s",
 				config->csv_output ? 0 : 16,
-				perf_thread_map__comm(evsel->core.threads, id.thread),
+				perf_thread_map__comm(evsel->core.threads, id.thread_idx),
 				config->csv_output ? 0 : -8,
-				perf_thread_map__pid(evsel->core.threads, id.thread),
+				perf_thread_map__pid(evsel->core.threads, id.thread_idx),
 				config->csv_sep);
 		}
 		break;
@@ -453,7 +453,7 @@ static int first_shadow_map_idx(struct perf_stat_config *config,
 		return perf_cpu_map__idx(cpus, id->cpu);
 
 	if (config->aggr_mode == AGGR_THREAD)
-		return id->thread;
+		return id->thread_idx;
 
 	if (!config->aggr_get_id)
 		return 0;
@@ -946,7 +946,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 
 		buf[i].counter = counter;
 		buf[i].id = aggr_cpu_id__empty();
-		buf[i].id.thread = thread;
+		buf[i].id.thread_idx = thread;
 		buf[i].uval = uval;
 		buf[i].val = val;
 		buf[i].run = run;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

