Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700426D0ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjC3QOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjC3QOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8DCA38
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLgapT9bBZ+99GDEmTuONCJOEOezrqQqmgr0JZLPIac=;
        b=a0sId/HVntJvqmvj1xhIsStpL06UAbDLLaheLvHi9JUyjCpZEccDGWitB5xPifoKF+iDKY
        lO8PKxRb4VNw/RHyZJ1F5881xB060JCvV7XwtKByKTPS5lYdrMsVs46nUWLyahoVbONeqr
        K+oiirO5QmM+bygspWAiIz0tqODO1Mo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--dOnVvYINDaGzQOlJNFGIQ-1; Thu, 30 Mar 2023 12:08:25 -0400
X-MC-Unique: -dOnVvYINDaGzQOlJNFGIQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5aae34d87f7so13017296d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLgapT9bBZ+99GDEmTuONCJOEOezrqQqmgr0JZLPIac=;
        b=rxwLcWXDrpZR0sZSqYsivGhshIiFBM5QU2sIKfZ5aOb5bexBhpAa0gjY8ucMOATU5D
         OL535sXkhSVRIUfcPwf49K1BKVzKARzM7gq09iawOrs0KK/d503NWiVYr81d85Px9V17
         9lPVrF9wYT9Wzx/l4AW06m98bGWwN6apVRyYpx2Otp1j/IPBUJ5uMF+qcgldq2LuTEt6
         VmrdaDAn09d7UOl8S7AKpgsBfKvtcsU7OWAwFQyMrjE4C5LY9/VsjRormf4x/K9RN8zY
         GOCl+REweYb0p/ABbLCKutX7RhN5R0n0pZ3JinrjLxaO6qjnSrhHLHz0FO0giqZYWvdq
         jYLA==
X-Gm-Message-State: AAQBX9d3UJH7Gzymisyoc4ok7DFXgPwvcMb9LwHRzEROkeuxR5do2Q5u
        mEp50bmC8e9B/rzNucOb70jZO7lCaeXr5k4XsvcNheba+y21w5frYSYX8csDTSw2p3B8Y/6bLzl
        UB22HVSWl5Weq1M/F7bR9vcrcRZdXmQUri3zQu12QcZuRXHI3AxfgakD6t1DEhhzxqPKSulpTQU
        P4g4qV4w==
X-Received: by 2002:a05:6214:4007:b0:5da:b965:1efe with SMTP id kd7-20020a056214400700b005dab9651efemr3648524qvb.4.1680192504348;
        Thu, 30 Mar 2023 09:08:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350aH6oyf0Up2gN8U0vpoWNDr4p8tT9aXJ3/orA+qv3unlxlWSXFhXjQOmrmgGPnvNrKYnAuuAA==
X-Received: by 2002:a05:6214:4007:b0:5da:b965:1efe with SMTP id kd7-20020a056214400700b005dab9651efemr3648464qvb.4.1680192503778;
        Thu, 30 Mar 2023 09:08:23 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id on15-20020a056214448f00b005dd8b9345bbsm357979qvb.83.2023.03.30.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 22/29] selftests/mm: Move uffd pagemap test to unit test
Date:   Thu, 30 Mar 2023 12:08:21 -0400
Message-Id: <20230330160821.3107558-1-peterx@redhat.com>
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

Move it over and make it split into two tests, one for pagemap and one for
the new WP_UNPOPULATED (to be a separate one).

The thp pagemap test wasn't really working (with MADV_HUGEPAGE).  Let's
just drop it (since it never really worked anyway..) and leave that for
later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 166 -------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 145 ++++++++++++++++
 2 files changed, 145 insertions(+), 166 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 70cb0619354e..50738a993afc 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -671,157 +671,6 @@ static int userfaultfd_minor_test(void)
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
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
@@ -933,21 +782,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
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
index 007145063363..bcd67bd4ec90 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -200,7 +200,152 @@ static bool uffd_feature_supported(uffd_test_case_t *test)
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

