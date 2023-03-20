Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956BF6C2395
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCTVYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCTVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742818AAB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e11-20020a5b004b000000b00b37118ce5a7so14509002ybp.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347420;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVpDoD1EtljxxnMNg4hbmCXcWrkBwNDgBIuGmLtz0Po=;
        b=kQjNUMYCRA9X+bGmigd7EV5+58PYFjRQlqIcBD7mec8AqXOH5n55McSbrO2WtbIO7m
         003lgJwSRM04TBlUu5qNhdGiM2shzH2Z+ca6HVVgfpRJnJ87eALQiuv0KX68u1lYufBq
         HubFvQqxxhrb25vbVmBq5H2sis421IqeyU3M7P/ilSPEo8744985s/nb/bQq0xorniFV
         V9iFHMCH/5S8GNX6mSDLattfjl+xgy+Ymp8n2dP21tVgGCB+p6Et2Dmss4ZtIKPCicbw
         /qN8gjMBx2DLzIWrZdQA/VACvwdjkTnT7ekgI4FpU9pyn1o/wEFcSlqKJPW/aPpbnOQg
         pCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347420;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVpDoD1EtljxxnMNg4hbmCXcWrkBwNDgBIuGmLtz0Po=;
        b=gCAKWXB83sITPy4DqYATjhmOXWvgj8txLuar4iZxCL5NWnOIGnXXhTPdhXYPMAhzjf
         hQKk+vvYcBK/yhiIiLZnsfCCOBw1D2qi/yR9nAm7Wuo5Jo7tIaBa7tRlqzZAKzqnUV20
         4VpdhLRHqBr/1Mb3WAi4VvNSdcjWFvtN+pP98Fjpa074BtK5LdBR8ySWCDS/lh23ocwW
         SSWBsIwP25Rfb1/RTBdGkxpHnW4w0oK1x6kq5cChT0M/ro5TZhWtWxvZWi4+F1tVcP8F
         4SMvrr6uXv8pUT4Kq0ncz2Ru8dNwv06PWZ1UKHj7XE0MGCqpg5M6N5PBfhutbVVUeyS3
         aylw==
X-Gm-Message-State: AO0yUKWbRSd4wyOp6uEgSNKO5Y0CXf9KwQ03m0jwvn3CjjdlbaSchdOE
        WRhzPnJWnLpWy4Z+L1BGQWMF1rLj2cOk
X-Google-Smtp-Source: AK7set8haAcnyjN1MgWHAZg7+mqm7/pM8mPvyXP/wX13wIx67RQQptcH1/gKTvvf3/0Sx89P+jRUaEMw9wqd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a81:e50d:0:b0:541:a0cc:2a09 with SMTP id
 s13-20020a81e50d000000b00541a0cc2a09mr10933951ywl.7.1679347420460; Mon, 20
 Mar 2023 14:23:40 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:36 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-6-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 05/17] perf map: Add accessor for start and end
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

Later changes will add reference count checking for struct map, start
and end are frequently accessed variables. Add an accessor so that the
reference count check is only necessary in one place.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c      |  2 +-
 tools/perf/arch/x86/util/event.c              |  4 +-
 tools/perf/builtin-buildid-list.c             |  2 +-
 tools/perf/builtin-report.c                   |  2 +-
 tools/perf/builtin-script.c                   |  2 +-
 tools/perf/builtin-top.c                      |  2 +-
 tools/perf/tests/code-reading.c               |  8 +--
 tools/perf/tests/maps.c                       |  4 +-
 tools/perf/tests/mmap-thread-lookup.c         |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c           | 14 +++---
 tools/perf/util/annotate.c                    |  4 +-
 tools/perf/util/dlfilter.c                    |  8 +--
 tools/perf/util/intel-pt.c                    |  8 +--
 tools/perf/util/machine.c                     | 14 +++---
 tools/perf/util/map.c                         |  8 +--
 tools/perf/util/map.h                         | 12 ++++-
 tools/perf/util/maps.c                        | 30 ++++++------
 tools/perf/util/probe-event.c                 |  4 +-
 .../scripting-engines/trace-event-python.c    |  6 +--
 tools/perf/util/symbol-elf.c                  |  8 +--
 tools/perf/util/symbol.c                      | 49 ++++++++++---------
 tools/perf/util/symbol_fprintf.c              |  2 +-
 tools/perf/util/synthetic-events.c            | 16 +++---
 tools/perf/util/unwind-libdw.c                |  6 +--
 24 files changed, 114 insertions(+), 103 deletions(-)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index a54dea7c112f..497593be80f2 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map__end(map) - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 17bf60babfbd..3b2475707756 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -59,8 +59,8 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 
 		event->mmap.header.size = size;
 
