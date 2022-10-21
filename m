Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C88607C90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiJUQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiJUQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:58 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536DD238247
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:04 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id m186-20020a6726c3000000b0039b2e2e040dso1041533vsm.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qP1ClP7q+g5S/3EyNUqzGRFXdONCD3+1un/KPsFlt6w=;
        b=QMIS+S3FZjAOFL/rBkRiry87Th5Kd5EwT0c05LySCp4nkCaELh/zdUD5+Aa9N/+7D7
         SttWCG9Hi3HpsVOYK516SluMw+1U5skL5XiUCiezO60dxluHkHXNJD2BPxzYy9ElIoIo
         CqVjIAYat6VGsTooAFXgZhyY31kEJ2Pb7dKKQXnSZh6pHHmXteCqEnslryEPoKlJ/1HL
         ZJ2O0i+mmtp0eV1DkFySFLMzu3xcpuYZRBOXaXNztWI6gXkUaHxqX1Lu3FuqcpPbUo/J
         YTGrOVJlkmeX1/WedJcVMPwDEck6qTmRFmeRuAAp5UxDdvPetKdD3Fa+pCCwGznSQq8b
         F+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP1ClP7q+g5S/3EyNUqzGRFXdONCD3+1un/KPsFlt6w=;
        b=ZURbbmxFqfyo1vrwHNokNDYctS0PheIjzcA+iU1rxyWOmZ6fPlA9qGhk5V4bqKQrpE
         Yws7FbDQSiBYcHYAJGQGwfOU5i75FLzFb3o413QEMtr0wp9kqQOcLZ+hdlgDczneu7oF
         A9y955SMJGnvDwYW5gNTaY7RA7ZVqRUlE/h+9bLnP+Kh5FcZHQzNWOvz0PEEogoMvbNj
         8DPm42Lu4CTFSWdTc5XIdKSlz0QBRZJwdPcNtJKCCqFxaFE1op+uVkd6xl19uTmrMGfN
         JzywLTmMsNPDg7+YI4MKcHiqb9wuqlyLwv7+FkoFTCX4O1Ft26EIugVWO2dMV62Eu49S
         oAQQ==
X-Gm-Message-State: ACrzQf3z9dpK+pxvpNcH52MloQtMpuvpvwz56jSbrgdEIu7lbaMVgsDP
        QL0pFr0l+09fcQj4goo0ByhoZ0N/E/U+bLv9
X-Google-Smtp-Source: AMsMyM4IUmuvbEMg95LOcPWISiFLwBaVK46TD/2jo2TirSfe33B71xuI4Gxr0O7eiTjo3WhjYikEb+f+W3ttCA5W
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3d99:b0:3a9:5976:cd84 with
 SMTP id h25-20020a0561023d9900b003a95976cd84mr12345154vsv.4.1666370280478;
 Fri, 21 Oct 2022 09:38:00 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:37:03 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-48-jthoughton@google.com>
Subject: [RFC PATCH v2 47/47] selftests/vm: add HGM UFFDIO_CONTINUE and
 hwpoison tests
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

