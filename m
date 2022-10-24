Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712F60B908
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJXUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiJXT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FE27FA90
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s82-20020a632c55000000b0046b2491aa95so4976006pgs.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=YzERVhg9gMWf4MLdxZBUxgsORWHJ5IiRDR6VYxzIXnasnGV8Hosww149KRKfuABEov
         w96snZWOzfeu47BuK3oYRu/RxOuk/MmwEX6+gdq2c2tFXoJckpjyu/AYbr9k86Hyybhz
         1cIJLP8elnxBXNZRdVBOzhciaHBJrl2gmRzcgX67Vzg/0hUuIQUvqlGWD0k+Wd/SCM9z
         bItak9BMMARaNggK/JovGwRgGw/c+aSgGXbw2BnzMbBi5b1h2WKcSON2uSlPhA0U+DzQ
         d1HpCEVzzJeHvL37Oy8rcaQ+Q7l6sPxekv4KAY6W5Mz0MZH5Cg1EG8Loc3XJBjL9lJnm
         FEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=s6U9UTfc1TujbZ+sV6tVotprKmUheDhoCGSUCPDMxwezIPvHQNy5ilNnh66CKCfy7M
         qaDfHFCwhoeGEz3wTfqLFmZq+DLpmkicsddAwc80MJCD59aRVIUab1LGS7YRUAVk023g
         ilpc0brDvwbIzyI+D1hXMeJc20IyVjTfTtj5LQdTyKf4M7QJFVyLhs/xn9339Y2XOrhU
         k5plqgAhogo2pgQrv1klW/SK2HoKffZHkOKfntFlk71/9wMajwKhzRzeUbCTSg0RIOo6
         9wT9IjF4D44VSfjFR4sv8A50b/8ooGQk3KP/6U3Q3LifGTfWnBwNlPgq2xMkjhcThyCX
         P3xA==
X-Gm-Message-State: ACrzQf0Jp3jxsI5bt+Nmx+rf8GccZH0g0XIJUSZ6oxTQWouA8JChJBz4
        PBULw/grtMRkfWUkpY1zbUHlscwKsNk/
X-Google-Smtp-Source: AMsMyM53n+U8wMZYq2kZ48d4ptOI6JPZcIJhCvjLHnk8btpgGx6iLrT5rSk9jQcpAm0su0GzCh+QTnPUTe1t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:394:b0:212:19d7:9072 with SMTP id
 ga20-20020a17090b039400b0021219d79072mr27097168pjb.69.1666635608577; Mon, 24
 Oct 2022 11:20:08 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:09 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-5-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 4/8] perf ftrace: Use sig_atomic_t to avoid UB
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7de07bb16d23..d7fe00f66b83 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -36,8 +36,8 @@
 
 #define DEFAULT_TRACER  "function_graph"
 
-static volatile int workload_exec_errno;
-static bool done;
+static volatile sig_atomic_t workload_exec_errno;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

