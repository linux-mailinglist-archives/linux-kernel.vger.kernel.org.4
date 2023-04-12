Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178376DFB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDLQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjDLQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7E1BF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojqw0o6nNzx2NLPCFuTH85mteh7O3LjoH7u5kZisRAA=;
        b=GxRNL4CcwHXwv2ZETHCxUDDCJdDWXkwWRJsQWrxrprWEhbeKQ7EretlkgTtoOc/7fmwFjT
        PLjLhIWwMmdg9EkVH4//AzR/QofIZR7ONXW90fiV0NaNwtf6dYqMxp2owcXeqlKP7Hf0Ey
        sftNd8Q1VhA9v63++KcCHdmwo8XCTVU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-HcfIVNBlMD2-NAIRxPa4Jw-1; Wed, 12 Apr 2023 12:42:56 -0400
X-MC-Unique: HcfIVNBlMD2-NAIRxPa4Jw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74a65b255beso53906485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317775; x=1683909775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojqw0o6nNzx2NLPCFuTH85mteh7O3LjoH7u5kZisRAA=;
        b=gYV1+JT912n/7BAdn4R+H3cZuT0DIhIFp7bqgf2YdY3Mcwn0buc5xdRa4yuNUqrtR3
         Ls9+GwjmmRw9zqoVfyykBnxipAgAwGyZTRQI4Ma+zbnjMYloZmRJOnieBcFuYLubFKXT
         rjLWPQn2K+MD/xndMuATjqpzCIp2M3FdbV3Tj+UD+qA19aNYx7F6zsfzlMGXoJIlzH+m
         b/IA6sgxOyOV8lm12rZHDgJ7mXpEsuotPWmPQpOtSROt16PnRM/yPgy0RMsTxe355awS
         PlL51xnVGTgdvPlFfgQVn1t6P9BNMM83PKijY0V/zOwZljvps7dlFd0sGZafAJ+gLNYz
         EYnQ==
X-Gm-Message-State: AAQBX9fC0ufNZI2YGsd2Ivt9B5mWZxz/+3YENnSMXAPsUvj3aCzDFqJM
        HFdiHqdVRSo/xtn57uzM+LMtZ3BUniZqw2156Y5yarVexQ2nVDJMccuiJj1tpPnSFlroZtwnoNY
        IfR59tcNXXIu+ZAqAD56geWcHDapjr2JxTp/VqiIJX/bvAed1jq39AjZSjpPUrNSjxaOmAtIAAk
        cDwqQWZw==
X-Received: by 2002:a05:6214:529e:b0:532:141d:3750 with SMTP id kj30-20020a056214529e00b00532141d3750mr4507661qvb.2.1681317774623;
        Wed, 12 Apr 2023 09:42:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZiNYvtLNaUrZK97U0yXiPXuXJq4154VRxXp1Kfb8XAq8hOWTf5d/hKo1brcX+fmf478dwLA==
X-Received: by 2002:a05:6214:529e:b0:532:141d:3750 with SMTP id kj30-20020a056214529e00b00532141d3750mr4507612qvb.2.1681317774057;
        Wed, 12 Apr 2023 09:42:54 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id l11-20020ac84a8b000000b003e89e2b3c23sm410577qtq.58.2023.04.12.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com
Subject: [PATCH v2 14/31] selftests/mm: uffd_[un]register()
Date:   Wed, 12 Apr 2023 12:42:47 -0400
Message-Id: <20230412164247.328293-1-peterx@redhat.com>
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

Add two helpers to register/unregister to an uffd.  Use them to drop
duplicate codes.

This patch also drops assert_expected_ioctls_present() and
get_expected_ioctls().  Reasons:

  - It'll need a lot of effort to pass test_type==HUGETLB into it from the
  upper, so it's the simplest way to get rid of another global var

  - The ioctls returned in UFFDIO_REGISTER is hardly useful at all, because
  any app can already detect kernel support on any ioctl via its
  corresponding UFFD_FEATURE_*.  The check here is for sanity mostly but
  it's probably destined no user app will even use it.

  - It's not friendly to one future goal of uffd to run on old kernels, the
  problem is get_expected_ioctls() compiles against UFFD_API_RANGE_IOCTLS,
  which is a value that can change depending on where the test is compiled,
  rather than reflecting what the kernel underneath has.  It means it'll
  report false negatives on old kernels so it's against our will.

