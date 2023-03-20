Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736B6C23A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCTV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCTV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:26:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A5C30B2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:25:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544570e6d82so136862397b3.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347510;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA2P3cCw0w5TexeIUCzMnIczpz6RbPZ7j4N3nKY8zz8=;
        b=WZfpYLDd0QCgZQKekHT2Bh2DsXKfl1+RNPHWTodXaRgIqij5DVCt77co89dce06a/p
         FEBb1OcSVgqaS0XsVzjYGfQdG2qsSqhQE0YqQ/h0NVWH8QJRRt7e7LMqJWcg8cw3nmpE
         haloQhO+miEC1+yzSvXp7+psRyICUw/7eU3P4FV6x0827P8xXNBFabIquiqnO4NZfqXD
         Vya/bteK1ueUinukEWcDaGFojvkN/BQqlGRkWRYCv0jkz1vqFVzk1SmxYWvpdDqNiSs3
         rDCZ8kGGAyxG3EfpXYQDOp/zz221M/yOgnI6GxA6usLNVGg6pcaMq6tSLov6MT5rxIGQ
         l0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347510;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA2P3cCw0w5TexeIUCzMnIczpz6RbPZ7j4N3nKY8zz8=;
        b=LldSLZ8buxMiLFK/2pnRZ6NC2lPPpOQ/YwnqgyCkIFHWMoUOA+hdeXftX8newB/8Vv
         4g/b9I+IgzyPF+HffMnq0HQfUoNUlBHFg/3qftFq9InQ458aMQNqSK/5Ui060x3tcZD+
         q6QuxP9+ddBmlADmEVTruzsmE2dm0KQCqpDtekALHyL6HoLJ5KO1qBOiu+0E88ag5ob7
         PJsjm9oryI/E8vrKZ6qs+eaIv3nKC7nHVdZDVZEI/vm8AZ1vqZm4FDQIfSqcp8JdsFPK
         LPUDSFw4G1boXnqA0O3oYbld2pxOZO0kyllXTSFJdEWYslG7nx5GZtLMrvsvdC4LyxkH
         BhRA==
X-Gm-Message-State: AAQBX9d2wKkptkMpL75gc1AaebwH+/xjXw4p/RYOl62XvDPS3/T+Wxtc
        h4aH7XN9ncwDy772+yqS5r1HwtCLMESP
X-Google-Smtp-Source: AKy350bAC4SLbeTAvwM0rFadDZVHynJ6wRZ6DfU7WaHNnDj0xeuY+gF0h+C0o2OadYCVVyNVVL8Ub2P9FCTA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:706:b0:b6d:9e38:1017 with SMTP id
 k6-20020a056902070600b00b6d9e381017mr26860ybt.1.1679347509795; Mon, 20 Mar
 2023 14:25:09 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:48 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-18-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 17/17] perf map: Add reference count checking
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

There's no strict get/put policy with map that leads to leaks or use
after free. Reference count checking identifies correct pairing of gets
and puts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/s390/annotate/instructions.c |  5 +-
 tools/perf/builtin-top.c                     |  4 +-
 tools/perf/tests/hists_link.c                |  2 +-
 tools/perf/tests/maps.c                      | 20 +++---
 tools/perf/tests/vmlinux-kallsyms.c          |  4 +-
 tools/perf/util/annotate.c                   | 10 +--
 tools/perf/util/machine.c                    | 25 +++----
 tools/perf/util/map.c                        | 69 +++++++++++---------
 tools/perf/util/map.h                        | 32 +++++----
 tools/perf/util/maps.c                       | 13 ++--
 tools/perf/util/symbol-elf.c                 | 26 ++++----
 tools/perf/util/symbol.c                     | 40 +++++++-----
 12 files changed, 136 insertions(+), 114 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 6548933e8dc0..9953d510f7c1 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -39,8 +39,9 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
