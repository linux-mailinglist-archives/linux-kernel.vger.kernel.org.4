Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA26DFBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDLQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDLQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4069758
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moJlUxkxV9yMXHXtrl4RDvvI70k6nNWMdoirhLeOGGU=;
        b=d1aTx4JuRpo9lusjEbi8CiAjAcHr4Lxzs1lULLk3/L30qWUUL4QQWcFYI1n/+5jsbq5yDp
        U/My85KzBpS1iV+Q17X6BL2h7e3xoLhs2abO31lY0qs2QxlGI/jgCIHAHrwmGR5q70hgCy
        GgFeLykDPNjXvMFbTzX9T0X1CxHafis=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-JOBEczZtNl61d4k9vkU9nA-1; Wed, 12 Apr 2023 12:44:09 -0400
X-MC-Unique: JOBEczZtNl61d4k9vkU9nA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e8d943d3a4so667881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317845; x=1683909845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moJlUxkxV9yMXHXtrl4RDvvI70k6nNWMdoirhLeOGGU=;
        b=l9mzaHxU1mvgbOzW7pvrOur+WLQjfNAFgcFu0E2o8cgnHuhOpvzTQ70JKaI9Maxzpy
         oZgKzxFEcs5qgGEo7qqHcG3NdTbULFAcHYa3MTjy11wUV0VQi29Sy2SkvqChBqBGxU95
         hawPiMDXkk6jruWCgJv4AUJO+ZKenTI484+kRe8LJuvVw2Izf6jU49u7OOU9y4bVQqHg
         Vj+35mLFjQLw3ehzld17ID2iR5ObzbuntVakAmTlHQ1c9NymBwSQT41jrGMzCZYj9Lvh
         Htv7pxws33DJcHterqLPxCz4APoBuuAWSWHtOAIzrgMrOXIi9G1J/SUvv02NxmoAT1UH
         Vfqw==
X-Gm-Message-State: AAQBX9dKMHOTmfZqi2eM61AloguSn2A/QgMQNsfXaLdyFk2kgkAFIvMl
        5l3WNdO1OZN6QJiBQZg+u0NFGa+A5b95KLaBb5tRFq6H++3mr7bgsBx6tZnHne+a6a7AP04xfVA
        7bTh80p4ZRqod3sNL3vGnlaehnp8b7CaFGD8B2XYNhBm1BCrBYrex1JSqhMMuPs9miXHu5E9BFf
        k7/cu/mw==
X-Received: by 2002:a05:622a:14cf:b0:3b8:6c6e:4949 with SMTP id u15-20020a05622a14cf00b003b86c6e4949mr4198065qtx.4.1681317845033;
        Wed, 12 Apr 2023 09:44:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZyI0LO2mW+nKpthrbnN+kJ/X5tJn7Dl5m81czcPWaU9AQPMWeY1C8uomlpugD00uwX305oNw==
X-Received: by 2002:a05:622a:14cf:b0:3b8:6c6e:4949 with SMTP id u15-20020a05622a14cf00b003b86c6e4949mr4198015qtx.4.1681317844406;
        Wed, 12 Apr 2023 09:44:04 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id do28-20020a05620a2b1c00b007484bc04a63sm4782932qkb.99.2023.04.12.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:44:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 25/31] selftests/mm: Move uffd sig/events tests into uffd unit tests
Date:   Wed, 12 Apr 2023 12:44:00 -0400
Message-Id: <20230412164400.328798-1-peterx@redhat.com>
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

Move the two tests into the unit test, and convert it into 20 standalone
tests:

  - events test on all 5 mem types, with wp on/off
  - signal test on all 5 mem types, with wp on/off

  Testing sigbus on anon... done
  Testing sigbus on shmem... done
  Testing sigbus on shmem-private... done
  Testing sigbus on hugetlb... done
  Testing sigbus on hugetlb-private... done
  Testing sigbus-wp on anon... done
  Testing sigbus-wp on shmem... done
  Testing sigbus-wp on shmem-private... done
  Testing sigbus-wp on hugetlb... done
  Testing sigbus-wp on hugetlb-private... done
  Testing events on anon... done
  Testing events on shmem... done
  Testing events on shmem-private... done
  Testing events on hugetlb... done
  Testing events on hugetlb-private... done
  Testing events-wp on anon... done
  Testing events-wp on shmem... done
  Testing events-wp on shmem-private... done
  Testing events-wp on hugetlb... done
  Testing events-wp on hugetlb-private... done

It'll also remove a lot of global references along the way,
e.g. test_uffdio_wp will be replaced with the wp value passed over.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 227 +---------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 264 +++++++++++++++++++
 2 files changed, 265 insertions(+), 226 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f9322bbaf825..ce51180238d8 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -273,133 +273,6 @@ static int stress(struct uffd_args *args)
 	return 0;
 }
 
