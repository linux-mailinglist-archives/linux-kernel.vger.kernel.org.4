Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E46C2392
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCTVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCTVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32027D8E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so135456317b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347412;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCPsVarVbCCpTaNQyEy/KRjlDglBfjSGr3AOUxgUf4c=;
        b=tOVAKSqbxj9z9O9MP4/376ahvhcVUDV9mErh+W9STA4pJYWSpWL3Ok0Uu/AIkRFxbK
         Y485AgfUCelZMnmegMhgPZI5/8ULRqyasCCUETSPfnlgjG6lvlF2hQbhWgRjueIYEaJb
         hRqoOrEWiwppBOA+6k9XzDxvtPyVdYwX1i+CakNE2KlvW/9Doyq4nowJnZyrNESOns90
         lSAgPe/f27Z6pDIOykZO9apwneiin+ozhuc4+ZWfK8PQhyQEJJ/muw8J8nF+yOPP6GhW
         t21V/Jn1kSnQ0pO5pomsYOoT9IgW4wKwt2ofh0VsfKrI6FBFABButsrOOih71k3ORT6q
         27Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347412;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCPsVarVbCCpTaNQyEy/KRjlDglBfjSGr3AOUxgUf4c=;
        b=h278G9qo/0VCnwi2avKpsiyUEv6tUKEI4GavZdHmZj5LG57czdx68A8+kOgIJbsej3
         4TDb1DyoY9ThG84ut+k8ucXiO7E/9rJdEoe0KfVf5kTFHFU52QIxuFKcdYSr+T4vdthN
         mblCKUk8Zk4YxLFiht7z/Zh6u7JAu5NcQ5aTKnqwqt7nwpRVJDdAGcl70vogcbcTXyqn
         L4H5wB0Ugo0yMp0oPZ63o9q0LmOBQu0SPbsSDdMcxsZDHx9btLVS+0YweO/L8sN4r0K1
         WIcTHuoTJAvuxR7nX1BJ6btv6chhGTW9wZZkuiCnjpqrbFjCebU6PoCUvFlx5rWLdzja
         BqCQ==
X-Gm-Message-State: AO0yUKUda8smUKyjJPfbUdf0J62+5hfk7/ty2tGsHBVUFtTx3l6om51m
        xUF948WkrhZPxGGe6obak/OtCa/+5MTW
X-Google-Smtp-Source: AK7set+P0DcGW9BbPtSbZnffnWchgFZ6x/ekRsq9ca6oiSdzlHSm+w//+BbtYhvvLABmbTCm7lbExUwOkD/Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a81:431b:0:b0:544:94fe:4244 with SMTP id
 q27-20020a81431b000000b0054494fe4244mr11170099ywa.10.1679347412727; Mon, 20
 Mar 2023 14:23:32 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:35 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-5-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 04/17] perf map: Add accessor for dso
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

Later changes will add reference count checking for struct map, with
dso being the most frequently accessed variable. Add an accessor so
that the reference count check is only necessary in one place.

Additional changes:
 - add a dso variable to avoid repeated map__dso calls.
 - in builtin-mem.c dump_raw_samples, code only partially tested for
   dso == NULL. Make the possibility of NULL consistent.
 - in thread.c thread__memcpy fix use of spaces and use tabs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c                 | 11 ++-
 tools/perf/builtin-buildid-list.c             |  2 +-
 tools/perf/builtin-inject.c                   |  8 +-
 tools/perf/builtin-kallsyms.c                 |  4 +-
 tools/perf/builtin-mem.c                      | 10 +-
 tools/perf/builtin-report.c                   |  7 +-
 tools/perf/builtin-script.c                   | 19 ++--
 tools/perf/builtin-top.c                      | 11 ++-
 tools/perf/builtin-trace.c                    |  2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  6 +-
 tools/perf/tests/code-reading.c               | 28 +++---
 tools/perf/tests/hists_common.c               |  8 +-
 tools/perf/tests/hists_cumulate.c             |  4 +-
 tools/perf/tests/hists_filter.c               |  4 +-
 tools/perf/tests/hists_output.c               |  2 +-
 tools/perf/tests/maps.c                       |  2 +-
 tools/perf/tests/symbols.c                    |  6 +-
 tools/perf/tests/vmlinux-kallsyms.c           | 13 ++-
 tools/perf/ui/browsers/annotate.c             |  9 +-
 tools/perf/ui/browsers/hists.c                | 16 ++--
 tools/perf/ui/browsers/map.c                  |  4 +-
 tools/perf/util/annotate.c                    | 16 ++--
 tools/perf/util/auxtrace.c                    |  2 +-
 tools/perf/util/block-info.c                  |  4 +-
 tools/perf/util/bpf-event.c                   | 10 +-
 tools/perf/util/build-id.c                    |  2 +-
 tools/perf/util/callchain.c                   |  6 +-
 tools/perf/util/data-convert-json.c           | 10 +-
 tools/perf/util/db-export.c                   |  4 +-
 tools/perf/util/dlfilter.c                    | 10 +-
 tools/perf/util/event.c                       |  9 +-
 tools/perf/util/evsel_fprintf.c               |  2 +-
 tools/perf/util/hist.c                        | 10 +-
 tools/perf/util/intel-pt.c                    | 45 +++++----
 tools/perf/util/machine.c                     | 70 ++++++++------
 tools/perf/util/map.c                         | 96 ++++++++++++-------
 tools/perf/util/map.h                         |  7 +-
 tools/perf/util/maps.c                        |  7 +-
 tools/perf/util/probe-event.c                 | 30 +++---
 .../util/scripting-engines/trace-event-perl.c | 10 +-
 .../scripting-engines/trace-event-python.c    | 16 ++--
 tools/perf/util/sort.c                        | 49 +++++-----
 tools/perf/util/symbol-elf.c                  |  2 +-
 tools/perf/util/symbol.c                      | 55 +++++++----
 tools/perf/util/synthetic-events.c            | 12 +--
 tools/perf/util/thread.c                      | 25 +++--
 tools/perf/util/unwind-libdw.c                | 10 +-
 tools/perf/util/vdso.c                        |  2 +-
 48 files changed, 404 insertions(+), 293 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4750fac7bf93..9e220159e320 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -205,7 +205,7 @@ static int process_branch_callback(struct evsel *evsel,
 		return 0;
 
 	if (a.map != NULL)
-		a.map->dso->hit = 1;
+		map__dso(a.map)->hit = 1;
 
 	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
 
@@ -235,10 +235,11 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 		 * the DSO?
 		 */
 		if (al->sym != NULL) {
-			rb_erase_cached(&al->sym->rb_node,
-				 &al->map->dso->symbols);
+			struct dso *dso = map__dso(al->map);
+
+			rb_erase_cached(&al->sym->rb_node, &dso->symbols);
 			symbol__delete(al->sym);
-			dso__reset_find_symbol_cache(al->map->dso);
+			dso__reset_find_symbol_cache(dso);
 		}
 		return 0;
 	}
