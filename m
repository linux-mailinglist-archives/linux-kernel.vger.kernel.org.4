Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE766D6E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjDDVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjDDVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33E49EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:00:53 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z14-20020a62d10e000000b0062e01947ef4so134527pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642053;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTqMk+i14kBQhNGj+iB54TJvhWHGHEix7VEoIVCjH+o=;
        b=Tx2occNBIdX5b7jB2iYgPuGXZMCwpyVHbaJ/5KSlG31iWgB6Bf44aFnemB3efGLfQo
         Qu/XebiD6J0z/u/5DH6AiyMAQjvdsy0Ht/iRgS1nWDnheB6it7ID+TgMu9nS9fwBlmuE
         R55ElxXGRjWYiu0HgXDbZBnj2LTJHYyLpH01JaOClsV3lbDbk6+fJ+g4IOABHOr+Dtdp
         fSrI3x3ZkvnMOvZOW+z/9Zitrp5Q/+9t6Ef6ycYBnt4HbHgyCORtRU/xgpCU3Od6S2LI
         6jxbx1N0Wg1NfRyoa2aiWHFZs7DjjVmEjLY3aqUpyXmhVkTYsGOcB6ykmUxLjah147Sh
         pdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642053;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTqMk+i14kBQhNGj+iB54TJvhWHGHEix7VEoIVCjH+o=;
        b=p+zU7rA7l8fhrDh2BEHpSNJr0PKEBwJzLjc0tVsGPdRy0FG+apSE6vnIAAoXITLoAI
         QR1cAp55ZmfHMw72uOXFnFajXEZrCKn+c5ZU+yWAX2X/JUvTwTpjrg/AgLUImjnjK3m3
         hAJsbZSj7nZNlfVSwuLitdpl9Hf0nNC6J3VbougWo0m18nsNMAziB2O0XJHQ416fxj9Z
         ceRv3CgyZQlWH7ngExIfqcUgPdb1zwMZu2r++oa3PK5ctzKhMLcPlf7Hm5XjO7cwimFo
         F+36TOxKRG0o4xj0klrP6aWirblYUr8Nz8WHVFt5ILVwI3yLPWN+VUgoozCvik0vIpHl
         keAA==
X-Gm-Message-State: AAQBX9e0GRBdKbnj9uFkFw/lQbfwa/7uDGm8XdHySIu24WJ9D5bb1Vvo
        Ezg69ayPLpyN7W7uNLWTACHEHjfcMCtL
X-Google-Smtp-Source: AKy350aR0+LCtC7ZuR8nlLRzzmcVh7BiTaSdHPR/2Gd7nqq8LjSUSQ+L/dAo7u9PoJOktgluHYd9eNRO6Dth
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:aa7:8891:0:b0:623:129f:6269 with SMTP id
 z17-20020aa78891000000b00623129f6269mr2094653pfe.1.1680642052919; Tue, 04 Apr
 2023 14:00:52 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:46 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-5-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 04/12] perf map: Add accessors for pgoff and reloc
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

Later changes will add reference count checking for struct map. Add
accessors so that the reference count check is only necessary in one
place.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/event.c    |  2 +-
 tools/perf/builtin-report.c         |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/machine.c           |  4 ++--
 tools/perf/util/map.c               | 14 +++++++-------
 tools/perf/util/map.h               | 10 ++++++++++
 tools/perf/util/probe-event.c       |  8 ++++----
 tools/perf/util/symbol.c            |  6 +++---
 tools/perf/util/unwind-libdw.c      |  6 +++---
 9 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 3b2475707756..5741ffe47312 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -61,7 +61,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 
 		event->mmap.start = map__start(map);
 		event->mmap.len   = map__size(map);
-		event->mmap.pgoff = map->pgoff;
+		event->mmap.pgoff = map__pgoff(map);
 		event->mmap.pid   = machine->pid;
 
 		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c066452219c8..92c6797e7cba 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -857,7 +857,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 				   prot & PROT_WRITE ? 'w' : '-',
 				   prot & PROT_EXEC ? 'x' : '-',
 				   map__flags(map) ? 's' : 'p',
-				   map->pgoff,
+				   map__pgoff(map),
 				   dso->id.ino, dso->name);
 	}
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7db102868bc2..af511233c764 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -335,10 +335,10 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 			}
 
 			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-				map__start(map), map__end(map), map->pgoff, dso->name);
+				map__start(map), map__end(map), map__pgoff(map), dso->name);
 			if (mem_end != map__end(pair))
 				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
-					map__start(pair), map__end(pair), pair->pgoff);
+					map__start(pair), map__end(pair), map__pgoff(pair));
 			pr_info(" %s\n", dso->name);
 			pair->priv = 1;
 		}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d29ec4a04488..1ea6f6c06bbb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1277,9 +1277,9 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 		if (!kmap || !is_entry_trampoline(kmap->name))
 			continue;
 
-		dest_map = maps__find(kmaps, map->pgoff);
+		dest_map = maps__find(kmaps, map__pgoff(map));
 		if (dest_map != map)
