Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABDF6D0AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjC3QK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjC3QKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE2E192
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Roeuk409dPF2L2QvtyDeIj99sNqVdIN74Z+r6aghdT8=;
        b=QI8EXuMuCOyJ/kvc3umd6ObUulcgKJ+NOMU8WW04rxPDNT9FOw0mczyUNCAMDxC3m6fjpL
        meaUBS2+w+BFyNvuwB8xApne0qc9/tMRXXbVa1u8sCqs7bLtSBMHT35/E5iXa/Da5AF1YG
        +tu01Rtp3vC/jWMGCqTGRTX0FOWAAjI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-7jHPJga7OUOvRWmxRCvmVA-1; Thu, 30 Mar 2023 12:08:34 -0400
X-MC-Unique: 7jHPJga7OUOvRWmxRCvmVA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-746bae78af3so60184885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roeuk409dPF2L2QvtyDeIj99sNqVdIN74Z+r6aghdT8=;
        b=IZorTI/m1ksi98iKVUZnIYNKKvnPsjajDCakD07phMGjegZ62ecrykF0AsPcZUAqm6
         mEMpiqkb1EPHnJGAxwr+lmkKvJImmPCxKjjGij793AcvScO1K8QL4t021gJ4TqKhCr/f
         VZpz9fZTydQSX+sdswleJrBXRMzzxF6G3/QLXlBWQ5TrYsnfPaF33D9UKj9NaEuvCAhb
         /AMDlL6Awj6NPff95+VwItnpDNp1z5DWunXysopI7AvausEpKuZ0jPJNGhx6IG801sHH
         5v0A+4TusLLj9Hfm3ISaR6BBDG7lzRgpqPK3t4CDRcEeHwVH4Oo3Hp9WOy9bGrl9Az+b
         gcYA==
X-Gm-Message-State: AAQBX9cfpPyVVtlQ+jur69pVvW3n5pvrLMBuNShnsTbx5dsSKqRLWPLS
        ovGOm8dF9JSyW/jIfIJ80tj1qPWzCaIG3+BxzWI/UrD4JF4A745fhjPJQd8jiA3BXzXYML/Ochs
        txEBkbfXeKWdLVWnJoezR92Tm//aQOasRBeH53xsDlXrUv89+7OKIT3dFwFbpqjm8DgmL+sPMLk
        z2CGfUzw==
X-Received: by 2002:a05:622a:199a:b0:3e4:eb39:eb8b with SMTP id u26-20020a05622a199a00b003e4eb39eb8bmr4380210qtc.5.1680192513186;
        Thu, 30 Mar 2023 09:08:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zj+eN5QPeQ5wVil623hZvzJrIMImI+/YUsY/jqTUUYPanRTL0PgneBxr/Nlg9DU4Nsp1MaQg==
X-Received: by 2002:a05:622a:199a:b0:3e4:eb39:eb8b with SMTP id u26-20020a05622a199a00b003e4eb39eb8bmr4380140qtc.5.1680192512678;
        Thu, 30 Mar 2023 09:08:32 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id s13-20020ac8758d000000b003e4e1ea3cb5sm3925874qtq.51.2023.03.30.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:32 -0700 (PDT)
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
Subject: [PATCH 25/29] selftests/mm: Move zeropage test into uffd unit tests
Date:   Thu, 30 Mar 2023 12:08:29 -0400
Message-Id: <20230330160829.3107591-1-peterx@redhat.com>
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

Simplifies it a bit along the way, e.g., drop the never used offset
field (which was always the 1st page so offset=0).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 94 +-------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 94 ++++++++++++++++++++
 2 files changed, 95 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f3046ae13a90..a6f3609c1ad1 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -110,15 +110,6 @@ static inline uint64_t uffd_minor_feature(void)
 		return 0;
 }
 
-static int my_bcmp(char *str1, char *str2, size_t n)
-{
-	unsigned long i;
-	for (i = 0; i < n; i++)
-		if (str1[i] != str2[i])
-			return 1;
-	return 0;
-}
-
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -274,89 +265,6 @@ static int stress(struct uffd_stats *uffd_stats)
 	return 0;
 }
 