-	    ops->target.addr)
+	    map__rip_2objdump(target.ms.map,
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
+			     ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	return 0;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b45565f718f4..2605040e6788 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -191,7 +191,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 	if (use_browser <= 0)
 		sleep(5);
 
-	map->erange_warned = true;
+	RC_CHK_ACCESS(map)->erange_warned = true;
 }
 
 static void perf_top__record_precise_ip(struct perf_top *top,
@@ -225,7 +225,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 		 */
 		mutex_unlock(&he->hists->lock);
 
-		if (err == -ERANGE && !he->ms.map->erange_warned)
+		if (err == -ERANGE && !RC_CHK_ACCESS(he->ms.map)->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
 		else if (err == -ENOMEM) {
 			pr_err("Not enough memory for annotating '%s' symbol!\n",
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 64ce8097889c..141e2972e34f 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -145,7 +145,7 @@ static int find_sample(struct sample *samples, size_t nr_samples,
 {
 	while (nr_samples--) {
 		if (samples->thread == t &&
-		    samples->map == m &&
+		    RC_CHK_ACCESS(samples->map) == RC_CHK_ACCESS(m) &&
 		    samples->sym == s)
 			return 1;
 		samples++;
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 1c7293476aca..b8dab6278bca 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -30,7 +30,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 			if (map__start(map) != merged[i].start ||
 			    map__end(map) != merged[i].end ||
 			    strcmp(map__dso(map)->name, merged[i].name) ||
-			    refcount_read(&map->refcnt) != 1) {
+			    refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 1) {
 				failed = true;
 			}
 			i++;
@@ -50,7 +50,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 				map__start(map),
 				map__end(map),
 				map__dso(map)->name,
-				refcount_read(&map->refcnt));
+				refcount_read(&RC_CHK_ACCESS(map)->refcnt));
 		}
 	}
 	return failed ? TEST_FAIL : TEST_OK;
@@ -95,8 +95,8 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 		map = dso__new_map(bpf_progs[i].name);
 		TEST_ASSERT_VAL("failed to create map", map);
 
-		map->start = bpf_progs[i].start;
-		map->end   = bpf_progs[i].end;
+		RC_CHK_ACCESS(map)->start = bpf_progs[i].start;
+		RC_CHK_ACCESS(map)->end   = bpf_progs[i].end;
 		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
 		map__put(map);
 	}
@@ -111,16 +111,16 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	TEST_ASSERT_VAL("failed to create map", map_kcore3);
 
 	/* kcore1 map overlaps over all bpf maps */
-	map_kcore1->start = 100;
-	map_kcore1->end   = 1000;
+	RC_CHK_ACCESS(map_kcore1)->start = 100;
+	RC_CHK_ACCESS(map_kcore1)->end   = 1000;
 
 	/* kcore2 map hides behind bpf_prog_2 */
-	map_kcore2->start = 550;
-	map_kcore2->end   = 570;
+	RC_CHK_ACCESS(map_kcore2)->start = 550;
+	RC_CHK_ACCESS(map_kcore2)->end   = 570;
 
 	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
-	map_kcore3->start = 880;
-	map_kcore3->end   = 1100;
+	RC_CHK_ACCESS(map_kcore3)->start = 880;
+	RC_CHK_ACCESS(map_kcore3)->end   = 1100;
 
 	ret = maps__merge_in(maps, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index af511233c764..a087b24463ff 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -304,7 +304,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 								dso->short_name :
 								dso->name));
 		if (pair) {
-			pair->priv = 1;
+			RC_CHK_ACCESS(pair)->priv = 1;
 		} else {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in vmlinux:\n");
@@ -340,7 +340,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
 					map__start(pair), map__end(pair), map__pgoff(pair));
 			pr_info(" %s\n", dso->name);
-			pair->priv = 1;
+			RC_CHK_ACCESS(pair)->priv = 1;
 		}
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 199f6cd5ad1e..8bae9d78d8c4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -280,8 +280,9 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
-	    ops->target.addr)
+	    map__rip_2objdump(target.ms.map,
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
+			      ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	return 0;
@@ -409,8 +410,9 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * the symbol searching and disassembly should be done.
 	 */
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
-	    ops->target.addr)
+	    map__rip_2objdump(target.ms.map,
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
+			      ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	if (!ops->target.outside) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cfbced348335..6310d74f6d6d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -909,8 +909,8 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_loaded(dso);
 		}
 
