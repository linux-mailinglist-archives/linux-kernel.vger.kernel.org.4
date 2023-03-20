Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150D6C2390
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCTVXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCTVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:23:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F538036
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so14350575ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347398;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwfJHR3uDeVFPoUwsnTQRvdix/5zBLz6Y91JeFwQQFU=;
        b=DTesJb6co4v+Onwn+ESWXt32fvvJwVx+xUKTOHNVG3OqyqACcokI6XcSXYR4/Xmul2
         GtyEEJUnK1H12dwyrzOEl2pGP2wE7voxJ2GhOAYkxmQdk1DikSIV2oM/0vdDHdQXHLPQ
         aF/8fSaSI0yd7E+Xkos4lRUHjWqUFnnGLlsiYQ7E3P249m2DeXRj+goPxTkQK5SI9Nm/
         Swyl6G1YP222hINlKXdmp4LBvfFWJfRGXeA1I2t9cig1hs7d/G3IC+iW+1tVWBVsQjAK
         uKxpND8wSJDRW2eaG1HyUju6Vl5R177FEy5Venm+fGN1tgUSgdwZu2vs2dFADSoJK5pJ
         WpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347398;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwfJHR3uDeVFPoUwsnTQRvdix/5zBLz6Y91JeFwQQFU=;
        b=TzwLmDePuKpVc//4hrB0dsjEWN2hUFL5RGmCW9GegOv0zGufFVxrGOm2vT6/GXguIA
         0l//mwtGpzVhHE78HZEIy8/Z/pGH+cgLTAR6kGJJ7uOesggHp45rMEJKbA+y23/eDKYd
         OmB1xBKt2bUxCoiilqO2syAwF69U1xXIMTO/grwhU8XKS+0geQti6QxN4O5T6euCXOLg
         hiPKNVnp0zRYOTSL0kEMFd/VvZ0SZVm/iP4fNEhm1f/X3l1i64sBSAFmCYdR6UldfzUK
         wWze3WAzHtBjscTrfX/pU2DBW74bMXnRvQCo8ONqVfTMON7Wz4DjyI7W9c2UNERaWeLg
         WS6g==
X-Gm-Message-State: AAQBX9eqF0zl9HGqcSP6w7uNEPsJFqq5ikY5pOJLSbPgJr1h256/QTSp
        +nUdRzMFgclL4WqbCeZkLIWyFtqpcTLm
X-Google-Smtp-Source: AKy350bBf9o0wCHgoGW3qE82LYrMMACmPs658gYzT2A7fqiGwAm+qQdCre3/yIK6dqzwL1UVqji7FtbC2vlE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b3c:637f:ad00 with SMTP
 id w3-20020a056902100300b00b3c637fad00mr6160ybt.5.1679347398084; Mon, 20 Mar
 2023 14:23:18 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:33 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-3-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 02/17] perf maps: Remove rb_node from struct map
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

