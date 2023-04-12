Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABC16DFBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjDLQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDLQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67693EF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681318141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvUBLMIj6eaAe1GDo1uBeLCLb+kkyu1V0plV870AgzY=;
        b=dMREYaFmEUTyUivNAns7jYi1rMXVXc+z6dQg1darMPKEqfONTgH1XdfLt7k8fQ+YRB0fo9
        8O8dgkdvZD8PP6ioJ8GOEcLhagcOoV35v6bH47iFhjhmQsNOO3LJPqL6T0pwFGygLszV++
        R5HpYni2TvMo3r+TuzuZ0FTR5NGM3sg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-hrrzXzmLPf-EDkOxcsiVJA-1; Wed, 12 Apr 2023 12:45:30 -0400
X-MC-Unique: hrrzXzmLPf-EDkOxcsiVJA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e8d943d3a4so669641cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317925; x=1683909925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvUBLMIj6eaAe1GDo1uBeLCLb+kkyu1V0plV870AgzY=;
        b=IGA2znnCz6q84+iCXtoSAiEDWt1nNe+KFT11VOWDEEvDIEpUXQ2mq5uxvmB/YLxYVg
         yDnHiSID9ELfSKXBRPxTL9Lx3J9KxKpV5YLCop7t1uLl8Uer5oZswu3k3t7q3EiTnYps
         Z9ydCmltx0a9sl8lLNZXFFuVqFGPp8NwqPwj9BncqpQGrSdLHrKv3IsIUQ5JPssYeRPH
         zD4Wmf8xRtFaeO5bxykdNqFP4QiXvhdaBdwwGerl2aVHNBMFGShaWTHcQBAUTnjxd/GZ
         fVm4S7eUREsVSCHLd5LE85CPXb7dl4tP3NUwc/QnpNBoRNLPvdTHih0q4L5r+mvU4OzN
         aLlw==
X-Gm-Message-State: AAQBX9fL/Ro7gAO73Kz4oTBy+muZWdBRPjPSDlg8uhIfKV0QfiO8GI+x
        TNbcrgOfoa+PYfeczcNeU4yzxL1IK73pqdah3q5UJVCEtXDCOBs69hVq+Qh8X5/OHVs54ZQ5vVR
        SJlsndK27Ph34nDgVs8IVW6sK
X-Received: by 2002:a05:622a:1816:b0:3e6:45c7:cf36 with SMTP id t22-20020a05622a181600b003e645c7cf36mr4507542qtc.2.1681317925220;
        Wed, 12 Apr 2023 09:45:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+HrIjE4VkqiqM0waR7nZs5KpOic28Y2xavh1QsIMJZkK6W8GnSwnURyYGigGHyvQoxq9B1Q==
X-Received: by 2002:a05:622a:1816:b0:3e6:45c7:cf36 with SMTP id t22-20020a05622a181600b003e645c7cf36mr4507479qtc.2.1681317924355;
        Wed, 12 Apr 2023 09:45:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 73-20020a37064c000000b0074acd1b32f5sm112009qkg.83.2023.04.12.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:45:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 28/31] selftests/mm: Allow uffd test to skip properly with no privilege
Date:   Wed, 12 Apr 2023 12:45:20 -0400
Message-Id: <20230412164520.329163-1-peterx@redhat.com>
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

Allow skip a unit test properly due to no privilege (e.g. sigbus and events
tests).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 27 ++++++++++++--------
 tools/testing/selftests/mm/uffd-common.h     |  4 +--
 tools/testing/selftests/mm/uffd-stress.c     |  6 +++--
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 +++++---
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 12ac84712a38..3e98e129f8bd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -232,7 +232,7 @@ void uffd_stats_report(struct uffd_args *args, int n_cpus)
 	printf("\n");
 }
 
-void userfaultfd_open(uint64_t *features)
+int userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
@@ -241,18 +241,19 @@ void userfaultfd_open(uint64_t *features)
 	else
 		uffd = uffd_open_sys(UFFD_FLAGS);
 	if (uffd < 0)
-		err("uffd open failed (dev=%d)", test_dev_userfaultfd);
+		return -1;
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = *features;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
-		err("UFFDIO_API failed.\nPlease make sure to "
-		    "run with either root or ptrace capability.");
+		/* Probably lack of CAP_PTRACE? */
+		return -1;
 	if (uffdio_api.api != UFFD_API)
 		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
 
 	*features = uffdio_api.features;
+	return 0;
 }
 
 static inline void munmap_area(void **area)
@@ -295,7 +296,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_remap);
 }
 
-int uffd_test_ctx_init(uint64_t features)
+int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 {
 	unsigned long nr, cpu;
 	int ret;
@@ -303,13 +304,19 @@ int uffd_test_ctx_init(uint64_t features)
 	uffd_test_ctx_clear();
 
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
-	if (ret)
-		return ret;
-	ret = uffd_test_ops->allocate_area((void **)&area_dst, false);
-	if (ret)
+	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
+	if (ret) {
+		if (errmsg)
+			*errmsg = "memory allocation failed";
 		return ret;
+	}
 
-	userfaultfd_open(&features);
+	ret = userfaultfd_open(&features);
+	if (ret) {
+		if (errmsg)
+			*errmsg = "possible lack of priviledge";
+		return ret;
+	}
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
 	if (!count_verify)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 4bd5915cf5b4..32e590ce9442 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -101,8 +101,8 @@ extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
-int uffd_test_ctx_init(uint64_t features);
-void userfaultfd_open(uint64_t *features);
+int uffd_test_ctx_init(uint64_t features, const char **errmsg);
+int userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index d78f88850011..c0e804f05002 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -271,7 +271,8 @@ static int userfaultfd_stress(void)
 	struct uffd_args args[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
 
-	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
+	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
+		err("context init failed");
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
@@ -435,7 +436,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	userfaultfd_open(&features);
+	if (userfaultfd_open(&features))
+		err("Userfaultfd open failed");
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index a33d6c928eeb..b0acf558e8cb 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -172,7 +172,8 @@ static int test_uffd_api(bool use_dev)
  * This function initializes the global variables.  TODO: remove global
  * vars and then remove this.
  */
-static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
+static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
+				  const char **errmsg)
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
@@ -186,7 +187,7 @@ static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
 	/* TODO: remove this global var.. it's so ugly */
 	nr_cpus = 1;
 
-	return uffd_test_ctx_init(test->uffd_feature_required);
+	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
 }
 
 static bool uffd_feature_supported(uffd_test_case_t *test)
@@ -835,6 +836,7 @@ int main(int argc, char *argv[])
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
 	char test_name[128];
+	const char *errmsg;
 	int has_uffd;
 	int i, j;
 
@@ -860,8 +862,8 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(test, mem_type)) {
-				uffd_test_skip("environment setup failed");
+			if (uffd_setup_environment(test, mem_type, &errmsg)) {
+				uffd_test_skip(errmsg);
 				continue;
 			}
 			test->uffd_fn();
-- 
2.39.1

