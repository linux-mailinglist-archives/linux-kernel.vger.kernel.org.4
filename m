Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDD69B6D9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBRAcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjBRAb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:31:59 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CB6EBA3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53659b9818dso20142317b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyOLv1FsgINJ0DL+GVviZenHuSxZX0xiNJERAdFTwJY=;
        b=CawVGssLxbR/eBsnpR76uSOwVJlkmsmCv0a5oroE0FUoq5CLC5qHPXGXefy+nfOAyq
         vHPyCbLQuykbScgNRy8G6ArFuhS2PA24tAoAR0gKyBhUDTykhHwShI6arftzkplVbyyk
         b4WDZ3892nTCDc681eGtskse+KIsH+dqtfTG2Vne6aDgRhNRdxfjHtbN/sR4SQs6gHc0
         qUEwaDcngWDaQt95+PjWHSmLfyKw65IbdY5tMd2l4nt3+4TnGgT5wI1VLYvFO5GyJcwD
         HDiIQ3YFBSVkmnMVLHQ4cyRGkHdEevZ48y3mNmJQPrsPUHrSdwcp+QpVtufpdBI9D2OH
         id0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyOLv1FsgINJ0DL+GVviZenHuSxZX0xiNJERAdFTwJY=;
        b=xw41vqJJWN4lrBYOs2cIIcNvUKe2MA7KDvGo6Mm1y1ACe+TrkjuiBC7v4CX6nQdmVC
         UrIj+dKaHseR6QC141WSiVoaYFnRTJgmVX/Zs6pQTkglq6PEDuf5Q1emoxMIeC6k7/q6
         EZaQqSi7UqqR5p+bNU5xYqN9IM06UIv90HpOqNcV+HKkD5wQOZ18HLmDgJs6Jr1hcjt/
         BGKOpAx4GReqAmvXjh5oRcqfFJm0OreUo8P3T9u3RyBvmfg8lQimSBvjiLprY39PM0jh
         +kELcCExAybInH2/CEtW4mWOoSMXEkyEdwLnftFzCw7pP2yabL5UmhyaFScYz8BIHmAQ
         3RBg==
X-Gm-Message-State: AO0yUKXaak9bUALie6YOEEGSZt4pWJFBbP5WN1RHpJmGhYAkHx9kWX/N
        DkqagcKkL0rFSTIGBPgnh1AT8+3aPym9J6EB
X-Google-Smtp-Source: AK7set+1gp+3xzyRWa+pkBelE3wO17FQrBJLukvYGoDbOlAPndL6HG5Z6zOqFqMyhLaMuLWmUDnySY104VSUsagh
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:4f0:b0:98e:6280:74ca with SMTP
 id w16-20020a05690204f000b0098e628074camr174263ybs.1.1676680184745; Fri, 17
 Feb 2023 16:29:44 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:17 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-45-jthoughton@google.com>
Subject: [PATCH v2 44/46] selftests/mm: add anon and shared hugetlb to
 migration test
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared HugeTLB mappings are migrated best-effort. Sometimes, due to
being unable to grab the VMA lock for writing, migration may just
randomly fail. To allow for that, we allow retries.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1cec8425e3ca..21577a84d7e4 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -13,6 +13,7 @@
 #include <sys/types.h>
 #include <signal.h>
 #include <time.h>
+#include <sys/statfs.h>
 
 #define TWOMEG (2<<20)
 #define RUNTIME (60)
@@ -59,11 +60,12 @@ FIXTURE_TEARDOWN(migration)
 	free(self->pids);
 }
 
-int migrate(uint64_t *ptr, int n1, int n2)
+int migrate(uint64_t *ptr, int n1, int n2, int retries)
 {
 	int ret, tmp;
 	int status = 0;
 	struct timespec ts1, ts2;
+	int failed = 0;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
 		return -1;
@@ -78,6 +80,9 @@ int migrate(uint64_t *ptr, int n1, int n2)
 		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
 				MPOL_MF_MOVE_ALL);
 		if (ret) {
+			if (++failed < retries)
+				continue;
+
 			if (ret > 0)
 				printf("Didn't migrate %d pages\n", ret);
 			else
@@ -88,6 +93,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
 		tmp = n2;
 		n2 = n1;
 		n1 = tmp;
+		failed = 0;
 	}
 
 	return 0;
@@ -128,7 +134,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
 		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
 			perror("Couldn't create thread");
 
-	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 1), 0);
 	for (i = 0; i < self->nthreads - 1; i++)
 		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
 }
@@ -158,7 +164,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
 			self->pids[i] = pid;
 	}
 
-	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 1), 0);
 	for (i = 0; i < self->nthreads - 1; i++)
 		ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
 }
@@ -185,9 +191,78 @@ TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
 		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
 			perror("Couldn't create thread");
 
-	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 1), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+}
+
+/*
+ * Tests the anon hugetlb migration entry paths.
+ */
+TEST_F_TIMEOUT(migration, private_anon_hugetlb, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (ptr == MAP_FAILED)
+		SKIP(return, "Could not allocate hugetlb pages");
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 1), 0);
 	for (i = 0; i < self->nthreads - 1; i++)
 		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
 }
 
+/*
+ * Tests the shared hugetlb migration entry paths.
+ */
+TEST_F_TIMEOUT(migration, shared_hugetlb, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	int i;
+	int fd;
+	unsigned long sz;
+	struct statfs filestat;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	fd = memfd_create("tmp_hugetlb", MFD_HUGETLB);
+	if (fd < 0)
+		SKIP(return, "Couldn't create hugetlb memfd");
+
+	if (fstatfs(fd, &filestat) < 0)
+		SKIP(return, "Couldn't fstatfs hugetlb file");
+
+	sz = filestat.f_bsize;
+
+	if (ftruncate(fd, sz))
+		SKIP(return, "Couldn't allocate hugetlb pages");
+	ptr = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED)
+		SKIP(return, "Could not map hugetlb pages");
+
+	memset(ptr, 0xde, sz);
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 10), 0);
+	for (i = 0; i < self->nthreads - 1; i++) {
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+		pthread_join(self->threads[i], NULL);
+	}
+	ftruncate(fd, 0);
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.39.2.637.g21b0678d19-goog

