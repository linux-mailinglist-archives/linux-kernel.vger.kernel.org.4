Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FC70BB90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjEVLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjEVLQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:16:31 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C482690
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:11:07 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 23C14E1ED8; Mon, 22 May 2023 18:54:35 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v8 6/6] selftest: add a testcase of ksm zero pages
Date:   Mon, 22 May 2023 18:54:33 +0800
Message-Id: <20230522105433.4277-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305221842587200002@zte.com.cn>
References: <202305221842587200002@zte.com.cn>
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

test_unmerge_zero_page() actually contains three subjct test objects:
(1) whether the count of ksm zero pages can update correctly after merging;
(2) whether the count of ksm zero pages can update correctly after
    unmerging;
(3) whether ksm zero pages are really unmerged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 26853badae70..9b7fb94ed64f 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -29,6 +29,8 @@
 
 static int ksm_fd;
 static int ksm_full_scans_fd;
+static int ksm_zero_pages_fd;
+static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;
 
@@ -59,6 +61,21 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	return false;
 }
 
+static long get_ksm_zero_pages(void)
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
@@ -159,6 +176,61 @@ static void test_unmerge(void)
 	munmap(map, size);
 }
 
+static inline unsigned long expected_ksm_pages(unsigned long mergeable_size)
+{
+	return mergeable_size / pagesize;
+}
+
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
+		ksft_test_result_skip("open(\"/sys/kernel/mm/ksm/ksm_zero_pages\") failed\n");
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
+	map = mmap_and_merge_range(0x00, size, false);
+	if (map == MAP_FAILED)
+		return;
+
+	/* Check if ksm_zero_pages can be update correctly after merging */
+	pages_expected = expected_ksm_pages(size);
+	ksft_test_result(pages_expected == get_ksm_zero_pages(),
+		"The count zero_page_sharing was updated after merging\n");
+
+	/* try to unmerge half of the region */
+	if (madvise(map, size / 2, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto unmap;
+	}
+
+	/* Check if ksm_zero_pages can be update correctly after unmerging */
+	pages_expected = expected_ksm_pages(size / 2);
+	ksft_test_result(pages_expected == get_ksm_zero_pages(),
+		"The count zero_page_sharing was updated after unmerging\n");
+
+	/* Check if ksm zero pages are really unmerged */
+	ksft_test_result(!range_maps_duplicates(map, size / 2),
+				"KSM zero pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
 static void test_unmerge_discarded(void)
 {
 	const unsigned int size = 2 * MiB;
@@ -379,8 +451,11 @@ int main(int argc, char **argv)
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
+	ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/ksm_zero_pages", O_RDONLY);
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
 
 	test_unmerge();
+	test_unmerge_zero_pages();
 	test_unmerge_discarded();
 #ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-- 
2.15.2