-		event->mmap.start = map->start;
-		event->mmap.len   = map->end - map->start;
+		event->mmap.start = map__start(map);
+		event->mmap.len   = map__size(map);
 		event->mmap.pgoff = map->pgoff;
 		event->mmap.pid   = machine->pid;
 
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index cad9ed44ce7c..eea28cbcc0b7 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -30,7 +30,7 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 	memset(bid_buf, 0, sizeof(bid_buf));
 	if (dso->has_build_id)
 		build_id__sprintf(&dso->bid, bid_buf);
-	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map->start, map->end);
+	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), map__end(map));
 	if (dso->long_name != NULL) {
 		printf(" %s", dso->long_name);
 	} else if (dso->short_name != NULL) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02ca87c13e91..4ce1aef3e253 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -847,7 +847,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 		const struct dso *dso = map__dso(map);
 
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
-				   indent, "", map->start, map->end,
+				   indent, "", map__start(map), map__end(map),
 				   map->prot & PROT_READ ? 'r' : '-',
 				   map->prot & PROT_WRITE ? 'w' : '-',
 				   map->prot & PROT_EXEC ? 'x' : '-',
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9c7eb900ff7c..eb49689d0f00 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1209,7 +1209,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	if (al.addr < al.sym->end)
 		off = al.addr - al.sym->start;
 	else
-		off = al.addr - al.map->start - al.sym->start;
+		off = al.addr - map__start(al.map) - al.sym->start;
 	printed += fprintf(fp, "\t%s", al.sym->name);
 	if (off)
 		printed += fprintf(fp, "%+d", off);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5010eee8fbae..b45565f718f4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -183,7 +183,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Not all samples will be on the annotation output.\n\n"
 		    "Please report to linux-kernel@vger.kernel.org\n",
 		    ip, dso->long_name, dso__symtab_origin(dso),
-		    map->start, map->end, sym->start, sym->end,
+		    map__start(map), map__end(map), sym->start, sym->end,
 		    sym->binding == STB_GLOBAL ? 'g' :
 		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
 		    err ? "[unknown]" : uts.machine,
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 936c61546e64..1545fcaa95c6 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -265,8 +265,8 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		len = BUFSZ;
 
 	/* Do not go off the map */
-	if (addr + len > al.map->end)
-		len = al.map->end - addr;
+	if (addr + len > map__end(al.map))
+		len = map__end(al.map) - addr;
 
 	/* Read the object code using perf */
 	ret_len = dso__data_read_offset(dso, maps__machine(thread->maps),
@@ -291,7 +291,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		size_t d;
 
 		for (d = 0; d < state->done_cnt; d++) {
-			if (state->done[d] == al.map->start) {
+			if (state->done[d] == map__start(al.map)) {
 				pr_debug("kcore map tested already");
 				pr_debug(" - skipping\n");
 				goto out;
@@ -301,7 +301,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			pr_debug("Too many kcore maps - skipping\n");
 			goto out;
 		}
-		state->done[state->done_cnt++] = al.map->start;
+		state->done[state->done_cnt++] = map__start(al.map);
 	}
 
 	objdump_name = dso->long_name;
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index ae7028fbf79e..fd0c464fcf95 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -24,8 +24,8 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 		if (i > 0)
 			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 
-		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
+		TEST_ASSERT_VAL("wrong map start",  map__start(map) == merged[i].start);
+		TEST_ASSERT_VAL("wrong map end",    map__end(map) == merged[i].end);
 		TEST_ASSERT_VAL("wrong map name",  !strcmp(map__dso(map)->name, merged[i].name));
 		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
 
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index a4301fc7b770..5cc4644e353d 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -202,7 +202,7 @@ static int mmap_events(synth_cb synth)
 			break;
 		}
 
-		pr_debug("map %p, addr %" PRIx64 "\n", al.map, al.map->start);
+		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
 	}
 
 	machine__delete_threads(machine);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index c614c2db7e89..0a75623172c2 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -267,7 +267,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 				continue;
 			}
