Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1D6D0ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjC3QKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjC3QJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCF9ED8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NTrS8mJzWPEnPLBWSlseOL+7dIWq0u/3um5fPzddJ8=;
        b=h/pX68xsoKsLbvBW2mDDwXoxhajDw3NdLkny3v8Oiq4+0aw05EvqBhf3HpUWwyPX1rFGH5
        Z/zjEQAwKq2KkoSBNLpMwL4PhosXEmB5xG7TAWAytUNt8A6FtAkIMphnFpw7wDNCwKJBlp
        UT2i09IZM3zzez32gQro4BIZqcI4Yio=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-m-5B07egPu-qhKeUh8Impw-1; Thu, 30 Mar 2023 12:08:17 -0400
X-MC-Unique: m-5B07egPu-qhKeUh8Impw-1
Received: by mail-qv1-f70.google.com with SMTP id f8-20020a0cbec8000000b005b14a30945cso8446157qvj.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192496; x=1682784496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NTrS8mJzWPEnPLBWSlseOL+7dIWq0u/3um5fPzddJ8=;
        b=ItB8rOB+aCDO7GftPppSmfbQKg5HAN319gWXJ1wOCOVyBKxZnyAfuFG1mjuE7NB+br
         yv0/E0zEto5LXTiH1EmQLO1yNAk4Jrv9/0P53wvRzSyfHChjTDzBzvoWo0M100ylmr5W
         32TQCt5SHsRVFIqjKRWgL7SRioKUikA8LtqeQc+AG3Lhqn2uHMM7s//tkhxGg9NSzSmO
         aYKmSfnDRzb6iM4keda3zeLAw2vOLzavwsa0r2U/aUKRNT8Tgp4wdk+wZqepjsjjR0aa
         v1goAUDE2mlRZoB6hVMyKAdev3LVqzinzD22pX1ekxPEoVd0m/siruJ1BC44MhaUwE8M
         DwPw==
X-Gm-Message-State: AO0yUKXmwhD2EK4HEei9hUBclYRmBBvZIRQkrLdG3azT6+WtIImocI/A
        e9p9HvxcJgdoxU6HgM67+7u2/EOvXy4M1WDBL7Y79k1wktO+xiLtCUY6DAxbku04IxEwHVtn1yd
        GbP78UCTzxXPYJj2/SUlolETXOUBijxgriOTau5DjD4FpRbtb3h659T9SCKCSGumA4WADs67gBF
        GpoqUe+Q==
X-Received: by 2002:a05:622a:3c9:b0:3b8:36f8:830e with SMTP id k9-20020a05622a03c900b003b836f8830emr37733733qtx.6.1680192496042;
        Thu, 30 Mar 2023 09:08:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set+xWLH8y6GmL2ENvwzVmLLUlI8WPGbRuYB5jyqQ/eNHJax24mqyfmVMDw61Ei3HBM8optw/0w==
X-Received: by 2002:a05:622a:3c9:b0:3b8:36f8:830e with SMTP id k9-20020a05622a03c900b003b836f8830emr37733689qtx.6.1680192495676;
        Thu, 30 Mar 2023 09:08:15 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b007486052d731sm4247503qkb.10.2023.03.30.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:15 -0700 (PDT)
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
Subject: [PATCH 19/29] selftests/mm: Let uffd_handle_page_fault() takes wp parameter
Date:   Thu, 30 Mar 2023 12:08:12 -0400
Message-Id: <20230330160812.3107522-1-peterx@redhat.com>
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

Make the handler optionally apply WP bit when resolving page faults for
either missing or minor page faults.  This move towards removing global
test_uffdio_wp outside of the common code.

For this, slightly abuse uffd_stats to keep one more parameter on whether
we'd like to resolve page faults with WP bit set.  Note that only the name
is abused, it'll be better to be called uffd_args or similar but let's not
bother for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 17 +++++++++--------
 tools/testing/selftests/mm/uffd-common.h |  6 ++++--
 tools/testing/selftests/mm/uffd-stress.c | 16 ++++++++++------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 025e40ffc7bf..92b7e00efa8a 100644
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
@@ -429,7 +429,8 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
 				    area_dst_alias));
 		for (b = 0; b < page_size; ++b)
 			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size);