-sigjmp_buf jbuf, *sigbuf;
-
-static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
-{
-	if (sig == SIGBUS) {
-		if (sigbuf)
-			siglongjmp(*sigbuf, 1);
-		abort();
-	}
-}
-
-/*
- * For non-cooperative userfaultfd test we fork() a process that will
- * generate pagefaults, will mremap the area monitored by the
- * userfaultfd and at last this process will release the monitored
- * area.
- * For the anonymous and shared memory the area is divided into two
- * parts, the first part is accessed before mremap, and the second
- * part is accessed after mremap. Since hugetlbfs does not support
- * mremap, the entire monitored area is accessed in a single pass for
- * HUGETLB_TEST.
- * The release of the pages currently generates event for shmem and
- * anonymous memory (UFFD_EVENT_REMOVE), hence it is not checked
- * for hugetlb.
- * For signal test(UFFD_FEATURE_SIGBUS), signal_test = 1, we register
- * monitored area, generate pagefaults and test that signal is delivered.
- * Use UFFDIO_COPY to allocate missing page and retry. For signal_test = 2
- * test robustness use case - we release monitored area, fork a process
- * that will generate pagefaults and verify signal is generated.
- * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
- * feature. Using monitor thread, verify no userfault events are generated.
- */
-static int faulting_process(int signal_test, bool wp)
-{
-	unsigned long nr;
-	unsigned long long count;
-	unsigned long split_nr_pages;
-	unsigned long lastnr;
-	struct sigaction act;
-	volatile unsigned long signalled = 0;
-
-	split_nr_pages = (nr_pages + 1) / 2;
-
-	if (signal_test) {
-		sigbuf = &jbuf;
-		memset(&act, 0, sizeof(act));
-		act.sa_sigaction = sighndl;
-		act.sa_flags = SA_SIGINFO;
-		if (sigaction(SIGBUS, &act, 0))
-			err("sigaction");
-		lastnr = (unsigned long)-1;
-	}
-
-	for (nr = 0; nr < split_nr_pages; nr++) {
-		volatile int steps = 1;
-		unsigned long offset = nr * page_size;
-
-		if (signal_test) {
-			if (sigsetjmp(*sigbuf, 1) != 0) {
-				if (steps == 1 && nr == lastnr)
-					err("Signal repeated");
-
-				lastnr = nr;
-				if (signal_test == 1) {
-					if (steps == 1) {
-						/* This is a MISSING request */
-						steps++;
-						if (copy_page(uffd, offset, wp))
-							signalled++;
-					} else {
-						/* This is a WP request */
-						assert(steps == 2);
-						wp_range(uffd,
-							 (__u64)area_dst +
-							 offset,
-							 page_size, false);
-					}
-				} else {
-					signalled++;
-					continue;
-				}
-			}
-		}
-
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr])
-			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
-		/*
-		 * Trigger write protection if there is by writing
-		 * the same value back.
-		 */
-		*area_count(area_dst, nr) = count;
-	}
-
-	if (signal_test)
-		return signalled != split_nr_pages;
-
-	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
-			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
-	if (area_dst == MAP_FAILED)
-		err("mremap");
-	/* Reset area_src since we just clobbered it */
-	area_src = NULL;
-
-	for (; nr < nr_pages; nr++) {
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr]) {
-			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
-		}
-		/*
-		 * Trigger write protection if there is by writing
-		 * the same value back.
-		 */
-		*area_count(area_dst, nr) = count;
-	}
-
-	uffd_test_ops->release_pages(area_dst);
-
-	for (nr = 0; nr < nr_pages; nr++)
-		if (my_bcmp(area_dst + nr * page_size, zeropage, page_size))
-			err("nr %lu is not zero", nr);
-
-	return 0;
-}
-
 static void retry_uffdio_zeropage(int ufd,
 				  struct uffdio_zeropage *uffdio_zeropage,
 				  unsigned long offset)
@@ -483,103 +356,6 @@ static int userfaultfd_zeropage_test(void)
 	return 0;
 }
 
