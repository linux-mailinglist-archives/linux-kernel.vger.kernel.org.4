Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5A6DFBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDLQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDLQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D2476BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPLVHwmG1JWLQdfe+bC3h4cMLKGLNsksPTamWwKRdSQ=;
        b=dNT4CWuiA6H3ozax1FAsMBK9WjVyGJmXQqZpwJ2InYTlZawhEvQMgSR1bc3/OOvXPUu7Ge
        j6ZTIuEjURQXvU8uoXQgxLlqo2KU0fyC0AD3CBWDvjorvtqmwpbZCxt47Q4YLKL1zkdaSF
        9qAMN0vZ7qUsvNLMUA/rrC49hDRvitI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-6G2BJ_UhMdSjBeRnqSCfJw-1; Wed, 12 Apr 2023 12:43:58 -0400
X-MC-Unique: 6G2BJ_UhMdSjBeRnqSCfJw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74a9035256eso54274185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317837; x=1683909837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPLVHwmG1JWLQdfe+bC3h4cMLKGLNsksPTamWwKRdSQ=;
        b=GuSN9lWTA/OZ6z5t75NxSdZbgKowRaVA+UTNEJj/4k5fUi3HNI42UC7FsjDV8v6cIY
         0UD3zb3SXj9ZOeU94SSNgF7VfPPaSjH6EZJzQ3asP8+1+hCssg83yZOaVbFkIWN5fOOe
         v59LlVai/6AxFd4yO7QfMk9n8NXlcYyo/x5BHP10XAfzyjp9g7/2QwNAbad3kmglysAQ
         hAXNvVozpwqk68/heqln6rBj7fMrx0t4vw1a5yimIpKdDQHiA6oAWWQmxN8+5fA74K5H
         5WX2EV4/B2keJi4iNS5nZbN2U47mEkpPyYw5Z9xkU98rYmglzFFgHipHoEjgz32xmMxf
         Ybiw==
X-Gm-Message-State: AAQBX9cfyOLe8JQDWaRpJAFxgGKzagrdHCs+TKLAntigTXrdRaImjB6e
        0mimJwvE9krlB+c/Vm9SADdHQRp04/7nD+QvuW1oTqy7To1rxfGT189wD8QL13agVl74SyqSDj0
        a4unqimVDAps4oRhsnIH0WFFGLfD7b0yBSi+qMv1CDmF3jgoG64GE6qF3EcSpqQvhoMBZxFHdVH
        YtZP5ZZg==
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr5019847qta.0.1681317837120;
        Wed, 12 Apr 2023 09:43:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZbuxgmUhLJPUZsc/XbkJJrLLicXSsAvTA4gBiNZfg/X0rald8nfCHkMiAjHNJAZFk97T+JTQ==
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr5019794qta.0.1681317836679;
        Wed, 12 Apr 2023 09:43:56 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a141700b00746803d7e8dsm4760743qkj.113.2023.04.12.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:55 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 23/31] selftests/mm: Move uffd pagemap test to unit test
Date:   Wed, 12 Apr 2023 12:43:52 -0400
Message-Id: <20230412164352.328733-1-peterx@redhat.com>
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

Move it over and make it split into two tests, one for pagemap and one for
the new WP_UNPOPULATED (to be a separate one).

The thp pagemap test wasn't really working (with MADV_HUGEPAGE).  Let's
just drop it (since it never really worked anyway..) and leave that for
later.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 166 -------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 145 ++++++++++++++++
 2 files changed, 145 insertions(+), 166 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 747d588c0d69..61d025d87bf2 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -670,157 +670,6 @@ static int userfaultfd_minor_test(void)
 	return args.missing_faults != 0 || args.minor_faults != nr_pages;
 }
 
