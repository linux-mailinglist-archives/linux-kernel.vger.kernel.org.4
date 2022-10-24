Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B102460B903
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiJXUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiJXT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F8285B54
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w11-20020a170902e88b00b001855276704aso6819562plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=DnGef15ISVlJnfi1KdPzmICCiRSaKIZLMjxG9TJJ8kDAx+s7g+g/2xISsfzdrDh+WW
         /f6JqO38QlJnZ3N9v9ldBM2gB5j9g0mvhCW87whc3ZY/AogByxJnYfA9QCcZ1uJ3uJ9d
         6zoLYgjruct7UaRGpXkJsHL2JA8nWB9V1yjJokQcpkKDcmkbKYEpVT/XbLGdpYFok8JB
         RkFfVFbMtjhAgFr81QhRU6/QGKSH8KhHTJ68iwVmVI1h7s7HMdWrgDUu130hdz+MJCS5
         txCDwpf4bbfhmf8jzO6QwoM2RrNXZa4QUaZph5FgHM5muRrU0FG9hu9AHZODHPXTkvZ2
         UkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=KJiYgtX+x0gAwiVc0UFA8O1pHsDIyZm6hCcwxI/OiPQ3fzGLFRPAR2tVtc/nKRWtLt
         lM/fWcF2mh6eCBjRjTtNzDIZ5qpI+Rom/+5x+69rw0W6FJK/nb3lJqF2x52z8xiaM1Kw
         4wg/iwojqPW2L1l5vmG+L8QRlYa9J9J9wnT/9v1xoXeTpc2p6UaxnTxaLzeASpzEhX/V
         IgDg1N9/HX5kbMja0qDo5fppwCQOMm7pp46ijpUVdmhUNRKGCLNtWKqFYMo8R53EdffI
         xlUlylzvoskFbXnRhhYN9zvhD5O7AmQ/v9YB9OWu8pPVV7+ft0XvdZd0jTG6XwDgfHow
         THRw==
X-Gm-Message-State: ACrzQf17lQWtKLhHyrHx3sCkD/fCeAIpBp2imvTKBBxExfMCeFmxq299
        lRJqR9kIq7fyx61E1eqU1F3FjnoRDEGN
X-Google-Smtp-Source: AMsMyM5I5LbNcQTjNoTi2S86eT/wMOj8nHlMxWbgBHAB8LrcdsN7qavwvxu+4GNraLduqpKcMV1v0wbxct3d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:b794:b0:20a:eab5:cf39 with SMTP id
 m20-20020a17090ab79400b0020aeab5cf39mr3956618pjr.1.1666635641443; Mon, 24 Oct
 2022 11:20:41 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:13 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-9-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 8/8] perf trace: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3c757769b96..72991528687e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1535,8 +1535,8 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 }
 
 static pid_t workload_pid = -1;
-static bool done = false;
-static bool interrupted = false;
+static volatile sig_atomic_t done = false;
+static volatile sig_atomic_t interrupted = false;
 
 static void sighandler_interrupt(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