-static int userfaultfd_events_test(void)
-{
-	pthread_t uffd_mon;
-	int err, features;
-	pid_t pid;
-	char c;
-	struct uffd_args args = { 0 };
-
-	printf("testing events (fork, remap, remove): ");
-	fflush(stdout);
-
-	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
-		UFFD_FEATURE_EVENT_REMOVE;
-	uffd_test_ctx_init(features);
-
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
-
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
-			  true, test_uffdio_wp, false))
-		err("register failure");
-
-	args.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
-		err("uffd_poll_thread create");
-
-	pid = fork();
-	if (pid < 0)
-		err("fork");
-
-	if (!pid)
-		exit(faulting_process(0, test_uffdio_wp));
-
-	waitpid(pid, &err, 0);
-	if (err)
-		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
-		err("pipe write");
-	if (pthread_join(uffd_mon, NULL))
-		return 1;
-
-	uffd_stats_report(&args, 1);
-
-	return args.missing_faults != nr_pages;
-}
-
-static int userfaultfd_sig_test(void)
-{
-	unsigned long userfaults;
-	pthread_t uffd_mon;
-	int err, features;
-	pid_t pid;
-	char c;
-	struct uffd_args args = { 0 };
-
-	printf("testing signal delivery: ");
-	fflush(stdout);
-
-	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	uffd_test_ctx_init(features);
-
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
-
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
-			  true, test_uffdio_wp, false))
-		err("register failure");
-
-	if (faulting_process(1, test_uffdio_wp))
-		err("faulting process failed");
-
-	uffd_test_ops->release_pages(area_dst);
-
-	args.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
-		err("uffd_poll_thread create");
-
-	pid = fork();
-	if (pid < 0)
-		err("fork");
-
-	if (!pid)
-		exit(faulting_process(2, test_uffdio_wp));
-
-	waitpid(pid, &err, 0);
-	if (err)
-		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
-		err("pipe write");
-	if (pthread_join(uffd_mon, (void **)&userfaults))
-		return 1;
-
-	printf("done.\n");
-	if (userfaults)
-		err("Signal test failed, userfaults: %ld", userfaults);
-
-	return userfaults != 0;
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -691,8 +467,7 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(args, nr_cpus);
 	}
 
-	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-	    || userfaultfd_events_test();
+	return userfaultfd_zeropage_test();
 }
 
 static void set_test_type(const char *type)
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index cba04608bdb0..94549696f4b2 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -18,6 +18,9 @@
 #define  MEM_HUGETLB                      BIT_ULL(3)
 #define  MEM_HUGETLB_PRIVATE              BIT_ULL(4)
 
+#define  MEM_ALL  (MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE | \
+		   MEM_HUGETLB | MEM_HUGETLB_PRIVATE)
+
 struct mem_type {
 	const char *name;
 	unsigned int mem_flag;
@@ -426,6 +429,237 @@ void uffd_minor_collapse_test(void)
 	uffd_minor_test_common(true, false);
 }
 
