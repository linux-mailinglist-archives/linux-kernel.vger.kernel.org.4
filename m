Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7160B8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiJXUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiJXT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:44 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AB280EF8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso6773979plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO66rWb82Ym5SFWEwsbpBF8A8iB7JwCydGL2I5mbLFY=;
        b=hds5L9pq39xD5mOs2wSydg/fTH9JKNsJ7Rbx4+Zwar0mwCiXd1hUG54QUFgvXIy46C
         0Nuybfzj2CtB9cQ87gNkJHD4MHJc113lhZZBc1ReSEFoxUjqpdWMir9O2DRmqD7ls/MW
         /M7P7UwALSMn681ZAGb7ZMYNuscUeK/5z2yD2R3faeyxN9tYpOCOSvAqSfBITEHXq4aM
         ZDekWbhsSEyGVKC9MlqoG8fW1+//MdAC2v70eHWLCMBgzcrePSjc7sMpNZJTy3eIjYJP
         auJ5eWSlKWzOox1BEvLJHFG/Y3irC2WZBoMDi9LvpgiZ1ZpS38/wuu4xWHW7ZGO8vbV7
         Bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO66rWb82Ym5SFWEwsbpBF8A8iB7JwCydGL2I5mbLFY=;
        b=AdPCszGK82yHO3jDmhpLy4IS+JWtW6c3nX734VvYrh/BDpbn4FfowkUL5PX75Dxei6
         dS02nNYIc1fVHSTscWDQeUvgG2d3T/4YCYZt8LbjUn1+qxMQJaefdie9TLRvtAzJ6y1d
         0+Ft/n63PWs7/hg4NrE6TuXF0EGTP+eKr8xF9fj2VlPQuZNupbeB33WaqEHgJBHtE1r+
         izUdgftq60sv6af/10+E94HxJoBEeGdHkKAxpTz9PQqeY00h5U1NNQNq0iSw3jfLpLSy
         edbLTWavCYjH0RjyleUblncHrgwzr7HT+ovG5wOXPqXhOjhrArC8aYa2Jv1q5tV64iGL
         BbrA==
X-Gm-Message-State: ACrzQf2T/lDVAv4/bvEUf7aP6EDEI4qr7hmBYpbUZ1cpoCcUu8wwsuXc
        FXDQSD6e3SfiIsx8NvKsXqaq6aznNqOK
X-Google-Smtp-Source: AMsMyM7mr42p3I5oH5NEpSHkDYBQ44el74P+LK4ELUYR9780/JS2/SSKzlney3clKu0vyZWDA8Pxbn80JtQY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:7a85:b0:20d:2891:15f with SMTP id
 q5-20020a17090a7a8500b0020d2891015fmr40660039pjf.107.1666635626193; Mon, 24
 Oct 2022 11:20:26 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:11 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-7-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 6/8] perf stat: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..e1a5605adb97 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -173,7 +173,7 @@ static struct target target = {
 
 #define METRIC_ONLY_LEN 20
 
-static volatile pid_t		child_pid			= -1;
+static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -208,7 +208,7 @@ struct perf_stat {
 static struct perf_stat		perf_stat;
 #define STAT_RECORD		perf_stat.record
 
-static volatile int done = 0;
+static volatile sig_atomic_t done = 0;
 
 static struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
@@ -569,7 +569,7 @@ static void disable_counters(void)
 	}
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
@@ -1029,7 +1029,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
-static volatile int signr = -1;
+static volatile sig_atomic_t signr = -1;
 
 static void skip_signal(int signo)
 {
-- 
2.38.0.135.g90850a2211-goog

