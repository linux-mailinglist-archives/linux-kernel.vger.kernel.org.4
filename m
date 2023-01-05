Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56265E8F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjAEKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjAEKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED14D485
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4700580ca98so305719667b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPcVmryUH+86L7TuxpN8GfuTRNIB++IYGz7ii/fh+60=;
        b=kI4ZTRQe7Q0DNwU8Nd2EZKZhgCILp8F6DoLJQBQIeMmVpBPgy2nY9fRh+7WBj3mKcv
         b3mHhtPqHKj27maMD9zcK0xNFg7ZH3P+7Zrl4zxFnCf7G/kUV7ygs9iJH6H3DPnwY+7v
         pEVpy5jqUM6S9+jlWu94uWgwsLLyquWN42I/U3Mye5rfAyPIaLO+CcmOU47oPaODXHBZ
         g6tTWmWkSREPHJl4j7JvfcfZmIeSW+FeLQ5bKfcMOb/+OzwicxRoFD6mPiFPk365Ae1D
         C7W9a4QJVUB1YYOH+GqrZqYY061aZQSPOGcDY51qN61zXe8gTbgIaiQswond5R+j607U
         +9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPcVmryUH+86L7TuxpN8GfuTRNIB++IYGz7ii/fh+60=;
        b=D4ESXZZPo+2MM7GUKFmn7uhMcesL4FpJMI+Rl/yTjt6bjW01QUEs8yP4Pmxj7+ibgE
         ctvO1hyZn3+jCgG6cOMG8/he08vZHnXyLqVXWin6GjkIkQ3aextsKHx+xP/ElIzmq7C7
         7eU0pAw3HPqu5WDHibAcOAcKsnxGWiNrDYwrXYJxtSuZr0cRiWMYIOQ+dcFFUe0EwRAo
         QXrB+xlzfo7BMGsnmgy0WrypFA7xBf0KGys/jv5hoXTVTNNgNu+PmH0i/cBWFgI4e9ts
         7Q9OaFexB7fNwHKCCyn5zh9bTGsr2b189kIPm/BjJdwYY5J9l7OkkL074OC1KH5cXzEQ
         luVA==
X-Gm-Message-State: AFqh2kq0kzu9wEJeoQGPvdmGlRY/PnKmdSocdwoGbTtr5B7v9I8bHO0W
        B5E3wrYbhNtzzXm/LXjDLwXXPK93N8zY4D1d
X-Google-Smtp-Source: AMrXdXtTdSV2u8sC9W2WJTx+X9U5bRZRCXSHwwKpc/aZe4u4qkoBDtjjb5Moax2r1vBZGfpJQ/5EU4hKV8ZnomEr
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:7c81:0:b0:727:e539:452f with SMTP
 id x123-20020a257c81000000b00727e539452fmr5333597ybc.552.1672913999168; Thu,
 05 Jan 2023 02:19:59 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:42 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-45-jthoughton@google.com>
Subject: [PATCH 44/46] selftests/vm: add anon and shared hugetlb to migration test
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
2.39.0.314.g84b9a713c41-goog

