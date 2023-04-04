Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14D6D6E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjDDVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjDDVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38375583
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:00:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5461fe3163eso206513497b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642036;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqEAholP6s5JO6IAfeA8IAnwz80MVC9mCMC/N1UGzaI=;
        b=Pre1RT/RwUnsEu1Z88qVKp832+IMlAFDxrIai7mdO9rB/KmVvPZPA/2kGlwyaqDBgZ
         LxX3r6onTPTfyrBCZDyorNJXtbhr3cjaktQyoDDO4ljreDjRj9nuLWigTQHX3LafKQpB
         IxL/rLSh+Pq/xvkzikbXTqWXpeCpznK/Os+Qk+m5auzxdXLEEWXfAvwWIjP7aXofo9xM
         TAUkPybrvr8AmfEydRKVfdlpNwVmiaf7aiS7m0yXxcFN9uj1LlirV6zGWSue3diMs23X
         aJi59eAxw+n7CfcpHLO/7QlY/q4trn+1wlMeqOHOcUp4oUZyRRB2qSbniMzVRgHiRwaf
         /MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642036;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqEAholP6s5JO6IAfeA8IAnwz80MVC9mCMC/N1UGzaI=;
        b=iwQFNJ09GJh3tpOiVaeifWKxIENGKIy9PilAWhbfB/sGcSn5cW7SSqWcvD9axjbdwu
         X6OtYJpc7q2FAMThmVn5hpYtQ7ouZNWRvjYIHkT3GSy1QcZdLaA+ViOG0OkryOg/kze0
         notXJMmBe6s09ENGDnQZPCX0keWSukMcgtAkaHmmnX6NaFRhcyRVFN3boCFvzq/TpL54
         ws2kVsyBflfxrcWFbHntlzT3enasVA3AZOMn0tYzd1FU0NlBWKlVVyia35QobCv0reoM
         9Z9yZIY3C4samBonB1gKgHnaija/3rUX9KmHyZz/IAXuIRZ53LozdU7r/m43EE325yQT
         y7DQ==
X-Gm-Message-State: AAQBX9fG/Jv+jsElKEK/sqDr8WGE7ecKA5G55+axT2bnCLIhs3H6P/9l
        TThfY4pmOpdliWBn6oOstC35gdaRgxzZ
X-Google-Smtp-Source: AKy350YFGt9Kc+Pfi75dbGIQZ+oOZ2q1vWVyMjN1tPhk5H0Dle4y6QIbciQ0VGUnMuY5t4j/Ue+8Lq2wAvvh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a81:4513:0:b0:544:d5ce:eb33 with SMTP id
 s19-20020a814513000000b00544d5ceeb33mr2333239ywa.8.1680642036311; Tue, 04 Apr
 2023 14:00:36 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:44 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-3-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 02/12] perf map: Add helper for map_ip and unmap_ip
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

Later changes will add reference count checking for struct map, add a
helper function to invoke the map_ip and unmap_ip function
pointers. The helper allows the reference count check to be in fewer
places.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/s390/annotate/instructions.c     |  3 ++-
 tools/perf/builtin-kallsyms.c                    |  2 +-
 tools/perf/builtin-kmem.c                        |  2 +-
 tools/perf/builtin-lock.c                        |  4 ++--
 tools/perf/builtin-script.c                      |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c              | 10 +++++-----
 tools/perf/util/annotate.c                       | 16 +++++++++-------
 tools/perf/util/bpf_lock_contention.c            |  4 ++--
 tools/perf/util/dlfilter.c                       |  2 +-
 tools/perf/util/dso.c                            |  6 ++++--
 tools/perf/util/event.c                          |  8 ++++----
 tools/perf/util/evsel_fprintf.c                  |  2 +-
 tools/perf/util/intel-pt.c                       | 10 +++++-----
 tools/perf/util/machine.c                        | 16 ++++++++--------
 tools/perf/util/map.c                            | 10 +++++-----
 tools/perf/util/map.h                            | 10 ++++++++++
 tools/perf/util/maps.c                           |  8 ++++----
 tools/perf/util/probe-event.c                    |  8 ++++----
 .../util/scripting-engines/trace-event-python.c  |  2 +-
 tools/perf/util/sort.c                           | 12 ++++++------
 tools/perf/util/symbol.c                         |  4 ++--
 tools/perf/util/thread.c                         |  2 +-
 tools/perf/util/unwind-libdw.c                   |  2 +-
 tools/perf/util/unwind-libunwind-local.c         |  2 +-
 24 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 0e136630659e..6548933e8dc0 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -39,7 +39,8 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
