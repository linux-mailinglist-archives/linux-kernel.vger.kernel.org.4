Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81498706DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjEQQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjEQQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:10:06 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB635FC4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2505b80d5b3so98423a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684339804; x=1686931804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGxg+zhhm/tdTqkE4MZxwuMTE52MydtCt+SDG4bfPzg=;
        b=rX0HksKsk0IJFI+DSWwGwnSF1zsM0Y/3NSgkTE4ZsUpxUBwgEnbw18PdOa4svGvURJ
         Z/ZtfKN7U1NEhdwFryCTbpt629Lk3erFtvp0ks79CR7fNs4DF9ZUJ7r3rymcKmX1jxLx
         1/8VzjvNjUTrOOzM0zqxVIj6gBRb/Q1AyjBmfpBAPMAjRyv7K+bR6aS1jV2AcucecG09
         PiV2VwOn0EFurlAEbZnmRq2zSQ+a5Lqd1uCwtPeNFlwqIyEkdfG3BejPJqOgGnQcijDm
         K4RmMrWMkOQF5LZYJhUk5lnzr6Fi4LUAi6tHOOgtS4eRQeDaORBjAtuvBswrm2NGd2m/
         fGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339804; x=1686931804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGxg+zhhm/tdTqkE4MZxwuMTE52MydtCt+SDG4bfPzg=;
        b=PpFCASIk1dtmCoEfETyJXRU3Q9Y2AW9xBqL3P68GDdqvPeYGrf9PKefw3FhKj/dSfS
         fpnTm2JAQhaZl02t4ssnF+APTdeyEavoTS6auMuhs/9IWvsnVBHJbYV1qHmXquG2o/if
         y0q1D/t5MuoCToHOn6rjngQS8ZvITMPkmkjRcgRWfPHRZ3fLXy9cGCQmlpT98KOnDTCN
         zHk/anA0BUOVCp1wFYo6DvxkZcgB7mYGg7Osi1ZlDOGNvZJsXc89j+gL+M9lLT6H4Bx+
         PRTA1bp6FNds2dN6PO518Um0ke92CR+pfi1Rm56z3jPfrdRwhPaPI8yhjKPG9ewAKkl+
         KcRg==
X-Gm-Message-State: AC+VfDwn0hKadsoCUy0HhAaDZwZrb75e/lQUDOd8CkwBLL+2vu7Zs4Cz
        MsAK+lF5xwOFvyAV8l/kTiPFn7M2il9GXw==
X-Google-Smtp-Source: ACHHUZ5+d60PcaMXbxsAMlias9eLlwRUCq3s5d4aGQz1cuagr41Ek8tZIoO9lZquq6XMY0bgQXJgoSJwjv+7Jg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:90b:89:b0:253:4800:438b with SMTP id
 bb9-20020a17090b008900b002534800438bmr7216pjb.2.1684339804718; Wed, 17 May
 2023 09:10:04 -0700 (PDT)
Date:   Wed, 17 May 2023 16:09:48 +0000
In-Reply-To: <20230517160948.811355-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517160948.811355-4-jiaqiyan@google.com>
Subject: [PATCH v1 3/3] selftests/mm: add tests for HWPOISON hugetlbfs read
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        naoya.horiguchi@nec.com, shy828301@gmail.com, linmiaohe@huawei.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for the improvement made to read operations on HWPOISON
hugetlb page with different read granularities.

0) Simple regression test on read.
1) Sequential read page by page should succeed until encounters the 1st
   raw HWPOISON subpage.
2) After skip raw HWPOISON subpage by lseek, read always succeeds.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 8917455f4f51..fe8224d2ee06 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -5,6 +5,7 @@ hugepage-mremap
 hugepage-shm
 hugepage-vmemmap
 hugetlb-madvise
+hugetlb-read-hwpoison
 khugepaged
 map_hugetlb
 map_populate
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..6cc63668c50e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -37,6 +37,7 @@ TEST_GEN_PROGS += compaction_test
 TEST_GEN_PROGS += gup_test
 TEST_GEN_PROGS += hmm-tests
 TEST_GEN_PROGS += hugetlb-madvise
+TEST_GEN_PROGS += hugetlb-read-hwpoison
 TEST_GEN_PROGS += hugepage-mmap
 TEST_GEN_PROGS += hugepage-mremap
 TEST_GEN_PROGS += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
