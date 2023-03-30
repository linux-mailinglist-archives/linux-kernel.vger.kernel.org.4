Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534B56D0ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjC3QJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjC3QJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B700E398
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gA0z3fLtS/53pi31HkFC8RYwaDcusvVg7bMc/ulU8j0=;
        b=KIKb0DkIF41uP2Cw/gAv5F2Lm8NJfxK+HOlhcuXZWgrTkgJHI2nlRxnqMaQopYGKqXw2qe
        SAtww0SNGQBT8G5w3AdM6xG25vl/WhCOmjjFLCN1TEw6xmOkPdCJQZl5ClnHvpXgWF3B4t
        OK2USu/MBdVuGk59WWVPCxtB3qqSxb0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-09LYY7_lPxCzaU0pf8JnHQ-1; Thu, 30 Mar 2023 12:08:15 -0400
X-MC-Unique: 09LYY7_lPxCzaU0pf8JnHQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5aae34d87f7so13016926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA0z3fLtS/53pi31HkFC8RYwaDcusvVg7bMc/ulU8j0=;
        b=ZIEJWL+nHs/gUTuU4N9Pkw0+GyCfKP8Q2E6JwocvRwrEEmTcWL8knu4ECOpqOSXU84
         8dcEH3y6vQYd8b2fnzx0LbGCLQxzpvRuh+0bSi3qHRp/xcIiyFk7ITIaVXskZysNTopI
         WiQnH9te1KSNI1jBNOzbm+e3hAApamyfyeSvr5XsgzvGgauGMFD3hVbKWd2IaUGjivQ9
         SXa6qWAyxboa3OUA1bG4QFTdMJ0Dmw9z6/r8ipXjpbHwSlaw1oZ+XoV6XXK6cRg0tSny
         LD7OYexDJc6opFTrUvMQue+pUx8bUW1oYsrvOJ0TzAmhIyP/f5GKkgpJeAAv/ndxT05H
         bBPQ==
X-Gm-Message-State: AAQBX9cJr2V0nNN8hx1z1ZNi6wRg9v5PYkkm4wyUlmJpkAZx+oyqjejv
        h6GSdNl2qlo9X9g12jYHDNU42yZX33DR6zbLAmN/b6EgABEZcepXxUYMvoraA+E+e10sT3HXnHV
        JFEbFeWAhSj14Bw74+KHaSe8Ve8BzIypMMGau3jF/vKhlpxetYCKCEqb2g5r+oJUjFMf21f3c6N
        mjZaiiMw==
X-Received: by 2002:a05:6214:d0c:b0:5df:a693:39e with SMTP id 12-20020a0562140d0c00b005dfa693039emr3572761qvh.5.1680192492261;
        Thu, 30 Mar 2023 09:08:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350a31IcuGsNWlBkf8cNmNuBl6n8qJKAWJr7SjOPxGZusPrloFA/ON2e0syMszVgcE7KnbiFCxQ==
X-Received: by 2002:a05:6214:d0c:b0:5df:a693:39e with SMTP id 12-20020a0562140d0c00b005dfa693039emr3572696qvh.5.1680192491770;
        Thu, 30 Mar 2023 09:08:11 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mk5-20020a056214580500b005dd8b93459csm5534560qvb.52.2023.03.30.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:10 -0700 (PDT)
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
Subject: [PATCH 18/29] selftests/mm: Drop global hpage_size in uffd tests
Date:   Thu, 30 Mar 2023 12:08:09 -0400
Message-Id: <20230330160809.3107511-1-peterx@redhat.com>
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

hpage_size was wrongly used.  Sometimes it means hugetlb default size,
sometimes it was used as thp size.

Remove the global variable and use the right one at each place.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 7 ++++---
 tools/testing/selftests/mm/uffd-common.h | 2 +-
 tools/testing/selftests/mm/uffd-stress.c | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index a2b6e4957d0f..025e40ffc7bf 100644
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

