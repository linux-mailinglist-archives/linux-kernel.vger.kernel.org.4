Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87F66DFBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjDLQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjDLQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2858A7A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3C20L7q6E0jI4D7x0NRqCKUvj6UY8rhbxmq4jIDbcM=;
        b=HDbafzJ2Pfs2wWHB6TuFWHRC0bQ3XQDzTWD/mH+v+Rm/OlBx1xqGMFC+r6YWo+rBkYAv9Z
        1IP0G6ia4YsVo84BZIIwTsBEidcD1+XvMAlWZQCtUM/SBdt7SzcjP0Eb83SMMBE/Fw7k2K
        U4ElBfL8ESK7PJ34oSzrmOV8lgCg6M0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-3k4y9FA1MKC4WR4QTA-qhg-1; Wed, 12 Apr 2023 12:43:43 -0400
X-MC-Unique: 3k4y9FA1MKC4WR4QTA-qhg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3e699015faeso3543961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317822; x=1683909822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3C20L7q6E0jI4D7x0NRqCKUvj6UY8rhbxmq4jIDbcM=;
        b=fck4d30Qg3nfpLDZeN0AwhY3TZAH82CpqJNT8xRxABX9XBco8b5RCjSo1DaPbeqdVO
         2EcZCRhLmfIBt88kF2OzSoujoxtTD6fRuoq+aMW/SY2233H5RuyHdKujZuD0iLIwcQPd
         gub3rL1Ky3ihm+roTe1mCvg8sJ8h8TNQc2l2teMB8yxdLC0jo3VMnQLv9k0uP7yh3mzR
         zxNpjvifOZbPP067lEWJszQgEnEgEdS0TQVUh+7Tf2EE4lnJIq0T2h8kMTyswyNQf4FA
         u6iVLIzwsvqv0rSRq3KDGciXSZ4QiC6wGjFzj3cWcvi7pwZxuprdBGlmX9e6PXpxItQx
         mAGw==
X-Gm-Message-State: AAQBX9cf1iLkeYWIJ4tRFYROXdGQ0GZOAPsIuEMutKHNCjPSE9rhDdMT
        ul5svrZiR/8tMQfayT+UbI9jOrATJpEdAlGHJ7GKRXSr7VrhupnrWm8RSyl3xf40CH6x4kuGksF
        bEH5lZFB+XqIvVhzPpCNg7LgA4RRP9Fo2RoXw8hvlrQ26rj6PQ2W6cUtP3vGmO2bCnmgQFTnwK+
        JRmgZ/4w==
X-Received: by 2002:a05:622a:14cf:b0:3bf:cf77:a861 with SMTP id u15-20020a05622a14cf00b003bfcf77a861mr4120233qtx.4.1681317821882;
        Wed, 12 Apr 2023 09:43:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350bS0H0y2MXWTHEdCzjaxChBZetPVl11/ilu2oRzLKkLGeeR4cj9iwfLJ5Lhe5q6n8VH3atofw==
X-Received: by 2002:a05:622a:14cf:b0:3bf:cf77:a861 with SMTP id u15-20020a05622a14cf00b003bfcf77a861mr4120195qtx.4.1681317821429;
        Wed, 12 Apr 2023 09:43:41 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id b15-20020ac8678f000000b003e38e2815a5sm4328106qtp.22.2023.04.12.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:40 -0700 (PDT)
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
Subject: [PATCH v2 19/31] selftests/mm: Rename uffd_stats to uffd_args
Date:   Wed, 12 Apr 2023 12:43:37 -0400
Message-Id: <20230412164337.328607-1-peterx@redhat.com>
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

Prepare for adding more fields into the struct.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 28 ++++++-------
 tools/testing/selftests/mm/uffd-common.h |  6 +--
 tools/testing/selftests/mm/uffd-stress.c | 51 ++++++++++++------------
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index f02dfcf10714..e746405aa8f3 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -186,34 +186,34 @@ struct uffd_test_ops hugetlb_uffd_test_ops = {
 	.check_pmd_mapping = NULL,
 };
 
