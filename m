Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A403F6D6D79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjDDTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjDDTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:53:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26602134;
        Tue,  4 Apr 2023 12:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0A1637AD;
        Tue,  4 Apr 2023 19:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E7C433D2;
        Tue,  4 Apr 2023 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680637993;
        bh=09d8yU2orqxQBC3UmwiGu3trtnx5ka9Mhc2NEbv7Z7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBMSKcU5SQ3BDgpm5ESjVb0+EkS/bDPvmloCUkNMB0B9s+DBgTjQ3VMpT0o0U3wzN
         5muxNcJJG2DvsW7Ed6cGMygN9iQSP/LhMoT6mxQxIC+JIVVhEreNypxfOiY39oCHl+
         Zmto/L7/hsr2HcLTbccHEAc4sUblyfZ3cfXDfG4uOan1X+knbyH6injyL/w7zUrK3z
         gZur0OH9JTQDPusOgNI+BnStS9eciqjE19yJYFetwJwNkQamOdAq0JAqrFvyjTB/X9
         DsK3dMx1d8p18OUm50gNPU1qt3ZtqXm+QVibfwc/if0+oj2qV6rCeKz3cNvlTI8+XC
         3zf7LSScZ14vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6308A4052D; Tue,  4 Apr 2023 16:53:10 -0300 (-03)
Date:   Tue, 4 Apr 2023 16:53:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Message-ID: <ZCyAJiEGui9JmULO@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
 <ZCx5EyhgwZNWomfD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCx5EyhgwZNWomfD@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to:

perf map: Add accessor for start and end

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index ccfa87055c4a3b9d..566fb6c0eae737c6 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map__end(map) - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 46147a483049615d..90a7ef293ce76879 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map__end(map) - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index c9cb4b059392f6cf..32fffb593fbf0236 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map__end(map) - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index fe0e4530673c6661..b7223feec770dc33 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -262,7 +262,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 		return skip_slot;
 	}
 
-	rc = check_return_addr(dso, al.map->start, ip);
+	rc = check_return_addr(dso, map__start(al.map), ip);
 
 	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
 				dso->long_name, al.sym->name, ip, rc);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7852b97da10aa336..1cc6f338728f5499 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -903,7 +903,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		map->start = event->ksymbol.addr;
-		map->end = map__start(map) + event->ksymbol.len;
+		map__end(map) = map__start(map) + event->ksymbol.len;
 		err = maps__insert(machine__kernel_maps(machine), map);
 		map__put(map);
 		if (err)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 1fd57db7222678ad..21010a2b8e16cc2e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -339,7 +339,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			map__put(before);
 		}
 
-		if (map->end < map__end(pos->map)) {
+		if (map__end(map) < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 108f7b1697a73465..1c13f43e7d22c84c 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -327,9 +327,10 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 
 	maps__for_each_entry(ui->thread->maps, map_node) {
 		struct map *map = map_node->map;
+		u64 start = map__start(map);
 
-		if (map__dso(map) == dso && map->start < base_addr)
-			base_addr = map->start;
+		if (map__dso(map) == dso && start < base_addr)
+			base_addr = start;
 	}
 	base_addr -= dso->data.elf_base_addr;
 	/* Address of .eh_frame_hdr */
@@ -443,8 +444,8 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 	if (!read_unwind_spec_eh_frame(dso, ui, &table_data, &segbase, &fde_count)) {
 		memset(&di, 0, sizeof(di));
 		di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
-		di.start_ip = map->start;
-		di.end_ip   = map->end;
+		di.start_ip = map__start(map);
+		di.end_ip   = map__end(map);
 		di.u.rti.segbase    = segbase;
 		di.u.rti.table_data = table_data;
 		di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
@@ -459,7 +460,8 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 	    !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
 		int fd = dso__data_get_fd(dso, ui->machine);
 		int is_exec = elf_is_exec(fd, dso->name);
-		unw_word_t base = is_exec ? 0 : map->start;
+		u64 start = map__start(map);
+		unw_word_t base = is_exec ? 0 : start;
 		const char *symfile;
 
 		if (fd >= 0)
@@ -468,8 +470,7 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 		symfile = dso->symsrc_filename ?: dso->name;
 
 		memset(&di, 0, sizeof(di));
-		if (dwarf_find_debug_frame(0, &di, ip, base, symfile,
-					   map->start, map->end))
+		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
 			return dwarf_search_unwind_table(as, ip, &di, pi,
 							 need_unwind_info, arg);
 	}
