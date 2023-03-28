Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6936CCE56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC1X5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjC1X46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377073591
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b714602d43fso13833350ybb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047795;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLwl6lqshUJrYpudRLUNg3JmQvCjYB/FLO+tQsQQJpQ=;
        b=XnvygogEgzonzrrSq9l6TzoXcbOQmCY53hMyUXr621BGx6mEB14SMpXAG4EzOBf88G
         1Q8vwVBihtpmg7wfXXvAGVMXO9LhOhg4YYhfTLGW7/DrAwn9TFoB8iGDtOwho0wLSyWG
         F7yDuRQxYYjB8HmVV2pHPVb8r5NTYghs4EyJ0hUFs+vDfGzajtqMJb4mHJ6yDKFnSOxR
         F7BexECaHBoyyGLIB5oXRdt784Sh3aoLb1CoOnu34QtXXEQakpm9XseP4hw7WFxFcsG3
         sw85tr+RwZgAH1IkVWuJctw3LAfRIKzcUNfPX+2uOig5U2nvI3gSnQTVBsQH0m2opRAg
         o1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047795;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLwl6lqshUJrYpudRLUNg3JmQvCjYB/FLO+tQsQQJpQ=;
        b=2v3pCftvqpas1cY7C5Fg/Yusq8KEpE+R4UYCWG5SKZKhcnZfxKFUwlCuVx21Z0frFd
         1OqpRWjWWgzRZQHK8lTkJEPAzIMLgP54qyIgk3UFIK87IRnpCdHgFfcNrrUBW/lOGPdY
         pMstXpfjrjcbtRvOyvXRyAn7h9YeQJaOCHyKlmjSExOjgL0BdqjmpS++nFh3NZYLRWiG
         gaVDwwWRlo5LgtjFnAOmmSX8ND0pw5OIT2aLUS5St1fOS/wjvRi+RxGyWJlVwwHo1px+
         92CBckyFuF9lxRIKJuT7csNJ6nSFauj94tNobUl7RyuN29zoI9HDk/RNwvfdZTQgAxsd
         FJOA==
X-Gm-Message-State: AAQBX9dDqvexYSZHlH18SlIKKlPOnOHJGCYNvjU8DCmgalm+lWckNW7D
        djd/lfzVw8CtFARdMlSkpvNhLcypyKjV
X-Google-Smtp-Source: AKy350bAcDR00breSQ4TUpY8mhI99EKXmR4Gbx3YKucZJfbextj5+Qrrnc7kQwofHP6QfllYpfWO9w7l7kfy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a81:b647:0:b0:541:a17f:c779 with SMTP id
 h7-20020a81b647000000b00541a17fc779mr8460207ywk.4.1680047795353; Tue, 28 Mar
 2023 16:56:35 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:41 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-5-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 4/6] perf annotate: Own objdump_path and disassembler_style strings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

Make struct annotation_options own the strings objdump_path and
disassembler_style, freeing them on exit. Add missing strdup for
disassembler_style when read from a config file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c      |  4 ++--
 tools/perf/arch/common.h      |  2 +-
 tools/perf/builtin-annotate.c | 16 ++++++++++++++--
 tools/perf/builtin-report.c   | 16 ++++++++++++++--
 tools/perf/builtin-top.c      | 17 +++++++++++++++--
 tools/perf/util/annotate.c    | 10 ++++++++--
 tools/perf/util/annotate.h    |  4 ++--
 7 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 59dd875fd5e4..28ac09997928 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -130,7 +130,7 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 }
 
 static int perf_env__lookup_binutils_path(struct perf_env *env,
-					  const char *name, const char **path)
+					  const char *name, char **path)
 {
 	int idx;
 	const char *arch = perf_env__arch(env), *cross_env;
@@ -202,7 +202,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	return -1;
 }
 
