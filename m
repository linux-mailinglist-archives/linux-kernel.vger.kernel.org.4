Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61786E5142
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDQTyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDQTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8256EB1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PiB4O8c7FzfgLpxlGuxco4WipLi6p7uHP+fG5udokS8=;
        b=DlGuFqq5mO+6tNfbVSNcs4mL4/S420Z3QlL7DGSbj+JCAnmzmEY9NcQZfrvU14oF9BBLP2
        cudzb+lH1PpxKa7Un1T0KAJ/KCqI+wUfmDEFxgyuNc3dZRuQYT/snCCqPBobaHDGQTQ2N7
        jboM8HcVxVgs71k/fG1AI2GcM58Fs+M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-yqvIume8OiyQWcc_AAwebw-1; Mon, 17 Apr 2023 15:53:30 -0400
X-MC-Unique: yqvIume8OiyQWcc_AAwebw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74acb477be6so72178385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761209; x=1684353209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiB4O8c7FzfgLpxlGuxco4WipLi6p7uHP+fG5udokS8=;
        b=aDso02lrE/qXfmVC3GBa5CYS+LBzDDJmq7LjiSk6kyv66WVMRDGp/izxZRpeDSUGPO
         KYFfcoSFOAWgL0631VGA6jcR15LYJULTjVpJF+0efoEbwSO34D6nC8FznYzXEN4ILDvE
         aaL59sD3lqGrUbZHszwIVeDJK5QDYAL4Pi/irSHl/javwwa4OAqu0GqALzpF04hAZCWs
         Xk2VkVSdwwFjR6QLsccXI7eouuh90vSlduruGs4vYdXG6GUik8zVXwgQauk5Pi3CeFUE
         C2m/NLnKkaaD7o6MGPl6hbBuddEYkveHceI4ZhLRnlYBinkT/JNK69gVi2iwVpIzfS9L
         fQCw==
X-Gm-Message-State: AAQBX9cltNvn3urTiEOhlh/kmK+yqWmvkGC/6hBgNa9n9ig/9zGmPWEa
        Xof6+aqOm2CiuY3X+3hkHrcLXrglWgDqRPIC94sOhMyH70+dfaoPfoiL2QQTsVHfG2wG6vkn6oq
        Nxyrnaw6tE5jrS5sD4+4lSo2pQ6iTChlIOACaNfTIvkPOOW/LFeeHjSH3oW76V9xa28ibz5d5nA
        Ae+OfsJw==
X-Received: by 2002:a05:622a:1352:b0:3ef:37fa:e1d6 with SMTP id w18-20020a05622a135200b003ef37fae1d6mr1229514qtk.2.1681761209399;
        Mon, 17 Apr 2023 12:53:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/Xr56P7wXtTgHgR9HpSg1x1E8ea69mUaTjl3roEaHjKyTAe98r0gM0V7aTgCT/jxwZH4gBA==
X-Received: by 2002:a05:622a:1352:b0:3ef:37fa:e1d6 with SMTP id w18-20020a05622a135200b003ef37fae1d6mr1229477qtk.2.1681761209061;
        Mon, 17 Apr 2023 12:53:29 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/6] selftests/mm: Extend and rename uffd pagemap test
Date:   Mon, 17 Apr 2023 15:53:15 -0400
Message-Id: <20230417195317.898696-5-peterx@redhat.com>
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

Extend it to all types of mem, meanwhile add one parallel test when
EVENT_FORK is enabled, where uffd-wp bits should be persisted rather than
dropped.

Since at it, rename the test to "wp-fork" to better show what it means.
Making the new test called "wp-fork-with-event".

Before:

        Testing pagemap on anon... done

After:

        Testing wp-fork on anon... done
        Testing wp-fork on shmem... done
        Testing wp-fork on shmem-private... done
        Testing wp-fork on hugetlb... done
        Testing wp-fork on hugetlb-private... done
        Testing wp-fork-with-event on anon... done
        Testing wp-fork-with-event on shmem... done
        Testing wp-fork-with-event on shmem-private... done
        Testing wp-fork-with-event on hugetlb... done
        Testing wp-fork-with-event on hugetlb-private... done

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 130 +++++++++++++++----
 1 file changed, 106 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 452ca05a829d..739fc4d30342 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -227,25 +227,65 @@ static int pagemap_open(void)
 			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
 	} while (0)
 
