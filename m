Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B046D6E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjDDVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjDDVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B74C28
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:00:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo331880597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642044;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2robLIprEBFAsbqlI5uLA2rGb41LEGoQT3g1ZHVZHs=;
        b=URkoMiY57JFr4bg6vTKUNXBlX2RRhIqlneaow3/vn6vUyAjUFLY4w88vTUIHXl85Gs
         Bx6ODF+dQUmyhOK/LCXPZ/fIufkfpC/xmBnjWSIQyg8wrDyVYVwJW77ehUn8q3B6krba
         ZzvVEn095I0LwwniwjZb3IvS8fp0ITRipwh3nz+OcMA439mLyAqYRB9UZjqawqPF2NE1
         TJuiHdUYwsu2LGUCCsWNo56DSy+uOvjWT9yEjvVHThwiWsbFbkLerfXygtUUvaEl6KzM
         NTy4HWUgBto4IZ2IQaZP25k3AnNkCPAlXNhuq6qKFtI1TSA4cbf2AC/tjbDIM3y4tPlm
         BVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642044;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2robLIprEBFAsbqlI5uLA2rGb41LEGoQT3g1ZHVZHs=;
        b=k9UeTeaWl15irZ1YZTfumJjmH7vTl2z7KcgIZsulS/I1faCu4NGwGGo+Qz7bLU+F7K
         4X3lnSvI5cKXgITTvAQ5HfT8JJvfsSJ7nQCnwuE+iR27l55zVwD7SC1av3ZyxGjKBvio
         iLrwDhyZfu6ZsbTN7QyQDn7W4iMaUkiA2F3VjfATPpUh+xWQZ3j6oHgtisrpl+Sc1YLz
         jqypJy/Ikwsh1C40ifNQvKloqaHEcSosa2HMChBtAA71IYJL/B8Prsl2cTYaP3JCCXup
         VjPpkJ9YDtRJSquBVuVQWmtw8F6tnJmxGLO7x8L5yj4865mzw8ziDZspVTXo7KN1I9oY
         UWuw==
X-Gm-Message-State: AAQBX9egKhY14YDMuX4JWMC+YiCDRed25YkN/mrfRaTmJP057ZQwR6pt
        dsR0UpJujtb6rCtVkojsO0RHGg/vWtMg
X-Google-Smtp-Source: AKy350YVIX8GdcOOPZrvfbcZ8BboepzC9grVMGll3G3XLDl2zD70sKHDEHKTRdE62F1zraCcGvjPdROByb2P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a05:6902:90b:b0:b81:a13:50c3 with SMTP id
 bu11-20020a056902090b00b00b810a1350c3mr448032ybb.2.1680642044451; Tue, 04 Apr
 2023 14:00:44 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:45 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-4-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 03/12] perf map: Add accessors for prot, priv and flags
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 2a6e2cee5e0d..c066452219c8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -849,13 +849,14 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
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
index 87a3ba584af5..80c9960c37e5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1540,7 +1540,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	 */
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(l_map->flags & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
+	    (!(map__flags(l_map) & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
 	    !l_dso->id.ino && !l_dso->id.ino_generation) {
 		/* userspace anonymous */
 
@@ -1576,8 +1576,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
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
index 9ba49c1ef6ef..5c075d77a792 100644
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
@@ -1509,7 +1509,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	close(fd);
 
-	if (map->prot & PROT_EXEC)
+	if (map__prot(map) & PROT_EXEC)
 		pr_debug("Using %s for kernel object code\n", kcore_filename);
 	else
 		pr_debug("Using %s for kernel data\n", kcore_filename);
-- 
2.40.0.348.gf938b09366-goog

