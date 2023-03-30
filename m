Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD56D0AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjC3QIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjC3QIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE908A246
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=db6YoFSypJnTIouTrDztz4PPOGN8H3NbJ+XG7IwkLI4=;
        b=PgqipptT0NZnLIk3hlnRW5c9tVkEdvA2T6UIN2Pd9XEq2SHyYnQdM13vajQZdh0hM0qpkB
        kPtRlsYkVdqew1pN+tMHZRBYVRaXykCRwN0xF8bkP6TmLcLC9KOeVSUWijsgT5xezuG7cK
        qJVo9Fl/fG4YwgbC5Otgx4u4f7UdjV4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ckhZSk5OMpqK3CXIwQ1u4g-1; Thu, 30 Mar 2023 12:07:24 -0400
X-MC-Unique: ckhZSk5OMpqK3CXIwQ1u4g-1
Received: by mail-qt1-f197.google.com with SMTP id u22-20020a05622a011600b003dfd61e8594so12717107qtw.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192444; x=1682784444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=db6YoFSypJnTIouTrDztz4PPOGN8H3NbJ+XG7IwkLI4=;
        b=zt8Y/qvTFuDnir1hHAmk2yR+Ctu5+V3DnhapczasvL2NxAdx/9mekUtZID6U15Vncv
         mqXISRNjjpC6DAtAq7qgBiG5h8dleK4cl32lYaiBHvf8BO/bc/Zy3ZmZWqriGZKINK/e
         5gvyeKx26260wEmg8k+JIMeY761sN3eLIGkrdPyZjNEBeJJqgVoM7r711KgWqDxl+G/q
         pQT7IwJWZWIpSXPIf5BYfzi8bcI/mE47sGbcxwxVwaqhL0NEL/lf8TNyZC+amHOYQrNM
         sWFPrJTcOQCdRF2h+VUjAm6bOGomDWGd89SmHuGtP7NGnwvtWwQb66OtSOdkuObL0jz6
         t59g==
X-Gm-Message-State: AO0yUKVeA31w2nbBod5qh3dhPh0W2qqiy8GLy6lZBo55W3ZTjMo97Po1
        LxFJyG8/sek6L/YjPjJKa+9iB70ryeTc2iJB/f6vpWCry0mpyiJC83HHaF1BRdT/eysHsQ2Ad8o
        YWc125cYsfqQMO7aa35ibmWlv
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr39966948qtx.1.1680192443357;
        Thu, 30 Mar 2023 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8NP+ElEFUZi/FQlI+wMTehrXi8sXGiQJhwf0nLobOlWBUuFRTmOho1iWz5s5A65oqwy/4F8g==
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr39966866qtx.1.1680192442731;
        Thu, 30 Mar 2023 09:07:22 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a0d4a00b0074281812276sm13066719qkl.97.2023.03.30.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 12/29] selftests/mm: Create uffd-common.[ch]
Date:   Thu, 30 Mar 2023 12:07:20 -0400
Message-Id: <20230330160720.3107021-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common utility functions into uffd-common.[ch] files from the original
userfaultfd.c.  This prepares for a split of userfaultfd.c into two tests:
one to only cover the old but powerful stress test, the other one covers
all the functional tests.

This movement is kind of a brute-force effort for now, with light touch-ups
but nothing should really change.  There's chances to optimize more, but
let's leave that for later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile      |   2 +
 tools/testing/selftests/mm/uffd-common.c | 611 ++++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h | 117 ++++
 tools/testing/selftests/mm/userfaultfd.c | 694 +----------------------
 4 files changed, 731 insertions(+), 693 deletions(-)
 create mode 100644 tools/testing/selftests/mm/uffd-common.c
 create mode 100644 tools/testing/selftests/mm/uffd-common.h

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index b35f3eafde3c..9c3737285f8a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -107,6 +107,8 @@ include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c
 
