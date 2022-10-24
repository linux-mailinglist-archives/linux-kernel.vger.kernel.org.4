Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0060B66F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJXS5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiJXS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73881683
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g6-20020a17090a300600b00212f609f6aeso1681235pjb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3arsizWDDWH+MKNBhUVuOKkALW8L2napp9/1OYe9kXI=;
        b=OlvnzNTW+kTD3+3BfP32Lyp4zweV38hpVb3JBzX9Kl8cG8rpDJwS1PNWPBbQM81X7f
         XKoN0dP+gbL1BoM6bbsYOUT8B0ZSkP05gici5Rw/4uDCV2QhO5VIArmr/WGmb+lyquko
         MEp9EfBNLkEiRITbcWDMY5AfjBW0VSuakRM0IjX3+ypLC7et5HlFvKeeSZkkUyZ2fgYL
         qjcqke3JcYNj49+1ewf3HmEDkdr068IEqFDOtG5SXPz6C9CH3xahhFqdnIeu4U93HlqJ
         Wie9R7uYy/J60mKIfLJXhEBhu94B3NPzKcjwM8I4REAdx2vKxSEgeXC/g4fvTLoMXRJD
         WwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3arsizWDDWH+MKNBhUVuOKkALW8L2napp9/1OYe9kXI=;
        b=Xg+eQt7YZaFBUIJdDXmocS/w301Tk6xR5FbpsDI9O89RYAVwXlhrncc0NqJi3jWQmb
         jU5MCuDEfZ7XjRtfH9FI7zxAuQaFlzw3EHEZ75lyVFSXbLscTwB90BRNUabXctjsJekv
         /0N3ccXfEBp30DozJcsjeZ1APM3xkXjMell07OlEda3BIwujEIebu6zx0Vg5MYkynv/a
         FyUn7b7xT1KVPpCAapPG6500R/hR74OZ+yBk9fJ+shWaGM5KGsvEehvuIEraaep3G8P7
         wdvK/WpCp0hNP5cj41okaFKjhK2urhEg6EhEVS5SrduS7Nr2uUdLf8Y/ORUeFev+vobz
         GleQ==
X-Gm-Message-State: ACrzQf0brpL23ZMuOqa464oem0kZNr67QNPYih9GGjjEo2IvfustYS4m
        IT7oVOnBESJ5SFmbFnokEoAXe+jQOapP
X-Google-Smtp-Source: AMsMyM52C28bTdexwEVOx/oa6h7vzYixq1KPT8VWRN/t6wx6Lux1MD7mY1A8UAcbolqUTb6K9RrWJ6+cWh3U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:38c4:b0:20d:9dfa:4339 with SMTP id
 nn4-20020a17090b38c400b0020d9dfa4339mr72319030pjb.74.1666632966573; Mon, 24
 Oct 2022 10:36:06 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:18 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-4-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 3/8] perf daemon: Use sig_atomic_t to avoid UB
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

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..d05084952c09 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <sys/file.h>
 #include <signal.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 #include <time.h>
 #include <stdio.h>
@@ -105,7 +106,7 @@ static const char * const daemon_usage[] = {
 	NULL
 };
 
-static bool done;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

