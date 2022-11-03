Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112536175D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKCE4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKCEzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28818E06
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:55:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so1190198ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUgYFeR5VfNnBAi81qTIwK/qXUSt8bp2iygLv7fkD0I=;
        b=LeDk8/TRVg8xXxlznJRt+RCwNDDHza+JEdecE94JgWkd3rGy6uwrw8Yl4PaThYu5/+
         z9HRGBHP8ToxGpa0HXQxp2QPs/Za8onmkLQ+zdmhIipKdGwVMCBQ+3PeBRYDFLRVsuOp
         ZphtKT5sO1e7s3qj+sBndvEzn4724j7Z/17Be8qF/nz/HcIX0k+z1MsHxxzVl03i+U5D
         5p/j/ttFlA0+J25pxMBFmkkQEyFmyq70sI/rwRTGBxAzZwsrkw2L1Njc3zNo78Ova3iZ
         mGoc91qD+Q8jtGjU7M+QvzbFRoWNs+w9DpHqOhWjdEM1bJhBTbXskj5df5j5Rr+rXYPL
         s0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUgYFeR5VfNnBAi81qTIwK/qXUSt8bp2iygLv7fkD0I=;
        b=hnqTRMDaOjZjJiJiaRRS2Xk3Qry0HCPDqo/9e5xyebrqIVlpT5uAub/5BF2GBwCszj
         z8HydQvF2+I8AZMiBJknymT4ue9zn5gFu+Ci4gaysYD/GesqGkYjPjeXwOXZPZBYuccT
         eT6y8YWByqwlTMywTVLmxv6MICRA27P/KKE6UyzUnOIRAek3rfCwB1g8g27tHnw96ROt
         G3S8YQQv3KQ/yQXVGoICVpDNDPpo1GSWYHDjaPAmQK9l6PLO1+8X7/i2SSaRhg+knNAY
         UhbrBaaqvGCXxetcrhyw6MrJ0mYvmx1BkQK5FuuauZYfiSNRLu2h+govz6xEcZIrjnlG
         6mZQ==
X-Gm-Message-State: ACrzQf2ayFwmcCQkSrw9Fxlts9piXLNFKboDTba/iFV86P3SbR1Q6fyK
        mwPZcthsMPTQ9ShpY1sPCl+OzaQut+nF
X-Google-Smtp-Source: AMsMyM7Y111fR7xKROa1RHADLVwif/tfIJe5C17IVuQjIhJqnZ3Zpotw2FwXO9aSGAPUssk+c+tONkUubZEg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a25:a08c:0:b0:6cf:e475:2b41 with SMTP id
 y12-20020a25a08c000000b006cfe4752b41mr7693876ybh.326.1667451343895; Wed, 02
 Nov 2022 21:55:43 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:37 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-8-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 7/7] perf bpf: Remove now unused BPF headers
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

Example code has migrated to use standard BPF header files, remove
unnecessary perf equivalents. Update install step to not try to copy
these.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf              |  5 --
 tools/perf/include/bpf/bpf.h          | 70 ---------------------------
 tools/perf/include/bpf/linux/socket.h | 24 ---------
 tools/perf/include/bpf/pid_filter.h   | 21 --------
 tools/perf/include/bpf/stdio.h        | 16 ------
 tools/perf/include/bpf/unistd.h       | 10 ----
 6 files changed, 146 deletions(-)
 delete mode 100644 tools/perf/include/bpf/bpf.h
 delete mode 100644 tools/perf/include/bpf/linux/socket.h
 delete mode 100644 tools/perf/include/bpf/pid_filter.h
 delete mode 100644 tools/perf/include/bpf/stdio.h
 delete mode 100644 tools/perf/include/bpf/unistd.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..67819f905611 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -960,11 +960,6 @@ endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBBPF
