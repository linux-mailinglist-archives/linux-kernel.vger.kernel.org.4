Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1E6CCE60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC1X5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjC1X5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:57:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77A3C20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54476ef9caeso136332697b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDSsTwYxjnBxXL6ZIXaxMuMGjJVcQd1t2sonbT61qik=;
        b=tThQWf8o7mRKmLU99+Ys5G/hVG6Iaa7NDOQLCLqAGn8IfHeEaE11bpjPdJS7YsIfkU
         CLMiMvT2BDI9uvuHq3azBFNQnfXxHPh4D4Y3/wUsJS6GV/NX1i6fquhAtPd5fhd+mik+
         UzCL0oAPwDe0mPgJh8j1vCarXeKr5B3V4mc4mc+DZ6uKTibz6f4kl18DVM6ZM1bdJA0D
         XFe2O94KaSatm7cP1HwWSbiyqt1ex9ukllKv8kbOJ4T4g+mh6W2+NFv2+hrgWMMEtoIL
         RiOiq2d8sN9dk6njWW4ARKk6MzYuSekvPOqhOlpIkLhwDF9sTohFuTMI8ZbZvLatvZ4u
         t+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDSsTwYxjnBxXL6ZIXaxMuMGjJVcQd1t2sonbT61qik=;
        b=VMvkbPhg+0vy/kizNdlLu66eqXJoMxQegL0lEcF3z0i6J+FzzotgSVIrPJTrXEVqul
         Bt2ELQoYNdWJZQm9dhJ51e/FpXWoLnVZqjL7bEjCsxyQBDy5jgl4Oq3g6++U0APArDyB
         N/C1gika5vSuzftCWzuSdErOoRhaMSPGuxHbhdD3MwucgWuLXMdIUG9Sm4Y3s4sYRn9D
         YxkCYoFBoFZc0l3asVw4PaA+tZKbwzNW7l6o4ffn+hOjQQ9o6uoJxUa5seiePF1SLsVB
         ynjiMVCoIrbCr4t0MMnutI1hydmHfuG7jJiv2+js48c3wymqWh28M+q31fYCC2AqFkR4
         IxJA==
X-Gm-Message-State: AAQBX9cDTSuqKN+AertpL1rAOFb1kewf5toc19bAUcpJ78QcGKibpqpo
        8f6I/SR2pCeSXrY/g4Rr9vJ0PPaw+CmQ
X-Google-Smtp-Source: AKy350bYz2fZS10JwFEhD+dS2mleic5+6OtWAf1qE64PpR5ZyQ91NbiL9aiv3PLYfWuM+xr1e6CSOBj5tdXO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr11707003ybt.6.1680047810713; Tue, 28
 Mar 2023 16:56:50 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:43 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-7-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 6/6] perf symbol: Add command line support for addr2line path
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

Allow addr2line to be set either on the command line or via the
perfconfig file. This doesn't currently work with llvm-addr2line as
the addr2line code emits two things:
1) the address to decode,
2) a bogus ',' value.
The expectation is the bogus value will generate:
??
??:0
that terminates the addr2line reading. However, the output from
llvm-addr2line is a single line with just the input ',' locking up the
addr2line reading that is expecting a second line.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-annotate.txt |  3 +++
 tools/perf/Documentation/perf-config.txt   |  3 +++
 tools/perf/Documentation/perf-report.txt   |  3 +++
 tools/perf/Documentation/perf-top.txt      |  6 +++++
 tools/perf/builtin-annotate.c              |  9 +++++++-
 tools/perf/builtin-report.c                |  9 +++++++-
 tools/perf/builtin-top.c                   | 10 +++++++--
 tools/perf/util/annotate.c                 |  6 +++++
 tools/perf/util/srcline.c                  | 26 +++++++++++++---------
 tools/perf/util/symbol_conf.h              |  1 +
 10 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 980fe2c29275..fe168e8165c8 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -116,6 +116,9 @@ include::itrace.txt[]
 -M::
 --disassembler-style=:: Set disassembler style for objdump.
 
