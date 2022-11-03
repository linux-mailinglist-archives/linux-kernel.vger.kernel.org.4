Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6D46175CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKCEzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKCEzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B8F17ABF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:55:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so1138983ybf.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NO4EAaPdlCi62iB+M5zDGMRqIBRUtwLFDoXq6ZpSfuw=;
        b=ZoYo3Un1fIQpifOfk/INmb5tD31LpNepPPNKxroFffZ4XwuFjCmiylh1CpaLi0fMUE
         ZRTnvSK5Tu2RJsmP79Wx0JqMWvB9BEwZEhUEmGGuV7LGjx3Y9K6EOiYl+fXGtre0vLRM
         hIHWg1tID6B3vpAftbn9wjCNLXbezQmt3NbfbPcpPXjS10QWHqpMOppzX3I7Lv0qbfB+
         XzqwAKx40rlBCIbIrRNixgnvJ5QNVMEBnFywIgfLhqIEyra1MTEHE5nHNwzsB+zwuXMC
         eOfPLGu1rHP0zjRUGS/JXEUXTAFuhW4pAWj02EH2B+3Hga2MHADSKqFy3NuOlhASOjlu
         6l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO4EAaPdlCi62iB+M5zDGMRqIBRUtwLFDoXq6ZpSfuw=;
        b=VpoN3ZZl6sxdLPiMHDGgqAStlTftV+2o0YQFgbX1kCnYWz9MYl3igY8S7w7Axiy+QC
         KyJtZxPHYwoAZ6mcOD9g2Tl2JHLcbb0CmrhvO8QGIva0aD15ai9zJmCkiE7dYRzGkLVZ
         DmFcwS4gg9XpnvqtzJbVBJR2JEL2ey+2P8YbH0sXScW7W/YXszWMGx9UWvUJKe8eaEwF
         itqbg+/EgZOMBBc1gohA/3TbSdz0fCNqAnBO3J0zh9ZKkok2qodvEhK3a3KhzWUypYfy
         GiCvgejjqocZU46DzNqpnptowswErRpeUM/Vn6SP+npfYyuGd865nutWDNEQUTAWziKI
         vSog==
X-Gm-Message-State: ACrzQf0GTQgf2M80LKSeSSzFnoe3jMuV5n7mUoXB2dKaJE1odxRkJWH5
        fz9W8Xohiu+YDL+JGPryxcJpfmpUuJNn
X-Google-Smtp-Source: AMsMyM78oSDtfnW3xt5/Y4SvXCBCzuGhCfgfLwau6qa/1+zrjdA//EUcxUaLxEYHCfaMpS07MmHoCpn3Q57+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:c501:0:b0:36a:ca92:d207 with SMTP id
 h1-20020a0dc501000000b0036aca92d207mr189850ywd.429.1667451303556; Wed, 02 Nov
 2022 21:55:03 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:32 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-3-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 2/7] perf trace: Etcsnoop fix libbpf 1.0+ compatibility
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
Add "< 0" checks to fix BPF verifier failures about potentially
negative values being passed to bpf_perf_event_output. Add a
raw_syscalls:sys_enter to avoid the evlist being empty and causing
perf trace to exit during argument parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/etcsnoop.c | 41 ++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/perf/examples/bpf/etcsnoop.c b/tools/perf/examples/bpf/etcsnoop.c
index e81b535346c0..a04109d9b2b5 100644
--- a/tools/perf/examples/bpf/etcsnoop.c
+++ b/tools/perf/examples/bpf/etcsnoop.c
@@ -5,7 +5,7 @@
  *
  * Test it with:
  *
- * perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
+ * perf trace -e tools/perf/examples/bpf/etcsnoop.c cat /etc/passwd > /dev/null
  *
  * It'll catch some openat syscalls related to the dynamic linked and
  * the last one should be the one for '/etc/passwd'.
@@ -19,10 +19,17 @@
  * tools/perf/include/bpf/stdio.h.
  */
 
-#include <stdio.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
 /* bpf-output associated map */
-bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
+struct __augmented_syscalls__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, __NR_CPUS__);
+} __augmented_syscalls__ SEC(".maps");
+
 
 struct augmented_filename {
 	int	size;
@@ -30,6 +37,9 @@ struct augmented_filename {
 	char	value[64];
 };
 
+#define syscall_enter(name) \
+	SEC("!syscalls:sys_enter_" #name) syscall_enter_ ## name
+
 #define augmented_filename_syscall_enter(syscall) 						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
@@ -39,17 +49,25 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 {												\
 	char etc[6] = "/etc/";									\
 	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
+	long size;										\
+												\
+	if (bpf_probe_read(&augmented_args.args, sizeof(augmented_args.args), args) < 0)	\
+		return -1;									\
+												\
+	size = bpf_probe_read_str(&augmented_args.filename.value,				\
 						      sizeof(augmented_args.filename.value), 	\
 						      args->filename_ptr); 			\
+	if (size < 0)										\
+		return -1;									\
+												\
+	augmented_args.filename.size = size;							\
 	if (__builtin_memcmp(augmented_args.filename.value, etc, 4) != 0)			\
 		return 0;									\
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
+	return bpf_perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,		\
 				 &augmented_args,						\
 				 (sizeof(augmented_args) - sizeof(augmented_args.filename.value) + \
-				 augmented_args.filename.size));				\
+				 size));				\
 }
 
 struct syscall_enter_openat_args {
@@ -73,4 +91,11 @@ struct syscall_enter_open_args {
 
 augmented_filename_syscall_enter(open);
 
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

