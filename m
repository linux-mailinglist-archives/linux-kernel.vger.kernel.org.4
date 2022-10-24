Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8360B670
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJXS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJXS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C55B1DFB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 130-20020a251188000000b006be249d0a70so9832033ybr.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=PfDVYoSTOvxujmA929mKarnso4WjqFDWW2bmFKktkEtczES8mG4DER2VLr5qv7Autw
         Q8VBpRY/deX1Dz17HaSk+iFAthZQb0VGSP2gad5/7EnWN575WvXu85aE6KNktQpT7e++
         JE6+jyt46d3qWFVVq763Vf48hue5KkqYQzzBw2r6i97cVYGX0Q16Y1gd513g30u7z8fh
         7XzpxBvtkSoBTXiUQMt1ymYvIYi1IrpBX85rr5+n82XhYhPyBHfx7wIxgk9JVXSWLkVT
         NjlWgVTl7f7ad/e2bemq4wNdBELHqDEe3O0B9mmkTKblHddHgxvkgxkGePJDeJCeO9gY
         snHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=EROYbAxKasVjm4OHPlWwx+9Mzs+9wXoh4jRgFpzJllUWsqajfl3V9XOaq8oZN7UDTR
         /H2W7DUNi92PlVDxYXLY5MerJFZSfMJvTtBi+FYgyebaj4UzJ1z/vyQB3mjzY0ypY8q7
         U8HuLVPkV1H4p85zTWYiuFp605A73Vx7/THZWR8xQN6KVcI5wrooX+TRTXk1ZQw5N1cX
         VTCb7NiQNFw8BV0oGZyX7A1HdLb96wqSTLbpVVWTav3ROPF0oyrWW3WjRcYC9m7w5SZT
         lbkp0O1MIx/s54EUDHP0hHci4PpLgAlaJggqPWVh1WWH9ci8xQxBWM3zL5I7KlEk81dT
         78xg==
X-Gm-Message-State: ACrzQf0JhTijz+d+4DeO3/NUB+7R4Y727GDC6GBfiMSI22+Bz5MkNNR3
        UPrNK1ER3Ep7ZvBbZVgmJF+tGMtDfybr
X-Google-Smtp-Source: AMsMyM7P5d5LajPOjwQlwK82cvCrmTi1X25KVUyW6ylDi76/pIUXd7UlRm5bbfoDg4Upgsp0sliEKaXvVv45
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a81:2513:0:b0:368:3de2:7655 with SMTP id
 l19-20020a812513000000b003683de27655mr22126537ywl.488.1666632974562; Mon, 24
 Oct 2022 10:36:14 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:19 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-5-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 4/8] perf ftrace: Use sig_atomic_t to avoid UB
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

