Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70846E17F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjDMXNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDMXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEEA19AD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U50mzc3x7opcua/Zq5xIU5DytHBPjAF3IuThARnv+MM=;
        b=ZCitj2OxvSxTiK53ie/rCtYueeBNF+T4eJaCpu1Qd1x3w94OlGkZp1z4JwpytoesD2z7Sn
        7OgBzXrSXQo0ebbkBAjXpaF48lSvEUmcDoV/J4YByVkpuQpgIPANQOY7JIhCq0WO9udDpW
        qwzWj03kX6OtVY2oRP01gtFLmFeXsak=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-B-Fx5p2GNFGh9UPmRZIy7Q-1; Thu, 13 Apr 2023 19:12:12 -0400
X-MC-Unique: B-Fx5p2GNFGh9UPmRZIy7Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3eab4df3ef0so823811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427532; x=1684019532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U50mzc3x7opcua/Zq5xIU5DytHBPjAF3IuThARnv+MM=;
        b=NUqRgQJplkdKYiLi+dP1Rgn7rcRswOi9ovV2NfHFgLssL/1ZM5NOQgZcaaIPkYK1ZA
         kpxXFWdpetCbJDl4mpjsyZM+J8l2huLHhP5xWpXOdKc+FLX6OhGLZh8DQ0+vqM8pYl2g
         g+zJFhliUgBSUKDQyC7zbZa39SY/WVSHeT43NxTnS4SqdETTNZDxG0WeaW5hb8UQOd0d
         OayFEOoR7NI+H35El0V/bMc+oSRMSdRYXmPQ06OQVivYWnn6Jo/c0n3Wn9KB1Jm+Mbjy
         90pywEZ/t3I074pG7xW+t0tJAdY/UNLlfaBPqa3AyINzlQ3ALln9/aOYVlB7zdtek1k2
         7/Ew==
X-Gm-Message-State: AAQBX9cnRGT2qw2IpE3rFrkkIIfgPT9ak/R1mncpRz28ePJtgM1De9lh
        h8yJARqU7P7q4IlX1tPoVptnG77I7exVObBGW7FqASk89HVrAZ8dDnxzIQUn/xaWwdjzSz6Mplo
        PekUemZ31Mw0K4aduclwZXZag
X-Received: by 2002:a05:622a:1a0b:b0:3e6:3af1:de7a with SMTP id f11-20020a05622a1a0b00b003e63af1de7amr983573qtb.4.1681427531955;
        Thu, 13 Apr 2023 16:12:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlByEGJ4UdGFBHdGvGYtpq6JVyaUGtX1ideR+y+TXFaHJemqbrxo5x6y9sTphL6VxiZhrbGw==
X-Received: by 2002:a05:622a:1a0b:b0:3e6:3af1:de7a with SMTP id f11-20020a05622a1a0b00b003e63af1de7amr983544qtb.4.1681427531653;
        Thu, 13 Apr 2023 16:12:11 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p26-20020ac8741a000000b003dd8ad765dcsm814463qtq.76.2023.04.13.16.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:12:11 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 6/6] selftests/mm: Add tests for RO pinning vs fork()
Date:   Thu, 13 Apr 2023 19:12:09 -0400
Message-Id: <20230413231209.544825-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230413231120.544685-1-peterx@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
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

Add 10 one more test to cover RO pinning against fork() over uffd-wp.  It
covers both:

  (1) Early CoW test in fork() when page pinned,
  (2) page unshare due to RO longterm pin.

They are:

Testing wp-fork-pin on anon... done
Testing wp-fork-pin on shmem... done
Testing wp-fork-pin on shmem-private... done
Testing wp-fork-pin on hugetlb... done
Testing wp-fork-pin on hugetlb-private... done
Testing wp-fork-pin-with-event on anon... done
Testing wp-fork-pin-with-event on shmem... done
Testing wp-fork-pin-with-event on shmem-private... done
Testing wp-fork-pin-with-event on hugetlb... done
Testing wp-fork-pin-with-event on hugetlb-private... done

CONFIG_GUP_TEST needed or they'll be skipped.

Testing wp-fork-pin on anon... skipped [reason: Possibly CONFIG_GUP_TEST missing or unprivileged]

Note that only private pages matter here, but no hurt to also run all of
them over shared.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 144 ++++++++++++++++++-
 1 file changed, 141 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 739fc4d30342..269c86768a02 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -7,6 +7,8 @@
 
 #include "uffd-common.h"
 
+#include "../../../../mm/gup_test.h"
+
 #ifdef __NR_userfaultfd
 
 /* The unit test doesn't need a large or random size, make it 32MB for now */
@@ -247,7 +249,53 @@ static void *fork_event_consumer(void *data)
 	return NULL;
 }
 
