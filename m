Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796506C096B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCTDmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCTDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:41:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8C222F7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5425c04765dso109039937b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283626;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiouAZ40EdNQ9HzOWi9Q5cOqGSHkPPBEOvAUks0/VHE=;
        b=IX97UIGEBtiKRAgenEIk0ukW04xt+QkXaOyXR1ev1h2vlBMjRH4mWxH5AhmFSCBb6+
         Qsey9L5vqch4pWbOc6zUmEjSb5qWi1DediryZI4nA7LT7EIFl6tCefe9leeDjUgrJThg
         ytX5mzcbE/Mo5Iel6wUuU2mP+2tib4GBULzOJoFH/+xQM6dEEsdJTdxef2VlLhmgiXfg
         ese6LEKZliUC5aOM5lR/7aSwJYRsNg4Gvy8BT+0sNtJpazGVNPvht+AZ/MwuNyxLIfCB
         K89HW5mEfv0bTQ50DFfBwo//OCQR9ogC6aTvjT4rs516yFb8Q/6yvdAhgkO7tNP/pvqQ
         1v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283626;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiouAZ40EdNQ9HzOWi9Q5cOqGSHkPPBEOvAUks0/VHE=;
        b=BEmgo4iz3fEQ2oio6YaZe9YkxP16OU8U4kD1EoMrtDIg5oXoiZ4defh1yrhtp/f1yG
         3dxDf/IwuVbRho1SNpvVPBwZbY0Gk51INQbhFs/eJ33NGMiBmjmL/RbrPHCKSlswV0Am
         CfKUZXx0EnZgn2l7WqpOtWr+iwF/0N6h9rcR/J+pp1WmzGSrVKXHQWMnI2BZtxuxwHY+
         1u+NcjnBpcIV/rcnkXQYeREOlWy/r+2moBcPTQ4s7AXLHTaA3nqwDraotu6qXgz2IIc+
         +nRNOnSb7VLbUFSzW5y10JqYnFV8XjLFGCrpvys994A8tpW+5rHa4zyuTnTDWL0+umwZ
         iZzg==
X-Gm-Message-State: AO0yUKWDeIPPI5zrPOaqmFuQZdlOfQmA9mrJ/0wixj0JKWCKkY4yQKOO
        Hy7sFA6DAKFk/QWXIh8BMygTphuaSJ7U
X-Google-Smtp-Source: AK7set+sO8vskdeB+ZXyD/v777u22MCMnSTVUlT5666qVbud2c34Y+7qBMGQfXOswgfaY0AN8K7MSYy77B5f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a5b:d0f:0:b0:b17:e69b:b82a with SMTP id
 y15-20020a5b0d0f000000b00b17e69bb82amr3328018ybp.8.1679283625811; Sun, 19 Mar
 2023 20:40:25 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:02 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-15-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 14/22] perf map: Add accessors for pgoff and reloc
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
index b73c4bf0137e..0431c328f4d6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -805,11 +805,11 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
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
@@ -1455,7 +1455,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
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

