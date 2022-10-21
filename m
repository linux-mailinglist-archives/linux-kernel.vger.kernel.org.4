Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28E6074B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJUKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJUKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D07AB02
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpvAVKz3qbonI1lfYmBeIQnX7aY+jIE8nipT3HyDP+I=;
        b=hGn4Rrsh3VNBWXJms6MSicok7N8j0Gus4wUhPP81jDPsGZJrzKb0sfpAjnir6udNQ0yKSf
        yw6KzCqiEBXSGr0jcRUwws6TFr5lwKqx+3Mfdtnyqb/39eDRoO3zh/A6fDiTYBNbHb32Wo
        Yyh0EQbrZWndNbBbt2Iru1++myf+W3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-HesOCGjDNr6QxqCIcGuzdw-1; Fri, 21 Oct 2022 06:12:05 -0400
X-MC-Unique: HesOCGjDNr6QxqCIcGuzdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C98387A386;
        Fri, 21 Oct 2022 10:12:04 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB8CA40D2998;
        Fri, 21 Oct 2022 10:11:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/9] selftests/vm: add test to measure MADV_UNMERGEABLE performance
Date:   Fri, 21 Oct 2022 12:11:33 +0200
Message-Id: <20221021101141.84170-2-david@redhat.com>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a test to measure performance of KSM breaking not triggered
via COW, but triggered by disabling KSM on an area filled with KSM pages
via MADV_UNMERGEABLE.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 76 +++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 0d85be2350fa..f9eb4d67e0dd 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -40,6 +40,7 @@ enum ksm_test_name {
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
 	KSM_MERGE_TIME_HUGE_PAGES,
+	KSM_UNMERGE_TIME,
 	KSM_COW_TIME
 };
 
@@ -108,7 +109,10 @@ static void print_help(void)
 	       " -P evaluate merging time and speed.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\n"
 	       "    must be provided using -s option\n"
-				 " -H evaluate merging time and speed of area allocated mostly with huge pages\n"
+	       " -H evaluate merging time and speed of area allocated mostly with huge pages\n"
+	       "    For this test, the size of duplicated memory area (in MiB)\n"
+	       "    must be provided using -s option\n"
+	       " -D evaluate unmerging time and speed when disabling KSM.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\n"
 	       "    must be provided using -s option\n"
 	       " -C evaluate the time required to break COW of merged pages.\n\n");
@@ -188,6 +192,16 @@ static int ksm_merge_pages(void *addr, size_t size, struct timespec start_time,
 	return 0;
 }
 
+static int ksm_unmerge_pages(void *addr, size_t size,
+			     struct timespec start_time, int timeout)
+{
+	if (madvise(addr, size, MADV_UNMERGEABLE)) {
+		perror("madvise");
+		return 1;
+	}
+	return 0;
+}
+
 static bool assert_ksm_pages_count(long dupl_page_count)
 {
 	unsigned long max_page_sharing, pages_sharing, pages_shared;
@@ -560,6 +574,53 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 	return KSFT_FAIL;
 }
 
+static int ksm_unmerge_time(int mapping, int prot, int timeout, size_t map_size)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	unsigned long scan_time_ns;
+
+	map_size *= MB;
+
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
+	if (!map_ptr)
+		return KSFT_FAIL;
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+		goto err_out;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	if (ksm_unmerge_pages(map_ptr, map_size, start_time, timeout))
+		goto err_out;
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+
+	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
+		       (end_time.tv_nsec - start_time.tv_nsec);
+
+	printf("Total size:    %lu MiB\n", map_size / MB);
+	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+	       scan_time_ns % NSEC_PER_SEC);
+	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+					       ((double)scan_time_ns / NSEC_PER_SEC));
+
+	munmap(map_ptr, map_size);
+	return KSFT_PASS;
+
+err_out:
+	printf("Not OK\n");
+	munmap(map_ptr, map_size);
+	return KSFT_FAIL;
+}
+
 static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size)
 {
 	void *map_ptr;
@@ -644,7 +705,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCH")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCHD")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -701,6 +762,9 @@ int main(int argc, char *argv[])
 		case 'H':
 			test_name = KSM_MERGE_TIME_HUGE_PAGES;
 			break;
+		case 'D':
+			test_name = KSM_UNMERGE_TIME;
+			break;
 		case 'C':
 			test_name = KSM_COW_TIME;
 			break;
@@ -762,6 +826,14 @@ int main(int argc, char *argv[])
 		ret = ksm_merge_hugepages_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
 				ksm_scan_limit_sec, size_MB);
 		break;
+	case KSM_UNMERGE_TIME:
+		if (size_MB == 0) {
+			printf("Option '-s' is required.\n");
+			return KSFT_FAIL;
+		}
+		ret = ksm_unmerge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				       ksm_scan_limit_sec, size_MB);
+		break;
 	case KSM_COW_TIME:
 		ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				   page_size);
-- 
2.37.3