+--addr2line=<path>::
+        Path to addr2line binary.
+
 --objdump=<path>::
         Path to objdump binary.
 
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 697f7f924545..e56ae54805a8 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -250,6 +250,9 @@ annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
+	annotate.addr2line::
+		addr2line binary to use for file names and line numbers.
+
 	annotate.objdump::
 		objdump binary to use for disassembly and annotations.
 
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index cfd502f7e6da..af068b4f1e5a 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -381,6 +381,9 @@ OPTIONS
 	This allows to examine the path the program took to each sample.
 	The data collection must have used -b (or -j) and -g.
 
+--addr2line=<path>::
+        Path to addr2line binary.
+
 --objdump=<path>::
         Path to objdump binary.
 
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index c60e615b7183..619cc8143ad5 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -161,6 +161,12 @@ Default is to monitor all CPUS.
 -M::
 --disassembler-style=:: Set disassembler style for objdump.
 
+--addr2line=<path>::
+        Path to addr2line binary.
+
+--objdump=<path>::
+        Path to objdump binary.
+
 --prefix=PREFIX::
 --prefix-strip=N::
         Remove first N entries from source file path names in executables
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index d781639b644f..ec276db3e5dd 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -516,7 +516,7 @@ int cmd_annotate(int argc, const char **argv)
 	struct itrace_synth_opts itrace_synth_opts = {
 		.set = 0,
 	};
-	const char *disassembler_style = NULL, *objdump_path = NULL;
+	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -569,6 +569,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
+	OPT_STRING(0, "addr2line", &addr2line_path, "path",
+		   "addr2line binary to use for line numbers"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
@@ -628,6 +630,11 @@ int cmd_annotate(int argc, const char **argv)
 		if (!annotate.opts.objdump_path)
 			return -ENOMEM;
 	}
+	if (addr2line_path) {
+		symbol_conf.addr2line_path = strdup(addr2line_path);
+		if (!symbol_conf.addr2line_path)
+			return -ENOMEM;
+	}
 
 	if (annotate_check_args(&annotate.opts) < 0)
 		return -EINVAL;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 15b0cf649e1a..4011abc03d0d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1226,7 +1226,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	char *sort_order_help = sort_help("sort by key(s):");
 	char *field_order_help = sort_help("output field(s): overhead period sample ");
-	const char *disassembler_style = NULL, *objdump_path = NULL;
+	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -1344,6 +1344,8 @@ int cmd_report(int argc, const char **argv)
 		    "add last branch records to call history"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
+	OPT_STRING(0, "addr2line", &addr2line_path, "path",
+		   "addr2line binary to use for line numbers"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Disable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
@@ -1430,6 +1432,11 @@ int cmd_report(int argc, const char **argv)
 		if (!report.annotation_opts.objdump_path)
 			return -ENOMEM;
 	}
