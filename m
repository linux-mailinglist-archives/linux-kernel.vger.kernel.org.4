Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C666DFBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDLQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144E8A60
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGYE1DDdeK4+pcxB+E5dvgvlIGHgCfc4atHqaHYPYpQ=;
        b=K07TSWG+xWXK96/48tbSWNcx6n1sXfX9dhviT/Ie0tQ1U0IKGlFY8H7bSSLb/5CSXsz/Vu
        64H4XJb2ygv/lcJT8vaQ6B/BR2DupvLjePZqpDD8sZ7l2Q5HCn4ma6t/UJ7F2Un3SxFxZa
        VzhhB/mZou8nL7ckU9NOG8chno36LlM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-nGWwhBwvN0qmsEaxmADopQ-1; Wed, 12 Apr 2023 12:44:02 -0400
X-MC-Unique: nGWwhBwvN0qmsEaxmADopQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74accc750c1so3422285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317841; x=1683909841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGYE1DDdeK4+pcxB+E5dvgvlIGHgCfc4atHqaHYPYpQ=;
        b=aNWo85nWYZ+7UpW2wT5rN44KkV5PPFd/dJkZNdoyx7Svew/uKcoFz8+VV+yvoWWzpj
         w48gQWG+v/yVNNVyNy5u0Iiex1xIbsfvlBmsMs0MKLuRUfk90jpFXKvVo4yVQr4jEJYL
         ZIFKAQdRf/fUg0CwWlQgPec48qdoyV4Xvh2i5NoHjuxBQq+laIkiMaT2FxTli2B86hL0
         ZsY5EgqGaVakikgjb2IO+V4zbqiuUubelVZ6y+MJJVbEk9s8ILPSsPArGVuQstKW2u6J
         S1IGA6vEvU08puSYNYCGLZs8HPkYy9qYaSbkni769Z6TQE/CPzsgyG8Bf6T4eyr2vssn
         A0xA==
X-Gm-Message-State: AAQBX9d5GQNmabQpnlt1LiOx/HvpDOACszvrL0ugpGFp9IFhOOCRQnLD
        urZR4qnQZfEXP9wUa50DtJwL1kQU/utLmz2XIQdgGRGGrwMoGIuaoRfr5ZszN++s0KrUkcJiK1F
        b1jMDtlzG1JWZ+94RvBNvHRYqo03kItYwh8MvxxoIlM7L8vmxVgKcUaW1v4R0GVzoyjcSOKnR07
        N378X7iQ==
X-Received: by 2002:a05:6214:528e:b0:5a5:e941:f33d with SMTP id kj14-20020a056214528e00b005a5e941f33dmr4706439qvb.3.1681317841005;
        Wed, 12 Apr 2023 09:44:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZjRI108S/AEWKqmkwW7425E04im1RHPeYTESzVUXReVKQDc9FypzgLpo/HuPpxAL+w9pWXmQ==
X-Received: by 2002:a05:6214:528e:b0:5a5:e941:f33d with SMTP id kj14-20020a056214528e00b005a5e941f33dmr4706400qvb.3.1681317840523;
        Wed, 12 Apr 2023 09:44:00 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o191-20020a3741c8000000b0074abe1e1457sm777268qka.76.2023.04.12.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: [PATCH v2 24/31] selftests/mm: Move uffd minor test to unit test
Date:   Wed, 12 Apr 2023 12:43:57 -0400
Message-Id: <20230412164357.328779-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the minor test to the new unit test.

Rewrite the content check with char* opeartions to avoid fiddling with
my_bcmp().

Drop global vars test_uffdio_minor and test_collapse, just assume test them
always in common code for now.

OTOH make this single test into five tests:

  - minor test on [shmem, hugetlb] with wp=false
  - minor test on [shmem, hugetlb] with wp=true
  - minor test + collapse on shmem only

One thing to mention that we used to test COLLAPSE+WP but that doesn't
sound right at all.  It's possible it's silently broken but unnoticed
because COLLAPSE is not part of the default test suite.

Make the MADV_COLLAPSE test fail-able (by skip it when failing), because
it's not guaranteed to success anyway.

