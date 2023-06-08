Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192B727731
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjFHGUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjFHGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:20:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971726AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:20:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb39316a68eso553897276.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686205249; x=1688797249;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlkV9oZluLdE0Q1X2UHaZBqfxbjezgSg94v39TnZsYo=;
        b=bxXFEIvgk/dI+tADARdi4vlHeR7u3JlFh98b/YBsFKo4p1yR85buugmZGfg7TFLsAK
         wrdJ9nTRy7x1o6mPeNnYR9b5pL3HN9WqQV4Xxk9Y12YW0Ko3bKhu/RZMKKuo/yo2YtnC
         E7VSzmMcMaVKyfPJIkHLKoJM4aW6dk96AHvgCKQ4IQ4xVn5ulYVKKaZtUWLKYcLF6ImO
         Wj0uqDlzHhPNd9r1c3x0go4B9hKdXwK5lAdbSuwYNqnzFuKK8mbQdWTFeegW7GxPn0E4
         DSNIb2BO1an4VRV5r8THTmnF18VhJKlVlMZXsWQijc+3dYl+gxT6lbA5Q7bCFvFstv9S
         5MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686205249; x=1688797249;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlkV9oZluLdE0Q1X2UHaZBqfxbjezgSg94v39TnZsYo=;
        b=cLEFmJ4UmL85o6i5uD37IUIgZbbWyNCnMs70AmREUjtsi/8odvlHkgT1JVghYwWtVZ
         6peSRLnmi4rchKtiPBEEtekRzVK78QcVX7YbSNeaZXCx15qNmugE/Q6Z2BIu5iK0Azwj
         43aSqUsKgnc6WvmwRImQCvbQcIic63W+pwfmg3AujHOfwvFCXMf64U3kRx/uXKhybXt7
         rmOMzLs3Zw4vHmtPrklReREs3tonCZiLXeu3tE8t04dt1wiE7Ta2TIg5vlr5a7nJ38Ra
         mIckUUObN7eKCD/y//ndYn6UAikhuzGkix20oSsT1X8gxOjjs7wbHGAA7pmlhR+uU7+F
         gc8Q==
X-Gm-Message-State: AC+VfDyUXMUwi724m+631uAGUlyaBhXXUfY6CVgwV8+d+jX9nyKt5CFu
        PTeTdpIgj4YrSqjga+ripSMDNjCNwlai
X-Google-Smtp-Source: ACHHUZ6G6iLw7XgrUUDzjI/KPKpsYCqjzGyyo4eNBZ8oaNkNg1vculHYfRrs1gpGI6UvA0u/7sekTCADrx5S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:886b:58d8:e227:9ed9])
 (user=irogers job=sendgmr) by 2002:a05:6902:72d:b0:ba1:d0:7f7c with SMTP id
 l13-20020a056902072d00b00ba100d07f7cmr2844784ybt.2.1686205249117; Wed, 07 Jun
 2023 23:20:49 -0700 (PDT)
Date:   Wed,  7 Jun 2023 23:18:12 -0700
In-Reply-To: <20230608061812.3715566-1-irogers@google.com>
Message-Id: <20230608061812.3715566-2-irogers@google.com>
Mime-Version: 1.0
References: <20230608061812.3715566-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 2/2] perf srcline: Add a timeout to reading from addr2line
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
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addr2line may fail to send expected values causing perf to wait
indefinitely. Add a 1 second timeout (twice the timeout for reading
from /proc/pid/maps) so that such reads don't cause perf to appear to
lock up.

There are already checks that the file for addr2line contains a debug
section but this isn't always sufficient. The problem was observed
when a valid elf file would set the configuration for binutils
addr2line, then a later read of vmlinux with ELF debug sections would
cause a failing write/read which would block indefinitely.

As a service to future readers, if the io hits eof or an error,
cleanup the addr2line process.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/config.c  |  7 +++++--
 tools/perf/util/srcline.c | 11 ++++++++---
 tools/perf/util/srcline.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index f340dc73db6d..46f144c46827 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -19,6 +19,7 @@
 #include "util/llvm-utils.h"   /* perf_llvm_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
+#include "util/srcline.h"  /* addr2line_timeout_ms */
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
@@ -434,12 +435,14 @@ static int perf_buildid_config(const char *var, const char *value)
 	return 0;
 }
 
-static int perf_default_core_config(const char *var __maybe_unused,
-				    const char *value __maybe_unused)
+static int perf_default_core_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.proc-map-timeout"))
 		proc_map_timeout = strtoul(value, NULL, 10);
 
+	if (!strcmp(var, "core.addr2line-timeout"))
+		addr2line_timeout_ms = strtoul(value, NULL, 10);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index cfca03abd6f8..e06a345c5d19 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -21,6 +21,8 @@
 #include "symbol.h"
 #include "subcmd/run-command.h"
 
+/* If addr2line doesn't return data for 1 second then timeout. */
+int addr2line_timeout_ms = 1 * 1000;
 bool srcline_full_filename;
 
 static const char *dso__name(struct dso *dso)
@@ -512,7 +514,6 @@ static int read_addr2line_record(struct io *io,
 		zfree(&line);
 		return 0;
 	}
-
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -574,7 +575,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	int len;
 	char buf[128];
 	ssize_t written;
-	struct io io;
+	struct io io = { .eof = false };
 	enum a2l_style a2l_style;
 
 	if (!a2l) {
@@ -616,7 +617,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		goto out;
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
-
+	io.timeout_ms = addr2line_timeout_ms;
 	switch (read_addr2line_record(&io, a2l_style,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
@@ -686,6 +687,10 @@ static int addr2line(const char *dso_name, u64 addr,
 out:
 	free(record_function);
 	free(record_filename);
+	if (io.eof) {
+		dso->a2l = NULL;
+		addr2line_subprocess_cleanup(a2l);
+	}
 	return ret;
 }
 
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index b11a0aaaa676..35a5ff3e78f5 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -9,6 +9,7 @@
 struct dso;
 struct symbol;
 
+extern int addr2line_timeout_ms;
 extern bool srcline_full_filename;
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, u64 ip);
-- 
2.41.0.rc0.172.g3f132b7071-goog