struct map is reference counted, having it also be a node in an
red-black tree complicates the reference counting. Switch to having a
map_rb_node which is a red-block tree node but points at the reference
counted struct map. This reference is responsible for a single reference
count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/event.c      |  13 +-
 tools/perf/builtin-report.c           |   6 +-
 tools/perf/tests/maps.c               |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c   |  17 ++-
 tools/perf/util/bpf_lock_contention.c |   2 +-
 tools/perf/util/machine.c             |  68 ++++++----
 tools/perf/util/map.c                 |  16 ---
 tools/perf/util/map.h                 |   1 -
 tools/perf/util/maps.c                | 180 +++++++++++++++++---------
 tools/perf/util/maps.h                |  17 ++-
 tools/perf/util/probe-event.c         |  18 ++-
 tools/perf/util/symbol-elf.c          |   9 +-
 tools/perf/util/symbol.c              |  77 +++++++----
 tools/perf/util/synthetic-events.c    |  26 ++--
 tools/perf/util/thread.c              |  10 +-
 tools/perf/util/vdso.c                |   7 +-
 16 files changed, 291 insertions(+), 184 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index e4288d09f3a0..17bf60babfbd 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -19,7 +19,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 				       struct machine *machine)
 {
 	int rc = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 	struct maps *kmaps = machine__kernel_maps(machine);
 	union perf_event *event = zalloc(sizeof(event->mmap) +
 					 machine->id_hdr_size);
@@ -33,11 +33,12 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 	maps__for_each_entry(kmaps, pos) {
 		struct kmap *kmap;
 		size_t size;
+		struct map *map = pos->map;
 
-		if (!__map__is_extra_kernel_map(pos))
+		if (!__map__is_extra_kernel_map(map))
 			continue;
 
-		kmap = map__kmap(pos);
+		kmap = map__kmap(map);
 
 		size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
 		       PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
@@ -58,9 +59,9 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 
 		event->mmap.header.size = size;
 
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pgoff = pos->pgoff;
+		event->mmap.start = map->start;
+		event->mmap.len   = map->end - map->start;
+		event->mmap.pgoff = map->pgoff;
 		event->mmap.pid   = machine->pid;
 
 		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6400615b5e98..c453b7fa7418 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -840,9 +840,11 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 {
 	size_t printed = 0;
-	struct map *map;
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
 
-	maps__for_each_entry(maps, map) {
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
 				   indent, "", map->start, map->end,
 				   map->prot & PROT_READ ? 'r' : '-',
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index a69988a89d26..8246d37e4b7a 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -15,10 +15,12 @@ struct map_def {
 
 static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
 {
-	struct map *map;
+	struct map_rb_node *rb_node;
 	unsigned int i = 0;
 
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
+
 		if (i > 0)
 			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 
@@ -74,7 +76,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 
 		map->start = bpf_progs[i].start;
 		map->end   = bpf_progs[i].end;
-		maps__insert(maps, map);
+		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
 		map__put(map);
 	}
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 8ab035b55875..c8abb3ca8347 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -118,7 +118,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	int err = TEST_FAIL;
 	struct rb_node *nd;
 	struct symbol *sym;
-	struct map *kallsyms_map, *vmlinux_map, *map;
+	struct map *kallsyms_map, *vmlinux_map;
+	struct map_rb_node *rb_node;
 	struct machine kallsyms, vmlinux;
 	struct maps *maps;
 	u64 mem_start, mem_end;
@@ -290,15 +291,15 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	header_printed = false;
 
-	maps__for_each_entry(maps, map) {
-		struct map *
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
 		/*
 		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
 		 * the kernel will have the path for the vmlinux file being used,
 		 * so use the short name, less descriptive but the same ("[kernel]" in
 		 * both cases.
 		 */
-		pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
+		struct map *pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
 								map->dso->short_name :
 								map->dso->name));
 		if (pair) {
@@ -314,8 +315,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	header_printed = false;
 
-	maps__for_each_entry(maps, map) {
-		struct map *pair;
+	maps__for_each_entry(maps, rb_node) {
+		struct map *pair, *map = rb_node->map;
 
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
@@ -344,7 +345,9 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	maps = machine__kernel_maps(&kallsyms);
 
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
+
 		if (!map->priv) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 235fc7150545..0b47863d2460 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -282,7 +282,7 @@ int lock_contention_read(struct lock_contention *con)
 	}
 
 	/* make sure it loads the kernel map */
-	map__load(maps__first(machine->kmaps));
+	map__load(maps__first(machine->kmaps)->map);
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 803c9d1803dd..93a07079d174 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -882,6 +882,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 	if (!map) {
 		struct dso *dso = dso__new(event->ksymbol.name);
+		int err;
 
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
@@ -901,8 +902,11 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
-		maps__insert(machine__kernel_maps(machine), map);
+		err = maps__insert(machine__kernel_maps(machine), map);
 		map__put(map);
+		if (err)
+			return err;
+
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
@@ -1002,6 +1006,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	struct map *map = NULL;
 	struct kmod_path m;
 	struct dso *dso;
+	int err;
 
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
@@ -1014,10 +1019,14 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (map == NULL)
 		goto out;
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 
 	/* Put the map here because maps__insert already got it */
 	map__put(map);
+
+	/* If maps__insert failed, return NULL. */
+	if (err)
+		map = NULL;
 out:
 	/* put the dso here, corresponding to  machine__findnew_module_dso */
 	dso__put(dso);
@@ -1184,10 +1193,11 @@ int machine__create_extra_kernel_map(struct machine *machine,
 {
 	struct kmap *kmap;
 	struct map *map;
+	int err;
 
 	map = map__new2(xm->start, kernel);
 	if (!map)
-		return -1;
+		return -ENOMEM;
 
 	map->end   = xm->end;
 	map->pgoff = xm->pgoff;
@@ -1196,14 +1206,16 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 
-	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
-		  kmap->name, map->start, map->end);
+	if (!err) {
+		pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
+			kmap->name, map->start, map->end);
+	}
 
 	map__put(map);
 
-	return 0;
+	return err;
 }
 
 static u64 find_entry_trampoline(struct dso *dso)
@@ -1244,16 +1256,16 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 	struct maps *kmaps = machine__kernel_maps(machine);
 	int nr_cpus_avail, cpu;
 	bool found = false;
-	struct map *map;
+	struct map_rb_node *rb_node;
 	u64 pgoff;
 
 	/*
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	maps__for_each_entry(kmaps, map) {
+	maps__for_each_entry(kmaps, rb_node) {
+		struct map *dest_map, *map = rb_node->map;
 		struct kmap *kmap = __map__kmap(map);
-		struct map *dest_map;
 
 		if (!kmap || !is_entry_trampoline(kmap->name))
 			continue;
@@ -1308,11 +1320,10 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 
 	machine->vmlinux_map = map__new2(0, kernel);
 	if (machine->vmlinux_map == NULL)
-		return -1;
+		return -ENOMEM;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
-	return 0;
+	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
 }
 
 void machine__destroy_kernel_maps(struct machine *machine)
@@ -1634,25 +1645,26 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		machine->vmlinux_map->end = ~0ULL;
 }
 
-static void machine__update_kernel_mmap(struct machine *machine,
+static int machine__update_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
 	struct map *map = machine__kernel_map(machine);
+	int err;
 
 	map__get(map);
 	maps__remove(machine__kernel_maps(machine), map);
 
 	machine__set_kernel_mmap(machine, start, end);
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 	map__put(map);
+	return err;
 }
 
 int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
-	struct map *map;
 	u64 start = 0, end = ~0ULL;
 	int ret;
 
@@ -1684,7 +1696,9 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, start, end);
+		ret = machine__update_kernel_mmap(machine, start, end);
+		if (ret < 0)
+			goto out_put;
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
@@ -1692,9 +1706,12 @@ int machine__create_kernel_maps(struct machine *machine)
 
 	if (end == ~0ULL) {
 		/* update end address of the kernel map using adjacent module address */
-		map = map__next(machine__kernel_map(machine));
-		if (map)
-			machine__set_kernel_mmap(machine, start, map->start);
+		struct map_rb_node *rb_node = maps__find_node(machine__kernel_maps(machine),
+							machine__kernel_map(machine));
+		struct map_rb_node *next = map_rb_node__next(rb_node);
+
+		if (next)
+			machine__set_kernel_mmap(machine, start, next->map->start);
 	}
 
 out_put:
@@ -1827,7 +1844,10 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__update_kernel_mmap(machine, xm->start, xm->end);
+		if (machine__update_kernel_mmap(machine, xm->start, xm->end) < 0) {
+			dso__put(kernel);
+			goto out_problem;
+		}
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(kernel, bid);
@@ -3325,11 +3345,11 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
 {
 	struct maps *maps = machine__kernel_maps(machine);
-	struct map *map;
+	struct map_rb_node *pos;
 	int err = 0;
 
-	for (map = maps__first(maps); map != NULL; map = map__next(map)) {
-		err = fn(map, priv);
+	maps__for_each_entry(maps, pos) {
+		err = fn(pos->map, priv);
 		if (err != 0) {
 			break;
 		}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f3a3d9b3a40d..7620cfa114d4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -111,7 +111,6 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->dso      = dso__get(dso);
 	map->map_ip   = map__map_ip;
 	map->unmap_ip = map__unmap_ip;
-	RB_CLEAR_NODE(&map->rb_node);
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -397,7 +396,6 @@ struct map *map__clone(struct map *from)
 	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
-		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
 	}
 
@@ -537,20 +535,6 @@ bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 	return ip >= map->start && ip < map->end;
 }
 
-static struct map *__map__next(struct map *map)
-{
-	struct rb_node *next = rb_next(&map->rb_node);
-
-	if (next)
-		return rb_entry(next, struct map, rb_node);
-	return NULL;
-}
-
-struct map *map__next(struct map *map)
-{
-	return map ? __map__next(map) : NULL;
-}
-
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 2879cae05ee0..d1a6f85fd31d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,7 +16,6 @@ struct maps;
 struct machine;
 
 struct map {
-	struct rb_node		rb_node;
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 37bd5b40000d..83ec126bcbe5 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,8 +10,6 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
-static void __maps__insert(struct maps *maps, struct map *map);
-
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	maps->entries = RB_ROOT;
@@ -32,10 +30,44 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	maps->nr_maps_allocated = 0;
 }
 
-void maps__insert(struct maps *maps, struct map *map)
+static int __maps__insert(struct maps *maps, struct map *map)
 {
+	struct rb_node **p = &maps->entries.rb_node;
+	struct rb_node *parent = NULL;
+	const u64 ip = map->start;
+	struct map_rb_node *m, *new_rb_node;
+
+	new_rb_node = malloc(sizeof(*new_rb_node));
+	if (!new_rb_node)
+		return -ENOMEM;
+
+	RB_CLEAR_NODE(&new_rb_node->rb_node);
+	new_rb_node->map = map;
+
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map_rb_node, rb_node);
+		if (ip < m->map->start)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&new_rb_node->rb_node, parent, p);
+	rb_insert_color(&new_rb_node->rb_node, &maps->entries);
+	map__get(map);
+	return 0;
+}
+
+int maps__insert(struct maps *maps, struct map *map)
+{
+	int err;
+
 	down_write(&maps->lock);
-	__maps__insert(maps, map);
+	err = __maps__insert(maps, map);
+	if (err)
+		goto out;
+
 	++maps->nr_maps;
 
 	if (map->dso && map->dso->kernel) {
@@ -59,32 +91,39 @@ void maps__insert(struct maps *maps, struct map *map)
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
-				up_write(&maps->lock);
-				return;
+				err = -ENOMEM;
+				goto out;
 			}
 
 			maps->maps_by_name = maps_by_name;
 			maps->nr_maps_allocated = nr_allocate;
-		}
+}
 		maps->maps_by_name[maps->nr_maps - 1] = map;
 		__maps__sort_by_name(maps);
 	}
+ out:
 	up_write(&maps->lock);
+	return err;
 }
 
-static void __maps__remove(struct maps *maps, struct map *map)
+static void __maps__remove(struct maps *maps, struct map_rb_node *rb_node)
 {
-	rb_erase_init(&map->rb_node, &maps->entries);
-	map__put(map);
+	rb_erase_init(&rb_node->rb_node, &maps->entries);
+	map__put(rb_node->map);
+	free(rb_node);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
 {
+	struct map_rb_node *rb_node;
+
 	down_write(&maps->lock);
 	if (maps->last_search_by_name == map)
 		maps->last_search_by_name = NULL;
 
-	__maps__remove(maps, map);
+	rb_node = maps__find_node(maps, map);
+	assert(rb_node->map == map);
+	__maps__remove(maps, rb_node);
 	--maps->nr_maps;
 	if (maps->maps_by_name)
 		__maps__free_maps_by_name(maps);
@@ -93,11 +132,12 @@ void maps__remove(struct maps *maps, struct map *map)
 
 static void __maps__purge(struct maps *maps)
 {
-	struct map *pos, *next;
+	struct map_rb_node *pos, *next;
 
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
-		map__put(pos);
+		map__put(pos->map);
+		free(pos);
 	}
 }
 
@@ -153,21 +193,21 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
 {
 	struct symbol *sym;
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	down_read(&maps->lock);
 
 	maps__for_each_entry(maps, pos) {
-		sym = map__find_symbol_by_name(pos, name);
+		sym = map__find_symbol_by_name(pos->map, name);
 
 		if (sym == NULL)
 			continue;
-		if (!map__contains_symbol(pos, sym)) {
+		if (!map__contains_symbol(pos->map, sym)) {
 			sym = NULL;
 			continue;
 		}
 		if (mapp != NULL)
-			*mapp = pos;
+			*mapp = pos->map;
 		goto out;
 	}
 
@@ -196,15 +236,15 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 size_t maps__fprintf(struct maps *maps, FILE *fp)
 {
 	size_t printed = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	down_read(&maps->lock);
 
 	maps__for_each_entry(maps, pos) {
 		printed += fprintf(fp, "Map:");
-		printed += map__fprintf(pos, fp);
+		printed += map__fprintf(pos->map, fp);
 		if (verbose > 2) {
-			printed += dso__fprintf(pos->dso, fp);
+			printed += dso__fprintf(pos->map->dso, fp);
 			printed += fprintf(fp, "--\n");
 		}
 	}
@@ -231,11 +271,11 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 	next = root->rb_node;
 	first = NULL;
 	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
+		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 
-		if (pos->end > map->start) {
+		if (pos->map->end > map->start) {
 			first = next;
-			if (pos->start <= map->start)
+			if (pos->map->start <= map->start)
 				break;
 			next = next->rb_left;
 		} else
@@ -244,14 +284,14 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 	next = first;
 	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
+		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
 
 		/*
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (pos->start >= map->end)
+		if (pos->map->start >= map->end)
 			break;
 
 		if (verbose >= 2) {
@@ -262,7 +302,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			} else {
 				fputs("overlapping maps:\n", fp);
 				map__fprintf(map, fp);
-				map__fprintf(pos, fp);
+				map__fprintf(pos->map, fp);
 			}
 		}
 
@@ -271,8 +311,8 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map->start > pos->start) {
-			struct map *before = map__clone(pos);
+		if (map->start > pos->map->start) {
+			struct map *before = map__clone(pos->map);
 
 			if (before == NULL) {
 				err = -ENOMEM;
@@ -280,14 +320,17 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			before->end = map->start;
-			__maps__insert(maps, before);
+			err = __maps__insert(maps, before);
+			if (err)
+				goto put_map;
+
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
 		}
 
-		if (map->end < pos->end) {
-			struct map *after = map__clone(pos);
+		if (map->end < pos->map->end) {
+			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
 				err = -ENOMEM;
@@ -295,15 +338,19 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			after->start = map->end;
-			after->pgoff += map->end - pos->start;
-			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__maps__insert(maps, after);
+			after->pgoff += map->end - pos->map->start;
+			assert(pos->map->map_ip(pos->map, map->end) ==
+				after->map_ip(after, map->end));
+			err = __maps__insert(maps, after);
+			if (err)
+				goto put_map;
+
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
 		}
 put_map:
-		map__put(pos);
+		map__put(pos->map);
 
 		if (err)
 			goto out;
@@ -322,12 +369,12 @@ int maps__clone(struct thread *thread, struct maps *parent)
 {
 	struct maps *maps = thread->maps;
 	int err;
-	struct map *map;
+	struct map_rb_node *rb_node;
 
 	down_read(&parent->lock);
 
-	maps__for_each_entry(parent, map) {
-		struct map *new = map__clone(map);
+	maps__for_each_entry(parent, rb_node) {
+		struct map *new = map__clone(rb_node->map);
 
 		if (new == NULL) {
 			err = -ENOMEM;
@@ -338,7 +385,10 @@ int maps__clone(struct thread *thread, struct maps *parent)
 		if (err)
 			goto out_unlock;
 
-		maps__insert(maps, new);
+		err = maps__insert(maps, new);
+		if (err)
+			goto out_unlock;
+
 		map__put(new);
 	}
 
@@ -348,40 +398,31 @@ int maps__clone(struct thread *thread, struct maps *parent)
 	return err;
 }
 
-static void __maps__insert(struct maps *maps, struct map *map)
+struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
 {
-	struct rb_node **p = &maps->entries.rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = map->start;
-	struct map *m;
+	struct map_rb_node *rb_node;
 
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node);
-		if (ip < m->start)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	maps__for_each_entry(maps, rb_node) {
+		if (rb_node->map == map)
+			return rb_node;
 	}
-
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color(&map->rb_node, &maps->entries);
-	map__get(map);
+	return NULL;
 }
 
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
-	struct map *m;
+	struct map_rb_node *m;
+
 
 	down_read(&maps->lock);
 
 	p = maps->entries.rb_node;
 	while (p != NULL) {
-		m = rb_entry(p, struct map, rb_node);
-		if (ip < m->start)
+		m = rb_entry(p, struct map_rb_node, rb_node);
+		if (ip < m->map->start)
 			p = p->rb_left;
-		else if (ip >= m->end)
+		else if (ip >= m->map->end)
 			p = p->rb_right;
 		else
 			goto out;
@@ -390,14 +431,29 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	m = NULL;
 out:
 	up_read(&maps->lock);
-	return m;
+	return m ? m->map : NULL;
 }
 
-struct map *maps__first(struct maps *maps)
+struct map_rb_node *maps__first(struct maps *maps)
 {
 	struct rb_node *first = rb_first(&maps->entries);
 
 	if (first)
-		return rb_entry(first, struct map, rb_node);
+		return rb_entry(first, struct map_rb_node, rb_node);
 	return NULL;
 }
+
+struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
+{
+	struct rb_node *next;
+
+	if (!node)
+		return NULL;
+
+	next = rb_next(&node->rb_node);
+
+	if (!next)
+		return NULL;
+
+	return rb_entry(next, struct map_rb_node, rb_node);
+}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 7e729ff42749..512746ec0f9a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -15,15 +15,22 @@ struct map;
 struct maps;
 struct thread;
 
+struct map_rb_node {
+	struct rb_node rb_node;
+	struct map *map;
+};
+
+struct map_rb_node *maps__first(struct maps *maps);
+struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
+struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
-struct map *maps__first(struct maps *maps);
-struct map *map__next(struct map *map);
 
 #define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map__next(map))
+	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
 #define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
+	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
+	     map = next, next = map_rb_node__next(map))
 
 struct maps {
 	struct rb_root      entries;
@@ -63,7 +70,7 @@ void maps__put(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
-void maps__insert(struct maps *maps, struct map *map);
+int maps__insert(struct maps *maps, struct map *map);
 
 void maps__remove(struct maps *maps, struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 881d94f65a6b..cdf5d655d84c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -151,23 +151,27 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 static struct map *kernel_get_module_map(const char *module)
 {
 	struct maps *maps = machine__kernel_maps(host_machine);
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	/* A file path -- this is an offline module */
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
 	if (!module) {
-		pos = machine__kernel_map(host_machine);
-		return map__get(pos);
+		struct map *map = machine__kernel_map(host_machine);
+
+		return map__get(map);
 	}
 
 	maps__for_each_entry(maps, pos) {
 		/* short_name is "[module]" */
-		if (strncmp(pos->dso->short_name + 1, module,
-			    pos->dso->short_name_len - 2) == 0 &&
-		    module[pos->dso->short_name_len - 2] == '\0') {
-			return map__get(pos);
+		const char *short_name = pos->map->dso->short_name;
+		u16 short_name_len =  pos->map->dso->short_name_len;
+
+		if (strncmp(short_name + 1, module,
+			    short_name_len - 2) == 0 &&
+		    module[short_name_len - 2] == '\0') {
+			return map__get(pos->map);
 		}
 	}
 	return NULL;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c0a2de42c51b..325fbeea8dff 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1355,10 +1355,14 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map->unmap_ip = map__unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
+				int err;
+
 				map__get(map);
 				maps__remove(kmaps, map);
-				maps__insert(kmaps, map);
+				err = maps__insert(kmaps, map);
 				map__put(map);
+				if (err)
+					return err;
 			}
 		}
 
@@ -1411,7 +1415,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
-		maps__insert(kmaps, curr_map);
+		if (maps__insert(kmaps, curr_map))
+			return -1;
 		/*
 		 * Add it before we drop the reference to curr_map, i.e. while
 		 * we still are sure to have a reference to this DSO via
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 65e0c3d126f1..d9aa41e20d5f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -273,13 +273,13 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 
 void maps__fixup_end(struct maps *maps)
 {
-	struct map *prev = NULL, *curr;
+	struct map_rb_node *prev = NULL, *curr;
 
 	down_write(&maps->lock);
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !prev->end)
-			prev->end = curr->start;
+		if (prev != NULL && !prev->map->end)
+			prev->map->end = curr->map->start;
 
 		prev = curr;
 	}
@@ -288,8 +288,8 @@ void maps__fixup_end(struct maps *maps)
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (curr && !curr->end)
-		curr->end = ~0ULL;
+	if (curr && !curr->map->end)
+		curr->map->end = ~0ULL;
 
 	up_write(&maps->lock);
 }
@@ -942,7 +942,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			}
 
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
-			maps__insert(kmaps, curr_map);
+			if (maps__insert(kmaps, curr_map)) {
+				dso__put(ndso);
+				return -1;
+			}
 			++kernel_range;
 		} else if (delta) {
 			/* Kernel was relocated at boot time */
@@ -1130,14 +1133,15 @@ int compare_proc_modules(const char *from, const char *to)
 static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
-	struct map *old_map;
+	struct map_rb_node *old_node;
 	int err;
 
 	err = read_proc_modules(filename, &modules);
 	if (err)
 		return err;
 
-	maps__for_each_entry(kmaps, old_map) {
+	maps__for_each_entry(kmaps, old_node) {
+		struct map *old_map = old_node->map;
 		struct module_info *mi;
 
 		if (!__map__is_kmodule(old_map)) {
@@ -1254,10 +1258,13 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
  */
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
-	struct map *old_map;
+	struct map_rb_node *rb_node;
 	LIST_HEAD(merged);
+	int err = 0;
+
+	maps__for_each_entry(kmaps, rb_node) {
+		struct map *old_map = rb_node->map;
 
-	maps__for_each_entry(kmaps, old_map) {
 		/* no overload with this one */
 		if (new_map->end < old_map->start ||
 		    new_map->start >= old_map->end)
@@ -1281,13 +1288,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 */
 				struct map_list_node *m = map_list_node__new();
 
-				if (!m)
-					return -ENOMEM;
+				if (!m) {
+					err = -ENOMEM;
+					goto out;
+				}
 
 				m->map = map__clone(new_map);
 				if (!m->map) {
 					free(m);
-					return -ENOMEM;
+					err = -ENOMEM;
+					goto out;
 				}
 
 				m->map->end = old_map->start;
@@ -1319,21 +1329,24 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 		}
 	}
 
+out:
 	while (!list_empty(&merged)) {
 		struct map_list_node *old_node;
 
 		old_node = list_entry(merged.next, struct map_list_node, node);
 		list_del_init(&old_node->node);
-		maps__insert(kmaps, old_node->map);
+		if (!err)
+			err = maps__insert(kmaps, old_node->map);
 		map__put(old_node->map);
 		free(old_node);
 	}
 
 	if (new_map) {
-		maps__insert(kmaps, new_map);
+		if (!err)
+			err = maps__insert(kmaps, new_map);
 		map__put(new_map);
 	}
-	return 0;
+	return err;
 }
 
 static int dso__load_kcore(struct dso *dso, struct map *map,
@@ -1341,7 +1354,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *replacement_map = NULL, *next;
+	struct map *replacement_map = NULL;
+	struct map_rb_node *old_node, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1388,7 +1402,9 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__for_each_entry_safe(kmaps, old_map, next) {
+	maps__for_each_entry_safe(kmaps, old_node, next) {
+		struct map *old_map = old_node->map;
+
 		/*
 		 * We need to preserve eBPF maps even if they are
 		 * covered by kcore, because we need to access
@@ -1441,17 +1457,21 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			maps__remove(kmaps, map);
-			maps__insert(kmaps, map);
+			err = maps__insert(kmaps, map);
 			map__put(map);
 			map__put(new_node->map);
+			if (err)
+				goto out_err;
 		} else {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
 			 * stay intact.
 			 */
-			if (maps__merge_in(kmaps, new_node->map))
+			if (maps__merge_in(kmaps, new_node->map)) {
+				err = -EINVAL;
 				goto out_err;
+			}
 		}
 		free(new_node);
 	}
@@ -1498,7 +1518,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(list_node);
 	}
 	close(fd);
-	return -EINVAL;
+	return err;
 }
 
 /*
@@ -2042,8 +2062,9 @@ void __maps__sort_by_name(struct maps *maps)
 
 static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 {
-	struct map *map;
-	struct map **maps_by_name = realloc(maps->maps_by_name, maps->nr_maps * sizeof(map));
+	struct map_rb_node *rb_node;
+	struct map **maps_by_name = realloc(maps->maps_by_name,
+					    maps->nr_maps * sizeof(struct map *));
 	int i = 0;
 
 	if (maps_by_name == NULL)
@@ -2055,8 +2076,8 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	maps->maps_by_name = maps_by_name;
 	maps->nr_maps_allocated = maps->nr_maps;
 
-	maps__for_each_entry(maps, map)
-		maps_by_name[i++] = map;
+	maps__for_each_entry(maps, rb_node)
+		maps_by_name[i++] = rb_node->map;
 
 	__maps__sort_by_name(maps);
 
@@ -2082,6 +2103,7 @@ static struct map *__maps__find_by_name(struct maps *maps, const char *name)
 
 struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
+	struct map_rb_node *rb_node;
 	struct map *map;
 
 	down_read(&maps->lock);
@@ -2100,12 +2122,13 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		goto out_unlock;
 
 	/* Fallback to traversing the rbtree... */
-	maps__for_each_entry(maps, map)
+	maps__for_each_entry(maps, rb_node) {
+		map = rb_node->map;
 		if (strcmp(map->dso->short_name, name) == 0) {
 			maps->last_search_by_name = map;
 			goto out_unlock;
 		}
-
+	}
 	map = NULL;
 
 out_unlock:
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6def01036eb5..57b95c1d7e39 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -669,7 +669,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 				   struct machine *machine)
 {
 	int rc = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 	struct maps *maps = machine__kernel_maps(machine);
 	union perf_event *event;
 	size_t size = symbol_conf.buildid_mmap2 ?
@@ -692,37 +692,39 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
 	maps__for_each_entry(maps, pos) {
-		if (!__map__is_kmodule(pos))
+		struct map *map = pos->map;
+
+		if (!__map__is_kmodule(map))
 			continue;
 
 		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
 			event->mmap2.header.type = PERF_RECORD_MMAP2;
 			event->mmap2.header.size = (sizeof(event->mmap2) -
 						(sizeof(event->mmap2.filename) - size));
 			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
 			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = pos->start;
-			event->mmap2.len   = pos->end - pos->start;
+			event->mmap2.start = map->start;
+			event->mmap2.len   = map->end - map->start;
 			event->mmap2.pid   = machine->pid;
 
-			memcpy(event->mmap2.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
+			memcpy(event->mmap2.filename, map->dso->long_name,
+			       map->dso->long_name_len + 1);
 
 			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 		} else {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
 			event->mmap.header.size = (sizeof(event->mmap) -
 						(sizeof(event->mmap.filename) - size));
 			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
 			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = pos->start;
-			event->mmap.len   = pos->end - pos->start;
+			event->mmap.start = map->start;
+			event->mmap.len   = map->end - map->start;
 			event->mmap.pid   = machine->pid;
 
-			memcpy(event->mmap.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
+			memcpy(event->mmap.filename, map->dso->long_name,
+			       map->dso->long_name_len + 1);
 		}
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index a2490a20eb56..24e53bd55f7d 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -352,9 +352,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
 		return ret;
 
 	maps__fixup_overlappings(thread->maps, map, stderr);
-	maps__insert(thread->maps, map);
-
-	return 0;
+	return maps__insert(thread->maps, map);
 }
 
 static int __thread__prepare_access(struct thread *thread)
@@ -362,12 +360,12 @@ static int __thread__prepare_access(struct thread *thread)
 	bool initialized = false;
 	int err = 0;
 	struct maps *maps = thread->maps;
-	struct map *map;
+	struct map_rb_node *rb_node;
 
 	down_read(&maps->lock);
 
-	maps__for_each_entry(maps, map) {
-		err = unwind__prepare_access(thread->maps, map, &initialized);
+	maps__for_each_entry(maps, rb_node) {
+		err = unwind__prepare_access(thread->maps, rb_node->map, &initialized);
 		if (err || initialized)
 			break;
 	}
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 43beb169631d..835c39efb80d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -144,10 +144,11 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map;
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(thread->maps, rb_node) {
+		struct dso *dso = rb_node->map->dso;
 
-	maps__for_each_entry(thread->maps, map) {
-		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
 		dso_type = dso__type(dso, machine);
-- 
2.40.0.rc1.284.g88254d51c5-goog

