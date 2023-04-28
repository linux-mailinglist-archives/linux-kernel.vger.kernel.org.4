Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9416F0FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjD1Am0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbjD1AmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:42:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD03A82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52855ba7539so3164282a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642516; x=1685234516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezb/mtBWXto18t5BMeGyfP88KWTxkli4FptKeY/x46M=;
        b=cBpNq4kDOoS1KXNAw36+zGssSnylFqMaR3rTdo/Bbi9j+uSIW0zcOYI0md0xbW4j6W
         +PHFxJ/rOe3KUn/hfS4DGeQhcETYJOxEfXjZyGlSMKsv+CSEvmuki2TM5s9h+sqzZXkm
         zFMImG52kUZ92kxbvfqyxdPPLXjw/DJeyVb7bUVcVONfdKFL8z9+VjLIhMS0+re2GE2O
         zEwtBtEBHkyndAa1lteLDV2QAeqC8zrgH0gfV610xTUo+Pm8uYlqrCTPp0id3O0nqgM8
         EO4A4dGanmX/FeoSb2uM1T+dObQeuLR3ZhqUU9X+KEIF6pPvyCLlK8E7wcVNgFeDCjlE
         Uraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642516; x=1685234516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezb/mtBWXto18t5BMeGyfP88KWTxkli4FptKeY/x46M=;
        b=lYQCpCorHHymnhdArlIeoy8FvwBXiUSwYDXMUrD4+/1TUrvPClckboVjN0OpUm5vIc
         pUza3mZLnS2oVysbAKdXtB+G17SAgMHS4onOTwt7ztNRWM9mUhMIiQCNY/U1svw5OV47
         QLLlAlPILFnmCsPwof3KkJYLyLoipuuDUy9/6ulz4vxD6sAFjV4RkPEwPW+WfUBptpqQ
         4jkjKzQc1g3moZ4ggOc/8ucaVF5TksKYv2bJG+7PHmbJSQlR7mvmynH0RDzv/YqqYrax
         m9IJq6Q+wgvHSoM6HXk7xqV0rNHq6hwETsx46sjz+NH0/4J9I2nTWMYIvB47CgnWIIft
         V5TA==
X-Gm-Message-State: AC+VfDzrFWOfOsxKRvjmz7xlVJA87TwyO5GoHSdg3WyPfFi8Z+WC6CfM
        s9i2pgMNs7NO7AJ1xEaitmTq7SqIpGYGcg==
X-Google-Smtp-Source: ACHHUZ4uSTJSvROEy8sBOqqJIAEA7UBFzhEBDJSv45cu5mSBlwmubK7GVOYVl6ekjsL6kpRFWsParYbdrONO0g==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:2885:0:b0:513:953f:fee4 with SMTP id
 bs127-20020a632885000000b00513953ffee4mr815399pgb.10.1682642516710; Thu, 27
 Apr 2023 17:41:56 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:39 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-8-jiaqiyan@google.com>
Subject: [RFC PATCH v1 7/7] selftest/mm: test PAGESIZE unmapping UFFD WP
 marker HWPOISON pages
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

For not-yet-faulted hugepage containing HWPOISON raw page, test
1. only HWPOISON raw page will not be faulted, and a BUS_MCEERR_AR
   SIGBUS will be sent to userspace.
2. healthy raw pages are faulted in as normal. Since the hugepage
   has been writeprotect by UFFD, non BUS_MCEERR_AR SIGBUS will be
   sent to userspace.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/hugetlb-hgm.c | 170 +++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/tools/testing/selftests/mm/hugetlb-hgm.c b/tools/testing/selftests/mm/hugetlb-hgm.c
index bc9529986b66..81ee2d99fea8 100644
--- a/tools/testing/selftests/mm/hugetlb-hgm.c
+++ b/tools/testing/selftests/mm/hugetlb-hgm.c
@@ -515,6 +515,169 @@ static int uffd_register(int uffd, char *primary_map, unsigned long len,
 	return ioctl(uffd, UFFDIO_REGISTER, &reg);
 }
 