-	$(call QUIET_INSTALL, bpf-headers) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'; \
-		$(INSTALL) include/bpf/*.h -m 644 -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
-		$(INSTALL) include/bpf/linux/*.h -m 644 -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
 	$(call QUIET_INSTALL, bpf-examples) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
 		$(INSTALL) examples/bpf/*.c -m 644 -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
deleted file mode 100644
index b422aeef5339..000000000000
--- a/tools/perf/include/bpf/bpf.h
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#ifndef _PERF_BPF_H
-#define _PERF_BPF_H
-
-#include <uapi/linux/bpf.h>
-
-/*
- * A helper structure used by eBPF C program to describe map attributes to
- * elf_bpf loader, taken from tools/testing/selftests/bpf/bpf_helpers.h:
- */
-struct bpf_map {
-        unsigned int type;
-        unsigned int key_size;
-        unsigned int value_size;
-        unsigned int max_entries;
-        unsigned int map_flags;
-        unsigned int inner_map_idx;
-        unsigned int numa_node;
-};
-
-#define bpf_map(name, _type, type_key, type_val, _max_entries)	\
-struct bpf_map SEC("maps") name = {				\
-	.type	     = BPF_MAP_TYPE_##_type,			\
-	.key_size    = sizeof(type_key),			\
-	.value_size  = sizeof(type_val),			\
-	.max_entries = _max_entries,				\
-};								\
-struct ____btf_map_##name {					\
-	type_key key;						\
-	type_val value;                                 	\
-};								\
-struct ____btf_map_##name __attribute__((section(".maps." #name), used)) \
-	____btf_map_##name = { }
-
-/*
- * FIXME: this should receive .max_entries as a parameter, as careful
- *	  tuning of these limits is needed to avoid hitting limits that
- *	  prevents other BPF constructs, such as tracepoint handlers,
- *	  to get installed, with cryptic messages from libbpf, etc.
- *	  For the current need, 'perf trace --filter-pids', 64 should
- *	  be good enough, but this surely needs to be revisited.
- */
-#define pid_map(name, value_type) bpf_map(name, HASH, pid_t, value_type, 64)
-
-static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
-static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
-
-static void (*bpf_tail_call)(void *ctx, void *map, int index) = (void *)BPF_FUNC_tail_call;
-
-#define SEC(NAME) __attribute__((section(NAME),  used))
-
-#define probe(function, vars) \
-	SEC(#function "=" #function " " #vars) function
-
-#define syscall_enter(name) \
-	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
-
-#define syscall_exit(name) \
-	SEC("syscalls:sys_exit_" #name) syscall_exit_ ## name
-
-#define license(name) \
-char _license[] SEC("license") = #name; \
-int _version SEC("version") = LINUX_VERSION_CODE;
-
-static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
-static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
-
-static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
-
-#endif /* _PERF_BPF_H */
diff --git a/tools/perf/include/bpf/linux/socket.h b/tools/perf/include/bpf/linux/socket.h
deleted file mode 100644
index 7f844568dab8..000000000000
--- a/tools/perf/include/bpf/linux/socket.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_SOCKET_H
-#define _UAPI_LINUX_SOCKET_H
-
-/*
- * Desired design of maximum size and alignment (see RFC2553)
- */
-#define _K_SS_MAXSIZE	128	/* Implementation specific max size */
-#define _K_SS_ALIGNSIZE	(__alignof__ (struct sockaddr *))
-				/* Implementation specific desired alignment */
-
-typedef unsigned short __kernel_sa_family_t;
-
-struct __kernel_sockaddr_storage {
-	__kernel_sa_family_t	ss_family;		/* address family */
-	/* Following field(s) are implementation specific */
-	char		__data[_K_SS_MAXSIZE - sizeof(unsigned short)];
-				/* space to achieve desired size, */
-				/* _SS_MAXSIZE value minus size of ss_family */
-} __attribute__ ((aligned(_K_SS_ALIGNSIZE)));	/* force desired alignment */
-
-#define sockaddr_storage __kernel_sockaddr_storage
-
-#endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
deleted file mode 100644
index 6e61c4bdf548..000000000000
--- a/tools/perf/include/bpf/pid_filter.h
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-
-#ifndef _PERF_BPF_PID_FILTER_
-#define _PERF_BPF_PID_FILTER_
-
-#include <bpf.h>
-
-#define pid_filter(name) pid_map(name, bool)
-
-static int pid_filter__add(struct bpf_map *pids, pid_t pid)
-{
-	bool value = true;
-	return bpf_map_update_elem(pids, &pid, &value, BPF_NOEXIST);
-}
-
-static bool pid_filter__has(struct bpf_map *pids, pid_t pid)
-{
-	return bpf_map_lookup_elem(pids, &pid) != NULL;
-}
-
-#endif // _PERF_BPF_PID_FILTER_
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
deleted file mode 100644
index 316af5b2ff35..000000000000
--- a/tools/perf/include/bpf/stdio.h
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <bpf.h>
-
-struct bpf_map SEC("maps") __bpf_stdout__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
-
-#define puts(from) \
-	({ const int __len = sizeof(from); \
-	   char __from[__len] = from; \
-	   perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
-			  &__from, __len & (sizeof(from) - 1)); })
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
deleted file mode 100644
index ca7877f9a976..000000000000
--- a/tools/perf/include/bpf/unistd.h
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-
-#include <bpf.h>
-
-static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
-
-static pid_t getpid(void)
-{
-	return bpf_get_current_pid_tgid();
-}
-- 
2.38.1.273.g43a17bfeac-goog