+	    ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	return 0;
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 5638ca4dbd8e..3751df744577 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -39,7 +39,7 @@ static int __cmd_kallsyms(int argc, const char **argv)
 		dso = map__dso(map);
 		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
 			symbol->name, dso->short_name, dso->long_name,
-			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+			map__unmap_ip(map, symbol->start), map__unmap_ip(map, symbol->end),
 			symbol->start, symbol->end);
 	}
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 4d4b770a401c..fcd2ef3bd3f5 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1024,7 +1024,7 @@ static void __print_slab_result(struct rb_root *root,
 
 		if (sym != NULL)
 			snprintf(buf, sizeof(buf), "%s+%" PRIx64 "", sym->name,
-				 addr - map->unmap_ip(map, sym->start));
+				 addr - map__unmap_ip(map, sym->start));
 		else
 			snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
 		printf(" %-34s |", buf);
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 32ec58fb80e4..04345b2e7101 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -900,7 +900,7 @@ static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
 		return 0;
 	}
 
-	offset = map->map_ip(map, ip) - sym->start;
+	offset = map__map_ip(map, ip) - sym->start;
 
 	if (offset)
 		return scnprintf(buf, size, "%s+%#lx", sym->name, offset);
@@ -1070,7 +1070,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 				return -ENOMEM;
 			}
 
-			addrs[filters.nr_addrs++] = kmap->unmap_ip(kmap, sym->start);
+			addrs[filters.nr_addrs++] = map__unmap_ip(kmap, sym->start);
 			filters.addrs = addrs;
 		}
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index af0a69c7f41f..8fba247b798c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1088,7 +1088,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	/* Load maps to ensure dso->is_64_bit has been updated */
 	map__load(al.map);
 
-	offset = al.map->map_ip(al.map, start);
+	offset = map__map_ip(al.map, start);
 	len = dso__data_read_offset(dso, machine, offset, (u8 *)buffer,
 				    end - start + MAXINSN);
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 0a75623172c2..05a322ea3f9f 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -13,7 +13,7 @@
 #include "debug.h"
 #include "machine.h"
 
-#define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
+#define UM(x) map__unmap_ip(kallsyms_map, (x))
 
 static bool is_ignored_symbol(const char *name, char type)
 {
@@ -221,8 +221,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		if (sym->start == sym->end)
 			continue;
 
-		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
-		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
+		mem_start = map__unmap_ip(vmlinux_map, sym->start);
+		mem_end = map__unmap_ip(vmlinux_map, sym->end);
 
 		first_pair = machine__find_kernel_symbol(&kallsyms, mem_start, NULL);
 		pair = first_pair;
@@ -319,8 +319,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	maps__for_each_entry(maps, rb_node) {
 		struct map *pair, *map = rb_node->map;
 
-		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map__start(map));
-		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map__end(map));
+		mem_start = map__unmap_ip(vmlinux_map, map__start(map));
+		mem_end = map__unmap_ip(vmlinux_map, map__end(map));
 
 		pair = maps__find(kallsyms.kmaps, mem_start);
 		if (pair == NULL || pair->priv)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b9cff782d7df..36acdd1bd379 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -272,7 +272,8 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
+	    ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	return 0;
@@ -376,8 +377,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	}
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map->unmap_ip(map, sym->start),
-	end = map->unmap_ip(map, sym->end);
+	start = map__unmap_ip(map, sym->start);
+	end = map__unmap_ip(map, sym->end);
 
 	ops->target.outside = target.addr < start || target.addr > end;
 
@@ -400,7 +401,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * the symbol searching and disassembly should be done.
 	 */
 	if (maps__find_ams(ms->maps, &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) ==
+	    ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
 	if (!ops->target.outside) {
@@ -881,7 +883,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	unsigned offset;
 	struct sym_hist *h;
 
-	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, ms->map->unmap_ip(ms->map, addr));
+	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map__unmap_ip(ms->map, addr));
 
 	if ((addr < sym->start || addr >= sym->end) &&
 	    (addr != sym->end || sym->start != sym->end)) {
@@ -1977,8 +1979,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		return err;
 
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
-		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
-		 map->unmap_ip(map, sym->end));
+		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
+		 map__unmap_ip(map, sym->end));
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
 		 dso, dso->long_name, sym, sym->name);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 8a5d0eb44189..2b3bc544aa3e 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -74,7 +74,7 @@ int lock_contention_prepare(struct lock_contention *con)
 				continue;
 			}
 
-			addrs[con->filters->nr_addrs++] = kmap->unmap_ip(kmap, sym->start);
+			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, sym->start);
 			con->filters->addrs = addrs;
 		}
 		naddrs = con->filters->nr_addrs;
