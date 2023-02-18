Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D769B6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBRAc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBRAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:32:00 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268A6E677
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:28 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id x2-20020ab03802000000b0060d5bfd73b5so940115uav.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfKq0bBaVq4CjPIDar2fHBWF2wKUUWJpsDr5c4wwSS8=;
        b=FNS8OXzQNbEkpLDpjB3nAEwYdiqjzDyLdWfy2qMCsFYgDJSKBhPFK3yDxyIWpeySgl
         maQUSikgn8RHfHnveHKP4KewomfuBHkrzkOdNxKAEwOz4ERjMdSgdS+IkmHhDevj0Dlo
         8SYMrUU5w0fXhm10675DXBEz1qa82TExwLIbs6xG0LABcq+O89FT45Z9grk1Qq9uWQnL
         VEl/w45AklX6i6AYyOmin2NKbHJDvd0cIf5fk1zu+qjIn8o5y4g9O4lMFPFSQVgZ0QZ9
         4eExXJ6WU1Q2oLrhiuNiGB+aLlTM+fJuXr+noURddq0gbHVbzoVDxDtmh6wk9zHk9oKN
         9jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfKq0bBaVq4CjPIDar2fHBWF2wKUUWJpsDr5c4wwSS8=;
        b=nCHjl62P6gsOcOxCvrHUS+VwgswZKQgJ6ToSISvaiipVQfhzbRl9htdiUC429QSy+5
         akicXhbT5kpmJOYn+Yy9Eq99aso618WeMF63JggG5+PuU8lHXc1SHm6JX86bbPhGGH1A
         0EVuK8LvE514eKFjeG4y2rCG6q4pK4xyq1884JZuq0M4okr1S7OLkM6+8E3l0K32bB9o
         IApRjc43eXVdRdmhT13p1YVOhb+iK+ZS9aG6TFlGoibGUi/BuLjvZx4gN1vgwm4PSFkQ
         0Ouuf/DZ2n/1duFbGn7MpbaYz3cniV9Qr7gx/3tRmkyXrUViWTKJNKanbfQ/Vj/pRvdz
         6fYw==
X-Gm-Message-State: AO0yUKUJb+Lwy3SWhRwZlGWhdZF9VAn0z70ML3OmjRYawFuoOGTlDtfw
        APBSdSXDeZbIFEQe8T5qbsz17zsT0KALwpno
X-Google-Smtp-Source: AK7set+/8h4Ti6SaOCrSw2JWCwa+A4XjEDrEdPurb5cORBytv6OxLdCN0/KOEI5ep27FSzg7p5WKdfqWfRYxseKZ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:53d2:0:b0:68b:923a:d6f4 with SMTP
 id l18-20020ab053d2000000b0068b923ad6f4mr47364uaa.2.1676680186208; Fri, 17
 Feb 2023 16:29:46 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:18 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-46-jthoughton@google.com>
Subject: [PATCH v2 45/46] selftests/mm: add hugetlb HGM test to migration selftest
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

This is mostly the same as the shared HugeTLB case, but instead of
mapping the page with a regular page fault, we map it with lots of
UFFDIO_CONTINUE operations. We also verify that the contents haven't
changed after the migration, which would be the case if the
post-migration PTEs pointed to the wrong page.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 21577a84d7e4..1fb3607accab 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
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
2.39.2.637.g21b0678d19-goog

