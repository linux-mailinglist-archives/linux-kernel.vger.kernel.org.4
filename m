Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E782B710611
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjEYHNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEYHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C28E4C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed51b0so392957276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998736; x=1687590736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JINgRbKyqeD/5xjEyB2Z8M27zbkpuoQ93P6f/ale0uI=;
        b=OP4afWsTIYHlIiVTegNyeLRIqJ2zMqeyRsGXo/7eq4nQ5gebMPUTViLGgtu89xP43w
         X25NyK2bhxqAHZtrw1issc4tRmXnff5EtFVyw+kq3E99WowlEQlVAV4935YOas6Bl/Bq
         LhMHBUoNbwpi0bpYt5T9maZQF4yoblT3yyX+IAZdUcmpyyuKxTOzG4miAldimh5JFUIB
         Hiu2a09aHEQYNjXmmZv0C//qoO+ntkS8zOpyqiIypFAXIpib6mKGDVU/UHRod0EfNM7Q
         nOsc/DeVMBBGfIoAUK4Fbqu4C3dpZ7W1WSvi/0P4y2uIevkTZhzXlmn9TyFaWIKeHC/j
         G8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998736; x=1687590736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JINgRbKyqeD/5xjEyB2Z8M27zbkpuoQ93P6f/ale0uI=;
        b=OTt4vhmOHSyKpyGoFLM2D0FjycajqHp5qBzJSUpZ5UXmCi5j7n+d2ejRTrraLHOhYL
         w2CZKKmEH9SnYAl5KmvousH5gCkcjQiRXKOpKVApvmDWkbP7wUpSt6tsqG9Di6k5nuMH
         PGfdUWNR0gWnF19l5kCkQxHv2dkylJCDMMswbd8kt6NR+BpeN7ewiT5vd7MFUMTaE0l2
         ChEHutaX29dh90bcegG2DVXsFjcT8ANGHn+jV1uVfSurxhEi0cdxv8RGsCNznCuQghJp
         Dq2V52j2b3w+xcTG02Ky+KzxXry1CqkxCVnbqnznq3MypcIg9slrFzdSFdctvyRXMt3H
         NoqA==
X-Gm-Message-State: AC+VfDxNjxLxip3/sKjE5Hr1tfpCeFOjoacu3KFCG9ICnnciTevgWgJ6
        UvqPTjnAQFwS19fZhznA9Y3OOQBNzOaF
X-Google-Smtp-Source: ACHHUZ7sbw6AbhpElOgagS6t6+PV+X3bd3rUnq9Dqsw9hU6xB469HNKeglXDNdx1ojU0xz8YM86WvVJWnJUg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:7456:0:b0:ba7:1499:e202 with SMTP id
 p83-20020a257456000000b00ba71499e202mr1646377ybc.7.1684998736756; Thu, 25 May
 2023 00:12:16 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:25 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-9-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 08/16] perf daemon: Dynamically allocate path to perf
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

Avoid a PATH_MAX array in __daemon (the .data section) by dynamically
allocating the memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 34cbe3e959aa..adb5751c3ed0 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -90,7 +90,7 @@ struct daemon {
 	char			*base;
 	struct list_head	 sessions;
 	FILE			*out;
-	char			 perf[PATH_MAX];
+	char			*perf;
 	int			 signal_fd;
 	time_t			 start;
 };
@@ -1490,6 +1490,15 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static char *set_perf_exe(void)
+{
+	char path[PATH_MAX];
+
+	perf_exe(path, sizeof(path));
+	__daemon.perf = strdup(path);
+	return __daemon.perf;
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1503,7 +1512,9 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_END()
 	};
 
-	perf_exe(__daemon.perf, sizeof(__daemon.perf));
+	if (!set_perf_exe())
+		return -ENOMEM;
+
 	__daemon.out = stdout;
 
 	argc = parse_options(argc, argv, daemon_options, daemon_usage,
-- 
2.40.1.698.g37aff9b760-goog