Drop a bunch of useless code after the move, because the unit test always
use aligned num of pages and has nothing to do with n_cpus.

Cc: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  25 ++--
 tools/testing/selftests/mm/uffd-common.h     |   4 +-
 tools/testing/selftests/mm/uffd-stress.c     | 131 +------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 120 +++++++++++++++++
 4 files changed, 135 insertions(+), 145 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index bc6c5c38d6dd..12ac84712a38 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -13,8 +13,8 @@ volatile bool test_uffdio_copy_eexist = true;
 unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 int uffd = -1, uffd_flags, finished, *pipefd, test_type;
-bool map_shared, test_collapse, test_dev_userfaultfd;
-bool test_uffdio_wp = true, test_uffdio_minor = false;
+bool map_shared, test_dev_userfaultfd;
+bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 
@@ -128,15 +128,14 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 	char *p = NULL, *p_alias = NULL;
 	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
 
-	if (test_collapse) {
-		p = BASE_PMD_ADDR;
-		if (!is_src)
-			/* src map + alias + interleaved hpages */
-			p += 2 * (bytes + hpage_size);
-		p_alias = p;
-		p_alias += bytes;
-		p_alias += hpage_size;  /* Prevent src/dst VMA merge */
-	}
+	/* TODO: clean this up.  Use a static addr is ugly */
+	p = BASE_PMD_ADDR;
+	if (!is_src)
+		/* src map + alias + interleaved hpages */
+		p += 2 * (bytes + hpage_size);
+	p_alias = p;
+	p_alias += bytes;
+	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
 
 	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
 			   mem_fd, offset);
@@ -144,7 +143,7 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 		*alloc_area = NULL;
 		return -errno;
 	}
-	if (test_collapse && *alloc_area != p)
+	if (*alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
 	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
@@ -154,7 +153,7 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 		*alloc_area = NULL;
 		return -errno;
 	}
-	if (test_collapse && area_alias != p_alias)
+	if (area_alias != p_alias)
 		err("mmap of anonymous memory failed at %p", p_alias);
 
 	if (is_src)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 9479a0649d7f..4bd5915cf5b4 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -90,8 +90,8 @@ typedef struct uffd_test_ops uffd_test_ops_t;
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
-extern bool map_shared, test_collapse, test_dev_userfaultfd;
-extern bool test_uffdio_wp, test_uffdio_minor;
+extern bool map_shared, test_dev_userfaultfd;
+extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
 
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 61d025d87bf2..f9322bbaf825 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -52,8 +52,6 @@ pthread_attr_t attr;
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
-#define factor_of_2(x) ((x) ^ ((x) & ((x) - 1)))
-
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
@@ -79,8 +77,6 @@ static void usage(void)
 		"Supported mods:\n");
 	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
 	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
-	fprintf(stderr, "\tcollapse - Test MADV_COLLAPSE of UFFDIO_REGISTER_MODE_MINOR\n"
-		"memory\n");
 	fprintf(stderr, "\nExample test mod usage:\n");
 	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
 	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
@@ -584,92 +580,6 @@ static int userfaultfd_sig_test(void)
 	return userfaults != 0;
 }
 