-static int pagemap_test_fork(int uffd, bool with_event)
+typedef struct {
+	int gup_fd;
+	bool pinned;
+} pin_args;
+
+/*
+ * Returns 0 if succeed, <0 for errors.  pin_pages() needs to be paired
+ * with unpin_pages().  Currently it needs to be RO longterm pin to satisfy
+ * all needs of the test cases (e.g., trigger unshare, trigger fork() early
+ * CoW, etc.).
+ */
+static int pin_pages(pin_args *args, void *buffer, size_t size)
+{
+	struct pin_longterm_test test = {
+		.addr = (uintptr_t)buffer,
+		.size = size,
+		/* Read-only pins */
+		.flags = 0,
+	};
+
+	if (args->pinned)
+		err("already pinned");
+
+	args->gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	if (args->gup_fd < 0)
+		return -errno;
+
+	if (ioctl(args->gup_fd, PIN_LONGTERM_TEST_START, &test)) {
+		/* Even if gup_test existed, can be an old gup_test / kernel */
+		close(args->gup_fd);
+		return -errno;
+	}
+	args->pinned = true;
+	return 0;
+}
+
+static void unpin_pages(pin_args *args)
+{
+	if (!args->pinned)
+		err("unpin without pin first");
+	if (ioctl(args->gup_fd, PIN_LONGTERM_TEST_STOP))
+		err("PIN_LONGTERM_TEST_STOP");
+	close(args->gup_fd);
+	args->pinned = false;
+}
+
+static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 {
 	fork_event_args args = { .parent_uffd = uffd, .child_uffd = -1 };
 	pthread_t thread;
@@ -264,7 +312,17 @@ static int pagemap_test_fork(int uffd, bool with_event)
 	child = fork();
 	if (!child) {
 		/* Open the pagemap fd of the child itself */
+		pin_args args = {};
+
 		fd = pagemap_open();
+
+		if (test_pin && pin_pages(&args, area_dst, page_size))
+			/*
+			 * Normally when reach here we have pinned in
+			 * previous tests, so shouldn't fail anymore
+			 */
+			err("pin page failed in child");
+
 		value = pagemap_get_entry(fd, area_dst);
 		/*
 		 * After fork(), we should handle uffd-wp bit differently:
@@ -273,6 +331,8 @@ static int pagemap_test_fork(int uffd, bool with_event)
 		 * (2) when without EVENT_FORK, it should be dropped
 		 */
 		pagemap_check_wp(value, with_event);
+		if (test_pin)
+			unpin_pages(&args);
 		/* Succeed */
 		exit(0);
 	}
@@ -352,7 +412,7 @@ static void uffd_wp_fork_test_common(uffd_test_args_t *args,
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
 	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event)) {
+	if (pagemap_test_fork(uffd, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in present pte",
 			       with_event ? "missing" : "stall");
 		goto out;
@@ -383,7 +443,7 @@ static void uffd_wp_fork_test_common(uffd_test_args_t *args,
 	/* Uffd-wp should persist even swapped out */
 	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event)) {
+	if (pagemap_test_fork(uffd, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in zapped pte",
 			       with_event ? "missing" : "stall");
 		goto out;
@@ -415,6 +475,68 @@ static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
 	uffd_wp_fork_test_common(args, true);
 }
 
+static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
+					 bool with_event)
+{
+	int pagemap_fd;
+	pin_args pin_args = {};
+
+	if (uffd_register(uffd, area_dst, page_size, false, true, false))
+		err("register failed");
+
+	pagemap_fd = pagemap_open();
+
+	/* Touch the page */
+	*area_dst = 1;
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+
+	/*
+	 * 1. First pin, then fork().  This tests fork() special path when
+	 * doing early CoW if the page is private.
+	 */
+	if (pin_pages(&pin_args, area_dst, page_size)) {
+		uffd_test_skip("Possibly CONFIG_GUP_TEST missing "
+			       "or unprivileged");
+		close(pagemap_fd);
+		uffd_unregister(uffd, area_dst, page_size);
+		return;
+	}
+
+	if (pagemap_test_fork(uffd, with_event, false)) {
+		uffd_test_fail("Detected %s uffd-wp bit in early CoW of fork()",
+			       with_event ? "missing" : "stall");
+		unpin_pages(&pin_args);
+		goto out;
+	}
+
+	unpin_pages(&pin_args);
+
+	/*
+	 * 2. First fork(), then pin (in the child, where test_pin==true).
+	 * This tests COR, aka, page unsharing on private memories.
+	 */
+	if (pagemap_test_fork(uffd, with_event, true)) {
+		uffd_test_fail("Detected %s uffd-wp bit when RO pin",
+			       with_event ? "missing" : "stall");
+		goto out;
+	}
+	uffd_test_pass();
+out:
+	if (uffd_unregister(uffd, area_dst, page_size))
+		err("register failed");
+	close(pagemap_fd);
+}
+
+static void uffd_wp_fork_pin_test(uffd_test_args_t *args)
+{
+	uffd_wp_fork_pin_test_common(args, false);
+}
+
+static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t *args)
+{
+	uffd_wp_fork_pin_test_common(args, true);
+}
+
 static void check_memory_contents(char *p)
 {
 	unsigned long i, j;
@@ -923,6 +1045,22 @@ uffd_test_case_t uffd_tests[] = {
 		/* when set, child process should inherit uffd-wp bits */
 		UFFD_FEATURE_EVENT_FORK,
 	},
+	{
+		.name = "wp-fork-pin",
+		.uffd_fn = uffd_wp_fork_pin_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
+	},
+	{
+		.name = "wp-fork-pin-with-event",
+		.uffd_fn = uffd_wp_fork_pin_with_event_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM |
+		/* when set, child process should inherit uffd-wp bits */
+		UFFD_FEATURE_EVENT_FORK,
+	},
 	{
 		.name = "wp-unpopulated",
 		.uffd_fn = uffd_wp_unpopulated_test,
-- 
2.39.1

