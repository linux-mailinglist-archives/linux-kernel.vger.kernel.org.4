Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995E636033
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiKWNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiKWNlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:41:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2E20F6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:29:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m22so42714892eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=773RRMVCPN6QPWjGJFIAY7FmZidOaNRJv0ENxs1SOnA=;
        b=WYm0dytNltf59pxcfavAgINQV0zsw+yDU7h5rQdJAMcHcjLlAcg3tKIdYZi8hc7/yq
         KOrpfda2Mn2sMB5TepPmZXyiY5AlKxzKQp3fWlF3VuL3Jjf2P1++FDpwy9WHJNRGaxWg
         TmBjyi/4I2ESOIY7I+fQFOCa8w7HjJQxevQQ4IPpPt87eTE3bIRv0tDTL0u7wTTbiJtp
         KVx0WokGAOQ+Xl2OpM+BsHkU4+cScqk4m42r/06QtpHVOhS4ZJVr5WIXQ5I+irYa1yXn
         2PpcoQmXDb0dVBaMOPF/KUmO1XDnVVtbEwjATAPdNI94EnvEXqMGKm+M5/nbJnGceh43
         ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=773RRMVCPN6QPWjGJFIAY7FmZidOaNRJv0ENxs1SOnA=;
        b=OxEZDlYjbXYUx3QKFr5zgyU2mIEbNOu8oTOX26Z+a6u9FGkWds1qG76IxV+fkdvwkE
         QmY1VESdMbgLfK78alxYK+JM+r1Dp9jKV8xNtg4S5Vhs/IE7WEeamtshVuo+lQWC29bi
         Hl4twubQzx3vEw0PYiaOkd4dZvSLFKLt6idECrCrUgmnZe334jRGcN/Y97FS9+UQd4gZ
         FJ6vmTTnT/onpyQspll1DdI4REECUZUg4JdGIqJCKIA0Qtjs6ZdZcNrUkpZDb5IDRxqJ
         0ifIhMdydbH5J+MGUn0Rs5vGFsvE0U63FboB3robWU5zF9aWW7x3yrbZ0mJSf1p8xxTy
         312w==
X-Gm-Message-State: ANoB5pnXHpRbW9L+F2WeP4svHO9SrMBkVFbEe+unhS4bKn4UHQP+S6Bi
        rD1ZcXQQxCfOopV309ts1wXWiSEVxQ==
X-Google-Smtp-Source: AA0mqf61VdtljBxjfIM4D3L9ClB+eFJynjF2pDF+QZtVmpumiOjqs8BbZyA9F2NX2xM6LT4UiWnjPA==
X-Received: by 2002:a17:906:4309:b0:78d:36d7:92ae with SMTP id j9-20020a170906430900b0078d36d792aemr7531427ejm.113.1669210169684;
        Wed, 23 Nov 2022 05:29:29 -0800 (PST)
Received: from p183 ([46.53.252.92])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0077f324979absm7193158ejb.67.2022.11.23.05.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:29:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:29:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y34gN2C48IZ+XevQ@p183>
References: <Y1wunXB2iv0QHr22@p183>
 <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com>
 <Y11h+mbtSEEwHKRZ@p183>
 <429982ba-e06f-e76b-061c-39db67558aa5@intel.com>
 <Y2DAk9zKYG9hT/Ov@p183>
 <6bbbb89b-1339-e5a1-b127-09270327b6c8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bbbb89b-1339-e5a1-b127-09270327b6c8@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9cef26875f96cd4ae507ed3af6f310d1dbde3352 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 28 Oct 2022 22:09:19 +0300
Subject: [PATCH 1/1] selftests/x86: add "ffff8" -- kernel memory scanner

During Meltdown drama Microsoft managed to screw up pagetables and give
full kernel memory access to userspace:

	https://blog.frizk.net/2018/03/total-meltdown.html

We don't want _any_ of that.

This utility named ffff8 tries to read upper half of virtual address space
and report access that went through (excluding vsyscall page if present).

It works by doing access and rewriting RDI in the SIGSEGV handler
which will fault again upon exiting.

I've tested it with kernel patch which installs rogue page vsyscall style
and the test found it:

	$ ./ffff8_64 -f -s 32
	g_mask ffffffff00000000
	vsyscall 1
	N 2 threads
	thread 0, cpu 0: min ffffffff00000000, max ffffffff80000000, seed 000000000180f050 0000000000000000
	thread 1, cpu 1: min ffffffff80000000, max 0000000000000000, seed 000000000180f078 0000000000000000
	thread 1, cpu 1: error: kernel memory read at ffffffffff602000

