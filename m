Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF39712C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbjEZSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbjEZSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77444E6F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb76a9831so2254712276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126071; x=1687718071;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkY/jlHU8D/QUvZsW65703DMiaAstyzw0n4JGn1I7vM=;
        b=MoGo2A46Zq0pgRI5fFfL3G0sZBkuPf6Gf6b+p740I+LJYvieH3dq3QaVNjLRDDNhI1
         Yn9ltXeJuUEOhVtEquQdMsqzbUhRoJUGQtMqvA5bi2twF/0wV4+U6Ti2RnEUHasDnT3L
         Z0Y9te2LZtpfdHrMnSf6cnEr9VAdFSIcAw3aoF2AN8VTTd7jqEvHIBvwzAFyGsFi6CbW
         VSEd6JZrFDi0Q6+n4JnqrJ2B9WGImjQab1awVAfiGL/RJBuy8dgWdY4jpgQN2K2N3BU9
         5TxdIBZypd2GK+vsDNuCUZtFUukdvtaq4DmE/lnqx0XiUwIugV6UzE2XCSxKURn5s76W
         FG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126071; x=1687718071;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkY/jlHU8D/QUvZsW65703DMiaAstyzw0n4JGn1I7vM=;
        b=Df1D9OfQwX6lkdWNQJqRiOZrgX2RxjiCnxRD5sKD27xkFaZL7putQyZDaiBLY0upVt
         TX7nIX7ZeP3NMp4mzlj5yxSc2ALuxNS2vFAJxvlf0mDqNXGtwh6fzSrTeRcr+GJgvoMq
         pA1dftISodX4UQHp24GTom1ZsBT3S4fJzTZ3ysGHvFtGA17N3DYmBRuWz3qdIWh5PF5q
         TOwY2Tl5k4WRQ13tGGxFp2n7rj6UsJXzhvINZSdCzDpd0DIA94UEDHTC+A0LyM+JrLes
         iKvaYGUKefW1j8iA40tWJSfZ8xbeGKGUtpN5hmuP1O+zL34WqQ7Ezz3MG447EhclfWo5
         zCHA==
X-Gm-Message-State: AC+VfDyIQdRRGZoiziq78EdSaPL3ehSdd05ECW5TxgiopIpZdiXLr9DN
        NDD5uDg70GfWygdLO37axq7soszGHQas
X-Google-Smtp-Source: ACHHUZ46CyhIFSMkGhxWip07ySTruzaJfa/BntRi5T2gFcKfTHUsjqalbBDoLuSWZ0sSotcB6zsIWcXS+ISA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:0:b0:bac:7086:c9b2 with SMTP id
 v28-20020a25fc1c000000b00bac7086c9b2mr992109ybd.12.1685126071162; Fri, 26 May
 2023 11:34:31 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:54 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-10-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 09/16] perf lock: Dynamically allocate lockhash_table
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
2.41.0.rc0.172.g3f132b7071-goog

