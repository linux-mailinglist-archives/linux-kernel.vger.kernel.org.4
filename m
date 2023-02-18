Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F469B6DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjBRAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjBRAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:32:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E706EBB9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e83-20020a25e756000000b0086349255277so2438159ybh.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGrggQ/qDTMgdBpDhPDYEEJzTc7x7HUNebehORCAiA=;
        b=Ycfh2IW+hDbVlFvLyA3lntlwjCloreR3r/qvCLXWGq6CNK6K2k2C8p8Spq55zPyhuq
         AAzGAWCFdAKep93lG+yL4ZIn4/dB4F5SfgWiuIci0gRz5Jc/WSpHykVxXgtPRca51cTh
         Kjt4vcYHHiUBWKNDbEdNkw5LmtxPtJAs961xziLXEQQmcRRKC+XTvb8X3Mv5HuNd3g65
         rbEnCtYwG9f2sqWhaLJitGD3eobDHYJm3Lp8idB4WHCamsENmNmOfrndZ99VziA1718v
         ZFwhg4eMsDrzkJAlatdDRFvDNHgbLy+EDTZnB6N9dZ7yt4JVcAMrYLFaHtXLj4rhKRWg
         o1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGrggQ/qDTMgdBpDhPDYEEJzTc7x7HUNebehORCAiA=;
        b=xW7/t2TW9JqIWsGkrDP8r8AazBmsFE4vvffdIaA4l29Q95s1Bkt49qNYMcJaAlK7oi
         9Dpbl9eoi69eLCLe8ETNyCx4KEFOVah6HQgOsTsp1CsDwA08DayDX3WjCwvs1nqvDCSW
         XxaaGoeYvfIWPScgQ3YV6eVx3Gihj5m+nFFkIn8gbqyj8dZaIjcF3ArVyf+B+iLWhtEL
         3yMUMlhfc+0tzimQkJHC4+n82M5RsxvpK3WFraZXK6VtqaJ1BWtecD0302PRvyi4oOg0
         e5TvIDjNrX4OMlkL56/MAp4+hls/cewx3LEExUuOd4s82gO8Ol3NRrD7ksJq2ePnzUS7
         9lxA==
X-Gm-Message-State: AO0yUKWX15o8wkC+wqIuhGvnw3DTwyGd1W0ysXdK79AIGNwDfVPTW2CC
        RRvWxlCQoU9AgaMIsg2RIYWSfeQy8FBUoWZa
X-Google-Smtp-Source: AK7set8/WW6OVTCGwPxg+uQR5Lu/p2b0h5x6j4EcxX6yyi99urCYtaxSW3TCY7nRxHf6oG5i6KVmizuXRuCPg5hr
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:5c3:0:b0:8ed:262d:defe with SMTP id
 w3-20020a5b05c3000000b008ed262ddefemr185750ybp.0.1676680187212; Fri, 17 Feb
 2023 16:29:47 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:19 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-47-jthoughton@google.com>
Subject: [PATCH v2 46/46] selftests/mm: add HGM UFFDIO_CONTINUE and hwpoison tests
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

Test that high-granularity CONTINUEs at all sizes work (exercising
contiguous PTE sizes for arm64, when support is added). Also test that
collapse works and hwpoison works correctly (although we aren't yet
testing high-granularity poison).

This test uses UFFD_FEATURE_EVENT_FORK + UFFD_REGISTER_MODE_WP to force
the kernel to copy page tables on fork(), exercising the changes to
copy_hugetlb_page_range().

Also test that UFFDIO_WRITEPROTECT doesn't prevent UFFDIO_CONTINUE
from behaving properly (in other words, that HGM walks treat UFFD-WP
markers like blank PTEs in the appropriate cases). We also test that
the uffd-wp PTE markers are preserved properly.

Signed-off-by: James Houghton <jthoughton@google.com>

 create mode 100644 tools/testing/selftests/mm/hugetlb-hgm.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d90cdc06aa59..920baccccb9e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -36,6 +36,7 @@ TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
