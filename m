Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C72607C89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiJUQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiJUQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCDC2892F2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v17-20020a259d91000000b006b4c31c0640so3723404ybp.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdHnE7caiqm4qshIBX12p5Rv53BpHm3Kmd+OvWlvh64=;
        b=BIwoTuKHg0KVxAgZkQCtc2lTNtp6Y3O1lU/37+Hr0O/jeYU6gp+nzdB+H8m1NuA1ZL
         VfIhzTnIwplVj+yHE00lZr+dFVwGgjXrUD+N5kHCoV/HhA1HAXwQNy9x27lvlVlgLIwf
         DtjoIt6kkMc1YxnjeRuFwMF1WhDCfWcSqQA8ZPBcfbEojzPyzzD3dfJjCbyiR5Oc3sTY
         SGe/+kTodt8Pm9AEqQzXBD2m1LtQnlBciskGh6NtkTnRzM+71sNNQHKJjcxjPPCLNpaD
         NGLrnmbOnuJ8iS/HFbyXfe7oQTovhAfVGgN7uv4nuezupV5Y/VexoSSWmkqo3fUcEME7
         XpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdHnE7caiqm4qshIBX12p5Rv53BpHm3Kmd+OvWlvh64=;
        b=azDVOvfrkK2fNG02OQG5hoy9ZY34fQA4opA8NXen0NuyR1G7MrwMzSj86estGiRFJE
         etSjwdWBG8E0BQrvvs6sgWpP6MqUbNYo5ealYFu7h/8gktm1Q77hlLOF4Ov2yEuNXlhH
         LZ1d+S8yfD97Y59tWAIgbyN0JZPVoQvkCepti7j6V0uzAPelCpyGIUf/3nrwpgZ7os63
         rx/GDseUzf9u1v3O0/kHxLjjNctheX1m3/aZpuWpPL2ca+4hyotBiI149osGSg1NTxBV
         rOotXr36HwOhT0Z4m7It5nt7u0i3TREafJUOZydGGO/BDFw7zEo8TnaGYcRbdDhOVDcw
         VajA==
X-Gm-Message-State: ACrzQf1ryhCG6IwN3JPq/uJJ2qmogDH68aVegpp67sU3UpDHF0EIA5i9
        b6um56cgf2jf/lk5lf952AhBqPBAQibu5q0B
X-Google-Smtp-Source: AMsMyM5h7Qfvjj2U3dA4nHJgEpkUrpiMmGEWdmjeehuzwUrU0UvEY2wo0j6MknJytybv7NpgRlPVlv0RuroSad+t
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:e402:0:b0:368:5f54:d94b with SMTP
 id n2-20020a0de402000000b003685f54d94bmr8815902ywe.519.1666370276754; Fri, 21
 Oct 2022 09:37:56 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:59 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-44-jthoughton@google.com>
Subject: [RFC PATCH v2 43/47] selftests/vm: add HugeTLB HGM to userfaultfd selftest
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test case behaves similarly to the regular shared HugeTLB
configuration, except that it uses 4K instead of hugepages, and that we
ignore the UFFDIO_COPY tests, as UFFDIO_CONTINUE is the only ioctl that
supports PAGE_SIZE-aligned regions.

This doesn't test MADV_COLLAPSE. Other tests are added later to exercise
MADV_COLLAPSE.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 90 +++++++++++++++++++-----
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7f22844ed704..c9cdfb20f292 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -73,9 +73,10 @@ static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
 #define BOUNCE_POLL		(1<<3)
 static int bounces;
 
-#define TEST_ANON	1
-#define TEST_HUGETLB	2
-#define TEST_SHMEM	3
+#define TEST_ANON		1
+#define TEST_HUGETLB		2
+#define TEST_HUGETLB_HGM	3
+#define TEST_SHMEM		4
 static int test_type;
 
 #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
@@ -93,6 +94,8 @@ static volatile bool test_uffdio_zeropage_eexist = true;
 static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
+static bool test_uffdio_copy = true;
+
 static bool map_shared;
 static int mem_fd;
 static unsigned long long *count_verify;
@@ -151,7 +154,7 @@ static void usage(void)
 	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
 		"[hugetlbfs_file]\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
-		"hugetlb_shared, shmem\n\n");
+		"hugetlb_shared, hugetlb_shared_hgm, shmem\n\n");
 	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
 		"Supported mods:\n");
 	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
@@ -167,6 +170,11 @@ static void usage(void)
 	exit(1);
 }
 