-void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
+void uffd_stats_report(struct uffd_args *args, int n_cpus)
 {
 	int i;
 	unsigned long long miss_total = 0, wp_total = 0, minor_total = 0;
 
 	for (i = 0; i < n_cpus; i++) {
-		miss_total += stats[i].missing_faults;
-		wp_total += stats[i].wp_faults;
-		minor_total += stats[i].minor_faults;
+		miss_total += args[i].missing_faults;
+		wp_total += args[i].wp_faults;
+		minor_total += args[i].minor_faults;
 	}
 
 	printf("userfaults: ");
 	if (miss_total) {
 		printf("%llu missing (", miss_total);
 		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].missing_faults);
+			printf("%lu+", args[i].missing_faults);
 		printf("\b) ");
 	}
 	if (wp_total) {
 		printf("%llu wp (", wp_total);
 		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].wp_faults);
+			printf("%lu+", args[i].wp_faults);
 		printf("\b) ");
 	}
 	if (minor_total) {
 		printf("%llu minor (", minor_total);
 		for (i = 0; i < n_cpus; i++)
-			printf("%lu+", stats[i].minor_faults);
+			printf("%lu+", args[i].minor_faults);
 		printf("\b)");
 	}
 	printf("\n");
@@ -397,7 +397,7 @@ int uffd_read_msg(int ufd, struct uffd_msg *msg)
 	return 0;
 }
 
-void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
+void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 {
 	unsigned long offset;
 
@@ -407,7 +407,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
 		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
-		stats->wp_faults++;
+		args->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
 		int b;
@@ -430,7 +430,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
 		for (b = 0; b < page_size; ++b)
 			area[b] = ~area[b];
 		continue_range(uffd, msg->arg.pagefault.address, page_size);
-		stats->minor_faults++;
+		args->minor_faults++;
 	} else {
 		/*
 		 * Missing page faults.
@@ -460,14 +460,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
 		offset &= ~(page_size-1);
 
 		if (copy_page(uffd, offset))
-			stats->missing_faults++;
+			args->missing_faults++;
 	}
 }
 
 void *uffd_poll_thread(void *arg)
 {
-	struct uffd_stats *stats = (struct uffd_stats *)arg;
-	unsigned long cpu = stats->cpu;
+	struct uffd_args *args = (struct uffd_args *)arg;
+	unsigned long cpu = args->cpu;
 	struct pollfd pollfd[2];
 	struct uffd_msg msg;
 	struct uffdio_register uffd_reg;
@@ -502,7 +502,7 @@ void *uffd_poll_thread(void *arg)
 			err("unexpected msg event %u\n", msg.event);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			uffd_handle_page_fault(&msg, stats);
+			uffd_handle_page_fault(&msg, args);
 			break;
 		case UFFD_EVENT_FORK:
 			close(uffd);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 47565b2f2dee..f8d2ad178827 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -70,7 +70,7 @@
 						  -  1)))
 
 /* Userfaultfd test statistics */
-struct uffd_stats {
+struct uffd_args {
 	int cpu;
 	unsigned long missing_faults;
 	unsigned long wp_faults;
@@ -98,12 +98,12 @@ extern uffd_test_ops_t shmem_uffd_test_ops;
 extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 
-void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
+void uffd_stats_report(struct uffd_args *args, int n_cpus);
 void uffd_test_ctx_init(uint64_t features);
 void userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
-void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
+void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry);
 int copy_page(int ufd, unsigned long offset);
 void *uffd_poll_thread(void *arg);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 54fc9b4ffa3c..ce7251ab93ef 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -90,16 +90,15 @@ static void usage(void)
 	exit(1);
 }
 
-static void uffd_stats_reset(struct uffd_stats *uffd_stats,
-			     unsigned long n_cpus)
+static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
 {
 	int i;
 
 	for (i = 0; i < n_cpus; i++) {
-		uffd_stats[i].cpu = i;
-		uffd_stats[i].missing_faults = 0;
-		uffd_stats[i].wp_faults = 0;
-		uffd_stats[i].minor_faults = 0;
+		args[i].cpu = i;
+		args[i].missing_faults = 0;
+		args[i].wp_faults = 0;
+		args[i].minor_faults = 0;
 	}
 }
 
@@ -163,7 +162,7 @@ pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static void *uffd_read_thread(void *arg)
 {
-	struct uffd_stats *stats = (struct uffd_stats *)arg;
+	struct uffd_args *args = (struct uffd_args *)arg;
 	struct uffd_msg msg;
 
 	pthread_mutex_unlock(&uffd_read_mutex);
@@ -172,7 +171,7 @@ static void *uffd_read_thread(void *arg)
 	for (;;) {
 		if (uffd_read_msg(uffd, &msg))
 			continue;
-		uffd_handle_page_fault(&msg, stats);
+		uffd_handle_page_fault(&msg, args);
 	}
 
 	return NULL;
@@ -210,7 +209,7 @@ static void *background_thread(void *arg)
 	return NULL;
 }
 
-static int stress(struct uffd_stats *uffd_stats)
+static int stress(struct uffd_args *args)
 {
 	unsigned long cpu;
 	pthread_t locking_threads[nr_cpus];
@@ -225,12 +224,12 @@ static int stress(struct uffd_stats *uffd_stats)
 		if (bounces & BOUNCE_POLL) {
 			if (pthread_create(&uffd_threads[cpu], &attr,
 					   uffd_poll_thread,
-					   (void *)&uffd_stats[cpu]))
+					   (void *)&args[cpu]))
 				return 1;
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
 					   uffd_read_thread,
-					   (void *)&uffd_stats[cpu]))
+					   (void *)&args[cpu]))
 				return 1;
 			pthread_mutex_lock(&uffd_read_mutex);
 		}