+$(OUTPUT)/userfaultfd: uffd-common.c
+
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
new file mode 100644
index 000000000000..c57757c2a36f
--- /dev/null
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Userfaultfd tests util functions
+ *
+ * Copyright (C) 2015-2023  Red Hat, Inc.
+ */
+
+#include "uffd-common.h"
+
+#define BASE_PMD_ADDR ((void *)(1UL << 30))
+
+volatile bool test_uffdio_copy_eexist = true;
+unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
+char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
+int mem_fd, uffd = -1, uffd_flags, finished, *pipefd, test_type;
+bool map_shared, test_collapse, test_dev_userfaultfd;
+bool test_uffdio_wp = true, test_uffdio_minor = false;
+unsigned long long *count_verify;
+uffd_test_ops_t *uffd_test_ops;
+
+static void anon_release_pages(char *rel_area)
+{
+	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+}
+
+static void anon_allocate_area(void **alloc_area, bool is_src)
+{
+	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+}
+
+static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+}
+
+static void hugetlb_release_pages(char *rel_area)
+{
+	if (!map_shared) {
+		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+			err("madvise(MADV_DONTNEED) failed");
+	} else {
+		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+			err("madvise(MADV_REMOVE) failed");
+	}
+}
+
+static void hugetlb_allocate_area(void **alloc_area, bool is_src)
+{
+	off_t size = nr_pages * page_size;
+	off_t offset = is_src ? 0 : size;
+	void *area_alias = NULL;
+	char **alloc_area_alias;
+
+	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
+			   (is_src ? 0 : MAP_NORESERVE),
+			   mem_fd, offset);
+	if (*alloc_area == MAP_FAILED)
+		err("mmap of hugetlbfs file failed");
+
+	if (map_shared) {
+		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
+				  MAP_SHARED, mem_fd, offset);
+		if (area_alias == MAP_FAILED)
+			err("mmap of hugetlb file alias failed");
+	}
+
+	if (is_src) {
+		alloc_area_alias = &area_src_alias;
+	} else {
+		alloc_area_alias = &area_dst_alias;
+	}
+	if (area_alias)
+		*alloc_area_alias = area_alias;
+}
+
+static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	if (!map_shared)
+		return;
+
+	*start = (unsigned long) area_dst_alias + offset;
+}
+
+static void shmem_release_pages(char *rel_area)
+{
+	if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+		err("madvise(MADV_REMOVE) failed");
+}
+
+static void shmem_allocate_area(void **alloc_area, bool is_src)
+{
+	void *area_alias = NULL;
+	size_t bytes = nr_pages * page_size;
+	unsigned long offset = is_src ? 0 : bytes;
+	char *p = NULL, *p_alias = NULL;
+
+	if (test_collapse) {
+		p = BASE_PMD_ADDR;
+		if (!is_src)
+			/* src map + alias + interleaved hpages */
+			p += 2 * (bytes + hpage_size);
+		p_alias = p;
+		p_alias += bytes;
+		p_alias += hpage_size;  /* Prevent src/dst VMA merge */
+	}
+
+	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   mem_fd, offset);
+	if (*alloc_area == MAP_FAILED)
+		err("mmap of memfd failed");
+	if (test_collapse && *alloc_area != p)
+		err("mmap of memfd failed at %p", p);
+
+	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+			  mem_fd, offset);
+	if (area_alias == MAP_FAILED)
+		err("mmap of memfd alias failed");
+	if (test_collapse && area_alias != p_alias)
+		err("mmap of anonymous memory failed at %p", p_alias);
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+}
+
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
+}
+
+static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
+{
+	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_size))
+		err("Did not find expected %d number of hugepages",
+		    expect_nr_hpages);
+}
+
+struct uffd_test_ops anon_uffd_test_ops = {
+	.allocate_area = anon_allocate_area,
+	.release_pages = anon_release_pages,
+	.alias_mapping = noop_alias_mapping,
+	.check_pmd_mapping = NULL,
+};
+
+struct uffd_test_ops shmem_uffd_test_ops = {
+	.allocate_area = shmem_allocate_area,
+	.release_pages = shmem_release_pages,
+	.alias_mapping = shmem_alias_mapping,
+	.check_pmd_mapping = shmem_check_pmd_mapping,
+};
+
+struct uffd_test_ops hugetlb_uffd_test_ops = {
+	.allocate_area = hugetlb_allocate_area,
+	.release_pages = hugetlb_release_pages,
+	.alias_mapping = hugetlb_alias_mapping,
+	.check_pmd_mapping = NULL,
+};
+
+void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
+{
+	int i;
+	unsigned long long miss_total = 0, wp_total = 0, minor_total = 0;
+
+	for (i = 0; i < n_cpus; i++) {
+		miss_total += stats[i].missing_faults;
+		wp_total += stats[i].wp_faults;
+		minor_total += stats[i].minor_faults;
+	}
+
+	printf("userfaults: ");
+	if (miss_total) {
+		printf("%llu missing (", miss_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].missing_faults);
+		printf("\b) ");
+	}
+	if (wp_total) {
+		printf("%llu wp (", wp_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].wp_faults);
+		printf("\b) ");
+	}
+	if (minor_total) {
+		printf("%llu minor (", minor_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].minor_faults);
+		printf("\b)");
+	}
+	printf("\n");
+}
+
+static int __userfaultfd_open_dev(void)
+{
+	int fd, _uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
+
+	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
+	if (_uffd < 0)
+		errexit(errno == ENOTTY ? KSFT_SKIP : 1,
+			"creating userfaultfd failed");
+	close(fd);
+	return _uffd;
+}
+
+void userfaultfd_open(uint64_t *features)
+{
+	struct uffdio_api uffdio_api;
+
+	if (test_dev_userfaultfd)
+		uffd = __userfaultfd_open_dev();
+	else {
+		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
+		if (uffd < 0)
+			errexit(errno == ENOSYS ? KSFT_SKIP : 1,
+				"creating userfaultfd failed");
+	}
+	uffd_flags = fcntl(uffd, F_GETFD, NULL);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = *features;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		err("UFFDIO_API failed.\nPlease make sure to "
+		    "run with either root or ptrace capability.");
+	if (uffdio_api.api != UFFD_API)
+		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
+
+	*features = uffdio_api.features;
+}
+
+static inline void munmap_area(void **area)
+{
+	if (*area)
+		if (munmap(*area, nr_pages * page_size))
+			err("munmap");
+
+	*area = NULL;
+}
+
+static void uffd_test_ctx_clear(void)
+{
+	size_t i;
+
+	if (pipefd) {
+		for (i = 0; i < nr_cpus * 2; ++i) {
+			if (close(pipefd[i]))
+				err("close pipefd");
+		}
+		free(pipefd);
+		pipefd = NULL;
+	}
+
+	if (count_verify) {
+		free(count_verify);
+		count_verify = NULL;
+	}
+
+	if (uffd != -1) {
+		if (close(uffd))
+			err("close uffd");
+		uffd = -1;
+	}
+
+	munmap_area((void **)&area_src);
+	munmap_area((void **)&area_src_alias);
+	munmap_area((void **)&area_dst);
+	munmap_area((void **)&area_dst_alias);
+	munmap_area((void **)&area_remap);
+}
+
+void uffd_test_ctx_init(uint64_t features)
+{
+	unsigned long nr, cpu;
+
+	uffd_test_ctx_clear();
+
+	uffd_test_ops->allocate_area((void **)&area_src, true);
+	uffd_test_ops->allocate_area((void **)&area_dst, false);
+
+	userfaultfd_open(&features);
+
+	count_verify = malloc(nr_pages * sizeof(unsigned long long));
+	if (!count_verify)
+		err("count_verify");
+
+	for (nr = 0; nr < nr_pages; nr++) {
+		*area_mutex(area_src, nr) =
+			(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
+		count_verify[nr] = *area_count(area_src, nr) = 1;
+		/*
+		 * In the transition between 255 to 256, powerpc will
+		 * read out of order in my_bcmp and see both bytes as
+		 * zero, so leave a placeholder below always non-zero
+		 * after the count, to avoid my_bcmp to trigger false
+		 * positives.
+		 */
+		*(area_count(area_src, nr) + 1) = 1;
+	}
+
+	/*
+	 * After initialization of area_src, we must explicitly release pages
+	 * for area_dst to make sure it's fully empty.  Otherwise we could have
+	 * some area_dst pages be errornously initialized with zero pages,
+	 * hence we could hit memory corruption later in the test.
+	 *
+	 * One example is when THP is globally enabled, above allocate_area()
+	 * calls could have the two areas merged into a single VMA (as they
+	 * will have the same VMA flags so they're mergeable).  When we
+	 * initialize the area_src above, it's possible that some part of
+	 * area_dst could have been faulted in via one huge THP that will be
+	 * shared between area_src and area_dst.  It could cause some of the
+	 * area_dst won't be trapped by missing userfaults.
+	 *
+	 * This release_pages() will guarantee even if that happened, we'll
+	 * proactively split the thp and drop any accidentally initialized
+	 * pages within area_dst.
+	 */
+	uffd_test_ops->release_pages(area_dst);
+
+	pipefd = malloc(sizeof(int) * nr_cpus * 2);
+	if (!pipefd)
+		err("pipefd");
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
+			err("pipe");
+}
+
+uint64_t get_expected_ioctls(uint64_t mode)
+{
+	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
+
+	if (test_type == TEST_HUGETLB)
+		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
+		ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
+		ioctls &= ~(1 << _UFFDIO_CONTINUE);
+
+	return ioctls;
+}
+
+void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
+{
+	uint64_t expected = get_expected_ioctls(mode);
+	uint64_t actual = ioctls & expected;
+
+	if (actual != expected) {
+		err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx64,
+		    expected, actual);
+	}
+}
+
+void wp_range(int ufd, __u64 start, __u64 len, bool wp)
+{
+	struct uffdio_writeprotect prms;
+
+	/* Write protection page faults */
+	prms.range.start = start;
+	prms.range.len = len;
+	/* Undo write-protect, do wakeup after that */
+	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
+
+	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
+		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
+}
+
+static void continue_range(int ufd, __u64 start, __u64 len)
+{
+	struct uffdio_continue req;
+	int ret;
+
+	req.range.start = start;
+	req.range.len = len;
+	req.mode = 0;
+	if (test_uffdio_wp)
+		req.mode |= UFFDIO_CONTINUE_MODE_WP;
+
+	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
+		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
+		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, (int64_t) req.mapped);
+}
+
+int uffd_read_msg(int ufd, struct uffd_msg *msg)
+{
+	int ret = read(uffd, msg, sizeof(*msg));
+
+	if (ret != sizeof(*msg)) {
+		if (ret < 0) {
+			if (errno == EAGAIN || errno == EINTR)
+				return 1;
+			err("blocking read error");
+		} else {
+			err("short read");
+		}
+	}
+
+	return 0;
+}
+
+void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
+		/* Write protect page faults */
+		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		stats->wp_faults++;
+	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
+		uint8_t *area;
+		int b;
+
+		/*
+		 * Minor page faults
+		 *
+		 * To prove we can modify the original range for testing
+		 * purposes, we're going to bit flip this range before
+		 * continuing.
+		 *
+		 * Note that this requires all minor page fault tests operate on
+		 * area_dst (non-UFFD-registered) and area_dst_alias
+		 * (UFFD-registered).
+		 */
+
+		area = (uint8_t *)(area_dst +
+				   ((char *)msg->arg.pagefault.address -
+				    area_dst_alias));
+		for (b = 0; b < page_size; ++b)
+			area[b] = ~area[b];
+		continue_range(uffd, msg->arg.pagefault.address, page_size);
+		stats->minor_faults++;
+	} else {
+		/*
+		 * Missing page faults.
+		 *
+		 * Here we force a write check for each of the missing mode
+		 * faults.  It's guaranteed because the only threads that
+		 * will trigger uffd faults are the locking threads, and
+		 * their first instruction to touch the missing page will
+		 * always be pthread_mutex_lock().
+		 *
+		 * Note that here we relied on an NPTL glibc impl detail to
+		 * always read the lock type at the entry of the lock op
+		 * (pthread_mutex_t.__data.__type, offset 0x10) before
+		 * doing any locking operations to guarantee that.  It's
+		 * actually not good to rely on this impl detail because
+		 * logically a pthread-compatible lib can implement the
+		 * locks without types and we can fail when linking with
+		 * them.  However since we used to find bugs with this
+		 * strict check we still keep it around.  Hopefully this
+		 * could be a good hint when it fails again.  If one day
+		 * it'll break on some other impl of glibc we'll revisit.
+		 */
+		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+			err("unexpected write fault");
+
+		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+		offset &= ~(page_size-1);
+
+		if (copy_page(uffd, offset))
+			stats->missing_faults++;
+	}
+}
+
+void *uffd_poll_thread(void *arg)
+{
+	struct uffd_stats *stats = (struct uffd_stats *)arg;
+	unsigned long cpu = stats->cpu;
+	struct pollfd pollfd[2];
+	struct uffd_msg msg;
+	struct uffdio_register uffd_reg;
+	int ret;
+	char tmp_chr;
+
+	pollfd[0].fd = uffd;
+	pollfd[0].events = POLLIN;
+	pollfd[1].fd = pipefd[cpu*2];
+	pollfd[1].events = POLLIN;
+
+	for (;;) {
+		ret = poll(pollfd, 2, -1);
+		if (ret <= 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			err("poll error: %d", ret);
+		}
+		if (pollfd[1].revents) {
+			if (!(pollfd[1].revents & POLLIN))
+				err("pollfd[1].revents %d", pollfd[1].revents);
+			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
+				err("read pipefd error");
+			break;
+		}
+		if (!(pollfd[0].revents & POLLIN))
+			err("pollfd[0].revents %d", pollfd[0].revents);
+		if (uffd_read_msg(uffd, &msg))
+			continue;
+		switch (msg.event) {
+		default:
+			err("unexpected msg event %u\n", msg.event);
+			break;
+		case UFFD_EVENT_PAGEFAULT:
+			uffd_handle_page_fault(&msg, stats);
+			break;
+		case UFFD_EVENT_FORK:
+			close(uffd);
+			uffd = msg.arg.fork.ufd;
+			pollfd[0].fd = uffd;
+			break;
+		case UFFD_EVENT_REMOVE:
+			uffd_reg.range.start = msg.arg.remove.start;
+			uffd_reg.range.len = msg.arg.remove.end -
+				msg.arg.remove.start;
+			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
+				err("remove failure");
+			break;
+		case UFFD_EVENT_REMAP:
+			area_remap = area_dst;  /* save for later unmap */
+			area_dst = (char *)(unsigned long)msg.arg.remap.to;
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
+			    unsigned long offset)
+{
+	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
+				     uffdio_copy->len,
+				     offset);
+	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
+		/* real retval in ufdio_copy.copy */
+		if (uffdio_copy->copy != -EEXIST)
+			err("UFFDIO_COPY retry error: %"PRId64,
+			    (int64_t)uffdio_copy->copy);
+	} else {
+		err("UFFDIO_COPY retry unexpected: %"PRId64,
+		    (int64_t)uffdio_copy->copy);
+	}
+}
+
+static void wake_range(int ufd, unsigned long addr, unsigned long len)
+{
+	struct uffdio_range uffdio_wake;
+
+	uffdio_wake.start = addr;
+	uffdio_wake.len = len;
+
+	if (ioctl(ufd, UFFDIO_WAKE, &uffdio_wake))
+		fprintf(stderr, "error waking %lu\n",
+			addr), exit(1);
+}
+
+int __copy_page(int ufd, unsigned long offset, bool retry)
+{
+	struct uffdio_copy uffdio_copy;
+
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu\n", offset);
+	uffdio_copy.dst = (unsigned long) area_dst + offset;
+	uffdio_copy.src = (unsigned long) area_src + offset;
+	uffdio_copy.len = page_size;
+	if (test_uffdio_wp)
+		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
+	else
+		uffdio_copy.mode = 0;
+	uffdio_copy.copy = 0;
+	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
+		/* real retval in ufdio_copy.copy */
+		if (uffdio_copy.copy != -EEXIST)
+			err("UFFDIO_COPY error: %"PRId64,
+			    (int64_t)uffdio_copy.copy);
+		wake_range(ufd, uffdio_copy.dst, page_size);
+	} else if (uffdio_copy.copy != page_size) {
+		err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.copy);
+	} else {
+		if (test_uffdio_copy_eexist && retry) {
+			test_uffdio_copy_eexist = false;
+			retry_copy_page(ufd, &uffdio_copy, offset);
+		}
+		return 1;
+	}
+	return 0;
+}
+
+int copy_page(int ufd, unsigned long offset)
+{
+	return __copy_page(ufd, offset, false);
+}
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
new file mode 100644
index 000000000000..d9430cfdcb19
--- /dev/null
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Userfaultfd tests common header
+ *
+ * Copyright (C) 2015-2023  Red Hat, Inc.
+ */
+#ifndef __UFFD_COMMON_H__
+#define __UFFD_COMMON_H__
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <time.h>
+#include <signal.h>
+#include <poll.h>
+#include <string.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+#include <pthread.h>
+#include <linux/userfaultfd.h>
+#include <setjmp.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <sys/random.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+#define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
+
+#define _err(fmt, ...)						\
+	do {							\
+		int ret = errno;				\
+		fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);	\
+		fprintf(stderr, " (errno=%d, @%s:%d)\n",	\
+			ret, __FILE__, __LINE__);		\
+	} while (0)
+
+#define errexit(exitcode, fmt, ...)		\
+	do {					\
+		_err(fmt, ##__VA_ARGS__);	\
+		exit(exitcode);			\
+	} while (0)
+
+#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
+
+/* pthread_mutex_t starts at page offset 0 */
+#define area_mutex(___area, ___nr)					\
+	((pthread_mutex_t *) ((___area) + (___nr)*page_size))
+/*
+ * count is placed in the page after pthread_mutex_t naturally aligned
+ * to avoid non alignment faults on non-x86 archs.
+ */
+#define area_count(___area, ___nr)					\
+	((volatile unsigned long long *) ((unsigned long)		\
+				 ((___area) + (___nr)*page_size +	\
+				  sizeof(pthread_mutex_t) +		\
+				  sizeof(unsigned long long) - 1) &	\
+				 ~(unsigned long)(sizeof(unsigned long long) \
+						  -  1)))
+
+/* Userfaultfd test statistics */
+struct uffd_stats {
+	int cpu;
+	unsigned long missing_faults;
+	unsigned long wp_faults;
+	unsigned long minor_faults;
+};
+
+struct uffd_test_ops {
+	void (*allocate_area)(void **alloc_area, bool is_src);
+	void (*release_pages)(char *rel_area);
+	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
+	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
+};
+typedef struct uffd_test_ops uffd_test_ops_t;
+
+extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
+extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
+extern int mem_fd, uffd, uffd_flags, finished, *pipefd, test_type;
+extern bool map_shared, test_collapse, test_dev_userfaultfd;
+extern bool test_uffdio_wp, test_uffdio_minor;
+extern unsigned long long *count_verify;
+extern volatile bool test_uffdio_copy_eexist;
+
+extern uffd_test_ops_t anon_uffd_test_ops;
+extern uffd_test_ops_t shmem_uffd_test_ops;
+extern uffd_test_ops_t hugetlb_uffd_test_ops;
+extern uffd_test_ops_t *uffd_test_ops;
+
+void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
+void uffd_test_ctx_init(uint64_t features);
+void userfaultfd_open(uint64_t *features);
+uint64_t get_expected_ioctls(uint64_t mode);
+void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls);
+int uffd_read_msg(int ufd, struct uffd_msg *msg);
+void wp_range(int ufd, __u64 start, __u64 len, bool wp);
+void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
+int __copy_page(int ufd, unsigned long offset, bool retry);
+int copy_page(int ufd, unsigned long offset);
+void *uffd_poll_thread(void *arg);
+
+#define TEST_ANON	1
+#define TEST_HUGETLB	2
+#define TEST_SHMEM	3
+
+#endif
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 3487ec0bfcc8..c68a9aeefc41 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -34,96 +34,20 @@
  * transfer (UFFDIO_COPY).
  */
 
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <time.h>
-#include <signal.h>
-#include <poll.h>
-#include <string.h>
-#include <linux/mman.h>
-#include <sys/mman.h>
-#include <sys/syscall.h>
-#include <sys/ioctl.h>
-#include <sys/wait.h>
-#include <pthread.h>
-#include <linux/userfaultfd.h>
-#include <setjmp.h>
-#include <stdbool.h>
-#include <assert.h>
-#include <inttypes.h>
-#include <stdint.h>
-#include <sys/random.h>
-
-#include "../kselftest.h"
-#include "vm_util.h"
+#include "uffd-common.h"
 
 #ifdef __NR_userfaultfd
 