-static int pagemap_open(void)
-{
-	int fd = open("/proc/self/pagemap", O_RDONLY);
-
-	if (fd < 0)
-		err("open pagemap");
-
-	return fd;
-}
-
-/* This macro let __LINE__ works in err() */
-#define  pagemap_check_wp(value, wp) do {				\
-		if (!!(value & PM_UFFD_WP) != wp)			\
-			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
-	} while (0)
-
-static int pagemap_test_fork(bool present)
-{
-	pid_t child = fork();
-	uint64_t value;
-	int fd, result;
-
-	if (!child) {
-		/* Open the pagemap fd of the child itself */
-		fd = pagemap_open();
-		value = pagemap_get_entry(fd, area_dst);
-		/*
-		 * After fork() uffd-wp bit should be gone as long as we're
-		 * without UFFD_FEATURE_EVENT_FORK
-		 */
-		pagemap_check_wp(value, false);
-		/* Succeed */
-		exit(0);
-	}
-	waitpid(child, &result, 0);
-	return result;
-}
-
-static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
-{
-	uint64_t value;
-
-	/* Test applying pte marker to anon unpopulated */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, true);
-
-	/* Test unprotect on anon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, false);
-
-	/* Test zap on anon marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
-		err("madvise(MADV_DONTNEED) failed");
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, false);
-
-	/* Test fault in after marker removed */
-	*area_dst = 1;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, false);
-	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
-		err("madvise(MADV_DONTNEED) failed");
-
-	/* Test read-zero-page upon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	*(volatile char *)area_dst;
-	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
-		err("madvise(MADV_DONTNEED) failed");
-}
-
-static void userfaultfd_pagemap_test(unsigned int test_pgsize)
-{
-	int pagemap_fd;
-	uint64_t value;
-
-	/* Pagemap tests uffd-wp only */
-	if (!test_uffdio_wp)
-		return;
-
-	/* Not enough memory to test this page size */
-	if (test_pgsize > nr_pages * page_size)
-		return;
-
-	printf("testing uffd-wp with pagemap (pgsize=%u): ", test_pgsize);
-	/* Flush so it doesn't flush twice in parent/child later */
-	fflush(stdout);
-
-	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
-
-	if (test_pgsize > page_size) {
-		/* This is a thp test */
-		if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
-			err("madvise(MADV_HUGEPAGE) failed");
-	} else if (test_pgsize == page_size) {
-		/* This is normal page test; force no thp */
-		if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
-			err("madvise(MADV_NOHUGEPAGE) failed");
-	}
-
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
-			  false, true, false))
-		err("register failed");
-
-	pagemap_fd = pagemap_open();
-
-	/* Smoke test WP_UNPOPULATED first when it's still empty */
-	if (test_pgsize == page_size)
-		userfaultfd_wp_unpopulated_test(pagemap_fd);
-
-	/* Touch the page */
-	*area_dst = 1;
-	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, true);
-	/* Make sure uffd-wp bit dropped when fork */
-	if (pagemap_test_fork(true))
-		err("Detected stall uffd-wp bit in child");
-
-	/* Exclusive required or PAGEOUT won't work */
-	if (!(value & PM_MMAP_EXCLUSIVE))
-		err("multiple mapping detected: 0x%"PRIx64, value);
-
-	if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
-		err("madvise(MADV_PAGEOUT) failed");
-
-	/* Uffd-wp should persist even swapped out */
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, true);
-	/* Make sure uffd-wp bit dropped when fork */
-	if (pagemap_test_fork(false))
-		err("Detected stall uffd-wp bit in child");
-
-	/* Unprotect; this tests swap pte modifications */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, false);
-
-	/* Fault in the page from disk */
-	*area_dst = 2;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
-	pagemap_check_wp(value, false);
-
-	close(pagemap_fd);
-	printf("done\n");
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -932,21 +781,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(args, nr_cpus);
 	}
 