-		map->start = event->ksymbol.addr;
-		map->end = map__start(map) + event->ksymbol.len;
+		RC_CHK_ACCESS(map)->start = event->ksymbol.addr;
+		RC_CHK_ACCESS(map)->end = map__start(map) + event->ksymbol.len;
 		err = maps__insert(machine__kernel_maps(machine), map);
 		if (err) {
 			err = -ENOMEM;
@@ -952,7 +952,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	if (!map)
 		return 0;
 
-	if (map != machine->vmlinux_map)
+	if (RC_CHK_ACCESS(map) != RC_CHK_ACCESS(machine->vmlinux_map))
 		maps__remove(machine__kernel_maps(machine), map);
 	else {
 		struct dso *dso = map__dso(map);
@@ -1217,8 +1217,8 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	if (!map)
 		return -ENOMEM;
 
-	map->end   = xm->end;
-	map->pgoff = xm->pgoff;
+	RC_CHK_ACCESS(map)->end   = xm->end;
+	RC_CHK_ACCESS(map)->pgoff = xm->pgoff;
 
 	kmap = map__kmap(map);
 
@@ -1290,7 +1290,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 
 		dest_map = maps__find(kmaps, map__pgoff(map));
 		if (dest_map != map)
-			map->pgoff = map__map_ip(dest_map, map__pgoff(map));
+			RC_CHK_ACCESS(map)->pgoff = map__map_ip(dest_map, map__pgoff(map));
 		found = true;
 	}
 	if (found || machine->trampolines_mapped)
@@ -1341,7 +1341,8 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	if (machine->vmlinux_map == NULL)
 		return -ENOMEM;
 
-	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
+	RC_CHK_ACCESS(machine->vmlinux_map)->map_ip = identity__map_ip;
+	RC_CHK_ACCESS(machine->vmlinux_map)->unmap_ip = identity__map_ip;
 	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
 }
 
@@ -1622,7 +1623,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	map = machine__addnew_module_map(machine, start, name);
 	if (map == NULL)
 		return -1;
-	map->end = start + size;
+	RC_CHK_ACCESS(map)->end = start + size;
 
 	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
 	map__put(map);
@@ -1658,14 +1659,14 @@ static int machine__create_modules(struct machine *machine)
 static void machine__set_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
-	machine->vmlinux_map->start = start;
-	machine->vmlinux_map->end   = end;
+	RC_CHK_ACCESS(machine->vmlinux_map)->start = start;
+	RC_CHK_ACCESS(machine->vmlinux_map)->end   = end;
 	/*
 	 * Be a bit paranoid here, some perf.data file came with
 	 * a zero sized synthesized MMAP event for the kernel.
 	 */
 	if (start == 0 && end == 0)
