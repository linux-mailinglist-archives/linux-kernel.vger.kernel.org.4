Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31166074B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJUKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiJUKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E077AB08
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXtz/Zj1ptThtlYCmULXjCE80g7BkkS7MWtxrW61b/8=;
        b=Fjgu4sv1/rOMA7veGfxs0A1diuaZTGj+y/eRW66zdzGCluqqAChFzb262UrsylH5rdL0hF
        bxH28kO9tWcP9ZpF8F+YyZ+MOoJVZXyhP1tLz00fRKAC0X8avsZ/iUMxpnOJhI/RliTnDV
        UxpGbkjDKrI+HEGdfxBcfwdr5JF0HMU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-JeVJkWYEM-2dEQrYwBCSRw-1; Fri, 21 Oct 2022 06:12:33 -0400
X-MC-Unique: JeVJkWYEM-2dEQrYwBCSRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6D5B3C0F248;
        Fri, 21 Oct 2022 10:12:32 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62B1440B4976;
        Fri, 21 Oct 2022 10:12:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 4/9] selftests/vm: add KSM unmerge tests
Date:   Fri, 21 Oct 2022 12:11:36 +0200
Message-Id: <20221021101141.84170-5-david@redhat.com>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add three unmerge tests (MADV_UNMERGEABLE unmerging all pages in the
range).

test_unmerge(): basic unmerge tests
test_unmerge_discarded(): have some pte_none() entries in the range
test_unmerge_uffd_wp(): protect the merged pages using uffd-wp

ksm_tests.c currently contains a mixture of benchmarks and tests,
whereby each test is carried out by executing the ksm_tests binary with
specific parameters. Let's add new ksm_functional_tests.c that performs
multiple, smaller functional tests all at once.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/Makefile           |   2 +
 .../selftests/vm/ksm_functional_tests.c       | 279 ++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh     |   2 +
 tools/testing/selftests/vm/vm_util.c          |  10 +
 tools/testing/selftests/vm/vm_util.h          |   1 +
 5 files changed, 294 insertions(+)
 create mode 100644 tools/testing/selftests/vm/ksm_functional_tests.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 163c2fde3cb3..2d640a48255c 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -52,6 +52,7 @@ TEST_GEN_FILES += userfaultfd
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
+TEST_GEN_PROGS += ksm_functional_tests
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
@@ -96,6 +97,7 @@ TEST_FILES += va_128TBswitch.sh
 include ../lib.mk
 
 $(OUTPUT)/khugepaged: vm_util.c
