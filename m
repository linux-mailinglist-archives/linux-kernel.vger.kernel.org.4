Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8365E8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAEKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjAEKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A2485A8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g9-20020a25bdc9000000b0073727a20239so36034702ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM1fuebOiYdsKI6sxS1LfWku8C58IPteD/Sei8VpSxQ=;
        b=I8sjFLZnx+aNBRXgBMZRH312QMYInRX5Te2g9nBKTxCe34+OYraFmUgSlUONr2eooJ
         62HtRkoKcvk84eoWTg4qbcUFd2KKx07w9eSKHxyCphfKi6xjhUfineaz01Tx3MjmftXp
         zpVT5lb/OOmri7egZafvXcJTXzLNWPrLvhzt30S+FUXmd1QDJW2D+ASIf6sSrCO2pujj
         Wcuy4YdikybIl74tALJwRxpzS/O3LreoB3I8MFENTfEl2pSn4PDiQF+YbQjOUN/Fl9LC
         tguO+iGWrK5Q4xc2bG/OYNQ+g0mnWemidtzpfKV7SFWPLEAOT5YY+2u3ODxF8u421Xje
         VNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oM1fuebOiYdsKI6sxS1LfWku8C58IPteD/Sei8VpSxQ=;
        b=NvxZxG//tdacZW3tKFFYMVXghjed07XTcXg4w8VISCFMd/xmZ0tfnqKYfNRoqbp8uv
         EBMRJjQ1QUCftSo9o+Ju/gcBAIZZgjv5NWmqnrjj1Dn1UJ4XXBE10Iy5c9bRBeN+yMnx
         ndsD8kbMSqL3i08AfAuSBWCPf9l+5qEa++x4qRonbCyFgkrAVeLp7Q7yA1KO52UMQOJ7
         S/XFOHsZSdJ3VJunX0W5zeZ0Hgnrblg0HW11ujcYwqdKWpsk8n6Pfjs0gdW1TJ+KRca5
         iJxYyJK5h0dHs/r/nTcTWjPqQ7qyA8H2JzcR2QkMqTw/SYxMPoASqESxoBzT+mUj7VM+
         eUwA==
X-Gm-Message-State: AFqh2koomw0z7CO3yZxCCMMXxLIYTcRuf27lfvIA/3t6EruM8i7vsom3
        MPfvtZKFsOZnQqIev9zH74z4VG0xGrXCd/QY
X-Google-Smtp-Source: AMrXdXt1McQ73HGP/bgfACgNt1pvdbvPI5F1rZ+GWu6XhGxvz7s7KKrAed+ZRcqWM42eHH4pUjfYXbqKojyiSuhg
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:25cf:0:b0:426:6938:b154 with SMTP
 id l198-20020a8125cf000000b004266938b154mr102769ywl.511.1672913995101; Thu,
 05 Jan 2023 02:19:55 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:40 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-43-jthoughton@google.com>
Subject: [PATCH 42/46] selftests/vm: add HugeTLB HGM to userfaultfd selftest
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
 tools/testing/selftests/vm/userfaultfd.c | 84 +++++++++++++++++++-----
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7f22844ed704..681c5c5f863b 100644
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
@@ -381,7 +389,7 @@ static struct uffd_test_ops *uffd_test_ops;
 
 static inline uint64_t uffd_minor_feature(void)
 {
-	if (test_type == TEST_HUGETLB && map_shared)
+	if (test_is_hugetlb() && map_shared)
 		return UFFD_FEATURE_MINOR_HUGETLBFS;
 	else if (test_type == TEST_SHMEM)
 		return UFFD_FEATURE_MINOR_SHMEM;
@@ -393,7 +401,7 @@ static uint64_t get_expected_ioctls(uint64_t mode)
 {
 	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
 
-	if (test_type == TEST_HUGETLB)
+	if (test_is_hugetlb())
 		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
 
 	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
@@ -500,13 +508,16 @@ static void uffd_test_ctx_clear(void)
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
@@ -726,13 +737,16 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 				   struct uffd_stats *stats)
 {
 	unsigned long offset;
+	unsigned long address;
 
 	if (msg->event != UFFD_EVENT_PAGEFAULT)
 		err("unexpected msg event %u", msg->event);
 
+	address = msg->arg.pagefault.address;
+
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
-		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		wp_range(uffd, address, page_size, false);
 		stats->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
@@ -751,11 +765,10 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
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
@@ -782,7 +795,7 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
 			err("unexpected write fault");
 
-		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+		offset = (char *)address - area_dst;
 		offset &= ~(page_size-1);
 
 		if (copy_page(uffd, offset))
@@ -1192,6 +1205,12 @@ static int userfaultfd_events_test(void)
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
 
@@ -1245,6 +1264,12 @@ static int userfaultfd_sig_test(void)
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
 
@@ -1329,6 +1354,11 @@ static int userfaultfd_minor_test(void)
 
 	uffd_test_ctx_init(uffd_minor_feature());
 
+	if (test_type == TEST_HUGETLB_HGM)
+		/* Enable high-granularity userfaultfd ioctls for HugeTLB */
+		if (madvise(area_dst_alias, nr_pages * page_size, MADV_SPLIT))
+			err("MADV_SPLIT failed");
+
 	uffdio_register.range.start = (unsigned long)area_dst_alias;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
@@ -1538,6 +1568,12 @@ static int userfaultfd_stress(void)
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
@@ -1696,6 +1732,16 @@ static void set_test_type(const char *type)
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
@@ -1731,6 +1777,7 @@ static void parse_test_type_arg(const char *raw_type)
 		err("Unsupported test: %s", raw_type);
 
 	if (test_type == TEST_HUGETLB)
+		/* TEST_HUGETLB_HGM gets small pages. */
 		page_size = hpage_size;
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
@@ -1813,22 +1860,29 @@ int main(int argc, char **argv)
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
2.39.0.314.g84b9a713c41-goog