-static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
-
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
 #define BOUNCE_VERIFY		(1<<2)
 #define BOUNCE_POLL		(1<<3)
 static int bounces;
 
-#define TEST_ANON	1
-#define TEST_HUGETLB	2
-#define TEST_SHMEM	3
-static int test_type;
-
-#define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
-
-#define BASE_PMD_ADDR ((void *)(1UL << 30))
-
-/* test using /dev/userfaultfd, instead of userfaultfd(2) */
-static bool test_dev_userfaultfd;
-
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
-static volatile bool test_uffdio_copy_eexist = true;
-/* Whether to test uffd write-protection */
-static bool test_uffdio_wp = true;
-/* Whether to test uffd minor faults */
-static bool test_uffdio_minor = false;
-static bool map_shared;
-static int mem_fd;
-static unsigned long long *count_verify;
-static int uffd = -1;
-static int uffd_flags, finished, *pipefd;
-static char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 static char *zeropage;
 pthread_attr_t attr;
-static bool test_collapse;
-
-/* Userfaultfd test statistics */
-struct uffd_stats {
-	int cpu;
-	unsigned long missing_faults;
-	unsigned long wp_faults;
-	unsigned long minor_faults;
-};
-
-/* pthread_mutex_t starts at page offset 0 */
-#define area_mutex(___area, ___nr)					\
-	((pthread_mutex_t *) ((___area) + (___nr)*page_size))
-/*
- * count is placed in the page after pthread_mutex_t naturally aligned
- * to avoid non alignment faults on non-x86 archs.
- */
-#define area_count(___area, ___nr)					\
-	((volatile unsigned long long *) ((unsigned long)		\
-				 ((___area) + (___nr)*page_size +	\
-				  sizeof(pthread_mutex_t) +		\
-				  sizeof(unsigned long long) - 1) &	\
-				 ~(unsigned long)(sizeof(unsigned long long) \
-						  -  1)))
 
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
@@ -166,22 +90,6 @@ static void usage(void)
 	exit(1);
 }
 