So let's make our live easier.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c  |  7 +-
 .../selftests/mm/ksm_functional_tests.c       |  6 +-
 tools/testing/selftests/mm/uffd-common.c      | 27 ------
 tools/testing/selftests/mm/uffd-common.h      |  2 -
 tools/testing/selftests/mm/uffd-stress.c      | 83 +++++--------------
 tools/testing/selftests/mm/vm_util.c          | 37 +++++++++
 tools/testing/selftests/mm/vm_util.h          |  4 +
 7 files changed, 62 insertions(+), 104 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index e53b5eaa8fce..2084692fe1c4 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -60,7 +60,6 @@ static void register_region_with_uffd(char *addr, size_t len)
 {
 	long uffd; /* userfaultfd file descriptor */
 	struct uffdio_api uffdio_api;
-	struct uffdio_register uffdio_register;
 
 	/* Create and enable userfaultfd object. */
 
@@ -96,11 +95,7 @@ static void register_region_with_uffd(char *addr, size_t len)
 	 * handling by the userfaultfd object. In mode, we request to track
 	 * missing pages (i.e., pages that have not yet been faulted in).
 	 */
-
-	uffdio_register.range.start = (unsigned long)addr;
-	uffdio_register.range.len = len;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+	if (uffd_register(uffd, addr, len, true, false, false)) {
 		perror("ioctl-UFFDIO_REGISTER");
 		exit(1);
 	}
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d8b5b4930412..d3f26050dfd7 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -178,7 +178,6 @@ static void test_unmerge_discarded(void)
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
-	struct uffdio_register uffdio_register;
 	const unsigned int size = 2 * MiB;
 	struct uffdio_api uffdio_api;
 	char *map;
@@ -210,10 +209,7 @@ static void test_unmerge_uffd_wp(void)
 	}
 
 	/* Register UFFD-WP, no need for an actual handler. */
-	uffdio_register.range.start = (unsigned long) map;
-	uffdio_register.range.len = size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
+	if (uffd_register(uffd, map, size, false, true, false)) {
 		ksft_test_result_fail("UFFDIO_REGISTER_MODE_WP failed\n");
 		goto close_uffd;
 	}
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index c57757c2a36f..daa5b5781e7a 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -330,33 +330,6 @@ void uffd_test_ctx_init(uint64_t features)
 			err("pipe");
 }
 
-uint64_t get_expected_ioctls(uint64_t mode)
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
-void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
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
 void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 {
 	struct uffdio_writeprotect prms;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index d9430cfdcb19..11f770391bd9 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -101,8 +101,6 @@ extern uffd_test_ops_t *uffd_test_ops;
 void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
 void uffd_test_ctx_init(uint64_t features);
 void userfaultfd_open(uint64_t *features);
-uint64_t get_expected_ioctls(uint64_t mode);
-void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index c68a9aeefc41..e6d39a755082 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -463,28 +463,19 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 /* exercise UFFDIO_ZEROPAGE */
 static int userfaultfd_zeropage_test(void)
 {
-	struct uffdio_register uffdio_register;
-
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
 	uffd_test_ctx_init(0);
 
-	uffdio_register.range.start = (unsigned long) area_dst;
-	uffdio_register.range.len = nr_pages * page_size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
-		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	assert_expected_ioctls_present(
-		uffdio_register.mode, uffdio_register.ioctls);
-
 	if (area_dst_alias) {
 		/* Needed this to test zeropage-retry on shared memory */
-		uffdio_register.range.start = (unsigned long) area_dst_alias;
-		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
+				  true, test_uffdio_wp, false))
 			err("register failure");
 	}
 
