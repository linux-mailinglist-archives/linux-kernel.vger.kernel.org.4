Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429F6F0FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjD1AmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbjD1AmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:42:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88D40FB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99ef860a40so7583894276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642515; x=1685234515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83gQugE5cbaf4bRjalHdDmK4/joJvX/FU1hRUwFi3sU=;
        b=lkIUSE2Y29UDUiwiH/PXq03j0d2aozkiWLLGwRUxJKBzv349gzdyhvqftmJ2Fu62zY
         jMWxszNhpeRS5y3kImN5n2opTgBWFzDwuqKRzgYyjj6M0n66z7iMvb+tEcCceMdcsBOp
         Yeb8sup8/qzQ53OohH3ZK9C3z9mQqNbOrxs+PHi1sWeypkY3IZhF0GeGg2khyzhtLKeV
         DWO5IYJmpJdERF9S5Pot3hgD65WiP9Z2x3emz7ewMNj79q9jZZcAwhpTWXAelkXAdsUG
         qsrxPQRSj6bArSMm1jg0g9gbmM8D0ht2i0W9PUL5DphQLDMfi4v6IBF2iF6Uhh+G6NXh
         45Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642515; x=1685234515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83gQugE5cbaf4bRjalHdDmK4/joJvX/FU1hRUwFi3sU=;
        b=b/o7N4/oj2IwMT/kePUAKe+trRtwC3AcHGJ2iIcts91zhq8QPs4m2GgYL+zjInHaH+
         s6PAnEpd05zA1wbbij85nr+8IZQSa2VcMfTTUJML+OYntf7Z1zGkcAtZ3+82LOUfpS1r
         yLcezVa8xkaRhwAtUeFrGGassyk6KFe6Fe9Br+iSHGdGwGTDw696XOi/tB5FrJHDB/Zr
         NszzHKZlUhEzfnSFMyY73eHtkvuLUx7gsNdPuh58oUlM0+YyN2fiUW8/7k25DmWRXYzN
         Mz6+WA6Q0zdh9yZWXOc6xxNfwNhXv3M7S5gTXcpXqLDvQ4nAyBMSDJ/I+KNHszleKsOC
         fVUg==
X-Gm-Message-State: AC+VfDyUeLs78g3UD14BiycMohVPkyjooYGeD9I8VG6xW8bbc7+mdlTr
        OZQhjGMi4zamwbU4/O1dEw1fpXrGllshDQ==
X-Google-Smtp-Source: ACHHUZ7xVswVxMlAbuXM0D1pvugkyEcjJjFYRWa+KqmIhde44CvOq6FK0bhBjRxTVvPgtVl4zq6KC5eExxNjOg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a25:c041:0:b0:b96:5b8a:3c34 with SMTP id
 c62-20020a25c041000000b00b965b8a3c34mr1217514ybf.11.1682642515107; Thu, 27
 Apr 2023 17:41:55 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:38 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-7-jiaqiyan@google.com>
Subject: [RFC PATCH v1 6/7] selftest/mm: test PAGESIZE unmapping HWPOISON pages
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, peterx@redhat.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        rientjes@google.com, linmiaohe@huawei.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After injecting memory errors to byte addresses inside HugeTLB page,
the updated test checks
1. only a raw page is unmapped, and userspace gets correct SIGBUS
   from kernel.
2. other subpages in the same hugepage are still mapped and data not
   corrupted.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/hugetlb-hgm.c | 194 +++++++++++++++++++----
 1 file changed, 167 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-hgm.c b/tools/testing/selftests/mm/hugetlb-hgm.c
index c0ba6ad44005..bc9529986b66 100644
--- a/tools/testing/selftests/mm/hugetlb-hgm.c
+++ b/tools/testing/selftests/mm/hugetlb-hgm.c
@@ -39,6 +39,10 @@
 #define MADV_SPLIT 26
 #endif
 
+#ifndef NUM_HWPOISON_PAGES
+#define NUM_HWPOISON_PAGES 3UL
+#endif
+
 #define PREFIX " ... "
 #define ERROR_PREFIX " !!! "
 
@@ -241,6 +245,9 @@ static int test_sigbus(char *addr, bool poison)
 				sigbus_addr, addr);
 	else if (poison && !was_mceerr)
 		printf(ERROR_PREFIX "didn't get an MCEERR?\n");
+	else if (!poison && was_mceerr)
+		printf(ERROR_PREFIX "got BUS_MCEERR_AR sigbus on expected healthy address: %p\n",
+		       sigbus_addr);
 	else
 		ret = 0;
 out:
@@ -272,43 +279,176 @@ static int read_event_from_uffd(int *uffd, pthread_t *pthread)
 	return 0;
 }
 
