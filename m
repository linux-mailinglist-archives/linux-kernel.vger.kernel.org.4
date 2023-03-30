Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D26D0ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjC3QKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjC3QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CDA25A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTM5xtnArxH9EHNqMOFW/9fpO7KeYtGodOd2BXmVLVI=;
        b=SDTLvsUcY7iVfkJHxCTyLiYbyRT6r8AIagBTkN0Sut/j65SmgY/+P9n9XhQ3EuB8C4aW1X
        1ekhhTH7RestBx+ZOlhT5XHO8BG2T+OnWEokvSrBDRuXl6WSjuKbueXSDV/+SBoYp+8D7E
        /7Mb3mqIIADJy4vJS2lDZUiL9/sOMYs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-XOZYRgdAMlqLt9gBC6VKvg-1; Thu, 30 Mar 2023 12:08:32 -0400
X-MC-Unique: XOZYRgdAMlqLt9gBC6VKvg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-746bae78af3so60183685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTM5xtnArxH9EHNqMOFW/9fpO7KeYtGodOd2BXmVLVI=;
        b=7qXZVxffRayvF1hD9yN5YGoUHcazYUjgKn2u1oe0jQqmUnxuvtvW4V0YwtDZTQqU36
         VO2dvG5nzBkolDa6UyQ4/YxPZbaWvhXxXN1NXpiePKLzNnP4sZta09DKg7jkRSOgWyeP
         GwDJ0o0BA1rbs/E/mpOAYZMCo05FjZwlflGG8nML71AGrIs0XXKn1dLV5rqpO35hD/Rm
         opaLFtqNwp9xqiDa2nEegttt9lKYZAe7yVjhod7McdoQ+03dl/iOIGbkpsVxyjXGAs3N
         D5+/t4VQqNIW/jU1KVUGW7KPDk65EWMoCipUftC+8A70VAhZaOwxksNscC89vC/C5ss7
         p5lQ==
X-Gm-Message-State: AAQBX9c3QEMmzSRyNGhtcdr25EGyxY35l7ajlCfzuLiCF/BrDbBjC1lc
        NXRsokApu0DhfhV2k3L2+Fqugkn9qDn18YoEhtD22XWMrdweaFMDuUMSwFnXEwMNjsS8suG4gm1
        wn8spP0tHDNX4j7vIPlOtHdnoGL+nZK0F/Hdrt1gXNuE+qnywjvTG2vC3HPUDAchIcExr2KX+hI
        N/M02gTA==
X-Received: by 2002:a05:622a:1aa1:b0:3e3:8e1a:c30b with SMTP id s33-20020a05622a1aa100b003e38e1ac30bmr4584678qtc.1.1680192510217;
        Thu, 30 Mar 2023 09:08:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350avriHt3XCOjyRNwFhAa+6n3UwABlp02KxPIJQDVusPVqqtc5AFGtAyQG20QSUpJkKO74s2mA==
X-Received: by 2002:a05:622a:1aa1:b0:3e3:8e1a:c30b with SMTP id s33-20020a05622a1aa100b003e38e1ac30bmr4584621qtc.1.1680192509724;
        Thu, 30 Mar 2023 09:08:29 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id n14-20020ac8674e000000b003d65e257f10sm8616359qtp.79.2023.03.30.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:29 -0700 (PDT)
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
Subject: [PATCH 24/29] selftests/mm: Move uffd sig/events tests into uffd unit tests
Date:   Thu, 30 Mar 2023 12:08:27 -0400
Message-Id: <20230330160827.3107580-1-peterx@redhat.com>
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
 tools/testing/selftests/mm/uffd-unit-tests.c | 263 +++++++++++++++++++
 2 files changed, 264 insertions(+), 226 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 49fa61e5c54a..f3046ae13a90 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -274,133 +274,6 @@ static int stress(struct uffd_stats *uffd_stats)
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
@@ -484,103 +357,6 @@ static int userfaultfd_zeropage_test(void)
 	return 0;
 }
 
-static int userfaultfd_events_test(void)
-{
-	pthread_t uffd_mon;
-	int err, features;
-	pid_t pid;
-	char c;
-	struct uffd_stats stats = { 0 };
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
-	stats.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
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
-	uffd_stats_report(&stats, 1);
-
-	return stats.missing_faults != nr_pages;
-}
-
-static int userfaultfd_sig_test(void)
-{
-	unsigned long userfaults;
-	pthread_t uffd_mon;
-	int err, features;
-	pid_t pid;
-	char c;
-	struct uffd_stats stats = { 0 };
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
-	stats.apply_wp = test_uffdio_wp;
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
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
@@ -692,8 +468,7 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-	    || userfaultfd_events_test();
+	return userfaultfd_zeropage_test();
 }
 
 static void set_test_type(const char *type)
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index ecb8ba658736..ebf45cb0eca8 100644
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
@@ -429,6 +432,237 @@ void uffd_minor_collapse_test(void)
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
+	struct uffd_stats stats = { 0 };
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
+	stats.apply_wp = wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &stats))
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
+	struct uffd_stats stats = { 0 };
+
+	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, wp, false))
+		err("register failure");
+
+	stats.apply_wp = wp;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &stats))
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
+	if (stats.missing_faults != nr_pages)
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
@@ -466,6 +700,35 @@ uffd_test_case_t uffd_tests[] = {
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
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+	},
 };
 
 int main(int argc, char *argv[])
-- 
2.39.1

