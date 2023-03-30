Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F06D0AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC3QJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjC3QJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B3D32E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYveN9kYI+AE0CuBqSxlkzyTIkRFNshZ9iE0ExlkrHo=;
        b=eQRu5bWaFjcdN08/IhsDIeE4uWoLMiMRDyk/z31AxtJKFDPm7F7DmMIFZi9xHzI29VVC7u
        0zP9/GRE33UdT7i9e110PySv0PnA2j2+0V3mG2BLEHNqD2AAsMFC74uK7uIB3CXPFGpxdK
        JotC3of7xV5OhojbsbN+YkTgS/3wKok=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-bC1EW9GVNo-k5HgQypLCNQ-1; Thu, 30 Mar 2023 12:08:10 -0400
X-MC-Unique: bC1EW9GVNo-k5HgQypLCNQ-1
Received: by mail-qt1-f197.google.com with SMTP id b11-20020ac87fcb000000b003e37d72d532so12708542qtk.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYveN9kYI+AE0CuBqSxlkzyTIkRFNshZ9iE0ExlkrHo=;
        b=6XUA39pzDaarttByQdil8sROGUzD5cfka89pNWKY3PbVnpqdWDJnK4v9QExU8gpsrn
         4FKT38VqYJmhWBKojutOLcuSYU0Cv82InchXyw8X1a/pnVTGgoIsWWnabYIzn6pOOQIb
         ZZNdZhjG7OlSe1rvJA2vcT2BgN+6V/ouXCYRhLvtIl/qOUScw0sasmRLrReHHcxNCNU3
         UNnrWsQaLEVZ9QfLV5ojwmlK/unSLSOkemZG70VJvkhb7sAjQyq7kY4hBvnqJw8kpAwR
         La0HeFOH78bNYmwOZt2JP/rnUYoEkeaVXGhG2UfHZNNh2ZdiodrLiv4hQqw/BuXh8FBH
         X2kA==
X-Gm-Message-State: AAQBX9dN2zNjlNxSdjN4DZ0bQ4DJTPi6ccg0PRlw4KZzlGXgEcqVmF25
        9EDQuEVzwaz6uHVAyow3efCF5FqM3xytHJWHRmRYw0yljp3PZv62uHADPhsU/6KpfMAsrcVOS/J
        uX+2oStrnnWoWwtNznLXUvS/6TCtwjGMh4POMwMWmoGmT53KxQgiAfA2nxISvhBGJG1mTBWYzRz
        FK1MD11A==
X-Received: by 2002:a05:6214:4005:b0:56c:d9e:c9a0 with SMTP id kd5-20020a056214400500b0056c0d9ec9a0mr3701343qvb.1.1680192489198;
        Thu, 30 Mar 2023 09:08:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTdkYANw/GA8UM9SuMd+jqJY9HVceHWacP5BOag5vY6hpxHhAdpkx3urUgNiYoPKaL8hSmQg==
X-Received: by 2002:a05:6214:4005:b0:56c:d9e:c9a0 with SMTP id kd5-20020a056214400500b0056c0d9ec9a0mr3701286qvb.1.1680192488771;
        Thu, 30 Mar 2023 09:08:08 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id m12-20020ad44a0c000000b005dd8b93456dsm5504054qvz.5.2023.03.30.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:08 -0700 (PDT)
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
Subject: [PATCH 17/29] selftests/mm: Drop global mem_fd in uffd tests
Date:   Thu, 30 Mar 2023 12:08:06 -0400
Message-Id: <20230330160806.3107497-1-peterx@redhat.com>
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

Drop it by creating the memfd dynamically in the tests.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 28 +++++++++++++++++++++++-
 tools/testing/selftests/mm/uffd-common.h |  2 +-
 tools/testing/selftests/mm/uffd-stress.c | 15 -------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 3a9b5c1aca9d..a2b6e4957d0f 100644
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