@@ -498,7 +489,6 @@ static int userfaultfd_zeropage_test(void)
 
 static int userfaultfd_events_test(void)
 {
-	struct uffdio_register uffdio_register;
 	pthread_t uffd_mon;
 	int err, features;
 	pid_t pid;
@@ -514,17 +504,10 @@ static int userfaultfd_events_test(void)
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
-	uffdio_register.range.start = (unsigned long) area_dst;
-	uffdio_register.range.len = nr_pages * page_size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
-		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	assert_expected_ioctls_present(
-		uffdio_register.mode, uffdio_register.ioctls);
-
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
 
@@ -550,7 +533,6 @@ static int userfaultfd_events_test(void)
 
 static int userfaultfd_sig_test(void)
 {
-	struct uffdio_register uffdio_register;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -566,17 +548,10 @@ static int userfaultfd_sig_test(void)
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
-	uffdio_register.range.start = (unsigned long) area_dst;
-	uffdio_register.range.len = nr_pages * page_size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
-		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	assert_expected_ioctls_present(
-		uffdio_register.mode, uffdio_register.ioctls);
-
 	if (faulting_process(1))
 		err("faulting process failed");
 
@@ -629,7 +604,6 @@ void check_memory_contents(char *p)
 static int userfaultfd_minor_test(void)
 {
 	unsigned long p;
-	struct uffdio_register uffdio_register;
 	pthread_t uffd_mon;
 	char c;
 	struct uffd_stats stats = { 0 };
@@ -642,17 +616,10 @@ static int userfaultfd_minor_test(void)
 
 	uffd_test_ctx_init(uffd_minor_feature());
 
-	uffdio_register.range.start = (unsigned long)area_dst_alias;
-	uffdio_register.range.len = nr_pages * page_size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
-	if (test_uffdio_wp)
-		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
+			  false, test_uffdio_wp, true))
 		err("register failure");
 
-	assert_expected_ioctls_present(
-		uffdio_register.mode, uffdio_register.ioctls);
-
 	/*
 	 * After registering with UFFD, populate the non-UFFD-registered side of
 	 * the shared mapping. This should *not* trigger any UFFD minor faults.
@@ -777,7 +744,6 @@ static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
 
 static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 {
-	struct uffdio_register uffdio_register;
 	int pagemap_fd;
 	uint64_t value;
 
@@ -805,10 +771,8 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 			err("madvise(MADV_NOHUGEPAGE) failed");
 	}
 
-	uffdio_register.range.start = (unsigned long) area_dst;
-	uffdio_register.range.len = nr_pages * page_size;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
@@ -858,8 +822,8 @@ static int userfaultfd_stress(void)
 {
 	void *area;
 	unsigned long nr;
-	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
+	uint64_t mem_size = nr_pages * page_size;
 
 	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
 
@@ -894,20 +858,13 @@ static int userfaultfd_stress(void)
 			fcntl(uffd, F_SETFL, uffd_flags & ~O_NONBLOCK);
 
 		/* register */
-		uffdio_register.range.start = (unsigned long) area_dst;
-		uffdio_register.range.len = nr_pages * page_size;
-		uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-		if (test_uffdio_wp)
-			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		if (uffd_register(uffd, area_dst, mem_size,
+				  true, test_uffdio_wp, false))
 			err("register failure");
-		assert_expected_ioctls_present(
-			uffdio_register.mode, uffdio_register.ioctls);
 
 		if (area_dst_alias) {
-			uffdio_register.range.start = (unsigned long)
-				area_dst_alias;
-			if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+			if (uffd_register(uffd, area_dst_alias, mem_size,
+					  true, test_uffdio_wp, false))
 				err("register failure alias");
 		}
 
@@ -949,12 +906,10 @@ static int userfaultfd_stress(void)
 				 nr_pages * page_size, false);
 
 		/* unregister */
-		if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range))
+		if (uffd_unregister(uffd, area_dst, mem_size))
 			err("unregister failure");
 		if (area_dst_alias) {
-			uffdio_register.range.start = (unsigned long) area_dst;
-			if (ioctl(uffd, UFFDIO_UNREGISTER,
-				  &uffdio_register.range))
+			if (uffd_unregister(uffd, area_dst_alias, mem_size))
 				err("unregister failure alias");
 		}
 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 54d227d6f70a..bb633d050d71 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
 #include "../kselftest.h"
 #include "vm_util.h"
 
@@ -193,3 +195,38 @@ unsigned long default_huge_page_size(void)
 	fclose(f);
 	return hps;
 }
+
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor)
+{
+	struct uffdio_register uffdio_register = { 0 };
+	uint64_t mode = 0;
+	int ret = 0;
+
+	if (miss)
+		mode |= UFFDIO_REGISTER_MODE_MISSING;
+	if (wp)
+		mode |= UFFDIO_REGISTER_MODE_WP;
+	if (minor)
+		mode |= UFFDIO_REGISTER_MODE_MINOR;
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = mode;
+
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		ret = -errno;
+
+	return ret;
+}
+
+int uffd_unregister(int uffd, void *addr, uint64_t len)
+{
+	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
+	int ret = 0;
+
+	if (ioctl(uffd, UFFDIO_UNREGISTER, &range) == -1)
+		ret = -errno;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index d9fadddb5c69..3a9762022efd 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -45,6 +45,10 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor);
+int uffd_unregister(int uffd, void *addr, uint64_t len);
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.39.1

