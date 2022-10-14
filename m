Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4E5FF074
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJNOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJNOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044DD1D4DE7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEy7pKIEsfMMFzj4vyOzQVpkWI0TxrmvN3NLo9J44z8=;
        b=iepYJhttJwhqIGc6BDa2CKrYQKQSHTWGZcrN9v8IMO6Ngab5cIWXky27aNI4NmuNNYOSci
        bSf0nvG2q5zt0ych081OKFa68KQDieNsDiLXthPTHCB/NucxMfOIHcV3Sl6Zq5Ytq5HSPf
        9cUoITp/c97tRaOiwJktQ35/6tRlOYs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-l_ER5CKYNmuc7kbrvHuT5A-1; Fri, 14 Oct 2022 10:39:25 -0400
X-MC-Unique: l_ER5CKYNmuc7kbrvHuT5A-1
Received: by mail-qk1-f198.google.com with SMTP id j13-20020a05620a288d00b006be7b2a758fso3580147qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEy7pKIEsfMMFzj4vyOzQVpkWI0TxrmvN3NLo9J44z8=;
        b=kyIQlijkbsz/HvzKAO59f5AwgWjTywJg4zXdJ4Z6JcQzqEcCl33jfDuXR1B1qnJCQy
         5FU82tFQ6AulAfzojEbXKVOeRTmzm+PEwmbFK/taI7IenBp6gXibynNzGrbVrw9by02W
         vurin6GwOpYtRDrN8LbmX7SqNPchLmHdQx68RvyVr2XW2L4ghsrFnmzHVXyIerKlYPqR
         r6lZXNK64RJG3Ef+wkvWQITNsDk/azjxl20fZ0VIDZpgPH4IM+h0JjwCZTDiJWaGbzj+
         31Nk4+It7OxynBP4R4rVo2Z4jbdQ4h0XnO3ou2f1LP8yvy+Nwn4OmYkDIv8CjqLJrxBq
         F6Cw==
X-Gm-Message-State: ACrzQf0yI6jITXJsZeR+UjxR9n6ivlrcJQOaql6vShcFEv/24p2snBsY
        n7njwdIJwq244B/7Ty/km44PlpnjwZuLVD+VyqxySVmmwDY1hu89TmoQoWZeWE5hs53DFwTK3mL
        nEWbFxdrDP4dHcMQ9MnzQyvSCKn4gwnp4dJevH94a97cnYlQ08L2ZcogE0LJvZAhhJdp+Kt7Y1w
        ==
X-Received: by 2002:a05:6214:500f:b0:4b1:d2b1:54c with SMTP id jo15-20020a056214500f00b004b1d2b1054cmr4236938qvb.54.1665758364406;
        Fri, 14 Oct 2022 07:39:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5hcHtcB11MKZ36Ka9jJq2b9wUzusa/zVJ0ne6bkmpItRnjhCW0Ngl0EeWdKQA1NKrIZ/bLuw==
X-Received: by 2002:a05:6214:500f:b0:4b1:d2b1:54c with SMTP id jo15-20020a056214500f00b004b1d2b1054cmr4236905qvb.54.1665758364028;
        Fri, 14 Oct 2022 07:39:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ec09d7d357sm2675541qkp.47.2022.10.14.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:39:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 1/4] selftests/vm: Use memfd for uffd hugetlb tests
Date:   Fri, 14 Oct 2022 10:39:18 -0400
Message-Id: <20221014143921.93887-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014143921.93887-1-peterx@redhat.com>
References: <20221014143921.93887-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already used memfd for shmem test, move it forward with hugetlb too so
that we don't need user to specify the hugetlb file path explicitly when
running hugetlb shared tests.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 62 ++++++++----------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..58f70d81e630 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -93,10 +93,8 @@ static volatile bool test_uffdio_zeropage_eexist = true;
 static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
-
 static bool map_shared;
-static int shm_fd;
-static int huge_fd;
+static int mem_fd;
 static unsigned long long *count_verify;
 static int uffd = -1;
 static int uffd_flags, finished, *pipefd;
@@ -143,7 +141,7 @@ const char *examples =
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
     "./userfaultfd hugetlb 256 50\n\n"
     "# Run the same hugetlb test but using shared file:\n"
-    "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
+    "./userfaultfd hugetlb_shared 256 50\n\n"
     "# 10MiB-~6GiB 999 bounces anonymous test, "
     "continue forever unless an error triggers\n"
     "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n\n";
@@ -260,35 +258,21 @@ static void hugetlb_release_pages(char *rel_area)
 
 static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 {
+	off_t size = nr_pages * page_size;
+	off_t offset = is_src ? 0 : size;
 	void *area_alias = NULL;
 	char **alloc_area_alias;
 
-	if (!map_shared)
-		*alloc_area = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
-				(is_src ? 0 : MAP_NORESERVE),
-			-1,
-			0);
-	else
-		*alloc_area = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED |
-				(is_src ? 0 : MAP_NORESERVE),
-			huge_fd,
-			is_src ? 0 : nr_pages * page_size);
+	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
+			   (is_src ? 0 : MAP_NORESERVE),
+			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
 	if (map_shared) {
-		area_alias = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED,
-			huge_fd,
-			is_src ? 0 : nr_pages * page_size);
+		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
+				  MAP_SHARED, mem_fd, offset);
 		if (area_alias == MAP_FAILED)
 			err("mmap of hugetlb file alias failed");
 	}
@@ -334,14 +318,14 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 	}
 
 	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			   shm_fd, offset);
+			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
 	if (test_collapse && *alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
 	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  shm_fd, offset);
+			  mem_fd, offset);
 	if (area_alias == MAP_FAILED)
 		err("mmap of memfd alias failed");
 	if (test_collapse && area_alias != p_alias)
@@ -1821,21 +1805,17 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB && map_shared) {
-		if (argc < 5)
-			usage();
-		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-		if (huge_fd < 0)
-			err("Open of %s failed", argv[4]);
-		if (ftruncate(huge_fd, 0))
-			err("ftruncate %s to size 0 failed", argv[4]);
-	} else if (test_type == TEST_SHMEM) {
-		shm_fd = memfd_create(argv[0], 0);
-		if (shm_fd < 0)
+	if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
+		unsigned int memfd_flags = 0;
+
+		if (test_type == TEST_HUGETLB)
+			memfd_flags = MFD_HUGETLB;
+		mem_fd = memfd_create(argv[0], memfd_flags);
+		if (mem_fd < 0)
 			err("memfd_create");
-		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+		if (ftruncate(mem_fd, nr_pages * page_size * 2))
 			err("ftruncate");
-		if (fallocate(shm_fd,
+		if (fallocate(mem_fd,
 			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
 			      nr_pages * page_size * 2))
 			err("fallocate");
-- 
2.37.3