+	if (addr2line_path) {
+		symbol_conf.addr2line_path = strdup(addr2line_path);
+		if (!symbol_conf.addr2line_path)
+			return -ENOMEM;
+	}
 
 	if (annotate_check_args(&report.annotation_opts) < 0) {
 		ret = -EINVAL;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 57a273cd03de..82c6c065830d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1439,7 +1439,7 @@ int cmd_top(int argc, const char **argv)
 	};
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
-	const char *disassembler_style = NULL, *objdump_path = NULL;
+	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	const struct option options[] = {
 	OPT_CALLBACK('e', "event", &top.evlist, "event",
 		     "event selector. use 'perf list' to list available events",
@@ -1527,6 +1527,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "no-bpf-event", &top.record_opts.no_bpf_event, "do not record bpf events"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
+	OPT_STRING(0, "addr2line", &addr2line_path, "path",
+		   "addr2line binary to use for line numbers"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "prefix", &top.annotation_opts.prefix, "prefix",
@@ -1629,7 +1631,11 @@ int cmd_top(int argc, const char **argv)
 		if (!top.annotation_opts.objdump_path)
 			return -ENOMEM;
 	}
-
+	if (addr2line_path) {
+		symbol_conf.addr2line_path = strdup(addr2line_path);
+		if (!symbol_conf.addr2line_path)
+			return -ENOMEM;
+	}
 
 	status = symbol__validate_sym_arguments();
 	if (status)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3eaa9b2df6c4..3e5df90e11f8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3217,6 +3217,12 @@ static int annotation__config(const char *var, const char *value, void *data)
 			pr_err("Not enough memory for annotate.objdump\n");
 			return -1;
 		}
+	} else if (!strcmp(var, "annotate.addr2line")) {
+		symbol_conf.addr2line_path = strdup(value);
+		if (!symbol_conf.addr2line_path) {
+			pr_err("Not enough memory for annotate.addr2line\n");
+			return -1;
+		}
 	} else if (!strcmp(var, "annotate.demangle")) {
 		symbol_conf.demangle = perf_config_bool("demangle", value);
 	} else if (!strcmp(var, "annotate.demangle_kernel")) {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 33321867416b..f0a96a834e4b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -414,9 +414,14 @@ static void addr2line_subprocess_cleanup(struct a2l_subprocess *a2l)
 	free(a2l);
 }
 
-static struct a2l_subprocess *addr2line_subprocess_init(const char *path)
-{
-	const char *argv[] = { "addr2line", "-e", path, "-i", "-f", NULL };
+static struct a2l_subprocess *addr2line_subprocess_init(const char *addr2line_path,
+							const char *binary_path)
+{
+	const char *argv[] = {
+		addr2line_path ?: "addr2line",
+		"-e", binary_path,
+		"-i", "-f", NULL
+	};
 	struct a2l_subprocess *a2l = zalloc(sizeof(*a2l));
 	int start_command_status = 0;
 
@@ -436,21 +441,22 @@ static struct a2l_subprocess *addr2line_subprocess_init(const char *path)
 	a2l->addr2line.argv = NULL; /* it's not used after start_command; avoid dangling pointers */
 
 	if (start_command_status != 0) {
-		pr_warning("could not start addr2line for %s: start_command return code %d\n",
-			   path,
-			   start_command_status);
+		pr_warning("could not start addr2line (%s) for %s: start_command return code %d\n",
+			addr2line_path, binary_path, start_command_status);
 		goto out;
 	}
 
 	a2l->to_child = fdopen(a2l->addr2line.in, "w");
 	if (a2l->to_child == NULL) {
-		pr_warning("could not open write-stream to addr2line of %s\n", path);
+		pr_warning("could not open write-stream to addr2line (%s) of %s\n",
+			addr2line_path, binary_path);
 		goto out;
 	}
 
 	a2l->from_child = fdopen(a2l->addr2line.out, "r");
 	if (a2l->from_child == NULL) {
-		pr_warning("could not open read-stream from addr2line of %s\n", path);
+		pr_warning("could not open read-stream from addr2line (%s) of %s\n",
+			addr2line_path, binary_path);
 		goto out;
 	}
 
@@ -490,7 +496,6 @@ static int read_addr2line_record(struct a2l_subprocess *a2l,
 
 	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
 		goto error;
-
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -553,7 +558,8 @@ static int addr2line(const char *dso_name, u64 addr,
 		if (!filename__has_section(dso_name, ".debug_line"))
 			goto out;
 
-		dso->a2l = addr2line_subprocess_init(dso_name);
+		dso->a2l = addr2line_subprocess_init(symbol_conf.addr2line_path,
+						     dso_name);
 		a2l = dso->a2l;
 	}
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index bc3d046fbb63..5accd8e69ad2 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -61,6 +61,7 @@ struct symbol_conf {
 			*sym_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
+	char		*addr2line_path;
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
-- 
2.40.0.348.gf938b09366-goog

