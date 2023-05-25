Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A563710603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbjEYHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjEYHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61102E67
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-560ee0df572so6392397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998727; x=1687590727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bvqtZMaMVahHc8ltlI3yqPqIhhKvYIIrry65zbvjgo=;
        b=EvcEKepfQlDZdXfQ2topr18fG5SgrGkMrDGb6bXKfsk/E6u1iQDlvCXGEGeZSSJTY6
         j45Ul6s9ALG3dcVd6GYYuVE1gfcG593zZg6kIDNpNGJcV0JsjCBqSe9v+QKUrlUtA4VW
         6Z3iggxFzx2IKvwZaQ0Fr7Vrf9UrGS1G7IkwdNz0DF+AOVHcFcltf4ntb965lpeavXUX
         Eb3ksymwuH5wsVSv8xCnWbzN1Zq+CqWsqaqU1q+ONLCrRh0pZcM3JaobX0M/j9uKcH+D
         5YzBfhYJ7kXUv66f5KL2IQjA0oRxEAyJ/+6bgN0MgEtSyGKJ+le0h0b0VD/pj9jodrJc
         vB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998727; x=1687590727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bvqtZMaMVahHc8ltlI3yqPqIhhKvYIIrry65zbvjgo=;
        b=SbDLLBsGBXOUDUG5L4oyVzeUPT3fJGKeaMnmqd+wQr6ZY1yLDIrDIk9vwBFjE9ubjk
         9ldembnOSyL3Y4qc8I/ZPRrNRx/VQjQRCWPbUn+EyOgqSH6U1ITyABL0Id+gh6WyhAS+
         kgZRuT9gxnWaXTKVJEQvKyKEgG2xC/TPl0opbZe1Ag6h2SGizGwFze9dfRFLdSIVANbu
         BjSqcbaDLex3uWX6JP9ipb/Hybx3UF2WTqNEmcw1n2rOySDuGrv15trxmWQxetImgDYG
         wAmphzRNAqYKH+9LLBKLRTH7+oruQf233LHGz7Oq/xw1JPUxiklwd9E9aOBNl+BCUFle
         eSGQ==
X-Gm-Message-State: AC+VfDzhMSHQ8p2QhefFp8aVwt57cWwuUXtIZr25Umbax4A8EsWKKtG4
        zdgFt3MUyL6+R8E5vbItFym0F9KdBz63
X-Google-Smtp-Source: ACHHUZ56KoRTg/8ZXkf+D/nXzC02q/vPfTREgKGfzN/3AV1a3sK4SMMvyr8WnSGo/ZkUQ9R4J0CmfpfV9C6Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ad27:0:b0:561:8fc0:24af with SMTP id
 l39-20020a81ad27000000b005618fc024afmr12304352ywh.9.1684998727652; Thu, 25
 May 2023 00:12:07 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:21 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-5-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 04/16] perf trace: Make some large static arrays const
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the movement of 33,128 bytes from .data to .data.rel.ro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b49d3abb1203..62c7c99a0fe4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -914,7 +914,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/socket_type.c"
 #include "trace/beauty/waitid_options.c"
 
-static struct syscall_fmt syscall_fmts[] = {
+static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl",
@@ -1176,18 +1176,21 @@ static int syscall_fmt__cmp(const void *name, const void *fmtp)
 	return strcmp(name, fmt->name);
 }
 
-static struct syscall_fmt *__syscall_fmt__find(struct syscall_fmt *fmts, const int nmemb, const char *name)
+static const struct syscall_fmt *__syscall_fmt__find(const struct syscall_fmt *fmts,
+						     const int nmemb,
+						     const char *name)
 {
 	return bsearch(name, fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
-static struct syscall_fmt *syscall_fmt__find(const char *name)
+static const struct syscall_fmt *syscall_fmt__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
 	return __syscall_fmt__find(syscall_fmts, nmemb, name);
 }
 
-static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts, const int nmemb, const char *alias)
+static const struct syscall_fmt *__syscall_fmt__find_by_alias(const struct syscall_fmt *fmts,
+							      const int nmemb, const char *alias)
 {
 	int i;
 
@@ -1199,7 +1202,7 @@ static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts
 	return NULL;
 }
 
-static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+static const struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
 	return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
@@ -1224,7 +1227,7 @@ struct syscall {
 	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
-	struct syscall_fmt  *fmt;
+	const struct syscall_fmt  *fmt;
 	struct syscall_arg_fmt *arg_fmt;
 };
 
@@ -1673,7 +1676,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
-static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
 	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
 	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
 };
@@ -1684,13 +1687,14 @@ static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
        return strcmp(name, fmt->name);
 }
 
-static struct syscall_arg_fmt *
-__syscall_arg_fmt__find_by_name(struct syscall_arg_fmt *fmts, const int nmemb, const char *name)
+static const struct syscall_arg_fmt *
+__syscall_arg_fmt__find_by_name(const struct syscall_arg_fmt *fmts, const int nmemb,
+				const char *name)
 {
        return bsearch(name, fmts, nmemb, sizeof(struct syscall_arg_fmt), syscall_arg_fmt__cmp);
 }
 
-static struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
+static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
 {
        const int nmemb = ARRAY_SIZE(syscall_arg_fmts__by_name);
        return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
@@ -1735,8 +1739,9 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
-               } else {
-			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
+		} else {
+			const struct syscall_arg_fmt *fmt =
+				syscall_arg_fmt__find_by_name(field->name);
 
 			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
@@ -4458,7 +4463,7 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt) {
-		struct syscall_fmt *scfmt = syscall_fmt__find(name);
+		const struct syscall_fmt *scfmt = syscall_fmt__find(name);
 
 		if (scfmt) {
 			int skip = 0;
@@ -4525,7 +4530,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
-	struct syscall_fmt *fmt;
+	const struct syscall_fmt *fmt;
 
 	if (strace_groups_dir == NULL)
 		return -1;
-- 
2.40.1.698.g37aff9b760-goog

