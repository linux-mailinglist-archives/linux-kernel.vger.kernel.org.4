Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45531712C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbjEZSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbjEZSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A6134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae7eea1d5dso8281765ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126059; x=1687718059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJmwLfRRVr3ODHBN7zQ2hUxxptOi1p92mYZclHdiN44=;
        b=ebkX03X6J7UXTqGhZi7TZ5tKSwDb5GlMRiV4qte2YYdvtTDfUDJZMnnIeCZRKUL3jp
         b1IDDwyvTFTNgUsTeKE7Vf5/Q5wOKad7bGRsNgXfHaFe5wjlDnhdIg+pqIJ7nCoLVZ43
         JXLgblf3SuR+iklvswplYjUli+LWd7aABOaCTNHShXdVPRBPuWAJRFyYD5KC3zVMh4I6
         HdV5u0QmREQ7ub/VfuZiKGcboRmX2BrZ+G5lhrUgz9qVUCcDWix+D1YJX3mvA7gMEJ47
         yOUHoM1N67qPM3C7sEJGxzsGtk8EPOK6U2y41Hv1+YrfycJXskuXonn0tOaIkjlTZ8Jt
         jH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126059; x=1687718059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJmwLfRRVr3ODHBN7zQ2hUxxptOi1p92mYZclHdiN44=;
        b=dNvQQHSiGknHRgL19Iq3SGky8GqsNjDrkeE/qXXpizhbHpKB5+NajYKRzlLDVbm7KY
         qBNXN9n3Ka3gnZpw/aitZjgUpoM9o/GbN2Dq0R4a5V170mic6SASUJi6nmDp+ccPbsuU
         FtWrq2AICBilv2rnJkbxGVEa8Pa05OyrtwgmQ7xzkCaIDQIV5ASAkQ28tVnI4Lw1Vwiu
         rL0fNpfaOB3sel6N7CtF/UVfmQHhOlBGTFgL2XIyLD5f0HjO+y+NbjyJkUYqfBd2OquN
         +luyt73Ujzy1ZIucTCDSf3SsdJBxNBzHEdC1aTPTSpbKQO512AU3W/rukREtVtzf0lHk
         nD7A==
X-Gm-Message-State: AC+VfDyVM6H+W1bKKMluWvhYlOt2DhIVK6semWk4DGbTQue0YlQUVrz0
        YxVr/Fe7/dOrmaJdiPTsg0+0EM6GqwdK
X-Google-Smtp-Source: ACHHUZ66XVs9uuYY7Z8yFza1YhbpP/n+i9VBRWqOvdwvNtok78qODw9ody70xKdsTuJwZFl/tMHcBbWcFr8T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:903:2683:b0:1ae:531f:366a with SMTP id
 jf3-20020a170903268300b001ae531f366amr691371plb.5.1685126059551; Fri, 26 May
 2023 11:34:19 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:49 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-5-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 04/16] perf trace: Make some large static arrays const
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
2.41.0.rc0.172.g3f132b7071-goog

