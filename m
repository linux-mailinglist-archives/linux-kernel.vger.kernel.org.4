Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B16818A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbjA3SUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjA3STr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2938678
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m15so855973ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp7aHBUW1jeQF5BaTlNM3qh6OpGZbn+TcSkRCqi1rpA=;
        b=JlFJKGfQVP+ZJ4ZfNW/30qCZgXd85FdLu28kwHbW4K1QjzS8W8lPA1dmvs5YOKPx6i
         g1rcxZPr0uXfhgIhiLKW8LXNCCrvkBLjT4uSE+KGpkgENyGFJ+6UWb7/TicE8j2x4K5X
         uq8913H01SJ5Bpwu5jHe99aWe8Tt7mzxcAlH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp7aHBUW1jeQF5BaTlNM3qh6OpGZbn+TcSkRCqi1rpA=;
        b=RHH6qVFfUvRn2LxwvadZKQGx/xxQF3lhd8f3jxB4Ynj5s5TX9RKX1XdejHSfLiHUnU
         SqnkhgbgqTt0WA7EBfH9NIWwstc6RsMLA7KO90Wlo3uiF7IJ4mJyY5+39M6vCRukmJP6
         Y3IJOkmsEUvrOE8ZcIAVze/EKQNLU38OU0QJp+gHHpCvy9MXttX7qp/uq4S/7fetFuF4
         2HWdzCZZuzKsaxdAIwzW1uj/Tn0X6a2VrM4+MRgvl/q06YhWrqSAdv5yFhBg1rxBDtpA
         TGmSgvuLl0bxt8XQSSPK85NWh5xHhDwkYuhkVOBaFtACwnI0zUqeZNhi9MQH4KJ9oVib
         ZtTQ==
X-Gm-Message-State: AFqh2kqucUY2kJhYiMb4ZL6FQv+OMk4w24daH/V0M6R7ZvyuM3MjzKIs
        a8k8hBTJTbEFbW0Q/lzsWa/q5lmESFWZpgwR
X-Google-Smtp-Source: AMrXdXtNYZmSI/B6owkdukXiEncZXYpEnMelEao+FAikw603ox7t8fW0hkOpMTlEEpNU5qPt5EQaHQ==
X-Received: by 2002:a92:de09:0:b0:30e:f1e5:3e4a with SMTP id x9-20020a92de09000000b0030ef1e53e4amr33574012ilm.28.1675102783894;
        Mon, 30 Jan 2023 10:19:43 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:43 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/9] perf docs: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:10 -0700
Message-Id: <20230130181915.1113313-5-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in the perf docs still refer to this older debugfs path, so
let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/perf/Documentation/perf-list.txt          | 2 +-
 tools/perf/Documentation/perf-script-perl.txt   | 2 +-
 tools/perf/Documentation/perf-script-python.txt | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 57384a97c04f..6c83459d3192 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -228,7 +228,7 @@ This can be overridden by setting the kernel.perf_event_paranoid
 sysctl to -1, which allows non root to use these events.
 
 For accessing trace point events perf needs to have read access to
-/sys/kernel/debug/tracing, even when perf_event_paranoid is in a relaxed
+/sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
 TRACING
diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
index fa4f39d305a7..5b479f5e62ff 100644
--- a/tools/perf/Documentation/perf-script-perl.txt
+++ b/tools/perf/Documentation/perf-script-perl.txt
@@ -55,7 +55,7 @@ Traces meant to be processed using a script should be recorded with
 the above option: -a to enable system-wide collection.
 
 The format file for the sched_wakeup event defines the following fields
-(see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
+(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
 
 ----
  format:
diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index cf4b7f4b625a..6a8581012e16 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -319,7 +319,7 @@ So those are the essential steps in writing and running a script.  The
 process can be generalized to any tracepoint or set of tracepoints
 you're interested in - basically find the tracepoint(s) you're
 interested in by looking at the list of available events shown by
-'perf list' and/or look in /sys/kernel/debug/tracing/events/ for
+'perf list' and/or look in /sys/kernel/tracing/events/ for
 detailed event and field info, record the corresponding trace data
 using 'perf record', passing it the list of interesting events,
 generate a skeleton script using 'perf script -g python' and modify the
@@ -449,7 +449,7 @@ Traces meant to be processed using a script should be recorded with
 the above option: -a to enable system-wide collection.
 
 The format file for the sched_wakeup event defines the following fields
-(see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
+(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
 
 ----
  format:
-- 
2.39.1.456.gfc5497dd1b-goog