+TEST_GEN_FILES += hugetlb-hgm
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-hgm.c b/tools/testing/selftests/mm/hugetlb-hgm.c
new file mode 100644
index 000000000000..4c27a6a11818
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-hgm.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test uncommon cases in HugeTLB high-granularity mapping:
+ *  1. Test all supported high-granularity page sizes (with MADV_COLLAPSE).
+ *  2. Test MADV_HWPOISON behavior.
+ *  3. Test interaction with UFFDIO_WRITEPROTECT.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/poll.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <linux/userfaultfd.h>
+#include <linux/magic.h>
+#include <sys/mman.h>
+#include <sys/statfs.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#define PAGE_SIZE 4096
+#define PAGE_MASK ~(PAGE_SIZE - 1)
+
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
+#ifndef MADV_SPLIT
+#define MADV_SPLIT 26
+#endif
+
+#define PREFIX " ... "
+#define ERROR_PREFIX " !!! "
+
+static void *sigbus_addr;
+bool was_mceerr;
+bool got_sigbus;
+bool expecting_sigbus;
+
+enum test_status {
+	TEST_PASSED = 0,
+	TEST_FAILED = 1,
+	TEST_SKIPPED = 2,
+};
+
+static char *status_to_str(enum test_status status)
+{
+	switch (status) {
+	case TEST_PASSED:
+		return "TEST_PASSED";
+	case TEST_FAILED:
+		return "TEST_FAILED";
+	case TEST_SKIPPED:
+		return "TEST_SKIPPED";
+	default:
+		return "TEST_???";
+	}
+}
+
+static int userfaultfd(int flags)
+{
+	return syscall(__NR_userfaultfd, flags);
+}
+
+static int map_range(int uffd, char *addr, uint64_t length)
+{
+	struct uffdio_continue cont = {
+		.range = (struct uffdio_range) {
+			.start = (uint64_t)addr,
+			.len = length,
+		},
+		.mode = 0,
+		.mapped = 0,
+	};
+
+	if (ioctl(uffd, UFFDIO_CONTINUE, &cont) < 0) {
+		perror(ERROR_PREFIX "UFFDIO_CONTINUE failed");
+		return -1;
+	}
+	return 0;
+}
+
+static int userfaultfd_writeprotect(int uffd, char *addr, uint64_t length,
+				    bool protect)
+{
+	struct uffdio_writeprotect wp = {
+		.range = (struct uffdio_range) {
+			.start = (uint64_t)addr,
+			.len = length,
+		},
+		.mode = UFFDIO_WRITEPROTECT_MODE_DONTWAKE,
+	};
+
+	if (protect)
+		wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+
+	printf(PREFIX "UFFDIO_WRITEPROTECT: %p -> %p (%sprotected)\n", addr,
+			addr + length, protect ? "" : "un");
+
+	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp) < 0) {
+		perror(ERROR_PREFIX "UFFDIO_WRITEPROTECT failed");
+		return -1;
+	}
+	return 0;
+}
+
+static int check_equal(char *mapping, size_t length, char value)
+{
+	size_t i;
+
+	for (i = 0; i < length; ++i)
+		if (mapping[i] != value) {
+			printf(ERROR_PREFIX "mismatch at %p (%d != %d)\n",
+					&mapping[i], mapping[i], value);
+			return -1;
+		}
+
+	return 0;
+}
+
+static int test_continues(int uffd, char *primary_map, char *secondary_map,
+			  size_t len, bool verify)
+{
+	size_t offset = 0;
+	unsigned char iter = 0;
+	unsigned long pagesize = getpagesize();
+	uint64_t size;
+
+	for (size = len/2; size >= pagesize;
+			offset += size, size /= 2) {
+		iter++;
+		memset(secondary_map + offset, iter, size);
+		printf(PREFIX "UFFDIO_CONTINUE: %p -> %p = %d%s\n",
+				primary_map + offset,
+				primary_map + offset + size,
+				iter,
+				verify ? " (and verify)" : "");
+		if (map_range(uffd, primary_map + offset, size))
+			return -1;
+		if (verify && check_equal(primary_map + offset, size, iter))
+			return -1;
+	}
+	return 0;
+}
+
+static int verify_contents(char *map, size_t len, bool last_page_zero)
+{
+	size_t offset = 0;
+	int i = 0;
+	uint64_t size;
+
+	for (size = len/2; size > PAGE_SIZE; offset += size, size /= 2)
+		if (check_equal(map + offset, size, ++i))
+			return -1;
+
+	if (last_page_zero)
+		if (check_equal(map + len - PAGE_SIZE, PAGE_SIZE, 0))
+			return -1;
+
+	return 0;
+}
+
+static int test_collapse(char *primary_map, size_t len, bool verify)
+{
+	int ret = 0;
+
+	printf(PREFIX "collapsing %p -> %p\n", primary_map, primary_map + len);
+	if (madvise(primary_map, len, MADV_COLLAPSE) < 0) {
+		perror(ERROR_PREFIX "collapse failed");
+		return -1;
+	}
+
+	if (verify) {
+		printf(PREFIX "verifying %p -> %p\n", primary_map,
+				primary_map + len);
+		ret = verify_contents(primary_map, len, true);
+	}
+	return ret;
+}
+
+static void sigbus_handler(int signo, siginfo_t *info, void *context)
+{
+	if (!expecting_sigbus)
+		printf(ERROR_PREFIX "unexpected sigbus: %p\n", info->si_addr);
+
+	got_sigbus = true;
+	was_mceerr = info->si_code == BUS_MCEERR_AR;
+	sigbus_addr = info->si_addr;
+
+	pthread_exit(NULL);
+}
+
+static void *access_mem(void *addr)
+{
+	volatile char *ptr = addr;
+
+	/*
+	 * Do a write without changing memory contents, as other routines will
+	 * need to verify that mapping contents haven't changed.
+	 *
+	 * We do a write so that we trigger uffd-wp SIGBUSes. To test that we
+	 * get HWPOISON SIGBUSes, we would only need to read.
+	 */
+	*ptr = *ptr;
+	return NULL;
+}
+
+static int test_sigbus(char *addr, bool poison)
+{
+	int ret;
+	pthread_t pthread;
+
+	sigbus_addr = (void *)0xBADBADBAD;
+	was_mceerr = false;
+	got_sigbus = false;
+	expecting_sigbus = true;
+	ret = pthread_create(&pthread, NULL, &access_mem, addr);
+	if (ret) {
+		printf(ERROR_PREFIX "failed to create thread: %s\n",
+				strerror(ret));
+		goto out;
+	}
+
+	pthread_join(pthread, NULL);
+
+	ret = -1;
+	if (!got_sigbus)
+		printf(ERROR_PREFIX "didn't get a SIGBUS: %p\n", addr);
+	else if (sigbus_addr != addr)
+		printf(ERROR_PREFIX "got incorrect sigbus address: %p vs %p\n",
+				sigbus_addr, addr);
+	else if (poison && !was_mceerr)
+		printf(ERROR_PREFIX "didn't get an MCEERR?\n");
+	else
+		ret = 0;
+out:
+	expecting_sigbus = false;
+	return ret;
+}
+
+static void *read_from_uffd_thd(void *arg)
+{
+	int uffd = *(int *)arg;
+	struct uffd_msg msg;
+	/* opened without O_NONBLOCK */
+	if (read(uffd, &msg, sizeof(msg)) != sizeof(msg))
+		printf(ERROR_PREFIX "reading uffd failed\n");
+
+	return NULL;
+}
+
+static int read_event_from_uffd(int *uffd, pthread_t *pthread)
+{
+	int ret = 0;
+
+	ret = pthread_create(pthread, NULL, &read_from_uffd_thd, (void *)uffd);
+	if (ret) {
+		printf(ERROR_PREFIX "failed to create thread: %s\n",
+				strerror(ret));
+		return ret;
+	}
+	return 0;
+}
+
+static int test_sigbus_range(char *primary_map, size_t len, bool hwpoison)
+{
+	const unsigned long pagesize = getpagesize();
+	const int num_checks = 512;
+	unsigned long bytes_per_check = len/num_checks;
+	int i;
+
+	printf(PREFIX "checking that we can't access "
+	       "(%d addresses within %p -> %p)\n",
+	       num_checks, primary_map, primary_map + len);
+
+	if (pagesize > bytes_per_check)
+		bytes_per_check = pagesize;
+
+	for (i = 0; i < len; i += bytes_per_check)
+		if (test_sigbus(primary_map + i, hwpoison) < 0)
+			return 1;
+	/* check very last byte, because we left it unmapped */
+	if (test_sigbus(primary_map + len - 1, hwpoison))
+		return 1;
+
+	return 0;
+}
+
+static enum test_status test_hwpoison(char *primary_map, size_t len)
+{
+	printf(PREFIX "poisoning %p -> %p\n", primary_map, primary_map + len);
+	if (madvise(primary_map, len, MADV_HWPOISON) < 0) {
+		perror(ERROR_PREFIX "MADV_HWPOISON failed");
+		return TEST_SKIPPED;
+	}
+
+	return test_sigbus_range(primary_map, len, true)
+		? TEST_FAILED : TEST_PASSED;
+}
+
+static int test_fork(int uffd, char *primary_map, size_t len)
+{
+	int status;
+	int ret = 0;
+	pid_t pid;
+	pthread_t uffd_thd;
+
+	/*
+	 * UFFD_FEATURE_EVENT_FORK will put fork event on the userfaultfd,
+	 * which we must read, otherwise we block fork(). Setup a thread to
+	 * read that event now.
+	 *
+	 * Page fault events should result in a SIGBUS, so we expect only a
+	 * single event from the uffd (the fork event).
+	 */
+	if (read_event_from_uffd(&uffd, &uffd_thd))
+		return -1;
+
+	pid = fork();
+
+	if (!pid) {
+		/*
+		 * Because we have UFFDIO_REGISTER_MODE_WP and
+		 * UFFD_FEATURE_EVENT_FORK, the page tables should be copied
+		 * exactly.
+		 *
+		 * Check that everything except that last 4K has correct
+		 * contents, and then check that the last 4K gets a SIGBUS.
+		 */
+		printf(PREFIX "child validating...\n");
+		ret = verify_contents(primary_map, len, false) ||
+			test_sigbus(primary_map + len - 1, false);
+		ret = 0;
+		exit(ret ? 1 : 0);
+	} else {
+		/* wait for the child to finish. */
+		waitpid(pid, &status, 0);
+		ret = WEXITSTATUS(status);
+		if (!ret) {
+			printf(PREFIX "parent validating...\n");
+			/* Same check as the child. */
+			ret = verify_contents(primary_map, len, false) ||
+				test_sigbus(primary_map + len - 1, false);
+			ret = 0;
+		}
+	}
+
+	pthread_join(uffd_thd, NULL);
+	return ret;
+
+}
+
+static int uffd_register(int uffd, char *primary_map, unsigned long len,
+			 int mode)
+{
+	struct uffdio_register reg;
+
+	reg.range.start = (unsigned long)primary_map;
+	reg.range.len = len;
+	reg.mode = mode;
+
+	reg.ioctls = 0;
+	return ioctl(uffd, UFFDIO_REGISTER, &reg);
+}
+
+enum test_type {
+	TEST_DEFAULT,
+	TEST_UFFDWP,
+	TEST_HWPOISON
+};
+
+static enum test_status
+test_hgm(int fd, size_t hugepagesize, size_t len, enum test_type type)
+{
+	int uffd;
+	char *primary_map, *secondary_map;
+	struct uffdio_api api;
+	struct sigaction new, old;
+	enum test_status status = TEST_SKIPPED;
+	bool hwpoison = type == TEST_HWPOISON;
+	bool uffd_wp = type == TEST_UFFDWP;
+	bool verify = type == TEST_DEFAULT;
+	int register_args;
+
+	if (ftruncate(fd, len) < 0) {
+		perror(ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	uffd = userfaultfd(O_CLOEXEC);
+	if (uffd < 0) {
+		perror(ERROR_PREFIX "uffd not created");
+		return status;
+	}
+
+	primary_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (primary_map == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for primary mapping failed");
+		goto close_uffd;
+	}
+	secondary_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (secondary_map == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for secondary mapping failed");
+		goto unmap_primary;
+	}
+
+	printf(PREFIX "primary mapping: %p\n", primary_map);
+	printf(PREFIX "secondary mapping: %p\n", secondary_map);
+
+	api.api = UFFD_API;
+	api.features = UFFD_FEATURE_SIGBUS | UFFD_FEATURE_EXACT_ADDRESS |
+		UFFD_FEATURE_EVENT_FORK;
+	if (ioctl(uffd, UFFDIO_API, &api) == -1) {
+		perror(ERROR_PREFIX "UFFDIO_API failed");
+		goto out;
+	}
+
+	if (madvise(primary_map, len, MADV_SPLIT)) {
+		perror(ERROR_PREFIX "MADV_SPLIT failed");
+		goto out;
+	}
+
+	/*
+	 * Register with UFFDIO_REGISTER_MODE_WP to force fork() to copy page
+	 * tables (also need UFFD_FEATURE_EVENT_FORK, which we have).
+	 */
+	register_args = UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP;
+	if (!uffd_wp)
+		/*
+		 * If we're testing UFFDIO_WRITEPROTECT, then we don't want
+		 * minor faults. With minor faults enabled, we'll get SIGBUSes
+		 * for any minor fault, wheresa without minot faults enabled,
+		 * writes will verify that uffd-wp PTE markers were installed
+		 * properly.
+		 */
+		register_args |= UFFDIO_REGISTER_MODE_MINOR;
+
+	if (uffd_register(uffd, primary_map, len, register_args)) {
+		perror(ERROR_PREFIX "UFFDIO_REGISTER failed");
+		goto out;
+	}
+
+
+	new.sa_sigaction = &sigbus_handler;
+	new.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &new, &old) < 0) {
+		perror(ERROR_PREFIX "could not setup SIGBUS handler");
+		goto out;
+	}
+
+	status = TEST_FAILED;
+
+	if (uffd_wp) {
+		/*
+		 * Install uffd-wp PTE markers now. They should be preserved
+		 * as we split the mappings with UFFDIO_CONTINUE later.
+		 */
+		if (userfaultfd_writeprotect(uffd, primary_map, len, true))
+			goto done;
+		/* Verify that we really are write-protected. */
+		if (test_sigbus(primary_map, false))
+			goto done;
+	}
+
+	/*
+	 * Main piece of the test: map primary_map at all the possible
+	 * page sizes. Starting at the hugepage size and going down to
+	 * PAGE_SIZE. This leaves the final PAGE_SIZE piece of the mapping
+	 * unmapped.
+	 */
+	if (test_continues(uffd, primary_map, secondary_map, len, verify))
+		goto done;
+
+	/*
+	 * Verify that MADV_HWPOISON is able to properly poison the entire
+	 * mapping.
+	 */
+	if (hwpoison) {
+		enum test_status new_status = test_hwpoison(primary_map, len);
+
+		if (new_status != TEST_PASSED) {
+			status = new_status;
+			goto done;
+		}
+	}
+
+	if (uffd_wp) {
+		/*
+		 * Check that the uffd-wp marker we installed initially still
+		 * exists in the unmapped 4K piece at the end the mapping.
+		 *
+		 * test_sigbus() will do a write. When this happens:
+		 *  1. The page fault handler will find the uffd-wp marker and
+		 *     create a read-only PTE.
+		 *  2. The memory access is retried, and the page fault handler
+		 *     will find that a write was attempted in a UFFD_WP VMA
+		 *     where a RO mapping exists, so SIGBUS
+		 *     (we have UFFD_FEATURE_SIGBUS).
+		 *
+		 * We only check the final pag because UFFDIO_CONTINUE will
+		 * have cleared the write-protection on all the other pieces
+		 * of the mapping.
+		 */
+		printf(PREFIX "verifying that we can't write to final page\n");
+		if (test_sigbus(primary_map + len - 1, false))
+			goto done;
+	}
+
+	if (!hwpoison)
+		/*
+		 * test_fork() will verify memory contents. We can't do
+		 * that if memory has been poisoned.
+		 */
+		if (test_fork(uffd, primary_map, len))
+			goto done;
+
+	/*
+	 * Check that MADV_COLLAPSE functions properly. That is:
+	 *  - the PAGE_SIZE hole we had is no longer unmapped.
+	 *  - poisoned regions are still poisoned.
+	 *
+	 *  Verify the data is correct if we haven't poisoned.
+	 */
+	if (test_collapse(primary_map, len, !hwpoison))
+		goto done;
+	/*
+	 * Verify that memory is still poisoned.
+	 */
+	if (hwpoison && test_sigbus_range(primary_map, len, true))
+		goto done;
+
+	status = TEST_PASSED;
+
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+
+out:
+	munmap(secondary_map, len);
+unmap_primary:
+	munmap(primary_map, len);
+close_uffd:
+	close(uffd);
+	return status;
+}
+
+int main(void)
+{
+	int fd;
+	struct statfs file_stat;
+	size_t hugepagesize;
+	size_t len;
+	enum test_status status;
+	int ret = 0;
+
+	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
+	if (fd < 0) {
+		perror(ERROR_PREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(&file_stat, 0, sizeof(file_stat));
+	if (fstatfs(fd, &file_stat)) {
+		perror(ERROR_PREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat.f_type != HUGETLBFS_MAGIC) {
+		printf(ERROR_PREFIX "not hugetlbfs file\n");
+		goto close;
+	}
+
+	hugepagesize = file_stat.f_bsize;
+	len = 2 * hugepagesize;
+
+	printf("HGM regular test...\n");
+	status = test_hgm(fd, hugepagesize, len, TEST_DEFAULT);
+	printf("HGM regular test:  %s\n", status_to_str(status));
+	if (status == TEST_FAILED)
+		ret = -1;
+
+	printf("HGM uffd-wp test...\n");
+	status = test_hgm(fd, hugepagesize, len, TEST_UFFDWP);
+	printf("HGM uffd-wp test:  %s\n", status_to_str(status));
+	if (status == TEST_FAILED)
+		ret = -1;
+
+	printf("HGM hwpoison test...\n");
+	status = test_hgm(fd, hugepagesize, len, TEST_HWPOISON);
+	printf("HGM hwpoison test: %s\n", status_to_str(status));
+	if (status == TEST_FAILED)
+		ret = -1;
+close:
+	close(fd);
+
+	return ret;
+}
-- 
2.39.2.637.g21b0678d19-goog

