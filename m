Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1F6DFBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDLQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDLQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CB449C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjojpcmOEAy9sHKJxFBhh1D6ilVghlmR8goVSOpVaAo=;
        b=aBPA/suDeuNhHVeyeXpy4MKFGsYgT0CRWEZxQIpSRfXcJ+2atooRjBMogLXDZFWImH4cQE
        VLnClEHqHigH7qdAby9g+gSd2aKYDRtOhsV/FtCae1g5fE6f37uk5wzbsM34jLrNVt7DFT
        +RlvJ3L8mbnF7DGPB67CCpRSLvxV8ho=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-u8VGGvg0Px2J7zF16EaBIA-1; Wed, 12 Apr 2023 12:43:35 -0400
X-MC-Unique: u8VGGvg0Px2J7zF16EaBIA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74a7c661208so92379885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317814; x=1683909814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjojpcmOEAy9sHKJxFBhh1D6ilVghlmR8goVSOpVaAo=;
        b=CXiMRSMlNhOQFs5Eta5LVdj570rog09IkKWHI3yGMrukZIOSaEGBEi+iwjNJPaT6xN
         lFjioQb6R63i7DhbBx6lenqoozJi6GMPEOws2Q6XrBYyr9kAX9y/iahIX2vQLTPhzpid
         UdeaB70MfargCKjBmLmLT5jdzcerkvGKGMlere1SLer/tIfNZEGjKaH5xmDTbx2yPMfV
         kr1DHBWQ53WrxYjv1fsXBhQWuR3mFmuMKfIA2r1p2FzkoBXJnLcJTxiqnq5XwqwmMwuy
         cmPWjsNA7b7FS6Zvam/+AcHFvr0zIwMs9nIb5ichu19YXvI+W1HFb0ydIxlQwI3zXouL
         37Sw==
X-Gm-Message-State: AAQBX9cQt015oRAW6WduCJrnkTqI3a4XoDTvSNsTgPtajNp4/NgR5niZ
        f+4vKv5kvVwvqWRoComYOh+DK6OATFFr7ZxjSRbPUOEvpNYuFzEox54OuLJ6V+qtnhmpMlSQFIl
        rLwtjEIu2xZg4h9HO/rJb6pvglkvU0kplH8/nb8XYPzFJA3I2HiWbcaRBARLTc0o2yxwdSDO9f6
        CqOju5cw==
X-Received: by 2002:a05:6214:4009:b0:5ac:325c:a28f with SMTP id kd9-20020a056214400900b005ac325ca28fmr28040733qvb.0.1681317813875;
        Wed, 12 Apr 2023 09:43:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350aCRUYX9XSVZcq8LYLtGSnSwVz7FM081yXsn58IDzHk0UjUVjNJXSLp/S7y3S1wvu+8J1/rtQ==
X-Received: by 2002:a05:6214:4009:b0:5ac:325c:a28f with SMTP id kd9-20020a056214400900b005ac325ca28fmr28040704qvb.0.1681317813518;
        Wed, 12 Apr 2023 09:43:33 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id k16-20020a05621414f000b005eea9d3137fsm1749862qvw.134.2023.04.12.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 17/31] selftests/mm: Drop global mem_fd in uffd tests
Date:   Wed, 12 Apr 2023 12:43:31 -0400
Message-Id: <20230412164331.328584-1-peterx@redhat.com>
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

Drop it by creating the memfd dynamically in the tests.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 28 +++++++++++++++++++++++-
 tools/testing/selftests/mm/uffd-common.h |  2 +-
 tools/testing/selftests/mm/uffd-stress.c | 15 -------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 09ea24c5f02c..b1617f5d4517 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -12,12 +12,32 @@
 volatile bool test_uffdio_copy_eexist = true;
 unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
-int mem_fd, uffd = -1, uffd_flags, finished, *pipefd, test_type;
+int uffd = -1, uffd_flags, finished, *pipefd, test_type;
 bool map_shared, test_collapse, test_dev_userfaultfd;
 bool test_uffdio_wp = true, test_uffdio_minor = false;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 
+static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
+{
+	unsigned int memfd_flags = 0;
+	int mem_fd;
+
+	if (hugetlb)
+		memfd_flags = MFD_HUGETLB;
+	mem_fd = memfd_create("uffd-test", memfd_flags);
+	if (mem_fd < 0)
+		err("memfd_create");
+	if (ftruncate(mem_fd, mem_size))
+		err("ftruncate");
+	if (fallocate(mem_fd,
+		      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+		      mem_size))
+		err("fallocate");
+
+	return mem_fd;
+}
+
 static void anon_release_pages(char *rel_area)
 {
 	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
@@ -51,6 +71,7 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 	off_t offset = is_src ? 0 : size;
 	void *area_alias = NULL;
 	char **alloc_area_alias;
+	int mem_fd = uffd_mem_fd_create(size * 2, true);
 
 	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
 			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
@@ -73,6 +94,8 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 	}
 	if (area_alias)
 		*alloc_area_alias = area_alias;
+
+	close(mem_fd);
 }
 
 static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -95,6 +118,7 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 	size_t bytes = nr_pages * page_size;
 	unsigned long offset = is_src ? 0 : bytes;
 	char *p = NULL, *p_alias = NULL;
+	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
 
 	if (test_collapse) {
 		p = BASE_PMD_ADDR;
@@ -124,6 +148,8 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 		area_src_alias = area_alias;
 	else
 		area_dst_alias = area_alias;
+
+	close(mem_fd);
 }
 
 static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 11f770391bd9..0dfab7057295 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -87,7 +87,7 @@ typedef struct uffd_test_ops uffd_test_ops_t;
 
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
-extern int mem_fd, uffd, uffd_flags, finished, *pipefd, test_type;
+extern int uffd, uffd_flags, finished, *pipefd, test_type;
 extern bool map_shared, test_collapse, test_dev_userfaultfd;
 extern bool test_uffdio_wp, test_uffdio_minor;
 extern unsigned long long *count_verify;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index e6d39a755082..4eca1a0276c2 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -1090,21 +1090,6 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
-		unsigned int memfd_flags = 0;
-
-		if (test_type == TEST_HUGETLB)
-			memfd_flags = MFD_HUGETLB;
-		mem_fd = memfd_create(argv[0], memfd_flags);
-		if (mem_fd < 0)
-			err("memfd_create");
-		if (ftruncate(mem_fd, nr_pages * page_size * 2))
-			err("ftruncate");
-		if (fallocate(mem_fd,
-			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
-			      nr_pages * page_size * 2))
-			err("fallocate");
-	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
-- 
2.39.1