-void check_memory_contents(char *p)
-{
-	unsigned long i;
-	uint8_t expected_byte;
-	void *expected_page;
-
-	if (posix_memalign(&expected_page, page_size, page_size))
-		err("out of memory");
-
-	for (i = 0; i < nr_pages; ++i) {
-		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
-		memset(expected_page, expected_byte, page_size);
-		if (my_bcmp(expected_page, p + (i * page_size), page_size))
-			err("unexpected page contents after minor fault");
-	}
-
-	free(expected_page);
-}
-
-static int userfaultfd_minor_test(void)
-{
-	unsigned long p;
-	pthread_t uffd_mon;
-	char c;
-	struct uffd_args args = { 0 };
-
-	if (!test_uffdio_minor)
-		return 0;
-
-	printf("testing minor faults: ");
-	fflush(stdout);
-
-	uffd_test_ctx_init(uffd_minor_feature());
-
-	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
-			  false, test_uffdio_wp, true))
-		err("register failure");
-
-	/*
-	 * After registering with UFFD, populate the non-UFFD-registered side of
-	 * the shared mapping. This should *not* trigger any UFFD minor faults.
-	 */
-	for (p = 0; p < nr_pages; ++p) {
-		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
-		       page_size);
-	}
-
-	args.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
-		err("uffd_poll_thread create");
-
-	/*
-	 * Read each of the pages back using the UFFD-registered mapping. We
-	 * expect that the first time we touch a page, it will result in a minor
-	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
-	 * page's contents, and then issuing a CONTINUE ioctl.
-	 */
-	check_memory_contents(area_dst_alias);
-
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
-		err("pipe write");
-	if (pthread_join(uffd_mon, NULL))
-		return 1;
-
-	uffd_stats_report(&args, 1);
-
-	if (test_collapse) {
-		printf("testing collapse of uffd memory into PMD-mapped THPs:");
-		if (madvise(area_dst_alias, nr_pages * page_size,
-			    MADV_COLLAPSE))
-			err("madvise(MADV_COLLAPSE)");
-
-		uffd_test_ops->check_pmd_mapping(area_dst,
-						 nr_pages * page_size /
-						 read_pmd_pagesize());
-		/*
-		 * This won't cause uffd-fault - it purely just makes sure there
-		 * was no corruption.
-		 */
-		check_memory_contents(area_dst_alias);
-		printf(" done.\n");
-	}
-
-	return args.missing_faults != 0 || args.minor_faults != nr_pages;
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -782,7 +692,7 @@ static int userfaultfd_stress(void)
 	}
 
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-		|| userfaultfd_events_test() || userfaultfd_minor_test();
+	    || userfaultfd_events_test();
 }
 
 static void set_test_type(const char *type)
@@ -797,13 +707,10 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-		/* Minor faults require shared hugetlb; only enable here. */
-		test_uffdio_minor = true;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
-		test_uffdio_minor = true;
 	}
 }
 
@@ -821,8 +728,6 @@ static void parse_test_type_arg(const char *raw_type)
 			test_dev_userfaultfd = true;
 		else if (!strcmp(token, "syscall"))
 			test_dev_userfaultfd = false;
-		else if (!strcmp(token, "collapse"))
-			test_collapse = true;
 		else
 			err("unrecognized test mod '%s'", token);
 	}