+static sigjmp_buf jbuf, *sigbuf;
+
+static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
+{
+	if (sig == SIGBUS) {
+		if (sigbuf)
+			siglongjmp(*sigbuf, 1);
+		abort();
+	}
+}
+
+/*
+ * For non-cooperative userfaultfd test we fork() a process that will
+ * generate pagefaults, will mremap the area monitored by the
+ * userfaultfd and at last this process will release the monitored
+ * area.
+ * For the anonymous and shared memory the area is divided into two
+ * parts, the first part is accessed before mremap, and the second
+ * part is accessed after mremap. Since hugetlbfs does not support
+ * mremap, the entire monitored area is accessed in a single pass for
+ * HUGETLB_TEST.
+ * The release of the pages currently generates event for shmem and
+ * anonymous memory (UFFD_EVENT_REMOVE), hence it is not checked
+ * for hugetlb.
+ * For signal test(UFFD_FEATURE_SIGBUS), signal_test = 1, we register
+ * monitored area, generate pagefaults and test that signal is delivered.
+ * Use UFFDIO_COPY to allocate missing page and retry. For signal_test = 2
+ * test robustness use case - we release monitored area, fork a process
+ * that will generate pagefaults and verify signal is generated.
+ * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
+ * feature. Using monitor thread, verify no userfault events are generated.
+ */
+static int faulting_process(int signal_test, bool wp)
+{
+	unsigned long nr, i;
+	unsigned long long count;
+	unsigned long split_nr_pages;
+	unsigned long lastnr;
+	struct sigaction act;
+	volatile unsigned long signalled = 0;
+
+	split_nr_pages = (nr_pages + 1) / 2;
+
+	if (signal_test) {
+		sigbuf = &jbuf;
+		memset(&act, 0, sizeof(act));
+		act.sa_sigaction = sighndl;
+		act.sa_flags = SA_SIGINFO;
+		if (sigaction(SIGBUS, &act, 0))
+			err("sigaction");
+		lastnr = (unsigned long)-1;
+	}
+
+	for (nr = 0; nr < split_nr_pages; nr++) {
+		volatile int steps = 1;
+		unsigned long offset = nr * page_size;
+
+		if (signal_test) {
+			if (sigsetjmp(*sigbuf, 1) != 0) {
+				if (steps == 1 && nr == lastnr)
+					err("Signal repeated");
+
+				lastnr = nr;
+				if (signal_test == 1) {
+					if (steps == 1) {
+						/* This is a MISSING request */
+						steps++;
+						if (copy_page(uffd, offset, wp))
+							signalled++;
+					} else {
+						/* This is a WP request */
+						assert(steps == 2);
+						wp_range(uffd,
+							 (__u64)area_dst +
+							 offset,
+							 page_size, false);
+					}
+				} else {
+					signalled++;
+					continue;
+				}
+			}
+		}
+
+		count = *area_count(area_dst, nr);
+		if (count != count_verify[nr])
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
+		/*
+		 * Trigger write protection if there is by writing
+		 * the same value back.
+		 */
+		*area_count(area_dst, nr) = count;
+	}
+
+	if (signal_test)
+		return signalled != split_nr_pages;
+
+	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
+	if (area_dst == MAP_FAILED)
+		err("mremap");
+	/* Reset area_src since we just clobbered it */
+	area_src = NULL;
+
+	for (; nr < nr_pages; nr++) {
+		count = *area_count(area_dst, nr);
+		if (count != count_verify[nr]) {
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
+		}
+		/*
+		 * Trigger write protection if there is by writing
+		 * the same value back.
+		 */
+		*area_count(area_dst, nr) = count;
+	}
+
+	uffd_test_ops->release_pages(area_dst);
+
+	for (nr = 0; nr < nr_pages; nr++)
+		for (i = 0; i < page_size; i++)
+			if (*(area_dst + nr * page_size + i) != 0)
+				err("page %lu offset %lu is not zero", nr, i);
+
+	return 0;
+}
+
+static void uffd_sigbus_test_common(bool wp)
+{
+	unsigned long userfaults;
+	pthread_t uffd_mon;
+	pid_t pid;
+	int err;
+	char c;
+	struct uffd_args args = { 0 };
+
+	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, wp, false))
+		err("register failure");
+
+	if (faulting_process(1, wp))
+		err("faulting process failed");
+
+	uffd_test_ops->release_pages(area_dst);
+
+	args.apply_wp = wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	pid = fork();
+	if (pid < 0)
+		err("fork");
+
+	if (!pid)
+		exit(faulting_process(2, wp));
+
+	waitpid(pid, &err, 0);
+	if (err)
+		err("faulting process failed");
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, (void **)&userfaults))
+		err("pthread_join()");
+
+	if (userfaults)
+		uffd_test_fail("Signal test failed, userfaults: %ld", userfaults);
+	else
+		uffd_test_pass();
+}
+
+static void uffd_sigbus_test(void)
+{
+	uffd_sigbus_test_common(false);
+}
+
+static void uffd_sigbus_wp_test(void)
+{
+	uffd_sigbus_test_common(true);
+}
+
+static void uffd_events_test_common(bool wp)
+{
+	pthread_t uffd_mon;
+	pid_t pid;
+	int err;
+	char c;
+	struct uffd_args args = { 0 };
+
+	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, wp, false))
+		err("register failure");
+
+	args.apply_wp = wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	pid = fork();
+	if (pid < 0)
+		err("fork");
+
+	if (!pid)
+		exit(faulting_process(0, wp));
+
+	waitpid(pid, &err, 0);
+	if (err)
+		err("faulting process failed");
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("pthread_join()");
+
+	if (args.missing_faults != nr_pages)
+		uffd_test_fail("Fault counts wrong");
+	else
+		uffd_test_pass();
+}
+
+static void uffd_events_test(void)
+{
+	uffd_events_test_common(false);
+}
+
+static void uffd_events_wp_test(void)
+{
+	uffd_events_test_common(true);
+}
+
 uffd_test_case_t uffd_tests[] = {
 	{
 		.name = "pagemap",
@@ -463,6 +697,36 @@ uffd_test_case_t uffd_tests[] = {
 		/* We can't test MADV_COLLAPSE, so try our luck */
 		.uffd_feature_required = UFFD_FEATURE_MINOR_SHMEM,
 	},
+	{
+		.name = "sigbus",
+		.uffd_fn = uffd_sigbus_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
+		UFFD_FEATURE_EVENT_FORK,
+	},
+	{
+		.name = "sigbus-wp",
+		.uffd_fn = uffd_sigbus_wp_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
+		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+	},
+	{
+		.name = "events",
+		.uffd_fn = uffd_events_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_EVENT_FORK |
+		UFFD_FEATURE_EVENT_REMAP | UFFD_FEATURE_EVENT_REMOVE,
+	},
+	{
+		.name = "events-wp",
+		.uffd_fn = uffd_events_wp_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_EVENT_FORK |
+		UFFD_FEATURE_EVENT_REMAP | UFFD_FEATURE_EVENT_REMOVE |
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
+	},
 };
 
 int main(int argc, char *argv[])
-- 
2.39.1

