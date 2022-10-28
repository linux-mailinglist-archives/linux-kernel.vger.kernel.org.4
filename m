Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661D9611AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1Td6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ1Tdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:33:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BC823B697
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:33:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z18so4298913edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wZ5SAMO/Rxq5hIzkJ9wiscYq/ayYI7n9xaja8qXhuc=;
        b=lNLdGMuOAAbKn93P3Z0WRZI8aF+b9ALRvIe1nOPA9CgwRw/ySeJGW8hXWD2E1MNTiW
         8dyfzP2vj9GqU+gai4iBhiIro8Q+1CD9FfNVyrRg47V3Cx9Cor/5qYOlt/0pXKYVfy3q
         K4fo9klKa83jh0QBKcakLt+AGnLkfX/qyluSTKSVNR9d4UhBp68BRxh/EevrJUKJ1hf3
         ObYCO8VyQfkci5ErZ/BDYA5NAJQD6Pur8L2snYClIOYUhcBAF9Z4MnsCuaQ0OV1U51kO
         yyIpxRfEU5Smz8VTMtwLh/ZK4JYIqA1Kfwsn8HyOzuDYhJfVdkiaj3Krje6kM7FXkLri
         F9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wZ5SAMO/Rxq5hIzkJ9wiscYq/ayYI7n9xaja8qXhuc=;
        b=kU/CfobCl7Oo+LZILtwlMaU873ZNpJ2jXxrvTMzU1A3q0ySEDd6t/UmrrsULH6Os5U
         MdoS2tCwgPfaUvYTMbNnVRhsEnyByJ+OEY1fIrIbQstpWdvAEV+pgzaQBqJXQAiNgf10
         bGGutyEbcVDcCvHQnQT8IwB6GqcRmbCpkbiyOU0TsY9vSCuuPITiFBMCPjewDsCaohSj
         ZmTi1BgdLzEWHQTOMS8lhF3GUkUEoN3DlmbqVBJCEGe79Z9r+6vxdWFtOPQgMFX2Wmr0
         dw3NZrv8b4HgTj0eib9C3+w6JHCxYavR3FjXsGNojeku3mheDuzD+LMbUf09SDtKcIjp
         9vGQ==
X-Gm-Message-State: ACrzQf2s5eEoI+dVspmypEBOZ96Taemsu/Qti9TaqSjWoXkVKqWVrdNe
        WuimDUgnjCrnToSRymX0gw==
X-Google-Smtp-Source: AMsMyM68UkkIAxMkvbTr0ARWa+qe97usbMMc5i7+f94KHMbF1XDSj1hfrwoiYS0I5lpTUIyFxCcFng==
X-Received: by 2002:a05:6402:249f:b0:453:eb1b:1f8b with SMTP id q31-20020a056402249f00b00453eb1b1f8bmr939372eda.235.1666985632001;
        Fri, 28 Oct 2022 12:33:52 -0700 (PDT)
Received: from p183 ([46.53.251.139])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640205cf00b00461cdda400esm3107078edx.4.2022.10.28.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:33:51 -0700 (PDT)
Date:   Fri, 28 Oct 2022 22:33:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y1wunXB2iv0QHr22@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During Meltdown drama Microsoft managed to screw up pagetables and give
full kernel memory access to userspace:

	https://blog.frizk.net/2018/03/total-meltdown.html

We don't want _any_ of that.

This utility named ffff8 tries to read upper half of virtual address space
and report access that went through (excluding vsyscall page if present).

It works by doing access and rewriting RDI in the SIGSEGV handler.

I've tested it with kernel patch which installs rogue page and it was found.

	$ ./a.out -h
	usage: ./a.out [-f] [-r] [-n N] [-s S]
	        -f: sequential scan
	        -r: random scan (default)
	        -n: use N threads (default: $(nproc))
	        -s: lowest address shift (default: 47)
	        -t: time to run (default: 256 seconds)

Intended usages are:

	$ ./a.out -f		# full scan on all cores
