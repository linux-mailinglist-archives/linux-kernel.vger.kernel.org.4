Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE3C6B5923
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCKG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCKG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD827733B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-538116920c3so76941997b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517922;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5GcUUcZRN+AEu9vpTIS9W0tRqRRERda5Pu2Ht/K9Pk=;
        b=pR13zWUd1h9CUw/T2GV0Cj+B8jhP5cn1b0sfJynxS58CMKOE3JqEuutXfxMi4Wioti
         EFbn2mdwNoHJ/wARCIZO56BUhwpqgFZ4Bn5sPoYHugdpGrzTJmayahuR+TNP5iqQgy/x
         CqWQeouCG3GnHU6qgt4kdZpK5XM+ljNUv0Jsdzr7g/tl9L65XCuwCndRocKy+po/BQzU
         ruGs389OD5dZUXcUWJjPGX566lwUNDY7Xc+oEkZSRYH+PVXpT8RFXWNcEPR71t4g47Sx
         sLTI3WeR7S1OZCkHPeDiOq26WyWmPGQPgAJqIzyXSYb0CMy3RBdWVwkUSQGv+qwnbW9q
         VBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517922;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5GcUUcZRN+AEu9vpTIS9W0tRqRRERda5Pu2Ht/K9Pk=;
        b=AwzDj/HiQOaINi4xQz9Yk8ZjQa6rkFIvIRpPFHTJCmYKBDaRDEoLC0t0iLuQ8CgOF1
         d8IfJA0zLCQjP7cpkhMbbUvLXEzCmU0pNFWIWlzSyxRum/4uVuZCf8w1IQRyc6GHZa03
         +wWlaYd2KdMw2hiYLT1CjWXux1YE9qCn8XbrgjeWWyfHQt7s0EMQpHm5+GNjQz008JDq
         UvVZ1MDmcUswEsCkb1HJ+wcmfXLatY1N/ftHsvGUFlp72mYG0DIqluXfZZ7ihPzqrPB+
         1Wm6yLz9rxJ2F3izs/hVO3Ttxo7R1Ln8ySNftDdpqfJBX+syCGUl4lq7UaY8iMYegOIe
         WKJA==
X-Gm-Message-State: AO0yUKV/s5QjOcv8z8MVlfwvWjm5pmgSv4PM64j/omESd2A0GuT3ROHq
        5j75e6IbsAnFLRoUNr6zJCxQzQPeYzmt
X-Google-Smtp-Source: AK7set+6srXuJ0wtMRw7PpcSCeXW+oUgIuzrriuNVGeyYG1RPaHgSLMosGnTbUK0w+ieDCHiEIQd12hje2ew
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a05:6902:208:b0:ace:1ae4:9dd2 with SMTP id
 j8-20020a056902020800b00ace1ae49dd2mr17170987ybs.8.1678517921899; Fri, 10 Mar
 2023 22:58:41 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:45 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-6-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 05/13] perf util: Remove weak sched_getcpu
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
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

sched_getcpu may not be present and so a feature test and definition
exist to workaround this in the build. The feature test is used to
define HAVE_SCHED_GETCPU_SUPPORT and so this is sufficient to know
whether the local sched_getcpu is needed and a weak symbol can be
avoided.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cloexec.c | 13 -------------
 tools/perf/util/util.c    | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index fa8248aadb59..8830604c3a8d 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -13,19 +13,6 @@
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
 
-int __weak sched_getcpu(void)
-{
-#ifdef __NR_getcpu
-	unsigned cpu;
-	int err = syscall(__NR_getcpu, &cpu, NULL, NULL);
-	if (!err)
-		return cpu;
-#else
-	errno = ENOSYS;
-#endif
-	return -1;
-}
-
 static int perf_flag_probe(void)
 {
 	/* use 'safest' configuration as used in evsel__fallback() */
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 391c1e928bd7..b356c9f7f0c3 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -533,3 +533,19 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x, size_t msz,
 	*arr_sz = new_sz;
 	return 0;
 }
+
+#ifndef HAVE_SCHED_GETCPU_SUPPORT
+int sched_getcpu(void)
+{
+#ifdef __NR_getcpu
+	unsigned int cpu;
+	int err = syscall(__NR_getcpu, &cpu, NULL, NULL);
+
+	if (!err)
+		return cpu;
+#else
+	errno = ENOSYS;
+#endif
+	return -1;
+}
+#endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