-			map->pgoff = map__map_ip(dest_map, map->pgoff);
+			map->pgoff = map__map_ip(dest_map, map__pgoff(map));
 		found = true;
 	}
 	if (found || machine->trampolines_mapped)
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 816bffbbf344..1fe367e2cf19 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -421,7 +421,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
 	const struct dso *dso = map__dso(map);
 
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
-		       map__start(map), map__end(map), map->pgoff, dso->name);
+		       map__start(map), map__end(map), map__pgoff(map), dso->name);
 }
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
@@ -510,7 +510,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 		return rip;
 
 	if (dso->rel)
-		return rip - map->pgoff;
+		return rip - map__pgoff(map);
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
@@ -519,7 +519,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 	if (dso->kernel == DSO_SPACE__USER)
 		return rip + dso->text_offset;
 
-	return map__unmap_ip(map, rip) - map->reloc;
+	return map__unmap_ip(map, rip) - map__reloc(map);
 }
 
 /**
@@ -542,7 +542,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 		return map__unmap_ip(map, ip);
 
 	if (dso->rel)
-		return map__unmap_ip(map, ip + map->pgoff);
+		return map__unmap_ip(map, ip + map__pgoff(map));
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
@@ -551,7 +551,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	if (dso->kernel == DSO_SPACE__USER)
 		return map__unmap_ip(map, ip - dso->text_offset);
 
-	return ip + map->reloc;
+	return ip + map__reloc(map);
 }
 
 bool map__contains_symbol(const struct map *map, const struct symbol *sym)
@@ -592,12 +592,12 @@ struct maps *map__kmaps(struct map *map)
 
 u64 map__dso_map_ip(const struct map *map, u64 ip)
 {
-	return ip - map__start(map) + map->pgoff;
+	return ip - map__start(map) + map__pgoff(map);
 }
 
 u64 map__dso_unmap_ip(const struct map *map, u64 ip)
 {
-	return ip + map__start(map) - map->pgoff;
+	return ip + map__start(map) - map__pgoff(map);
 }
 
 u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fd440c9c279e..102485699aa8 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -72,6 +72,16 @@ static inline u64 map__end(const struct map *map)
 	return map->end;
 }
 
+static inline u64 map__pgoff(const struct map *map)
+{
+	return map->pgoff;
+}
+
+static inline u64 map__reloc(const struct map *map)
+{
+	return map->reloc;
+}
+
 static inline u32 map__flags(const struct map *map)
 {
 	return map->flags;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index bb44a3798df8..6e2110d605fb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -135,14 +135,14 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 	/* ref_reloc_sym is just a label. Need a special fix*/
 	reloc_sym = kernel_get_ref_reloc_sym(&map);
 	if (reloc_sym && strcmp(name, reloc_sym->name) == 0)
-		*addr = (!map->reloc || reloc) ? reloc_sym->addr :
+		*addr = (!map__reloc(map) || reloc) ? reloc_sym->addr :
 			reloc_sym->unrelocated_addr;
 	else {
 		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
 			return -ENOENT;
 		*addr = map__unmap_ip(map, sym->start) -
-			((reloc) ? 0 : map->reloc) -
+			((reloc) ? 0 : map__reloc(map)) -
 			((reladdr) ? map__start(map) : 0);
 	}
 	return 0;
@@ -400,7 +400,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
 					   pp->function);
 		} else
-			address = map__unmap_ip(map, sym->start) - map->reloc;
+			address = map__unmap_ip(map, sym->start) - map__reloc(map);
 		break;
 	}
 	if (!address) {
@@ -866,7 +866,7 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 			free(tevs[i].point.symbol);
 		tevs[i].point.symbol = tmp;
 		tevs[i].point.offset = tevs[i].point.address -
-			(map->reloc ? reloc_sym->unrelocated_addr :
+			(map__reloc(map) ? reloc_sym->unrelocated_addr :
 				      reloc_sym->addr);
 	}
 	return skipped;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5c075d77a792..7282119c2990 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -810,11 +810,11 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			continue;
 		}
 		curr_map_dso = map__dso(curr_map);
-		pos->start -= map__start(curr_map) - curr_map->pgoff;
+		pos->start -= map__start(curr_map) - map__pgoff(curr_map);
 		if (pos->end > map__end(curr_map))
 			pos->end = map__end(curr_map);
 		if (pos->end)
-			pos->end -= map__start(curr_map) - curr_map->pgoff;
+			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
 		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
 	}
@@ -1459,7 +1459,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		if (new_map == replacement_map) {
 			map->start	= map__start(new_map);
 			map->end	= map__end(new_map);
-			map->pgoff	= new_map->pgoff;
+			map->pgoff	= map__pgoff(new_map);
 			map->map_ip	= new_map->map_ip;
 			map->unmap_ip	= new_map->unmap_ip;
 			/* Ensure maps are correctly ordered */
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 538320e4260c..9565f9906e5d 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -62,19 +62,19 @@ static int __report_module(struct addr_location *al, u64 ip,
 		Dwarf_Addr s;
 
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s != map__start(al->map) - al->map->pgoff)
+		if (s != map__start(al->map) - map__pgoff(al->map))
 			mod = 0;
 	}
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
-				      map__start(al->map) - al->map->pgoff, false);
+				      map__start(al->map) - map__pgoff(al->map), false);
 	if (!mod) {
 		char filename[PATH_MAX];
 
 		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
 			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
-					      map__start(al->map) - al->map->pgoff, false);
+					      map__start(al->map) - map__pgoff(al->map), false);
 	}
 
 	if (mod) {
-- 
2.40.0.348.gf938b09366-goog