-#define _err(fmt, ...)						\
-	do {							\
-		int ret = errno;				\
-		fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);	\
-		fprintf(stderr, " (errno=%d, line=%d)\n",	\
-			ret, __LINE__);				\
-	} while (0)
-
-#define errexit(exitcode, fmt, ...)		\
-	do {					\
-		_err(fmt, ##__VA_ARGS__);	\
-		exit(exitcode);			\
-	} while (0)
-
-#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
-
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 			     unsigned long n_cpus)
 {
@@ -195,189 +103,6 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 	}
 }
 
-static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
-{
-	int i;
-	unsigned long long miss_total = 0, wp_total = 0, minor_total = 0;
-
-	for (i = 0; i < n_cpus; i++) {
-		miss_total += stats[i].missing_faults;
-		wp_total += stats[i].wp_faults;
-		minor_total += stats[i].minor_faults;
-	}
-
-	printf("userfaults: ");
-	if (miss_total) {
-		printf("%llu missing (", miss_total);
-		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].missing_faults);
-		printf("\b) ");
-	}
-	if (wp_total) {
-		printf("%llu wp (", wp_total);
-		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].wp_faults);
-		printf("\b) ");
-	}
-	if (minor_total) {
-		printf("%llu minor (", minor_total);
-		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].minor_faults);
-		printf("\b)");
-	}
-	printf("\n");
-}
-
-static void anon_release_pages(char *rel_area)
-{
-	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
-		err("madvise(MADV_DONTNEED) failed");
-}
-
-static void anon_allocate_area(void **alloc_area, bool is_src)
-{
-	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-}
-
-static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
-{
-}
-
-static void hugetlb_release_pages(char *rel_area)
-{
-	if (!map_shared) {
-		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
-			err("madvise(MADV_DONTNEED) failed");
-	} else {
-		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
-			err("madvise(MADV_REMOVE) failed");
-	}
-}
-
-static void hugetlb_allocate_area(void **alloc_area, bool is_src)
-{
-	off_t size = nr_pages * page_size;
-	off_t offset = is_src ? 0 : size;
-	void *area_alias = NULL;
-	char **alloc_area_alias;
-
-	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
-			   (is_src ? 0 : MAP_NORESERVE),
-			   mem_fd, offset);
-	if (*alloc_area == MAP_FAILED)
-		err("mmap of hugetlbfs file failed");
-
-	if (map_shared) {
-		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
-				  MAP_SHARED, mem_fd, offset);
-		if (area_alias == MAP_FAILED)
-			err("mmap of hugetlb file alias failed");
-	}
-
-	if (is_src) {
-		alloc_area_alias = &area_src_alias;
-	} else {
-		alloc_area_alias = &area_dst_alias;
-	}
-	if (area_alias)
-		*alloc_area_alias = area_alias;
-}
-
-static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
-{
-	if (!map_shared)
-		return;
-
-	*start = (unsigned long) area_dst_alias + offset;
-}
-
-static void shmem_release_pages(char *rel_area)
-{
-	if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
-		err("madvise(MADV_REMOVE) failed");
-}
-
-static void shmem_allocate_area(void **alloc_area, bool is_src)
-{
-	void *area_alias = NULL;
-	size_t bytes = nr_pages * page_size;
-	unsigned long offset = is_src ? 0 : bytes;
-	char *p = NULL, *p_alias = NULL;
-
-	if (test_collapse) {
-		p = BASE_PMD_ADDR;
-		if (!is_src)
-			/* src map + alias + interleaved hpages */
-			p += 2 * (bytes + hpage_size);
-		p_alias = p;
-		p_alias += bytes;
-		p_alias += hpage_size;  /* Prevent src/dst VMA merge */
-	}
-
-	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			   mem_fd, offset);
-	if (*alloc_area == MAP_FAILED)
-		err("mmap of memfd failed");
-	if (test_collapse && *alloc_area != p)
-		err("mmap of memfd failed at %p", p);
-
-	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  mem_fd, offset);
-	if (area_alias == MAP_FAILED)
-		err("mmap of memfd alias failed");
-	if (test_collapse && area_alias != p_alias)
-		err("mmap of anonymous memory failed at %p", p_alias);
-
-	if (is_src)
-		area_src_alias = area_alias;
-	else
-		area_dst_alias = area_alias;
-}
-
-static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
-{
-	*start = (unsigned long)area_dst_alias + offset;
-}
-
-static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
-{
-	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_size))
-		err("Did not find expected %d number of hugepages",
-		    expect_nr_hpages);
-}
-
-struct uffd_test_ops {
-	void (*allocate_area)(void **alloc_area, bool is_src);
-	void (*release_pages)(char *rel_area);
-	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
-	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
-};
-
-static struct uffd_test_ops anon_uffd_test_ops = {
-	.allocate_area	= anon_allocate_area,
-	.release_pages	= anon_release_pages,
-	.alias_mapping = noop_alias_mapping,
-	.check_pmd_mapping = NULL,
-};
-
-static struct uffd_test_ops shmem_uffd_test_ops = {
-	.allocate_area	= shmem_allocate_area,
-	.release_pages	= shmem_release_pages,
-	.alias_mapping = shmem_alias_mapping,
-	.check_pmd_mapping = shmem_check_pmd_mapping,
-};
-
-static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.allocate_area	= hugetlb_allocate_area,
-	.release_pages	= hugetlb_release_pages,
-	.alias_mapping = hugetlb_alias_mapping,
-	.check_pmd_mapping = NULL,
-};
-
-static struct uffd_test_ops *uffd_test_ops;
-
 static inline uint64_t uffd_minor_feature(void)
 {
 	if (test_type == TEST_HUGETLB && map_shared)
@@ -388,171 +113,6 @@ static inline uint64_t uffd_minor_feature(void)
 		return 0;
 }
 
