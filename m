Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED274B7C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGGUTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:19:24 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596B2106
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:19:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55bf5cd4fb8so2535552a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761160; x=1691353160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmSXGhNgjtW0Yb8+yIyK70NmvAjyR1vjV+RIYl0ULq4=;
        b=cgDoU3tDkKP7JTQ+F0CzAiBgvzjb4qUPJbX80bmEdZNC2kBFPhSxB/2KWqZSIhGnu5
         DNnicuDpK4RRjfvI8Od0feJbKV0/XU2e63+LYPuJBKE3rThjUkLPqnYx6RjItC6itmd6
         E8oybw7gnCOvuqj/lkQyUEa8CGnU/e60XfcGhlrIjKezX1hZaq+Fbq1wQe5hiMJLfSxY
         04YtCgIm9GcwTklBS9EFbPw5TLQgXGtx3bb42RDjvnpfonqnq7jboBzGk/LZy1us4JKo
         w+8/QeI5pWZgUe4X5h5uG4tRJUsMzcCNRRNm03kEX6WEvTDa0+st3K25FuKUsfWelq3J
         yj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761160; x=1691353160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmSXGhNgjtW0Yb8+yIyK70NmvAjyR1vjV+RIYl0ULq4=;
        b=PURmerhlN8w14FyMItiPfsI47nkcSVYi/0JsFSKOyKgsW8zeJrC8eb33671cS45mKl
         Kj82nD8Q7REfvXoO1t/5QpAbwzwu3dmsmjhbeaf1yTBXCo2PfNxdrtuzSCIbMNFqnJHz
         FtIJOEDMUWbZtT4Wqzzu9gBtglvkjnNG4maNbsvGOatdEkw3YQONGAglUi0b0jKaDZS6
         5hjA0+4zjljJ1/CZFQHBQr2l6qyakwaIJlNRKkbfifrkikS5X6DPSBHy324paLxiHgna
         5rpf6VzGA3NXKM+QxcY0JmLU4sBRnmcBZUi0D6Z6WEmJPYkBI4JkMZXqYyR+jPI4rapN
         An6w==
X-Gm-Message-State: ABy/qLYgrFXLZXDZ4Q4Ei4Lu8vfLQpRNxAXWuIQo0HXC/qbvwp/ZWN4M
        2dHsnscFzgkaQ90MyTi6oi88n65zNp4v3A==
X-Google-Smtp-Source: APBJJlH7Cq0eDn70cDDe92uconHq1/8/0rJBg2JnBViw/2FmoEOJgxc84w8NuFGWdffzBFiFeO6rajwXkfI/1A==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:9316:0:b0:53f:f32b:1f20 with SMTP id
 b22-20020a639316000000b0053ff32b1f20mr4028211pge.2.1688761160596; Fri, 07 Jul
 2023 13:19:20 -0700 (PDT)
Date:   Fri,  7 Jul 2023 20:19:04 +0000
In-Reply-To: <20230707201904.953262-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707201904.953262-5-jiaqiyan@google.com>
Subject: [PATCH v3 4/4] selftests/mm: add tests for HWPOISON hugetlbfs read
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, linux-mm@kvack.org,
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

Add tests for the improvement made to read operation on HWPOISON
hugetlb page with different read granularities. For each chunk size,
three read scenarios are tested:
1. Simple regression test on read without HWPOISON.
2. Sequential read page by page should succeed until encounters the 1st
   raw HWPOISON subpage.
3. After skip a raw HWPOISON subpage by lseek, read()s always succeed.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 7e2a982383c0..cdc9ce4426b9 100644
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
index 66d7c07dc177..b7fce9073279 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -41,6 +41,7 @@ TEST_GEN_PROGS += gup_longterm
 TEST_GEN_PROGS += gup_test
 TEST_GEN_PROGS += hmm-tests
 TEST_GEN_PROGS += hugetlb-madvise
+TEST_GEN_PROGS += hugetlb-read-hwpoison
 TEST_GEN_PROGS += hugepage-mmap
 TEST_GEN_PROGS += hugepage-mremap
 TEST_GEN_PROGS += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
new file mode 100644
index 000000000000..ba6cc6f9cabc
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
+			printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
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
+	printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
+	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	if (lseek(fd, offset, SEEK_SET) < 0) {
+		perror(PREFIX ERROR_PREFIX "seek failed");
+		return false;
+	}
+
+	while (offset + total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(PREFIX ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
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
+	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	while (total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(PREFIX ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
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
+		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
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
+		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
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
+		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
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
+		perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
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
+		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
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
+		perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		perror(PREFIX ERROR_PREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
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
+		printf("Write/read chunk size=0x%lx\n",
+		       wr_chunk_sizes[i]);
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB read regression test...\n");
+		status = test_hugetlb_read(fd, file_stat.f_bsize,
+					   wr_chunk_sizes[i]);
+		printf(PREFIX "HugeTLB read regression test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], false);
+		printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], true);
+		printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
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
2.41.0.255.g8b1d071c50-goog

