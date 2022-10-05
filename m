Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6E5F5AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJEUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:14:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41B1AF2D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:14:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu30so7618616wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=x8RV8VG+A4vngdgkQwHX3NLb0hjKfGrsT3m3maaP/EU=;
        b=m8gfm9uxhvPKKE//tDmfaojO9Kj90ty5lb0l0k/YYMUHA96yGsza06b5nX43BCKWqt
         E3H4zq4tHepnH9Gc/nRhwX4jgIDdnSvPTn4ieEwbnZkybPV+7hii6xdhAGLjlk0Opuye
         QSfdcqGBl2E4z1rVdWz7YYtp/QqX4XH3xR1/vku1l4INl9lAOTWFpMRJYSF0+DD3P5ue
         Y9wOkuu+INxZxHKZYibUoN9FFBDZmC5eZnm5SLYou0rHXT98oXrIggZ4oyxGpq3lxC2h
         WlyyBOct7hPv2BF4m/pThE3HVktjRPtLfQUjHOFpJvaaLzB+oP2BsUlJP/b+g7wz0o8H
         YIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x8RV8VG+A4vngdgkQwHX3NLb0hjKfGrsT3m3maaP/EU=;
        b=6wwVh/VmDEVp34t8XjP4e6GW5FWngowQu6LNFbTeUIvcXPUn24ziZDG+u7hHvUwkeE
         Avw4/jyMa5bPAQ1dXVkUsiS1JT8YbCRHWG4Z/Ri1p6XyZ6B3cGKmJqoyE8ITPWwMX5Kf
         hN0diASVJpCKsaihyab6QwzxIWzM1Qkwc3ufiQZAHLrELsbomJPRvJWEe8s9utM3j6d8
         PjCXV9DEtUNQmsSg38Lr8N2b5VrOzdSnUuF0bF/2G/K8tHttYkHlOS9SR1YmSe3hHep5
         aDIF022YzrNryGxJ1hG/eIvXxoiWufEbluQfsTug3/wP+L6E9JHu9hafb6UcLJte9nBM
         mSHA==
X-Gm-Message-State: ACrzQf1jyipfphWQcYnaIwDWEgZXTqUJBStw1BZi8YH6SPmZ0jUsXpI4
        g1hlyDtUOthQo5Onr8OAme0YhcfQTg==
X-Google-Smtp-Source: AMsMyM5cOEtubVD24PO2IBl5Xln4D8Hu2tvec4KQQrRqilxO7IhlIIHUPJOZ5MdAn4nGwj2p048eWw==
X-Received: by 2002:adf:cf10:0:b0:22e:4e50:9161 with SMTP id o16-20020adfcf10000000b0022e4e509161mr785337wrj.587.1665000843099;
        Wed, 05 Oct 2022 13:14:03 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b0022ae0965a8asm15730778wro.24.2022.10.05.13.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:14:02 -0700 (PDT)
Date:   Wed, 5 Oct 2022 23:14:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: test how it holds up with mapping'less process
Message-ID: <Yz3liL6Dn+n2SD8Q@localhost.localdomain>
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

Create process without mappings and check

	/proc/*/maps
	/proc/*/numa_maps
	/proc/*/smaps
	/proc/*/smaps_rollup

They must be empty (excluding vsyscall page) or full of zeroes.

Retroactively this test should've caught embarassing /proc/*/smaps_rollup
oops:

