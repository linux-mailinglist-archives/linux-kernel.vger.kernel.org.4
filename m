Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700E6D0ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjC3QK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjC3QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28223D33D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhDA/wjfT6X0KP/XkxMZvdeJDhg2SLQS/Rv9HxMM2sI=;
        b=UB1nxhQaVKRMv+toni/81Une2kbcN4X4jgE8LoGIRJ+Sblatf8NZyYNizZK89/E/p253rs
        GTIOHDwlkf5ySVc8JaNpx+I45jyrV1ULQicUaodfM/HvkqYaaNN/NuDQPZYfWzs7mJWT3Q
        zr2boiq+jK0u/OSZT3xzsfH/RulUkD8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-RuQv74wlMBuekp-YuXlFaQ-1; Thu, 30 Mar 2023 12:08:23 -0400
X-MC-Unique: RuQv74wlMBuekp-YuXlFaQ-1
Received: by mail-qv1-f72.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so8513284qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhDA/wjfT6X0KP/XkxMZvdeJDhg2SLQS/Rv9HxMM2sI=;
        b=fkcU06DPoZbDr6SW8F3jev2PEM9xC9QZ3mMWqM1Zae1uUohIJldNd9MwWwnsD/2yzl
         bcBX769Y/oX6oRSX2VIWm3vVvPs1agDYnGjtwZ8bcuO4wb2Sqjy9h33sqeTiJigyQJjk
         AnF2NDL4guXoQ/e8PG3nbIVxvX5q5SuSPqM1n5CLKhAvGPlEzAzGoyXAEh1RvCqLGBvc
         xa1YiXQczvzgyRy1+xMaRbYtFkgW6belXGWmYnuWFcDTevvsKPSjnu+4yViR1O2ZPGqF
         W78KnmmqYuDqgfmn67luERlyHrZzdqoXGYzKLI0zyhKgFaBfw0P7Tpda9RbEvgmWYpmL
         yHQA==
X-Gm-Message-State: AAQBX9fv2RSYTVPq8tRczAoUaKxsJ8VC4iVxb58j5vrCNz393SzuZPn2
        UKkH/hJpSflGuZIZBzq3siIFC9QUGNMvzmOMO8HE3Ho3HUj107DsgwBSIisnZsKgKCGUpv1Gqja
        TxXC+ID36SVQJPEg8itimEQgRcJXhiDP74kFBBdnaYXbqcMdcL0/+RUKH2Ynp/y1t0XhLwOgRoE
        G17WRMpQ==
X-Received: by 2002:a05:6214:4005:b0:56c:d9e:c9a0 with SMTP id kd5-20020a056214400500b0056c0d9ec9a0mr3702716qvb.1.1680192501732;
        Thu, 30 Mar 2023 09:08:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIVoRr5JKeD10TL5Z3VboZfFB7o7h5MoQBZi1Ow1eqcSHcj8AcQbyOTnGNgHxF8PIDsqGFfQ==
X-Received: by 2002:a05:6214:4005:b0:56c:d9e:c9a0 with SMTP id kd5-20020a056214400500b0056c0d9ec9a0mr3702655qvb.1.1680192501195;
        Thu, 30 Mar 2023 09:08:21 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id j5-20020a0ce6a5000000b005dd8b93458esm5515078qvn.38.2023.03.30.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:20 -0700 (PDT)
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
Subject: [PATCH 21/29] selftests/mm: Add framework for uffd-unit-test
Date:   Thu, 30 Mar 2023 12:08:18 -0400
Message-Id: <20230330160818.3107545-1-peterx@redhat.com>
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

Add a framework to be prepared to move unit tests from uffd-stress.c into
uffd-unit-tests.c.  The goal is to allow detection of uffd features for
each test, and also loop over specified types of memory that a test support.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 125 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c         |  27 ++++
 tools/testing/selftests/mm/vm_util.h         |   1 +
 3 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index dfb44ffad5f5..007145063363 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -9,6 +9,66 @@
 
 #ifdef __NR_userfaultfd
 
