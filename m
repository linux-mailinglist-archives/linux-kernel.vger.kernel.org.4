Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43172D803
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbjFMDMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbjFMDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:11:11 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E47172A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:09:50 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id D996AE22D8; Tue, 13 Jun 2023 11:09:48 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>
Subject: [PATCH RESEND v10 5/5] selftest: add a testcase of ksm zero pages
Date:   Tue, 13 Jun 2023 11:09:47 +0800
Message-Id: <20230613030947.186089-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202306131104554703428@zte.com.cn>
References: <202306131104554703428@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add a function test_unmerge_zero_page() to test the functionality on
unsharing and counting ksm-placed zero pages and counting of this patch
series.

test_unmerge_zero_page() actually contains four subjct test objects:
(1) whether the count of ksm zero pages can update correctly after merging;
(2) whether the count of ksm zero pages can update correctly after
    unmerging by madvise(...MADV_UNMERGEABLE);
(3) whether the count of ksm zero pages can update correctly after
	unmerging by triggering write fault.
(4) whether ksm zero pages are really unmerged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 98 ++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 26853badae70..0de9d33cd565 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -29,6 +29,8 @@
 
 static int ksm_fd;
 static int ksm_full_scans_fd;
+static int proc_self_ksm_stat_fd;
+static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;
 
@@ -59,6 +61,33 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	return false;
 }
 
+static long get_my_ksm_zero_pages(void)
+{
+	char buf[200];
+	char *substr_ksm_zero;
+	size_t value_pos;
+	ssize_t read_size;
+	unsigned long my_ksm_zero_pages;
+
+	if (!proc_self_ksm_stat_fd)
+		return 0;
+
+	read_size = pread(proc_self_ksm_stat_fd, buf, sizeof(buf) - 1, 0);
+	if (read_size < 0)
+		return -errno;
+
+	buf[read_size] = 0;
+
+	substr_ksm_zero = strstr(buf, "ksm_zero_pages");
+	if (!substr_ksm_zero)
+		return 0;
+
+	value_pos = strcspn(substr_ksm_zero, "0123456789");
+	my_ksm_zero_pages = strtol(substr_ksm_zero + value_pos, NULL, 10);
+
+	return my_ksm_zero_pages;
+}
+
 static long ksm_get_full_scans(void)
 {
 	char buf[10];
@@ -159,6 +188,70 @@ static void test_unmerge(void)
 	munmap(map, size);
 }
 
+static void test_unmerge_zero_pages(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+	unsigned int offs;
+	unsigned long pages_expected;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	if (proc_self_ksm_stat_fd < 0) {
+		ksft_test_result_skip("open(\"/proc/self/ksm_stat\") failed\n");
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
+	/* Let KSM deduplicate zero pages. */
+	map = mmap_and_merge_range(0x00, size, false);
+	if (map == MAP_FAILED)
+		return;
+
+	/* Check if ksm_zero_pages is updated correctly after KSM merging */
+	pages_expected = size / pagesize;
+	if (pages_expected != get_my_ksm_zero_pages()) {
+		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
+		goto unmap;
+	}
+
+	/* Try to unmerge half of the region */
+	if (madvise(map, size / 2, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto unmap;
+	}
+
+	/* Check if ksm_zero_pages is updated correctly after unmerging */
+	pages_expected /= 2;
+	if (pages_expected != get_my_ksm_zero_pages()) {
+		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
+		goto unmap;
+	}
+
+	/* Trigger unmerging of the other half by writing to the pages. */
+	for (offs = size / 2; offs < size; offs += pagesize)
+		*((unsigned int *)&map[offs]) = offs;
+
+	/* Now we should have no zeropages remaining. */
+	if (get_my_ksm_zero_pages()) {
+		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
+		goto unmap;
+	}
+
+	/* Check if ksm zero pages are really unmerged */
+	ksft_test_result(!range_maps_duplicates(map, size),
+			"KSM zero pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
 static void test_unmerge_discarded(void)
 {
 	const unsigned int size = 2 * MiB;
@@ -358,7 +451,7 @@ static void test_prctl_unmerge(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int tests = 5;
+	unsigned int tests = 6;
 	int err;
 
 #ifdef __NR_userfaultfd
@@ -379,8 +472,11 @@ int main(int argc, char **argv)
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
+	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
 
 	test_unmerge();
+	test_unmerge_zero_pages();
 	test_unmerge_discarded();
 #ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-- 
2.15.2
