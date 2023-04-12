Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FED76DFBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDLQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDLQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3B86B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pO7URj8vYM+yjGhq+aT/ST6K4M19Q/F9Gc+2VYksqI=;
        b=Xh5moXEx1lVc7jN9g7/xiWDUGVKRaHl9O4zyEHgmqCTVyAHqvEjC1GkujtUWVx3C5BucHW
        ZKA6APvA9Gx0XAh5NHtJ6aqysoilohfEolOx5PCkXyiugfDDyjArWJN5/IIZIflXJHJT/f
        y0CkHrFCrvFImqo3cn2OhB2tKpHfjGs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-3AJ12pWrOYufuAWBF2NedA-1; Wed, 12 Apr 2023 12:43:39 -0400
X-MC-Unique: 3AJ12pWrOYufuAWBF2NedA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74a25fcda05so77612885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317817; x=1683909817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pO7URj8vYM+yjGhq+aT/ST6K4M19Q/F9Gc+2VYksqI=;
        b=aX5PJo7TpA+a2kRi8L0bM34qMHS4hlmN8nstIZt47XyAZxo+Dw14ZegxAFAG9d7e0C
         2P4d3yPsXnNxFFdlqsq15DDrflV74BK2C7kKifTA7o4k8Fe3vDx+VP4AEdoyHTHb1BIY
         ph1uT7BuSPAGBic+rG8ek9AtA6BDi6DW9svTV1/ly1Jf1zWanMqMJc1NivL/QaEdEuf8
         Awy/3LoorA9bUrFlzHBFUlEMCGXTwjJZq6bmLvCVBudXTjYxAYgQPvDnymhg4YqUXaYr
         1DQkRkXlMkf8nLMKFdUWqsvGd3AHUjPD4KOyZoExzxoLE1sMREZpqEt6JJudzHr6T2k3
         VSzg==
X-Gm-Message-State: AAQBX9fZvs/Q3rTtlsJhpaMqoS/9OrGyN7L/nP2XYpP0zdu9QVpfNqSc
        UGK+DXZ/vD+gPA1bjMRPB9rBjwb0V6Th7R0UPBDrB7j6cNlr5jcHEYaekjS27+W4ZECeouiK6Q7
        BGmz+cICukwI4oliMQ738Jp1ctNmn+T/jRw+yS6z74oURY2QbW6XbFfL2pXEJRf1bzp5x6WuxMU
        49+9vRew==
X-Received: by 2002:a05:6214:4105:b0:5de:5da:b873 with SMTP id kc5-20020a056214410500b005de05dab873mr4443944qvb.3.1681317817310;
        Wed, 12 Apr 2023 09:43:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3R6M8KdFbyjyZ96tq0efKVR1IxKkDB07C26LLb6jjk8ZwbABfKxJGq8KdfFl/AQ+DyKIdCA==
X-Received: by 2002:a05:6214:4105:b0:5de:5da:b873 with SMTP id kc5-20020a056214410500b005de05dab873mr4443916qvb.3.1681317816911;
        Wed, 12 Apr 2023 09:43:36 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mf18-20020a0562145d9200b005dd8b934579sm3677087qvb.17.2023.04.12.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:35 -0700 (PDT)
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
Subject: [PATCH v2 18/31] selftests/mm: Drop global hpage_size in uffd tests
Date:   Wed, 12 Apr 2023 12:43:33 -0400
Message-Id: <20230412164333.328596-1-peterx@redhat.com>
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

hpage_size was wrongly used.  Sometimes it means hugetlb default size,
sometimes it was used as thp size.

Remove the global variable and use the right one at each place.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 7 ++++---
 tools/testing/selftests/mm/uffd-common.h | 2 +-
 tools/testing/selftests/mm/uffd-stress.c | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b1617f5d4517..f02dfcf10714 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -10,7 +10,7 @@
 #define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 volatile bool test_uffdio_copy_eexist = true;
-unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
+unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 int uffd = -1, uffd_flags, finished, *pipefd, test_type;
 bool map_shared, test_collapse, test_dev_userfaultfd;
@@ -115,7 +115,7 @@ static void shmem_release_pages(char *rel_area)
 static void shmem_allocate_area(void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
-	size_t bytes = nr_pages * page_size;
+	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
 	unsigned long offset = is_src ? 0 : bytes;
 	char *p = NULL, *p_alias = NULL;
 	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
@@ -159,7 +159,8 @@ static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 
 static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
 {
-	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_size))
+	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages,
+			      read_pmd_pagesize()))
 		err("Did not find expected %d number of hugepages",
 		    expect_nr_hpages);
 }
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 0dfab7057295..47565b2f2dee 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -85,7 +85,7 @@ struct uffd_test_ops {
 };
 typedef struct uffd_test_ops uffd_test_ops_t;
 
-extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
+extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
 extern bool map_shared, test_collapse, test_dev_userfaultfd;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 4eca1a0276c2..54fc9b4ffa3c 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -655,7 +655,7 @@ static int userfaultfd_minor_test(void)
 
 		uffd_test_ops->check_pmd_mapping(area_dst,
 						 nr_pages * page_size /
-						 hpage_size);
+						 read_pmd_pagesize());
 		/*
 		 * This won't cause uffd-fault - it purely just makes sure there
 		 * was no corruption.
@@ -997,7 +997,7 @@ static void parse_test_type_arg(const char *raw_type)
 		err("Unsupported test: %s", raw_type);
 
 	if (test_type == TEST_HUGETLB)
-		page_size = hpage_size;
+		page_size = default_huge_page_size();
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
 
@@ -1035,6 +1035,7 @@ static void sigalrm(int sig)
 int main(int argc, char **argv)
 {
 	size_t bytes;
+	size_t hpage_size = read_pmd_pagesize();
 
 	if (argc < 4)
 		usage();
@@ -1043,7 +1044,6 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	hpage_size = default_huge_page_size();
 	parse_test_type_arg(argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
-- 
2.39.1