-static int test_sigbus_range(char *primary_map, size_t len, bool hwpoison)
+struct range_exclude_pages {
+	/* Starting address of the buffer. */
+	char *mapping;
+	/* Length of the buffer in bytes. */
+	size_t length;
+	/* The value that each byte in buffer should equal to. */
+	char value;
+	/*
+	 * PAGESIZE aligned addresses excluded from the checking,
+	 * e.g. if PAGE_SIZE=4k, for each addr in excludes,
+	 * skips checking on [addr, addr + 4096).
+	 */
+	unsigned long excluded[NUM_HWPOISON_PAGES];
+};
+
+static int check_range_exclude_pages(struct range_exclude_pages *range)
+{
+	const unsigned long pagesize = getpagesize();
+	unsigned long excluded_index;
+	unsigned long page_index;
+	bool should_skip;
+	size_t i = 0;
+	size_t j = 0;
+
+	while (i < range->length) {
+		page_index = ((unsigned long)(range->mapping + i)) / pagesize;
+		should_skip = false;
+		for (j = 0; j < NUM_HWPOISON_PAGES; ++j) {
+			excluded_index = range->excluded[j] / pagesize;
+			if (page_index == excluded_index) {
+				should_skip = true;
+				break;
+			}
+		}
+		if (should_skip) {
+			printf(PREFIX "skip excluded addr range [%#lx, %#lx)\n",
+				(unsigned long)(range->mapping + i),
+				(unsigned long)(range->mapping + i + pagesize));
+			i += pagesize;
+			continue;
+		}
+		if (range->mapping[i] != range->value) {
+			printf(ERROR_PREFIX "mismatch at %p (%d != %d)\n",
+			       &range->mapping[i], range->mapping[i], range->value);
+			return -1;
+		}
+		++i;
+	}
+
+	return 0;
+}
+
+enum test_status verify_raw_pages(char *map, size_t len,
+				  unsigned long excluded[NUM_HWPOISON_PAGES])
 {
 	const unsigned long pagesize = getpagesize();
-	const int num_checks = 512;
-	unsigned long bytes_per_check = len/num_checks;
-	int i;
+	unsigned long size, offset, value;
+	size_t j = 0;
+
+	for (size = len / 2, offset = 0, value = 1; size > pagesize;
+	     offset += size, size /= 2, ++value) {
+		struct range_exclude_pages range = {
+			.mapping = map + offset,
+			.length = size,
+			.value = value,
+		};
+		for (j = 0; j < NUM_HWPOISON_PAGES; ++j)
+			range.excluded[j] = excluded[j];
+
+		printf(PREFIX "checking non-poisoned range [%p, %p) "
+			"(len=%#lx) per-byte value=%lu\n",
+			range.mapping, range.mapping + range.length,
+			range.length, value);
+		if (check_range_exclude_pages(&range))
+			return TEST_FAILED;
+
+		printf(PREFIX PREFIX "good\n");
+	}
 
-	printf(PREFIX "checking that we can't access "
-	       "(%d addresses within %p -> %p)\n",
-	       num_checks, primary_map, primary_map + len);
+	return TEST_PASSED;
+}
 
-	if (pagesize > bytes_per_check)
-		bytes_per_check = pagesize;
+static int read_hwpoison_pages(unsigned long *nr_hwp_pages)
+{
+	const unsigned long pagesize = getpagesize();
+	char buffer[256] = {0};
+	char *cmd = "cat /proc/meminfo | grep -i HardwareCorrupted | grep -o '[0-9]*'";
+	FILE *cmdfile = popen(cmd, "r");
 
-	for (i = 0; i < len; i += bytes_per_check)
-		if (test_sigbus(primary_map + i, hwpoison) < 0)
-			return 1;
-	/* check very last byte, because we left it unmapped */
-	if (test_sigbus(primary_map + len - 1, hwpoison))
-		return 1;
+	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
+		perror("failed to read HardwareCorrupted from /proc/meminfo\n");
+		return -1;
+	}
+	pclose(cmdfile);
+	*nr_hwp_pages = atoll(buffer) * 1024 / pagesize;
 
 	return 0;
 }
 
