Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C46175CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKCEzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKCEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:54:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514917E0C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:54:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h67-20020a252146000000b006ccc4702068so1115879ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ2um6c1slJC7mFKEqkDgLoAnh4NP6kllgPCGRDYU3g=;
        b=DHyGb7HoSpr040k5uJEFe9wBkt7167do1UmLynLyH7i9mUWinY5NVyCMyuqvQ6OmKV
         CLT34lD3Qc+ttTZ7chOOm6AemNbVfckUEOf69YpqGwJHWYoe93kMc81jnE+V+Qj8QqYb
         Op/jfokAzEDmJ0O0W6nxvl8uFLmiFLP+9i/M8tpBMw4ELp/aMj9fVvh2uh31hrFNBPPk
         PofLimqurLiDI2/PR5lOLinOb8luvpM1Wx+1fx3x3KcfNjBdvTecU73Irv1hINeW7BPf
         4BX9pJDUv5OJnKYWOm5tpG8O7ha+CpAA1DlHTpFW50iYnOek9wIPRD1C7Hph1lKkf5T3
         ReNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ2um6c1slJC7mFKEqkDgLoAnh4NP6kllgPCGRDYU3g=;
        b=sVe/IUUv1MLwhp3/EjigbPPv8V8bb4+HlDSdD4cexsPCqPweTB8r7EJfvj8riIBXqx
         GgC/tX84XNa/JGH5ECuQiQUvpU+4oQ0fjK5D2lDR49iAKxvq70jhmqZ94b39mCzhOFGn
         rPc+92NV/41Ko+0hXRuPYnXCbyA1Il7l7CJMeHFsgFz7qhKg3HUSUK7IdSa3cCAPG+Hy
         UesOprwJhpZrUvxN3OL29baf7WPFCPSx3qDYwp6z4KRUbwajzNYGLPuielCds54tLhUB
         BZYQ3XjwvnYwfKTD9kAotLX5XnguBULrJQTmLQdfqpcjiAwOkvhcdrXs9FJcV/DRBe1N
         w3DQ==
X-Gm-Message-State: ACrzQf3aGO2qaEmIHjlbDosHiYSX0A2h6VaIKZ+nRsdPfJBV3bqdxcc+
        C/CaLG9JdesImNmxgM281z63DwUGuzkX
X-Google-Smtp-Source: AMsMyM41EYdW4Fepyy6eE2wThz3USEHotnrEX8Xm3fBADOLCi7moleXHTwl3G2eXvoHch9hyWyr2Kvrhoog+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:f9c2:0:b0:36f:9950:c456 with SMTP id
 j185-20020a0df9c2000000b0036f9950c456mr180239ywf.338.1667451295275; Wed, 02
 Nov 2022 21:54:55 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:31 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-2-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 1/7] perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use deprecated and now broken map style. Avoid use of
tools/perf/include/bpf/bpf.h and use the more regular BPF headers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 75 ++++++++++++++-----
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index a262dcd020f4..13c72fd602c3 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -14,13 +14,19 @@
  * code that will combine entry/exit in a strace like way.
  */
 
-#include <unistd.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
-#include <linux/socket.h>
-#include <pid_filter.h>
+#include <stdbool.h>
+#include <sys/socket.h>
 
 /* bpf-output associated map */
-bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
+struct __augmented_syscalls__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, __NR_CPUS__);
+} __augmented_syscalls__ SEC(".maps");
 
 /*
  * string_args_len: one per syscall arg, 0 means not a string or don't copy it,
@@ -29,24 +35,39 @@ bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
  */
 struct syscall {
 	bool	enabled;
-	u16	string_args_len[6];
+	__u16	string_args_len[6];
 };
 
-bpf_map(syscalls, ARRAY, int, struct syscall, 512);
+struct syscalls {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct syscall);
+	__uint(max_entries, 512);
+} syscalls SEC(".maps");
 
 /*
  * What to augment at entry?
  *
  * Pointer arg payloads (filenames, etc) passed from userspace to the kernel
  */
-bpf_map(syscalls_sys_enter, PROG_ARRAY, u32, u32, 512);
+struct syscalls_sys_enter {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 512);
+} syscalls_sys_enter SEC(".maps");
 
 /*
  * What to augment at exit?
  *
  * Pointer arg payloads returned from the kernel (struct stat, etc) to userspace.
  */
-bpf_map(syscalls_sys_exit, PROG_ARRAY, u32, u32, 512);
+struct syscalls_sys_exit {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 512);
+} syscalls_sys_exit SEC(".maps");
 
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
@@ -66,7 +87,12 @@ struct augmented_arg {
 	char		value[PATH_MAX];
 };
 
-pid_filter(pids_filtered);
+struct pids_filtered {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 64);
+} pids_filtered SEC(".maps");
 
 struct augmented_args_payload {
        struct syscall_enter_args args;
@@ -79,7 +105,12 @@ struct augmented_args_payload {
 };
 
 // We need more tmp space than the BPF stack can give us
-bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
+struct augmented_args_tmp {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct augmented_args_payload);
+	__uint(max_entries, 1);
+} augmented_args_tmp SEC(".maps");
 
 static inline struct augmented_args_payload *augmented_args_payload(void)
 {
@@ -90,14 +121,14 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
 {
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
 }
 
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
 	unsigned int augmented_len = sizeof(*augmented_arg);
-	int string_len = probe_read_str(&augmented_arg->value, arg_len, arg);
+	int string_len = bpf_probe_read_str(&augmented_arg->value, arg_len, arg);
 
 	augmented_arg->size = augmented_arg->err = 0;
 	/*
@@ -146,7 +177,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	if (socklen > sizeof(augmented_args->saddr))
 		socklen = sizeof(augmented_args->saddr);
 
-	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -165,7 +196,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 	if (socklen > sizeof(augmented_args->saddr))
 		socklen = sizeof(augmented_args->saddr);
 
-	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -234,6 +265,16 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
+static pid_t getpid(void)
+{
+	return bpf_get_current_pid_tgid();
+}
+
+static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
+{
+	return bpf_map_lookup_elem(pids, &pid) != NULL;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -257,7 +298,7 @@ int sys_enter(struct syscall_enter_args *args)
 	if (augmented_args == NULL)
 		return 1;
 
-	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
+	bpf_probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
@@ -278,7 +319,7 @@ int sys_exit(struct syscall_exit_args *args)
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-	probe_read(&exit_args, sizeof(exit_args), args);
+	bpf_probe_read(&exit_args, sizeof(exit_args), args);
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
@@ -291,4 +332,4 @@ int sys_exit(struct syscall_exit_args *args)
 	return 0;
 }
 
-license(GPL);
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