[17752.703567] BUG: kernel NULL pointer dereference, address: 0000000000000000
[17752.703580] #PF: supervisor read access in kernel mode
[17752.703583] #PF: error_code(0x0000) - not-present page
[17752.703587] PGD 0 P4D 0
[17752.703593] Oops: 0000 [#1] PREEMPT SMP PTI
[17752.703598] CPU: 0 PID: 60649 Comm: cat Tainted: G        W         5.19.9-100.fc35.x86_64 #1
[17752.703603] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extreme6/3.1, BIOS P3.30 08/05/2016
[17752.703607] RIP: 0010:show_smaps_rollup+0x159/0x2e0

Note 1:
	ProtectionKey field in /proc/*/smaps is optional,
	so check most of its contents, not everything.

Note 2:
	due to the nature of this test, child process hardly can signal
	its readiness (after unmapping everything!) to parent.
	I feel like "sleep(1)" is justified.
	If you know how to do it without sleep please tell me.

Note 3:
	/proc/*/statm is not tested but can be.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore      |    1 
 tools/testing/selftests/proc/Makefile        |    1 
 tools/testing/selftests/proc/proc-empty-vm.c |  386 +++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -5,6 +5,7 @@
 /proc-fsconfig-hidepid
 /proc-loadavg-001
 /proc-multiple-procfs
+/proc-empty-vm
 /proc-pid-vm
 /proc-self-map-files-001
 /proc-self-map-files-002
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
+TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -0,0 +1,386 @@
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
+/*
+ * Create a process without mappings by unmapping everything at once and
+ * holding it with ptrace(2). See what happens to
+ *
+ *	/proc/${pid}/maps
+ *	/proc/${pid}/numa_maps
+ *	/proc/${pid}/smaps
+ *	/proc/${pid}/smaps_rollup
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+/*
+ * 0: vsyscall VMA doesn't exist	vsyscall=none
+ * 1: vsyscall VMA is --xp		vsyscall=xonly
+ * 2: vsyscall VMA is r-xp		vsyscall=emulate
+ */
+static int g_vsyscall;
+static const char *g_proc_pid_maps_vsyscall;
+static const char *g_proc_pid_smaps_vsyscall;
+
+static const char proc_pid_maps_vsyscall_0[] = "";
+static const char proc_pid_maps_vsyscall_1[] =
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
+static const char proc_pid_maps_vsyscall_2[] =
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
+
+static const char proc_pid_smaps_vsyscall_0[] = "";
+
+static const char proc_pid_smaps_vsyscall_1[] =
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n"
+"Size:                  4 kB\n"
+"KernelPageSize:        4 kB\n"
+"MMUPageSize:           4 kB\n"
+"Rss:                   0 kB\n"
+"Pss:                   0 kB\n"
+"Pss_Dirty:             0 kB\n"
+"Shared_Clean:          0 kB\n"
+"Shared_Dirty:          0 kB\n"
+"Private_Clean:         0 kB\n"
+"Private_Dirty:         0 kB\n"
+"Referenced:            0 kB\n"
+"Anonymous:             0 kB\n"
+"LazyFree:              0 kB\n"
+"AnonHugePages:         0 kB\n"
+"ShmemPmdMapped:        0 kB\n"
+"FilePmdMapped:         0 kB\n"
+"Shared_Hugetlb:        0 kB\n"
+"Private_Hugetlb:       0 kB\n"
+"Swap:                  0 kB\n"
+"SwapPss:               0 kB\n"
+"Locked:                0 kB\n"
+"THPeligible:    0\n"
+/*
+ * "ProtectionKey:" field is conditional. It is possible to check it as well,
+ * but I don't have such machine.
+ */
+;
+
+static const char proc_pid_smaps_vsyscall_2[] =
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n"
+"Size:                  4 kB\n"
+"KernelPageSize:        4 kB\n"
+"MMUPageSize:           4 kB\n"
+"Rss:                   0 kB\n"
+"Pss:                   0 kB\n"
+"Pss_Dirty:             0 kB\n"
+"Shared_Clean:          0 kB\n"
+"Shared_Dirty:          0 kB\n"
+"Private_Clean:         0 kB\n"
+"Private_Dirty:         0 kB\n"
+"Referenced:            0 kB\n"
+"Anonymous:             0 kB\n"
+"LazyFree:              0 kB\n"
+"AnonHugePages:         0 kB\n"
+"ShmemPmdMapped:        0 kB\n"
+"FilePmdMapped:         0 kB\n"
+"Shared_Hugetlb:        0 kB\n"
+"Private_Hugetlb:       0 kB\n"
+"Swap:                  0 kB\n"
+"SwapPss:               0 kB\n"
+"Locked:                0 kB\n"
+"THPeligible:    0\n"
+/*
+ * "ProtectionKey:" field is conditional. It is possible to check it as well,
+ * but I'm too tired.
+ */
+;
+
+static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
+{
+	_exit(EXIT_FAILURE);
+}
+
+static void sigaction_SIGSEGV_vsyscall(int _, siginfo_t *__, void *___)
+{
+	_exit(g_vsyscall);
+}
+
+/*
+ * vsyscall page can't be unmapped, probe it directly.
+ */
+static void vsyscall(void)
+{
+	pid_t pid;
+	int wstatus;
+
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "fork, errno %d\n", errno);
+		exit(1);
+	}
+	if (pid == 0) {
+		setrlimit(RLIMIT_CORE, &(struct rlimit){});
+
+		/* Hide "segfault at ffffffffff600000" messages. */
+		struct sigaction act = {};
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = sigaction_SIGSEGV_vsyscall;
+		sigaction(SIGSEGV, &act, NULL);
+
+		g_vsyscall = 0;
+		/* gettimeofday(NULL, NULL); */
+		asm volatile (
+			"call %P0"
+			:
+			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
+			: "rax", "rcx", "r11"
+		);
+
+		g_vsyscall = 1;
+		*(volatile int *)0xffffffffff600000UL;
+
+		g_vsyscall = 2;
+		exit(g_vsyscall);
+	}
+	waitpid(pid, &wstatus, 0);
+	if (WIFEXITED(wstatus)) {
+		g_vsyscall = WEXITSTATUS(wstatus);
+	} else {
+		fprintf(stderr, "error: vsyscall wstatus %08x\n", wstatus);
+		exit(1);
+	}
+}
+
+static int test_proc_pid_maps(pid_t pid)
+{
+	char buf[4096];
+	snprintf(buf, sizeof(buf), "/proc/%u/maps", pid);
+	int fd = open(buf, O_RDONLY);
+	if (fd == -1) {
+		perror("open /proc/${pid}/maps");
+		return EXIT_FAILURE;
+	} else {
+		ssize_t rv = read(fd, buf, sizeof(buf));
+		close(fd);
+		if (g_vsyscall == 0) {
+			assert(rv == 0);
+		} else {
+			size_t len = strlen(g_proc_pid_maps_vsyscall);
+			assert(rv == len);
+			assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
+		}
+		return EXIT_SUCCESS;
+	}
+}
+
+static int test_proc_pid_numa_maps(pid_t pid)
+{
+	char buf[4096];
+	snprintf(buf, sizeof(buf), "/proc/%u/numa_maps", pid);
+	int fd = open(buf, O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			/*
+			 * /proc/${pid}/numa_maps is under CONFIG_NUMA,
+			 * it doesn't necessarily exist.
+			 */
+			return EXIT_SUCCESS;
+		}
+		perror("open /proc/${pid}/numa_maps");
+		return EXIT_FAILURE;
+	} else {
+		ssize_t rv = read(fd, buf, sizeof(buf));
+		close(fd);
+		assert(rv == 0);
+		return EXIT_SUCCESS;
+	}
+}
+
+static int test_proc_pid_smaps(pid_t pid)
+{
+	char buf[4096];
+	snprintf(buf, sizeof(buf), "/proc/%u/smaps", pid);
+	int fd = open(buf, O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			/*
+			 * /proc/${pid}/smaps is under CONFIG_PROC_PAGE_MONITOR,
+			 * it doesn't necessarily exist.
+			 */
+			return EXIT_SUCCESS;
+		}
+		perror("open /proc/${pid}/smaps");
+		return EXIT_FAILURE;
+	} else {
+		ssize_t rv = read(fd, buf, sizeof(buf));
+		close(fd);
+		if (g_vsyscall == 0) {
+			assert(rv == 0);
+		} else {
+			size_t len = strlen(g_proc_pid_maps_vsyscall);
+			/* TODO "ProtectionKey:" */
+			assert(rv > len);
+			assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
+		}
+		return EXIT_SUCCESS;
+	}
+}
+
+static const char g_smaps_rollup[] =
+"00000000-00000000 ---p 00000000 00:00 0                                  [rollup]\n"
+"Rss:                   0 kB\n"
+"Pss:                   0 kB\n"
+"Pss_Dirty:             0 kB\n"
+"Pss_Anon:              0 kB\n"
+"Pss_File:              0 kB\n"
+"Pss_Shmem:             0 kB\n"
+"Shared_Clean:          0 kB\n"
+"Shared_Dirty:          0 kB\n"
+"Private_Clean:         0 kB\n"
+"Private_Dirty:         0 kB\n"
+"Referenced:            0 kB\n"
+"Anonymous:             0 kB\n"
+"LazyFree:              0 kB\n"
+"AnonHugePages:         0 kB\n"
+"ShmemPmdMapped:        0 kB\n"
+"FilePmdMapped:         0 kB\n"
+"Shared_Hugetlb:        0 kB\n"
+"Private_Hugetlb:       0 kB\n"
+"Swap:                  0 kB\n"
+"SwapPss:               0 kB\n"
+"Locked:                0 kB\n"
+;
+
+static int test_proc_pid_smaps_rollup(pid_t pid)
+{
+	char buf[4096];
+	snprintf(buf, sizeof(buf), "/proc/%u/smaps_rollup", pid);
+	int fd = open(buf, O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			/*
+			 * /proc/${pid}/smaps_rollup is under CONFIG_PROC_PAGE_MONITOR,
+			 * it doesn't necessarily exist.
+			 */
+			return EXIT_SUCCESS;
+		}
+		perror("open /proc/${pid}/smaps_rollup");
+		return EXIT_FAILURE;
+	} else {
+		ssize_t rv = read(fd, buf, sizeof(buf));
+		close(fd);
+		assert(rv == sizeof(g_smaps_rollup) - 1);
+		assert(memcmp(buf, g_smaps_rollup, sizeof(g_smaps_rollup) - 1) == 0);
+		return EXIT_SUCCESS;
+	}
+}
+
+int main(void)
+{
+	int rv = EXIT_SUCCESS;
+
+	vsyscall();
+
+	switch (g_vsyscall) {
+	case 0:
+		g_proc_pid_maps_vsyscall  = proc_pid_maps_vsyscall_0;
+		g_proc_pid_smaps_vsyscall = proc_pid_smaps_vsyscall_0;
+		break;
+	case 1:
+		g_proc_pid_maps_vsyscall  = proc_pid_maps_vsyscall_1;
+		g_proc_pid_smaps_vsyscall = proc_pid_smaps_vsyscall_1;
+		break;
+	case 2:
+		g_proc_pid_maps_vsyscall  = proc_pid_maps_vsyscall_2;
+		g_proc_pid_smaps_vsyscall = proc_pid_smaps_vsyscall_2;
+		break;
+	default:
+		abort();
+	}
+
+	pid_t pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return EXIT_FAILURE;
+	} else if (pid == 0) {
+		rv = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+		if (rv != 0) {
+			if (errno == EPERM) {
+				fprintf(stderr,
+"Did you know? ptrace(PTRACE_TRACEME) doesn't work under strace.\n"
+				);
+				kill(getppid(), SIGTERM);
+				return EXIT_FAILURE;
+			}
+			perror("ptrace PTRACE_TRACEME");
+			return EXIT_FAILURE;
+		}
+
+		/*
+		 * Hide "segfault at ..." messages. Signal handler won't run.
+		 */
+		struct sigaction act = {};
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = sigaction_SIGSEGV;
+		sigaction(SIGSEGV, &act, NULL);
+
+#ifdef __amd64__
+		munmap(NULL, ((size_t)1 << 47) - 4096);
+#else
+#error "implement 'unmap everything'"
+#endif
+		return EXIT_FAILURE;
+	} else {
+		/*
+		 * TODO find reliable way to signal parent that munmap(2) completed.
+		 * Child can't do it directly because it effectively doesn't exist
+		 * anymore. Looking at child's VM files isn't 100% reliable either:
+		 * due to a bug they may not become empty or empty-like.
+		 */
+		sleep(1);
+
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_maps(pid);
+		}
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_numa_maps(pid);
+		}
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_smaps(pid);
+		}
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_smaps_rollup(pid);
+		}
+		/*
+		 * TODO test /proc/${pid}/statm, task_statm()
+		 * ->start_code, ->end_code aren't updated by munmap().
+		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
+		 */
+
+		/* Cut the rope. */
+		int wstatus;
+		waitpid(pid, &wstatus, 0);
+		assert(WIFSTOPPED(wstatus));
+		assert(WSTOPSIG(wstatus) == SIGSEGV);
+	}
+
+	return rv;
+}
