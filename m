Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6569162C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBJBWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBJBWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:22:05 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609DB5D3D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:22:04 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PCbYk6QnNz501Qf;
        Fri, 10 Feb 2023 09:22:02 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 31A1LuBR026416;
        Fri, 10 Feb 2023 09:21:56 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 10 Feb 2023 09:21:57 +0800 (CST)
Date:   Fri, 10 Feb 2023 09:21:57 +0800 (CST)
X-Zmail-TransId: 2b0363e59c35ffffffffa055065e
X-Mailer: Zmail v1.0
Message-ID: <202302100921574141612@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY2IDYvNl0gc2VsZnRlc3Q6IGFkZCB0ZXN0aW5nIHVuc2hhcmluZyBhbmQgY291bnRpbmcga3NtIHplcm8KIHBhZ2U=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31A1LuBR026416
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E59C3A.001/4PCbYk6QnNz501Qf
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
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

v5->v6:
According to David's suggestions, the following changes are made:
1) Rename check_ksm_zero_pages_count() -> ksm_get_zero_pages(), and do the
   comparison outside.
2) Open all global fd from main() rather than the test case.
3) Remove COW-related test codes and focus on explicit unmerging here.
4) Add some coments to explain why wait_two_full_scans is required.
5) Clean up some unneed changes.

v4->v5:
fix error of "} while (end_scans < start_scans + 20);" to
"} while (end_scans < start_scans + 2);" in wait_two_full_scans().
---
 tools/testing/selftests/vm/ksm_functional_tests.c | 96 ++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/vm/ksm_functional_tests.c
index b11b7e5115dc..3033cd6ed3b4 100644
--- a/tools/testing/selftests/vm/ksm_functional_tests.c
+++ b/tools/testing/selftests/vm/ksm_functional_tests.c
@@ -24,9 +24,12 @@

 #define KiB 1024u
 #define MiB (1024 * KiB)
+#define PageSize (4 * KiB)

 static int ksm_fd;
 static int ksm_full_scans_fd;
+static int ksm_zero_pages_fd;
+static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;

@@ -57,6 +60,21 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	return false;
 }

+static long ksm_get_zero_pages(void)
+{
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
+	return ksm_zero_pages;
+}
+
 static long ksm_get_full_scans(void)
 {
 	char buf[10];
@@ -70,15 +88,12 @@ static long ksm_get_full_scans(void)
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
@@ -89,6 +104,34 @@ static int ksm_merge(void)
 	return 0;
 }

+static inline int ksm_merge(void)
+{
+	/* Wait for two full scans such that any possible merging happened. */
+	if (write(ksm_fd, "1", 1) != 1)
+		return -errno;
+
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
+	/*
+	 * Wait for two full scans such that any possible unmerging of zero
+	 * pages happened. Why? Because the unmerge action of zero pages is not
+	 * done in the context of madvise(), but in the context of
+	 * unshare_zero_pages() of the ksmd thread.
+	 */
+	return wait_two_full_scans();
+}
+
 static char *mmap_and_merge_range(char val, unsigned long size)
 {
 	char *map;
@@ -146,6 +189,48 @@ static void test_unmerge(void)
 	munmap(map, size);
 }

+static void test_unmerge_zero_pages(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+	unsigned long pages_expected;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	/* Confirm the interfaces*/
+	if (ksm_zero_pages_fd < 0) {
+		ksft_test_result_skip("open(\"/sys/kernel/mm/ksm/zero_pages_sharing\") failed\n");
+		return;
+	}
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
+	if (map == MAP_FAILED)
+		return;
+
+	if (unmerge_zero_page(map + size / 2, size / 2))
+		goto unmap;
+
+	/* Check if zero_pages_sharing can be update correctly when unmerge */
+	pages_expected = (size / 2) / PageSize;
+	ksft_test_result(pages_expected == ksm_get_zero_pages(),
+						"zero page count react to unmerge\n");
+
+	/* Check if ksm zero pages are really unmerged */
+	ksft_test_result(!range_maps_duplicates(map + size / 2, size / 2),
+						"KSM zero pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
 static void test_unmerge_discarded(void)
 {
 	const unsigned int size = 2 * MiB;
@@ -264,8 +349,11 @@ int main(int argc, char **argv)
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
+	ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/zero_pages_sharing", O_RDONLY);
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);

 	test_unmerge();
+	test_unmerge_zero_pages();
 	test_unmerge_discarded();
 #ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-- 
2.15.2
