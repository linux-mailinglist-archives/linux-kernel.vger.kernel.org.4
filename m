Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7C6E5144
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDQTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDQTyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8C46BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7gltokQzFShDFjL1ksnnTsH6QcBiNJdLCM4WiStCBA=;
        b=XpbbJfdYajrrp3hMSH2oTF7Vje90EyVxKw6PJuyf/IBRn/dR2uUVqDiXkw1neybkiYICU0
        WIXbYnoQaygHmXsIxGcOutsz1IOO6Nah30kELSSROmG5proKYfYKQ7RVBer7oNdqfFwALN
        pB9vfAHuLTHCOZ9PGri5Fwt5ai1aFRE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-5aB9MYjCObCgZ5txVv6Hbw-1; Mon, 17 Apr 2023 15:53:35 -0400
X-MC-Unique: 5aB9MYjCObCgZ5txVv6Hbw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ecc0c4b867so7375721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761213; x=1684353213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7gltokQzFShDFjL1ksnnTsH6QcBiNJdLCM4WiStCBA=;
        b=Fc+fj8sGyj0Beks/fOz9huHPESaBDwHKABLvC4rbKkwmxce+3dTSOC3ZVIpgQ0tYoy
         edUdZJdrWRKU6nXpYdbgpC/yypnwiZ5kraMY/F1jeGDF6QOW70++QATDTWYM+BteAtxp
         fwylVM7c8EE8Pa0eVpuE7f2/t6Ab+MgDiSxj/h7mMmmNdB77q53WI7g/MT1TF7FouIB3
         1mK5BMkeSJgy0rS+CXRzdYFDOojzZLqAGVn0e9IdpYFJNjhH18KFbeXMcboJG3PeREsw
         uaiBdZevM8RC6dX7cuQBBYKg1KFqWvALu2ZXrv7Wpbngs/d+naifpeDOLmpcREy8qbGc
         BGbA==
X-Gm-Message-State: AAQBX9d74P/grVzkV0Cd13NnTJ7fCQU+yHsv6W6rkdft3grdaBOBxerT
        oS+2AhWsdc4+4W+ERsIJSFN8R0I6By7KLR1GVKVtKEGvCWo62miH+DjTewx9qY5l+jsZ0m1gMCp
        4wpR6A4HppdU/TPSfCSJzIzOwYqvjF/3R+KrMZ1PjRcBnkhjq7vFuZ9MkpUk788vL1elLNV+M7u
        bVmOGS1A==
X-Received: by 2002:a05:622a:1aaa:b0:3ee:5637:29cc with SMTP id s42-20020a05622a1aaa00b003ee563729ccmr9226105qtc.0.1681761213625;
        Mon, 17 Apr 2023 12:53:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350b6uFndWE+tj9O/onYcGkZ0fK6zrVlztfCRN9qHsXGXyZEKmCVQ7jywbyXKWj+B4rqOxPDQOw==
X-Received: by 2002:a05:622a:1aaa:b0:3ee:5637:29cc with SMTP id s42-20020a05622a1aaa00b003ee563729ccmr9226079qtc.0.1681761213267;
        Mon, 17 Apr 2023 12:53:33 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 6/6] selftests/mm: Add tests for RO pinning vs fork()
Date:   Mon, 17 Apr 2023 15:53:17 -0400
Message-Id: <20230417195317.898696-7-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417195317.898696-1-peterx@redhat.com>
References: <20230417195317.898696-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test suite (with 10 more sub-tests) to cover RO pinning against
fork() over uffd-wp.  It covers both:

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

Note that the major test goal is on private memory, but no hurt to also run
all of them over shared because shared memory should work the same.

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