@@ -830,9 +735,6 @@ static void parse_test_type_arg(const char *raw_type)
 	if (!test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
 
-	if (test_collapse && test_type != TEST_SHMEM)
-		err("Unsupported test: %s", raw_type);
-
 	if (test_type == TEST_HUGETLB)
 		page_size = default_huge_page_size();
 	else
@@ -854,8 +756,6 @@ static void parse_test_type_arg(const char *raw_type)
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
-	test_uffdio_minor = test_uffdio_minor &&
-		(features & uffd_minor_feature());
 
 	close(uffd);
 	uffd = -1;
@@ -872,7 +772,6 @@ static void sigalrm(int sig)
 int main(int argc, char **argv)
 {
 	size_t bytes;
-	size_t hpage_size = read_pmd_pagesize();
 
 	if (argc < 4)
 		usage();
@@ -884,36 +783,8 @@ int main(int argc, char **argv)
 	parse_test_type_arg(argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
-	if (test_collapse && bytes & (hpage_size - 1))
-		err("MiB must be multiple of %lu if :collapse mod set",
-		    hpage_size >> 20);
-
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if (test_collapse) {
-		/* nr_cpus must divide (bytes / page_size), otherwise,
-		 * area allocations of (nr_pages * paze_size) won't be a
-		 * multiple of hpage_size, even if bytes is a multiple of
-		 * hpage_size.
-		 *
-		 * This means that nr_cpus must divide (N * (2 << (H-P))
-		 * where:
-		 *	bytes = hpage_size * N
-		 *	hpage_size = 2 << H
-		 *	page_size = 2 << P
-		 *
-		 * And we want to chose nr_cpus to be the largest value
-		 * satisfying this constraint, not larger than the number
-		 * of online CPUs. Unfortunately, prime factorization of
-		 * N and nr_cpus may be arbitrary, so have to search for it.
-		 * Instead, just use the highest power of 2 dividing both
-		 * nr_cpus and (bytes / page_size).
-		 */
-		int x = factor_of_2(nr_cpus);
-		int y = factor_of_2(bytes / page_size);
-
-		nr_cpus = x < y ? x : y;
-	}
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 4690c95a9420..cba04608bdb0 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -329,6 +329,103 @@ static void uffd_pagemap_test(void)
 	uffd_test_pass();
 }
 
+static void check_memory_contents(char *p)
+{
+	unsigned long i, j;
+	uint8_t expected_byte;
+
+	for (i = 0; i < nr_pages; ++i) {
+		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
+		for (j = 0; j < page_size; j++) {
+			uint8_t v = *(uint8_t *)(p + (i * page_size) + j);
+			if (v != expected_byte)
+				err("unexpected page contents");
+		}
+	}
+}
+
+static void uffd_minor_test_common(bool test_collapse, bool test_wp)
+{
+	unsigned long p;
+	pthread_t uffd_mon;
+	char c;
+	struct uffd_args args = { 0 };
+
+	/*
+	 * NOTE: MADV_COLLAPSE is not yet compatible with WP, so testing
+	 * both do not make much sense.
+	 */
+	assert(!(test_collapse && test_wp));
+
+	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
+			  /* NOTE! MADV_COLLAPSE may not work with uffd-wp */
+			  false, test_wp, true))
+		err("register failure");
+
+	/*
+	 * After registering with UFFD, populate the non-UFFD-registered side of
+	 * the shared mapping. This should *not* trigger any UFFD minor faults.
+	 */
+	for (p = 0; p < nr_pages; ++p)
+		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
+		       page_size);
+
+	args.apply_wp = test_wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a minor
+	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
+	 * page's contents, and then issuing a CONTINUE ioctl.
+	 */
+	check_memory_contents(area_dst_alias);
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (test_collapse) {
+		if (madvise(area_dst_alias, nr_pages * page_size,
+			    MADV_COLLAPSE)) {
+			/* It's fine to fail for this one... */
+			uffd_test_skip("MADV_COLLAPSE failed");
+			return;
+		}
+
+		uffd_test_ops->check_pmd_mapping(area_dst,
+						 nr_pages * page_size /
+						 read_pmd_pagesize());
+		/*
+		 * This won't cause uffd-fault - it purely just makes sure there
+		 * was no corruption.
+		 */
+		check_memory_contents(area_dst_alias);
+	}
+
+	if (args.missing_faults != 0 || args.minor_faults != nr_pages)
+		uffd_test_fail("stats check error");
+	else
+		uffd_test_pass();
+}
+
+void uffd_minor_test(void)
+{
+	uffd_minor_test_common(false, false);
+}
+
+void uffd_minor_wp_test(void)
+{
+	uffd_minor_test_common(false, true);
+}
+
+void uffd_minor_collapse_test(void)
+{
+	uffd_minor_test_common(true, false);
+}
+
 uffd_test_case_t uffd_tests[] = {
 	{
 		.name = "pagemap",
@@ -343,6 +440,29 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_feature_required =
 		UFFD_FEATURE_PAGEFAULT_FLAG_WP | UFFD_FEATURE_WP_UNPOPULATED,
 	},
+	{
+		.name = "minor",
+		.uffd_fn = uffd_minor_test,
+		.mem_targets = MEM_SHMEM | MEM_HUGETLB,
+		.uffd_feature_required =
+		UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM,
+	},
+	{
+		.name = "minor-wp",
+		.uffd_fn = uffd_minor_wp_test,
+		.mem_targets = MEM_SHMEM | MEM_HUGETLB,
+		.uffd_feature_required =
+		UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+	},
+	{
+		.name = "minor-collapse",
+		.uffd_fn = uffd_minor_collapse_test,
+		/* MADV_COLLAPSE only works with shmem */
+		.mem_targets = MEM_SHMEM,
+		/* We can't test MADV_COLLAPSE, so try our luck */
+		.uffd_feature_required = UFFD_FEATURE_MINOR_SHMEM,
+	},
 };
 
 int main(int argc, char *argv[])
-- 
2.39.1

