Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F316C096A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCTDmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCTDlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:41:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485C01E1D1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso11643577ybu.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283617;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEJ5nngxb+YsJBYVKsyl4Y08iHIOpJbTkoy32Inc7VA=;
        b=B8Y9M4TNFto9BkAnqK46CmFOfU81BEhghn+YQaAs8S8DTmMGdUFP3JX2ZY4bLUJ9sO
         7oTaj2yuDz0kemM7NZrwzmkxkZA6/x9BkLXlTtAKkuEfAiJbAp2egVGYIG5IWEnPzvGK
         UT0dmgYdeOydLdVpMLICrWuhBwmKQZWq5roLLooAl5VdoTd/+Io9EwvqW0jZSaQVdLIM
         p8EXl0X14HKJUq9osnowRdr70mfasAhZAd5Wocd5o5mFu2DNi2Lrf7qrkTFrbFE9xJJf
         ussWqaubSWth5bKk6qO8nMaV0ozBtADvpyJz8d2YrbMPTUMbPZkmOxrSxR0iNzhve5Gl
         aQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283617;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEJ5nngxb+YsJBYVKsyl4Y08iHIOpJbTkoy32Inc7VA=;
        b=i+oiM/aHTuodkLl0uOeTnnbkTg0JpOM9coPprMRAE9s8Uzity1H5QVvgLN8DQek+4e
         cKezg4ZM5DY6ePQux0bYozO5L3nj/O8fqEFU1olEFMIQ/njeW5Op9GxIgN4UFCEzd4P7
         c3e8yhZMTUkegXx+cllMrGjPSuheyIyt8Rs/K1HU6ljo4q50GZrMQ2Vr4iH3MeslQPSR
         BREfWvtn1hSnDE+Ht/KzJ7P7DXovyjeoFo+hqg7qoSZ7cNkDplJgR/hGMOOWo77Lm746
         mLXUgwLooBb8/2DEsZTok3kR+aFn8ugRWawIy001OcPaVQFGLeUdEynUEA5eYD+UEowh
         DV5w==
X-Gm-Message-State: AO0yUKW0fpzdxsvlbsfUd66QuMR+8RVBM3uHKshTG5hVmp1dB5aR6lpe
        Nd3yyNGPyrDGuUYv7CwWeCRTKFycK1pM
X-Google-Smtp-Source: AK7set9GJDOya15LEUfsxc4TAujX7u728aKlDndr/xyfFwVAD7tJLXojxR2Wb5jNFUXso3DRPJW+IfUTaICS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:154e:b0:b6a:9ef0:2060 with SMTP
 id r14-20020a056902154e00b00b6a9ef02060mr2524010ybu.1.1679283617318; Sun, 19
 Mar 2023 20:40:17 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:01 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-14-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 13/22] perf map: Add accessors for prot, priv and flags
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
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

Later changes will add reference count checking for struct map. Add an
accessor so that the reference count check is only necessary in one
place.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         |  2 +-
 tools/perf/builtin-report.c         |  9 +++++----
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/map.h               | 15 +++++++++++++++
 tools/perf/util/sort.c              |  6 +++---
 tools/perf/util/symbol.c            |  4 ++--
 6 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8f6909dd8a54..fd2b38458a5d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -758,7 +758,7 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 		if (!dso->hit) {
 			dso->hit = 1;
 			dso__inject_build_id(dso, tool, machine,
-					     sample->cpumode, al.map->flags);
+					     sample->cpumode, map__flags(al.map));
 		}
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4ce1aef3e253..8650d9503b77 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -845,13 +845,14 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 	maps__for_each_entry(maps, rb_node) {
 		struct map *map = rb_node->map;
 		const struct dso *dso = map__dso(map);
+		u32 prot = map__prot(map);
 
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
 				   indent, "", map__start(map), map__end(map),
-				   map->prot & PROT_READ ? 'r' : '-',
-				   map->prot & PROT_WRITE ? 'w' : '-',
-				   map->prot & PROT_EXEC ? 'x' : '-',
-				   map->flags & MAP_SHARED ? 's' : 'p',
+				   prot & PROT_READ ? 'r' : '-',
+				   prot & PROT_WRITE ? 'w' : '-',
+				   prot & PROT_EXEC ? 'x' : '-',
+				   map__flags(map) ? 's' : 'p',
 				   map->pgoff,
 				   dso->id.ino, dso->name);
 	}
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 05a322ea3f9f..7db102868bc2 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -323,7 +323,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		mem_end = map__unmap_ip(vmlinux_map, map__end(map));
 
 		pair = maps__find(kallsyms.kmaps, mem_start);
-		if (pair == NULL || pair->priv)
+		if (pair == NULL || map__priv(pair))
 			continue;
 
 		if (map__start(pair) == mem_start) {
@@ -351,7 +351,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	maps__for_each_entry(maps, rb_node) {
 		struct map *map = rb_node->map;
 
-		if (!map->priv) {
+		if (!map__priv(map)) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
 				header_printed = true;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9118eba71032..fd440c9c279e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -72,6 +72,21 @@ static inline u64 map__end(const struct map *map)
 	return map->end;
 }
 
+static inline u32 map__flags(const struct map *map)
+{
+	return map->flags;
+}
+
+static inline u32 map__prot(const struct map *map)
+{
+	return map->prot;
+}
+
+static inline bool map__priv(const struct map *map)
+{
+	return map->priv;
+}
+
 static inline size_t map__size(const struct map *map)
 {
 	return map__end(map) - map__start(map);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 321d4859ae16..31a8df42cb2f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1499,7 +1499,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	 */
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(l_map->flags & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
+	    (!(map__flags(l_map) & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
 	    !l_dso->id.ino && !l_dso->id.ino_generation) {
 		/* userspace anonymous */
 
@@ -1535,8 +1535,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
 		/* print [s] for shared data mmaps */
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
-		     map && !(map->prot & PROT_EXEC) &&
-		    (map->flags & MAP_SHARED) &&
+		     map && !(map__prot(map) & PROT_EXEC) &&
+		     (map__flags(map) & MAP_SHARED) &&
 		    (dso->id.maj || dso->id.min || dso->id.ino || dso->id.ino_generation))
 			level = 's';
 		else if (!map)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ea80c4a07609..b73c4bf0137e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1393,7 +1393,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Read new maps into temporary lists */
-	err = file__read_maps(fd, map->prot & PROT_EXEC, kcore_mapfn, &md,
+	err = file__read_maps(fd, map__prot(map) & PROT_EXEC, kcore_mapfn, &md,
 			      &is_64_bit);
 	if (err)
 		goto out_err;
@@ -1505,7 +1505,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	close(fd);
 
-	if (map->prot & PROT_EXEC)
+	if (map__prot(map) & PROT_EXEC)
 		pr_debug("Using %s for kernel object code\n", kcore_filename);
 	else
 		pr_debug("Using %s for kernel data\n", kcore_filename);
-- 
2.40.0.rc1.284.g88254d51c5-goog

