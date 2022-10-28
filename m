Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAF611D48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJ1WPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ1WPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:15:16 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28EF80522
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29SMEVl33472852
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 28 Oct 2022 15:14:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29SMEVl33472852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1666995273;
        bh=lDZ8V/wvMnMCaGE4EGsoNUNgvkgMRiFi63Ump4cevgE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RN4FsapdrQWlgOZax4q62Gka2jtJhBYeusbnURV7DK+Q8xxP/WZMes6H401Fa0xXf
         NOOO/iPzgFZtdwO508X8AMdw/iDn1ECY7yw2IuaOKe8BGgx7T2nuDallXUF0yQSZpG
         iGgQUnrW80Bmgsxu2aUtPl87r3/rHTF3S7vY/938221wHSnJ8d97Gmvkr0O42aNV2b
         aB2Z0o3dOnty+d8efBw88s3dZXMv0KJUf7OW3sZAYAAuF3X+zFXjmpF1W8M8AiIxbg
         HyoENFhU4Du4HMyIrKXcQ1bMbM5a/yWRU7vlvli15vPn1NeJ8vGKrj/pc9kIClhqAD
         ilgKPvO3zdZCw==
Date:   Fri, 28 Oct 2022 15:14:31 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
CC:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] selftests/x86: add "ffff8" -- kernel memory scanner
User-Agent: K-9 Mail for Android
In-Reply-To: <Y1wunXB2iv0QHr22@p183>
References: <Y1wunXB2iv0QHr22@p183>
Message-ID: <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 28, 2022 12:33:49 PM PDT, Alexey Dobriyan <adobriyan@gmail=2Ecom=
> wrote:
>During Meltdown drama Microsoft managed to screw up pagetables and give
>full kernel memory access to userspace:
>
>	https://blog=2Efrizk=2Enet/2018/03/total-meltdown=2Ehtml
>
>We don't want _any_ of that=2E
>
>This utility named ffff8 tries to read upper half of virtual address spac=
e
>and report access that went through (excluding vsyscall page if present)=
=2E
>
>It works by doing access and rewriting RDI in the SIGSEGV handler=2E
>
>I've tested it with kernel patch which installs rogue page and it was fou=
nd=2E
>
>	$ =2E/a=2Eout -h
>	usage: =2E/a=2Eout [-f] [-r] [-n N] [-s S]
>	        -f: sequential scan
>	        -r: random scan (default)
>	        -n: use N threads (default: $(nproc))
>	        -s: lowest address shift (default: 47)
>	        -t: time to run (default: 256 seconds)
>
>Intended usages are:
>
>	$ =2E/a=2Eout -f		# full scan on all cores
>or
>	$ =2E/a=2Eout -r -t =2E=2E=2E	# time limited random scan for QA test
>
>Features include:
>* multithreading
>* auto spreads over CPUs given by taskset
>* full sequential scan / random scan
>* auto split work for full scan
>* smaller than 47-bit scanning (for benchmarking)
>* time limit
>
>Note 1:
>HT appears to make scanning slower=2E If this is the case use taskset(1)
>to exclude HT siblings=2E
>
>Note 2:
>Full 47-bit window scan takes a long time=2E My 16c/32t potato can do it
>in ~8 hours=2E Benchmark with smaller shifts first=2E
>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>---
>
> tools/testing/selftests/x86/Makefile |    2=20
> tools/testing/selftests/x86/ffff8=2Ec  |  400 ++++++++++++++++++++++++++=
+++++++++
> 2 files changed, 401 insertions(+), 1 deletion(-)
>
>--- a/tools/testing/selftests/x86/Makefile
>+++ b/tools/testing/selftests/x86/Makefile
>@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86 test_syscall_=
vdso unwind_vdso \
> 			test_FCMOV test_FCOMI test_FISTTP \
> 			vdso_restorer
> TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
>-			corrupt_xstate_header amx
>+			corrupt_xstate_header amx ffff8
> # Some selftests require 32bit support enabled also on 64bit systems
> TARGETS_C_32BIT_NEEDED :=3D ldt_gdt ptrace_syscall
>=20
>new file mode 100644
>--- /dev/null
>+++ b/tools/testing/selftests/x86/ffff8=2Ec
>@@ -0,0 +1,400 @@
>+/*
>+ * Copyright (c) 2022 Alexey Dobriyan <adobriyan@gmail=2Ecom>
>+ *
>+ * Permission to use, copy, modify, and distribute this software for any
>+ * purpose with or without fee is hereby granted, provided that the abov=
e
>+ * copyright notice and this permission notice appear in all copies=2E
>+ *
>+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANT=
IES
>+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
>+ * MERCHANTABILITY AND FITNESS=2E IN NO EVENT SHALL THE AUTHOR BE LIABLE=
 FOR
>+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGE=
S
>+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
>+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
>+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE=2E
>+ */
>+/* Test that kernel memory is unreadable from userspace=2E */
>+#undef _GNU_SOURCE
>+#define _GNU_SOURCE
>+#include <errno=2Eh>
>+#include <pthread=2Eh>
>+#include <signal=2Eh>
>+#include <stdint=2Eh>
>+#include <stdlib=2Eh>
>+#include <stdio=2Eh>
>+#include <sys/resource=2Eh>
>+#include <sys/syscall=2Eh>
>+#include <sys/wait=2Eh>
>+#include <unistd=2Eh>
>+
>+#define BPL (8 * sizeof(unsigned long))
>+#define PAGE_SIZE 4096
>+
>+static inline uint64_t rol64(uint64_t x, int n)
>+{
>+	return (x << n) | (x >> (64 - n));
>+}
>+
>+/*
>+ * xoroshiro128**
>+ * Written in 2018 by David Blackman and Sebastiano Vigna (vigna@acm=2Eo=
rg)
>+ */
>+static uint64_t next(uint64_t s[2])
>+{
>+	uint64_t s0 =3D s[0];
>+	uint64_t s1 =3D s[1];
>+	uint64_t rv =3D rol64(s0 * 5, 7) * 9;
>+	s1 ^=3D s0;
>+	s[0] =3D rol64(s0, 24) ^ s1 ^ (s1 << 16);
>+	s[1] =3D rol64(s1, 37);
>+	return rv;
>+}
>+
>+static inline long sys_sched_getaffinity(pid_t pid, unsigned int len, un=
signed long *m)
>+{
>+	return syscall(SYS_sched_getaffinity, pid, len, m);
>+}
>+
>+static inline long sys_sched_setaffinity(pid_t pid, unsigned int len, co=
nst unsigned long *m)
>+{
>+	return syscall(SYS_sched_setaffinity, pid, len, m);
>+}
>+
>+static inline long sys_getrandom(void *buf, size_t len, unsigned int fla=
gs)
>+{
>+#ifndef SYS_getrandom
>+#define SYS_getrandom 318
>+#endif
>+	return syscall(SYS_getrandom, buf, len, flags);
>+}
>+
>+/*
>+ * 0: vsyscall VMA doesn't exist	vsyscall=3Dnone
>+ * 1: vsyscall VMA is --xp		vsyscall=3Dxonly
>+ * 2: vsyscall VMA is r-xp		vsyscall=3Demulate
>+ */
>+static int g_vsyscall;
>+#define VSYSCALL_ADDR	0xffffffffff600000
>+
>+static void sigsegv_vsyscall(int _, siginfo_t *__, void *___)
>+{
>+        _exit(g_vsyscall);
>+}
>+
>+/*
>+ * vsyscall page can't be unmapped, probe it directly=2E
>+ */
>+static void vsyscall(void)
>+{
>+	pid_t pid =3D fork();
>+	if (pid < 0) {
>+		fprintf(stderr, "fork, errno %d\n", errno);
>+		exit(EXIT_FAILURE);
>+	}
>+	if (pid =3D=3D 0) {
>+		setrlimit(RLIMIT_CORE, &(struct rlimit){});
>+
>+		struct sigaction act =3D {};
>+		act=2Esa_flags =3D SA_SIGINFO;
>+		act=2Esa_sigaction =3D sigsegv_vsyscall;
>+		sigaction(SIGSEGV, &act, NULL);
>+
>+		g_vsyscall =3D 0;
>+		/* gettimeofday(NULL, NULL); */
>+		asm volatile (
>+			"call %P0"
>+			:
>+			: "i" (VSYSCALL_ADDR), "D" (NULL), "S" (NULL)
>+			: "rax", "rcx", "r11"
>+		);
>+
>+		g_vsyscall =3D 1;
>+                *(volatile int *)VSYSCALL_ADDR;
>+
>+		g_vsyscall =3D 2;
>+		exit(g_vsyscall);
>+	}
>+
>+	int wstatus;
>+	wait(&wstatus);
>+	if (WIFEXITED(wstatus)) {
>+		g_vsyscall =3D WEXITSTATUS(wstatus);
>+	} else {
>+		fprintf(stderr, "error: vsyscall wstatus %08x\n", wstatus);
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void sigalrm(int _, siginfo_t *__, void *___)
>+{
>+	exit(EXIT_SUCCESS);
>+}
>+
>+struct thread_arg {
>+	uint64_t min;
>+	uint64_t max;
>+	int id;
>+	int cpu;
>+	uint64_t s[2];
>+};
>+
>+__attribute__((noreturn,used))
>+static void error_exit(uint64_t addr, int _, const struct thread_arg *ar=
g)
>+{
>+	if (arg->cpu >=3D 0) {
>+		fprintf(stderr, "thread %d, cpu %d: error: kernel memory read at %016l=
x\n",
>+			arg->id, arg->cpu, addr);
>+	} else {
>+		fprintf(stderr, "thread %d: error: kernel memory read at %016lx\n",
>+			arg->id, addr);
>+	}
>+	exit(EXIT_FAILURE);
>+}
>+
>+void f_seq(uint64_t min, uint64_t max, struct thread_arg *arg);
>+asm (
>+"=2Eglobal f_seq;"
>+"=2Etype f_seq, @function;"
>+"f_seq:"
>+	"cmp	%rsi, %rdi;"
>+	"je	1f;"
>+	/*
>+	 * Should fault and restart from the beginning of this function
>+	 * with different address=2E
>+	 */
>+	"mov	(%rdi), %al;"
>+	/* DEFCON 1: kernel memory is readable from userspace=2E */
>+	"jmp	error_exit;"
>+"1:"
>+	"ret;"
>+"=2Esize f_seq, =2E-f_seq;"
>+);
>+
>+static void sigsegv_seq(int _, siginfo_t *__, void *uc_)
>+{
>+	ucontext_t *uc =3D uc_;
>+	uc->uc_mcontext=2Egregs[REG_RIP] =3D (uintptr_t)&f_seq;
>+	/* Idea stolen from Sandsifter by Christopher Domas=2E */
>+	uint64_t rdi =3D uc->uc_mcontext=2Egregs[REG_RDI];
>+	rdi +=3D PAGE_SIZE;
>+	if (rdi =3D=3D VSYSCALL_ADDR && g_vsyscall =3D=3D 2) {
>+		rdi +=3D PAGE_SIZE;
>+	}
>+	uc->uc_mcontext=2Egregs[REG_RDI] =3D rdi;
>+	if (0) {
>+		printf("%016llx\n", (unsigned long long)rdi);
>+	}
>+}
>+
>+void f_rand(uint64_t min, uint64_t max, struct thread_arg *arg);
>+asm (
>+"=2Eglobal f_rand;"
>+"=2Etype f_rand, @function;"
>+"f_rand:"
>+	/*
>+	 * Should fault and restart from the beginning of this function
>+	 * with different address=2E
>+	 */
>+	"mov	(%rdi), %al;"
>+	/* DEFCON 1: kernel memory is readable from userspace=2E */
>+	"jmp	error_exit;"
>+"=2Esize f_rand, =2E-f_rand;"
>+);
>+
>+static void sigsegv_rand(int _, siginfo_t *__, void *uc_)
>+{
>+	ucontext_t *uc =3D uc_;
>+	uc->uc_mcontext=2Egregs[REG_RIP] =3D (uintptr_t)&f_rand;
>+
>+	struct thread_arg *arg =3D (struct thread_arg *)uc->uc_mcontext=2Egregs=
[REG_RDX];
>+	uint64_t rdi;
>+	do {
>+		rdi =3D 0xffff800000000000 | next(arg->s);
>+	} while ((rdi & 0xfffffffffffff000) =3D=3D VSYSCALL_ADDR && g_vsyscall =
=3D=3D 2);
>+	uc->uc_mcontext=2Egregs[REG_RDI] =3D rdi;
>+	if (0) {
>+		printf("%016llx\n", (unsigned long long)rdi);
>+	}
>+}
>+
>+static int g_mode =3D 'r';
>+static unsigned int g_len =3D 0;
>+
>+static void *thread_fn(void *arg_)
>+{
>+	struct thread_arg *arg =3D arg_;
>+
>+	if (arg->cpu >=3D 0) {
>+		unsigned long *m =3D calloc(1, g_len);
>+		int bit =3D arg->cpu;
>+		m[bit / BPL] |=3D 1UL << (bit % BPL);
>+		sys_sched_setaffinity(0, g_len, m);
>+	}
>+
>+	/* Just in case getrandom(2) doesn't exist or returns EAGAIN=2E */
>+	arg->s[0] =3D (uintptr_t)arg;
>+	arg->s[1] =3D 0;
>+	if (g_mode =3D=3D 'r') {
>+		do {
>+#ifndef GRND_NONBLOCK
>+#define GRND_NONBLOCK 1
>+#endif
>+			sys_getrandom(arg->s, sizeof(arg->s), GRND_NONBLOCK);
>+		} while (arg->s[0] =3D=3D 0 && arg->s[1] =3D=3D 0);
>+	}
>+
>+	if (arg->cpu >=3D 0) {
>+		printf("thread %d, cpu %d: min %016lx, max %016lx, seed %016lx %016lx\=
n",
>+			arg->id, arg->cpu, arg->min, arg->max, arg->s[0], arg->s[1]);
>+	} else {
>+		printf("thread %d: min %016lx, max %016lx, seed %016lx %016lx\n",
>+			arg->id, arg->min, arg->max, arg->s[0], arg->s[1]);
>+	}
>+
>+	if (g_mode =3D=3D 'f') {
>+		f_seq(arg->min, arg->max, arg);
>+	} else {
>+		f_rand(arg->min, arg->max, arg);
>+	}
>+	return NULL;
>+}
>+
>+int main(int argc, char *argv[])
>+{
>+	int option_N =3D 0;
>+	int option_s =3D 47;
>+	unsigned int option_t =3D 256;
>+
>+	int opt;
>+	while ((opt =3D getopt(argc, argv, "fhn:rs:t:")) !=3D -1) {
>+		switch (opt) {
>+		case 'f':
>+			/* Full scan implies running for as long as it takes=2E */
>+			g_mode =3D 'f';
>+			option_t =3D 0;
>+			break;
>+
>+		case 'r':
>+			g_mode =3D 'r';
>+			break;
>+
>+		case 'n':
>+			option_N =3D atoi(optarg);
>+			break;
>+
>+		case 's':
>+			option_s =3D atoi(optarg);
>+			break;
>+
>+		case 't':
>+			option_t =3D atoi(optarg);
>+			break;
>+
>+		case 'h':
>+			printf("usage: %s [-f] [-r] [-n N] [-s S]\n", argv[0]);
>+			printf("\t-f: sequential scan\n");
>+			printf("\t-r: random scan (default)\n");
>+			printf("\t-n: use N threads (default: $(nproc))\n");
>+			printf("\t-s: lowest address shift (default: %d)\n", option_s);
>+			printf("\t-t: time to run (default: %u seconds)\n", option_t);
>+			return EXIT_FAILURE;
>+		}
>+	}
>+	if (option_s < 12 || option_s > 47) {
>+		fprintf(stderr, "error: -s %d\n", option_s);
>+		return EXIT_FAILURE;
>+	}
>+	if (option_N < 0) {
>+		fprintf(stderr, "error: -n %d\n", option_N);
>+		return EXIT_FAILURE;
>+	}
>+
>+	vsyscall();
>+	printf("vsyscall %d\n", g_vsyscall);
>+
>+	unsigned long *m =3D NULL;
>+	do {
>+		g_len +=3D sizeof(unsigned long);
>+		free(m);
>+		m =3D malloc(g_len);
>+	} while (sys_sched_getaffinity(0, g_len, m) =3D=3D -1 && errno =3D=3D E=
INVAL);
>+
>+	int N;
>+	if (option_N > 0) {
>+		N =3D option_N;
>+	} else {
>+		N =3D 0;
>+		for (int i =3D 0; i < g_len / sizeof(unsigned long); i +=3D 1) {
>+			N +=3D __builtin_popcountl(m[i]);
>+		}
>+	}
>+	printf("N %d threads\n", N);
>+	if (option_t > 0) {
>+		printf("T %u seconds\n", option_t);
>+	}
>+
>+	{
>+		struct sigaction act =3D {};
>+		sigemptyset(&act=2Esa_mask);
>+		act=2Esa_flags =3D SA_SIGINFO;
>+		if (g_mode =3D=3D 'f') {
>+			act=2Esa_sigaction =3D sigsegv_seq;
>+		} else {
>+			act=2Esa_sigaction =3D sigsegv_rand;
>+		}
>+		sigaction(SIGSEGV, &act, NULL);
>+	}
>+
>+	pthread_t *pth =3D calloc(N, sizeof(pthread_t));
>+	struct thread_arg *arg =3D calloc(N, sizeof(struct thread_arg));
>+
>+	uint64_t min_addr =3D ((uint64_t)-1) << option_s;
>+	uint64_t max_addr =3D 0;	/* exclusive */
>+
>+	uint64_t d =3D ((max_addr - min_addr) / N) & ~(PAGE_SIZE - 1);
>+	uint64_t a =3D min_addr;
>+	uint64_t b =3D a + d;
>+
>+	int bit =3D -1;
>+	for (int i =3D 0; i < N; i +=3D 1) {
>+		arg[i]=2Emin =3D a;
>+		/* No page left behind=2E */
>+		arg[i]=2Emax =3D (i =3D=3D N - 1) ? 0 : b;
>+		arg[i]=2Eid =3D i;
>+
>+		if (option_N > 0) {
>+			arg[i]=2Ecpu =3D -1;
>+		} else {
>+			do {
>+				bit +=3D 1;
>+			} while ((m[bit / BPL] & (1UL << (bit % BPL))) =3D=3D 0);
>+			arg[i]=2Ecpu =3D bit;
>+		}
>+
>+		a =3D b;
>+		b +=3D d;
>+	}
>+
>+	for (int i =3D 0; i < N; i +=3D 1) {
>+		int rv =3D pthread_create(&pth[i], NULL, thread_fn, &arg[i]);
>+		if (rv !=3D 0) {
>+			fprintf(stderr, "error: pthread_create, rv %d\n", rv);
>+			return EXIT_FAILURE;
>+		}
>+	}
>+
>+	if (option_t > 0) {
>+		struct sigaction act =3D {};
>+		sigemptyset(&act=2Esa_mask);
>+		act=2Esa_sigaction =3D sigalrm;
>+		sigaction(SIGALRM, &act, NULL);
>+
>+		alarm(option_t);
>+	}
>+
>+	for (int i =3D 0; i < N; i +=3D 1) {
>+		pthread_join(pth[i], NULL);
>+	}
>+
>+	return EXIT_SUCCESS;
>+}

Good initiative!

Only complaint I have is the name and the limit to LA48=2E LA57 (5-level p=
age tables) have the same potential issue=2E

You may want to consider doing a breadth-first sweep scanning by decreasin=
g powers of 2 as that will more quickly catch errors caused by problems in =
the upper levels of the page table hierarchy=2E
