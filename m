Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA686175D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKCEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD417E04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:55:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h9-20020a25e209000000b006cbc4084f2eso1077498ybe.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVFGWePvwNmlXm2BOJFvtaMGSMXy8LREl0rrvfBjVA=;
        b=esd73Ew1HyHI7NYFtpnPAP9jY/cbc550EHnRTY8Ws6yN4OalaXE9EODfDf/NdUi/lS
         MY37wQkTs7e5rqXiIPuDVqbRrm84uW8eutX7Gp+H/Ao5NSNjHdhovqInJBCiGgQTFfNt
         rw0bb/XU1WYVN/2ilg5cPKz62ThFN1HUPfv4dwg8iRygeLv7OqzfNApFDDj/v/iQA6eQ
         uEn4TQfVYd8H/IzkWqefkA00nNq49wdvmVfBzHp5N76GmXQ9H2l9XCofEXtrCqH+hqgg
         dFgYuqIHPz8aF++8Vg1hlMtPrVxuYfhNxLhgFeu2ECVu/rJzGmm8pDYYFgHrLSDgWEMm
         RpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVFGWePvwNmlXm2BOJFvtaMGSMXy8LREl0rrvfBjVA=;
        b=qQC+S1tj3Y0gh8SxGQP/RcBYO9xLiP6VuovRZ7GYdHek6q4a20sCSeK9mrIBfpWznn
         UvRQnVLbj/4en/glnSAprzh0eHWDA4zs/CA2AO39NHlFg8L+cO7p+xribj7AeVOf8Gm/
         Y34IXpq22uMYspH5ZKNwooxf4XBucGCIxYWivFU4+pa8udiOKXVz2/rtdQrYGwzpc2PK
         SQDDrEtELpKyYnBFRCChZVpAq2oRb0+MrSVFkTaUeMiNOJLF6qNFylCxHS9jD8RhY50K
         zjoOkyw9xAlJ25do5i70INStIb1bttoYzEaFNG3bqL+h4J+PrRm+YSR00PJjLWIlqtxU
         kD+A==
X-Gm-Message-State: ACrzQf1vR3QRkNK7Ehyn6cQHdrivCAfoBULcMav4FivbCPtAg9/OCLgc
        kEImjDLLfgVB6kq69T6BVI7O93BB5Dlo
X-Google-Smtp-Source: AMsMyM4xeZfFWcIYHW7+VZ8bY5fEr0eMPQ3tVpLlB+nDmZ1z/3e6KwT36FpXWpzSq473i2iaq3+ly/BFyBcw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d:b0:6cb:9135:29d7 with SMTP id
 m13-20020a056902004d00b006cb913529d7mr23783827ybh.208.1667451318415; Wed, 02
 Nov 2022 21:55:18 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:34 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-5-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 4/7] perf trace: hello fix libbpf 1.0+ compatibility
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

Don't use deprecated and now broken map style. Avoid use of
tools/perf/include/bpf/bpf.h and use the more regular BPF headers.
Switch to raw_syscalls:sys_enter to avoid the evlist being
empty and fixing generating output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/hello.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
index cf3c2fdc7f79..e9080b0df158 100644
--- a/tools/perf/examples/bpf/hello.c
+++ b/tools/perf/examples/bpf/hello.c
@@ -1,9 +1,27 @@
-#include <stdio.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
-int syscall_enter(openat)(void *args)
+struct __bpf_stdout__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, __NR_CPUS__);
+} __bpf_stdout__ SEC(".maps");
+
+#define puts(from) \
+	({ const int __len = sizeof(from); \
+	   char __from[sizeof(from)] = from;			\
+	   bpf_perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
+			  &__from, __len & (sizeof(from) - 1)); })
+
+struct syscall_enter_args;
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
 {
 	puts("Hello, world\n");
 	return 0;
 }
 
-license(GPL);
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