-static int pagemap_test_fork(bool present)
+typedef struct {
+	int parent_uffd, child_uffd;
+} fork_event_args;
+
+static void *fork_event_consumer(void *data)
 {
-	pid_t child = fork();
+	fork_event_args *args = data;
+	struct uffd_msg msg = { 0 };
+
+	/* Read until a full msg received */
+	while (uffd_read_msg(args->parent_uffd, &msg));
+
+	if (msg.event != UFFD_EVENT_FORK)
+		err("wrong message: %u\n", msg.event);
+
+	/* Just to be properly freed later */
+	args->child_uffd = msg.arg.fork.ufd;
+	return NULL;
+}
+
+static int pagemap_test_fork(int uffd, bool with_event)
+{
+	fork_event_args args = { .parent_uffd = uffd, .child_uffd = -1 };
+	pthread_t thread;
+	pid_t child;
 	uint64_t value;
 	int fd, result;
 
+	/* Prepare a thread to resolve EVENT_FORK */
+	if (with_event) {
+		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
+			err("pthread_create()");
+	}
+
+	child = fork();
 	if (!child) {
 		/* Open the pagemap fd of the child itself */
 		fd = pagemap_open();
 		value = pagemap_get_entry(fd, area_dst);
 		/*
-		 * After fork() uffd-wp bit should be gone as long as we're
-		 * without UFFD_FEATURE_EVENT_FORK
+		 * After fork(), we should handle uffd-wp bit differently:
+		 *
+		 * (1) when with EVENT_FORK, it should persist
+		 * (2) when without EVENT_FORK, it should be dropped
 		 */
-		pagemap_check_wp(value, false);
+		pagemap_check_wp(value, with_event);
 		/* Succeed */
 		exit(0);
 	}
 	waitpid(child, &result, 0);
+
+	if (with_event) {
+		if (pthread_join(thread, NULL))
+			err("pthread_join()");
+		if (args.child_uffd < 0)
+			err("Didn't receive child uffd");
+		close(args.child_uffd);
+	}
+
 	return result;
 }
 
@@ -295,7 +335,8 @@ static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
 	uffd_test_pass();
 }
 
-static void uffd_pagemap_test(uffd_test_args_t *args)
+static void uffd_wp_fork_test_common(uffd_test_args_t *args,
+				     bool with_event)
 {
 	int pagemap_fd;
 	uint64_t value;
@@ -311,23 +352,42 @@ static void uffd_pagemap_test(uffd_test_args_t *args)
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
 	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
-	/* Make sure uffd-wp bit dropped when fork */
-	if (pagemap_test_fork(true))
-		err("Detected stall uffd-wp bit in child");
-
-	/* Exclusive required or PAGEOUT won't work */
-	if (!(value & PM_MMAP_EXCLUSIVE))
-		err("multiple mapping detected: 0x%"PRIx64, value);
+	if (pagemap_test_fork(uffd, with_event)) {
+		uffd_test_fail("Detected %s uffd-wp bit in child in present pte",
+			       with_event ? "missing" : "stall");
+		goto out;
+	}
 
-	if (madvise(area_dst, page_size, MADV_PAGEOUT))
-		err("madvise(MADV_PAGEOUT) failed");
+	/*
+	 * This is an attempt for zapping the pgtable so as to test the
+	 * markers.
+	 *
+	 * For private mappings, PAGEOUT will only work on exclusive ptes
+	 * (PM_MMAP_EXCLUSIVE) which we should satisfy.
+	 *
+	 * For shared, PAGEOUT may not work.  Use DONTNEED instead which
+	 * plays a similar role of zapping (rather than freeing the page)
+	 * to expose pte markers.
+	 */
+	if (args->mem_type->shared) {
+		if (madvise(area_dst, page_size, MADV_DONTNEED))
+			err("MADV_DONTNEED");
+	} else {
+		/*
+		 * NOTE: ignore retval because private-hugetlb doesn't yet
+		 * support swapping, so it could fail.
+		 */
+		madvise(area_dst, page_size, MADV_PAGEOUT);
+	}
 
 	/* Uffd-wp should persist even swapped out */
 	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
-	/* Make sure uffd-wp bit dropped when fork */
-	if (pagemap_test_fork(false))
-		err("Detected stall uffd-wp bit in child");
+	if (pagemap_test_fork(uffd, with_event)) {
+		uffd_test_fail("Detected %s uffd-wp bit in child in zapped pte",
+			       with_event ? "missing" : "stall");
+		goto out;
+	}
 
 	/* Unprotect; this tests swap pte modifications */
 	wp_range(uffd, (uint64_t)area_dst, page_size, false);
@@ -338,9 +398,21 @@ static void uffd_pagemap_test(uffd_test_args_t *args)
 	*area_dst = 2;
 	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
-
-	close(pagemap_fd);
 	uffd_test_pass();
+out:
+	if (uffd_unregister(uffd, area_dst, nr_pages * page_size))
+		err("unregister failed");
+	close(pagemap_fd);
+}
+
+static void uffd_wp_fork_test(uffd_test_args_t *args)
+{
+	uffd_wp_fork_test_common(args, false);
+}
+
+static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
+{
+	uffd_wp_fork_test_common(args, true);
 }
 
 static void check_memory_contents(char *p)
@@ -836,10 +908,20 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_feature_required = 0,
 	},
 	{
-		.name = "pagemap",
-		.uffd_fn = uffd_pagemap_test,
-		.mem_targets = MEM_ANON,
-		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+		.name = "wp-fork",
+		.uffd_fn = uffd_wp_fork_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
+	},
+	{
+		.name = "wp-fork-with-event",
+		.uffd_fn = uffd_wp_fork_with_event_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM |
+		/* when set, child process should inherit uffd-wp bits */
+		UFFD_FEATURE_EVENT_FORK,
 	},
 	{
 		.name = "wp-unpopulated",
-- 
2.39.1

