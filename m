Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81F6D0ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjC3QNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjC3QNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF545E385
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAXTpuab088GPUG02wNB3TGzyfzkRuRXgQ9Q53l/WHY=;
        b=VB7afFUazUyUMWehXBjJSeYo5gxmoX1LRFl6c3/W0PMXTE2EUt+Al9tvze6lSs1P6RpKPp
        4ESCf+hA+oFfTOf+WlFqrnvrrOZV6pIPdqoU/k8495NHW0pDfaSgVcf97YqcTSKaG3b+8/
        mcGSqpNeBtAYrON+Pa6UikLntTVLzxA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-k_o-mmXtOBmdFnGhVnzVyw-1; Thu, 30 Mar 2023 12:08:39 -0400
X-MC-Unique: k_o-mmXtOBmdFnGhVnzVyw-1
Received: by mail-qt1-f197.google.com with SMTP id l13-20020a05622a174d00b003e4df699997so10555398qtk.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192518; x=1682784518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAXTpuab088GPUG02wNB3TGzyfzkRuRXgQ9Q53l/WHY=;
        b=KnTjzIF9unyLxhQ2ibFPxHrkI/HysQga9zhpVgj6sDCk4JuEzSF2ZUmswYQ/rEWEUr
         WiFoHrGUEI2n1O5cc/h3F33qfYOj1LPe3/SszxSMK/B4VmRu42y48lPMVjnMNOnITkPs
         7XwQaNKOW269WAhbwj7XE6PPbAqsI+yKoBYgnNYk5s3PXpVevoHGCh8neJrZJprNytio
         cNKiFc+kco+T4bkYwftpyCSkt9nx5WPKIOV7XHh9dc0w/7s4nRNQvSiPpkRhsWONC3Mb
         CsqfUsV0olfklBWeNqeY6qo27sVHoVz7XXqF0e9Rt0OqCdHLPaED2iYvdrkcFuIJ5OoD
         3e+A==
X-Gm-Message-State: AO0yUKWg9EjUCY1FInhAfR82VEgSLaO0pGuX2CTzlz2x+aCDkw+xsPwC
        lDLR/Z2s6rY0nDCZkEsR+gxDkYs1nTOSs2fFYtZJ1nnn3t3lJy+X3FlP/SMiyuov6AXgEBdVV7u
        d/1i729XmDFr/ATE1ZjT8zEESKzHPb767OtMerC3j6oePNOJ0TaFYdjjMwtAvTSPNZuQ/PCs+zx
        tafC79nQ==
X-Received: by 2002:a05:622a:3c9:b0:3b8:36f8:830e with SMTP id k9-20020a05622a03c900b003b836f8830emr37735721qtx.6.1680192517937;
        Thu, 30 Mar 2023 09:08:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set812uf+kM7Yhq9Ka7uXYBi3m3muJq4kJHafeEAcNFKKp1xJShq8EXVPV3LRZllFJWeH38i74A==
X-Received: by 2002:a05:622a:3c9:b0:3b8:36f8:830e with SMTP id k9-20020a05622a03c900b003b836f8830emr37735663qtx.6.1680192517402;
        Thu, 30 Mar 2023 09:08:37 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r13-20020ac8794d000000b003e638d0aa67sm195332qtt.93.2023.03.30.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:36 -0700 (PDT)
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
Subject: [PATCH 27/29] selftests/mm: Allow uffd test to skip properly with no privilege
Date:   Thu, 30 Mar 2023 12:08:35 -0400
Message-Id: <20230330160835.3107613-1-peterx@redhat.com>
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
index 95ad619d0df4..964fa57b710a 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -225,7 +225,7 @@ void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 	printf("\n");
 }
 
-void userfaultfd_open(uint64_t *features)
+int userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
@@ -234,18 +234,19 @@ void userfaultfd_open(uint64_t *features)
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
@@ -288,7 +289,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_remap);
 }
 
-int uffd_test_ctx_init(uint64_t features)
+int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 {
 	unsigned long nr, cpu;
 	int ret;
@@ -296,13 +297,19 @@ int uffd_test_ctx_init(uint64_t features)
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
index 16d32ddf8412..07d00e9809dc 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -101,8 +101,8 @@ extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
-int uffd_test_ctx_init(uint64_t features);
-void userfaultfd_open(uint64_t *features);
+int uffd_test_ctx_init(uint64_t features, const char **errmsg);
+int userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a6f3609c1ad1..8f41bef2fbda 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -272,7 +272,8 @@ static int userfaultfd_stress(void)
 	struct uffd_stats uffd_stats[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
 
-	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
+	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
+		err("context init failed");
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
@@ -436,7 +437,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	userfaultfd_open(&features);
+	if (userfaultfd_open(&features))
+		err("Userfaultfd open failed");
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 82fd3aaa06c2..9e7f7c7f2982 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -175,7 +175,8 @@ static int test_uffd_api(bool use_dev)
  * This function initializes the global variables.  TODO: remove global
  * vars and then remove this.
  */
-static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
+static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
+				  const char **errmsg)
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
@@ -189,7 +190,7 @@ static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
 	/* TODO: remove this global var.. it's so ugly */
 	nr_cpus = 1;
 
-	return uffd_test_ctx_init(test->uffd_feature_required);
+	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
 }
 
 static bool uffd_feature_supported(uffd_test_case_t *test)
@@ -838,6 +839,7 @@ int main(int argc, char *argv[])
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
 	char test_name[128];
+	const char *errmsg;
 	int has_uffd;
 	int i, j;
 
@@ -863,8 +865,8 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(test, mem_type)) {
-				uffd_test_skip("memory allocation failed");
+			if (uffd_setup_environment(test, mem_type, &errmsg)) {
+				uffd_test_skip(errmsg);
 				continue;
 			}
 			test->uffd_fn();
-- 
2.39.1

