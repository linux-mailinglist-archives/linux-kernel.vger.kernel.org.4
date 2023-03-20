Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A466C239A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCTVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCTVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9552E82D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544539a729cso133234597b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347449;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2i4YJs4tQ6IQ1Hen18/XhJnk7dBepvgDbeMX7/u62cc=;
        b=N1FUGGEH8YTujfk8nF52/4f4t68rCeI9a6d+ravdornaJH/jz45w4CQZf9FkfZjJCK
         kVcg7U3vDoYJaGkCReZHrT8zaJCUUXIEjQSTne0jJu5sD525nM2QdRTUEdVgM/xGEafY
         r7div5iMnj0L2SnPfVKXg42Gyp6eeVRDO4L0dyXYxLIpebOmayxnNAEtlerh6RI5U/ec
         7VbI22HWjiQKHf0B4SFTIVrJ8HQnU2lDp3ZZ25eegOqYWrARj0+zW7GQBITTaECvnLtI
         qYFxTHG+PGO1k8jMRpF79uabMUeGqdpDYglsxwN4ZSKkpPwBGgh8yBZLe9hWORQEHqOa
         +AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347449;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2i4YJs4tQ6IQ1Hen18/XhJnk7dBepvgDbeMX7/u62cc=;
        b=p6BUWBYjh0g5cU23BArR8zHqu0u9sKOQXhXcOMZf7WxE6YCPsT+B82OLckLZ69gvPf
         3u3rfE4Uvq1WrXiqzNbJ48qFOtBvwWQlpcGfT6L8cYT8aw02SvTEF2uoUOvIsfQynV8/
         cOJydgtNIwBPRnFcpPBSdpKh9+Q84YJU4vjCJSGXADlce2L3fn0kgkU7TSR299uzpGLx
         OvfWka3F3UFiNxxzzO17/w+ArC4YMGwdjM8asu9iSBRv5dfKjUNuCzPzMzJqZfS9Z4GA
         S6ddS5ePJiIclkax9re3jvb9z4e7rMCdE0pll2eLg32+KcRo3Q3uxleq13jOsongobtF
         BTvw==
X-Gm-Message-State: AO0yUKXFofYm3z3Qs+EtM56k2eUwDEKCVYDwPFOvyPSqgJVoW+zmbvM8
        Uw/2ak7TrOy6+HSL7UmzF7lhgZq3fx2U
X-Google-Smtp-Source: AK7set9iHty3UpWHuzfDR/7IsSyMq15yKKzw6LM0HUS7yHyBvOYOE7kAXVXdLFYP4IN00jbOJvqepeVXh5w/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:a27:3ecc:ffe7 with SMTP
 id w2-20020a056902100200b00a273eccffe7mr6242921ybt.3.1679347448770; Mon, 20
 Mar 2023 14:24:08 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:40 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-10-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 09/17] perf map: Add accessors for pgoff and reloc
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
index 8650d9503b77..c7e4160f64ad 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -853,7 +853,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
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
index afb77bd161e2..916d98885128 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1276,9 +1276,9 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
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
index e3758519e4d1..ec7a312e7cc1 100644
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
@@ -1458,7 +1458,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		if (new_node->map == replacement_map) {
 			map->start	= map__start(new_node->map);
 			map->end	= map__end(new_node->map);
-			map->pgoff	= new_node->map->pgoff;
+			map->pgoff	= map__pgoff(new_node->map);
 			map->map_ip	= new_node->map->map_ip;
 			map->unmap_ip	= new_node->map->unmap_ip;
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
2.40.0.rc1.284.g88254d51c5-goog