+$(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/vm/ksm_functional_tests.c
new file mode 100644
index 000000000000..96644be68962
--- /dev/null
+++ b/tools/testing/selftests/vm/ksm_functional_tests.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KSM functional tests
+ *
+ * Copyright 2022, Red Hat, Inc.
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+#define KiB 1024u
+#define MiB (1024 * KiB)
+
+static int ksm_fd;
+static int ksm_full_scans_fd;
+static int pagemap_fd;
+static size_t pagesize;
+
+static bool range_maps_duplicates(char *addr, unsigned long size)
+{
+	unsigned long offs_a, offs_b, pfn_a, pfn_b;
+
+	/*
+	 * There is no easy way to check if there are KSM pages mapped into
+	 * this range. We only check that the range does not map the same PFN
+	 * twice by comaring each pair of mapped pages.
+	 */
+	for (offs_a = 0; offs_a < size; offs_a += pagesize) {
+		pfn_a = pagemap_get_pfn(pagemap_fd, addr + offs_a);
+		/* Page not present or PFN not exposed by the kernel. */
+		if (pfn_a == -1ull || !pfn_a)
+			continue;
+
+		for (offs_b = offs_a + pagesize; offs_b < size;
+		     offs_b += pagesize) {
+			pfn_b = pagemap_get_pfn(pagemap_fd, addr + offs_b);
+			if (pfn_b == -1ull || !pfn_b)
+				continue;
+			if (pfn_a == pfn_b)
+				return true;
+		}
+	}
+	return false;
+}
+
+static long ksm_get_full_scans(void)
+{
+	char buf[10];
+	ssize_t ret;
+
+	ret = pread(ksm_full_scans_fd, buf, sizeof(buf) - 1, 0);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+static int ksm_merge(void)
+{
+	long start_scans, end_scans;
+
+	/* Wait for two full scans such that any possible merging happened. */
+	start_scans = ksm_get_full_scans();
+	if (start_scans < 0)
+		return start_scans;
+	if (write(ksm_fd, "1", 1) != 1)
+		return -errno;
+	do {
+		end_scans = ksm_get_full_scans();
+		if (end_scans < 0)
+			return end_scans;
+	} while (end_scans < start_scans + 2);
+
+	return 0;
+}
+
+static char *mmap_and_merge_range(char val, unsigned long size)
+{
+	char *map;
+
+	map = mmap(NULL, size, PROT_READ|PROT_WRITE,
+		   MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (map == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return MAP_FAILED;
+	}
+
+	/* Don't use THP. Ignore if THP are not around on a kernel. */
+	if (madvise(map, size, MADV_NOHUGEPAGE) && errno != EINVAL) {
+		ksft_test_result_fail("MADV_NOHUGEPAGE failed\n");
+		goto unmap;
+	}
+
+	/* Make sure each page contains the same values to merge them. */
+	memset(map, val, size);
+	if (madvise(map, size, MADV_MERGEABLE)) {
+		ksft_test_result_fail("MADV_MERGEABLE failed\n");
+		goto unmap;
+	}
+
+	/* Run KSM to trigger merging and wait. */
+	if (ksm_merge()) {
+		ksft_test_result_fail("Running KSM failed\n");
+		goto unmap;
+	}
+	return map;
+unmap:
+	munmap(map, size);
+	return MAP_FAILED;
+}
+
+static void test_unmerge(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0xcf, size);
+	if (map == MAP_FAILED)
+		return;
+
+	if (madvise(map, size, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto unmap;
+	}
+
+	ksft_test_result(!range_maps_duplicates(map, size),
+			 "Pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
+static void test_unmerge_discarded(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0xcf, size);
+	if (map == MAP_FAILED)
+		return;
+
+	/* Discard half of all mapped pages so we have pte_none() entries. */
+	if (madvise(map, size / 2, MADV_DONTNEED)) {
+		ksft_test_result_fail("MADV_DONTNEED failed\n");
+		goto unmap;
+	}
+
+	if (madvise(map, size, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto unmap;
+	}
+
+	ksft_test_result(!range_maps_duplicates(map, size),
+			 "Pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
+#ifdef __NR_userfaultfd
+static void test_unmerge_uffd_wp(void)
+{
+	struct uffdio_writeprotect uffd_writeprotect;
+	struct uffdio_register uffdio_register;
+	const unsigned int size = 2 * MiB;
+	struct uffdio_api uffdio_api;
+	char *map;
+	int uffd;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0xcf, size);
+	if (map == MAP_FAILED)
+		return;
+
+	/* See if UFFD is around. */
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		ksft_test_result_skip("__NR_userfaultfd failed\n");
+		goto unmap;
+	}
+
+	/* See if UFFD-WP is around. */
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
+		ksft_test_result_fail("UFFDIO_API failed\n");
+		goto close_uffd;
+	}
+	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
+		ksft_test_result_skip("UFFD_FEATURE_PAGEFAULT_FLAG_WP not available\n");
+		goto close_uffd;
+	}
+
+	/* Register UFFD-WP, no need for an actual handler. */
+	uffdio_register.range.start = (unsigned long) map;
+	uffdio_register.range.len = size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
+		ksft_test_result_fail("UFFDIO_REGISTER_MODE_WP failed\n");
+		goto close_uffd;
+	}
+
+	/* Write-protect the range using UFFD-WP. */
+	uffd_writeprotect.range.start = (unsigned long) map;
+	uffd_writeprotect.range.len = size;
+	uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
+		ksft_test_result_fail("UFFDIO_WRITEPROTECT failed\n");
+		goto close_uffd;
+	}
+
+	if (madvise(map, size, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto close_uffd;
+	}
+
+	ksft_test_result(!range_maps_duplicates(map, size),
+			 "Pages were unmerged\n");
+close_uffd:
+	close(uffd);
+unmap:
+	munmap(map, size);
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	unsigned int tests = 2;
+	int err;
+
+#ifdef __NR_userfaultfd
+	tests++;
+#endif
+
+	ksft_print_header();
+	ksft_set_plan(tests);
+
+	pagesize = getpagesize();
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/run\") failed\n");
+	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	if (ksm_full_scans_fd < 0)
+		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
+
+	test_unmerge();
+	test_unmerge_discarded();
+#ifdef __NR_userfaultfd
+	test_unmerge_uffd_wp();
+#endif
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e780e76c26b8..b8950891259b 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -184,6 +184,8 @@ run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
 run_test ./ksm_tests -N -m 0
 
+run_test ./ksm_functional_tests
+
 # protection_keys tests
 if [ -x ./protection_keys_32 ]
 then
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index f11f8adda521..dbd8889324e6 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -28,6 +28,16 @@ bool pagemap_is_softdirty(int fd, char *start)
 	return entry & 0x0080000000000000ull;
 }
 
+unsigned long pagemap_get_pfn(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	/* If present (63th bit), PFN is at bit 0 -- 54. */
+	if (entry & 0x8000000000000000ull)
+		return entry & 0x007fffffffffffffull;
+	return -1ull;
+}
+
 void clear_softdirty(void)
 {
 	int ret;
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 5c35de454e08..acecb5b6f8ca 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -4,6 +4,7 @@
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
+unsigned long pagemap_get_pfn(int fd, char *start);
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
-- 
2.37.3