+/* The unit test doesn't need a large or random size, make it 32MB for now */
+#define  UFFD_TEST_MEM_SIZE               (32UL << 20)
+
+#define  MEM_ANON                         BIT_ULL(0)
+#define  MEM_SHMEM                        BIT_ULL(1)
+#define  MEM_SHMEM_PRIVATE                BIT_ULL(2)
+#define  MEM_HUGETLB                      BIT_ULL(3)
+#define  MEM_HUGETLB_PRIVATE              BIT_ULL(4)
+
+struct mem_type {
+	const char *name;
+	unsigned int mem_flag;
+	uffd_test_ops_t *mem_ops;
+	bool shared;
+};
+typedef struct mem_type mem_type_t;
+
+mem_type_t mem_types[] = {
+	{
+		.name = "anon",
+		.mem_flag = MEM_ANON,
+		.mem_ops = &anon_uffd_test_ops,
+		.shared = false,
+	},
+	{
+		.name = "shmem",
+		.mem_flag = MEM_SHMEM,
+		.mem_ops = &shmem_uffd_test_ops,
+		.shared = true,
+	},
+	{
+		.name = "shmem-private",
+		.mem_flag = MEM_SHMEM_PRIVATE,
+		.mem_ops = &shmem_uffd_test_ops,
+		.shared = false,
+	},
+	{
+		.name = "hugetlb",
+		.mem_flag = MEM_HUGETLB,
+		.mem_ops = &hugetlb_uffd_test_ops,
+		.shared = true,
+	},
+	{
+		.name = "hugetlb-private",
+		.mem_flag = MEM_HUGETLB_PRIVATE,
+		.mem_ops = &hugetlb_uffd_test_ops,
+		.shared = false,
+	},
+};
+
+/* Returns: UFFD_TEST_* */
+typedef void (*uffd_test_fn)(void);
+
+typedef struct {
+	const char *name;
+	uffd_test_fn uffd_fn;
+	unsigned int mem_targets;
+	uint64_t uffd_feature_required;
+} uffd_test_case_t;
+
 struct {
 	unsigned int pass, skip, fail, total;
 } uffd_test_acct;
@@ -108,9 +168,50 @@ static int test_uffd_api(bool use_dev)
 	return 1;
 }
 
+/*
+ * This function initializes the global variables.  TODO: remove global
+ * vars and then remove this.
+ */
+static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
+{
+	map_shared = mem_type->shared;
+	uffd_test_ops = mem_type->mem_ops;
+
+	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
+		page_size = default_huge_page_size();
+	else
+		page_size = psize();
+
+	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
+	/* TODO: remove this global var.. it's so ugly */
+	nr_cpus = 1;
+
+	return uffd_test_ctx_init(test->uffd_feature_required);
+}
+
+static bool uffd_feature_supported(uffd_test_case_t *test)
+{
+	uint64_t features;
+
+	if (uffd_get_features(&features))
+		return false;
+
+	return (features & test->uffd_feature_required) ==
+	    test->uffd_feature_required;
+}
+
+uffd_test_case_t uffd_tests[] = {
+};
+
 int main(int argc, char *argv[])
 {
+	int n_tests = sizeof(uffd_tests) / sizeof(uffd_test_case_t);
+	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
+	uffd_test_case_t *test;
+	mem_type_t *mem_type;
+	char test_name[128];
 	int has_uffd;
+	int i, j;
 
 	has_uffd = test_uffd_api(false);
 	has_uffd |= test_uffd_api(true);
@@ -119,7 +220,31 @@ int main(int argc, char *argv[])
 		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
 		exit(KSFT_SKIP);
 	}
+
+	for (i = 0; i < n_tests; i++) {
+		test = &uffd_tests[i];
+		for (j = 0; j < n_mems; j++) {
+			mem_type = &mem_types[j];
+			if (!(test->mem_targets & mem_type->mem_flag))
+				continue;
+			snprintf(test_name, sizeof(test_name),
+				 "%s on %s", test->name, mem_type->name);
+
+			uffd_test_start(test_name);
+			if (!uffd_feature_supported(test)) {
+				uffd_test_skip("feature missing");
+				continue;
+			}
+			if (uffd_setup_environment(test, mem_type)) {
+				uffd_test_skip("memory allocation failed");
+				continue;
+			}
+			test->uffd_fn();
+		}
+	}
+
 	uffd_test_report();
+
 	return uffd_test_acct.fail ? KSFT_FAIL : KSFT_PASS;
 }
 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 62fcf039d6b7..dad1f62a7ecd 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -264,3 +264,30 @@ int uffd_open(unsigned int flags)
 
 	return uffd;
 }
+
+int uffd_get_features(uint64_t *features)
+{
+	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
+	/*
+	 * This should by default work in most kernels; the feature list
+	 * will be the same no matter what we pass in here.
+	 */
+	int fd = uffd_open(UFFD_USER_MODE_ONLY);
+
+	if (fd < 0)
+		/* Maybe the kernel is older than user-only mode? */
+		fd = uffd_open(0);
+
+	if (fd < 0)
+		return fd;
+
+	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
+		close(fd);
+		return -errno;
+	}
+
+	*features = uffdio_api.features;
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index a67db8432855..2edad3256271 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -51,6 +51,7 @@ int uffd_open(unsigned int flags);
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
 int uffd_unregister(int uffd, void *addr, uint64_t len);
+int uffd_get_features(uint64_t *features);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1