+		continue_range(uffd, msg->arg.pagefault.address, page_size,
+			       stats->apply_wp);
 		stats->minor_faults++;
 	} else {
 		/*
@@ -459,7 +460,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
 		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 		offset &= ~(page_size-1);
 
-		if (copy_page(uffd, offset))
+		if (copy_page(uffd, offset, stats->apply_wp))
 			stats->missing_faults++;
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
@@ -587,8 +588,8 @@ int __copy_page(int ufd, unsigned long offset, bool retry)
 	return 0;
 }
 
-int copy_page(int ufd, unsigned long offset)
+int copy_page(int ufd, unsigned long offset, bool wp)
 {
-	return __copy_page(ufd, offset, false);
+	return __copy_page(ufd, offset, false, wp);
 }
 
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 47565b2f2dee..f4bc73ce3b48 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -72,6 +72,8 @@
 /* Userfaultfd test statistics */
 struct uffd_stats {
 	int cpu;
+	/* Whether apply wr-protects when installing pages */
+	bool apply_wp;
 	unsigned long missing_faults;
 	unsigned long wp_faults;
 	unsigned long minor_faults;
@@ -104,8 +106,8 @@ void userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
-int __copy_page(int ufd, unsigned long offset, bool retry);
-int copy_page(int ufd, unsigned long offset);
+int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
+int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
 
 #define TEST_ANON	1
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 54fc9b4ffa3c..70cb0619354e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -97,6 +97,7 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 
 	for (i = 0; i < n_cpus; i++) {
 		uffd_stats[i].cpu = i;
+		uffd_stats[i].apply_wp = test_uffdio_wp;
 		uffd_stats[i].missing_faults = 0;
 		uffd_stats[i].wp_faults = 0;
 		uffd_stats[i].minor_faults = 0;
@@ -156,7 +157,7 @@ static void *locking_thread(void *arg)
 
 static int copy_page_retry(int ufd, unsigned long offset)
 {
-	return __copy_page(ufd, offset, true);
+	return __copy_page(ufd, offset, true, test_uffdio_wp);
 }
 
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -309,7 +310,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
  * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
  * feature. Using monitor thread, verify no userfault events are generated.
  */
-static int faulting_process(int signal_test)
+static int faulting_process(int signal_test, bool wp)
 {
 	unsigned long nr;
 	unsigned long long count;
@@ -344,7 +345,7 @@ static int faulting_process(int signal_test)
 					if (steps == 1) {
 						/* This is a MISSING request */
 						steps++;
-						if (copy_page(uffd, offset))
+						if (copy_page(uffd, offset, wp))
 							signalled++;
 					} else {
 						/* This is a WP request */
@@ -508,6 +509,7 @@ static int userfaultfd_events_test(void)
 			  true, test_uffdio_wp, false))
 		err("register failure");
 
+	stats.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
 
@@ -516,7 +518,7 @@ static int userfaultfd_events_test(void)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(0));
+		exit(faulting_process(0, test_uffdio_wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
@@ -552,11 +554,12 @@ static int userfaultfd_sig_test(void)
 			  true, test_uffdio_wp, false))
 		err("register failure");
 
-	if (faulting_process(1))
+	if (faulting_process(1, test_uffdio_wp))
 		err("faulting process failed");
 
 	uffd_test_ops->release_pages(area_dst);
 
+	stats.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
 
@@ -565,7 +568,7 @@ static int userfaultfd_sig_test(void)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(2));
+		exit(faulting_process(2, test_uffdio_wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
@@ -629,6 +632,7 @@ static int userfaultfd_minor_test(void)
 		       page_size);
 	}
 
+	stats.apply_wp = test_uffdio_wp;
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
 
-- 
2.39.1