+static int setup_present_map(char *present_map, size_t len)
+{
+	size_t offset = 0;
+	unsigned char iter = 0;
+	unsigned long pagesize = getpagesize();
+	uint64_t size;
+
+	for (size = len/2; size >= pagesize;
+			offset += size, size /= 2) {
+		iter++;
+		memset(present_map + offset, iter, size);
+	}
+	return 0;
+}
+
+static enum test_status test_hwpoison_absent_uffd_wp(int fd, size_t hugepagesize, size_t len)
+{
+	int uffd;
+	char *absent_map, *present_map;
+	struct uffdio_api api;
+	int register_args;
+	struct sigaction new, old;
+	enum test_status status = TEST_SKIPPED;
+	const unsigned long pagesize = getpagesize();
+	const unsigned long hwpoison_index = 128;
+	char *hwpoison_addr;
+
+	if (hwpoison_index >= (len / pagesize)) {
+		printf(ERROR_PREFIX "hwpoison_index out of range");
+		return TEST_FAILED;
+	}
+
+	if (ftruncate(fd, len) < 0) {
+		perror(ERROR_PREFIX "ftruncate failed");
+		return TEST_FAILED;
+	}
+
+	uffd = userfaultfd(O_CLOEXEC);
+	if (uffd < 0) {
+		perror(ERROR_PREFIX "uffd not created");
+		return TEST_FAILED;
+	}
+
+	absent_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (absent_map == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for ABSENT mapping failed");
+		goto close_uffd;
+	}
+	printf(PREFIX "ABSENT mapping: %p\n", absent_map);
+
+	api.api = UFFD_API;
+	api.features = UFFD_FEATURE_SIGBUS | UFFD_FEATURE_EXACT_ADDRESS |
+		UFFD_FEATURE_EVENT_FORK;
+	if (ioctl(uffd, UFFDIO_API, &api) == -1) {
+		perror(ERROR_PREFIX "UFFDIO_API failed");
+		goto unmap_absent;
+	}
+
+	/*
+	 * Register with UFFDIO_REGISTER_MODE_WP to have UFFD WP bit on
+	 * the HugeTLB page table entry.
+	 */
+	register_args = UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP;
+	if (uffd_register(uffd, absent_map, len, register_args)) {
+		perror(ERROR_PREFIX "UFFDIO_REGISTER failed");
+		goto unmap_absent;
+	}
+
+	new.sa_sigaction = &sigbus_handler;
+	new.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &new, &old) < 0) {
+		perror(ERROR_PREFIX "could not setup SIGBUS handler");
+		goto unmap_absent;
+	}
+
+	/*
+	 * Set WP markers to the absent huge mapping. With HGM enabled in
+	 * kernel CONFIG, memory_failure will enabled HGM in kernel,
+	 * so no need to enable HGM from userspace.
+	 */
+	if (userfaultfd_writeprotect(uffd, absent_map, len, true) < 0) {
+		status = TEST_FAILED;
+		goto unmap_absent;
+	}
+
+	status = TEST_PASSED;
+
+	/*
+	 * With MAP_SHARED hugetlb memory, we cna inject memory error to
+	 * not-yet-faulted mapping (absent_map) by injecting memory error
+	 * to a already faulted mapping (present_map).
+	 */
+	present_map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (present_map == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap for non present mapping failed");
+		goto close_uffd;
+	}
+	printf(PREFIX "PRESENT mapping: %p\n", present_map);
+	setup_present_map(present_map, len);
+
+	hwpoison_addr = present_map + hwpoison_index * pagesize;
+	if (madvise(hwpoison_addr, pagesize, MADV_HWPOISON)) {
+		perror(PREFIX "MADV_HWPOISON a page in PRESENT mapping failed");
+		status = TEST_FAILED;
+		goto unmap_present;
+	}
+
+	printf(PREFIX "checking poisoned range [%p, %p) (len=%#lx) in PRESENT mapping\n",
+	       hwpoison_addr, hwpoison_addr + pagesize, pagesize);
+	if (test_sigbus(hwpoison_addr, true) < 0) {
+		status = TEST_FAILED;
+		goto done;
+	}
+	printf(PREFIX "checking healthy pages in PRESENT mapping\n");
+	unsigned long hwpoison_addrs[] = {
+		(unsigned long)hwpoison_addr,
+		(unsigned long)hwpoison_addr,
+		(unsigned long)hwpoison_addr
+	};
+	status = verify_raw_pages(present_map, len, hwpoison_addrs);
+	if (status != TEST_PASSED) {
+		printf(ERROR_PREFIX "checking healthy pages failed\n");
+		goto done;
+	}
+
+	for (int i = 0; i < len; i += pagesize) {
+		if (i == hwpoison_index * pagesize) {
+			printf(PREFIX "checking poisoned range [%p, %p) (len=%#lx) in ABSENT mapping\n",
+				absent_map + i, absent_map + i + pagesize, pagesize);
+			if (test_sigbus(absent_map + i, true) < 0) {
+				status = TEST_FAILED;
+				break;
+			}
+		} else {
+			/*
+			 * With UFFD_FEATURE_SIGBUS, we should get a SIGBUS for
+			 * every not faulted (non present) page/byte.
+			 */
+			if (test_sigbus(absent_map + i, false) < 0) {
+				printf(PREFIX "checking healthy range [%p, %p) (len=%#lx) in ABSENT mapping failed\n",
+					absent_map + i, absent_map + i + pagesize, pagesize);
+				status = TEST_FAILED;
+				break;
+			}
+		}
+	}
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+unmap_present:
+	printf(PREFIX "Unmap PRESENT mapping=%p\n", absent_map);
+	munmap(present_map, len);
+unmap_absent:
+	printf(PREFIX "Unmap ABSENT mapping=%p\n", absent_map);
+	munmap(absent_map, len);
+close_uffd:
+	printf(PREFIX "Close UFFD\n");
+	close(uffd);
+	return status;
+}
+
 enum test_type {
 	TEST_DEFAULT,
 	TEST_UFFDWP,
@@ -744,6 +907,13 @@ int main(void)
 	printf("HGM hwpoison test: %s\n", status_to_str(status));
 	if (status == TEST_FAILED)
 		ret = -1;
+
+	printf("HGM hwpoison UFFD-WP marker test...\n");
+	status = test_hwpoison_absent_uffd_wp(fd, hugepagesize, len);
+	printf("HGM hwpoison UFFD-WP marker test: %s\n",
+		status_to_str(status));
+	if (status == TEST_FAILED)
+		ret = -1;
 close:
 	close(fd);
 
-- 
2.40.1.495.gc816e09b53d-goog

