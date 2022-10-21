Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D15607C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJUQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiJUQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07C28B19B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so3731874ybj.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIQEWHlSLo/XkVLbilcDDKMbq3Gd3wcTC7FKcNbq2ok=;
        b=kwDsO1K2E/Ygmg/+9L0K1r1iIEM7XdI2MkqQcBsRmTHXB24iYmGgzQlcuEW2FKjX7m
         plhMEQJHzYM8g9ACG97HJE8ZCRQlE3FdOGdPSeXGWAUONWB42bOUJIthA2+V8zHKec/m
         fC6Mz0RKHc+cbwkbZjPlGqO5Uqz3GxoAe2WPWIrxxuon+8lLDyi8pd/A3tEgkPonOJa4
         QGdAVkjCxEDMcQL2niAH/NOQhDCN8KVl0p+89L9GZ9Hl7RKE4T/WVn9sk/Y8tmIFdKCL
         iWCcUBvK1VCBpMt5bjp85RIt+A5+KMo4rALu1oLpUelOWsIAmrxOn9f5I2sbOnyNjqPF
         QggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIQEWHlSLo/XkVLbilcDDKMbq3Gd3wcTC7FKcNbq2ok=;
        b=UgJOInjFOZhlj5mwpkjgakszZEepCMNrMY3wkrm8AkwEh8rTgweIjAA+gp+y0jn1aW
         fQVnv8Kv4p4jfGBcqeBw0p7q9HfVhPmh01cuX54ujNaoE6fwCcoby3M2MIcn66Ly4GZl
         Jr2qDT12eIdic3e2eypDqYV6B19rtQV2pusENW/vVOT7rqPxS11TuZekxHX7YhuGFU93
         fCT1hfgCJVRU3HAUtugVzCcqN2hvyIGtsoekKJwFIDXNtVqhVOUUwDLLo3zvGpIjKQl0
         xqa/qLPRIbV7+YnwwQ36e7GF1Q5zk/NhaL40Fk3BPhxkh4XsWa1zVLM3LMltJQz6t0mj
         pM1Q==
X-Gm-Message-State: ACrzQf0Gyupdcr74pbqx16B5WMP7hEoLfz5CtVdo6SV8TkfrN7eFrrBi
        dWCEqQQerL4x0xbgE2EvT+gA8jPZPZPIJBJv
X-Google-Smtp-Source: AMsMyM4rZCj+506qOriWzb44CLh78uoPB4FCIUSm75q+2TtVzxnulSdkwqX6XKYclU57H68nfYys4vC1g5f0/3cX
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:f11:0:b0:6be:94c1:65e2 with SMTP id
 x17-20020a5b0f11000000b006be94c165e2mr17452348ybr.283.1666370279477; Fri, 21
 Oct 2022 09:37:59 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:37:02 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-47-jthoughton@google.com>
Subject: [RFC PATCH v2 46/47] selftests/vm: add hugetlb HGM test to migration selftest
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
 tools/testing/selftests/vm/migration.c | 139 +++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tools/testing/selftests/vm/migration.c b/tools/testing/selftests/vm/migration.c
index 21577a84d7e4..89cb5934f139 100644
--- a/tools/testing/selftests/vm/migration.c
+++ b/tools/testing/selftests/vm/migration.c
@@ -14,6 +14,11 @@
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
@@ -265,4 +270,138 @@ TEST_F_TIMEOUT(migration, shared_hugetlb, 2*RUNTIME)
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
+	api.features = UFFD_FEATURE_MISSING_HUGETLBFS
+		| UFFD_FEATURE_MINOR_HUGETLBFS
+		| UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
+
+	ret = ioctl(uffd, UFFDIO_API, &api);
+	if (ret || api.api != UFFD_API) {
+		perror("UFFDIO_API failed");
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
2.38.0.135.g90850a2211-goog

