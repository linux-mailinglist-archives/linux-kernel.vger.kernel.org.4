Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88C6DFBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDLQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDLQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB7976C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujW8sSFyaGmImGgAfN35Mc7lSxeHHva64g4oK3AlUaQ=;
        b=WXECe1r6sPYXuk3zpYqSWkeXZe2UPAHh4H3sw6TFjkoID1Vo2eKaDVjsrU7EKg9iDY6/yE
        irPfZkc4yVDT1ODIAGZwI44RLEj9kBi7UBaMV8PTa3WsHT7R2ChV4YhXSJ0YqqdW28A2YC
        NGonSFHPFkvm86ASfkzCA/x1mHIezIE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-hVDJx8isO0GSeEqGox967A-1; Wed, 12 Apr 2023 12:43:54 -0400
X-MC-Unique: hVDJx8isO0GSeEqGox967A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e948dfe9c9so365011cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317832; x=1683909832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujW8sSFyaGmImGgAfN35Mc7lSxeHHva64g4oK3AlUaQ=;
        b=eHuJap8/sNTuLd5HBkPYq0f8xLqrGdE+eFLnCfDX+nQatqv+nSLIYQc1LwBaGtrDYs
         3R7IVaaAqmrOboBui2xQp2vz22A1w3MNiFccJjJK6ZC525DpnJUQ8Log9dtA5azfS6EJ
         SCKzobdXVZYLt+jNkpmnjajK/xmhkLgTl5o2e2qfsdoaPDHaZu87ZIkuiB+dN3nuWc4c
         mAOFEiuYPRkz8b5fi4Z5Y4oBWGNd487q/NT3eimB63Kd4kw96cK4YZR5hpmPNtkQwb9i
         utGiLWnaAIHbRMvmPaWjzIcAHWUO50bkdznkb+pa1QdbmkEydI+rlMJ+JfR82ZGn2MBg
         qDhg==
X-Gm-Message-State: AAQBX9enWlpzQqMmwv9/ClpFHRtqn2s8YWiMtbUvtOC0tm16krG0dydn
        VMskcd+Yr3RROglRvJ3KI81BAwU/Mo5Y5aTj2+bD3tWibcwpUP9uFZiFlzoE+v24kjKxkn5K7Ur
        izW5z2uEE/ahqBxgk1gCVt5tY1ANfBBrLZO1MHcDL7TrB2fytObva5YSXXE2R44RI4RkvMcVitK
        3pyIfRlw==
X-Received: by 2002:a05:622a:50d:b0:3e3:1d31:e37 with SMTP id l13-20020a05622a050d00b003e31d310e37mr4709095qtx.1.1681317832542;
        Wed, 12 Apr 2023 09:43:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350aZLU+frgjQvwfaxCNQHkNm3VqYZWvrTQZf2mrndcXgxwvn/h9oIaDpV8SbGuCpWFsDqkjI3A==
X-Received: by 2002:a05:622a:50d:b0:3e3:1d31:e37 with SMTP id l13-20020a05622a050d00b003e31d310e37mr4709058qtx.1.1681317832132;
        Wed, 12 Apr 2023 09:43:52 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id h2-20020ac87442000000b003e3914c6839sm4369508qtr.43.2023.04.12.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:43:51 -0700 (PDT)
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
Subject: [PATCH v2 22/31] selftests/mm: Add framework for uffd-unit-test
Date:   Wed, 12 Apr 2023 12:43:48 -0400
Message-Id: <20230412164348.328710-1-peterx@redhat.com>
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

Add a framework to be prepared to move unit tests from uffd-stress.c into
uffd-unit-tests.c.  The goal is to allow detection of uffd features for
each test, and also loop over specified types of memory that a test support.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 124 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c         |  37 ++++++
 tools/testing/selftests/mm/vm_util.h         |   2 +
 3 files changed, 163 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index bb492c258486..936b24a6f468 100644
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
 static void uffd_test_report(void)
 {
 	printf("Userfaults unit tests: pass=%u, skip=%u, fail=%u (total=%u)\n",
@@ -105,9 +165,50 @@ static int test_uffd_api(bool use_dev)
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
@@ -116,6 +217,29 @@ int main(int argc, char *argv[])
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
+				uffd_test_skip("environment setup failed");
+				continue;
+			}
+			test->uffd_fn();
+		}
+	}
+
 	uffd_test_report();
 
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5ee6c4688a7c..1bc0ceb01adb 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -254,3 +254,40 @@ int uffd_open_sys(unsigned int flags)
 	return -1;
 #endif
 }
+
+int uffd_open(unsigned int flags)
+{
+	int uffd = uffd_open_sys(flags);
+
+	if (uffd < 0)
+		uffd = uffd_open_dev(flags);
+
+	return uffd;
+}
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
index 481354141533..634eb2f41145 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -50,6 +50,8 @@ int uffd_register(int uffd, void *addr, uint64_t len,
 int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_open_dev(unsigned int flags);
 int uffd_open_sys(unsigned int flags);
+int uffd_open(unsigned int flags);
+int uffd_get_features(uint64_t *features);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1