-		} else if (mem_start == kallsyms.vmlinux_map->end) {
+		} else if (mem_start == map__end(kallsyms.vmlinux_map)) {
 			/*
 			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
 			 * such as __indirect_thunk_end.
@@ -319,14 +319,14 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	maps__for_each_entry(maps, rb_node) {
 		struct map *pair, *map = rb_node->map;
 
-		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
-		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
+		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map__start(map));
+		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map__end(map));
 
 		pair = maps__find(kallsyms.kmaps, mem_start);
 		if (pair == NULL || pair->priv)
 			continue;
 
-		if (pair->start == mem_start) {
+		if (map__start(pair) == mem_start) {
 			struct dso *dso = map__dso(map);
 
 			if (!header_printed) {
@@ -335,10 +335,10 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 			}
 
 			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-				map->start, map->end, map->pgoff, dso->name);
-			if (mem_end != pair->end)
+				map__start(map), map__end(map), map->pgoff, dso->name);
+			if (mem_end != map__end(pair))
 				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
-					pair->start, pair->end, pair->pgoff);
+					map__start(pair), map__end(pair), pair->pgoff);
 			pr_info(" %s\n", dso->name);
 			pair->priv = 1;
 		}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9494b34e84fc..f60f5efb2ad9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1016,13 +1016,13 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	if (start &&
 		(start->ms.sym == ams->ms.sym ||
 		 (ams->ms.sym &&
-		   start->addr == ams->ms.sym->start + ams->ms.map->start)))
+		  start->addr == ams->ms.sym->start + map__start(ams->ms.map))))
 		saddr = start->al_addr;
 	if (saddr == 0)
 		pr_debug2("BB with bad start: addr %"PRIx64" start %"PRIx64" sym %"PRIx64" saddr %"PRIx64"\n",
 			ams->addr,
 			start ? start->addr : 0,
-			ams->ms.sym ? ams->ms.sym->start + ams->ms.map->start : 0,
+			ams->ms.sym ? ams->ms.sym->start + map__start(ams->ms.map) : 0,
 			saddr);
 	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles);
 	if (err)
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 8a7ffe0d805a..fe401fa4be02 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -51,7 +51,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		if (al->addr < sym->end)
 			d_al->symoff = al->addr - sym->start;
 		else
-			d_al->symoff = al->addr - al->map->start - sym->start;
+			d_al->symoff = al->addr - map__start(al->map) - sym->start;
 		d_al->sym_binding = sym->binding;
 	} else {
 		d_al->sym = NULL;
@@ -268,7 +268,7 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 
 	map = al->map;
 
-	if (map && ip >= map->start && ip < map->end &&
+	if (map && ip >= map__start(map) && ip < map__end(map) &&
 	    machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
 		goto have_map;
 
@@ -279,8 +279,8 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 	map = a.map;
 have_map:
 	offset = map->map_ip(map, ip);
-	if (ip + len >= map->end)
-		len = map->end - ip;
+	if (ip + len >= map__end(map))
+		len = map__end(map) - ip;
 	return dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
 }
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8cec88e09792..a2e62daa708e 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -887,7 +887,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				goto out_no_cache;
 			}
 
-			if (*ip >= al.map->end)
+			if (*ip >= map__end(al.map))
 				break;
 
 			offset += intel_pt_insn->length;
@@ -2750,7 +2750,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 		if (sym->binding == STB_GLOBAL &&
 		    !strcmp(sym->name, "__switch_to")) {
 			ip = map->unmap_ip(map, sym->start);
-			if (ip >= map->start && ip < map->end) {
+			if (ip >= map__start(map) && ip < map__end(map)) {
 				switch_ip = ip;
 				break;
 			}
@@ -2768,7 +2768,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (!strcmp(sym->name, ptss)) {
 			ip = map->unmap_ip(map, sym->start);
-			if (ip >= map->start && ip < map->end) {
+			if (ip >= map__start(map) && ip < map__end(map)) {
 				*ptss_ip = ip;
 				break;
 			}
@@ -3356,7 +3356,7 @@ static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
 static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
-	if (!al->map || addr < al->map->start || addr >= al->map->end) {
+	if (!al->map || addr < map__start(al->map) || addr >= map__end(al->map)) {
 		if (!thread__find_map(thread, cpumode, addr, al))
 			return -1;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6e32344e66dc..08fb3ab0c205 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -902,7 +902,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		map->start = event->ksymbol.addr;
-		map->end = map->start + event->ksymbol.len;
+		map->end = map__start(map) + event->ksymbol.len;
 		err = maps__insert(machine__kernel_maps(machine), map);
 		map__put(map);
 		if (err)
@@ -918,7 +918,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		dso = map__dso(map);
 	}
 
-	sym = symbol__new(map->map_ip(map, map->start),
+	sym = symbol__new(map->map_ip(map, map__start(map)),
 			  event->ksymbol.len,
 			  0, 0, event->ksymbol.name);
 	if (!sym)
@@ -943,7 +943,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	else {
 		struct dso *dso = map__dso(map);
 
-		sym = dso__find_symbol(dso, map->map_ip(map, map->start));
+		sym = dso__find_symbol(dso, map->map_ip(map, map__start(map)));
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
@@ -1216,7 +1216,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	if (!err) {
 		pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
-			kmap->name, map->start, map->end);
+			kmap->name, map__start(map), map__end(map));
 	}
 
 	map__put(map);
@@ -1721,7 +1721,7 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map_rb_node *next = map_rb_node__next(rb_node);
 
 		if (next)
-			machine__set_kernel_mmap(machine, start, next->map->start);
+			machine__set_kernel_mmap(machine, start, map__start(next->map));
 	}
 
 out_put:
@@ -1794,7 +1794,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (map == NULL)
 			goto out_problem;
 
-		map->end = map->start + xm->end - xm->start;
+		map->end = map__start(map) + xm->end - xm->start;
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(map__dso(map), bid);
@@ -3288,7 +3288,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
 		if (!err && !machine__is(machine, "x86_64"))
-			machine->kernel_start = map->start;
+			machine->kernel_start = map__start(map);
 	}
 	return err;
 }
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 90062af6675a..416fc449bde8 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -421,7 +421,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
 	const struct dso *dso = map__dso(map);
 
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
-		       map->start, map->end, map->pgoff, dso->name);
+		       map__start(map), map__end(map), map->pgoff, dso->name);
 }
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
@@ -558,7 +558,7 @@ bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
 	u64 ip = map->unmap_ip(map, sym->start);
 
-	return ip >= map->start && ip < map->end;
+	return ip >= map__start(map) && ip < map__end(map);
 }
 
 struct kmap *__map__kmap(struct map *map)
@@ -592,12 +592,12 @@ struct maps *map__kmaps(struct map *map)
 
 u64 map__map_ip(const struct map *map, u64 ip)
 {
-	return ip - map->start + map->pgoff;
+	return ip - map__start(map) + map->pgoff;
 }
 
 u64 map__unmap_ip(const struct map *map, u64 ip)
 {
-	return ip + map->start - map->pgoff;
+	return ip + map__start(map) - map->pgoff;
 }
 
 u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 36c5add0144d..16646b94fa3a 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -52,9 +52,19 @@ static inline struct dso *map__dso(const struct map *map)
 	return map->dso;
 }
 
+static inline u64 map__start(const struct map *map)
+{
+	return map->start;
+}
+
+static inline u64 map__end(const struct map *map)
+{
+	return map->end;
+}
+
 static inline size_t map__size(const struct map *map)
 {
-	return map->end - map->start;
+	return map__end(map) - map__start(map);
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09ec6bbafcbc..1fd57db72226 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -34,7 +34,7 @@ static int __maps__insert(struct maps *maps, struct map *map)
 {
 	struct rb_node **p = &maps__entries(maps)->rb_node;
 	struct rb_node *parent = NULL;
-	const u64 ip = map->start;
+	const u64 ip = map__start(map);
 	struct map_rb_node *m, *new_rb_node;
 
 	new_rb_node = malloc(sizeof(*new_rb_node));
@@ -47,7 +47,7 @@ static int __maps__insert(struct maps *maps, struct map *map)
 	while (*p != NULL) {
 		parent = *p;
 		m = rb_entry(parent, struct map_rb_node, rb_node);
-		if (ip < m->map->start)
+		if (ip < map__start(m->map))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -229,7 +229,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 {
-	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
+	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
 		ams->ms.map = maps__find(maps, ams->addr);
@@ -283,9 +283,9 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 	while (next) {
 		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 
-		if (pos->map->end > map->start) {
+		if (map__end(pos->map) > map__start(map)) {
 			first = next;
-			if (pos->map->start <= map->start)
+			if (map__start(pos->map) <= map__start(map))
 				break;
 			next = next->rb_left;
 		} else
@@ -301,7 +301,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (pos->map->start >= map->end)
+		if (map__start(pos->map) >= map__end(map))
 			break;
 
 		if (verbose >= 2) {
@@ -321,7 +321,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map->start > pos->map->start) {
+		if (map__start(map) > map__start(pos->map)) {
 			struct map *before = map__clone(pos->map);
 
 			if (before == NULL) {
@@ -329,7 +329,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			before->end = map->start;
+			before->end = map__start(map);
 			err = __maps__insert(maps, before);
 			if (err)
 				goto put_map;
@@ -339,7 +339,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			map__put(before);
 		}
 
-		if (map->end < pos->map->end) {
+		if (map->end < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
@@ -347,10 +347,10 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			after->start = map->end;
-			after->pgoff += map->end - pos->map->start;
-			assert(pos->map->map_ip(pos->map, map->end) ==
-				after->map_ip(after, map->end));
+			after->start = map__end(map);
+			after->pgoff += map__end(map) - map__start(pos->map);
+			assert(pos->map->map_ip(pos->map, map__end(map)) ==
+				after->map_ip(after, map__end(map)));
 			err = __maps__insert(maps, after);
 			if (err)
 				goto put_map;
@@ -430,9 +430,9 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	p = maps__entries(maps)->rb_node;
 	while (p != NULL) {
 		m = rb_entry(p, struct map_rb_node, rb_node);
-		if (ip < m->map->start)
+		if (ip < map__start(m->map))
 			p = p->rb_left;
-		else if (ip >= m->map->end)
+		else if (ip >= map__end(m->map))
 			p = p->rb_right;
 		else
 			goto out;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b26670a26005..4d9dbeeb6014 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -143,7 +143,7 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 			return -ENOENT;
 		*addr = map->unmap_ip(map, sym->start) -
 			((reloc) ? 0 : map->reloc) -
-			((reladdr) ? map->start : 0);
+			((reladdr) ? map__start(map) : 0);
 	}
 	return 0;
 }
@@ -257,7 +257,7 @@ static bool kprobe_warn_out_range(const char *symbol, u64 address)
 
 	map = kernel_get_module_map(NULL);
 	if (map) {
-		ret = address <= map->start || map->end < address;
+		ret = address <= map__start(map) || map__end(map) < address;
 		if (ret)
 			pr_warning("%s is out of .text, skip it.\n", symbol);
 		map__put(map);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index b8e5c6f61d80..cbf09eaf3734 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -409,7 +409,7 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 	if (al->addr < sym->end)
 		offset = al->addr - sym->start;
 	else
-		offset = al->addr - al->map->start - sym->start;
+		offset = al->addr - map__start(al->map) - sym->start;
 
 	return offset;
 }
@@ -788,9 +788,9 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 		pydict_set_item_string_decref(dict, dso_bid_field,
 			_PyUnicode_FromString(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_map_start,
-			PyLong_FromUnsignedLong(al->map->start));
+			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
-			PyLong_FromUnsignedLong(al->map->end));
+			PyLong_FromUnsignedLong(map__end(al->map)));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 97085ad7fe9b..0542985ecaf6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1349,7 +1349,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (*remap_kernel && dso->kernel && !kmodule) {
 			*remap_kernel = false;
 			map->start = shdr->sh_addr + ref_reloc(kmap);
-			map->end = map->start + shdr->sh_size;
+			map->end = map__start(map) + shdr->sh_size;
 			map->pgoff = shdr->sh_offset;
 			map->map_ip = map__map_ip;
 			map->unmap_ip = map__unmap_ip;
@@ -1391,7 +1391,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		u64 start = sym->st_value;
 
 		if (kmodule)
-			start += map->start + shdr->sh_offset;
+			start += map__start(map) + shdr->sh_offset;
 
 		curr_dso = dso__new(dso_name);
 		if (curr_dso == NULL)
@@ -1409,7 +1409,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
-			curr_map->end	 = curr_map->start + shdr->sh_size;
+			curr_map->end	 = map__start(curr_map) + shdr->sh_size;
 			curr_map->pgoff	 = shdr->sh_offset;
 		} else {
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
@@ -1530,7 +1530,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * attempted to prelink vdso to its virtual address.
 	 */
 	if (dso__is_vdso(dso))
-		map->reloc = map->start - dso->text_offset;
+		map->reloc = map__start(map) - dso->text_offset;
 
 	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
 	/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 13176ed5bd27..c76582dbe7ff 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -278,8 +278,8 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !prev->map->end)