-static void retry_uffdio_zeropage(int ufd,
-				  struct uffdio_zeropage *uffdio_zeropage,
-				  unsigned long offset)
-{
-	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
-				     uffdio_zeropage->range.len,
-				     offset);
-	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
-		if (uffdio_zeropage->zeropage != -EEXIST)
-			err("UFFDIO_ZEROPAGE error: %"PRId64,
-			    (int64_t)uffdio_zeropage->zeropage);
-	} else {
-		err("UFFDIO_ZEROPAGE error: %"PRId64,
-		    (int64_t)uffdio_zeropage->zeropage);
-	}
-}
-
-static int __uffdio_zeropage(int ufd, unsigned long offset)
-{
-	struct uffdio_zeropage uffdio_zeropage;
-	int ret;
-	bool has_zeropage = !(test_type == TEST_HUGETLB);
-	__s64 res;
-
-	if (offset >= nr_pages * page_size)
-		err("unexpected offset %lu", offset);
-	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
-	uffdio_zeropage.range.len = page_size;
-	uffdio_zeropage.mode = 0;
-	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
-	res = uffdio_zeropage.zeropage;
-	if (ret) {
-		/* real retval in ufdio_zeropage.zeropage */
-		if (has_zeropage)
-			err("UFFDIO_ZEROPAGE error: %"PRId64, (int64_t)res);
-		else if (res != -EINVAL)
-			err("UFFDIO_ZEROPAGE not -EINVAL");
-	} else if (has_zeropage) {
-		if (res != page_size) {
-			err("UFFDIO_ZEROPAGE unexpected size");
-		} else {
-			retry_uffdio_zeropage(ufd, &uffdio_zeropage,
-					      offset);
-			return 1;
-		}
-	} else
-		err("UFFDIO_ZEROPAGE succeeded");
-
-	return 0;
-}
-
-static int uffdio_zeropage(int ufd, unsigned long offset)
-{
-	return __uffdio_zeropage(ufd, offset);
-}
-
-/* exercise UFFDIO_ZEROPAGE */
-static int userfaultfd_zeropage_test(void)
-{
-	printf("testing UFFDIO_ZEROPAGE: ");
-	fflush(stdout);
-
-	uffd_test_ctx_init(0);
-
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
-			  true, test_uffdio_wp, false))
-		err("register failure");
-
-	if (area_dst_alias) {
-		/* Needed this to test zeropage-retry on shared memory */
-		if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
-				  true, test_uffdio_wp, false))
-			err("register failure");
-	}
-
-	if (uffdio_zeropage(uffd, 0))
-		if (my_bcmp(area_dst, zeropage, page_size))
-			err("zeropage is not zero");
-
-	printf("done.\n");
-	return 0;
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -468,7 +376,7 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	return userfaultfd_zeropage_test();
+	return 0;
 }
 
 static void set_test_type(const char *type)
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index ebf45cb0eca8..376dfa320b6f 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -663,7 +663,101 @@ static void uffd_events_wp_test(void)
 	uffd_events_test_common(true);
 }
 
+static void retry_uffdio_zeropage(int ufd,
+				  struct uffdio_zeropage *uffdio_zeropage)
+{
+	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
+				     uffdio_zeropage->range.len,
+				     0);
+	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
+		if (uffdio_zeropage->zeropage != -EEXIST)
+			err("UFFDIO_ZEROPAGE error: %"PRId64,
+			    (int64_t)uffdio_zeropage->zeropage);
+	} else {
+		err("UFFDIO_ZEROPAGE error: %"PRId64,
+		    (int64_t)uffdio_zeropage->zeropage);
+	}
+}
+
+static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
+{
+	struct uffdio_zeropage uffdio_zeropage = { 0 };
+	int ret;
+	__s64 res;
+
+	uffdio_zeropage.range.start = (unsigned long) area_dst;
+	uffdio_zeropage.range.len = page_size;
+	uffdio_zeropage.mode = 0;
+	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+	res = uffdio_zeropage.zeropage;
+	if (ret) {
+		/* real retval in ufdio_zeropage.zeropage */
+		if (has_zeropage)
+			err("UFFDIO_ZEROPAGE error: %"PRId64, (int64_t)res);
+		else if (res != -EINVAL)
+			err("UFFDIO_ZEROPAGE not -EINVAL");
+	} else if (has_zeropage) {
+		if (res != page_size)
+			err("UFFDIO_ZEROPAGE unexpected size");
+		else
+			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
+		return true;
+	} else
+		err("UFFDIO_ZEROPAGE succeeded");
+
+	return false;
+}
+
+/* exercise UFFDIO_ZEROPAGE */
+static void uffd_zeropage_test_common(bool has_zeropage)
+{
+	if (uffd_register(uffd, area_dst, page_size,
+			  true, false, false))
+		err("register");
+
+	if (area_dst_alias)
+		if (uffd_register(uffd, area_dst_alias, page_size,
+				  true, false, false))
+			err("register");
+
+	if (do_uffdio_zeropage(uffd, has_zeropage)) {
+		int i;
+
+		for (i = 0; i < page_size; i++)
+			if (area_dst[i] != 0)
+				err("data non-zero at offset %d\n", i);
+	}
+
+
+	if (uffd_unregister(uffd, area_dst, page_size * nr_pages))
+		err("unregister");
+
+	uffd_test_pass();
+}
+
+static void uffd_zeropage_test(void)
+{
+	uffd_zeropage_test_common(true);
+}
+
+static void uffd_zeropage_hugetlb_test(void)
+{
+	uffd_zeropage_test_common(false);
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		.name = "zeropage",
+		.uffd_fn = uffd_zeropage_test,
+		.mem_targets = MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE,
+		.uffd_feature_required = 0,
+	},
+	{
+		.name = "zeropage-hugetlb",
+		.uffd_fn = uffd_zeropage_hugetlb_test,
+		.mem_targets = MEM_HUGETLB | MEM_HUGETLB_PRIVATE,
+		.uffd_feature_required = 0,
+	},
 	{
 		.name = "pagemap",
 		.uffd_fn = uffd_pagemap_test,
-- 
2.39.1

