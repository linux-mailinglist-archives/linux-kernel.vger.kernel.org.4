Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D6607C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiJUQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiJUQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22328C322
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36885d835e9so33784767b3.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgu86dTBraBMEbo7EYK3wnE2QExNEIbm0lf0S3p+RAM=;
        b=CDWV7vuGy8k4HSVoqHUUqHq4k/ljtoqD3xxO+wejMuxAHTGuNtdRUbXNgGj+V+78Zx
         oU99fdRPWJDzHYJJwVoaXcgYCaOBiPK/e2LKKQV+PqTKnIRDuYGoo28iGCk8HwJwicT7
         +Q6T6t9e35ieUG8SKhA6GWk9Yngm0X5rtw33d4A+66eY3fHNfiCumY+W+3EeR+pd+k2g
         EJ/M2S1Kfe/MJZEOuP4oko60RqTpq+UKJsdxFeoYbx/3dIB+RmMCT6+Z8zWR1IyMbdHb
         V6aR+BivHNTlLmnlyRdniwOEWMZQbRMfTL1+xWOhSK0EfGWdjiwxTjY0tFQre39sDFt5
         TSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgu86dTBraBMEbo7EYK3wnE2QExNEIbm0lf0S3p+RAM=;
        b=FE8f+/DLNgeMxhOm4kywgDYCK59xqRXV7LIlzgLHQq+puxTpbFJCGLEfJuq3/hXFVD
         ZVc+yF60X1jf4QDJI9m0J7rfjs4o21ccGDPaAl5m7j5X9jMkH4D1Hhe0K5NZYPsPhsEc
         Tcu8+CE9ltxMH4B3p0eaGQN20pnPJcs2KHPVcC97ZPKL+2wTtDeD7So51bddGxv49ols
         JguKKI72oRWh7PFbchZQXgn07c1Jyy4Rgn6qtaVeoCz5dBiI7Ykdv03gGIVGG8t779aC
         jHy09gWbbGlPueUOtyAipm6o3iYyuuxXHGkKECGi6m9VCmpTAc3zUdN2f8s6WgbiF5Wk
         tMrQ==
X-Gm-Message-State: ACrzQf38kB2MISoa3h2WraA0xTsJlKeYUe6NV6uUFAPW45cfRrw6Fcu/
        f3r7ShzvNSsBJbXFN2YSL0eEDjDTEmGiNIxE
X-Google-Smtp-Source: AMsMyM4PvTvrmhRgENKB7MFbK/ytPZdbawGZknlyGSBuoh8Jx8BOkToygX7N4aket6Bhv6WXDKkhj4XIOO1VetbE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:f448:0:b0:6ca:22e1:638c with SMTP
 id p8-20020a25f448000000b006ca22e1638cmr10364996ybe.252.1666370278696; Fri,
 21 Oct 2022 09:37:58 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:37:01 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-46-jthoughton@google.com>
Subject: [RFC PATCH v2 45/47] selftests/vm: add anon and shared hugetlb to
 migration test
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
---
 tools/testing/selftests/vm/migration.c | 83 ++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/migration.c b/tools/testing/selftests/vm/migration.c
index 1cec8425e3ca..21577a84d7e4 100644
--- a/tools/testing/selftests/vm/migration.c
+++ b/tools/testing/selftests/vm/migration.c
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
2.38.0.135.g90850a2211-goog

