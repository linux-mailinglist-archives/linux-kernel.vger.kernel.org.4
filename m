Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD95D6DFBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDLQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9BE977B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6fb7dGe8Qh9zpC1XHTDp4auTsAlmohzusSG+yhHPLI=;
        b=JDRit7WOzUsZLUWMU+pHu93i8EbKOUTZ8EJmmPEn9yI8rmE+d1PsKh5H+rYP3XnY5GHtd4
        gtfySFhFZfdUCd+mMJTEupWj/AmPqsSTDuYaCMmCxTLAAG+EGWGYZubxOYSjVc+elc3vhQ
        H7tV51F/FYXYIQdxp3W5af9XF3mzhOI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-_cxnZK6MPr2gGqv57ODuMg-1; Wed, 12 Apr 2023 12:43:50 -0400
X-MC-Unique: _cxnZK6MPr2gGqv57ODuMg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74acb477be6so2310485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317829; x=1683909829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6fb7dGe8Qh9zpC1XHTDp4auTsAlmohzusSG+yhHPLI=;
        b=BnJICVU/msEcEC6OzdtpGiZzp7/3fRPu9hiysijvi1zXodHxrSkARamRFUjS3n55F8
         R+GLws2c52KIPxkD088vf5kAmr3ZrzK7FY/QbvbI5IOc1yH3iUvqGU9mFqDB0qmT4T5a
         VcP3RTsMNaUONDXcia5G3+mNesnB5MVBMMWYahe/wj/87NjjBGTSFctuTqhz/LtO2j4N
         Fm+hyD0Y7tEKbKMmRRLzfTS6E7zt4XViEYvsLDCYcYB9T2h8YY+/2Bb0c04nbibindIc
         PINiWpFHsGEeQ49pS4ntwrqo2pBMNaJUMpNh0qX8SYEabxV979EB352S+tMvA+CkRUjW
         SKzA==
X-Gm-Message-State: AAQBX9exEPvER/e+z6cAIVRdsIPKfzb2ppcFQRUJRP5gEUf5ipFAEP94
        citSrbE6NbbDa4OmGPufJuMzrXCGt7LM80wp8ES64Uw85EkXGMWOR7K7AxmgQKdTQwzNjWASoKA
        KXGAQ6vL9yMcccE1kDVYpy0fSm2FyM/8AThp51TQ4cdt7dYEFB943eBMgRLBHDUxMlzEFBvLBmn
        AaAIw/WQ==
X-Received: by 2002:a05:6214:410e:b0:5e8:e227:982e with SMTP id kc14-20020a056214410e00b005e8e227982emr4492241qvb.3.1681317829026;
        Wed, 12 Apr 2023 09:43:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350bUncXTyJW92k3ESgGa7qeDhT/mpGdY2qSDyncYCia8CnYIFPtqWX76/SVSSYIWo1RN9ImdVA==
X-Received: by 2002:a05:6214:410e:b0:5e8:e227:982e with SMTP id kc14-20020a056214410e00b005e8e227982emr4492202qvb.3.1681317828637;
        Wed, 12 Apr 2023 09:43:48 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id w23-20020ac86b17000000b003e6948a8966sm3274810qts.21.2023.04.12.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 21/31] selftests/mm: Allow allocate_area() to fail properly
Date:   Wed, 12 Apr 2023 12:43:45 -0400
Message-Id: <20230412164345.328659-1-peterx@redhat.com>
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

Mostly to detect hugetlb allocation errors and skip hugetlb tests when
pages are not allocated.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 47 +++++++++++++++++-------
 tools/testing/selftests/mm/uffd-common.h |  4 +-
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index daa2a95408e6..bc6c5c38d6dd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -44,10 +44,15 @@ static void anon_release_pages(char *rel_area)
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static void anon_allocate_area(void **alloc_area, bool is_src)
+static int anon_allocate_area(void **alloc_area, bool is_src)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (*alloc_area == MAP_FAILED) {
+		*alloc_area = NULL;
+		return -errno;
+	}
+	return 0;
 }
 
 static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -65,7 +70,7 @@ static void hugetlb_release_pages(char *rel_area)
 	}
 }
 
-static void hugetlb_allocate_area(void **alloc_area, bool is_src)
+static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 {
 	off_t size = nr_pages * page_size;
 	off_t offset = is_src ? 0 : size;
@@ -77,14 +82,16 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
 			   (is_src ? 0 : MAP_NORESERVE),
 			   mem_fd, offset);
-	if (*alloc_area == MAP_FAILED)
-		err("mmap of hugetlbfs file failed");
+	if (*alloc_area == MAP_FAILED) {
+		*alloc_area = NULL;
+		return -errno;
+	}
 
 	if (map_shared) {
 		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
 				  MAP_SHARED, mem_fd, offset);
 		if (area_alias == MAP_FAILED)
-			err("mmap of hugetlb file alias failed");
+			return -errno;
 	}
 
 	if (is_src) {
@@ -96,6 +103,7 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 		*alloc_area_alias = area_alias;
 
 	close(mem_fd);
+	return 0;
 }
 
 static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -112,7 +120,7 @@ static void shmem_release_pages(char *rel_area)
 		err("madvise(MADV_REMOVE) failed");
 }
 
-static void shmem_allocate_area(void **alloc_area, bool is_src)
+static int shmem_allocate_area(void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
 	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
@@ -132,15 +140,20 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 
 	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
 			   mem_fd, offset);
-	if (*alloc_area == MAP_FAILED)
-		err("mmap of memfd failed");
+	if (*alloc_area == MAP_FAILED) {
+		*alloc_area = NULL;
+		return -errno;
+	}
 	if (test_collapse && *alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
 	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
 			  mem_fd, offset);
-	if (area_alias == MAP_FAILED)
-		err("mmap of memfd alias failed");
+	if (area_alias == MAP_FAILED) {
+		munmap(*alloc_area, bytes);
+		*alloc_area = NULL;
+		return -errno;
+	}
 	if (test_collapse && area_alias != p_alias)
 		err("mmap of anonymous memory failed at %p", p_alias);
 
@@ -150,6 +163,7 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 		area_dst_alias = area_alias;
 
 	close(mem_fd);
+	return 0;
 }
 
 static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -282,14 +296,19 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_remap);
 }
 
-void uffd_test_ctx_init(uint64_t features)
+int uffd_test_ctx_init(uint64_t features)
 {
 	unsigned long nr, cpu;
+	int ret;
 
 	uffd_test_ctx_clear();
 
-	uffd_test_ops->allocate_area((void **)&area_src, true);
-	uffd_test_ops->allocate_area((void **)&area_dst, false);
+	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
+	if (ret)
+		return ret;
+	ret = uffd_test_ops->allocate_area((void **)&area_dst, false);
+	if (ret)
+		return ret;
 
 	userfaultfd_open(&features);
 
@@ -337,6 +356,8 @@ void uffd_test_ctx_init(uint64_t features)
 	for (cpu = 0; cpu < nr_cpus; cpu++)
 		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
 			err("pipe");
+
+	return 0;
 }
 
 void wp_range(int ufd, __u64 start, __u64 len, bool wp)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 0ec07d025cfe..9479a0649d7f 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -80,7 +80,7 @@ struct uffd_args {
 };
 
 struct uffd_test_ops {
-	void (*allocate_area)(void **alloc_area, bool is_src);
+	int (*allocate_area)(void **alloc_area, bool is_src);
 	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
@@ -101,7 +101,7 @@ extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
-void uffd_test_ctx_init(uint64_t features);
+int uffd_test_ctx_init(uint64_t features);
 void userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
-- 
2.39.1