-static enum test_status test_hwpoison(char *primary_map, size_t len)
+static enum test_status test_hwpoison_one_raw_page(char *hwpoison_addr)
 {
-	printf(PREFIX "poisoning %p -> %p\n", primary_map, primary_map + len);
-	if (madvise(primary_map, len, MADV_HWPOISON) < 0) {
+	const unsigned long pagesize = getpagesize();
+
+	printf(PREFIX "poisoning [%p, %p) (len=%#lx)\n",
+	       hwpoison_addr, hwpoison_addr + pagesize, pagesize);
+	if (madvise(hwpoison_addr, pagesize, MADV_HWPOISON) < 0) {
 		perror(ERROR_PREFIX "MADV_HWPOISON failed");
 		return TEST_SKIPPED;
 	}
 
-	return test_sigbus_range(primary_map, len, true)
-		? TEST_FAILED : TEST_PASSED;
+	printf(PREFIX "checking poisoned range [%p, %p) (len=%#lx)\n",
+	       hwpoison_addr, hwpoison_addr + pagesize, pagesize);
+	if (test_sigbus(hwpoison_addr, true) < 0)
+		return TEST_FAILED;
+
+	return TEST_PASSED;
 }
 
-static int test_fork(int uffd, char *primary_map, size_t len)
+static enum test_status test_hwpoison_present(char *map, size_t len,
+					      bool already_injected)
+{
+	const unsigned long pagesize = getpagesize();
+	const unsigned long hwpoison_next = 128;
+	unsigned long nr_hwpoison_pages_before, nr_hwpoison_pages_after;
+	enum test_status ret;
+	size_t i;
+	char *hwpoison_addr = map;
+	unsigned long hwpoison_addrs[NUM_HWPOISON_PAGES];
+
+	if (hwpoison_next * (NUM_HWPOISON_PAGES - 1) >= (len / pagesize)) {
+		printf(ERROR_PREFIX "max hwpoison_addr out of range");
+		return TEST_SKIPPED;
+	}
+
+	for (i = 0; i < NUM_HWPOISON_PAGES; ++i) {
+		hwpoison_addrs[i] = (unsigned long)hwpoison_addr;
+		hwpoison_addr += hwpoison_next * pagesize;
+	}
+
+	if (already_injected)
+		return verify_raw_pages(map, len, hwpoison_addrs);
+
+	if (read_hwpoison_pages(&nr_hwpoison_pages_before)) {
+		printf(ERROR_PREFIX "check #HWPOISON pages\n");
+		return TEST_SKIPPED;
+	}
+	printf(PREFIX "Before injections, #HWPOISON pages = %ld\n", nr_hwpoison_pages_before);
+
+	for (i = 0; i < NUM_HWPOISON_PAGES; ++i) {
+		ret = test_hwpoison_one_raw_page((char *)hwpoison_addrs[i]);
+		if (ret != TEST_PASSED)
+			return ret;
+	}
+
+	if (read_hwpoison_pages(&nr_hwpoison_pages_after)) {
+		printf(ERROR_PREFIX "check #HWPOISON pages\n");
+		return TEST_SKIPPED;
+	}
+	printf(PREFIX "After injections, #HWPOISON pages = %ld\n", nr_hwpoison_pages_after);
+
+	if (nr_hwpoison_pages_after - nr_hwpoison_pages_before != NUM_HWPOISON_PAGES) {
+		printf(ERROR_PREFIX "delta #HWPOISON pages != %ld",
+			NUM_HWPOISON_PAGES);
+		return TEST_FAILED;
+	}
+
+	return verify_raw_pages(map, len, hwpoison_addrs);
+}
+
+int test_fork(int uffd, char *primary_map, size_t len)
 {
 	int status;
 	int ret = 0;
@@ -360,7 +500,6 @@ static int test_fork(int uffd, char *primary_map, size_t len)
 
 	pthread_join(uffd_thd, NULL);
 	return ret;
-
 }
 
 static int uffd_register(int uffd, char *primary_map, unsigned long len,
@@ -394,6 +533,7 @@ test_hgm(int fd, size_t hugepagesize, size_t len, enum test_type type)
 	bool uffd_wp = type == TEST_UFFDWP;
 	bool verify = type == TEST_DEFAULT;
 	int register_args;
+	enum test_status hwp_status = TEST_SKIPPED;
 
 	if (ftruncate(fd, len) < 0) {
 		perror(ERROR_PREFIX "ftruncate failed");
@@ -489,10 +629,10 @@ test_hgm(int fd, size_t hugepagesize, size_t len, enum test_type type)
 	 * mapping.
 	 */
 	if (hwpoison) {
-		enum test_status new_status = test_hwpoison(primary_map, len);
-
-		if (new_status != TEST_PASSED) {
-			status = new_status;
+		/* test_hwpoison can fail with TEST_SKIPPED. */
+		hwp_status = test_hwpoison_present(primary_map, len, false);
+		if (hwp_status != TEST_PASSED) {
+			status = hwp_status;
 			goto done;
 		}
 	}
@@ -539,7 +679,7 @@ test_hgm(int fd, size_t hugepagesize, size_t len, enum test_type type)
 	/*
 	 * Verify that memory is still poisoned.
 	 */
-	if (hwpoison && test_sigbus_range(primary_map, len, true))
+	if (hwpoison && test_hwpoison_present(primary_map, len, true))
 		goto done;
 
 	status = TEST_PASSED;
-- 
2.40.1.495.gc816e09b53d-goog

