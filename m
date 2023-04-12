Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABA6DFBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjDLQqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDLQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA89902D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbgfGOfUxiSSCaOkyoncCcfniesjTCna7R8zm3hOkOs=;
        b=duvuodg2x0wt0HDYybwz9/l/IcS641UITDwRSkPt+gJtKSkNbKcKjGBMPIVBl9ksnaFUZy
        8Lx5UWCCn0wqmnQ5vyEIcJcrEeOIiQxgCnADi4CMX/GRxjuuaaVy9KS31b54Lv5F7mO0I+
        gyxNs6IuwRPhCYYwRe6urMN0+lO9xjw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-AgXypREeOCWeOHaAYZ7C3w-1; Wed, 12 Apr 2023 12:44:12 -0400
X-MC-Unique: AgXypREeOCWeOHaAYZ7C3w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74a904f38f3so86471285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317850; x=1683909850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbgfGOfUxiSSCaOkyoncCcfniesjTCna7R8zm3hOkOs=;
        b=bJPoKERMnQQyh5juNXTVgQXlScLpBxCeFx1Vw0frgEHCWL762uBXud2Sk9/2og0FRK
         mrbTR3ySZRk5ozvxJQP+ztoqFJIk7pHndnDBhuWDPo2zd30u1gnoTc0FavnULOFfxV2n
         sPQk2Iqq2nwerPOCrW7lezsM01K5h/vTKZ0hQehwtzaFYB/DYN3eKX/E674T1CJOzccq
         4hb2q4pScE9Ni4hIBIoQheLka8QMmgCM87qNf+ssK6UcWHrGjJj4iKo7HCUgWTo9BFt4
         G9JCV+QZM4//U91nknmPnos5fB/nUp7p+YdZFWwmiPgn+E5Ucr18ZMgghHOFi1Qy/5V2
         w0cA==
X-Gm-Message-State: AAQBX9dplgnP+H/ANr8wszO8bmjXv2zgBld6G6BEWMOOXerKT4Idnx5W
        VV/oUbid03Pxeld9sirIWtWWoUiEwlQXo1cvA+RVNNTzZ77osjA9oZy5uOAeLtYBY/7ZkBgsIln
        hUuOSMpKKh3DTFyir4+4IHFlrL8lX48pvZrRYdvB8d9K73dLkSWb2p8koYWl8UMBElqmf61QWgb
        gnHoZrCw==
X-Received: by 2002:a05:6214:528e:b0:5a5:e941:f33d with SMTP id kj14-20020a056214528e00b005a5e941f33dmr4707113qvb.3.1681317850560;
        Wed, 12 Apr 2023 09:44:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgYkqzXY4OPOAVlwyIH89dfszaQ4CVLKQFhdriMwZPec01lMU25gulp094+Es9DxvsBiKi5Q==
X-Received: by 2002:a05:6214:528e:b0:5a5:e941:f33d with SMTP id kj14-20020a056214528e00b005a5e941f33dmr4707078qvb.3.1681317850234;
        Wed, 12 Apr 2023 09:44:10 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cfb44000000b005dd8b93457csm2915318qvq.20.2023.04.12.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:44:09 -0700 (PDT)
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
Subject: [PATCH v2 26/31] selftests/mm: Move zeropage test into uffd unit tests
Date:   Wed, 12 Apr 2023 12:44:04 -0400
Message-Id: <20230412164404.328815-1-peterx@redhat.com>
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

Simplifies it a bit along the way, e.g., drop the never used offset
field (which was always the 1st page so offset=0).

Introduce uffd_register_with_ioctls() out of uffd_register() to detect
uffdio_register.ioctls got returned.  Check that automatically when testing
UFFDIO_ZEROPAGE on different types of memory (and kernel).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 94 +-------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 93 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c         | 14 ++-
 tools/testing/selftests/mm/vm_util.h         |  2 +
 4 files changed, 108 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ce51180238d8..d78f88850011 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -109,15 +109,6 @@ static inline uint64_t uffd_minor_feature(void)
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
@@ -273,89 +264,6 @@ static int stress(struct uffd_args *args)
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
@@ -467,7 +375,7 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(args, nr_cpus);
 	}
 
-	return userfaultfd_zeropage_test();
+	return 0;
 }
 
 static void set_test_type(const char *type)
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 94549696f4b2..160bd8ccda55 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -660,7 +660,100 @@ static void uffd_events_wp_test(void)
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
+/*
+ * Registers a range with MISSING mode only for zeropage test.  Return true
+ * if UFFDIO_ZEROPAGE supported, false otherwise. Can't use uffd_register()
+ * because we want to detect .ioctls along the way.
+ */
+static bool
+uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
+{
+	uint64_t ioctls = 0;
+
+	if (uffd_register_with_ioctls(uffd, addr, len, true,
+				      false, false, &ioctls))
+		err("zeropage register fail");
+
+	return ioctls & (1 << _UFFDIO_ZEROPAGE);
+}
+
+/* exercise UFFDIO_ZEROPAGE */
+static void uffd_zeropage_test(void)
+{
+	bool has_zeropage;
+	int i;
+
+	has_zeropage = uffd_register_detect_zeropage(uffd, area_dst, page_size);
+	if (area_dst_alias)
+		/* Ignore the retval; we already have it */
+		uffd_register_detect_zeropage(uffd, area_dst_alias, page_size);
+
+	if (do_uffdio_zeropage(uffd, has_zeropage))
+		for (i = 0; i < page_size; i++)
+			if (area_dst[i] != 0)
+				err("data non-zero at offset %d\n", i);
+
+	if (uffd_unregister(uffd, area_dst, page_size))
+		err("unregister");
+
+	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
+		err("unregister");
+
+	uffd_test_pass();
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		.name = "zeropage",
+		.uffd_fn = uffd_zeropage_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = 0,
+	},
 	{
 		.name = "pagemap",
 		.uffd_fn = uffd_pagemap_test,
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 1bc0ceb01adb..9b06a5034808 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -198,8 +198,9 @@ unsigned long default_huge_page_size(void)
 	return hps;
 }
 
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor)
+/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls)
 {
 	struct uffdio_register uffdio_register = { 0 };
 	uint64_t mode = 0;
@@ -218,10 +219,19 @@ int uffd_register(int uffd, void *addr, uint64_t len,
 
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
 		ret = -errno;
+	else if (ioctls)
+		*ioctls = uffdio_register.ioctls;
 
 	return ret;
 }
 
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor)
+{
+	return uffd_register_with_ioctls(uffd, addr, len,
+					 miss, wp, minor, NULL);
+}
+
 int uffd_unregister(int uffd, void *addr, uint64_t len)
 {
 	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 634eb2f41145..b950bd16083a 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -52,6 +52,8 @@ int uffd_open_dev(unsigned int flags);
 int uffd_open_sys(unsigned int flags);
 int uffd_open(unsigned int flags);
 int uffd_get_features(uint64_t *features);
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1

