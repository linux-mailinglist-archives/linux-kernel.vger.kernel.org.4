Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5016D0AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjC3QMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjC3QMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE87CC1C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fazvJ2yoVQ3FbqTtLeeKqsLvxYRtSAddCup9lQnAU9I=;
        b=ImXgVj561CxRV7Co5nf+bFPpUWX1wcugydOwiFFTtUc5G5Eg8D9cOzJK9PuIx5KtF/9IQ0
        iaD28q28JppcVVIfDdHtjHhNpmmme9HIeNJiXXTLzdkfzBVeOEFErukHJ5FBgGaLyMz1Ql
        xgMAOFpDMfNuFq4dcZPYghR827XLwfg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-Zw41IXoxPFqlzT2WkOARig-1; Thu, 30 Mar 2023 12:08:29 -0400
X-MC-Unique: Zw41IXoxPFqlzT2WkOARig-1
Received: by mail-qt1-f199.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso12740691qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192499; x=1682784499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fazvJ2yoVQ3FbqTtLeeKqsLvxYRtSAddCup9lQnAU9I=;
        b=kuZID7v6q5vnBwwPRzcHU0IqSP5FKhvDMT3q4fpnTAIzFPgRZL+Y5F1h6Wyf4ODFi6
         4i99D2JeYo2C64H1V/SSqrgsKwNs+ofPyYfwTcmL7JuUFULXRQ4jr5V1i7SwCIrC64XJ
         KeuGa54xjZoJaAaJOUMXJVFwBLd95HQEZLt+1a2DHy6IfwBjqw2G3d7YRU902BSX/Ju+
         N3mgL6Y4M0FNfHSI7uezCNfY1yg6Slm6iv5fTvIFjH2BOHhRvSp2lkqbqQaVLYZA4JQq
         BPOCLxP1MgjYMGMjMbmjGztRdcFflFsK/3YJAUtDHfuKC2UoxylbHwnyF8dtuQBWVvB7
         Tz8w==
X-Gm-Message-State: AAQBX9fT0YUL8QBY4KmCu65zDA3pIJ/dfGjZ/bzeM+y6zMXy2gkdTXg0
        coek5pYoQUO715uAqlKnjE9zCgXMMGn2fi7F9C/jTm2rDgS/itgv0tm1c/2ofnSBHsT0vzmlJqF
        FPy4ebsn+UcxHbtg6WryADEGy11zZVGIdYHoOh4s2Kh3z2SByQTr4Sk0lzJ7pk3c645AG+ICpy/
        rLJjVTMw==
X-Received: by 2002:a05:6214:509b:b0:5af:3a13:202d with SMTP id kk27-20020a056214509b00b005af3a13202dmr3927559qvb.4.1680192498917;
        Thu, 30 Mar 2023 09:08:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350acTLaMKvkjgA5o3kANLnUneMIVx+Sq4WzW6L7IohGdoOjgIBbl1U95wQXN6zpuQKJP6h7ekA==
X-Received: by 2002:a05:6214:509b:b0:5af:3a13:202d with SMTP id kk27-20020a056214509b00b005af3a13202dmr3927505qvb.4.1680192498409;
        Thu, 30 Mar 2023 09:08:18 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id nh12-20020a056214390c00b005dd8b9345cbsm5546921qvb.99.2023.03.30.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:17 -0700 (PDT)
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
Subject: [PATCH 20/29] selftests/mm: Allow allocate_area() to fail properly
Date:   Thu, 30 Mar 2023 12:08:15 -0400
Message-Id: <20230330160815.3107534-1-peterx@redhat.com>
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

Mostly to detect hugetlb allocation errors and skip hugetlb tests when
pages are not allocated.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 32 +++++++++++++++++-------
 tools/testing/selftests/mm/uffd-common.h |  4 +--
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 92b7e00efa8a..ae6b61144b53 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -44,10 +44,13 @@ static void anon_release_pages(char *rel_area)
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static void anon_allocate_area(void **alloc_area, bool is_src)
+static int anon_allocate_area(void **alloc_area, bool is_src)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (*alloc_area == MAP_FAILED)
+		err("ENOMEM");
+	return 0;
 }
 
 static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -65,7 +68,7 @@ static void hugetlb_release_pages(char *rel_area)
 	}
 }
 
-static void hugetlb_allocate_area(void **alloc_area, bool is_src)
+static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 {
 	off_t size = nr_pages * page_size;
 	off_t offset = is_src ? 0 : size;
@@ -77,14 +80,16 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
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
@@ -96,6 +101,7 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 		*alloc_area_alias = area_alias;
 
 	close(mem_fd);
+	return 0;
 }
 
 static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -112,7 +118,7 @@ static void shmem_release_pages(char *rel_area)
 		err("madvise(MADV_REMOVE) failed");
 }
 
-static void shmem_allocate_area(void **alloc_area, bool is_src)
+static int shmem_allocate_area(void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
 	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
@@ -150,6 +156,7 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 		area_dst_alias = area_alias;
 
 	close(mem_fd);
+	return 0;
 }
 
 static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -282,14 +289,19 @@ static void uffd_test_ctx_clear(void)
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
 
@@ -337,6 +349,8 @@ void uffd_test_ctx_init(uint64_t features)
 	for (cpu = 0; cpu < nr_cpus; cpu++)
 		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
 			err("pipe");
+
+	return 0;
 }
 
 void wp_range(int ufd, __u64 start, __u64 len, bool wp)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index f4bc73ce3b48..51ec75f6d0c1 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -80,7 +80,7 @@ struct uffd_stats {
 };
 
 struct uffd_test_ops {
-	void (*allocate_area)(void **alloc_area, bool is_src);
+	int (*allocate_area)(void **alloc_area, bool is_src);
 	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
@@ -101,7 +101,7 @@ extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
-void uffd_test_ctx_init(uint64_t features);
+int uffd_test_ctx_init(uint64_t features);
 void userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
-- 
2.39.1

