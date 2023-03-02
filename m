Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847C66A882B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCBRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:55:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB118A97
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677779670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QzwEJy0ykd0+2iEjjzeHmHZle6okB7GtXUTcdZ9p+og=;
        b=ePEUTLxsvFyRHeyJG6dHGj0FGVdnA3GGSribyBretg26IVbFERQ7Qr9W6A60hJ3prnDZAh
        yOhpLSAsFgpt77hbfvpoVdc/FojDJhyMbtVuqIG3OMpdhiKLl+1LxJ8ccufdlB3Q6h/sJn
        MgFndV8V8vTOgD2lwL6CoyzFNLKsccc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-eGLh9503PxWADPCgNxdsbg-1; Thu, 02 Mar 2023 12:54:27 -0500
X-MC-Unique: eGLh9503PxWADPCgNxdsbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823BC2823809;
        Thu,  2 Mar 2023 17:54:26 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 727E4140EBF6;
        Thu,  2 Mar 2023 17:54:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
Subject: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when PTE-mapping the huge zeropage
Date:   Thu,  2 Mar 2023 18:54:23 +0100
Message-Id: <20230302175423.589164-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we'd lose the userfaultfd-wp marker when PTE-mapping a huge
zeropage, resulting in the next write faults in the PMD range
not triggering uffd-wp events.

Various actions (partial MADV_DONTNEED, partial mremap, partial munmap,
partial mprotect) could trigger this. However, most importantly,
un-protecting a single sub-page from the userfaultfd-wp handler when
processing a uffd-wp event will PTE-map the shared huge zeropage and
lose the uffd-wp bit for the remainder of the PMD.

Let's properly propagate the uffd-wp bit to the PMDs.

---
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include <inttypes.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
 #include <poll.h>
 #include <pthread.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>

 static size_t pagesize;
 static int uffd;
 static volatile bool uffd_triggered;

 #define barrier() __asm__ __volatile__("": : :"memory")

 static void uffd_wp_range(char *start, size_t size, bool wp)
 {
 	struct uffdio_writeprotect uffd_writeprotect;

 	uffd_writeprotect.range.start = (unsigned long) start;
 	uffd_writeprotect.range.len = size;
 	if (wp) {
 		uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
 	} else {
 		uffd_writeprotect.mode = 0;
 	}
 	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
 		fprintf(stderr, "UFFDIO_WRITEPROTECT failed: %d\n", errno);
 		exit(1);
 	}
 }

 static void *uffd_thread_fn(void *arg)
 {
 	static struct uffd_msg msg;
 	ssize_t nread;

 	while (1) {
 		struct pollfd pollfd;
 		int nready;

 		pollfd.fd = uffd;
 		pollfd.events = POLLIN;
 		nready = poll(&pollfd, 1, -1);
 		if (nready == -1) {
 			fprintf(stderr, "poll() failed: %d\n", errno);
 			exit(1);
 		}

 		nread = read(uffd, &msg, sizeof(msg));
 		if (nread <= 0)
 			continue;

 		if (msg.event != UFFD_EVENT_PAGEFAULT ||
 		    !(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP)) {
 			printf("FAIL: wrong uffd-wp event fired\n");
 			exit(1);
 		}

 		/* un-protect the single page. */
 		uffd_triggered = true;
 		uffd_wp_range((char *)(uintptr_t)msg.arg.pagefault.address,
 			      pagesize, false);
 	}
 	return arg;
 }

 static int setup_uffd(char *map, size_t size)
 {
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
 	pthread_t thread;

 	uffd = syscall(__NR_userfaultfd,
 		       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd < 0) {
 		fprintf(stderr, "syscall() failed: %d\n", errno);
 		return -errno;
 	}

 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
 		fprintf(stderr, "UFFDIO_API failed: %d\n", errno);
 		return -errno;
 	}

 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
 		fprintf(stderr, "UFFD_FEATURE_WRITEPROTECT missing\n");
 		return -ENOSYS;
 	}

 	uffdio_register.range.start = (unsigned long) map;
 	uffdio_register.range.len = size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
 		fprintf(stderr, "UFFDIO_REGISTER failed: %d\n", errno);
 		return -errno;
 	}

 	pthread_create(&thread, NULL, uffd_thread_fn, NULL);

 	return 0;
 }

 int main(void)
 {
 	const size_t size = 4 * 1024 * 1024ull;
 	char *map, *cur;

 	pagesize = getpagesize();

 	map = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "mmap() failed\n");
 		return -errno;
 	}

 	if (madvise(map, size, MADV_HUGEPAGE)) {
 		fprintf(stderr, "MADV_HUGEPAGE failed\n");
 		return -errno;
 	}

 	if (setup_uffd(map, size))
 		return 1;

 	/* Read the whole range, populating zeropages. */
 	madvise(map, size, MADV_POPULATE_READ);

 	/* Write-protect the whole range. */
 	uffd_wp_range(map, size, true);

 	/* Make sure uffd-wp triggers on each page. */
 	for (cur = map; cur < map + size; cur += pagesize) {
 		uffd_triggered = false;

 		barrier();
 		/* Trigger a write fault. */
 		*cur = 1;
 		barrier();

 		if (!uffd_triggered) {
 			printf("FAIL: uffd-wp did not trigger\n");
 			return 1;
 		}
 	}

 	printf("PASS: uffd-wp triggered\n");
 	return 0;
 }
---

Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Shaohua Li <shli@fb.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4fc43859e59a..032fb0ef9cd1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2037,7 +2037,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgtable_t pgtable;
-	pmd_t _pmd;
+	pmd_t _pmd, old_pmd;
 	int i;
 
 	/*
@@ -2048,7 +2048,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	 *
 	 * See Documentation/mm/mmu_notifier.rst
 	 */
-	pmdp_huge_clear_flush(vma, haddr, pmd);
+	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
 	pmd_populate(mm, &_pmd, pgtable);
@@ -2057,6 +2057,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 		pte_t *pte, entry;
 		entry = pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
 		entry = pte_mkspecial(entry);
+		if (pmd_uffd_wp(old_pmd))
+			entry = pte_mkuffd_wp(entry);
 		pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, haddr, pte, entry);
-- 
2.39.2