-			prev->map->end = curr->map->start;
+		if (prev != NULL && !map__end(prev->map))
+			prev->map->end = map__start(curr->map);
 
 		prev = curr;
 	}
@@ -288,7 +288,7 @@ void maps__fixup_end(struct maps *maps)
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (curr && !curr->map->end)
+	if (curr && !map__end(curr->map))
 		curr->map->end = ~0ULL;
 
 	up_write(maps__lock(maps));
@@ -810,11 +810,11 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			continue;
 		}
 		curr_map_dso = map__dso(curr_map);
-		pos->start -= curr_map->start - curr_map->pgoff;
-		if (pos->end > curr_map->end)
-			pos->end = curr_map->end;
+		pos->start -= map__start(curr_map) - curr_map->pgoff;
+		if (pos->end > map__end(curr_map))
+			pos->end = map__end(curr_map);
 		if (pos->end)
-			pos->end -= curr_map->start - curr_map->pgoff;
+			pos->end -= map__start(curr_map) - curr_map->pgoff;
 		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
 	}
@@ -1156,7 +1156,7 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 		dso = map__dso(old_map);
 		/* Module must be in memory at the same address */
 		mi = find_module(dso->short_name, &modules);
-		if (!mi || mi->start != old_map->start) {
+		if (!mi || mi->start != map__start(old_map)) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -1250,7 +1250,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 		return -ENOMEM;
 	}
 
