Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4A6E17EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDMXMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDMXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7544A7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PiB4O8c7FzfgLpxlGuxco4WipLi6p7uHP+fG5udokS8=;
        b=IVATLpeGNZVLtexgURJ9v5KEjo4XqoKNFAifajKjA2AoQGYYfzliEUVaBTkqusocvKMFYC
        nSGwuoPuYO8Lt9hz8vgHUcCQwvFlXGNQwtxVtBLNA1TqEsdlhGy9ppR9Pw3Eerq8TQv09l
        N1rnhm2lgw1oSCd8hdHktt9+c87oVN4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fR1VycY6MsiVDhtXiWB0pQ-1; Thu, 13 Apr 2023 19:11:33 -0400
X-MC-Unique: fR1VycY6MsiVDhtXiWB0pQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3e63ec50808so6303951cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427491; x=1684019491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiB4O8c7FzfgLpxlGuxco4WipLi6p7uHP+fG5udokS8=;
        b=CQTcBiHBW/mFc3PVrD/kq9EYSVfkJmc9lbj6+++/DG686g/8xRCzcZWpaPlM0rVPF+
         npiUEVRlLInAoMMA9s918ZM4mY/fGYeGTq5e7N8WXdHN3ZYI2aWH4icGWK69isU1o8Wo
         5Emk2ZB67biT6lxYIhRCTuHhsjgABW2eInc+N34GvhfMUYzJltKhcmQK1CFVh2i9YIhn
         4o40GiPCYB0oMS/QXU9jQRdpKHiJ6iRHKjtYJdYgIKhlOjhglCv2I73n2MLBDbRm/Jfh
         nDDuuXO4QX98ceL6Y5c3JhBXAxqMLxzVqcvIGp5oToiYDM7OPfvmDnFq77Fla5HhS9fj
         D/NQ==
X-Gm-Message-State: AAQBX9cd4FtBA6VWPmJGl4XlPZ1m+iqCh8bPDS3ZCVqf83fvqIC+M7Kz
        aZv1f9sQ2aBV+PgbeJelEvhNzLu4I+luGNavzJxPFKg+NiNiK/l56LdyF59UXyZ2lin57E4KSt5
        2CvtQBQeIJWTum5/UBWRRnEDmuJ7YjvQyrsXum3M6nKVTxt1LeikWsO0oYGl+puCPqagLFHfP0D
        v7sQGWbA==
X-Received: by 2002:ac8:5813:0:b0:3e6:707e:d3b2 with SMTP id g19-20020ac85813000000b003e6707ed3b2mr1243727qtg.0.1681427491579;
        Thu, 13 Apr 2023 16:11:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350YVqAYBJtjYRo4m3UT95yOx2hm06W56ReVZ3RTAjywmwDlKXwFvUxElkGFKWsmcn3tNMj/n2g==
X-Received: by 2002:ac8:5813:0:b0:3e6:707e:d3b2 with SMTP id g19-20020ac85813000000b003e6707ed3b2mr1243678qtg.0.1681427491125;
        Thu, 13 Apr 2023 16:11:31 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 4/6] selftests/mm: Extend and rename uffd pagemap test
Date:   Thu, 13 Apr 2023 19:11:18 -0400
Message-Id: <20230413231120.544685-5-peterx@redhat.com>
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