@@ -233,7 +233,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	if (sym) {
 		unsigned long offset;
 
-		offset = kmap->map_ip(kmap, addr) - sym->start;
+		offset = map__map_ip(kmap, addr) - sym->start;
 
 		if (offset == 0)
 			return sym->name;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index fe401fa4be02..16238f823a5e 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -278,7 +278,7 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 
 	map = a.map;
 have_map:
-	offset = map->map_ip(map, ip);
+	offset = map__map_ip(map, ip);
 	if (ip + len >= map__end(map))
 		len = map__end(map) - ip;
 	return dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f1a14c0ad26d..e36b418df2c6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1122,7 +1122,8 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size)
 {
-	u64 offset = map->map_ip(map, addr);
+	u64 offset = map__map_ip(map, addr);
+
 	return dso__data_read_offset(dso, machine, offset, data, size);
 }
 
@@ -1162,7 +1163,8 @@ ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
 				   struct machine *machine, u64 addr,
 				   const u8 *data, ssize_t size)
 {
-	u64 offset = map->map_ip(map, addr);
+	u64 offset = map__map_ip(map, addr);
+
 	return dso__data_write_cache_offs(dso, machine, offset, data, size);
 }
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2ddc75dee019..2712d1a8264e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -487,7 +487,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 
 		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
 		if (al.map && map__load(al.map) >= 0) {
-			al.addr = al.map->map_ip(al.map, tp->addr);
+			al.addr = map__map_ip(al.map, tp->addr);
 			al.sym = map__find_symbol(al.map, al.addr);
 			if (al.sym)
 				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
@@ -622,7 +622,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		 */
 		if (load_map)
 			map__load(al->map);
-		al->addr = al->map->map_ip(al->map, al->addr);
+		al->addr = map__map_ip(al->map, al->addr);
 	}
 
 	return al->map;