-		machine->vmlinux_map->end = ~0ULL;
+		RC_CHK_ACCESS(machine->vmlinux_map)->end = ~0ULL;
 }
 
 static int machine__update_kernel_mmap(struct machine *machine,
@@ -1809,7 +1810,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (map == NULL)
 			goto out_problem;
 
-		map->end = map__start(map) + xm->end - xm->start;
+		RC_CHK_ACCESS(map)->end = map__start(map) + xm->end - xm->start;
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(map__dso(map), bid);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index acbc37359e06..9ac5c909ea9e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -104,15 +104,15 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 {
-	map->start    = start;
-	map->end      = end;
-	map->pgoff    = pgoff;
-	map->reloc    = 0;
-	map->dso      = dso__get(dso);
-	map->map_ip   = map__dso_map_ip;
-	map->unmap_ip = map__dso_unmap_ip;
-	map->erange_warned = false;
-	refcount_set(&map->refcnt, 1);
+	RC_CHK_ACCESS(map)->start    = start;
+	RC_CHK_ACCESS(map)->end      = end;
+	RC_CHK_ACCESS(map)->pgoff    = pgoff;
+	RC_CHK_ACCESS(map)->reloc    = 0;
+	RC_CHK_ACCESS(map)->dso      = dso__get(dso);
+	RC_CHK_ACCESS(map)->map_ip   = map__dso_map_ip;
+	RC_CHK_ACCESS(map)->unmap_ip = map__dso_unmap_ip;
+	RC_CHK_ACCESS(map)->erange_warned = false;
+	refcount_set(&RC_CHK_ACCESS(map)->refcnt, 1);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -120,11 +120,13 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u32 prot, u32 flags, struct build_id *bid,
 		     char *filename, struct thread *thread)
 {
-	struct map *map = malloc(sizeof(*map));
+	struct map *res;
+	RC_STRUCT(map) *map;
 	struct nsinfo *nsi = NULL;
 	struct nsinfo *nnsi;
 
-	if (map != NULL) {
+	map = malloc(sizeof(*map));
+	if (ADD_RC_CHK(res, map)) {
 		char newfilename[PATH_MAX];
 		struct dso *dso, *header_bid_dso;
 		int anon, no_dso, vdso, android;
@@ -167,7 +169,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
-		map__init(map, start, start + len, pgoff, dso);
+		map__init(res, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
 			map->map_ip = map->unmap_ip = identity__map_ip;
@@ -204,10 +206,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		}
 		dso__put(dso);
 	}
-	return map;
+	return res;
 out_delete:
 	nsinfo__put(nsi);
-	free(map);
+	RC_CHK_FREE(res);
 	return NULL;
 }
 
@@ -218,16 +220,18 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  */
 struct map *map__new2(u64 start, struct dso *dso)
 {
-	struct map *map = calloc(1, (sizeof(*map) +
-				     (dso->kernel ? sizeof(struct kmap) : 0)));
-	if (map != NULL) {
+	struct map *res;
+	RC_STRUCT(map) *map;
+
+	map = calloc(1, sizeof(*map) + (dso->kernel ? sizeof(struct kmap) : 0));
+	if (ADD_RC_CHK(res, map)) {
 		/*
 		 * ->end will be filled after we load all the symbols
 		 */
-		map__init(map, start, 0, 0, dso);
+		map__init(res, start, 0, 0, dso);
 	}
 
-	return map;
+	return res;
 }
 
 bool __map__is_kernel(const struct map *map)
@@ -292,20 +296,22 @@ bool map__has_symbols(const struct map *map)
 
 static void map__exit(struct map *map)
 {
-	BUG_ON(refcount_read(&map->refcnt) != 0);
-	dso__zput(map->dso);
+	BUG_ON(refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 0);
+	dso__zput(RC_CHK_ACCESS(map)->dso);
 }
 
 void map__delete(struct map *map)
 {
 	map__exit(map);
-	free(map);
+	RC_CHK_FREE(map);
 }
 
 void map__put(struct map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(&RC_CHK_ACCESS(map)->refcnt))
 		map__delete(map);
+	else
+		RC_CHK_PUT(map);
 }
 
 void map__fixup_start(struct map *map)
@@ -317,7 +323,7 @@ void map__fixup_start(struct map *map)
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 
-		map->start = sym->start;
+		RC_CHK_ACCESS(map)->start = sym->start;
 	}
 }
 
@@ -329,7 +335,7 @@ void map__fixup_end(struct map *map)
 
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map->end = sym->end;
+		RC_CHK_ACCESS(map)->end = sym->end;
 	}
 }
 