-int perf_env__lookup_objdump(struct perf_env *env, const char **path)
+int perf_env__lookup_objdump(struct perf_env *env, char **path)
 {
 	/*
 	 * For live mode, env->arch will be NULL and we can use
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index e965ed8bb328..4224c299cc70 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -6,7 +6,7 @@
 
 struct perf_env;
 
-int perf_env__lookup_objdump(struct perf_env *env, const char **path);
+int perf_env__lookup_objdump(struct perf_env *env, char **path);
 bool perf_env__single_address_space(struct perf_env *env);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 0ceb41f16663..d781639b644f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -516,6 +516,7 @@ int cmd_annotate(int argc, const char **argv)
 	struct itrace_synth_opts itrace_synth_opts = {
 		.set = 0,
 	};
+	const char *disassembler_style = NULL, *objdump_path = NULL;
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -560,13 +561,13 @@ int cmd_annotate(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "prefix", &annotate.opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate.opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
+	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Enable symbol demangling"),
@@ -617,6 +618,17 @@ int cmd_annotate(int argc, const char **argv)
 		annotate.sym_hist_filter = argv[0];
 	}
 
+	if (disassembler_style) {
+		annotate.opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate.opts.disassembler_style)
+			return -ENOMEM;
+	}
+	if (objdump_path) {
+		annotate.opts.objdump_path = strdup(objdump_path);
+		if (!annotate.opts.objdump_path)
+			return -ENOMEM;
+	}
+
 	if (annotate_check_args(&annotate.opts) < 0)
 		return -EINVAL;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b41e1219d153..15b0cf649e1a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1226,6 +1226,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	char *sort_order_help = sort_help("sort by key(s):");
 	char *field_order_help = sort_help("output field(s): overhead period sample ");
+	const char *disassembler_style = NULL, *objdump_path = NULL;
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -1322,7 +1323,7 @@ int cmd_report(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &report.annotation_opts.disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "prefix", &report.annotation_opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
@@ -1341,7 +1342,7 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_STRING(0, "objdump", &report.annotation_opts.objdump_path, "path",
+	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Disable symbol demangling"),
@@ -1419,6 +1420,17 @@ int cmd_report(int argc, const char **argv)
 		report.symbol_filter_str = argv[0];
 	}
 
+	if (disassembler_style) {
+		report.annotation_opts.disassembler_style = strdup(disassembler_style);
+		if (!report.annotation_opts.disassembler_style)
+			return -ENOMEM;
+	}
+	if (objdump_path) {
+		report.annotation_opts.objdump_path = strdup(objdump_path);
+		if (!report.annotation_opts.objdump_path)
+			return -ENOMEM;
+	}
+
 	if (annotate_check_args(&report.annotation_opts) < 0) {
 		ret = -EINVAL;
 		goto exit;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 592eb827fba9..57a273cd03de 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1439,6 +1439,7 @@ int cmd_top(int argc, const char **argv)
 	};
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
+	const char *disassembler_style = NULL, *objdump_path = NULL;
 	const struct option options[] = {
 	OPT_CALLBACK('e', "event", &top.evlist, "event",
 		     "event selector. use 'perf list' to list available events",
@@ -1524,9 +1525,9 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "no-bpf-event", &top.record_opts.no_bpf_event, "do not record bpf events"),
-	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
+	OPT_STRING(0, "objdump", &objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
-	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "prefix", &top.annotation_opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
@@ -1618,6 +1619,18 @@ int cmd_top(int argc, const char **argv)
 	if (argc)
 		usage_with_options(top_usage, options);
 
+	if (disassembler_style) {
+		top.annotation_opts.disassembler_style = strdup(disassembler_style);
+		if (!top.annotation_opts.disassembler_style)
+			return -ENOMEM;
+	}
+	if (objdump_path) {
+		top.annotation_opts.objdump_path = strdup(objdump_path);
+		if (!top.annotation_opts.objdump_path)
+			return -ENOMEM;
+	}
+
+
 	status = symbol__validate_sym_arguments();
 	if (status)
 		goto out_delete_evlist;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a984bdae7811..7338249dfdd9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3206,7 +3206,11 @@ static int annotation__config(const char *var, const char *value, void *data)
 	} else if (!strcmp(var, "annotate.use_offset")) {
 		opt->use_offset = perf_config_bool("use_offset", value);
 	} else if (!strcmp(var, "annotate.disassembler_style")) {
-		opt->disassembler_style = value;
+		opt->disassembler_style = strdup(value);
+		if (!opt->disassembler_style) {
+			pr_err("Not enough memory for annotate.disassembler_style\n");
+			return -1;
+		}
 	} else if (!strcmp(var, "annotate.demangle")) {
 		symbol_conf.demangle = perf_config_bool("demangle", value);
 	} else if (!strcmp(var, "annotate.demangle_kernel")) {
@@ -3231,8 +3235,10 @@ void annotation_options__init(struct annotation_options *opt)
 }
 
 
-void annotation_options__exit(struct annotation_options *opt __maybe_unused)
+void annotation_options__exit(struct annotation_options *opt)
 {
+	free(opt->disassembler_style);
+	free(opt->objdump_path);
 }
 
 void annotation_config__init(struct annotation_options *opt)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e7238c694465..1c6335b8333a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -94,8 +94,8 @@ struct annotation_options {
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
-	const char *objdump_path;
-	const char *disassembler_style;
+	char *objdump_path;
+	char *disassembler_style;
 	const char *prefix;
 	const char *prefix_strip;
 	unsigned int percent_type;
-- 
2.40.0.348.gf938b09366-goog

