Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7F65E8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjAEKXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjAEKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72550E6B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:20:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v9-20020a259d89000000b007b515f139e0so1270719ybp.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtdl4oKQo+XEbgxtU4YTxEZN3Xtv3pieSBor01lKxpM=;
        b=JoK7U3yUK3xMp7jj3ED65QQRxyxFdtP2VVXxjeaagA1yOQ1VDOWmerpsJ93SBkq9zh
         1+sCrcsTNTUzGHfBCN3DVG0Ub0PaSUoyZmam0r/dYWFPfLKvvL3DvvjbWnpAFCJmqtmQ
         9dL77taavQp85y0beQ4G5rqDpS08FPS6eH96z44yL0EIzphbGcRadmhuAWN3kkhTwcyi
         Z6tLvspR8aGzxFL9AdtTmhEJWc3alCOwAyuQe0Fe4aSztOMMuenUMqwRmV5J/FhoFHxX
         pOzfJfehMxt0Fd8Q97JtyGiSLNhamOIcoa298fqunC0dT5N8onLPpGnxOJexx6VIdt++
         pOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtdl4oKQo+XEbgxtU4YTxEZN3Xtv3pieSBor01lKxpM=;
        b=CKFsRSYXjKk7ZMF12qnZxr7w33qTpLv3YyMsd+ttfA9/6lNamU/cHR2u4eQNW2atDT
         eq8kY6+gfP/hhlN8NkOVnomIDseZWIzR03CjuDwDeECo/Zo20zEnYuMD4Vn8EVHlgIlC
         RuRoC0eLmea8m4XBFOt7ls8Y3dy7/L/eV02lBSyaK32OTuA96wLg4SEYYVvHKA41MLb3
         /0IoD+naU3H7gE+ImDzjCCNllNXwEg0vxjxzaTfWaNa+ZyrcbA9n8RU8QXfdCcEX7C/4
         QJeBYm7+mFHS7RlSB0e7iOWqH97I0nLS5PEZleSQSoDexz/+mo9wCIL/2qVtvmdMDgXX
         BaYA==
X-Gm-Message-State: AFqh2krwlXrxhChOjLQnbnAJsyVPsnLqdv/pHXy5zvnAzeika3tnCUF6
        VPiIoIOGYVvyizFLF+Fk475yOpMpulcy8Uh1
X-Google-Smtp-Source: AMrXdXv5OilDl2+kIyWuY+cCyv/mwU3aGk8FszvI2rVdH9/dLOCIgt0mfQQiMmbp6/zudM0adl4O7gCLJPTvbpXO
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:8149:0:b0:7b6:5baa:c97c with SMTP
 id j9-20020a258149000000b007b65baac97cmr13349ybm.515.1672914001263; Thu, 05
 Jan 2023 02:20:01 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:43 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-46-jthoughton@google.com>
Subject: [PATCH 45/46] selftests/vm: add hugetlb HGM test to migration selftest
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

This is mostly the same as the shared HugeTLB case, but instead of
mapping the page with a regular page fault, we map it with lots of
UFFDIO_CONTINUE operations. We also verify that the contents haven't
changed after the migration, which would be the case if the
post-migration PTEs pointed to the wrong page.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/vm/migration.c | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/vm/migration.c b/tools/testing/selftests/vm/migration.c
index 21577a84d7e4..1fb3607accab 100644
--- a/tools/testing/selftests/vm/migration.c
+++ b/tools/testing/selftests/vm/migration.c
@@ -14,12 +14,21 @@
 #include <signal.h>
 #include <time.h>
 #include <sys/statfs.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+#include <sys/syscall.h>
+#include <fcntl.h>
 
 #define TWOMEG (2<<20)
 #define RUNTIME (60)
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
 
+#ifndef MADV_SPLIT
+#define MADV_SPLIT 26
+#endif
+
 FIXTURE(migration)
 {
 	pthread_t *threads;
@@ -265,4 +274,141 @@ TEST_F_TIMEOUT(migration, shared_hugetlb, 2*RUNTIME)
 	close(fd);
 }
 
+#ifdef __NR_userfaultfd
+static int map_at_high_granularity(char *mem, size_t length)
+{
+	int i;
+	int ret;
+	int uffd = syscall(__NR_userfaultfd, 0);
+	struct uffdio_api api;
+	struct uffdio_register reg;
+	int pagesize = getpagesize();
+
+	if (uffd < 0) {
+		perror("couldn't create uffd");
+		return uffd;
+	}
+
+	api.api = UFFD_API;
+	api.features = 0;
+
+	ret = ioctl(uffd, UFFDIO_API, &api);
+	if (ret || api.api != UFFD_API) {
+		perror("UFFDIO_API failed");
+		goto out;
+	}
+
+	if (madvise(mem, length, MADV_SPLIT) == -1) {
+		perror("MADV_SPLIT failed");
+		goto out;
+	}
+
+	reg.range.start = (unsigned long)mem;
+	reg.range.len = length;
+
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_MINOR;
+
+	ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
+	if (ret) {
+		perror("UFFDIO_REGISTER failed");
+		goto out;
+	}
+
+	/* UFFDIO_CONTINUE each 4K segment of the 2M page. */
+	for (i = 0; i < length/pagesize; ++i) {
+		struct uffdio_continue cont;
+
+		cont.range.start = (unsigned long long)mem + i * pagesize;
+		cont.range.len = pagesize;
+		cont.mode = 0;
+		ret = ioctl(uffd, UFFDIO_CONTINUE, &cont);
+		if (ret) {
+			fprintf(stderr, "UFFDIO_CONTINUE failed "
+					"for %llx -> %llx: %d\n",
+					cont.range.start,
+					cont.range.start + cont.range.len,
+					errno);
+			goto out;
+		}
+	}
+	ret = 0;
+out:
+	close(uffd);
+	return ret;
+}
+#else
+static int map_at_high_granularity(char *mem, size_t length)
+{
+	fprintf(stderr, "Userfaultfd missing\n");
+	return -1;
+}
+#endif /* __NR_userfaultfd */
+
+/*
+ * Tests the high-granularity hugetlb migration entry paths.
+ */
+TEST_F_TIMEOUT(migration, shared_hugetlb_hgm, 2*RUNTIME)
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
+
+	if (fallocate(fd, 0, 0, sz) < 0) {
+		perror("fallocate failed");
+		SKIP(return, "fallocate failed");
+	}
+
+	ptr = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED)
+		SKIP(return, "Could not allocate hugetlb pages");
+
+	/*
+	 * We have to map_at_high_granularity before we memset, otherwise
+	 * memset will map everything at the hugepage size.
+	 */
+	if (map_at_high_granularity((char *)ptr, sz) < 0)
+		SKIP(return, "Could not map HugeTLB range at high granularity");
+
+	/* Populate the page we're migrating. */
+	for (i = 0; i < sz/sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2, 10), 0);
+	for (i = 0; i < self->nthreads - 1; i++) {
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+		pthread_join(self->threads[i], NULL);
+	}
+
+	/* Check that the contents didnt' change. */
+	for (i = 0; i < sz/sizeof(*ptr); ++i) {
+		ASSERT_EQ(ptr[i], i);
+		if (ptr[i] != i)
+			break;
+	}
+
+	ftruncate(fd, 0);
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.39.0.314.g84b9a713c41-goog