-static uint64_t get_expected_ioctls(uint64_t mode)
-{
-	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
-
-	if (test_type == TEST_HUGETLB)
-		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
-
-	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
-		ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
-
-	if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
-		ioctls &= ~(1 << _UFFDIO_CONTINUE);
-
-	return ioctls;
-}
-
-static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
-{
-	uint64_t expected = get_expected_ioctls(mode);
-	uint64_t actual = ioctls & expected;
-
-	if (actual != expected) {
-		err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx64,
-		    expected, actual);
-	}
-}
-
-static int __userfaultfd_open_dev(void)
-{
-	int fd, _uffd;
-
-	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
-
-	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
-	if (_uffd < 0)
-		errexit(errno == ENOTTY ? KSFT_SKIP : 1,
-			"creating userfaultfd failed");
-	close(fd);
-	return _uffd;
-}
-
-static void userfaultfd_open(uint64_t *features)
-{
-	struct uffdio_api uffdio_api;
-
-	if (test_dev_userfaultfd)
-		uffd = __userfaultfd_open_dev();
-	else {
-		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
-		if (uffd < 0)
-			errexit(errno == ENOSYS ? KSFT_SKIP : 1,
-				"creating userfaultfd failed");
-	}
-	uffd_flags = fcntl(uffd, F_GETFD, NULL);
-
-	uffdio_api.api = UFFD_API;
-	uffdio_api.features = *features;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
-		err("UFFDIO_API failed.\nPlease make sure to "
-		    "run with either root or ptrace capability.");
-	if (uffdio_api.api != UFFD_API)
-		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
-
-	*features = uffdio_api.features;
-}
-
-static inline void munmap_area(void **area)
-{
-	if (*area)
-		if (munmap(*area, nr_pages * page_size))
-			err("munmap");
-
-	*area = NULL;
-}
-
-static void uffd_test_ctx_clear(void)
-{
-	size_t i;
-
-	if (pipefd) {
-		for (i = 0; i < nr_cpus * 2; ++i) {
-			if (close(pipefd[i]))
-				err("close pipefd");
-		}
-		free(pipefd);
-		pipefd = NULL;
-	}
-
-	if (count_verify) {
-		free(count_verify);
-		count_verify = NULL;
-	}
-
-	if (uffd != -1) {
-		if (close(uffd))
-			err("close uffd");
-		uffd = -1;
-	}
-
-	munmap_area((void **)&area_src);
-	munmap_area((void **)&area_src_alias);
-	munmap_area((void **)&area_dst);
-	munmap_area((void **)&area_dst_alias);
-	munmap_area((void **)&area_remap);
-}
-
-static void uffd_test_ctx_init(uint64_t features)
-{
-	unsigned long nr, cpu;
-
-	uffd_test_ctx_clear();
-
-	uffd_test_ops->allocate_area((void **)&area_src, true);
-	uffd_test_ops->allocate_area((void **)&area_dst, false);
-
-	userfaultfd_open(&features);
-
-	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-	if (!count_verify)
-		err("count_verify");
-
-	for (nr = 0; nr < nr_pages; nr++) {
-		*area_mutex(area_src, nr) =
-			(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
-		count_verify[nr] = *area_count(area_src, nr) = 1;
-		/*
-		 * In the transition between 255 to 256, powerpc will
-		 * read out of order in my_bcmp and see both bytes as
-		 * zero, so leave a placeholder below always non-zero
-		 * after the count, to avoid my_bcmp to trigger false
-		 * positives.
-		 */
-		*(area_count(area_src, nr) + 1) = 1;
-	}
-
-	/*
-	 * After initialization of area_src, we must explicitly release pages
-	 * for area_dst to make sure it's fully empty.  Otherwise we could have
-	 * some area_dst pages be errornously initialized with zero pages,
-	 * hence we could hit memory corruption later in the test.
-	 *
-	 * One example is when THP is globally enabled, above allocate_area()
-	 * calls could have the two areas merged into a single VMA (as they
-	 * will have the same VMA flags so they're mergeable).  When we
-	 * initialize the area_src above, it's possible that some part of
-	 * area_dst could have been faulted in via one huge THP that will be
-	 * shared between area_src and area_dst.  It could cause some of the
-	 * area_dst won't be trapped by missing userfaults.
-	 *
-	 * This release_pages() will guarantee even if that happened, we'll
-	 * proactively split the thp and drop any accidentally initialized
-	 * pages within area_dst.
-	 */
-	uffd_test_ops->release_pages(area_dst);
-
-	pipefd = malloc(sizeof(int) * nr_cpus * 2);
-	if (!pipefd)
-		err("pipefd");
-	for (cpu = 0; cpu < nr_cpus; cpu++)
-		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
-			err("pipe");
-}
-
 static int my_bcmp(char *str1, char *str2, size_t n)
 {
 	unsigned long i;
@@ -562,47 +122,6 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 	return 0;
 }
 
-static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
-{
-	struct uffdio_writeprotect prms;
-
-	/* Write protection page faults */
-	prms.range.start = start;
-	prms.range.len = len;
-	/* Undo write-protect, do wakeup after that */
-	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
-
-	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
-		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
-}
-
-static void continue_range(int ufd, __u64 start, __u64 len)
-{
-	struct uffdio_continue req;
-	int ret;
-
-	req.range.start = start;
-	req.range.len = len;
-	req.mode = 0;
-	if (test_uffdio_wp)
-		req.mode |= UFFDIO_CONTINUE_MODE_WP;
-
-	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
-		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
-		    (uint64_t)start);
-
-	/*
-	 * Error handling within the kernel for continue is subtly different
-	 * from copy or zeropage, so it may be a source of bugs. Trigger an
-	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
-	 */
-	req.mapped = 0;
-	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
-	if (ret >= 0 || req.mapped != -EEXIST)
-		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
-		    ret, (int64_t) req.mapped);
-}
-
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -635,222 +154,11 @@ static void *locking_thread(void *arg)
 	return NULL;
 }
 
