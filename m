Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBE46DFBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjDLQp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjDLQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDC86B5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BeK25Zk7G/NLwTDOVvJddw9Gyk0/O/quMsTWu17keu8=;
        b=XThYpklB4bklmMInCgZIjFHqgHf737RL0Gw2udByEypz4t8T7Frgv/4Mz7lyWNHO1yyemj
        xR0shRsmVAhDLWSzbMwFLnddnQDJHGiosBQgFhieRipGvb8u86NO61/26xVh+pA0lp8qCO
        DjQfcaW9+XOY8tARAlL4IAzF9Xy0NS8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-7gir-xTMNLGQbhjdwHwwFQ-1; Wed, 12 Apr 2023 12:43:47 -0400
X-MC-Unique: 7gir-xTMNLGQbhjdwHwwFQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3e699015faeso3544121cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317825; x=1683909825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeK25Zk7G/NLwTDOVvJddw9Gyk0/O/quMsTWu17keu8=;
        b=hkziREXSODP7lIrvTNVcw9PM+HJ/JMQWyehUT3u+mR412MvY+I4c9gcjkdRUXK/3Fl
         UXAIVMSPNWqU/quxzIlX3W4/I/3kLbg3CcdUptPod9SeWzL/jiyWm2Ri7a6z1YvwIOSq
         g2VljJydAD5EQD/1XtT2jnOVJQr+mu0V+IyFA3jyFHqoDf9oAkOuoKImZBXOLP3Wqh0L
         mKwOPDGes5jm0q9NsW1CXYOVsk3Y1VEeWysalgO19cwDu79CDt8iqPepHJC+QseV4fqd
         jz3ko+z8DmOdcSIfZa1m+MW5ftGhr2+dzKOf7PQjU4bXhEqiXc/GnNk6VUbvg3O9HyX1
         4EBw==
X-Gm-Message-State: AAQBX9ekRjlkiPHR8z4STOiiedRtaF9W57WZu+JmsYRUrrj2H+wTsawe
        aBYaFIT+Ags16BVZ9l8Kn7zOVK14qLkpfMenPBnn8CVfS/yh+IdHPMY9k1dwxV3HQkbV1T26oVM
        qcWfHRSotBzK+/JrxhtwJpApBskh+hk8D/eNMAJuXYVbapGenxCqsPORv9vXWxccucH44Jp+gng
        phnj7OGQ==
X-Received: by 2002:a05:622a:1891:b0:3e4:eb39:eb8b with SMTP id v17-20020a05622a189100b003e4eb39eb8bmr4000953qtc.5.1681317825559;
        Wed, 12 Apr 2023 09:43:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yl7mWL/S9YEy9zUWOoxCG4PHHcn5sGAnl7GyY2m0LveJWRNpcSER8LkzrTOjY9Kd6J0F5tgw==
X-Received: by 2002:a05:622a:1891:b0:3e4:eb39:eb8b with SMTP id v17-20020a05622a189100b003e4eb39eb8bmr4000915qtc.5.1681317825147;
        Wed, 12 Apr 2023 09:43:45 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id i18-20020ac860d2000000b003e45a39ed74sm4353141qtm.81.2023.04.12.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:44 -0700 (PDT)
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
Subject: [PATCH v2 20/31] selftests/mm: Let uffd_handle_page_fault() take wp parameter
Date:   Wed, 12 Apr 2023 12:43:41 -0400
Message-Id: <20230412164341.328618-1-peterx@redhat.com>
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

Make the handler optionally apply WP bit when resolving page faults for
either missing or minor page faults.  This moves towards removing global
test_uffdio_wp outside of the common code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 17 +++++++++--------
 tools/testing/selftests/mm/uffd-common.h |  6 ++++--
 tools/testing/selftests/mm/uffd-stress.c | 16 ++++++++++------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index e746405aa8f3..daa2a95408e6 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -353,7 +353,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
 }
 
-static void continue_range(int ufd, __u64 start, __u64 len)
+static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
 {
 	struct uffdio_continue req;
 	int ret;
@@ -361,7 +361,7 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	req.range.start = start;
 	req.range.len = len;
 	req.mode = 0;
-	if (test_uffdio_wp)
+	if (wp)
 		req.mode |= UFFDIO_CONTINUE_MODE_WP;
 
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
@@ -429,7 +429,8 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 				    area_dst_alias));
 		for (b = 0; b < page_size; ++b)
 			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size);