-	if (test_type == TEST_ANON) {
-		/*
-		 * shmem/hugetlb won't be able to run since they have different
-		 * behavior on fork() (file-backed memory normally drops ptes
-		 * directly when fork), meanwhile the pagemap test will verify
-		 * pgtable entry of fork()ed child.
-		 */
-		userfaultfd_pagemap_test(page_size);
-		/*
-		 * Hard-code for x86_64 for now for 2M THP, as x86_64 is
-		 * currently the only one that supports uffd-wp
-		 */
-		userfaultfd_pagemap_test(page_size * 512);
-	}
-
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 936b24a6f468..4690c95a9420 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -197,7 +197,152 @@ static bool uffd_feature_supported(uffd_test_case_t *test)
 	    test->uffd_feature_required;
 }
 
+static int pagemap_open(void)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+
+	if (fd < 0)
+		err("open pagemap");
+
+	return fd;
+}
+
+/* This macro let __LINE__ works in err() */
+#define  pagemap_check_wp(value, wp) do {				\
+		if (!!(value & PM_UFFD_WP) != wp)			\
+			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
+	} while (0)
+
+static int pagemap_test_fork(bool present)
+{
+	pid_t child = fork();
+	uint64_t value;
+	int fd, result;
+
+	if (!child) {
+		/* Open the pagemap fd of the child itself */
+		fd = pagemap_open();
+		value = pagemap_get_entry(fd, area_dst);
+		/*
+		 * After fork() uffd-wp bit should be gone as long as we're
+		 * without UFFD_FEATURE_EVENT_FORK
+		 */
+		pagemap_check_wp(value, false);
+		/* Succeed */
+		exit(0);
+	}
+	waitpid(child, &result, 0);
+	return result;
+}
+
+static void uffd_wp_unpopulated_test(void)
+{
+	uint64_t value;
+	int pagemap_fd;
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  false, true, false))
+		err("register failed");
+
+	pagemap_fd = pagemap_open();
+
+	/* Test applying pte marker to anon unpopulated */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+
+	/* Test unprotect on anon pte marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, false);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Test zap on anon marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Test fault in after marker removed */
+	*area_dst = 1;
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+	/* Drop it to make pte none again */
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+
+	/* Test read-zero-page upon pte marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	*(volatile char *)area_dst;
+	/* Drop it to make pte none again */
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+
+	uffd_test_pass();
+}
+
+static void uffd_pagemap_test(void)
+{
+	int pagemap_fd;
+	uint64_t value;
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  false, true, false))
+		err("register failed");
+
+	pagemap_fd = pagemap_open();
+
+	/* Touch the page */
+	*area_dst = 1;
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+	/* Make sure uffd-wp bit dropped when fork */
+	if (pagemap_test_fork(true))
+		err("Detected stall uffd-wp bit in child");
+
+	/* Exclusive required or PAGEOUT won't work */
+	if (!(value & PM_MMAP_EXCLUSIVE))
+		err("multiple mapping detected: 0x%"PRIx64, value);
+
+	if (madvise(area_dst, page_size, MADV_PAGEOUT))
+		err("madvise(MADV_PAGEOUT) failed");
+
+	/* Uffd-wp should persist even swapped out */
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+	/* Make sure uffd-wp bit dropped when fork */
+	if (pagemap_test_fork(false))
+		err("Detected stall uffd-wp bit in child");
+
+	/* Unprotect; this tests swap pte modifications */
+	wp_range(uffd, (uint64_t)area_dst, page_size, false);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Fault in the page from disk */
+	*area_dst = 2;
+	value = pagemap_get_entry(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	close(pagemap_fd);
+	uffd_test_pass();
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		.name = "pagemap",
+		.uffd_fn = uffd_pagemap_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+	},
+	{
+		.name = "wp-unpopulated",
+		.uffd_fn = uffd_wp_unpopulated_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required =
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP | UFFD_FEATURE_WP_UNPOPULATED,
+	},
 };
 
 int main(int argc, char *argv[])
-- 
2.39.1