Usage:

	$ ./ffff8_64 -h
	usage: ./ffff8_64 [-f] [-r] [-n N] [-s S] [-t T]
	        -f: sequential scan
	        -r: random scan (default)
	        -n: use N threads (default: $(nproc))
	        -s: lowest address shift (default: 47)
	        -t: time to run (default: 4 seconds)

Intended usage is:

	$ ./ffff8_64 -f		# full scan on all cores
or
	$ ./ffff8_64 -r -t ...	# time limited random scan

Features include:
* multithreading
* auto spreads over CPUs allowed by taskset
* full address space scan (sequential)
* random scan (fully deterministic)
* auto split work in full scan mode
* smaller than 47/56-bit scanning (for benchmarking)
* time limit
* LA57 support

Note 1:
Both HT and many cores appear to make scanning slower due to ->mmap_lock
contention. If this is the case use taskset(1) to run on a few cores only.

Note 2:
Full 47-bit, let alone 56-bit, window scan takes a long time.
Benchmark with smaller shifts first before attempting full scan.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v3: default to 4 seconds for random scan

 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/ffff8.c  | 430 +++++++++++++++++++++++++++
 2 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/ffff8.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..b7555ccdad72 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx ffff8
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/ffff8.c b/tools/testing/selftests/x86/ffff8.c
new file mode 100644
index 000000000000..858b8d7f5d17
--- /dev/null
+++ b/tools/testing/selftests/x86/ffff8.c
@@ -0,0 +1,430 @@
+/*
+ * Copyright (c) 2022 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that kernel memory is unreadable from userspace. */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define BPL (8 * sizeof(unsigned long))
+#define PAGE_SIZE 4096
+
+static inline uint64_t rol64(uint64_t x, int n)
+{
+	return (x << n) | (x >> (64 - n));
+}
+
+/*
+ * xoroshiro128**
+ * Written in 2018 by David Blackman and Sebastiano Vigna (vigna@acm.org)
+ */
+static uint64_t next(uint64_t s[2])
+{
+	uint64_t s0 = s[0];
+	uint64_t s1 = s[1];
+	uint64_t rv = rol64(s0 * 5, 7) * 9;
+	s1 ^= s0;
+	s[0] = rol64(s0, 24) ^ s1 ^ (s1 << 16);
+	s[1] = rol64(s1, 37);
+	return rv;
+}
+
+static inline long sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *m)
+{
+	return syscall(SYS_sched_getaffinity, pid, len, m);
+}
+
+static inline long sys_sched_setaffinity(pid_t pid, unsigned int len, const unsigned long *m)
+{
+	return syscall(SYS_sched_setaffinity, pid, len, m);
+}
+
+static inline long sys_getrandom(void *buf, size_t len, unsigned int flags)
+{
+#ifndef SYS_getrandom
+#define SYS_getrandom 318
+#endif
+	return syscall(SYS_getrandom, buf, len, flags);
+}
+
+static int x86_virt_bits(void)
+{
+	FILE *f = fopen("/proc/cpuinfo", "r");
+	if (!f) {
+		fprintf(stderr, "error: open /proc/cpuinfo, errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t n;
+	while ((n = getline(&line, &len, f)) != -1) {
+		if (strncmp(line, "address sizes\t:", strlen("address sizes\t:")) == 0) {
+			int rv = atoi(strchr(line, ',') + 2);
+			free(line);
+			fclose(f);
+			return rv;
+		}
+	}
+	__builtin_trap();
+}
+
+/*
+ * 0: vsyscall VMA doesn't exist	vsyscall=none
+ * 1: vsyscall VMA is --xp		vsyscall=xonly
+ * 2: vsyscall VMA is r-xp		vsyscall=emulate
+ */
+static int g_vsyscall;
+#define VSYSCALL_ADDR	0xffffffffff600000
+
+static void sigsegv_vsyscall(int _)
+{
+        _exit(g_vsyscall);
+}
+
+static void vsyscall(void)
+{
+	pid_t pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "fork, errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+	if (pid == 0) {
+		setrlimit(RLIMIT_CORE, &(struct rlimit){});
+
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_handler = sigsegv_vsyscall;
+		sigaction(SIGSEGV, &act, NULL);
+
+		g_vsyscall = 0;
+		/* gettimeofday(NULL, NULL); */
+		asm volatile (
+			"call %P0"
+			:
+			: "i" (VSYSCALL_ADDR), "D" (NULL), "S" (NULL)
+			: "rax", "rcx", "r11"
+		);
+
+		g_vsyscall = 1;
+		*(volatile int *)VSYSCALL_ADDR;
+
+		g_vsyscall = 2;
+		exit(g_vsyscall);
+	}
+
+	int wstatus;
+	wait(&wstatus);
+	if (WIFEXITED(wstatus)) {
+		g_vsyscall = WEXITSTATUS(wstatus);
+	} else {
+		fprintf(stderr, "error: vsyscall wstatus %08x\n", wstatus);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void sigalrm(int _)
+{
+	exit(EXIT_SUCCESS);
+}
+
+struct thread_arg {
+	uint64_t min;
+	uint64_t max;
+	int id;
+	int cpu;
+	uint64_t s[2];
+};
+
+__attribute__((noreturn,used))
+static void error_exit(uint64_t addr, int _, const struct thread_arg *arg)
+{
+	if (arg->cpu >= 0) {
+		fprintf(stderr, "thread %d, cpu %d: error: kernel memory read at %016lx\n",
+			arg->id, arg->cpu, addr);
+	} else {
+		fprintf(stderr, "thread %d: error: kernel memory read at %016lx\n",
+			arg->id, addr);
+	}
+	exit(EXIT_FAILURE);
+}
+
+void f_seq(uint64_t min, uint64_t max, struct thread_arg *arg);
+asm (
+".global f_seq;"
+".type f_seq, @function;"
+"f_seq:"
+	"cmp	%rsi, %rdi;"
+	"je	1f;"
+	/*
+	 * Should fault and restart from the beginning of this function
+	 * with different address.
+	 */
+	"mov	(%rdi), %al;"
+	/* DEFCON 1: kernel memory is readable from userspace. */
+	"jmp	error_exit;"
+"1:"
+	"ret;"
+".size f_seq, .-f_seq;"
+);
+
+static void sigsegv_seq(int _, siginfo_t *__, void *uc_)
+{
+	ucontext_t *uc = uc_;
+
+	/* Idea stolen from Sandsifter by Christopher Domas. */
+	uint64_t rdi = uc->uc_mcontext.gregs[REG_RDI] + PAGE_SIZE;
+	if (rdi == VSYSCALL_ADDR && g_vsyscall == 2) {
+		rdi += PAGE_SIZE;
+	}
+	uc->uc_mcontext.gregs[REG_RDI] = rdi;
+
+	uc->uc_mcontext.gregs[REG_RIP] = (uintptr_t)&f_seq;
+	if (0) {
+		printf("%016lx\n", rdi);
+	}
+}
+
+void f_rand(uint64_t min, uint64_t max, struct thread_arg *arg);
+asm (
+".global f_rand;"
+".type f_rand, @function;"
+"f_rand:"
+	/*
+	 * Should fault and restart from the beginning of this function
+	 * with different address.
+	 */
+	"mov	(%rdi), %al;"
+	/* DEFCON 1: kernel memory is readable from userspace. */
+	"jmp	error_exit;"
+".size f_rand, .-f_rand;"
+);
+
+static uint64_t g_mask;
+
+static void sigsegv_rand(int _, siginfo_t *__, void *uc_)
+{
+	ucontext_t *uc = uc_;
+	struct thread_arg *arg = (struct thread_arg *)uc->uc_mcontext.gregs[REG_RDX];
+	uint64_t rdi;
+
+	do {
+		rdi = g_mask | next(arg->s);
+	} while ((rdi & ~(PAGE_SIZE - 1)) == VSYSCALL_ADDR && g_vsyscall == 2);
+	uc->uc_mcontext.gregs[REG_RDI] = rdi;
+	uc->uc_mcontext.gregs[REG_RIP] = (uintptr_t)&f_rand;
+	if (0) {
+		printf("%016lx\n", rdi);
+	}
+}
+
+static int g_mode = 'r';
+static unsigned int g_len = 0;
+
+static void *thread_fn(void *arg_)
+{
+	struct thread_arg *arg = arg_;
+
+	if (arg->cpu >= 0) {
+		unsigned long *m = calloc(1, g_len);
+		int bit = arg->cpu;
+		m[bit / BPL] |= 1UL << (bit % BPL);
+		sys_sched_setaffinity(0, g_len, m);
+		free(m);
+	}
+
+	/*
+	 * xoroshiro128** requires non-zero seed.
+	 * getrandom(2) may or may not exist or return EAGAIN.
+	 */
+	arg->s[0] = (uintptr_t)arg;
+	arg->s[1] = 0;
+	if (g_mode == 'r') {
+		do {
+#ifndef GRND_NONBLOCK
+#define GRND_NONBLOCK 1
+#endif
+			sys_getrandom(arg->s, sizeof(arg->s), GRND_NONBLOCK);
+		} while (arg->s[0] == 0 && arg->s[1] == 0);
+	}
+
+	if (arg->cpu >= 0) {
+		printf("thread %d, cpu %d: min %016lx, max %016lx, seed %016lx %016lx\n",
+			arg->id, arg->cpu, arg->min, arg->max, arg->s[0], arg->s[1]);
+	} else {
+		printf("thread %d: min %016lx, max %016lx, seed %016lx %016lx\n",
+			arg->id, arg->min, arg->max, arg->s[0], arg->s[1]);
+	}
+
+	if (g_mode == 'f') {
+		f_seq(arg->min, arg->max, arg);
+	} else {
+		f_rand(arg->min, arg->max, arg);
+	}
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	int option_N = 0;
+	int option_s = x86_virt_bits() - 1;
+	unsigned int option_t = 4;
+
+	int opt;
+	while ((opt = getopt(argc, argv, "fhn:rs:t:")) != -1) {
+		switch (opt) {
+		case 'f':
+			/* Full scan implies running for as long as it takes. */
+			g_mode = 'f';
+			option_t = 0;
+			break;
+
+		case 'r':
+			g_mode = 'r';
+			break;
+
+		case 'n':
+			option_N = atoi(optarg);
+			break;
+
+		case 's':
+			option_s = atoi(optarg);
+			break;
+
+		case 't':
+			option_t = atoi(optarg);
+			break;
+
+		case 'h':
+			printf("usage: %s [-f] [-r] [-n N] [-s S] [-t T]\n", argv[0]);
+			printf("\t-f: sequential scan\n");
+			printf("\t-r: random scan (default)\n");
+			printf("\t-n: use N threads (default: $(nproc))\n");
+			printf("\t-s: lowest address shift (default: %d)\n", option_s);
+			printf("\t-t: time to run (default: %u seconds)\n", option_t);
+			return EXIT_FAILURE;
+		}
+	}
+	if (option_s < 12 || option_s > 63) {
+		fprintf(stderr, "error: -s %d\n", option_s);
+		return EXIT_FAILURE;
+	}
+	if (option_N < 0) {
+		fprintf(stderr, "error: -n %d\n", option_N);
+		return EXIT_FAILURE;
+	}
+
+	g_mask = (uint64_t)-1 << option_s;
+	printf("g_mask %016lx\n", g_mask);
+
+	vsyscall();
+	printf("g_vsyscall %d\n", g_vsyscall);
+
+	unsigned long *m = NULL;
+	do {
+		g_len += sizeof(unsigned long);
+		free(m);
+		m = malloc(g_len);
+	} while (sys_sched_getaffinity(0, g_len, m) == -1 && errno == EINVAL);
+
+	int N;
+	if (option_N > 0) {
+		N = option_N;
+	} else {
+		N = 0;
+		for (int i = 0; i < g_len / sizeof(unsigned long); i += 1) {
+			N += __builtin_popcountl(m[i]);
+		}
+	}
+	printf("N %d threads\n", N);
+	if (option_t > 0) {
+		printf("T %u seconds\n", option_t);
+	}
+
+	{
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_flags = SA_SIGINFO;
+		if (g_mode == 'f') {
+			act.sa_sigaction = sigsegv_seq;
+		} else {
+			act.sa_sigaction = sigsegv_rand;
+		}
+		sigaction(SIGSEGV, &act, NULL);
+	}
+
+	pthread_t *pth = calloc(N, sizeof(pthread_t));
+	struct thread_arg *arg = calloc(N, sizeof(struct thread_arg));
+
+	uint64_t min_addr = g_mask;
+	uint64_t max_addr = 0;	/* exclusive */
+
+	uint64_t d = ((max_addr - min_addr) / N) & ~(PAGE_SIZE - 1);
+	uint64_t a = min_addr;
+	uint64_t b = a + d;
+
+	int bit = -1;
+	for (int i = 0; i < N; i += 1) {
+		arg[i].min = a;
+		/* No page left behind. */
+		arg[i].max = (i == N - 1) ? 0 : b;
+		arg[i].id = i;
+
+		if (option_N > 0) {
+			arg[i].cpu = -1;
+		} else {
+			do {
+				bit += 1;
+			} while ((m[bit / BPL] & (1UL << (bit % BPL))) == 0);
+			arg[i].cpu = bit;
+		}
+
+		a = b;
+		b += d;
+	}
+	free(m);
+
+	for (int i = 0; i < N; i += 1) {
+		int rv = pthread_create(&pth[i], NULL, thread_fn, &arg[i]);
+		if (rv != 0) {
+			fprintf(stderr, "error: pthread_create, rv %d\n", rv);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (option_t > 0) {
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_handler = sigalrm;
+		sigaction(SIGALRM, &act, NULL);
+
+		alarm(option_t);
+	}
+
+	for (int i = 0; i < N; i += 1) {
+		pthread_join(pth[i], NULL);
+	}
+
+	return EXIT_SUCCESS;
+}
-- 
2.38.1