@@ -743,12 +743,12 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		}
 		if (!ret && al->sym) {
 			snprintf(al_addr_str, sz, "0x%"PRIx64,
-				al->map->unmap_ip(al->map, al->sym->start));
+				 map__unmap_ip(al->map, al->sym->start));
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al_addr_str);
 		}
 		if (!ret && symbol_conf.addr_list && al->map) {
-			unsigned long addr = al->map->unmap_ip(al->map, al->addr);
+			unsigned long addr = map__unmap_ip(al->map, al->addr);
 
 			ret = intlist__has_entry(symbol_conf.addr_list, addr);
 			if (!ret && symbol_conf.addr_range) {
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index dff5d8c4b06d..a09ac00810b7 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -151,7 +151,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				printed += fprintf(fp, " <-");
 
 			if (map)
-				addr = map->map_ip(map, node->ip);
+				addr = map__map_ip(map, node->ip);
 
 			if (print_ip) {
 				/* Show binary offset for userspace addr */
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a2e62daa708e..fe893c9bab3f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -816,7 +816,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 			return -ENOENT;
 
-		offset = al.map->map_ip(al.map, *ip);
+		offset = map__map_ip(al.map, *ip);
 
 		if (!to_ip && one_map) {
 			struct intel_pt_cache_entry *e;
@@ -987,7 +987,7 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
 		return -EINVAL;
 
-	offset = al.map->map_ip(al.map, ip);
+	offset = map__map_ip(al.map, ip);
 
 	return intel_pt_match_pgd_ip(ptq->pt, ip, offset, map__dso(al.map)->long_name);
 }
@@ -2749,7 +2749,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (sym->binding == STB_GLOBAL &&
 		    !strcmp(sym->name, "__switch_to")) {
-			ip = map->unmap_ip(map, sym->start);
+			ip = map__unmap_ip(map, sym->start);
 			if (ip >= map__start(map) && ip < map__end(map)) {
 				switch_ip = ip;
 				break;
@@ -2767,7 +2767,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (!strcmp(sym->name, ptss)) {
-			ip = map->unmap_ip(map, sym->start);
+			ip = map__unmap_ip(map, sym->start);
 			if (ip >= map__start(map) && ip < map__end(map)) {
 				*ptss_ip = ip;
 				break;
@@ -3393,7 +3393,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 		if (!dso || !dso->auxtrace_cache)
 			continue;
 
-		offset = al.map->map_ip(al.map, addr);
+		offset = map__map_ip(al.map, addr);
 
 		e = intel_pt_cache_lookup(dso, machine, offset);
 		if (!e)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9d24980a0a93..d29ec4a04488 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -919,7 +919,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		dso = map__dso(map);
 	}
 
-	sym = symbol__new(map->map_ip(map, map__start(map)),
+	sym = symbol__new(map__map_ip(map, map__start(map)),
 			  event->ksymbol.len,
 			  0, 0, event->ksymbol.name);
 	if (!sym)
@@ -944,7 +944,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	else {
 		struct dso *dso = map__dso(map);
 
-		sym = dso__find_symbol(dso, map->map_ip(map, map__start(map)));
+		sym = dso__find_symbol(dso, map__map_ip(map, map__start(map)));
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
@@ -1279,7 +1279,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 
 		dest_map = maps__find(kmaps, map->pgoff);
 		if (dest_map != map)
-			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
+			map->pgoff = map__map_ip(dest_map, map->pgoff);
 		found = true;
 	}
 	if (found || machine->trampolines_mapped)
@@ -3345,7 +3345,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 		return NULL;
 
 	*modp = __map__is_kmodule(map) ? (char *)map__dso(map)->short_name : NULL;
-	*addrp = map->unmap_ip(map, sym->start);
+	*addrp = map__unmap_ip(map, sym->start);
 	return sym->name;
 }
 
@@ -3388,17 +3388,17 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 			return false;
 		}
 
-		machine->sched.text_start = kmap->unmap_ip(kmap, sym->start);
+		machine->sched.text_start = map__unmap_ip(kmap, sym->start);
 
 		/* should not fail from here */
 		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
-		machine->sched.text_end = kmap->unmap_ip(kmap, sym->start);
+		machine->sched.text_end = map__unmap_ip(kmap, sym->start);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
-		machine->lock.text_start = kmap->unmap_ip(kmap, sym->start);
+		machine->lock.text_start = map__unmap_ip(kmap, sym->start);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
-		machine->lock.text_end = kmap->unmap_ip(kmap, sym->start);
+		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
 	}
 
 	/* failed to get kernel symbols */
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d97a6d20626f..816bffbbf344 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -519,7 +519,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 	if (dso->kernel == DSO_SPACE__USER)
 		return rip + dso->text_offset;
 
-	return map->unmap_ip(map, rip) - map->reloc;
+	return map__unmap_ip(map, rip) - map->reloc;
 }
 
 /**
@@ -539,24 +539,24 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	const struct dso *dso = map__dso(map);
 
 	if (!dso->adjust_symbols)
-		return map->unmap_ip(map, ip);
+		return map__unmap_ip(map, ip);
 
 	if (dso->rel)
-		return map->unmap_ip(map, ip + map->pgoff);
+		return map__unmap_ip(map, ip + map->pgoff);
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
 	 * but all kernel modules are ET_REL, so won't get here.
 	 */
 	if (dso->kernel == DSO_SPACE__USER)
-		return map->unmap_ip(map, ip - dso->text_offset);
+		return map__unmap_ip(map, ip - dso->text_offset);
 
 	return ip + map->reloc;
 }
 
 bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
-	u64 ip = map->unmap_ip(map, sym->start);
+	u64 ip = map__unmap_ip(map, sym->start);
 
 	return ip >= map__start(map) && ip < map__end(map);
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9b0a84e46e48..9118eba71032 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -52,6 +52,16 @@ static inline struct dso *map__dso(const struct map *map)
 	return map->dso;
 }
 
+static inline u64 map__map_ip(const struct map *map, u64 ip)
+{
+	return map->map_ip(map, ip);
+}
+
+static inline u64 map__unmap_ip(const struct map *map, u64 ip)
+{
+	return map->unmap_ip(map, ip);
+}
+
 static inline u64 map__start(const struct map *map)
 {
 	return map->start;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 21010a2b8e16..0eee27e24c33 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -194,7 +194,7 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	if (map != NULL && map__load(map) >= 0) {
 		if (mapp != NULL)
 			*mapp = map;
-		return map__find_symbol(map, map->map_ip(map, addr));
+		return map__find_symbol(map, map__map_ip(map, addr));
 	}
 
 	return NULL;
@@ -237,7 +237,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 			return -1;
 	}
 
-	ams->al_addr = ams->ms.map->map_ip(ams->ms.map, ams->addr);
+	ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
 	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
 
 	return ams->ms.sym ? 0 : -1;
@@ -349,8 +349,8 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 			after->start = map__end(map);
 			after->pgoff += map__end(map) - map__start(pos->map);
-			assert(pos->map->map_ip(pos->map, map__end(map)) ==
-				after->map_ip(after, map__end(map)));
+			assert(map__map_ip(pos->map, map__end(map)) ==
+				map__map_ip(after, map__end(map)));
 			err = __maps__insert(maps, after);
 			if (err)
 				goto put_map;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 4d9dbeeb6014..bb44a3798df8 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -141,7 +141,7 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
 			return -ENOENT;
-		*addr = map->unmap_ip(map, sym->start) -
+		*addr = map__unmap_ip(map, sym->start) -
 			((reloc) ? 0 : map->reloc) -
 			((reladdr) ? map__start(map) : 0);
 	}
