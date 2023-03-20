Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223836C2399
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCTVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCTVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315D399EB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541a39df9f4so135794947b3.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347441;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z76sUNZwYgL2J4e+xgHI73pvJbJjEp+YXSErrQxEh7o=;
        b=FlyoHQJuMJrZe1yqABr+i0WtVSVKeALjh3mVnaYENRCUq7WCHFRBV7I8q0qUP2WK5y
         7+js6lEfpaZY1vkiEXtBn2YFpe14tMXbTNw483uQ/04qxh7X/MtC//h+RPmaeXd/wGnl
         fbTyj7Lgm/AwoVi9NMhBtB8mq0PhfqSyRaRHJvhR3Qa+h5MkylLRwOO8L14BrCcboWGa
         VNoxKEUqdH4ZsgMU5E+s9QRM7mcyRcXdd8fZfXu/0zUsYnPdqXrwo3CRs0V52nQy40Zv
         sDingzlVPipMAxSGLbCsHRE2PFMEGNJOUVZm/uefzAA+dl7EK3F/o1oFA0GD6582O6o2
         vEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347441;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z76sUNZwYgL2J4e+xgHI73pvJbJjEp+YXSErrQxEh7o=;
        b=JBITrnWaQNej5HSL0EKYIjtqmZrmnZmsBf11hF8zljBLvAxv1d2yhnarJbokHOs6rI
         e7GoIxMejMZG/qf/vRLHJmQ7B1NeQEXl/BHRiq/6F4CmlvyghA7YDVBaMQhAwtR8yFSb
         sgJXKBE2eUbIUs1bLM31/1DHJidy1JtNVUEAu8QrPxp9QzoinL/h9AAcp6FlVGXhqiEH
         jJDLj9A6oKxS3QxpoQwsJWTLv2nKNb7+2bMTU7el/fDRqwqpI2gIuInHc4CSOFV171qi
         K3dTqglg5eAoUl+PsHoxkCHckTk+ioRdLOHDavLEp7pxywEEXX4cgUAICTwTfTQ9+gK1
         mt4Q==
X-Gm-Message-State: AO0yUKVBpwaigIN2A/jGzQvZ4zs8etWUOCOsS9c5Jczne6m1oBxyunl4
        ri1riE9+Zjt/E3/JT3hSROV2ToOiMmYw
X-Google-Smtp-Source: AK7set/uMY6Wdc56lynovtalfO23sq6qOsRtm/l0PbMp63JFrbHYQ6tz2Np08QrK/5QDWXTdMLj4o7jGOgEk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a81:b284:0:b0:533:99bb:c296 with SMTP id
 q126-20020a81b284000000b0053399bbc296mr10251560ywh.5.1679347441448; Mon, 20
 Mar 2023 14:24:01 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:39 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-9-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 08/17] perf map: Add accessors for prot, priv and flags
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
index 128d4a66cc0e..e3758519e4d1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1396,7 +1396,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Read new maps into temporary lists */
-	err = file__read_maps(fd, map->prot & PROT_EXEC, kcore_mapfn, &md,
+	err = file__read_maps(fd, map__prot(map) & PROT_EXEC, kcore_mapfn, &md,
 			      &is_64_bit);
 	if (err)
 		goto out_err;
@@ -1508,7 +1508,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	close(fd);
 
-	if (map->prot & PROT_EXEC)
+	if (map__prot(map) & PROT_EXEC)
 		pr_debug("Using %s for kernel object code\n", kcore_filename);
 	else
 		pr_debug("Using %s for kernel data\n", kcore_filename);
-- 
2.40.0.rc1.284.g88254d51c5-goog