@@ -264,7 +263,7 @@ static int stress(struct uffd_stats *uffd_stats)
 			if (write(pipefd[cpu*2+1], &c, 1) != 1)
 				err("pipefd write error");
 			if (pthread_join(uffd_threads[cpu],
-					 (void *)&uffd_stats[cpu]))
+					 (void *)&args[cpu]))
 				return 1;
 		} else {
 			if (pthread_cancel(uffd_threads[cpu]))
@@ -493,7 +492,7 @@ static int userfaultfd_events_test(void)
 	int err, features;
 	pid_t pid;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_args args = { 0 };
 
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
@@ -508,7 +507,7 @@ static int userfaultfd_events_test(void)
 			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
 	pid = fork();
@@ -526,9 +525,9 @@ static int userfaultfd_events_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	uffd_stats_report(&stats, 1);
+	uffd_stats_report(&args, 1);
 
-	return stats.missing_faults != nr_pages;
+	return args.missing_faults != nr_pages;
 }
 
 static int userfaultfd_sig_test(void)
@@ -538,7 +537,7 @@ static int userfaultfd_sig_test(void)
 	int err, features;
 	pid_t pid;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_args args = { 0 };
 
 	printf("testing signal delivery: ");
 	fflush(stdout);
@@ -557,7 +556,7 @@ static int userfaultfd_sig_test(void)
 
 	uffd_test_ops->release_pages(area_dst);
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
 	pid = fork();
@@ -606,7 +605,7 @@ static int userfaultfd_minor_test(void)
 	unsigned long p;
 	pthread_t uffd_mon;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_args args = { 0 };
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -629,7 +628,7 @@ static int userfaultfd_minor_test(void)
 		       page_size);
 	}
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
 	/*
@@ -645,7 +644,7 @@ static int userfaultfd_minor_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	uffd_stats_report(&stats, 1);
+	uffd_stats_report(&args, 1);
 
 	if (test_collapse) {
 		printf("testing collapse of uffd memory into PMD-mapped THPs:");
@@ -664,7 +663,7 @@ static int userfaultfd_minor_test(void)
 		printf(" done.\n");
 	}
 
-	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
+	return args.missing_faults != 0 || args.minor_faults != nr_pages;
 }
 
 static int pagemap_open(void)
@@ -822,7 +821,7 @@ static int userfaultfd_stress(void)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_stats uffd_stats[nr_cpus];
+	struct uffd_args args[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
 
 	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
@@ -894,10 +893,10 @@ static int userfaultfd_stress(void)
 		 */
 		uffd_test_ops->release_pages(area_dst);
 
-		uffd_stats_reset(uffd_stats, nr_cpus);
+		uffd_stats_reset(args, nr_cpus);
 
 		/* bounce pass */
-		if (stress(uffd_stats))
+		if (stress(args))
 			return 1;
 
 		/* Clear all the write protections if there is any */
@@ -926,7 +925,7 @@ static int userfaultfd_stress(void)
 
 		swap(area_src_alias, area_dst_alias);
 
-		uffd_stats_report(uffd_stats, nr_cpus);
+		uffd_stats_report(args, nr_cpus);
 	}
 
 	if (test_type == TEST_ANON) {
-- 
2.39.1

