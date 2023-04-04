Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D36D6D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjDDTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDDTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B81BC;
        Tue,  4 Apr 2023 12:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84ECA63909;
        Tue,  4 Apr 2023 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84365C433EF;
        Tue,  4 Apr 2023 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680636181;
        bh=BDA0BXthgaRe2Q0dikER4WlJack9+LTyGvCkahUOjd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5sQVitpvdfgcbFhyMC6whPbkHEtdAdP+SLmCqAlGhmBZ3mfJRsUXadZxQsFyd6iB
         d/GQWtI0QkXgwa4lBOtUBZtPcMF4l2VQO0O+jhCGLeav5Hb4YzwDBHYaIJpXxkACHF
         V94bpSgSm/43x8g9pNzYQW6Q1ImrOnLiFv/zIlmZfWJ/ufLJAP3eQpaNBNEhXpQnMQ
         0vNcgYI8AES17cLe32sNkunvv5+XDKDBqhHMLEBg6EYdLk4+Rc+SKDXDq1wR03VHME
         gZpsmCxBuBxjxDZmyFQJ8LCSYBfO0wgDuhg8uIk0JR5sopS9b4z8DdJNWLcfwnxOu9
         DthpYBlCDS8rA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 150C44052D; Tue,  4 Apr 2023 16:22:59 -0300 (-03)
Date:   Tue, 4 Apr 2023 16:22:59 -0300
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
Message-ID: <ZCx5EyhgwZNWomfD@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to:

perf map: Add accessor for dso


diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 20cd6244863b1a09..fe0e4530673c6661 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -255,7 +255,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
 	if (al.map)
-		dso = al.map->dso;
+		dso = map__dso(al.map);
 
 	if (!dso) {
 		pr_debug("%" PRIx64 " dso is NULL\n", ip);
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 0856b32f9e08a1f5..9f99fc88dbff9056 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -104,7 +104,7 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
 
-	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
+	if (map__dso(map)->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
 		tev->point.offset += PPC64LE_LEP_OFFSET;
 	else if (lep_offset) {
 		if (pev->uprobes)
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index a1c021a6d3c1f0f1..2effac77ca8c6742 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -165,6 +165,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 				struct annotation_options *options,
 				struct hist_browser_timer *hbt)
 {
+	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	GtkWidget *window;
 	GtkWidget *notebook;
@@ -172,13 +173,13 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	GtkWidget *tab_label;
 	int err;
 
-	if (ms->map->dso->annotate_warned)
+	if (dso->annotate_warned)
 		return -1;
 
 	err = symbol__annotate(ms, evsel, options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
-		ms->map->dso->annotate_warned = true;
+		dso->annotate_warned = true;
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s: %s\n", sym->name, msg);
 		return -1;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 94e2d02009eb9f72..528a7fb066cfc9ec 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -865,6 +865,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	struct thread *thread;
 	struct machine *machine;
 	struct addr_location al;
+	struct dso *dso;
 	struct cs_etm_traceid_queue *tidq;
 
 	if (!etmq)
@@ -883,27 +884,29 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		thread = etmq->etm->unknown_thread;
 	}
 
-	if (!thread__find_map(thread, cpumode, address, &al) || !al.map->dso)
+	dso = map__dso(al.map);
+
+	if (!thread__find_map(thread, cpumode, address, &al) || !dso)
 		return 0;
 
-	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
-	    dso__data_status_seen(al.map->dso, DSO_DATA_STATUS_SEEN_ITRACE))
+	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+	    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 		return 0;
 
 	offset = al.map->map_ip(al.map, address);
 
 	map__load(al.map);
 
-	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
+	len = dso__data_read_offset(dso, machine, offset, buffer, size);
 
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
 				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
-		if (!al.map->dso->auxtrace_warned) {
+		if (!dso->auxtrace_warned) {
 			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
 				    address,
-				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
-			al.map->dso->auxtrace_warned = true;
+				    dso->long_name ? dso->long_name : "Unknown");
+			dso->auxtrace_warned = true;
 		}
 		return 0;
 	}
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index c487a249b33c62d4..108f7b1697a73465 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -328,7 +328,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 	maps__for_each_entry(ui->thread->maps, map_node) {
 		struct map *map = map_node->map;
 
-		if (map->dso == dso && map->start < base_addr)
+		if (map__dso(map) == dso && map->start < base_addr)
 			base_addr = map->start;
 	}
 	base_addr -= dso->data.elf_base_addr;
@@ -424,19 +424,23 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 {
 	struct unwind_info *ui = arg;
 	struct map *map;
+	struct dso *dso;
 	unw_dyn_info_t di;
 	u64 table_data, segbase, fde_count;
 	int ret = -EINVAL;
 
 	map = find_map(ip, ui);
-	if (!map || !map->dso)
+	if (!map)
 		return -EINVAL;
 
-	pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
+	dso = map__dso(map);
+	if (!dso)
+		return -EINVAL;
+
+	pr_debug("unwind: find_proc_info dso %s\n", dso->name);
 
 	/* Check the .eh_frame section for unwinding info */
-	if (!read_unwind_spec_eh_frame(map->dso, ui,
-				       &table_data, &segbase, &fde_count)) {
+	if (!read_unwind_spec_eh_frame(dso, ui, &table_data, &segbase, &fde_count)) {
 		memset(&di, 0, sizeof(di));
 		di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
 		di.start_ip = map->start;
@@ -452,16 +456,16 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 #ifndef NO_LIBUNWIND_DEBUG_FRAME
 	/* Check the .debug_frame section for unwinding info */
 	if (ret < 0 &&
-	    !read_unwind_spec_debug_frame(map->dso, ui->machine, &segbase)) {
-		int fd = dso__data_get_fd(map->dso, ui->machine);
-		int is_exec = elf_is_exec(fd, map->dso->name);
+	    !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
+		int fd = dso__data_get_fd(dso, ui->machine);
+		int is_exec = elf_is_exec(fd, dso->name);
 		unw_word_t base = is_exec ? 0 : map->start;
 		const char *symfile;
 
 		if (fd >= 0)
-			dso__data_put_fd(map->dso);
+			dso__data_put_fd(dso);
 
-		symfile = map->dso->symsrc_filename ?: map->dso->name;
+		symfile = dso->symsrc_filename ?: dso->name;
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile,
@@ -513,6 +517,7 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 			  unw_word_t *data)
 {
 	struct map *map;
+	struct dso *dso;
 	ssize_t size;
 
 	map = find_map(addr, ui);
@@ -521,10 +526,12 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 		return -1;
 	}
 
-	if (!map->dso)
+	dso = map__dso(map);
+
+	if (!dso)
 		return -1;
 
-	size = dso__data_read_addr(map->dso, map, ui->machine,
+	size = dso__data_read_addr(dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
 
 	return !(size == sizeof(*data));
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 42528ade513e4975..4378daaafcd3b875 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -22,6 +22,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 	const char *arch;
 	enum dso_type dso_type;
 	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
+	struct dso *dso = map__dso(map);
 	struct machine *machine;
 	int err;
 
@@ -29,8 +30,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		return 0;
 
 	if (maps__addr_space(maps)) {
-		pr_debug("unwind: thread map already set, dso=%s\n",
-			 map->dso->name);
+		pr_debug("unwind: thread map already set, dso=%s\n", dso->name);
 		if (initialized)
 			*initialized = true;
 		return 0;
@@ -41,7 +41,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 	if (!machine->env || !machine->env->arch)
 		goto out_register;
 
-	dso_type = dso__type(map->dso, machine);
+	dso_type = dso__type(dso, machine);
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