-	list_node->map->end = list_node->map->start + len;
+	list_node->map->end = map__start(list_node->map) + len;
 	list_node->map->pgoff = pgoff;
 
 	list_add(&list_node->node, &md->maps);
@@ -1272,21 +1272,21 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 		struct map *old_map = rb_node->map;
 
 		/* no overload with this one */
-		if (new_map->end < old_map->start ||
-		    new_map->start >= old_map->end)
+		if (map__end(new_map) < map__start(old_map) ||
+		    map__start(new_map) >= map__end(old_map))
 			continue;
 
-		if (new_map->start < old_map->start) {
+		if (map__start(new_map) < map__start(old_map)) {
 			/*
 			 * |new......
 			 *       |old....
 			 */
-			if (new_map->end < old_map->end) {
+			if (map__end(new_map) < map__end(old_map)) {
 				/*
 				 * |new......|     -> |new..|
 				 *       |old....| ->       |old....|
 				 */
-				new_map->end = old_map->start;
+				new_map->end = map__start(old_map);
 			} else {
 				/*
 				 * |new.............| -> |new..|       |new..|
@@ -1306,17 +1306,17 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 					goto out;
 				}
 
-				m->map->end = old_map->start;
+				m->map->end = map__start(old_map);
 				list_add_tail(&m->node, &merged);
-				new_map->pgoff += old_map->end - new_map->start;
-				new_map->start = old_map->end;
+				new_map->pgoff += map__end(old_map) - map__start(new_map);
+				new_map->start = map__end(old_map);
 			}
 		} else {
 			/*
 			 *      |new......
 			 * |old....
 			 */
-			if (new_map->end < old_map->end) {
+			if (map__end(new_map) < map__end(old_map)) {
 				/*
 				 *      |new..|   -> x
 				 * |old.........| -> |old.........|
@@ -1329,8 +1329,8 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 *      |new......| ->         |new...|
 				 * |old....|        -> |old....|
 				 */
-				new_map->pgoff += old_map->end - new_map->start;
-				new_map->start = old_map->end;
+				new_map->pgoff += map__end(old_map) - map__start(new_map);
+				new_map->start = map__end(old_map);
 			}
 		}
 	}
@@ -1427,9 +1427,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		struct map_list_node *new_node;
 
 		list_for_each_entry(new_node, &md.maps, node) {
-			u64 new_size = new_node->map->end - new_node->map->start;
+			u64 new_size = map__size(new_node->map);
 
-			if (!(stext >= new_node->map->start && stext < new_node->map->end))
+			if (!(stext >= map__start(new_node->map) &&
+			      stext < map__end(new_node->map)))
 				continue;
 
 			/*
@@ -1455,8 +1456,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		new_node = list_entry(md.maps.next, struct map_list_node, node);
 		list_del_init(&new_node->node);
 		if (new_node->map == replacement_map) {
-			map->start	= new_node->map->start;
-			map->end	= new_node->map->end;
+			map->start	= map__start(new_node->map);
+			map->end	= map__end(new_node->map);
 			map->pgoff	= new_node->map->pgoff;
 			map->map_ip	= new_node->map->map_ip;
 			map->unmap_ip	= new_node->map->unmap_ip;
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 2664fb65e47a..d9e5ad040b6a 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -30,7 +30,7 @@ size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
 			if (al->addr < sym->end)
 				offset = al->addr - sym->start;
 			else
-				offset = al->addr - al->map->start - sym->start;
+				offset = al->addr - map__start(al->map) - sym->start;
 			length += fprintf(fp, "+0x%lx", offset);
 		}
 		return length;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index fbd1a882b013..b2e4afa5efa1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -706,8 +706,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 						(sizeof(event->mmap2.filename) - size));
 			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
 			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = map->start;
-			event->mmap2.len   = map->end - map->start;
+			event->mmap2.start = map__start(map);
+			event->mmap2.len   = map__size(map);
 			event->mmap2.pid   = machine->pid;
 
 			memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
@@ -720,8 +720,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 						(sizeof(event->mmap.filename) - size));
 			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
 			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = map->start;
-			event->mmap.len   = map->end - map->start;
+			event->mmap.start = map__start(map);
+			event->mmap.len   = map__size(map);
 			event->mmap.pid   = machine->pid;
 
 			memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
@@ -1143,8 +1143,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->mmap2.header.size = (sizeof(event->mmap2) -
 				(sizeof(event->mmap2.filename) - size) + machine->id_hdr_size);
 		event->mmap2.pgoff = kmap->ref_reloc_sym->addr;
-		event->mmap2.start = map->start;
-		event->mmap2.len   = map->end - event->mmap.start;
+		event->mmap2.start = map__start(map);
+		event->mmap2.len   = map__end(map) - event->mmap.start;
 		event->mmap2.pid   = machine->pid;
 
 		perf_record_mmap2__read_build_id(&event->mmap2, machine, true);
@@ -1156,8 +1156,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->mmap.header.size = (sizeof(event->mmap) -
 				(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
 		event->mmap.pgoff = kmap->ref_reloc_sym->addr;
-		event->mmap.start = map->start;
-		event->mmap.len   = map->end - event->mmap.start;
+		event->mmap.start = map__start(map);
+		event->mmap.len   = map__end(map) - event->mmap.start;
 		event->mmap.pid   = machine->pid;
 	}
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index c8cba9d4bfd9..b79f57e5648f 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -62,19 +62,19 @@ static int __report_module(struct addr_location *al, u64 ip,
 		Dwarf_Addr s;
 
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s != al->map->start - al->map->pgoff)
+		if (s != map__start(al->map) - al->map->pgoff)
 			mod = 0;
 	}
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
-				      al->map->start - al->map->pgoff, false);
+				      map__start(al->map) - al->map->pgoff, false);
 	if (!mod) {
 		char filename[PATH_MAX];
 
 		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
 			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
-					      al->map->start - al->map->pgoff, false);
+					      map__start(al->map) - al->map->pgoff, false);
 	}
 
 	if (mod) {
-- 
2.40.0.rc1.284.g88254d51c5-goog

