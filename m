Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D56D0ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC3QKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjC3QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE24C667
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYl/6yS5UtVMnAaCmSItplLGUyy4Ed+8ZQVGZ0RDCPU=;
        b=PAc39p/OUbtamE99OvPV62MzJZarmCjJT6ecbtGbTnP2IfQVWv5nNXM9hzdV+mcqiITihN
        W6nc5fYqWS90ID7JDc4oxjeLGWcgN4BPVHpExheM9yDjHElDOD/dhMjLtPQDMuJCxhn8WU
        IRdc20iGIAlIuVECwuUQ0sbW3+qgRyg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-7JwnABFAP66jIQyhbBXMWQ-1; Thu, 30 Mar 2023 12:08:28 -0400
X-MC-Unique: 7JwnABFAP66jIQyhbBXMWQ-1
Received: by mail-qv1-f72.google.com with SMTP id y19-20020ad445b3000000b005a5123cb627so8420451qvu.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192508; x=1682784508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYl/6yS5UtVMnAaCmSItplLGUyy4Ed+8ZQVGZ0RDCPU=;
        b=UF2HwBC0cexUTBfWj0zm4UmxfPBMpgNq/HQow85ZwEdju3hEMzYoDWYwnQIX4+EyNg
         OoUqS2EIpJ8sMi4xFKc+mHns4A1OHKBdxbkgucF8t1JQPeBlf3cYLKWIoan9lMCDt7BP
         2XkuKxR7uv/QTQd/9/OmqguQncxhumrrMptcXb0sN9hIrOiuMsPiQ0bpA4E4tL64UMvf
         xU/LEO1LCsN399dXTyqddHmAbUsD103YzFgBkYypeXPd6HW35n5nxxx1g7j5zIrSG5ae
         nFaJL6dNfwtNSs5Tu6zbodUOJXH4V3LND+UdX5dXkTWHH7id7y2S5iE3TuVhH47Hl7li
         AM7A==
X-Gm-Message-State: AAQBX9erkwZvkVU+7LKhS5fg5QPUtADij7vboq/px7SbnXyPNhocb1WX
        hcOtFqKxu/ovQAHlp79urUVxEdkiwi+petKOh3LoLB+hAcKwwDDGqxwzAJ/xlGT5eOMMHalpci2
        m3x3A5mr5jUlAfGvgX1utmSHtDycQODZXJg8i+IPYsp2HGxxS/FVR0LM8Qyd6JBuihsIbZaF8Zc
        JqzfPOFg==
X-Received: by 2002:a05:6214:300f:b0:5da:b965:1efd with SMTP id ke15-20020a056214300f00b005dab9651efdmr36932473qvb.2.1680192507646;
        Thu, 30 Mar 2023 09:08:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350bzvSc/AqAbP4HYGGuB2Ff0cVAuMuN0w5MB74cxWKB4kqee51E4nrpLgVuoA/lFvXDiP0RqlQ==
X-Received: by 2002:a05:6214:300f:b0:5da:b965:1efd with SMTP id ke15-20020a056214300f00b005dab9651efdmr36932407qvb.2.1680192507098;
        Thu, 30 Mar 2023 09:08:27 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r6-20020a0cf806000000b005dd8b93457asm5582943qvn.18.2023.03.30.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: [PATCH 23/29] selftests/mm: Move uffd minor test to unit test
Date:   Thu, 30 Mar 2023 12:08:24 -0400
Message-Id: <20230330160824.3107569-1-peterx@redhat.com>
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
index ae6b61144b53..95ad619d0df4 100644
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
 
@@ -126,28 +126,27 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
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
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
-	if (test_collapse && *alloc_area != p)
+	if (*alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
 	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
 			  mem_fd, offset);
 	if (area_alias == MAP_FAILED)
 		err("mmap of memfd alias failed");
-	if (test_collapse && area_alias != p_alias)
+	if (area_alias != p_alias)
 		err("mmap of anonymous memory failed at %p", p_alias);
 
 	if (is_src)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 51ec75f6d0c1..16d32ddf8412 100644
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
index 50738a993afc..49fa61e5c54a 100644
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
@@ -585,92 +581,6 @@ static int userfaultfd_sig_test(void)
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
-	struct uffd_stats stats = { 0 };
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
-	stats.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
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
-	uffd_stats_report(&stats, 1);
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
-	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -783,7 +693,7 @@ static int userfaultfd_stress(void)
 	}
 
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-		|| userfaultfd_events_test() || userfaultfd_minor_test();
+	    || userfaultfd_events_test();
 }
 
 static void set_test_type(const char *type)
@@ -798,13 +708,10 @@ static void set_test_type(const char *type)
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
 
@@ -822,8 +729,6 @@ static void parse_test_type_arg(const char *raw_type)
 			test_dev_userfaultfd = true;
 		else if (!strcmp(token, "syscall"))
 			test_dev_userfaultfd = false;
-		else if (!strcmp(token, "collapse"))
-			test_collapse = true;
 		else
 			err("unrecognized test mod '%s'", token);
 	}
@@ -831,9 +736,6 @@ static void parse_test_type_arg(const char *raw_type)
 	if (!test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
 
-	if (test_collapse && test_type != TEST_SHMEM)
-		err("Unsupported test: %s", raw_type);
-
 	if (test_type == TEST_HUGETLB)
 		page_size = default_huge_page_size();
 	else
@@ -855,8 +757,6 @@ static void parse_test_type_arg(const char *raw_type)
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
-	test_uffdio_minor = test_uffdio_minor &&
-		(features & uffd_minor_feature());
 
 	close(uffd);
 	uffd = -1;
@@ -873,7 +773,6 @@ static void sigalrm(int sig)
 int main(int argc, char **argv)
 {
 	size_t bytes;
-	size_t hpage_size = read_pmd_pagesize();
 
 	if (argc < 4)
 		usage();
@@ -885,36 +784,8 @@ int main(int argc, char **argv)
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
index bcd67bd4ec90..ecb8ba658736 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -332,6 +332,103 @@ static void uffd_pagemap_test(void)
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
+	struct uffd_stats stats = { 0 };
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
+	stats.apply_wp = test_wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &stats))
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
+	if (stats.missing_faults != 0 || stats.minor_faults != nr_pages)
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
@@ -346,6 +443,29 @@ uffd_test_case_t uffd_tests[] = {
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

