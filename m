Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6072F60B672
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiJXS61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiJXS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D228E7AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so96970197b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEp3gHOpXGArSFAK8kT0WcuQTUqFi2M7wcWMFBGh4Ac=;
        b=GN2Lg7OgUbAWHRuK4qJUwWr9eJwcQ3WTCuHSeezMa1W1zVxcuWl2iwk3n+jcrOHAEm
         aifzMeBo3/bJbLMhOZ65l2+B4Y8z+QQrx8f2wvgIkoYFd73QkNXUmkAb32PLV80i5Rr9
         TQqCmNn2OyWoR+48I1Y07KAJP4GgmKQGsVCQcgyeHJqiugcQf5osSD0zvchkWCcSA2YM
         kDCUDfUorZg8uTr7zN65tuziIfMpEqTtmH5deuJbnEkarcE3cB39VApi/RuRKtrJpfm9
         R9xOPvysoog3mqKdJL9BY7b5s3Ep/Ygk+IGoOmFvYFejdjcPTB37ya+iwD6plChLNX4g
         q84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEp3gHOpXGArSFAK8kT0WcuQTUqFi2M7wcWMFBGh4Ac=;
        b=L8Eb0GXzQtNX4HcHIx5pFlMIh8ug2Ndb9JGvOuevhYN1ULfpMiCR8MSG9gLIllSFOo
         Sur12k4gEBrbyx1GwjFFEQWahpW+YXX+4TpUavZ6WWgiy0kMwnXA5BWYTBbTW/zNqhwO
         6w88ycPh3JaitXKYPitIyb+/h4LSbBwaBzyArsuaVJXXJFr4wrUHCGN98yfpySjQGUQA
         tJKsC3E6v0s78JjimAFbwGBNXZPbWUz8bcNqJp75VdH+IOrr3itAaLbACNYK8lQBpIKt
         IJiPThbUH91ofR13XGxwV7A+NjaBAZVPgSb/BEKyxHb2Crcin0VHBo0P+yCN0GtnFVUf
         owfg==
X-Gm-Message-State: ACrzQf3a/42VWcEp85srBPcmQHZvImp26xsEPnnMCn8Rfvxruhpio33K
        NYuUKLC6mfIs9xhNijHi36fNzrKC0FsJ
X-Google-Smtp-Source: AMsMyM7W/1twXXk2xSwyn1QT/KR8kARo2uyuqG1BSfQS7x1oOxpYAxTDtVWlLoC6G604YFTSmELHqi9t/72g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:eb92:0:b0:36b:bf3:d56 with SMTP id
 u140-20020a0deb92000000b0036b0bf30d56mr11423120ywe.28.1666632990914; Mon, 24
 Oct 2022 10:36:30 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:21 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-7-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 6/8] perf stat: Use sig_atomic_t to avoid UB
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

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..13bb8508d228 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,6 +83,7 @@
 #include <inttypes.h>
 #include <locale.h>
 #include <math.h>
+#include <stdatomic.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -173,7 +174,7 @@ static struct target target = {
 
 #define METRIC_ONLY_LEN 20
 
-static volatile pid_t		child_pid			= -1;
+static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -208,7 +209,7 @@ struct perf_stat {
 static struct perf_stat		perf_stat;
 #define STAT_RECORD		perf_stat.record
 
-static volatile int done = 0;
+static volatile sig_atomic_t done = 0;
 
 static struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
@@ -569,7 +570,7 @@ static void disable_counters(void)
 	}
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
@@ -1029,7 +1030,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
-static volatile int signr = -1;
+static volatile sig_atomic_t signr = -1;
 
 static void skip_signal(int signo)
 {
-- 
2.38.0.135.g90850a2211-goog