-static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
-			    unsigned long offset)
-{
-	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
-				     uffdio_copy->len,
-				     offset);
-	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
-		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy->copy != -EEXIST)
-			err("UFFDIO_COPY retry error: %"PRId64,
-			    (int64_t)uffdio_copy->copy);
-	} else {
-		err("UFFDIO_COPY retry unexpected: %"PRId64,
-		    (int64_t)uffdio_copy->copy);
-	}
-}
-
-static void wake_range(int ufd, unsigned long addr, unsigned long len)
-{
-	struct uffdio_range uffdio_wake;
-
-	uffdio_wake.start = addr;
-	uffdio_wake.len = len;
-
-	if (ioctl(ufd, UFFDIO_WAKE, &uffdio_wake))
-		fprintf(stderr, "error waking %lu\n",
-			addr), exit(1);
-}
-
-static int __copy_page(int ufd, unsigned long offset, bool retry)
-{
-	struct uffdio_copy uffdio_copy;
-
-	if (offset >= nr_pages * page_size)
-		err("unexpected offset %lu\n", offset);
-	uffdio_copy.dst = (unsigned long) area_dst + offset;
-	uffdio_copy.src = (unsigned long) area_src + offset;
-	uffdio_copy.len = page_size;
-	if (test_uffdio_wp)
-		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
-	else
-		uffdio_copy.mode = 0;
-	uffdio_copy.copy = 0;
-	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
-		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy.copy != -EEXIST)
-			err("UFFDIO_COPY error: %"PRId64,
-			    (int64_t)uffdio_copy.copy);
-		wake_range(ufd, uffdio_copy.dst, page_size);
-	} else if (uffdio_copy.copy != page_size) {
-		err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.copy);
-	} else {
-		if (test_uffdio_copy_eexist && retry) {
-			test_uffdio_copy_eexist = false;
-			retry_copy_page(ufd, &uffdio_copy, offset);
-		}
-		return 1;
-	}
-	return 0;
-}
-
 static int copy_page_retry(int ufd, unsigned long offset)
 {
 	return __copy_page(ufd, offset, true);
 }
 