@@ -400,20 +406,21 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 
 struct map *map__clone(struct map *from)
 {
-	size_t size = sizeof(struct map);
-	struct map *map;
+	struct map *res;
+	RC_STRUCT(map) *map;
+	size_t size = sizeof(RC_STRUCT(map));
 	struct dso *dso = map__dso(from);
 
 	if (dso && dso->kernel)
 		size += sizeof(struct kmap);
 
-	map = memdup(from, size);
-	if (map != NULL) {
+	map = memdup(RC_CHK_ACCESS(from), size);
+	if (ADD_RC_CHK(res, map)) {
 		refcount_set(&map->refcnt, 1);
 		map->dso = dso__get(dso);
 	}
 
-	return map;
+	return res;
 }
 
 size_t map__fprintf(struct map *map, FILE *fp)
@@ -567,7 +574,7 @@ struct kmap *__map__kmap(struct map *map)
 
 	if (!dso || !dso->kernel)
 		return NULL;
-	return (struct kmap *)(map + 1);
+	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
 
 struct kmap *map__kmap(struct map *map)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 102485699aa8..55d047e818e7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -10,12 +10,13 @@
 #include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <internal/rc_check.h>
 
 struct dso;
 struct maps;
 struct machine;
 
-struct map {
+DECLARE_RC_STRUCT(map) {
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
@@ -49,52 +50,52 @@ u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
 
 static inline struct dso *map__dso(const struct map *map)
 {
-	return map->dso;
+	return RC_CHK_ACCESS(map)->dso;
 }
 
 static inline u64 map__map_ip(const struct map *map, u64 ip)
 {
-	return map->map_ip(map, ip);
+	return RC_CHK_ACCESS(map)->map_ip(map, ip);
 }
 
 static inline u64 map__unmap_ip(const struct map *map, u64 ip)
 {
-	return map->unmap_ip(map, ip);
+	return RC_CHK_ACCESS(map)->unmap_ip(map, ip);
 }
 
 static inline u64 map__start(const struct map *map)
 {
-	return map->start;
+	return RC_CHK_ACCESS(map)->start;
 }
 
 static inline u64 map__end(const struct map *map)
 {
-	return map->end;
+	return RC_CHK_ACCESS(map)->end;
 }
 
 static inline u64 map__pgoff(const struct map *map)
 {
-	return map->pgoff;
+	return RC_CHK_ACCESS(map)->pgoff;
 }
 
 static inline u64 map__reloc(const struct map *map)
 {
-	return map->reloc;
+	return RC_CHK_ACCESS(map)->reloc;
 }
 
 static inline u32 map__flags(const struct map *map)
 {
-	return map->flags;
+	return RC_CHK_ACCESS(map)->flags;
 }
 
 static inline u32 map__prot(const struct map *map)
 {
-	return map->prot;
+	return RC_CHK_ACCESS(map)->prot;
 }
 
 static inline bool map__priv(const struct map *map)
 {
-	return map->priv;
+	return RC_CHK_ACCESS(map)->priv;
 }
 
 static inline size_t map__size(const struct map *map)
@@ -153,9 +154,12 @@ struct map *map__clone(struct map *map);
 
 static inline struct map *map__get(struct map *map)
 {
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
+	struct map *result;
+
+	if (RC_CHK_GET(result, map))
+		refcount_inc(&RC_CHK_ACCESS(map)->refcnt);
+
+	return result;
 }
 
 void map__put(struct map *map);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 3c8bbcb2c204..a33ae321c65a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -126,7 +126,7 @@ void maps__remove(struct maps *maps, struct map *map)
 		RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
 
 	rb_node = maps__find_node(maps, map);
-	assert(rb_node->map == map);
+	assert(rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map));
 	__maps__remove(maps, rb_node);
 	if (maps__maps_by_name(maps))
 		__maps__free_maps_by_name(maps);
@@ -339,7 +339,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			before->end = map__start(map);
+			RC_CHK_ACCESS(before)->end = map__start(map);
 			err = __maps__insert(maps, before);
 			if (err) {
 				map__put(before);
@@ -351,7 +351,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			map__put(before);
 		}
 
-		if (map->end < map__end(pos->map)) {
+		if (map__end(map) < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
@@ -359,8 +359,9 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			after->start = map__end(map);
-			after->pgoff += map__end(map) - map__start(pos->map);
+			RC_CHK_ACCESS(after)->start = map__end(map);
+			RC_CHK_ACCESS(after)->pgoff +=
+				map__end(map) - map__start(pos->map);
 			assert(map__map_ip(pos->map, map__end(map)) ==
 				map__map_ip(after, map__end(map)));
 			err = __maps__insert(maps, after);
@@ -420,7 +421,7 @@ struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
 	struct map_rb_node *rb_node;
 
 	maps__for_each_entry(maps, rb_node) {
-		if (rb_node->map == map)
+		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
 			return rb_node;
 	}
 	return NULL;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 93ae3f22fd03..aa6113008627 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1348,11 +1348,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && dso->kernel && !kmodule) {
 			*remap_kernel = false;
-			map->start = shdr->sh_addr + ref_reloc(kmap);
-			map->end = map__start(map) + shdr->sh_size;
-			map->pgoff = shdr->sh_offset;
-			map->map_ip = map__dso_map_ip;
-			map->unmap_ip = map__dso_unmap_ip;
+			RC_CHK_ACCESS(map)->start = shdr->sh_addr + ref_reloc(kmap);
+			RC_CHK_ACCESS(map)->end = map__start(map) + shdr->sh_size;
+			RC_CHK_ACCESS(map)->pgoff = shdr->sh_offset;
+			RC_CHK_ACCESS(map)->map_ip = map__dso_map_ip;
+			RC_CHK_ACCESS(map)->unmap_ip = map__dso_unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
@@ -1373,7 +1373,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && kmodule) {
 			*remap_kernel = false;
-			map->pgoff = shdr->sh_offset;
+			RC_CHK_ACCESS(map)->pgoff = shdr->sh_offset;
 		}
 
 		*curr_mapp = map;
@@ -1408,11 +1408,13 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__kmap(curr_map)->kmaps = kmaps;
 
 		if (adjust_kernel_syms) {
-			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
-			curr_map->end	 = map__start(curr_map) + shdr->sh_size;
-			curr_map->pgoff	 = shdr->sh_offset;
+			RC_CHK_ACCESS(curr_map)->start  = shdr->sh_addr + ref_reloc(kmap);
+			RC_CHK_ACCESS(curr_map)->end	= map__start(curr_map) +
+							  shdr->sh_size;
+			RC_CHK_ACCESS(curr_map)->pgoff	= shdr->sh_offset;
 		} else {
-			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
+			RC_CHK_ACCESS(curr_map)->map_ip = identity__map_ip;
+			RC_CHK_ACCESS(curr_map)->unmap_ip = identity__map_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
 		if (maps__insert(kmaps, curr_map))
@@ -1519,7 +1521,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			if (strcmp(elf_name, kmap->ref_reloc_sym->name))
 				continue;
 			kmap->ref_reloc_sym->unrelocated_addr = sym.st_value;
-			map->reloc = kmap->ref_reloc_sym->addr -
+			RC_CHK_ACCESS(map)->reloc = kmap->ref_reloc_sym->addr -
 				     kmap->ref_reloc_sym->unrelocated_addr;
 			break;
 		}
@@ -1530,7 +1532,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * attempted to prelink vdso to its virtual address.
 	 */
 	if (dso__is_vdso(dso))
-		map->reloc = map__start(map) - dso->text_offset;
+		RC_CHK_ACCESS(map)->reloc = map__start(map) - dso->text_offset;
 
 	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
 	/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d99c8e1bb4bf..38b2890e4273 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -279,7 +279,7 @@ void maps__fixup_end(struct maps *maps)
 
 	maps__for_each_entry(maps, curr) {
 		if (prev != NULL && !map__end(prev->map))
-			prev->map->end = map__start(curr->map);
+			RC_CHK_ACCESS(prev->map)->end = map__start(curr->map);
 
 		prev = curr;
 	}
@@ -289,7 +289,7 @@ void maps__fixup_end(struct maps *maps)
 	 * last map final address.
 	 */
 	if (curr && !map__end(curr->map))
-		curr->map->end = ~0ULL;
+		RC_CHK_ACCESS(curr->map)->end = ~0ULL;
 
 	up_write(maps__lock(maps));
 }
@@ -865,7 +865,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			*module++ = '\0';
 			curr_map_dso = map__dso(curr_map);
 			if (strcmp(curr_map_dso->short_name, module)) {
-				if (curr_map != initial_map &&
+				if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map) &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
 					/*
@@ -944,7 +944,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 			}
 
-			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
+			RC_CHK_ACCESS(curr_map)->map_ip = identity__map_ip;
+			RC_CHK_ACCESS(curr_map)->unmap_ip = identity__map_ip;
 			if (maps__insert(kmaps, curr_map)) {
 				dso__put(ndso);
 				return -1;
@@ -1250,8 +1251,8 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 		return -ENOMEM;
 	}
 
-	list_node->map->end = map__start(list_node->map) + len;
-	list_node->map->pgoff = pgoff;
+	list_node->RC_CHK_ACCESS(map)->end = map__start(list_node->map) + len;
+	list_node->RC_CHK_ACCESS(map)->pgoff = pgoff;
 
 	list_add(&list_node->node, &md->maps);
 
@@ -1286,7 +1287,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 * |new......|     -> |new..|
 				 *       |old....| ->       |old....|
 				 */
-				new_map->end = map__start(old_map);
+				RC_CHK_ACCESS(new_map)->end = map__start(old_map);
 			} else {
 				/*
 				 * |new.............| -> |new..|       |new..|
@@ -1306,10 +1307,12 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 					goto out;
 				}
 
-				m->map->end = map__start(old_map);
+
+				RC_CHK_ACCESS(m->map)->end = map__start(old_map);
 				list_add_tail(&m->node, &merged);
-				new_map->pgoff += map__end(old_map) - map__start(new_map);
-				new_map->start = map__end(old_map);
+				RC_CHK_ACCESS(new_map)->pgoff +=
+					map__end(old_map) - map__start(new_map);
+				RC_CHK_ACCESS(new_map)->start = map__end(old_map);
 			}
 		} else {
 			/*
@@ -1329,8 +1332,9 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 *      |new......| ->         |new...|
 				 * |old....|        -> |old....|
 				 */
-				new_map->pgoff += map__end(old_map) - map__start(new_map);
-				new_map->start = map__end(old_map);
+				RC_CHK_ACCESS(new_map)->pgoff +=
+					map__end(old_map) - map__start(new_map);
+				RC_CHK_ACCESS(new_map)->start = map__end(old_map);
 			}
 		}
 	}
@@ -1455,12 +1459,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		new_node = list_entry(md.maps.next, struct map_list_node, node);
 		list_del_init(&new_node->node);
-		if (new_node->map == replacement_map) {
-			map->start	= map__start(new_node->map);
-			map->end	= map__end(new_node->map);
-			map->pgoff	= map__pgoff(new_node->map);
-			map->map_ip	= new_node->map->map_ip;
-			map->unmap_ip	= new_node->map->unmap_ip;
+		if (RC_CHK_ACCESS(new_node->map) == RC_CHK_ACCESS(replacement_map)) {
+			RC_CHK_ACCESS(map)->start = map__start(new_node->map);
+			RC_CHK_ACCESS(map)->end   = map__end(new_node->map);
+			RC_CHK_ACCESS(map)->pgoff = map__pgoff(new_node->map);
+			RC_CHK_ACCESS(map)->map_ip = RC_CHK_ACCESS(new_node->map)->map_ip;
+			RC_CHK_ACCESS(map)->unmap_ip = RC_CHK_ACCESS(new_node->map)->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			maps__remove(kmaps, map);
-- 
2.40.0.rc1.284.g88254d51c5-goog

