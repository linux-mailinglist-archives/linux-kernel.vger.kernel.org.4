Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA26175D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKCEzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKCEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C93417E1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:55:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so1135511ybj.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aytaF9VJiZ59kp8/UqWu1XpON56xoCf/kQCMxXol+VU=;
        b=kEyteBHALJtRTPCwr3TZEqux/nFBzmqZ8z83EVjNVsVjV8geGkB546cSN8DcWAK3xx
         /8shHqXyw5Yq7GzzLxX7kaoQiW7lV6WRAAtknxyu4kv6jpU8KPoyUAZSRnCwp6xhn59U
         G/SKDZ32p4ES1uJKV6NbORrmpTcpfRSLhr/9IO3f8sXFgMAreer+RDjj+YoKp+KSh5CK
         YkNEXYD2qTEpKqpH/vhU0mvi7Fwl9qJnICFYdyyM8YslYE/Tag2jAJJVd0wDOocFLGQ9
         xggyXpeHeV6ZBmx1CXgffPDeVODayjtgvfMrzUpT/6E+JoEWw1HtFv83jLOYakqalFif
         oJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aytaF9VJiZ59kp8/UqWu1XpON56xoCf/kQCMxXol+VU=;
        b=Ff90Sdfwx3Hzre0JdyPxATLOU0SyPNyR8eBydA47WQJ4Eovc3poe8FXFxIUGc1ypBR
         3wQ6kHfS8HSlmhy5HHOmeo6JwRwolBOoUmbm/SbgJSSYd7pJhG7Wk9xwjq7XcECkAr7F
         5SusXQx3YprsxPyZHlokj5aPEKTfxWX7pWA54VzrPaAW+iSHg1nRCrZHNxNTLD/KMby9
         pGXDSNtip0wNF/p/Keb6pxqhkzq4PutNhxDmfRkdhSFrJ6w+a7yNI98NubSbeoei2dLx
         J9hUZwaX5Yuv5ybE2KenQOMqDDDx9y0BTpfpeSIW/mz2bm/zJ7zJ1TqgmfOpuMYXdu43
         iNGQ==
X-Gm-Message-State: ACrzQf3hZ0X/ZlV+XTjcQvH6vBwm1rjFAU36geL9fJiMHKUrKzgXBzPc
        L+sN9OUpHZRBHzYlWgBHwE4pg7gjgqne
X-Google-Smtp-Source: AMsMyM7AUCs27q2zSxplxe1yi+Xzo6Vjq3rCThtq/3CxXMtYOH8jSxY5fbFRQ+Je3I9c8ngMwAGpB4AQA9oK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:ddd2:0:b0:367:27b6:db71 with SMTP id
 g201-20020a0dddd2000000b0036727b6db71mr185334ywe.432.1667451327234; Wed, 02
 Nov 2022 21:55:27 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:35 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-6-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 5/7] perf trace: empty fix libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
headers.  Add raw_syscalls:sys_enter to avoid the evlist being empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/empty.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 7d7fb0c9fe76..3e296c0c53d7 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,3 +1,12 @@
-#include <bpf/bpf.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
-license(GPL);
+struct syscall_enter_args;
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
+{
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

