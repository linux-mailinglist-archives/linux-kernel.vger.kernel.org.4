Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4512561A22C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKDUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKDUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532D1ADB3;
        Fri,  4 Nov 2022 13:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9EF62285;
        Fri,  4 Nov 2022 20:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104C1C433D6;
        Fri,  4 Nov 2022 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667593809;
        bh=c7Tfz81xRf9WZuBuzfYaSrnJW0HRBQPHuv/lgGHwz8c=;
        h=Date:From:To:Cc:Subject:From;
        b=C7wsr/SpM/WHW9UuKo/+MpxGl1gy62biXEwW21PAB6ttiXtasUJ0EUDcPKZu01Dnh
         puw04hl5Gi02p5qFWWVFc8jhhiwrESNyo9KTiZ3D+lMf3zQasYCtyhc/GtGwT2GfO0
         d4zCqV1PpdbRQRf1+mMa6yNO9/Y51exy5cihwDA7kpuAkEot4NYeef9F8gz5UexKWg
         r0sZyhhgwpc/7+800k09fEnra7qviQ+kg4vVyu4kAhT/sKkwsQkPj4Tvfx2o32FVfg
         qRPTbbHvmkpoGsP9EhLw6wlw5BcgPlYTxQJApA4gJ6t7vhojsZP1607ZFhhcAipXtF
         7hrOp1qsRNPCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7ED624034E; Fri,  4 Nov 2022 17:30:06 -0300 (-03)
Date:   Fri, 4 Nov 2022 17:30:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Add BPF augmenter to perf_event_open()'s
 'struct perf_event_attr' arg
Message-ID: <Y2V2Tpu+2vzJyon2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please test it together with what is in my tmp.perf/core branch, as it
has the fixes for perf to build and run with libbpf 1.0, please install
libbpf-devel from your distro, at least for now.

There is polishing to do here, but its interesting as an example of how
to augment a syscall.

If you run 'perf trace -v' with
~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c you'll
see that it reuses augmenters for other syscalls that have similar
signatures, so, in the future, doing for one struct gets it reused in
all the other syscalls using such struct.

Also more annotation is needed, as with other syscalls already in 'perf
trace' to associate a type syscall integer arguments, for things like
flags, enumerations not using enum, etc.

- Arnaldo

----

Using BPF for that, doing a cleverish reuse of perf_event_attr__fprintf(),
that really needs to be turned into __snprintf(), etc.

But since the plan is to go the BTF way probably use libbpf's
btf_dump__dump_type_data().

Example:

[root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,perf_event_open --max-events 10 perf stat --quiet sleep 0.001
fg
     0.000 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x1, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
     0.067 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x3, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
     0.120 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x4, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 5
     0.172 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x2, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 7
     0.190 perf_event_open(attr_uptr: { size: 128, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 8
     0.199 perf_event_open(attr_uptr: { size: 128, config: 0x1, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 9
     0.204 perf_event_open(attr_uptr: { size: 128, config: 0x4, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 10
     0.210 perf_event_open(attr_uptr: { size: 128, config: 0x5, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 11
[root@quaco ~]#

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    |  3 +-
 .../examples/bpf/augmented_raw_syscalls.c     | 44 +++++++++++++++++++
 tools/perf/trace/beauty/perf_event_open.c     | 44 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 72991528687ea60b..5690c33c523b37d7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1053,7 +1053,8 @@ static struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "perf_event_open",
-	  .arg = { [2] = { .scnprintf = SCA_INT,	/* cpu */ },
+	  .arg = { [0] = { .scnprintf = SCA_PERF_ATTR,  /* attr */ },
+		   [2] = { .scnprintf = SCA_INT,	/* cpu */ },
 		   [3] = { .scnprintf = SCA_FD,		/* group_fd */ },
 		   [4] = { .scnprintf = SCA_PERF_FLAGS, /* flags */ }, }, },
 	{ .name	    = "pipe2",
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 926238efd7d8d0df..0599823e8ae1b4c0 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -129,6 +129,7 @@ struct augmented_args_payload {
 			struct augmented_arg arg, arg2;
 		};
 		struct sockaddr_storage saddr;
+		char   __data[sizeof(struct augmented_arg)];
 	};
 };
 
@@ -293,6 +294,49 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
+#define PERF_ATTR_SIZE_VER0     64      /* sizeof first published struct */
+
+// we need just the start, get the size to then copy it
+struct perf_event_attr_size {
+        __u32                   type;
+        /*
+         * Size of the attr structure, for fwd/bwd compat.
+         */
+        __u32                   size;
+};
+
+SEC("!syscalls:sys_enter_perf_event_open")
+int sys_enter_perf_event_open(struct syscall_enter_args *args)
+{
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+		goto failure;
+
+	if (bpf_probe_read(&augmented_args->__data, sizeof(*attr), attr) < 0)
+		goto failure;
+
+	attr_read = (const struct perf_event_attr_size *)augmented_args->__data;
+
+	__u32 size = attr_read->size;
+
+	if (!size)
+		size = PERF_ATTR_SIZE_VER0;
+
+	if (size > sizeof(augmented_args->__data))
+                goto failure;
+
+	// Now that we read attr->size and tested it against the size limits, read it completely
+	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
+		goto failure;
+
+	return augmented__output(args, augmented_args, len + size);
+failure:
+	return 1; /* Failure: don't filter */
+}
+
 static pid_t getpid(void)
 {
 	return bpf_get_current_pid_tgid();
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 11d47dbe63bd1edc..01ee15fe9d0c7a98 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -44,3 +44,47 @@ static size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size,
 }
 
 #define SCA_PERF_FLAGS syscall_arg__scnprintf_perf_flags
+
+struct attr_fprintf_args {
+	size_t size, printed;
+	char *bf;
+	bool first;
+};
+
+static int attr__fprintf(FILE *fp __maybe_unused, const char *name, const char *val, void *priv)
+{
+	struct attr_fprintf_args *args = priv;
+	size_t printed = scnprintf(args->bf + args->printed , args->size - args->printed, "%s%s: %s", args->first ? "" : ", ", name, val);
+
+	args->first = false;
+	args->printed += printed;
+	return printed;
+}
+
+static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf, size_t size, bool show_zeros __maybe_unused)
+{
+	struct attr_fprintf_args args = {
+		.printed = scnprintf(bf, size, "{ "),
+		.size    = size,
+		.first   = true,
+		.bf	 = bf,
+	};
+
+	perf_event_attr__fprintf(stdout, attr, attr__fprintf, &args);
+	return args.printed + scnprintf(bf + args.printed, size - args.printed, " }");
+}
+
+static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
+{
+	return perf_event_attr___scnprintf((void *)arg->augmented.args, bf, size, arg->trace->show_zeros);
+}
+
+static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->augmented.args)
+		return syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
+
+	return scnprintf(bf, size, "%#lx", arg->val);
+}
+
+#define SCA_PERF_ATTR syscall_arg__scnprintf_perf_event_attr
-- 
2.37.3