+static bool test_is_hugetlb(void)
+{
+	return test_type == TEST_HUGETLB || test_type == TEST_HUGETLB_HGM;
+}
+
 #define _err(fmt, ...)						\
 	do {							\
 		int ret = errno;				\
@@ -381,8 +389,12 @@ static struct uffd_test_ops *uffd_test_ops;
 
 static inline uint64_t uffd_minor_feature(void)
 {
-	if (test_type == TEST_HUGETLB && map_shared)
-		return UFFD_FEATURE_MINOR_HUGETLBFS;
+	if (test_is_hugetlb() && map_shared)
+		return UFFD_FEATURE_MINOR_HUGETLBFS |
+			(test_type == TEST_HUGETLB_HGM
+			 ? (UFFD_FEATURE_MINOR_HUGETLBFS_HGM |
+				 UFFD_FEATURE_EXACT_ADDRESS)
+			 : 0);
 	else if (test_type == TEST_SHMEM)
 		return UFFD_FEATURE_MINOR_SHMEM;
 	else
@@ -393,7 +405,7 @@ static uint64_t get_expected_ioctls(uint64_t mode)
 {
 	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
 
-	if (test_type == TEST_HUGETLB)
+	if (test_is_hugetlb())
 		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
 
 	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
@@ -500,13 +512,16 @@ static void uffd_test_ctx_clear(void)
 static void uffd_test_ctx_init(uint64_t features)
 {
 	unsigned long nr, cpu;
+	uint64_t enabled_features = features;
 
 	uffd_test_ctx_clear();
 
 	uffd_test_ops->allocate_area((void **)&area_src, true);
 	uffd_test_ops->allocate_area((void **)&area_dst, false);
 
-	userfaultfd_open(&features);
+	userfaultfd_open(&enabled_features);
+	if ((enabled_features & features) != features)
+		err("couldn't enable all features");
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
 	if (!count_verify)
@@ -726,13 +741,21 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 				   struct uffd_stats *stats)
 {
 	unsigned long offset;
+	unsigned long address;
 
 	if (msg->event != UFFD_EVENT_PAGEFAULT)
 		err("unexpected msg event %u", msg->event);
 
+	/*
+	 * Round down address to nearest page_size.
+	 * We do this manually because we specified UFFD_FEATURE_EXACT_ADDRESS
+	 * to support UFFD_FEATURE_MINOR_HUGETLBFS_HGM.
+	 */
+	address = msg->arg.pagefault.address & ~(page_size - 1);
+
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
-		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		wp_range(uffd, address, page_size, false);
 		stats->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
@@ -751,11 +774,10 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		 */
 
 		area = (uint8_t *)(area_dst +
-				   ((char *)msg->arg.pagefault.address -
-				    area_dst_alias));
+				   ((char *)address - area_dst_alias));
 		for (b = 0; b < page_size; ++b)
 			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size);
+		continue_range(uffd, address, page_size);
 		stats->minor_faults++;
 	} else {
 		/*
@@ -782,7 +804,7 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
 			err("unexpected write fault");
 
-		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+		offset = (char *)address - area_dst;
 		offset &= ~(page_size-1);
 
 		if (copy_page(uffd, offset))
@@ -1192,6 +1214,12 @@ static int userfaultfd_events_test(void)
 	char c;
 	struct uffd_stats stats = { 0 };
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd events test "
+			"(test_uffdio_copy=false)\n");
+		return 0;
+	}
+
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
@@ -1245,6 +1273,12 @@ static int userfaultfd_sig_test(void)
 	char c;
 	struct uffd_stats stats = { 0 };
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd signal test "
+			"(test_uffdio_copy=false)\n");
+		return 0;
+	}
+
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
@@ -1538,6 +1572,12 @@ static int userfaultfd_stress(void)
 	pthread_attr_init(&attr);
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd stress test "
+			"(test_uffdio_copy=false)\n");
+		bounces = 0;
+	}
+
 	while (bounces--) {
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
@@ -1696,6 +1736,16 @@ static void set_test_type(const char *type)
 		uffd_test_ops = &hugetlb_uffd_test_ops;
 		/* Minor faults require shared hugetlb; only enable here. */
 		test_uffdio_minor = true;
+	} else if (!strcmp(type, "hugetlb_shared_hgm")) {
+		map_shared = true;
+		test_type = TEST_HUGETLB_HGM;
+		uffd_test_ops = &hugetlb_uffd_test_ops;
+		/*
+		 * HugeTLB HGM only changes UFFDIO_CONTINUE, so don't test
+		 * UFFDIO_COPY.
+		 */
+		test_uffdio_minor = true;
+		test_uffdio_copy = false;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
@@ -1731,6 +1781,7 @@ static void parse_test_type_arg(const char *raw_type)
 		err("Unsupported test: %s", raw_type);
 
 	if (test_type == TEST_HUGETLB)
+		/* TEST_HUGETLB_HGM gets small pages. */
 		page_size = hpage_size;
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
@@ -1813,22 +1864,29 @@ int main(int argc, char **argv)
 		nr_cpus = x < y ? x : y;
 	}
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
+	if (test_type == TEST_HUGETLB_HGM)
+		/*
+		 * `page_size` refers to the page_size we can use in
+		 * UFFDIO_CONTINUE. We still need nr_pages to be appropriately
+		 * aligned, so align it here.
+		 */
+		nr_pages_per_cpu -= nr_pages_per_cpu % (hpage_size / page_size);
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
 		usage();
 	}
+	nr_pages = nr_pages_per_cpu * nr_cpus;
 
 	bounces = atoi(argv[3]);
 	if (bounces <= 0) {
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
+	if (test_type == TEST_SHMEM || test_is_hugetlb()) {
 		unsigned int memfd_flags = 0;
 
-		if (test_type == TEST_HUGETLB)
+		if (test_is_hugetlb())
 			memfd_flags = MFD_HUGETLB;
 		mem_fd = memfd_create(argv[0], memfd_flags);
 		if (mem_fd < 0)
-- 
2.38.0.135.g90850a2211-goog

