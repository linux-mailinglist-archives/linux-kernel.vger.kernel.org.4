Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49765710612
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjEYHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbjEYHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D6E55
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed5097so629867276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998739; x=1687590739;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggTb6f0gA72Brkbk+lLnAHMXMj4Nzlq459y7w+X8s+M=;
        b=zya5huYBVKCG09FY59/9EdJFJ2gtw3RbTIm4L55BBG4PT8X/b9MS0BN14J4TKX+lMm
         IkFOIuPFZ707dsTexrCX/BMGBrjuOmazCA/KpqQ31nhcJCrHCuMwxRGCXdateaDifYsP
         +bqt+5PF4GgP5c+wrtqg6ILOa/6evCiGQAoR1k/Hu4+5xpIDLomMz1r/vAe7soVeoX8g
         YyUP8Jh6iKavD1b8sNyutgDqZTLf0Hp2jFHIY8cXwcZ6XTEikRZVK3nJHUYmCmzO0FZb
         9qvJlc5ZMY/CWUCxRaEbUFxBW2ho276N0givK7byEZJV1kmxegsZynwjUqTyBf63X5hJ
         pB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998739; x=1687590739;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggTb6f0gA72Brkbk+lLnAHMXMj4Nzlq459y7w+X8s+M=;
        b=i1kBeZOJ/NACILuMsFuOn2EfG6zpnvutIDwPvxFCnkF5UJ9maOefVzW/x3LAAMv0yU
         ag1bEnoyXKci2nHzT4MGFmgB6f6PZjo0dTkMab8LET/Sgc8CLzjRLpLLqAWiz7FLoDw0
         AHHN3iyh9gj/bLrL2ungru+9+DGNXS/rWDehhu48B70eSQODVJmrsddfAYW3MiVTzQdD
         ZDTJgTL7rz1Q4nx5/I60MCvXnhwVkTRJ8JNPsoVY433uyxBGXD6cqyVxKhSNYgD8xll2
         jMHSwQgf6AOvgloUoz2XrMIW0O1txdYhvpWBShrlrHa1AlwlXjaGWdScAavJdf9EDbEQ
         MDOg==
X-Gm-Message-State: AC+VfDxnuxjsH7DlpG6Yzg+0rslG1UCerDWe8g6ymCjpXIe6glkp5twQ
        Pa44mwuNXuSghea+HbFK8+Vsx2Afv7U8
X-Google-Smtp-Source: ACHHUZ7nBAXkL3/0TFHswcK9NCUCL+Ni/cvNuvpsdJBuVmg6LFyOPSr0UMvPxYD7FGLVdzpa0HosozU2iF0S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ca:b0:ba8:84fb:6ad with SMTP id
 v10-20020a05690204ca00b00ba884fb06admr1696358ybs.4.1684998738824; Thu, 25 May
 2023 00:12:18 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:26 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-10-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 09/16] perf lock: Dynamically allocate lockhash_table
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockhash_table is 32,768bytes in .bss, make it a memory allocation so
that the space is freed for non-lock perf commands.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 70b14ba5fdd5..fc8356bd6e3a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -48,7 +48,7 @@ static struct target target;
 #define LOCKHASH_BITS		12
 #define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
 
-static struct hlist_head lockhash_table[LOCKHASH_SIZE];
+static struct hlist_head *lockhash_table;
 
 #define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
 #define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
@@ -1871,7 +1871,6 @@ static int __cmd_contention(int argc, const char **argv)
 	};
 	struct lock_contention con = {
 		.target = &target,
-		.result = &lockhash_table[0],
 		.map_nr_entries = bpf_map_entries,
 		.max_stack = max_stack_depth,
 		.stack_skip = stack_skip,
@@ -1880,10 +1879,17 @@ static int __cmd_contention(int argc, const char **argv)
 		.owner = show_lock_owner,
 	};
 
+	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
+	if (!lockhash_table)
+		return -ENOMEM;
+
+	con.result = &lockhash_table[0];
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-		return PTR_ERR(session);
+		err = PTR_ERR(session);
+		goto out_delete;
 	}
 
 	con.machine = &session->machines.host;
@@ -1983,6 +1989,7 @@ static int __cmd_contention(int argc, const char **argv)
 	evlist__delete(con.evlist);
 	lock_contention_finish();
 	perf_session__delete(session);
+	zfree(&lockhash_table);
 	return err;
 }
 
@@ -2348,6 +2355,10 @@ int cmd_lock(int argc, const char **argv)
 	unsigned int i;
 	int rc = 0;
 
+	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
+	if (!lockhash_table)
+		return -ENOMEM;
+
 	for (i = 0; i < LOCKHASH_SIZE; i++)
 		INIT_HLIST_HEAD(lockhash_table + i);
 
@@ -2369,7 +2380,7 @@ int cmd_lock(int argc, const char **argv)
 		rc = __cmd_report(false);
 	} else if (!strcmp(argv[0], "script")) {
 		/* Aliased to 'perf script' */
-		return cmd_script(argc, argv);
+		rc = cmd_script(argc, argv);
 	} else if (!strcmp(argv[0], "info")) {
 		if (argc) {
 			argc = parse_options(argc, argv,
@@ -2403,5 +2414,6 @@ int cmd_lock(int argc, const char **argv)
 		usage_with_options(lock_usage, lock_options);
 	}
 
+	zfree(&lockhash_table);
 	return rc;
 }
-- 
2.40.1.698.g37aff9b760-goog