or
	$ ./a.out -r -t ...	# time limited random scan for QA test

Features include:
* multithreading
* auto spreads over CPUs given by taskset
* full sequential scan / random scan
* auto split work for full scan
* smaller than 47-bit scanning (for benchmarking)
* time limit

Note 1:
HT appears to make scanning slower. If this is the case use taskset(1)
to exclude HT siblings.

Note 2:
Full 47-bit window scan takes a long time. My 16c/32t potato can do it
in ~8 hours. Benchmark with smaller shifts first.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/x86/Makefile |    2 
 tools/testing/selftests/x86/ffff8.c  |  400 +++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 1 deletion(-)

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
 
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/x86/ffff8.c
@@ -0,0 +1,400 @@
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
+/*
+ * 0: vsyscall VMA doesn't exist	vsyscall=none
+ * 1: vsyscall VMA is --xp		vsyscall=xonly
+ * 2: vsyscall VMA is r-xp		vsyscall=emulate
+ */
+static int g_vsyscall;
+#define VSYSCALL_ADDR	0xffffffffff600000
+
+static void sigsegv_vsyscall(int _, siginfo_t *__, void *___)
+{
+        _exit(g_vsyscall);
+}
+
+/*
+ * vsyscall page can't be unmapped, probe it directly.
+ */
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
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = sigsegv_vsyscall;
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
+                *(volatile int *)VSYSCALL_ADDR;
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
+static void sigalrm(int _, siginfo_t *__, void *___)
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
+	uc->uc_mcontext.gregs[REG_RIP] = (uintptr_t)&f_seq;
+	/* Idea stolen from Sandsifter by Christopher Domas. */
+	uint64_t rdi = uc->uc_mcontext.gregs[REG_RDI];
+	rdi += PAGE_SIZE;
+	if (rdi == VSYSCALL_ADDR && g_vsyscall == 2) {
+		rdi += PAGE_SIZE;
+	}
+	uc->uc_mcontext.gregs[REG_RDI] = rdi;
+	if (0) {
+		printf("%016llx\n", (unsigned long long)rdi);
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
+static void sigsegv_rand(int _, siginfo_t *__, void *uc_)
+{
+	ucontext_t *uc = uc_;
+	uc->uc_mcontext.gregs[REG_RIP] = (uintptr_t)&f_rand;
+
+	struct thread_arg *arg = (struct thread_arg *)uc->uc_mcontext.gregs[REG_RDX];
+	uint64_t rdi;
+	do {
+		rdi = 0xffff800000000000 | next(arg->s);
+	} while ((rdi & 0xfffffffffffff000) == VSYSCALL_ADDR && g_vsyscall == 2);
+	uc->uc_mcontext.gregs[REG_RDI] = rdi;
+	if (0) {
+		printf("%016llx\n", (unsigned long long)rdi);
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
+	}
+
+	/* Just in case getrandom(2) doesn't exist or returns EAGAIN. */
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
+	int option_s = 47;
+	unsigned int option_t = 256;
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
+			printf("usage: %s [-f] [-r] [-n N] [-s S]\n", argv[0]);
+			printf("\t-f: sequential scan\n");
+			printf("\t-r: random scan (default)\n");
+			printf("\t-n: use N threads (default: $(nproc))\n");
+			printf("\t-s: lowest address shift (default: %d)\n", option_s);
+			printf("\t-t: time to run (default: %u seconds)\n", option_t);
+			return EXIT_FAILURE;
+		}
+	}
+	if (option_s < 12 || option_s > 47) {
+		fprintf(stderr, "error: -s %d\n", option_s);
+		return EXIT_FAILURE;
+	}
+	if (option_N < 0) {
+		fprintf(stderr, "error: -n %d\n", option_N);
+		return EXIT_FAILURE;
+	}
+
+	vsyscall();
+	printf("vsyscall %d\n", g_vsyscall);
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
+	uint64_t min_addr = ((uint64_t)-1) << option_s;
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
+		act.sa_sigaction = sigalrm;
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