@@ -400,7 +400,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
 					   pp->function);
 		} else
-			address = map->unmap_ip(map, sym->start) - map->reloc;
+			address = map__unmap_ip(map, sym->start) - map->reloc;
 		break;
 	}
 	if (!address) {
@@ -2249,7 +2249,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 		goto out;
 
 	pp->retprobe = tp->retprobe;
-	pp->offset = addr - map->unmap_ip(map, sym->start);
+	pp->offset = addr - map__unmap_ip(map, sym->start);
 	pp->function = strdup(sym->name);
 	ret = pp->function ? 0 : -ENOMEM;
 
@@ -3123,7 +3123,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 			goto err_out;
 		}
 		/* Add one probe point */
-		tp->address = map->unmap_ip(map, sym->start) + pp->offset;
+		tp->address = map__unmap_ip(map, sym->start) + pp->offset;
 
 		/* Check the kprobe (not in module) is within .text  */
 		if (!pev->uprobes && !pev->target &&
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index cbf09eaf3734..41d4f9e6a8b7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -471,7 +471,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 				struct addr_location node_al;
 				unsigned long offset;
 
-				node_al.addr = map->map_ip(map, node->ip);
+				node_al.addr = map__map_ip(map, node->ip);
 				node_al.map  = map;
 				offset = get_offset(node->ms.sym, &node_al);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f161589aefda..87a3ba584af5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -364,7 +364,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 		u64 rip = ip;
 
 		if (dso && dso->kernel && dso->adjust_symbols)
-			rip = map->unmap_ip(map, ip);
+			rip = map__unmap_ip(map, ip);
 
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
 				       BITS_PER_LONG / 4 + 2, rip, o);
@@ -375,7 +375,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 		if (sym->type == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
-					ip - map->unmap_ip(map, sym->start));
+					ip - map__unmap_ip(map, sym->start));
 		} else {
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
@@ -1147,7 +1147,7 @@ static int _hist_entry__addr_snprintf(struct map_symbol *ms,
 		if (sym->type == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
-					ip - map->unmap_ip(map, sym->start));
+					ip - map__unmap_ip(map, sym->start));
 		} else {
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
@@ -2104,9 +2104,9 @@ sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
 	struct map *right_map = right->ms.map;
 
 	if (left_map)
-		left_ip = left_map->unmap_ip(left_map, left_ip);
+		left_ip = map__unmap_ip(left_map, left_ip);
 	if (right_map)
-		right_ip = right_map->unmap_ip(right_map, right_ip);
+		right_ip = map__unmap_ip(right_map, right_ip);
 
 	return _sort__addr_cmp(left_ip, right_ip);
 }
@@ -2118,7 +2118,7 @@ static int hist_entry__addr_snprintf(struct hist_entry *he, char *bf,
 	struct map *map = he->ms.map;
 
 	if (map)
-		ip = map->unmap_ip(map, ip);
+		ip = map__unmap_ip(map, ip);
 
 	return repsep_snprintf(bf, size, "%-#*llx", width, ip);
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b91deb177091..9ba49c1ef6ef 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -896,8 +896,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 * So that we look just like we get from .ko files,
 			 * i.e. not prelinked, relative to initial_map->start.
 			 */
-			pos->start = curr_map->map_ip(curr_map, pos->start);
-			pos->end   = curr_map->map_ip(curr_map, pos->end);
+			pos->start = map__map_ip(curr_map, pos->start);
+			pos->end   = map__map_ip(curr_map, pos->end);
 		} else if (x86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index bb7a2ce82d46..4b5bdc277baa 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -464,7 +464,7 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 	if( !dso || dso->data.status == DSO_DATA_STATUS_ERROR || map__load(al.map) < 0)
 		return -1;
 
-	offset = al.map->map_ip(al.map, ip);
+	offset = map__map_ip(al.map, ip);
 	if (is64bit)
 		*is64bit = dso->is_64_bit;
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index b79f57e5648f..538320e4260c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -115,7 +115,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
 		 ip,
-		 al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
+		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
 	return 0;
 }
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 1c13f43e7d22..f9a52af48de4 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -640,7 +640,7 @@ static int entry(u64 ip, struct thread *thread,
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
 		 ip,
-		 al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
+		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
 
 	return cb(&e, arg);
 }
-- 
2.40.0.348.gf938b09366-goog

