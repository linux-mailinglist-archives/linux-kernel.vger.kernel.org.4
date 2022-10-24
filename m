Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629C460B8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJXT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiJXT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC228511E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y143-20020a626495000000b0056bae530d80so2145463pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=iiTJs0VEY07rTilwdAieFazat3VOy+LVzf466jKCU8DFFU3klelDhVQh411e4Fda+W
         LEuRBdu5LJXJRND4MI9Z5m59FiS19f6TSE25O5r/TPPn58S5GgDVU2YAsHHigzmAWW5K
         S2L4iZahsiLBOs9YUXiczWeQG9G/+qNfojh8Pd/yuqpT87M8udlLSpbpVUSicv0UHszq
         WUC47j2oZTq+UOoaGTGgbZVfAe28njxnsOhstYgGz7teIVnuNOE0Ee/PTTIqj/WNedF0
         sO0lxWfViGHOR2aRo/LnNfYE+7oupjVOGaFuOzh2y2uR4Gco+sfFuu/ErLgbWtfKNyQm
         8Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=JMG0Pus4feu8g/HKEGa6hBeSUfh/8hHszP++0Pnhj3SKl/rKEIWjaN5/XansuqykPI
         VU0QBGOi+RQTYK5jlp41ygSr7iuPWD2JxusBexcyDrhfW+egUj8fSgq0Y/UA5ERae9Mw
         CQCk5OABp9avIG4d3ZMHnBsvj/0zjVByAw48vn74f6FPGxTQlKF6FoNiiB8EbfjbsfU7
         xaieAjemOv1e1TRjW8SYycRSRxTkORIGeStDi06I4bvj56mBgO1W/iiy8+sqRI4ew4YE
         EK3XfHunJBXeycjwXKs95UVfG42vszNHHXuWQ2daPMEz8FuFbQ+/dBn40pgoLmO2Ze7J
         +K8Q==
X-Gm-Message-State: ACrzQf3+/5JZPZn9w4IlH+LX9IjnnlAD9EHb7S03hC/RIGckw7ISNnUd
        qIMQkytJV4xuZmZAA0hdgVT5Mew0XR+L
X-Google-Smtp-Source: AMsMyM4Ejr4u/zJQD1O1ntbW0fysOW1g8lIqixCh7xH5QCVGq9vEZLSvDzrM54rVza3CoTeOfEI7YSgyWHdA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a65:4943:0:b0:46e:f5e3:3e94 with SMTP id
 q3-20020a654943000000b0046ef5e33e94mr7928144pgs.75.1666635634101; Mon, 24 Oct
 2022 11:20:34 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:12 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-8-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 7/8] perf top: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4b3ff7687236..bb5bd241246b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -87,8 +87,8 @@
 #include <linux/ctype.h>
 #include <perf/mmap.h>
 
-static volatile int done;
-static volatile int resize;
+static volatile sig_atomic_t done;
+static volatile sig_atomic_t resize;
 
 #define HEADER_LINE_NR  5
 
-- 
2.38.0.135.g90850a2211-goog

