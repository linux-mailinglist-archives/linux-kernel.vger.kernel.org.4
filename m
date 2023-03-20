Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB76C2396
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCTVYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCTVYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A23844E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-544b71b3114so124417637b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347428;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y10GnXOzH9U5tz9iFzVskmw05u/+9XHwA2jBfRW8OlY=;
        b=oddRU666Q86lKEA4bPXLjt2ayia1jSTcm7XmgFsfqW1X3OM7/W745vJ0DQlJTYFDo1
         LSkqHO43iyvSQs3UM5O6rMHkcACaB55y+6zNQYmZzZxqn6lRO6ME1NYtMnoxqJUHfLhP
         JkdE7KiPziPgkUjJOor2ww26X7wFMC4xiDRmyEkAV/x45PtEVh+6kaIu80tXAc2ktmT7
         cUw3SrXJs64RrcbXJzkvKXGPO2frEza4Fgu7KUvOakxpvGElFj/zIJzEFMh6AbEy0PsX
         IJRvzDeEIInuNuXqJeMUGa1Vetw9T5eavThgOg/b29Moh/dERgPlZ+ekouox40oalz/v
         oG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347428;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y10GnXOzH9U5tz9iFzVskmw05u/+9XHwA2jBfRW8OlY=;
        b=08vrHRT7eqZ7npYQL/vRIsBsgKg159kClyTYc8gzhfkJu4HFf1cX672006+lJEkKNd
         rDFXELCxB0Uk5GMW4A4YLBLnfu87t7c2hrvZOLJC7QifQzWq3UDyZp92gosHaJa8x7DU
         l3OtOqlKqj+OZQTpiTVMXH1fGY9vgnvqzh2GTS54OmA56ZbFNNzAq0S6S5aqjC9k+fa4
         4n/uU8/Mk6FjqH8Wj2m+Whm37mofidEdsmoQhdJxxfEQ//UjIrZzGW9LFgJREQvm5wjw
         AxUDkfQs6WmZSVahOSSDdr3NyxBePXoYzGK0vgiUzg5PRhjuqgbBXzGIznvJZ6xGY7uB
         /ngw==
X-Gm-Message-State: AAQBX9fLAixt836yNLLFEDcDOYyto5AcDoqN/gLuvSsiATv9KO6PdFdg
        UjuU6smfRm5/AN890z+LNaHXFX8qvmQC
X-Google-Smtp-Source: AKy350Zuufbof6FtUY4Vvd5jNW+C3yO83paEfqQhCYt6zbb/o1XGiVWkoUM/0JZyeyr3PJ3CNXBq0zzY0Jw5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b3c:637f:ad00 with SMTP
 id w3-20020a056902100300b00b3c637fad00mr6874ybt.5.1679347427908; Mon, 20 Mar
 2023 14:23:47 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:37 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-7-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 06/17] perf map: Rename map_ip and unmap_ip
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dso to match comment. This avoids a naming conflict with later
added accessor functions for variables in struct map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c    | 2 +-
 tools/perf/builtin-script.c  | 4 ++--
 tools/perf/util/machine.c    | 4 ++--
 tools/perf/util/map.c        | 8 ++++----
 tools/perf/util/map.h        | 4 ++--
 tools/perf/util/symbol-elf.c | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index f3029742b800..4d4b770a401c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -423,7 +423,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 		if (!caller) {
 			/* found */
 			if (node->ms.map)
-				addr = map__unmap_ip(node->ms.map, node->ip);
+				addr = map__dso_unmap_ip(node->ms.map, node->ip);
 			else
 				addr = node->ip;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index eb49689d0f00..21944adf4c17 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1012,11 +1012,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !map__dso(alf.map)->adjust_symbols)
-			from = map__map_ip(alf.map, from);
+			from = map__dso_map_ip(alf.map, from);
 
 		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
 		    !map__dso(alt.map)->adjust_symbols)
-			to = map__map_ip(alt.map, to);
+			to = map__dso_map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 08fb3ab0c205..5bf035b23a79 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3053,7 +3053,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__map_ip(map, ip);
+	addr = map__dso_map_ip(map, ip);
 	addr = map__rip_2objdump(map, addr);
 	dso = map__dso(map);
 
@@ -3098,7 +3098,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	 * its corresponding binary.
 	 */
 	if (entry->ms.map)
-		addr = map__map_ip(entry->ms.map, entry->ip);
+		addr = map__dso_map_ip(entry->ms.map, entry->ip);
 
 	srcline = callchain_srcline(&entry->ms, addr);
 	return callchain_cursor_append(cursor, entry->ip, &entry->ms,
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 416fc449bde8..d97a6d20626f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -109,8 +109,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->pgoff    = pgoff;
 	map->reloc    = 0;
 	map->dso      = dso__get(dso);
-	map->map_ip   = map__map_ip;
-	map->unmap_ip = map__unmap_ip;
+	map->map_ip   = map__dso_map_ip;
+	map->unmap_ip = map__dso_unmap_ip;
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -590,12 +590,12 @@ struct maps *map__kmaps(struct map *map)
 	return kmap->kmaps;
 }
 
-u64 map__map_ip(const struct map *map, u64 ip)
+u64 map__dso_map_ip(const struct map *map, u64 ip)
 {
 	return ip - map__start(map) + map->pgoff;
 }
 
-u64 map__unmap_ip(const struct map *map, u64 ip)
+u64 map__dso_unmap_ip(const struct map *map, u64 ip)
 {
 	return ip + map__start(map) - map->pgoff;
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 16646b94fa3a..9b0a84e46e48 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -41,9 +41,9 @@ struct kmap *map__kmap(struct map *map);
 struct maps *map__kmaps(struct map *map);
 
 /* ip -> dso rip */
-u64 map__map_ip(const struct map *map, u64 ip);
+u64 map__dso_map_ip(const struct map *map, u64 ip);
 /* dso rip -> ip */
-u64 map__unmap_ip(const struct map *map, u64 ip);
+u64 map__dso_unmap_ip(const struct map *map, u64 ip);
 /* Returns ip */
 u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 0542985ecaf6..93ae3f22fd03 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1351,8 +1351,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map->start = shdr->sh_addr + ref_reloc(kmap);
 			map->end = map__start(map) + shdr->sh_size;
 			map->pgoff = shdr->sh_offset;
-			map->map_ip = map__map_ip;
-			map->unmap_ip = map__unmap_ip;
+			map->map_ip = map__dso_map_ip;
+			map->unmap_ip = map__dso_unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
-- 
2.40.0.rc1.284.g88254d51c5-goog