new file mode 100644
index 000000000000..2f8e84eceb3d
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <linux/magic.h>
+#include <sys/mman.h>
+#include <sys/statfs.h>
+#include <errno.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+
+#define PREFIX " ... "
+#define ERROR_PREFIX " !!! "
+
+#define MAX_WRITE_READ_CHUNK_SIZE (getpagesize() * 16)
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
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
+static int setup_filemap(char *filemap, size_t len, size_t wr_chunk_size)
+{
+	char iter = 0;
+
+	for (size_t offset = 0; offset < len;
+	     offset += wr_chunk_size) {
+		iter++;
+		memset(filemap + offset, iter, wr_chunk_size);
+	}
+
+	return 0;
+}
+
+static bool verify_chunk(char *buf, size_t len, char val)
+{
+	size_t i;
+
+	for (i = 0; i < len; ++i) {
+		if (buf[i] != val) {
+			printf(ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
+				i, buf[i], val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
+				       off_t offset, size_t expected)
+{
+	char buf[MAX_WRITE_READ_CHUNK_SIZE];
+	ssize_t ret_count = 0;
+	ssize_t total_ret_count = 0;
+	char val = offset / wr_chunk_size + offset % wr_chunk_size;
+
+	printf(PREFIX "init val=%u with offset=0x%lx\n", val, offset);
+	printf(PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	if (lseek(fd, offset, SEEK_SET) < 0) {
+		perror(ERROR_PREFIX "seek failed");
+		return false;
+	}
+
+	while (offset + total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX "actually read 0x%lx bytes of data in total\n",
+	       total_ret_count);
+
+	return total_ret_count == expected;
+}
+
+static bool read_hugepage_filemap(int fd, size_t len,
+				  size_t wr_chunk_size, size_t expected)
+{
+	char buf[MAX_WRITE_READ_CHUNK_SIZE];
+	ssize_t ret_count = 0;
+	ssize_t total_ret_count = 0;
+	char val = 0;
+
+	printf(PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	while (total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX "actually read 0x%lx bytes of data in total\n",
+	       total_ret_count);
+
+	return total_ret_count == expected;
+}
+
+static enum test_status
+test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
+{
+	enum test_status status = TEST_SKIPPED;
+	char *filemap = NULL;
+
+	if (ftruncate(fd, len) < 0) {
+		perror(ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for primary mapping failed");
+		goto done;
+	}
+
+	setup_filemap(filemap, len, wr_chunk_size);
+	status = TEST_FAILED;
+
+	if (read_hugepage_filemap(fd, len, wr_chunk_size, len))
+		status = TEST_PASSED;
+
+	munmap(filemap, len);
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+
+	return status;
+}
+
+static enum test_status
+test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
+			   bool skip_hwpoison_page)
+{
+	enum test_status status = TEST_SKIPPED;
+	char *filemap = NULL;
+	char *hwp_addr = NULL;
+	const unsigned long pagesize = getpagesize();
+
+	if (ftruncate(fd, len) < 0) {
+		perror(ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for primary mapping failed");
+		goto done;
+	}
+
+	setup_filemap(filemap, len, wr_chunk_size);
+	status = TEST_FAILED;
+
+	/*
+	 * Poisoned hugetlb page layout (assume hugepagesize=2MB):
+	 * |<---------------------- 1MB ---------------------->|
+	 * |<---- healthy page ---->|<---- HWPOISON page ----->|
+	 * |<------------------- (1MB - 8KB) ----------------->|
+	 */
+	hwp_addr = filemap + len / 2 + pagesize;
+	if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
+		perror(ERROR_PREFIX "MADV_HWPOISON failed");
+		goto unmap;
+	}
+
+	if (!skip_hwpoison_page) {
+		/*
+		 * Userspace should be able to read (1MB + 1 page) from
+		 * the beginning of the HWPOISONed hugepage.
+		 */
+		if (read_hugepage_filemap(fd, len, wr_chunk_size,
+					  len / 2 + pagesize))
+			status = TEST_PASSED;
+	} else {
+		/*
+		 * Userspace should be able to read (1MB - 2 pages) from
+		 * HWPOISONed hugepage.
+		 */
+		if (seek_read_hugepage_filemap(fd, len, wr_chunk_size,
+					       len / 2 + MAX(2 * pagesize, wr_chunk_size),
+					       len / 2 - MAX(2 * pagesize, wr_chunk_size)))
+			status = TEST_PASSED;
+	}
+
+unmap:
+	munmap(filemap, len);
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+
+	return status;
+}
+
+static int create_hugetlbfs_file(struct statfs *file_stat)
+{
+	int fd;
+
+	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
+	if (fd < 0) {
+		perror(ERROR_PREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		perror(ERROR_PREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		printf(ERROR_PREFIX "not hugetlbfs file\n");
+		goto close;
+	}
+
+	return fd;
+close:
+	close(fd);
+	return -1;
+}
+
+int main(void)
+{
+	int fd;
+	struct statfs file_stat;
+	enum test_status status;
+	/* Test read() in different granularity. */
+	size_t wr_chunk_sizes[] = {
+		getpagesize() / 2, getpagesize(),
+		getpagesize() * 2, getpagesize() * 4
+	};
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
+		printf(PREFIX "Write/read chunk size=0x%lx\n",
+		       wr_chunk_sizes[i]);
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf("HugeTLB read regression test...\n");
+		status = test_hugetlb_read(fd, file_stat.f_bsize,
+					   wr_chunk_sizes[i]);
+		printf("HugeTLB read regression test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf("HugeTLB read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], false);
+		printf("HugeTLB read HWPOISON test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf("HugeTLB seek then read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], true);
+		printf("HugeTLB seek then read HWPOISON test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+	}
+
+	return 0;
+
+create_failure:
+	printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
+	return -1;
+}
-- 
2.40.1.606.ga4b1b128d6-goog

