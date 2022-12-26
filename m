Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3D655F21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 03:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiLZCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 21:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 21:08:57 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59938AB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 18:08:56 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NgLn06Lxpz8R041;
        Mon, 26 Dec 2022 10:08:52 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2BQ28cmB058499;
        Mon, 26 Dec 2022 10:08:38 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 26 Dec 2022 10:08:39 +0800 (CST)
Date:   Mon, 26 Dec 2022 10:08:39 +0800 (CST)
X-Zmail-TransId: 2b0363a90227ffffffff9d783c60
X-Mailer: Zmail v1.0
Message-ID: <202212261008399750363@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDYvNl0gc2VsZnRlc3Q6IGFkZCB0ZXN0aW5nIHVuc2hhcmluZyBhbmQgY291bnRpbmcga3NtIHplcm8KIHBhZ2Vz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BQ28cmB058499
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A90234.000 by FangMail milter!
X-FangMail-Envelope: 1672020532/4NgLn06Lxpz8R041/63A90234.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A90234.000/4NgLn06Lxpz8R041
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add a function test_unmerge_zero_page() to test the functionality on
unsharing and counting ksm-placed zero pages and counting of this patch
series.

test_unmerge_zero_page() actually contains three subjct test objects:
	1) whether the count of ksm zero page can react correctly to cow
	   (copy on write);
	2) whether the count of ksm zero page can react correctly to unmerge;
	3) whether ksm zero pages are really unmerged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 tools/testing/selftests/vm/ksm_functional_tests.c | 105 ++++++++++++++++++++--
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/vm/ksm_functional_tests.c
index b11b7e5115dc..2c50c14d42db 100644
--- a/tools/testing/selftests/vm/ksm_functional_tests.c
+++ b/tools/testing/selftests/vm/ksm_functional_tests.c
@@ -27,6 +27,8 @@

 static int ksm_fd;
 static int ksm_full_scans_fd;
+static int ksm_zero_pages_fd;
+static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;

@@ -57,6 +59,22 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	return false;
 }

+static bool check_ksm_zero_pages_count(unsigned long zero_size)
+{
+	unsigned long pages_expected = zero_size / (4 * KiB);
+	char buf[20];
+	ssize_t read_size;
+	unsigned long ksm_zero_pages;
+
+	read_size = pread(ksm_zero_pages_fd, buf, sizeof(buf) - 1, 0);
+	if (read_size < 0)
+		return -errno;
+	buf[read_size] = 0;
+	ksm_zero_pages = strtol(buf, NULL, 10);
+
+	return ksm_zero_pages == pages_expected;
+}
+
 static long ksm_get_full_scans(void)
 {
 	char buf[10];
@@ -70,25 +88,50 @@ static long ksm_get_full_scans(void)
 	return strtol(buf, NULL, 10);
 }

-static int ksm_merge(void)
+static int wait_two_full_scans(void)
 {
 	long start_scans, end_scans;

-	/* Wait for two full scans such that any possible merging happened. */
 	start_scans = ksm_get_full_scans();
 	if (start_scans < 0)
-		return start_scans;
-	if (write(ksm_fd, "1", 1) != 1)
 		return -errno;
 	do {
 		end_scans = ksm_get_full_scans();
 		if (end_scans < 0)
 			return end_scans;
-	} while (end_scans < start_scans + 2);
+	} while (end_scans < start_scans + 20);

 	return 0;
 }

+static inline int ksm_merge(void)
+{
+	/* Wait for two full scans such that any possible merging happened. */
+	if (write(ksm_fd, "1", 1) != 1)
+		return -errno;
+	return wait_two_full_scans();
+}
+
+static inline int make_cow(char *map, char val, unsigned long size)
+{
+
+	memset(map, val, size);
+	return wait_two_full_scans();
+}
+
+static int unmerge_zero_page(char *start, unsigned long size)
+{
+	int ret;
+
+	ret = madvise(start, size, MADV_UNMERGEABLE);
+	if (ret) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		return ret;
+	}
+
+	return wait_two_full_scans();
+}
+
 static char *mmap_and_merge_range(char val, unsigned long size)
 {
 	char *map;
@@ -146,6 +189,56 @@ static void test_unmerge(void)
 	munmap(map, size);
 }

+static void test_unmerge_zero_pages(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	/* Confirm the interfaces*/
+	ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/zero_pages_sharing", O_RDONLY);
+	if (ksm_zero_pages_fd < 0) {
+		ksft_test_result_skip("open(\"/sys/kernel/mm/ksm/zero_pages_sharing\") failed\n");
+		return;
+	}
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+	if (ksm_use_zero_pages_fd < 0) {
+		ksft_test_result_skip("open \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
+		return;
+	}
+	if (write(ksm_use_zero_pages_fd, "1", 1) != 1) {
+		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
+		return;
+	}
+
+	/* Mmap zero pages*/
+	map = mmap_and_merge_range(0x00, size);
+
+	/* Case 1: make Writing on ksm zero pages (COW) */
+	if (make_cow(map, 0xcf, size / 2)) {
+		ksft_test_result_fail("COW failed\n");
+		goto unmap;
+	}
+	ksft_test_result(check_ksm_zero_pages_count(size / 2),
+						"zero page count react to cow\n");
+
+	/* Case 2: Call madvise(xxx, MADV_UNMERGEABLE)*/
+	if (unmerge_zero_page(map + size / 2, size / 4)) {
+		ksft_test_result_fail("unmerge_zero_page failed\n");
+		goto unmap;
+	}
+	ksft_test_result(check_ksm_zero_pages_count(size / 4),
+						"zero page count react to unmerge\n");
+
+	/*Check if ksm pages are really unmerged */
+	ksft_test_result(!range_maps_duplicates(map + size / 2, size / 4),
+						"KSM zero pages were unmerged\n");
+
+unmap:
+	munmap(map, size);
+}
+
 static void test_unmerge_discarded(void)
 {
 	const unsigned int size = 2 * MiB;
@@ -261,11 +354,13 @@ int main(int argc, char **argv)
 	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
 	if (ksm_full_scans_fd < 0)
 		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
+
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");

 	test_unmerge();
+	test_unmerge_zero_pages();
 	test_unmerge_discarded();
 #ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-- 
2.15.2