+		continue_range(uffd, msg->arg.pagefault.address, page_size,
+			       args->apply_wp);
 		args->minor_faults++;
 	} else {
 		/*
@@ -459,7 +460,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 		offset &= ~(page_size-1);
 
-		if (copy_page(uffd, offset))
+		if (copy_page(uffd, offset, args->apply_wp))
 			args->missing_faults++;
 	}
 }
@@ -555,7 +556,7 @@ static void wake_range(int ufd, unsigned long addr, unsigned long len)
 			addr), exit(1);
 }
 
-int __copy_page(int ufd, unsigned long offset, bool retry)
+int __copy_page(int ufd, unsigned long offset, bool retry, bool wp)
 {
 	struct uffdio_copy uffdio_copy;
 
@@ -564,7 +565,7 @@ int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.dst = (unsigned long) area_dst + offset;
 	uffdio_copy.src = (unsigned long) area_src + offset;
 	uffdio_copy.len = page_size;
-	if (test_uffdio_wp)
+	if (wp)
 		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
 	else
 		uffdio_copy.mode = 0;
@@ -587,7 +588,7 @@ int __copy_page(int ufd, unsigned long offset, bool retry)
 	return 0;
 }
 
-int copy_page(int ufd, unsigned long offset)
+int copy_page(int ufd, unsigned long offset, bool wp)
 {
-	return __copy_page(ufd, offset, false);
+	return __copy_page(ufd, offset, false, wp);
 }
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index f8d2ad178827..0ec07d025cfe 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -72,6 +72,8 @@
 /* Userfaultfd test statistics */
 struct uffd_args {
 	int cpu;
+	/* Whether apply wr-protects when installing pages */
+	bool apply_wp;
 	unsigned long missing_faults;
 	unsigned long wp_faults;
 	unsigned long minor_faults;
@@ -104,8 +106,8 @@ void userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
-int __copy_page(int ufd, unsigned long offset, bool retry);
-int copy_page(int ufd, unsigned long offset);
+int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
+int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
 
 #define TEST_ANON	1
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ce7251ab93ef..747d588c0d69 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -96,6 +96,7 @@ static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
 
 	for (i = 0; i < n_cpus; i++) {
 		args[i].cpu = i;
+		args[i].apply_wp = test_uffdio_wp;
 		args[i].missing_faults = 0;
 		args[i].wp_faults = 0;
 		args[i].minor_faults = 0;
@@ -155,7 +156,7 @@ static void *locking_thread(void *arg)
 
 static int copy_page_retry(int ufd, unsigned long offset)
 {
-	return __copy_page(ufd, offset, true);
+	return __copy_page(ufd, offset, true, test_uffdio_wp);
 }
 
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -308,7 +309,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
  * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
  * feature. Using monitor thread, verify no userfault events are generated.
  */
-static int faulting_process(int signal_test)
+static int faulting_process(int signal_test, bool wp)
 {
 	unsigned long nr;
 	unsigned long long count;
@@ -343,7 +344,7 @@ static int faulting_process(int signal_test)
 					if (steps == 1) {
 						/* This is a MISSING request */
 						steps++;
-						if (copy_page(uffd, offset))
+						if (copy_page(uffd, offset, wp))
 							signalled++;
 					} else {
 						/* This is a WP request */
@@ -507,6 +508,7 @@ static int userfaultfd_events_test(void)
 			  true, test_uffdio_wp, false))
 		err("register failure");
 
+	args.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
@@ -515,7 +517,7 @@ static int userfaultfd_events_test(void)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(0));
+		exit(faulting_process(0, test_uffdio_wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
@@ -551,11 +553,12 @@ static int userfaultfd_sig_test(void)
 			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	if (faulting_process(1))
+	if (faulting_process(1, test_uffdio_wp))
 		err("faulting process failed");
 
 	uffd_test_ops->release_pages(area_dst);
 
+	args.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
@@ -564,7 +567,7 @@ static int userfaultfd_sig_test(void)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(2));
+		exit(faulting_process(2, test_uffdio_wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
@@ -628,6 +631,7 @@ static int userfaultfd_minor_test(void)
 		       page_size);
 	}
 
+	args.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-- 
2.39.1