-static int copy_page(int ufd, unsigned long offset)
-{
-	return __copy_page(ufd, offset, false);
-}
-
-static int uffd_read_msg(int ufd, struct uffd_msg *msg)
-{
-	int ret = read(uffd, msg, sizeof(*msg));
-
-	if (ret != sizeof(*msg)) {
-		if (ret < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				return 1;
-			err("blocking read error");
-		} else {
-			err("short read");
-		}
-	}
-
-	return 0;
-}
-
-static void uffd_handle_page_fault(struct uffd_msg *msg,
-				   struct uffd_stats *stats)
-{
-	unsigned long offset;
-
-	if (msg->event != UFFD_EVENT_PAGEFAULT)
-		err("unexpected msg event %u", msg->event);
-
-	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
-		/* Write protect page faults */
-		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
-		stats->wp_faults++;
-	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
-		uint8_t *area;
-		int b;
-
-		/*
-		 * Minor page faults
-		 *
-		 * To prove we can modify the original range for testing
-		 * purposes, we're going to bit flip this range before
-		 * continuing.
-		 *
-		 * Note that this requires all minor page fault tests operate on
-		 * area_dst (non-UFFD-registered) and area_dst_alias
-		 * (UFFD-registered).
-		 */
-
-		area = (uint8_t *)(area_dst +
-				   ((char *)msg->arg.pagefault.address -
-				    area_dst_alias));
-		for (b = 0; b < page_size; ++b)
-			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size);
-		stats->minor_faults++;
-	} else {
-		/*
-		 * Missing page faults.
-		 *
-		 * Here we force a write check for each of the missing mode
-		 * faults.  It's guaranteed because the only threads that
-		 * will trigger uffd faults are the locking threads, and
-		 * their first instruction to touch the missing page will
-		 * always be pthread_mutex_lock().
-		 *
-		 * Note that here we relied on an NPTL glibc impl detail to
-		 * always read the lock type at the entry of the lock op
-		 * (pthread_mutex_t.__data.__type, offset 0x10) before
-		 * doing any locking operations to guarantee that.  It's
-		 * actually not good to rely on this impl detail because
-		 * logically a pthread-compatible lib can implement the
-		 * locks without types and we can fail when linking with
-		 * them.  However since we used to find bugs with this
-		 * strict check we still keep it around.  Hopefully this
-		 * could be a good hint when it fails again.  If one day
-		 * it'll break on some other impl of glibc we'll revisit.
-		 */
-		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
-			err("unexpected write fault");
-
-		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
-		offset &= ~(page_size-1);
-
-		if (copy_page(uffd, offset))
-			stats->missing_faults++;
-	}
-}
-
-static void *uffd_poll_thread(void *arg)
-{
-	struct uffd_stats *stats = (struct uffd_stats *)arg;
-	unsigned long cpu = stats->cpu;
-	struct pollfd pollfd[2];
-	struct uffd_msg msg;
-	struct uffdio_register uffd_reg;
-	int ret;
-	char tmp_chr;
-
-	pollfd[0].fd = uffd;
-	pollfd[0].events = POLLIN;
-	pollfd[1].fd = pipefd[cpu*2];
-	pollfd[1].events = POLLIN;
-
-	for (;;) {
-		ret = poll(pollfd, 2, -1);
-		if (ret <= 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
-			err("poll error: %d", ret);
-		}
-		if (pollfd[1].revents & POLLIN) {
-			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
-				err("read pipefd error");
-			break;
-		}
-		if (!(pollfd[0].revents & POLLIN))
-			err("pollfd[0].revents %d", pollfd[0].revents);
-		if (uffd_read_msg(uffd, &msg))
-			continue;
-		switch (msg.event) {
-		default:
-			err("unexpected msg event %u\n", msg.event);
-			break;
-		case UFFD_EVENT_PAGEFAULT:
-			uffd_handle_page_fault(&msg, stats);
-			break;
-		case UFFD_EVENT_FORK:
-			close(uffd);
-			uffd = msg.arg.fork.ufd;
-			pollfd[0].fd = uffd;
-			break;
-		case UFFD_EVENT_REMOVE:
-			uffd_reg.range.start = msg.arg.remove.start;
-			uffd_reg.range.len = msg.arg.remove.end -
-				msg.arg.remove.start;
-			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
-				err("remove failure");
-			break;
-		case UFFD_EVENT_REMAP:
-			area_remap = area_dst;  /* save for later unmap */
-			area_dst = (char *)(unsigned long)msg.arg.remap.to;
-			break;
-		}
-	}
-
-	return NULL;
-}
-
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static void *uffd_read_thread(void *arg)
-- 
2.39.1