@@ -320,7 +321,7 @@ static void hists__find_annotations(struct hists *hists,
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
 
-		if (he->ms.sym == NULL || he->ms.map->dso->annotate_warned)
+		if (he->ms.sym == NULL || map__dso(he->ms.map)->annotate_warned)
 			goto find_next;
 
 		if (ann->sym_hist_filter &&
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 00bfe89f0b5d..cad9ed44ce7c 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -24,7 +24,7 @@
 
 static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 {
-	const struct dso *dso = map->dso;
+	const struct dso *dso = map__dso(map);
 	char bid_buf[SBUILD_ID_SIZE];
 
 	memset(bid_buf, 0, sizeof(bid_buf));
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 10bb1d494258..8f6909dd8a54 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -753,9 +753,11 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		if (!al.map->dso->hit) {
-			al.map->dso->hit = 1;
-			dso__inject_build_id(al.map->dso, tool, machine,
+		struct dso *dso = map__dso(al.map);
+
+		if (!dso->hit) {
+			dso->hit = 1;
+			dso__inject_build_id(dso, tool, machine,
 					     sample->cpumode, al.map->flags);
 		}
 	}
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index c08ee81529e8..5638ca4dbd8e 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -28,6 +28,7 @@ static int __cmd_kallsyms(int argc, const char **argv)
 
 	for (i = 0; i < argc; ++i) {
 		struct map *map;
+		const struct dso *dso;
 		struct symbol *symbol = machine__find_kernel_symbol_by_name(machine, argv[i], &map);
 
 		if (symbol == NULL) {
@@ -35,8 +36,9 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			continue;
 		}
 
+		dso = map__dso(map);
 		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, map->dso->short_name, map->dso->long_name,
+			symbol->name, dso->short_name, dso->long_name,
 			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
 			symbol->start, symbol->end);
 	}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index dedd612eae5e..1e27188b0de1 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -200,6 +200,7 @@ dump_raw_samples(struct perf_tool *tool,
 	struct addr_location al;
 	const char *fmt, *field_sep;
 	char str[PAGE_SIZE_NAME_LEN];
+	struct dso *dso = NULL;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -210,8 +211,11 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.filtered || (mem->hide_unresolved && al.sym == NULL))
 		goto out_put;
 
-	if (al.map != NULL)
-		al.map->dso->hit = 1;
+	if (al.map != NULL) {
+		dso = map__dso(al.map);
+		if (dso)
+			dso->hit = 1;
+	}
 
 	field_sep = symbol_conf.field_sep;
 	if (field_sep) {
@@ -252,7 +256,7 @@ dump_raw_samples(struct perf_tool *tool,
 		symbol_conf.field_sep,
 		sample->data_src,
 		symbol_conf.field_sep,
-		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+		dso ? dso->long_name : "???",
 		al.sym ? al.sym->name : "???");
 out_put:
 	addr_location__put(&al);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c453b7fa7418..02ca87c13e91 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -314,7 +314,7 @@ static int process_sample_event(struct perf_tool *tool,
 	}
 
 	if (al.map != NULL)
-		al.map->dso->hit = 1;
+		map__dso(al.map)->hit = 1;
 
 	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
@@ -603,7 +603,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
 		return;
 
 	if (kernel_map == NULL ||
-	    (kernel_map->dso->hit &&
+	     (map__dso(kernel_map)->hit &&
 	     (kernel_kmap->ref_reloc_sym == NULL ||
 	      kernel_kmap->ref_reloc_sym->addr == 0))) {
 		const char *desc =
@@ -844,6 +844,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 
 	maps__for_each_entry(maps, rb_node) {
 		struct map *map = rb_node->map;
+		const struct dso *dso = map__dso(map);
 
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
 				   indent, "", map->start, map->end,
@@ -852,7 +853,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 				   map->prot & PROT_EXEC ? 'x' : '-',
 				   map->flags & MAP_SHARED ? 's' : 'p',
 				   map->pgoff,
-				   map->dso->id.ino, map->dso->name);
+				   dso->id.ino, dso->name);
 	}
 
 	return printed;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 976f8bfe099c..9c7eb900ff7c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1011,11 +1011,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		to   = entries[i].to;
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
-		    !alf.map->dso->adjust_symbols)
+		    !map__dso(alf.map)->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
 		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
-		    !alt.map->dso->adjust_symbols)
+		    !map__dso(alt.map)->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -1044,6 +1044,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	long offset, len;
 	struct addr_location al;
 	bool kernel;
+	struct dso *dso;
 
 	if (!start || !end)
 		return 0;
@@ -1074,11 +1075,12 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		return 0;
 	}
 
-	if (!thread__find_map(thread, *cpumode, start, &al) || !al.map->dso) {
+	dso = map__dso(al.map);
+	if (!thread__find_map(thread, *cpumode, start, &al) || !dso) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
-	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR) {
+	if (dso->data.status == DSO_DATA_STATUS_ERROR) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
@@ -1087,10 +1089,10 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	map__load(al.map);
 
 	offset = al.map->map_ip(al.map, start);
-	len = dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buffer,
+	len = dso__data_read_offset(dso, machine, offset, (u8 *)buffer,
 				    end - start + MAXINSN);
 
-	*is64bit = al.map->dso->is_64_bit;
+	*is64bit = dso->is_64_bit;
 	if (len <= 0)
 		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
 			start, end);
@@ -1104,10 +1106,11 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 	unsigned line;
 	int len;
 	char *srccode;
+	struct dso *dso = map__dso(map);
 
-	if (!map || !map->dso)
+	if (!map || !dso)
 		return 0;
-	srcfile = get_srcline_split(map->dso,
+	srcfile = get_srcline_split(dso,
 				    map__rip_2objdump(map, addr),
 				    &line);
 	if (!srcfile)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d4b5b02bab73..5010eee8fbae 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -114,6 +114,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	struct symbol *sym;
 	struct annotation *notes;
 	struct map *map;
+	struct dso *dso;
 	int err = -1;
 
 	if (!he || !he->ms.sym)
@@ -123,12 +124,12 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 
 	sym = he->ms.sym;
 	map = he->ms.map;
+	dso = map__dso(map);
 
 	/*
 	 * We can't annotate with just /proc/kallsyms
 	 */
-	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(map->dso)) {
+	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
 		pr_err("Can't annotate %s: No vmlinux file was found in the "
 		       "path\n", sym->name);
 		sleep(1);
@@ -169,6 +170,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 {
 	struct utsname uts;
 	int err = uname(&uts);
+	struct dso *dso = map__dso(map);
 
 	ui__warning("Out of bounds address found:\n\n"
 		    "Addr:   %" PRIx64 "\n"
@@ -180,7 +182,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Tools:  %s\n\n"
 		    "Not all samples will be on the annotation output.\n\n"
 		    "Please report to linux-kernel@vger.kernel.org\n",
-		    ip, map->dso->long_name, dso__symtab_origin(map->dso),
+		    ip, dso->long_name, dso__symtab_origin(dso),
 		    map->start, map->end, sym->start, sym->end,
 		    sym->binding == STB_GLOBAL ? 'g' :
 		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
@@ -810,7 +812,8 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
-				dso__strerror_load(al.map->dso, serr, sizeof(serr));
+
+				dso__strerror_load(map__dso(al.map), serr, sizeof(serr));
 				ui__warning("The %s file can't be used: %s\n%s",
 					    symbol_conf.vmlinux_name, serr, msg);
 			} else {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b363c609818b..72ef0bebb06b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2863,7 +2863,7 @@ static void print_location(FILE *f, struct perf_sample *sample,
 {
 
 	if ((verbose > 0 || print_dso) && al->map)
-		fprintf(f, "%s@", al->map->dso->long_name);
+		fprintf(f, "%s@", map__dso(al->map)->long_name);
 
 	if ((verbose > 0 || print_sym) && al->sym)
 		fprintf(f, "%s+0x%" PRIx64, al->sym->name,
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index feedd02b3b3d..53b1587db403 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -145,6 +145,7 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
 	char *srccode = NULL;
 	PyObject *result;
 	struct map *map;
+	struct dso *dso;
 	int len = 0;
 	u64 addr;
 
@@ -153,9 +154,10 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
 
 	map = c->al->map;
 	addr = c->al->addr;
+	dso = map ? map__dso(map) : NULL;
 
-	if (map && map->dso)
-		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
+	if (dso)
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
 
 	if (get_srccode) {
 		if (srcfile)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 8d2036f2f944..936c61546e64 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -237,10 +237,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	char decomp_name[KMOD_DECOMP_LEN];
 	bool decomp = false;
 	int ret, err = 0;
+	struct dso *dso;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
-	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
+	if (!thread__find_map(thread, cpumode, addr, &al) || !map__dso(al.map)) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			goto out;
@@ -250,11 +251,10 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		err = -1;
 		goto out;
 	}
+	dso = map__dso(al.map);
+	pr_debug("File is: %s\n", dso->long_name);
 
-	pr_debug("File is: %s\n", al.map->dso->long_name);
-
-	if (al.map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(al.map->dso)) {
+	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
 		pr_debug("Unexpected kernel address - skipping\n");
 		goto out;
 	}
@@ -269,7 +269,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		len = al.map->end - addr;
 
 	/* Read the object code using perf */
-	ret_len = dso__data_read_offset(al.map->dso, maps__machine(thread->maps),
+	ret_len = dso__data_read_offset(dso, maps__machine(thread->maps),
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
@@ -287,7 +287,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	}
 
 	/* objdump struggles with kcore - try each map only once */
-	if (dso__is_kcore(al.map->dso)) {
+	if (dso__is_kcore(dso)) {
 		size_t d;
 
 		for (d = 0; d < state->done_cnt; d++) {
@@ -304,9 +304,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		state->done[state->done_cnt++] = al.map->start;
 	}
 
-	objdump_name = al.map->dso->long_name;
-	if (dso__needs_decompress(al.map->dso)) {
-		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+	objdump_name = dso->long_name;
+	if (dso__needs_decompress(dso)) {
+		if (dso__decompress_kmodule_path(dso, objdump_name,
 						 decomp_name,
 						 sizeof(decomp_name)) < 0) {
 			pr_debug("decompression failed\n");
@@ -335,7 +335,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			len -= ret;
 			if (len) {
 				pr_debug("Reducing len to %zu\n", len);
-			} else if (dso__is_kcore(al.map->dso)) {
+			} else if (dso__is_kcore(dso)) {
 				/*
 				 * objdump cannot handle very large segments
 				 * that may be found in kcore.
@@ -572,6 +572,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid_t pid;
 	struct map *map;
 	bool have_vmlinux, have_kcore, excl_kernel = false;
+	struct dso *dso;
 
 	pid = getpid();
 
@@ -595,8 +596,9 @@ static int do_test_code_reading(bool try_kcore)
 		pr_debug("map__load failed\n");
 		goto out_err;
 	}
-	have_vmlinux = dso__is_vmlinux(map->dso);
-	have_kcore = dso__is_kcore(map->dso);
+	dso = map__dso(map);
+	have_vmlinux = dso__is_vmlinux(dso);
+	have_kcore = dso__is_kcore(dso);
 
 	/* 2nd time through we just try kcore */
 	if (try_kcore && !have_kcore)
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 6f34d08b84e5..745ab18d17db 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -179,9 +179,11 @@ void print_hists_in(struct hists *hists)
 		he = rb_entry(node, struct hist_entry, rb_node_in);
 
 		if (!he->filtered) {
+			struct dso *dso = map__dso(he->ms.map);
+
 			pr_info("%2d: entry: %-8s [%-8s] %20s: period = %"PRIu64"\n",
 				i, thread__comm_str(he->thread),
-				he->ms.map->dso->short_name,
+				dso->short_name,
 				he->ms.sym->name, he->stat.period);
 		}
 
@@ -206,9 +208,11 @@ void print_hists_out(struct hists *hists)
 		he = rb_entry(node, struct hist_entry, rb_node);
 
 		if (!he->filtered) {
+			struct dso *dso = map__dso(he->ms.map);
+
 			pr_info("%2d: entry: %8s:%5d [%-8s] %20s: period = %"PRIu64"/%"PRIu64"\n",
 				i, thread__comm_str(he->thread), he->thread->tid,
-				he->ms.map->dso->short_name,
+				dso->short_name,
 				he->ms.sym->name, he->stat.period,
 				he->stat_acc ? he->stat_acc->period : 0);
 		}
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index b42d37ff2399..f00ec9abdbcd 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -150,12 +150,12 @@ static void del_hist_entries(struct hists *hists)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (he->ms.map->dso->short_name)
+#define DSO(he)   (map__dso(he->ms.map)->short_name)
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define PID(he)   (he->thread->tid)
 #define DEPTH(he) (he->callchain->max_depth)
-#define CDSO(cl)  (cl->ms.map->dso->short_name)
+#define CDSO(cl)  (map__dso(cl->ms.map)->short_name)
 #define CSYM(cl)  (cl->ms.sym->name)
 
 struct result {
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 8e1ceeb9b7b6..7c552549f4a4 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -194,7 +194,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 		hists__filter_by_thread(hists);
 
 		/* now applying dso filter for 'kernel' */
-		hists->dso_filter = fake_samples[0].map->dso;
+		hists->dso_filter = map__dso(fake_samples[0].map);
 		hists__filter_by_dso(hists);
 
 		if (verbose > 2) {
@@ -288,7 +288,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 
 		/* now applying all filters at once. */
 		hists->thread_filter = fake_samples[1].thread;
-		hists->dso_filter = fake_samples[1].map->dso;
+		hists->dso_filter = map__dso(fake_samples[1].map);
 		hists__filter_by_thread(hists);
 		hists__filter_by_dso(hists);
 
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 62b0093253e3..428d11a938f2 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -116,7 +116,7 @@ static void del_hist_entries(struct hists *hists)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (he->ms.map->dso->short_name)
+#define DSO(he)   (map__dso(he->ms.map)->short_name)
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define PID(he)   (he->thread->tid)
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 8246d37e4b7a..ae7028fbf79e 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -26,7 +26,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 
 		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
 		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
+		TEST_ASSERT_VAL("wrong map name",  !strcmp(map__dso(map)->name, merged[i].name));
 		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
 
 		i++;
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 0793f8f419e2..2d1aa42d36a9 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -102,6 +102,7 @@ static int test_file(struct test_info *ti, char *filename)
 {
 	struct map *map = NULL;
 	int ret, nr;
+	struct dso *dso;
 
 	pr_debug("Testing %s\n", filename);
 
@@ -109,7 +110,8 @@ static int test_file(struct test_info *ti, char *filename)
 	if (ret != TEST_OK)
 		return ret;
 
-	nr = dso__load(map->dso, map);
+	dso = map__dso(map);
+	nr = dso__load(dso, map);
 	if (nr < 0) {
 		pr_debug("dso__load() failed!\n");
 		ret = TEST_FAIL;
@@ -122,7 +124,7 @@ static int test_file(struct test_info *ti, char *filename)
 		goto out_put;
 	}
 
-	ret = test_dso(map->dso);
+	ret = test_dso(dso);
 out_put:
 	map__put(map);
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index c8abb3ca8347..c614c2db7e89 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -293,15 +293,16 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	maps__for_each_entry(maps, rb_node) {
 		struct map *map = rb_node->map;
+		struct dso *dso = map__dso(map);
 		/*
 		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
 		 * the kernel will have the path for the vmlinux file being used,
 		 * so use the short name, less descriptive but the same ("[kernel]" in
 		 * both cases.
 		 */
-		struct map *pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
-								map->dso->short_name :
-								map->dso->name));
+		struct map *pair = maps__find_by_name(kallsyms.kmaps, (dso->kernel ?
+								dso->short_name :
+								dso->name));
 		if (pair) {
 			pair->priv = 1;
 		} else {
@@ -326,17 +327,19 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 			continue;
 
 		if (pair->start == mem_start) {
+			struct dso *dso = map__dso(map);
+
 			if (!header_printed) {
 				pr_info("WARN: Maps in vmlinux with a different name in kallsyms:\n");
 				header_printed = true;
 			}
 
 			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-				map->start, map->end, map->pgoff, map->dso->name);
+				map->start, map->end, map->pgoff, dso->name);
 			if (mem_end != pair->end)
 				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
 					pair->start, pair->end, pair->pgoff);
-			pr_info(" %s\n", pair->dso->name);
+			pr_info(" %s\n", dso->name);
 			pair->priv = 1;
 		}
 	}
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c03fa76c02ff..12c3ce530e42 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -441,7 +441,8 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
+	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
+			map__dso(map)->long_name,
 			percent_type_str(percent_type));
 }
 
@@ -964,20 +965,22 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		},
 		.opts = opts,
 	};
+	struct dso *dso;
 	int ret = -1, err;
 	int not_annotated = list_empty(&notes->src->source);
 
 	if (sym == NULL)
 		return -1;
 
-	if (ms->map->dso->annotate_warned)
+	dso = map__dso(ms->map);
+	if (dso->annotate_warned)
 		return -1;
 
 	if (not_annotated) {
 		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
-			ms->map->dso->annotate_warned = true;
+			dso->annotate_warned = true;
 			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 			goto out_free_offsets;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 572ff38ceb0f..66d8c0802ecd 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2487,7 +2487,7 @@ static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
 			return NULL;
 		}
 
-		dso__insert_symbol(map->dso, sym);
+		dso__insert_symbol(map__dso(map), sym);
 	}
 
 	return sym;
@@ -2499,7 +2499,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct map_symbol *ms,
 		 u64 addr)
 {
-	if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
+	if (!ms->map || !map__dso(ms->map) || map__dso(ms->map)->annotate_warned)
 		return 0;
 
 	if (!ms->sym)
@@ -2590,8 +2590,10 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
 		ui_helpline__pop();
 	} else {
 		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
-				   __map__is_kernel(map) ? "the Kernel" : map->dso->short_name);
-		browser->hists->dso_filter = map->dso;
+				   __map__is_kernel(map)
+				   ? "the Kernel"
+				   : map__dso(map)->short_name);
+		browser->hists->dso_filter = map__dso(map);
 		perf_hpp__set_elide(HISTC_DSO, true);
 		pstack__push(browser->pstack, &browser->hists->dso_filter);
 	}
@@ -2616,7 +2618,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 
 	if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",
 		     browser->hists->dso_filter ? "out of" : "into",
-		     __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
+		     __map__is_kernel(map) ? "the Kernel" : map__dso(map)->short_name) < 0)
 		return 0;
 
 	act->ms.map = map;
@@ -3091,8 +3093,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 			if (!browser->selection ||
 			    !browser->selection->map ||
-			    !browser->selection->map->dso ||
-			    browser->selection->map->dso->annotate_warned) {
+			    !map__dso(browser->selection->map) ||
+			    map__dso(browser->selection->map)->annotate_warned) {
 				continue;
 			}
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 3d49b916c9e4..3d1b958d8832 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -76,7 +76,7 @@ static int map_browser__run(struct map_browser *browser)
 {
 	int key;
 
-	if (ui_browser__show(&browser->b, browser->map->dso->long_name,
+	if (ui_browser__show(&browser->b, map__dso(browser->map)->long_name,
 			     "Press ESC to exit, %s / to search",
 			     verbose > 0 ? "" : "restart with -v to use") < 0)
 		return -1;
@@ -106,7 +106,7 @@ int map__browse(struct map *map)
 {
 	struct map_browser mb = {
 		.b = {
-			.entries = &map->dso->symbols,
+			.entries = &map__dso(map)->symbols,
 			.refresh = ui_browser__rb_tree_refresh,
 			.seek	 = ui_browser__rb_tree_seek,
 			.write	 = map_browser__write,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index db475e44f42f..9494b34e84fc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1593,7 +1593,7 @@ static void delete_last_nop(struct symbol *sym)
 
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen)
 {
-	struct dso *dso = ms->map->dso;
+	struct dso *dso = map__dso(ms->map);
 
 	BUG_ON(buflen == 0);
 
@@ -1735,7 +1735,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	struct map *map = args->ms.map;
 	struct perf_bpil *info_linear;
 	struct disassemble_info info;
-	struct dso *dso = map->dso;
+	struct dso *dso = map__dso(map);
 	int pc = 0, count, sub_id;
 	struct btf *btf = NULL;
 	char tpath[PATH_MAX];
@@ -1958,7 +1958,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
 	struct map *map = args->ms.map;
-	struct dso *dso = map->dso;
+	struct dso *dso = map__dso(map);
 	char *command;
 	FILE *file;
 	char symfs_filename[PATH_MAX];
@@ -2403,7 +2403,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
-	struct dso *dso = map->dso;
+	struct dso *dso = map__dso(map);
 	char *filename;
 	const char *d_filename;
 	const char *evsel_name = evsel__name(evsel);
@@ -2586,7 +2586,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
-		ms->sym->name, ms->map->dso->long_name, ev_name);
+		ms->sym->name, map__dso(ms->map)->long_name, ev_name);
 	symbol__annotate_fprintf2(ms->sym, fp, opts);
 
 	fclose(fp);
@@ -2812,7 +2812,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
+		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
 		insert_source_line(&tmp_root, al, opts);
 	}
@@ -2831,7 +2831,7 @@ static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root,
 int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 			  struct annotation_options *opts)
 {
-	struct dso *dso = ms->map->dso;
+	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
@@ -2867,7 +2867,7 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 			 struct annotation_options *opts)
 {
-	struct dso *dso = ms->map->dso;
+	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	int err;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 498ff7f24463..2341de8573c0 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2557,7 +2557,7 @@ static struct dso *load_dso(const char *name)
 	if (map__load(map) < 0)
 		pr_err("File '%s' not found or has no symbols.\n", name);
 
-	dso = dso__get(map->dso);
+	dso = dso__get(map__dso(map));
 
 	map__put(map);
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 5ecd4f401f32..16a7b4adcf18 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -317,9 +317,9 @@ static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
 	struct map *map = he->ms.map;
 
-	if (map && map->dso) {
+	if (map && map__dso(map)) {
 		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
-				 map->dso->short_name);
+				 map__dso(map)->short_name);
 	}
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 025f331b3867..38fcf3ba5749 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -57,10 +57,12 @@ static int machine__process_bpf_event_load(struct machine *machine,
 		struct map *map = maps__find(machine__kernel_maps(machine), addr);
 
 		if (map) {
-			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
-			map->dso->bpf_prog.id = id;
-			map->dso->bpf_prog.sub_id = i;
-			map->dso->bpf_prog.env = env;
+			struct dso *dso = map__dso(map);
+
+			dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			dso->bpf_prog.id = id;
+			dso->bpf_prog.sub_id = i;
+			dso->bpf_prog.env = env;
 		}
 	}
 	return 0;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index ea9c083ab1e3..06a8cd88cbef 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -59,7 +59,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
-		al.map->dso->hit = 1;
+		map__dso(al.map)->hit = 1;
 
 	thread__put(thread);
 	return 0;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0aa979f64565..9e9c39dd9d2b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -701,8 +701,8 @@ static enum match_result match_chain_strings(const char *left,
 static enum match_result match_chain_dso_addresses(struct map *left_map, u64 left_ip,
 						   struct map *right_map, u64 right_ip)
 {
-	struct dso *left_dso = left_map ? left_map->dso : NULL;
-	struct dso *right_dso = right_map ? right_map->dso : NULL;
+	struct dso *left_dso = left_map ? map__dso(left_map) : NULL;
+	struct dso *right_dso = right_map ? map__dso(right_map) : NULL;
 
 	if (left_dso != right_dso)
 		return left_dso < right_dso ? MATCH_LT : MATCH_GT;
@@ -1174,7 +1174,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	if (show_dso)
 		scnprintf(bf + printed, bfsize - printed, " %s",
 			  cl->ms.map ?
-			  cl->ms.map->dso->short_name :
+			  map__dso(cl->ms.map)->short_name :
 			  "unknown");
 
 	return bf;
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index ba9d93ce9463..653709ab867a 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -128,15 +128,17 @@ static void output_sample_callchain_entry(struct perf_tool *tool,
 	output_json_key_format(out, false, 5, "ip", "\"0x%" PRIx64 "\"", ip);
 
 	if (al && al->sym && al->sym->namelen) {
+		struct dso *dso = al->map ? map__dso(al->map) : NULL;
+
 		fputc(',', out);
 		output_json_key_string(out, false, 5, "symbol", al->sym->name);
 
-		if (al->map && al->map->dso) {
-			const char *dso = al->map->dso->short_name;
+		if (dso) {
+			const char *dso_name = dso->short_name;
 
-			if (dso && strlen(dso) > 0) {
+			if (dso_name && strlen(dso_name) > 0) {
 				fputc(',', out);
-				output_json_key_string(out, false, 5, "dso", dso);
+				output_json_key_string(out, false, 5, "dso", dso_name);
 			}
 		}
 	}
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 1cfcfdd3cf52..84c970c11794 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -179,7 +179,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	int err;
 
 	if (al->map) {
-		struct dso *dso = al->map->dso;
+		struct dso *dso = map__dso(al->map);
 
 		err = db_export__dso(dbe, dso, maps__machine(al->maps));
 		if (err)
@@ -255,7 +255,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
-			al.sym = dso__find_symbol(al.map->dso, al.addr);
+			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
 
 		db_ids_from_al(dbe, &al, &dso_db_id, &sym_db_id, &offset);
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index fe2a0752a0f6..8a7ffe0d805a 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -29,7 +29,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 
 	d_al->size = sizeof(*d_al);
 	if (al->map) {
-		struct dso *dso = al->map->dso;
+		struct dso *dso = map__dso(al->map);
 
 		if (symbol_conf.show_kernel_path && dso->long_name)
 			d_al->dso = dso->long_name;
@@ -220,6 +220,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 	unsigned int line = 0;
 	char *srcfile = NULL;
 	struct map *map;
+	struct dso *dso;
 	u64 addr;
 
 	if (!d->ctx_valid || !line_no)
@@ -231,9 +232,10 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 
 	map = al->map;
 	addr = al->addr;
+	dso = map ? map__dso(map) : NULL;
 
-	if (map && map->dso)
-		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
+	if (dso)
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
 
 	*line_no = line;
 	return srcfile;
@@ -279,7 +281,7 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 	offset = map->map_ip(map, ip);
 	if (ip + len >= map->end)
 		len = map->end - ip;
-	return dso__data_read_offset(map->dso, d->machine, offset, buf, len);
+	return dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
 }
 
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f40cdd6ac126..2ddc75dee019 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -685,6 +685,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		     struct perf_sample *sample)
 {
 	struct thread *thread;
+	struct dso *dso;
 
 	if (symbol_conf.guest_code && !machine__is_host(machine))
 		thread = machine__findnew_guest_code(machine, sample->pid);
@@ -695,9 +696,11 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
 	thread__find_map(thread, sample->cpumode, sample->ip, al);
+	dso = al->map ? map__dso(al->map) : NULL;
 	dump_printf(" ...... dso: %s\n",
-		    al->map ? al->map->dso->long_name :
-			al->level == 'H' ? "[hypervisor]" : "<not found>");
+		dso
+		? dso->long_name
+		: (al->level == 'H' ? "[hypervisor]" : "<not found>"));
 
 	if (thread__is_filtered(thread))
 		al->filtered |= (1 << HIST_FILTER__THREAD);
@@ -715,8 +718,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	}
 
 	if (al->map) {
-		struct dso *dso = al->map->dso;
-
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
 						  dso->short_name) ||
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index bd22c4932d10..dff5d8c4b06d 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -155,7 +155,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 
 			if (print_ip) {
 				/* Show binary offset for userspace addr */
-				if (map && !map->dso->kernel)
+				if (map && !map__dso(map)->kernel)
 					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
 				else
 					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1b0e89cd5d99..fdf0562d2fd3 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -106,7 +106,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
 
 	if (h->ms.map) {
-		len = dso__name_len(h->ms.map->dso);
+		len = dso__name_len(map__dso(h->ms.map));
 		hists__new_col_len(hists, HISTC_DSO, len);
 	}
 
@@ -120,7 +120,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
 
-			symlen = dso__name_len(h->branch_info->from.ms.map->dso);
+			symlen = dso__name_len(map__dso(h->branch_info->from.ms.map));
 			hists__new_col_len(hists, HISTC_DSO_FROM, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -135,7 +135,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
 
-			symlen = dso__name_len(h->branch_info->to.ms.map->dso);
+			symlen = dso__name_len(map__dso(h->branch_info->to.ms.map));
 			hists__new_col_len(hists, HISTC_DSO_TO, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -180,7 +180,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		}
 
 		if (h->mem_info->daddr.ms.map) {
-			symlen = dso__name_len(h->mem_info->daddr.ms.map->dso);
+			symlen = dso__name_len(map__dso(h->mem_info->daddr.ms.map));
 			hists__new_col_len(hists, HISTC_MEM_DADDR_DSO,
 					   symlen);
 		} else {
@@ -2104,7 +2104,7 @@ static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he)
 {
 	if (hists->dso_filter != NULL &&
-	    (he->ms.map == NULL || he->ms.map->dso != hists->dso_filter)) {
+	    (he->ms.map == NULL || map__dso(he->ms.map) != hists->dso_filter)) {
 		he->filtered |= (1 << HIST_FILTER__DSO);
 		return true;
 	}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 955c1b9dc6a4..8cec88e09792 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -801,17 +801,19 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	}
 
 	while (1) {
-		if (!thread__find_map(thread, cpumode, *ip, &al) || !al.map->dso) {
+		struct dso *dso;
+
+		if (!thread__find_map(thread, cpumode, *ip, &al) || !map__dso(al.map)) {
 			if (al.map)
 				intel_pt_log("ERROR: thread has no dso for %#" PRIx64 "\n", *ip);
 			else
 				intel_pt_log("ERROR: thread has no map for %#" PRIx64 "\n", *ip);
 			return -EINVAL;
 		}
+		dso = map__dso(al.map);
 
-		if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
-		    dso__data_status_seen(al.map->dso,
-					  DSO_DATA_STATUS_SEEN_ITRACE))
+		if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+		    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 			return -ENOENT;
 
 		offset = al.map->map_ip(al.map, *ip);
@@ -819,7 +821,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		if (!to_ip && one_map) {
 			struct intel_pt_cache_entry *e;
 
-			e = intel_pt_cache_lookup(al.map->dso, machine, offset);
+			e = intel_pt_cache_lookup(dso, machine, offset);
 			if (e &&
 			    (!max_insn_cnt || e->insn_cnt <= max_insn_cnt)) {
 				*insn_cnt_ptr = e->insn_cnt;
@@ -829,8 +831,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				intel_pt_insn->emulated_ptwrite = e->emulated_ptwrite;
 				intel_pt_insn->length = e->length;
 				intel_pt_insn->rel = e->rel;
-				memcpy(intel_pt_insn->buf, e->insn,
-				       INTEL_PT_INSN_BUF_SZ);
+				memcpy(intel_pt_insn->buf, e->insn, INTEL_PT_INSN_BUF_SZ);
 				intel_pt_log_insn_no_data(intel_pt_insn, *ip);
 				return 0;
 			}
@@ -842,17 +843,17 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		/* Load maps to ensure dso->is_64_bit has been updated */
 		map__load(al.map);
 
-		x86_64 = al.map->dso->is_64_bit;
+		x86_64 = dso->is_64_bit;
 
 		while (1) {
-			len = dso__data_read_offset(al.map->dso, machine,
+			len = dso__data_read_offset(dso, machine,
 						    offset, buf,
 						    INTEL_PT_INSN_BUF_SZ);
 			if (len <= 0) {
 				intel_pt_log("ERROR: failed to read at offset %#" PRIx64 " ",
 					     offset);
 				if (intel_pt_enable_logging)
-					dso__fprintf(al.map->dso, intel_pt_log_fp());
+					dso__fprintf(dso, intel_pt_log_fp());
 				return -EINVAL;
 			}
 
@@ -871,7 +872,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 					goto out;
 				/* Check for emulated ptwrite */
 				offs = offset + intel_pt_insn->length;
-				eptw = intel_pt_emulated_ptwrite(al.map->dso, machine, offs);
+				eptw = intel_pt_emulated_ptwrite(dso, machine, offs);
 				intel_pt_insn->emulated_ptwrite = eptw;
 				goto out;
 			}
@@ -906,13 +907,13 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	if (to_ip) {
 		struct intel_pt_cache_entry *e;
 
-		e = intel_pt_cache_lookup(al.map->dso, machine, start_offset);
+		e = intel_pt_cache_lookup(map__dso(al.map), machine, start_offset);
 		if (e)
 			return 0;
 	}
 
 	/* Ignore cache errors */
-	intel_pt_cache_add(al.map->dso, machine, start_offset, insn_cnt,
+	intel_pt_cache_add(map__dso(al.map), machine, start_offset, insn_cnt,
 			   *ip - start_ip, intel_pt_insn);
 
 	return 0;
@@ -983,13 +984,12 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	if (!thread)
 		return -EINVAL;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
+	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
 		return -EINVAL;
 
 	offset = al.map->map_ip(al.map, ip);
 
-	return intel_pt_match_pgd_ip(ptq->pt, ip, offset,
-				     al.map->dso->long_name);
+	return intel_pt_match_pgd_ip(ptq->pt, ip, offset, map__dso(al.map)->long_name);
 }
 
 static bool intel_pt_pgd_ip(uint64_t ip, void *data)
@@ -2744,7 +2744,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	if (map__load(map))
 		return 0;
 
-	start = dso__first_symbol(map->dso);
+	start = dso__first_symbol(map__dso(map));
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (sym->binding == STB_GLOBAL &&
@@ -3381,18 +3381,21 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 		return 0;
 
 	for (; cnt; cnt--, addr--) {
+		struct dso *dso;
+
 		if (intel_pt_find_map(thread, cpumode, addr, &al)) {
 			if (addr < event->text_poke.addr)
 				return 0;
 			continue;
 		}
 
-		if (!al.map->dso || !al.map->dso->auxtrace_cache)
+		dso = map__dso(al.map);
+		if (!dso || !dso->auxtrace_cache)
 			continue;
 
 		offset = al.map->map_ip(al.map, addr);
 
-		e = intel_pt_cache_lookup(al.map->dso, machine, offset);
+		e = intel_pt_cache_lookup(dso, machine, offset);
 		if (!e)
 			continue;
 
@@ -3405,9 +3408,9 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 			if (e->branch != INTEL_PT_BR_NO_BRANCH)
 				return 0;
 		} else {
-			intel_pt_cache_invalidate(al.map->dso, machine, offset);
+			intel_pt_cache_invalidate(dso, machine, offset);
 			intel_pt_log("Invalidated instruction cache for %s at %#"PRIx64"\n",
-				     al.map->dso->long_name, addr);
+				     dso->long_name, addr);
 		}
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 446c0273259d..6e32344e66dc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -47,7 +47,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
-	return machine->vmlinux_map->dso;
+	return map__dso(machine->vmlinux_map);
 }
 
 static void dsos__init(struct dsos *dsos)
@@ -878,12 +878,13 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
+	struct dso *dso;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 
 	if (!map) {
-		struct dso *dso = dso__new(event->ksymbol.name);
 		int err;
 
+		dso = dso__new(event->ksymbol.name);
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
 			map = map__new2(0, dso);
@@ -895,9 +896,9 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
-			map->dso->binary_type = DSO_BINARY_TYPE__OOL;
-			map->dso->data.file_size = event->ksymbol.len;
-			dso__set_loaded(map->dso);
+			dso->binary_type = DSO_BINARY_TYPE__OOL;
+			dso->data.file_size = event->ksymbol.len;
+			dso__set_loaded(dso);
 		}
 
 		map->start = event->ksymbol.addr;
@@ -913,6 +914,8 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso->binary_type = DSO_BINARY_TYPE__BPF_IMAGE;
 			dso__set_long_name(dso, "", false);
 		}
+	} else {
+		dso = map__dso(map);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
@@ -920,7 +923,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			  0, 0, event->ksymbol.name);
 	if (!sym)
 		return -ENOMEM;
-	dso__insert_symbol(map->dso, sym);
+	dso__insert_symbol(dso, sym);
 	return 0;
 }
 
@@ -938,9 +941,11 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	if (map != machine->vmlinux_map)
 		maps__remove(machine__kernel_maps(machine), map);
 	else {
-		sym = dso__find_symbol(map->dso, map->map_ip(map, map->start));
+		struct dso *dso = map__dso(map);
+
+		sym = dso__find_symbol(dso, map->map_ip(map, map->start));
 		if (sym)
-			dso__delete_symbol(map->dso, sym);
+			dso__delete_symbol(dso, sym);
 	}
 
 	return 0;
@@ -964,6 +969,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 {
 	struct map *map = maps__find(machine__kernel_maps(machine), event->text_poke.addr);
 	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	struct dso *dso = map ? map__dso(map) : NULL;
 
 	if (dump_trace)
 		perf_event__fprintf_text_poke(event, machine, stdout);
@@ -976,7 +982,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		return 0;
 	}
 
-	if (map && map->dso) {
+	if (dso) {
 		u8 *new_bytes = event->text_poke.bytes + event->text_poke.old_len;
 		int ret;
 
@@ -985,7 +991,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		 * must be done prior to using kernel maps.
 		 */
 		map__load(map);
-		ret = dso__data_write_cache_addr(map->dso, map, machine,
+		ret = dso__data_write_cache_addr(dso, map, machine,
 						 event->text_poke.addr,
 						 new_bytes,
 						 event->text_poke.new_len);
@@ -1421,10 +1427,11 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 int machine__load_kallsyms(struct machine *machine, const char *filename)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
+	struct dso *dso = map__dso(map);
+	int ret = __dso__load_kallsyms(dso, filename, map, true);
 
 	if (ret > 0) {
-		dso__set_loaded(map->dso);
+		dso__set_loaded(dso);
 		/*
 		 * Since /proc/kallsyms will have multiple sessions for the
 		 * kernel, with modules between them, fixup the end of all
@@ -1439,10 +1446,11 @@ int machine__load_kallsyms(struct machine *machine, const char *filename)
 int machine__load_vmlinux_path(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = dso__load_vmlinux_path(map->dso, map);
+	struct dso *dso = map__dso(map);
+	int ret = dso__load_vmlinux_path(dso, map);
 
 	if (ret > 0)
-		dso__set_loaded(map->dso);
+		dso__set_loaded(dso);
 
 	return ret;
 }
@@ -1484,6 +1492,7 @@ static bool is_kmod_dso(struct dso *dso)
 static int maps__set_module_path(struct maps *maps, const char *path, struct kmod_path *m)
 {
 	char *long_name;
+	struct dso *dso;
 	struct map *map = maps__find_by_name(maps, m->name);
 
 	if (map == NULL)
@@ -1493,16 +1502,17 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 	if (long_name == NULL)
 		return -ENOMEM;
 
-	dso__set_long_name(map->dso, long_name, true);
-	dso__kernel_module_get_build_id(map->dso, "");
+	dso = map__dso(map);
+	dso__set_long_name(dso, long_name, true);
+	dso__kernel_module_get_build_id(dso, "");
 
 	/*
 	 * Full name could reveal us kmod compression, so
 	 * we need to update the symtab_type if needed.
 	 */
-	if (m->comp && is_kmod_dso(map->dso)) {
-		map->dso->symtab_type++;
-		map->dso->comp = m->comp;
+	if (m->comp && is_kmod_dso(dso)) {
+		dso->symtab_type++;
+		dso->comp = m->comp;
 	}
 
 	return 0;
@@ -1601,7 +1611,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 		return -1;
 	map->end = start + size;
 
-	dso__kernel_module_get_build_id(map->dso, machine->root_dir);
+	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
 
 	return 0;
 }
@@ -1787,7 +1797,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		map->end = map->start + xm->end - xm->start;
 
 		if (build_id__is_defined(bid))
-			dso__set_build_id(map->dso, bid);
+			dso__set_build_id(map__dso(map), bid);
 
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = xm->name + strlen(mmap_name);
@@ -2247,18 +2257,20 @@ static char *callchain_srcline(struct map_symbol *ms, u64 ip)
 {
 	struct map *map = ms->map;
 	char *srcline = NULL;
+	struct dso *dso;
 
 	if (!map || callchain_param.key == CCKEY_FUNCTION)
 		return srcline;
 
-	srcline = srcline__tree_find(&map->dso->srclines, ip);
+	dso = map__dso(map);
+	srcline = srcline__tree_find(&dso->srclines, ip);
 	if (!srcline) {
 		bool show_sym = false;
 		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
 
-		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
+		srcline = get_srcline(dso, map__rip_2objdump(map, ip),
 				      ms->sym, show_sym, show_addr, ip);
-		srcline__tree_insert(&map->dso->srclines, ip, srcline);
+		srcline__tree_insert(&dso->srclines, ip, srcline);
 	}
 
 	return srcline;
@@ -3034,6 +3046,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	struct map *map = ms->map;
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
+	struct dso *dso;
 	u64 addr;
 	int ret = 1;
 
@@ -3042,13 +3055,14 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 	addr = map__map_ip(map, ip);
 	addr = map__rip_2objdump(map, addr);
+	dso = map__dso(map);
 
-	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	inline_node = inlines__tree_find(&dso->inlined_nodes, addr);
 	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
+		inline_node = dso__parse_addr_inlines(dso, addr, sym);
 		if (!inline_node)
 			return ret;
-		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
+		inlines__tree_insert(&dso->inlined_nodes, inline_node);
 	}
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
@@ -3325,7 +3339,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	if (sym == NULL)
 		return NULL;
 
-	*modp = __map__is_kmodule(map) ? (char *)map->dso->short_name : NULL;
+	*modp = __map__is_kmodule(map) ? (char *)map__dso(map)->short_name : NULL;
 	*addrp = map->unmap_ip(map, sym->start);
 	return sym->name;
 }
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a99dbde656a2..90062af6675a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -232,7 +232,7 @@ struct map *map__new2(u64 start, struct dso *dso)
 
 bool __map__is_kernel(const struct map *map)
 {
-	if (!map->dso->kernel)
+	if (!map__dso(map)->kernel)
 		return false;
 	return machine__kernel_map(maps__machine(map__kmaps((struct map *)map))) == map;
 }
@@ -247,8 +247,9 @@ bool __map__is_extra_kernel_map(const struct map *map)
 bool __map__is_bpf_prog(const struct map *map)
 {
 	const char *name;
+	struct dso *dso = map__dso(map);
 
-	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return true;
 
 	/*
@@ -256,15 +257,16 @@ bool __map__is_bpf_prog(const struct map *map)
 	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
 	 * guess the type based on name.
 	 */
-	name = map->dso->short_name;
+	name = dso->short_name;
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
 bool __map__is_bpf_image(const struct map *map)
 {
 	const char *name;
+	struct dso *dso = map__dso(map);
 
-	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
 		return true;
 
 	/*
@@ -272,18 +274,20 @@ bool __map__is_bpf_image(const struct map *map)
 	 * type of DSO_BINARY_TYPE__BPF_IMAGE. In such cases, we can
 	 * guess the type based on name.
 	 */
-	name = map->dso->short_name;
+	name = dso->short_name;
 	return name && is_bpf_image(name);
 }
 
 bool __map__is_ool(const struct map *map)
 {
-	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
+	const struct dso *dso = map__dso(map);
+
+	return dso && dso->binary_type == DSO_BINARY_TYPE__OOL;
 }
 
 bool map__has_symbols(const struct map *map)
 {
-	return dso__has_symbols(map->dso);
+	return dso__has_symbols(map__dso(map));
 }
 
 static void map__exit(struct map *map)
@@ -306,18 +310,23 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct dso *dso = map__dso(map);
+	struct rb_root_cached *symbols = &dso->symbols;
 	struct rb_node *nd = rb_first_cached(symbols);
+
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+
 		map->start = sym->start;
 	}
 }
 
 void map__fixup_end(struct map *map)
 {
-	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct dso *dso = map__dso(map);
+	struct rb_root_cached *symbols = &dso->symbols;
 	struct rb_node *nd = rb_last(&symbols->rb_root);
+
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 		map->end = sym->end;
@@ -328,18 +337,19 @@ void map__fixup_end(struct map *map)
 
 int map__load(struct map *map)
 {
-	const char *name = map->dso->long_name;
+	struct dso *dso = map__dso(map);
+	const char *name = dso->long_name;
 	int nr;
 
-	if (dso__loaded(map->dso))
+	if (dso__loaded(dso))
 		return 0;
 
-	nr = dso__load(map->dso, map);
+	nr = dso__load(dso, map);
 	if (nr < 0) {
-		if (map->dso->has_build_id) {
+		if (dso->has_build_id) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-			build_id__sprintf(&map->dso->bid, sbuild_id);
+			build_id__sprintf(&dso->bid, sbuild_id);
 			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
 			pr_debug("Failed to open %s", name);
@@ -371,32 +381,36 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
 	if (map__load(map) < 0)
 		return NULL;
 
-	return dso__find_symbol(map->dso, addr);
+	return dso__find_symbol(map__dso(map), addr);
 }
 
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 {
+	struct dso *dso;
+
 	if (map__load(map) < 0)
 		return NULL;
 
-	if (!dso__sorted_by_name(map->dso))
-		dso__sort_by_name(map->dso);
+	dso = map__dso(map);
+	if (!dso__sorted_by_name(dso))
+		dso__sort_by_name(dso);
 
-	return dso__find_symbol_by_name(map->dso, name);
+	return dso__find_symbol_by_name(dso, name);
 }
 
 struct map *map__clone(struct map *from)
 {
 	size_t size = sizeof(struct map);
 	struct map *map;
+	struct dso *dso = map__dso(from);
 
-	if (from->dso && from->dso->kernel)
+	if (dso && dso->kernel)
 		size += sizeof(struct kmap);
 
 	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
-		dso__get(map->dso);
+		dso__get(dso);
 	}
 
 	return map;
@@ -404,20 +418,23 @@ struct map *map__clone(struct map *from)
 
 size_t map__fprintf(struct map *map, FILE *fp)
 {
+	const struct dso *dso = map__dso(map);
+
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
-		       map->start, map->end, map->pgoff, map->dso->name);
+		       map->start, map->end, map->pgoff, dso->name);
 }
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 {
 	char buf[symbol_conf.pad_output_len_dso + 1];
 	const char *dsoname = "[unknown]";
+	const struct dso *dso = map ? map__dso(map) : NULL;
 
-	if (map && map->dso) {
-		if (symbol_conf.show_kernel_path && map->dso->long_name)
-			dsoname = map->dso->long_name;
+	if (dso) {
+		if (symbol_conf.show_kernel_path && dso->long_name)
+			dsoname = dso->long_name;
 		else
-			dsoname = map->dso->name;
+			dsoname = dso->name;
 	}
 
 	if (symbol_conf.pad_output_len_dso) {
@@ -432,15 +449,17 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
 {
 	if (map == NULL)
 		return SRCLINE_UNKNOWN;
-	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
+
+	return get_srcline(map__dso(map), map__rip_2objdump(map, addr), sym, true, true, addr);
 }
 
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp)
 {
+	const struct dso *dso = map ? map__dso(map) : NULL;
 	int ret = 0;
 
-	if (map && map->dso) {
+	if (dso) {
 		char *srcline = map__srcline(map, addr, NULL);
 		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
@@ -469,6 +488,7 @@ void srccode_state_free(struct srccode_state *state)
 u64 map__rip_2objdump(struct map *map, u64 rip)
 {
 	struct kmap *kmap = __map__kmap(map);
+	const struct dso *dso = map__dso(map);
 
 	/*
 	 * vmlinux does not have program headers for PTI entry trampolines and
@@ -486,18 +506,18 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 		}
 	}
 
-	if (!map->dso->adjust_symbols)
+	if (!dso->adjust_symbols)
 		return rip;
 
-	if (map->dso->rel)
+	if (dso->rel)
 		return rip - map->pgoff;
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
 	 * but all kernel modules are ET_REL, so won't get here.
 	 */
-	if (map->dso->kernel == DSO_SPACE__USER)
-		return rip + map->dso->text_offset;
+	if (dso->kernel == DSO_SPACE__USER)
+		return rip + dso->text_offset;
 
 	return map->unmap_ip(map, rip) - map->reloc;
 }
@@ -516,18 +536,20 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  */
 u64 map__objdump_2mem(struct map *map, u64 ip)
 {
-	if (!map->dso->adjust_symbols)
+	const struct dso *dso = map__dso(map);
+
+	if (!dso->adjust_symbols)
 		return map->unmap_ip(map, ip);
 
-	if (map->dso->rel)
+	if (dso->rel)
 		return map->unmap_ip(map, ip + map->pgoff);
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
 	 * but all kernel modules are ET_REL, so won't get here.
 	 */
-	if (map->dso->kernel == DSO_SPACE__USER)
-		return map->unmap_ip(map, ip - map->dso->text_offset);
+	if (dso->kernel == DSO_SPACE__USER)
+		return map->unmap_ip(map, ip - dso->text_offset);
 
 	return ip + map->reloc;
 }
@@ -541,7 +563,9 @@ bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 
 struct kmap *__map__kmap(struct map *map)
 {
-	if (!map->dso || !map->dso->kernel)
+	const struct dso *dso = map__dso(map);
+
+	if (!dso || !dso->kernel)
 		return NULL;
 	return (struct kmap *)(map + 1);
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index d1a6f85fd31d..36c5add0144d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -47,6 +47,11 @@ u64 map__unmap_ip(const struct map *map, u64 ip);
 /* Returns ip */
 u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
 
+static inline struct dso *map__dso(const struct map *map)
+{
+	return map->dso;
+}
+
 static inline size_t map__size(const struct map *map)
 {
 	return map->end - map->start;
@@ -69,7 +74,7 @@ struct thread;
  * Note: caller must ensure map->dso is not NULL (map is loaded).
  */
 #define map__for_each_symbol(map, pos, n)	\
-	dso__for_each_symbol(map->dso, pos, n)
+	dso__for_each_symbol(map__dso(map), pos, n)
 
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 91bb015caede..09ec6bbafcbc 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -62,6 +62,7 @@ static int __maps__insert(struct maps *maps, struct map *map)
 int maps__insert(struct maps *maps, struct map *map)
 {
 	int err;
+	const struct dso *dso = map__dso(map);
 
 	down_write(maps__lock(maps));
 	err = __maps__insert(maps, map);
@@ -70,7 +71,7 @@ int maps__insert(struct maps *maps, struct map *map)
 
 	++maps->nr_maps;
 
-	if (map->dso && map->dso->kernel) {
+	if (dso && dso->kernel) {
 		struct kmap *kmap = map__kmap(map);
 
 		if (kmap)
@@ -253,7 +254,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 		printed += fprintf(fp, "Map:");
 		printed += map__fprintf(pos->map, fp);
 		if (verbose > 2) {
-			printed += dso__fprintf(pos->map->dso, fp);
+			printed += dso__fprintf(map__dso(pos->map), fp);
 			printed += fprintf(fp, "--\n");
 		}
 	}
@@ -307,7 +308,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 			if (use_browser) {
 				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					   map->dso->name);
+					 map__dso(map)->name);
 			} else {
 				fputs("overlapping maps:\n", fp);
 				map__fprintf(map, fp);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index cdf5d655d84c..b26670a26005 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -165,8 +165,9 @@ static struct map *kernel_get_module_map(const char *module)
 
 	maps__for_each_entry(maps, pos) {
 		/* short_name is "[module]" */
-		const char *short_name = pos->map->dso->short_name;
-		u16 short_name_len =  pos->map->dso->short_name_len;
+		struct dso *dso = map__dso(pos->map);
+		const char *short_name = dso->short_name;
+		u16 short_name_len =  dso->short_name_len;
 
 		if (strncmp(short_name + 1, module,
 			    short_name_len - 2) == 0 &&
@@ -182,13 +183,15 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 	/* Init maps of given executable or kernel */
 	if (user) {
 		struct map *map;
+		struct dso *dso;
 
 		map = dso__new_map(target);
-		if (map && map->dso) {
-			mutex_lock(&map->dso->lock);
-			nsinfo__put(map->dso->nsinfo);
-			map->dso->nsinfo = nsinfo__get(nsi);
-			mutex_unlock(&map->dso->lock);
+		dso = map ? map__dso(map) : NULL;
+		if (dso) {
+			mutex_lock(&dso->lock);
+			nsinfo__put(dso->nsinfo);
+			dso->nsinfo = nsinfo__get(nsi);
+			mutex_unlock(&dso->lock);
 		}
 		return map;
 	} else {
@@ -341,7 +344,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		snprintf(module_name, sizeof(module_name), "[%s]", module);
 		map = maps__find_by_name(machine__kernel_maps(host_machine), module_name);
 		if (map) {
-			dso = map->dso;
+			dso = map__dso(map);
 			goto found;
 		}
 		pr_debug("Failed to find module %s.\n", module);
@@ -349,7 +352,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 	}
 
 	map = machine__kernel_map(host_machine);
-	dso = map->dso;
+	dso = map__dso(map);
 	if (!dso->has_build_id)
 		dso__read_running_kernel_build_id(dso, host_machine);
 
@@ -3737,6 +3740,7 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 {
         struct rb_node *nd;
 	struct map *map;
+	struct dso *dso;
 	int ret;
 
 	ret = init_probe_symbol_maps(user);
@@ -3762,14 +3766,14 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 			       (target) ? : "kernel");
 		goto end;
 	}
-	if (!dso__sorted_by_name(map->dso))
-		dso__sort_by_name(map->dso);
+	dso = map__dso(map);
+	if (!dso__sorted_by_name(dso))
+		dso__sort_by_name(dso);
 
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (nd = rb_first_cached(&map->dso->symbol_names); nd;
-	     nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
 		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 
 		if (strfilter__compare(_filter, pos->sym.name))
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 83fd2fd0ba16..039d0365ad41 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -315,12 +315,14 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 
 		if (node->ms.map) {
 			struct map *map = node->ms.map;
+			struct dso *dso = map ? map__dso(map) : NULL;
 			const char *dsoname = "[unknown]";
-			if (map && map->dso) {
-				if (symbol_conf.show_kernel_path && map->dso->long_name)
-					dsoname = map->dso->long_name;
+
+			if (dso) {
+				if (symbol_conf.show_kernel_path && dso->long_name)
+					dsoname = dso->long_name;
 				else
-					dsoname = map->dso->name;
+					dsoname = dso->name;
 			}
 			if (!hv_stores(elem, "dso", newSVpv(dsoname,0))) {
 				hv_undef(elem);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e5cc18f6fcda..b8e5c6f61d80 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -390,12 +390,13 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
 static const char *get_dsoname(struct map *map)
 {
 	const char *dsoname = "[unknown]";
+	struct dso *dso = map ? map__dso(map) : NULL;
 
-	if (map && map->dso) {
-		if (symbol_conf.show_kernel_path && map->dso->long_name)
-			dsoname = map->dso->long_name;
+	if (dso) {
+		if (symbol_conf.show_kernel_path && dso->long_name)
+			dsoname = dso->long_name;
 		else
-			dsoname = map->dso->name;
+			dsoname = dso->name;
 	}
 
 	return dsoname;
@@ -780,9 +781,10 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 	char sbuild_id[SBUILD_ID_SIZE];
 
 	if (al->map) {
-		pydict_set_item_string_decref(dict, dso_field,
-			_PyUnicode_FromString(al->map->dso->name));
-		build_id__sprintf(&al->map->dso->bid, sbuild_id);
+		struct dso *dso = map__dso(al->map);
+
+		pydict_set_item_string_decref(dict, dso_field, _PyUnicode_FromString(dso->name));
+		build_id__sprintf(&dso->bid, sbuild_id);
 		pydict_set_item_string_decref(dict, dso_bid_field,
 			_PyUnicode_FromString(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_map_start,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e04d9bddba11..d7b6b734bf90 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -184,8 +184,8 @@ struct sort_entry sort_comm = {
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
 {
-	struct dso *dso_l = map_l ? map_l->dso : NULL;
-	struct dso *dso_r = map_r ? map_r->dso : NULL;
+	struct dso *dso_l = map_l ? map__dso(map_l) : NULL;
+	struct dso *dso_r = map_r ? map__dso(map_r) : NULL;
 	const char *dso_name_l, *dso_name_r;
 
 	if (!dso_l || !dso_r)
@@ -211,13 +211,13 @@ sort__dso_cmp(struct hist_entry *left, struct hist_entry *right)
 static int _hist_entry__dso_snprintf(struct map *map, char *bf,
 				     size_t size, unsigned int width)
 {
-	if (map && map->dso) {
-		const char *dso_name = verbose > 0 ? map->dso->long_name :
-			map->dso->short_name;
-		return repsep_snprintf(bf, size, "%-*.*s", width, width, dso_name);
-	}
+	const struct dso *dso = map ? map__dso(map) : NULL;
+	const char *dso_name = "[unknown]";
+
+	if (dso)
+		dso_name = verbose > 0 ? dso->long_name : dso->short_name;
 
-	return repsep_snprintf(bf, size, "%-*.*s", width, width, "[unknown]");
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, dso_name);
 }
 
 static int hist_entry__dso_snprintf(struct hist_entry *he, char *bf,
@@ -233,7 +233,7 @@ static int hist_entry__dso_filter(struct hist_entry *he, int type, const void *a
 	if (type != HIST_FILTER__DSO)
 		return -1;
 
-	return dso && (!he->ms.map || he->ms.map->dso != dso);
+	return dso && (!he->ms.map || map__dso(he->ms.map) != dso);
 }
 
 struct sort_entry sort_dso = {
@@ -313,11 +313,11 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 	size_t ret = 0;
 
 	if (verbose > 0) {
-		char o = map ? dso__symtab_origin(map->dso) : '!';
+		struct dso *dso = map ? map__dso(map) : NULL;
+		char o = dso ? dso__symtab_origin(dso) : '!';
 		u64 rip = ip;
 
-		if (map && map->dso && map->dso->kernel
-		    && map->dso->adjust_symbols)
+		if (dso && dso->kernel && dso->adjust_symbols)
 			rip = map->unmap_ip(map, ip);
 
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
@@ -595,7 +595,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 	if (!map)
 		return no_srcfile;
 
-	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
+	sf = __get_srcline(map__dso(map), map__rip_2objdump(map, e->ip),
 			 e->ms.sym, false, true, true, e->ip);
 	if (!strcmp(sf, SRCLINE_UNKNOWN))
 		return no_srcfile;
@@ -941,7 +941,7 @@ static int hist_entry__dso_from_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return dso && (!he->branch_info || !he->branch_info->from.ms.map ||
-		       he->branch_info->from.ms.map->dso != dso);
+		map__dso(he->branch_info->from.ms.map) != dso);
 }
 
 static int64_t
@@ -973,7 +973,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return dso && (!he->branch_info || !he->branch_info->to.ms.map ||
-		       he->branch_info->to.ms.map->dso != dso);
+		map__dso(he->branch_info->to.ms.map) != dso);
 }
 
 static int64_t
@@ -1465,6 +1465,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	u64 l, r;
 	struct map *l_map, *r_map;
+	struct dso *l_dso, *r_dso;
 	int rc;
 
 	if (!left->mem_info)  return -1;
@@ -1484,7 +1485,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	rc = dso__cmp_id(l_map->dso, r_map->dso);
+	l_dso = map__dso(l_map);
+	r_dso = map__dso(r_map);
+	rc = dso__cmp_id(l_dso, r_dso);
 	if (rc)
 		return rc;
 	/*
@@ -1496,9 +1499,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	 */
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(l_map->flags & MAP_SHARED)) &&
-	    !l_map->dso->id.maj && !l_map->dso->id.min &&
-	    !l_map->dso->id.ino && !l_map->dso->id.ino_generation) {
+	    (!(l_map->flags & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
+	    !l_dso->id.ino && !l_dso->id.ino_generation) {
 		/* userspace anonymous */
 
 		if (left->thread->pid_ > right->thread->pid_) return -1;
@@ -1526,6 +1528,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
 	if (he->mem_info) {
 		struct map *map = he->mem_info->daddr.ms.map;
+		struct dso *dso = map__dso(map);
 
 		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
 		ms = &he->mem_info->daddr.ms;
@@ -1534,8 +1537,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map->prot & PROT_EXEC) &&
 		    (map->flags & MAP_SHARED) &&
-		    (map->dso->id.maj || map->dso->id.min ||
-		     map->dso->id.ino || map->dso->id.ino_generation))
+		    (dso->id.maj || dso->id.min || dso->id.ino || dso->id.ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
@@ -2031,9 +2033,8 @@ sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
 static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
 					  size_t bf_size, unsigned int width)
 {
-	if (map && map->dso)
-		return repsep_snprintf(bf, bf_size, "%*d", width,
-				       map__size(map));
+	if (map && map__dso(map))
+		return repsep_snprintf(bf, bf_size, "%*d", width, map__size(map));
 
 	return repsep_snprintf(bf, bf_size, "%*s", width, "unknown");
 }
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ccdafc3971ac..97085ad7fe9b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1429,7 +1429,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		*curr_mapp = curr_map;
 		*curr_dsop = curr_dso;
 	} else
-		*curr_dsop = curr_map->dso;
+		*curr_dsop = map__dso(curr_map);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index efd047bab373..13176ed5bd27 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -791,6 +791,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
+		struct dso *curr_map_dso;
 		char *module;
 
 		pos = rb_entry(next, struct symbol, rb_node);
@@ -808,13 +809,13 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			symbol__delete(pos);
 			continue;
 		}
-
+		curr_map_dso = map__dso(curr_map);
 		pos->start -= curr_map->start - curr_map->pgoff;
 		if (pos->end > curr_map->end)
 			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
-		symbols__insert(&curr_map->dso->symbols, pos);
+		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
 	}
 
@@ -856,12 +857,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 		module = strchr(pos->name, '\t');
 		if (module) {
+			struct dso *curr_map_dso;
+
 			if (!symbol_conf.use_modules)
 				goto discard_symbol;
 
 			*module++ = '\0';
-
-			if (strcmp(curr_map->dso->short_name, module)) {
+			curr_map_dso = map__dso(curr_map);
+			if (strcmp(curr_map_dso->short_name, module)) {
 				if (curr_map != initial_map &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
@@ -872,7 +875,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					 * symbols are in its kmap. Mark it as
 					 * loaded.
 					 */
-					dso__set_loaded(curr_map->dso);
+					dso__set_loaded(curr_map_dso);
 				}
 
 				curr_map = maps__find_by_name(kmaps, module);
@@ -884,8 +887,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					curr_map = initial_map;
 					goto discard_symbol;
 				}
-
-				if (curr_map->dso->loaded &&
+				curr_map_dso = map__dso(curr_map);
+				if (curr_map_dso->loaded &&
 				    !machine__is_default_guest(machine))
 					goto discard_symbol;
 			}
@@ -954,8 +957,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		}
 add_symbol:
 		if (curr_map != initial_map) {
+			struct dso *curr_map_dso = map__dso(curr_map);
+
 			rb_erase_cached(&pos->rb_node, root);
-			symbols__insert(&curr_map->dso->symbols, pos);
+			symbols__insert(&curr_map_dso->symbols, pos);
 			++moved;
 		} else
 			++count;
@@ -969,7 +974,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (curr_map != initial_map &&
 	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
-		dso__set_loaded(curr_map->dso);
+		dso__set_loaded(map__dso(curr_map));
 	}
 
 	return count + moved;
@@ -1143,13 +1148,14 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 	maps__for_each_entry(kmaps, old_node) {
 		struct map *old_map = old_node->map;
 		struct module_info *mi;
+		struct dso *dso;
 
 		if (!__map__is_kmodule(old_map)) {
 			continue;
 		}
-
+		dso = map__dso(old_map);
 		/* Module must be in memory at the same address */
-		mi = find_module(old_map->dso->short_name, &modules);
+		mi = find_module(dso->short_name, &modules);
 		if (!mi || mi->start != old_map->start) {
 			err = -EINVAL;
 			goto out;
@@ -2045,14 +2051,17 @@ int dso__load(struct dso *dso, struct map *map)
 
 static int map__strcmp(const void *a, const void *b)
 {
-	const struct map *ma = *(const struct map **)a, *mb = *(const struct map **)b;
-	return strcmp(ma->dso->short_name, mb->dso->short_name);
+	const struct dso *dso_a = map__dso(*(const struct map **)a);
+	const struct dso *dso_b = map__dso(*(const struct map **)b);
+
+	return strcmp(dso_a->short_name, dso_b->short_name);
 }
 
 static int map__strcmp_name(const void *name, const void *b)
 {
-	const struct map *map = *(const struct map **)b;
-	return strcmp(name, map->dso->short_name);
+	const struct dso *dso = map__dso(*(const struct map **)b);
+
+	return strcmp(name, dso->short_name);
 }
 
 void __maps__sort_by_name(struct maps *maps)
@@ -2109,10 +2118,13 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 	down_read(maps__lock(maps));
 
-	if (maps->last_search_by_name &&
-	    strcmp(maps->last_search_by_name->dso->short_name, name) == 0) {
-		map = maps->last_search_by_name;
-		goto out_unlock;
+	if (maps->last_search_by_name) {
+		const struct dso *dso = map__dso(maps->last_search_by_name);
+
+		if (strcmp(dso->short_name, name) == 0) {
+			map = maps->last_search_by_name;
+			goto out_unlock;
+		}
 	}
 	/*
 	 * If we have maps->maps_by_name, then the name isn't in the rbtree,
@@ -2125,8 +2137,11 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 	/* Fallback to traversing the rbtree... */
 	maps__for_each_entry(maps, rb_node) {
+		struct dso *dso;
+
 		map = rb_node->map;
-		if (strcmp(map->dso->short_name, name) == 0) {
+		dso = map__dso(map);
+		if (strcmp(dso->short_name, name) == 0) {
 			maps->last_search_by_name = map;
 			goto out_unlock;
 		}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 57b95c1d7e39..fbd1a882b013 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -693,12 +693,14 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 
 	maps__for_each_entry(maps, pos) {
 		struct map *map = pos->map;
+		struct dso *dso;
 
 		if (!__map__is_kmodule(map))
 			continue;
 
+		dso = map__dso(map);
 		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
 			event->mmap2.header.type = PERF_RECORD_MMAP2;
 			event->mmap2.header.size = (sizeof(event->mmap2) -
 						(sizeof(event->mmap2.filename) - size));
@@ -708,12 +710,11 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 			event->mmap2.len   = map->end - map->start;
 			event->mmap2.pid   = machine->pid;
 
-			memcpy(event->mmap2.filename, map->dso->long_name,
-			       map->dso->long_name_len + 1);
+			memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
 
 			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 		} else {
-			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
 			event->mmap.header.size = (sizeof(event->mmap) -
 						(sizeof(event->mmap.filename) - size));
@@ -723,8 +724,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 			event->mmap.len   = map->end - map->start;
 			event->mmap.pid   = machine->pid;
 
-			memcpy(event->mmap.filename, map->dso->long_name,
-			       map->dso->long_name_len + 1);
+			memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
 		}
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 292585a52281..42fdc80a6f2e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -448,23 +448,22 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit)
 {
-       u8 cpumode = PERF_RECORD_MISC_USER;
-       struct addr_location al;
-       long offset;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	struct addr_location al;
+	long offset;
 
-       if (machine__kernel_ip(machine, ip))
-               cpumode = PERF_RECORD_MISC_KERNEL;
+	if (machine__kernel_ip(machine, ip))
+		cpumode = PERF_RECORD_MISC_KERNEL;
 
-       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
-	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
-	   map__load(al.map) < 0)
-               return -1;
+	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map) ||
+		map__dso(al.map)->data.status == DSO_DATA_STATUS_ERROR || map__load(al.map) < 0)
+		return -1;
 
-       offset = al.map->map_ip(al.map, ip);
-       if (is64bit)
-               *is64bit = al.map->dso->is_64_bit;
+	offset = al.map->map_ip(al.map, ip);
+	if (is64bit)
+		*is64bit = map__dso(al.map)->is_64_bit;
 
-       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
+	return dso__data_read_offset(map__dso(al.map), machine, offset, buf, len);
 }
 
 void thread__free_stitch_list(struct thread *thread)
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 94aa40f6e348..c8cba9d4bfd9 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -52,7 +52,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
 
 	if (al->map)
-		dso = al->map->dso;
+		dso = map__dso(al->map);
 
 	if (!dso)
 		return 0;
@@ -134,17 +134,17 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 {
 	struct addr_location al;
 	ssize_t size;
+	struct dso *dso;
 
 	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		return -1;
 	}
-
-	if (!al.map->dso)
+	dso = map__dso(al.map);
+	if (!dso)
 		return -1;
 
-	size = dso__data_read_addr(al.map->dso, al.map, ui->machine,
-				   addr, (u8 *) data, sizeof(*data));
+	size = dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 *) data, sizeof(*data));
 
 	return !(size == sizeof(*data));
 }
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 835c39efb80d..ec777ee11493 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -147,7 +147,7 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 	struct map_rb_node *rb_node;
 
 	maps__for_each_entry(thread->maps, rb_node) {
-		struct dso *dso = rb_node->map->dso;
+		struct dso *dso = map__dso(rb_node->map);
 
 		if (!dso || dso->long_name[0] != '/')
 			continue;
-- 
2.40.0.rc1.284.g88254d51c5-goog