This tests that high-granularity CONTINUEs at all sizes work
(exercising contiguous PTE sizes for arm64, when support is added). This
also tests that collapse works and hwpoison works correctly (although we
aren't yet testing high-granularity poison).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/hugetlb-hgm.c | 326 +++++++++++++++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hugetlb-hgm.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 00920cb8b499..da1e01a5ac9b 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -32,6 +32,7 @@ TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
+TEST_GEN_FILES += hugetlb-hgm
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/vm/hugetlb-hgm.c b/tools/testing/selftests/vm/hugetlb-hgm.c
new file mode 100644
index 000000000000..e36a1c988bb4
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb-hgm.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test uncommon cases in HugeTLB high-granularity mapping:
+ *  1. Test all supported high-granularity page sizes (with MADV_COLLAPSE).
+ *  2. Test MADV_HWPOISON behavior.
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
+
+#define PAGE_MASK ~(4096 - 1)
+
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
+#define PREFIX " ... "
+
+int userfaultfd(int flags)
+{
+	return syscall(__NR_userfaultfd, flags);
+}
+
+int map_range(int uffd, char *addr, uint64_t length)
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
+		perror("UFFDIO_CONTINUE failed");
+		return -1;
+	}
+	return 0;
+}
+
+int check_equal(char *mapping, size_t length, char value)
+{
+	size_t i;
+
+	for (i = 0; i < length; ++i)
+		if (mapping[i] != value) {
+			printf("mismatch at %p (%d != %d)\n", &mapping[i],
+					mapping[i], value);
+			return -1;
+		}
+
+	return 0;
+}
+
+int test_continues(int uffd, char *primary_map, char *secondary_map, size_t len,
+		   bool verify)
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
+int test_collapse(char *primary_map, size_t len, bool hwpoison)
+{
+	size_t offset;
+	int i;
+	uint64_t size;
+
+	printf(PREFIX "collapsing %p -> %p\n", primary_map, primary_map + len);
+	if (madvise(primary_map, len, MADV_COLLAPSE) < 0) {
+		if (errno == EHWPOISON && hwpoison) {
+			/* this is expected for the hwpoison test. */
+			printf(PREFIX "could not collapse due to poison\n");
+			return 0;
+		}
+		perror("collapse failed");
+		return -1;
+	}
+
+	printf(PREFIX "verifying %p -> %p\n", primary_map, primary_map + len);
+
+	offset = 0;
+	i = 0;
+	for (size = len/2; size > 4096; offset += size, size /= 2) {
+		if (check_equal(primary_map + offset, size, ++i))
+			return -1;
+	}
+	/* expect the last 4K to be zero. */
+	if (check_equal(primary_map + len - 4096, 4096, 0))
+		return -1;
+
+	return 0;
+}
+
+static void *poisoned_addr;
+
+void sigbus_handler(int signo, siginfo_t *info, void *context)
+{
+	if (info->si_code != BUS_MCEERR_AR)
+		goto kill;
+	poisoned_addr = info->si_addr;
+kill:
+	pthread_exit(NULL);
+}
+
+void *access_mem(void *addr)
+{
+	volatile char *ptr = addr;
+
+	*ptr;
+	return NULL;
+}
+
+int test_poison_sigbus(char *addr)
+{
+	int ret = 0;
+	pthread_t pthread;
+
+	poisoned_addr = (void *)0xBADBADBAD;
+	ret = pthread_create(&pthread, NULL, &access_mem, addr);
+	if (pthread_create(&pthread, NULL, &access_mem, addr)) {
+		printf("failed to create thread: %s\n", strerror(ret));
+		return ret;
+	}
+
+	pthread_join(pthread, NULL);
+	if (poisoned_addr != addr) {
+		printf("got incorrect poisoned address: %p vs %p\n",
+				poisoned_addr, addr);
+		return -1;
+	}
+	return 0;
+}
+
+int test_hwpoison(char *primary_map, size_t len)
+{
+	const unsigned long pagesize = getpagesize();
+	const int num_poison_checks = 512;
+	unsigned long bytes_per_check = len/num_poison_checks;
+	struct sigaction new, old;
+	int i;
+
+	printf(PREFIX "poisoning %p -> %p\n", primary_map, primary_map + len);
+	if (madvise(primary_map, len, MADV_HWPOISON) < 0) {
+		perror("MADV_HWPOISON failed");
+		return -1;
+	}
+
+	printf(PREFIX "checking that it was poisoned "
+	       "(%d addresses within %p -> %p)\n",
+	       num_poison_checks, primary_map, primary_map + len);
+
+	new.sa_sigaction = &sigbus_handler;
+	new.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &new, &old) < 0) {
+		perror("could not setup SIGBUS handler");
+		return -1;
+	}
+
+	if (pagesize > bytes_per_check)
+		bytes_per_check = pagesize;
+
+	for (i = 0; i < len; i += bytes_per_check)
+		if (test_poison_sigbus(primary_map + i) < 0)
+			return -1;
+	/* check very last byte, because we left it unmapped */
+	if (test_poison_sigbus(primary_map + len - 1))
+		return -1;
+
+	return 0;
+}
+
+int test_hgm(int fd, size_t hugepagesize, size_t len, bool hwpoison)
+{
+	int ret = 0;
+	int uffd;
+	char *primary_map, *secondary_map;
+	struct uffdio_api api;
+	struct uffdio_register reg;
+
+	if (ftruncate(fd, len) < 0) {
+		perror("ftruncate failed");
+		return -1;
+	}
+
+	uffd = userfaultfd(O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		perror("uffd not created");
+		return -1;
+	}
+
+	primary_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (primary_map == MAP_FAILED) {
+		perror("mmap for primary mapping failed");
+		ret = -1;
+		goto close_uffd;
+	}
+	secondary_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (secondary_map == MAP_FAILED) {
+		perror("mmap for secondary mapping failed");
+		ret = -1;
+		goto unmap_primary;
+	}
+
+	printf(PREFIX "primary mapping: %p\n", primary_map);
+	printf(PREFIX "secondary mapping: %p\n", secondary_map);
+
+	api.api = UFFD_API;
+	api.features = UFFD_FEATURE_MINOR_HUGETLBFS |
+		UFFD_FEATURE_MISSING_HUGETLBFS |
+		UFFD_FEATURE_MINOR_HUGETLBFS_HGM | UFFD_FEATURE_SIGBUS |
+		UFFD_FEATURE_EXACT_ADDRESS;
+	if (ioctl(uffd, UFFDIO_API, &api) == -1) {
+		perror("UFFDIO_API failed");
+		ret = -1;
+		goto out;
+	}
+	if (!(api.features & UFFD_FEATURE_MINOR_HUGETLBFS_HGM)) {
+		puts("UFFD_FEATURE_MINOR_HUGETLBFS_HGM not present");
+		ret = -1;
+		goto out;
+	}
+
+	reg.range.start = (unsigned long)primary_map;
+	reg.range.len = len;
+	reg.mode = UFFDIO_REGISTER_MODE_MINOR | UFFDIO_REGISTER_MODE_MISSING;
+	reg.ioctls = 0;
+	if (ioctl(uffd, UFFDIO_REGISTER, &reg) == -1) {
+		perror("register failed");
+		ret = -1;
+		goto out;
+	}
+
+	if (test_continues(uffd, primary_map, secondary_map, len, !hwpoison)
+		|| (hwpoison && test_hwpoison(primary_map, len))
+		|| test_collapse(primary_map, len, hwpoison)) {
+		ret = -1;
+	}
+
+	if (ftruncate(fd, 0) < 0) {
+		perror("ftruncate back to 0 failed");
+		ret = -1;
+	}
+
+out:
+	munmap(secondary_map, len);
+unmap_primary:
+	munmap(primary_map, len);
+close_uffd:
+	close(uffd);
+	return ret;
+}
+
+int main(void)
+{
+	int fd;
+	struct statfs file_stat;
+	size_t hugepagesize;
+	size_t len;
+
+	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
+	if (fd < 0) {
+		perror("could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(&file_stat, 0, sizeof(file_stat));
+	if (fstatfs(fd, &file_stat)) {
+		perror("fstatfs failed");
+		goto close;
+	}
+	if (file_stat.f_type != HUGETLBFS_MAGIC) {
+		printf("not hugetlbfs file\n");
+		goto close;
+	}
+
+	hugepagesize = file_stat.f_bsize;
+	len = 2 * hugepagesize;
+	printf("HGM regular test...\n");
+	printf("HGM regular test:  %s\n",
+			test_hgm(fd, hugepagesize, len, false)
+			? "FAILED" : "PASSED");
+	printf("HGM hwpoison test...\n");
+	printf("HGM hwpoison test: %s\n",
+			test_hgm(fd, hugepagesize, len, true)
+			? "FAILED" : "PASSED");
+close:
+	close(fd);
+
+	return 0;
+}
-- 
2.38.0.135.g90850a2211-goog

