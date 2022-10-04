Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493215F4B11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiJDVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJDVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264070E75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664919690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/w2JwM8JeFqa2ztqMSbd+xEgiAESxi1m1hIt+DBhlCQ=;
        b=Z57QAEJPcI7UZhQ3yMQW0hPUUaN31mPYiMvXIO/NSvGt39yINSfM5Jax/VVkSSVpAOAx+8
        sQTlc20ZCF0wVdOe4CPs5XvrPEFK+UL4j0aZYnNBKHKVOeBj3v+i+je935paUyltUl8zQb
        5Ta4BdD2cOXwjGQb2U4L5k142SWU5yc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-uI4hRshAO6qA_Mlyzizwfg-1; Tue, 04 Oct 2022 17:41:29 -0400
X-MC-Unique: uI4hRshAO6qA_Mlyzizwfg-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso12934085qkp.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/w2JwM8JeFqa2ztqMSbd+xEgiAESxi1m1hIt+DBhlCQ=;
        b=DXypp2sh6tjpslC/rYk0LO7cII83T7mKkNdDO8STnoXkk0uTBgV8X0x70a7qCgzj9q
         pQTtJedYPiRasBAlfCVDdGo49E5Et/N5ygNjStkRZ3HDJi4k9ijtmRhWA2kDLBamwqJn
         gRMHa82++xzyW0llhq5XPTH2Wy6dIPDHAZpB3qT25sF2VQdOVqrbtezzcPCTE0WxTN2J
         S3aSmA1njDlwZHjjJXTQ9JuXKrHUSYTvkUpmPZX/WBxxMorvdaP4YpNzzJY5xco2wAP8
         jc8GMWJYb9glu5Sa2oeUyyEJm4+D7CE6AGOxINekQNkCye9JQPvNEmKbzQtTC8YC8Y1O
         XHeQ==
X-Gm-Message-State: ACrzQf17AXp9HIxSa0e/CLzRdkC60Du5ENjenz5qfQa2sA5pr4igdvpT
        AloHtP+uoTKNY60aUjWrnLwsNTkLTSalirhDb5ovexzUUNrUh1hGGIaLosQI426lJ1s3Z7lrqWX
        fyRCwYhFePNCl+4qKLhFHHYS9sK+b3/nHOFG+whwIFbCr1iOMAky1EVKOUCpueUlGAlxCBO9HiA
        ==
X-Received: by 2002:ac8:5cd5:0:b0:35b:bbd1:20ea with SMTP id s21-20020ac85cd5000000b0035bbbd120eamr21123623qta.549.1664919688666;
        Tue, 04 Oct 2022 14:41:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6qF+0TqymelkGkoObEdmZR55zlKAQ3919cYMgIiCESflQCNd2+DsttJ2F1dVn6tCX0I6g9Yg==
X-Received: by 2002:ac8:5cd5:0:b0:35b:bbd1:20ea with SMTP id s21-20020ac85cd5000000b0035bbbd120eamr21123607qta.549.1664919688375;
        Tue, 04 Oct 2022 14:41:28 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006bbf85cad0fsm15519956qko.20.2022.10.04.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:41:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/4] selftests/vm: Use memfd for hugetlb tests
Date:   Tue,  4 Oct 2022 17:41:22 -0400
Message-Id: <20221004214125.120993-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004214125.120993-1-peterx@redhat.com>
References: <20221004214125.120993-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 60 ++++++++----------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..c0c6853cdce5 100644
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

