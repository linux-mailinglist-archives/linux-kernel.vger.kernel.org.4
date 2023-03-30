Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F76D0AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC3QHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjC3QHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A193CA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7NTd9ykbxp4UXzRNrTfarBboXMMqnuQ6sOTF5uMlUjU=;
        b=K5JhMXgfm6kguiQKimQG+Aj2vDjGAiw3wQw4wmg+x0a9pqoLgoYreSpg2vI6OAFjI+Ua2P
        6hW/EseOhskhomjC5ppTzMwNsIzZKKnm20vMif7tc0v5iagRt6iF0y1LrKc0/r2Pylz+TI
        5eDqnOEcq112meGMni8GmLA+lW1rYvM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-hL8PWttiOsqPp9cPULO47w-1; Thu, 30 Mar 2023 12:07:02 -0400
X-MC-Unique: hL8PWttiOsqPp9cPULO47w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5aae34d87f7so13014036d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NTd9ykbxp4UXzRNrTfarBboXMMqnuQ6sOTF5uMlUjU=;
        b=t8WxwOs4DOFa8+wDpV20Fmh/7qcN+FNXK3Nc9D5o+vr/Dz89aHpQ0rYkqes+yh5yE8
         uiK/62ZPVCl1u03qhD0ioeftcbAO+RTyk8mGsxtymD6TKdczgXdspjyOfJwqk0q7xI2x
         55p0zSLfPfU8zk8dRyB3CyrlgVxGDxJev/ostNjNijxd1U1XhzU9CKMYTQpX/MfWzhGT
         GoQNbnwZBXLPLCFnUunmNuujccpGzK7xiy71K0lqKFJKbO/BU/3IbmRWGIOn/9ISTZzq
         niyWDO2tJG4c+bV5530XekRVJWNm/ABYeTyOqseHnGteBVfkzHaq77rlPrPCo9Z3ZQsS
         agGw==
X-Gm-Message-State: AAQBX9dBdSLMvdY6YDe6lGhPlesDHqF6ET57uhkFthQ+FjCGnsvjzs7d
        2jysYffGgJF9tBQox7cPSE2cleee31mHrSibLSo7pjWVy3z6WRlBxcQooGzLkiwGLN+UHMgaxKU
        1kkIbm83cL4u/LrCMzG4u2U3D
X-Received: by 2002:a05:6214:d0c:b0:5df:a693:39e with SMTP id 12-20020a0562140d0c00b005dfa693039emr3564904qvh.5.1680192414017;
        Thu, 30 Mar 2023 09:06:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350ay9foZ+7sLH0l9upG28YZMcH3wwEPMDOy35oTEC9bGWqO6YTuX4ly8yK4M9vqcaISxkOHyLQ==
X-Received: by 2002:a05:6214:d0c:b0:5df:a693:39e with SMTP id 12-20020a0562140d0c00b005dfa693039emr3564872qvh.5.1680192413714;
        Thu, 30 Mar 2023 09:06:53 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id jy3-20020a0562142b4300b005dd8b934595sm5541041qvb.45.2023.03.30.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:06:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 04/29] selftests/mm: Merge util.h into vm_util.h
Date:   Thu, 30 Mar 2023 12:06:49 -0400
Message-Id: <20230330160649.3106916-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're two util headers under mm/ kselftest.  Merge one with another.  It
turns out util.h is the easy one to move.

When merging, drop PAGE_SIZE / PAGE_SHIFT because they're unnecessary
wrappers to page_size() / page_shift(), meanwhile rename them to psize()
and pshift() so as to not conflict with some existing definitions in some
test files that includes vm_util.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile           |  4 ++
 tools/testing/selftests/mm/gup_test.c         |  5 +-
 tools/testing/selftests/mm/ksm_tests.c        |  2 +-
 tools/testing/selftests/mm/mrelease_test.c    | 11 ++-
 tools/testing/selftests/mm/transhuge-stress.c | 12 ++--
 tools/testing/selftests/mm/util.h             | 69 -------------------
 tools/testing/selftests/mm/vm_util.c          | 31 +++++++++
 tools/testing/selftests/mm/vm_util.h          | 31 +++++++++
 8 files changed, 80 insertions(+), 85 deletions(-)
 delete mode 100644 tools/testing/selftests/mm/util.h

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index fbf5646b1072..4188435967ed 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -111,6 +111,10 @@ $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
+$(OUTPUT)/gup_test: vm_util.c
+$(OUTPUT)/mrelease_test: vm_util.c
+$(OUTPUT)/transhuge-stress: vm_util.c
+$(OUTPUT)/ksm_tests: vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index e43879291dac..ec2229136384 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -12,8 +12,7 @@
 #include <assert.h>
 #include <mm/gup_test.h>
 #include "../kselftest.h"
-
-#include "util.h"
+#include "vm_util.h"
 
 #define MB (1UL << 20)
 
@@ -251,7 +250,7 @@ int main(int argc, char **argv)
 	if (touch) {
 		gup.gup_flags |= FOLL_TOUCH;
 	} else {
-		for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
+		for (; (unsigned long)p < gup.addr + size; p += psize())
 			p[0] = 0;
 	}
 
diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 9fb21b982dc9..85a49aea3ab8 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -14,7 +14,7 @@
 
 #include "../kselftest.h"
 #include <include/vdso/time64.h>
-#include "util.h"
+#include "vm_util.h"
 
 #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
 #define KSM_FP(s) (KSM_SYSFS_PATH s)
diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index 6c62966ab5db..37b6d33b9e84 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -9,8 +9,7 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include <unistd.h>
-
-#include "util.h"
+#include "vm_util.h"
 
 #include "../kselftest.h"
 
@@ -32,7 +31,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
 	unsigned long i;
 	char *buf;
 
-	buf = (char *)mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
+	buf = (char *)mmap(NULL, nr_pages * psize(), PROT_READ | PROT_WRITE,
 			   MAP_PRIVATE | MAP_ANON, 0, 0);
 	if (buf == MAP_FAILED) {
 		perror("mmap failed, halting the test");
@@ -40,7 +39,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		*((unsigned long *)(buf + (i * PAGE_SIZE))) = i;
+		*((unsigned long *)(buf + (i * psize()))) = i;
 
 	/* Signal the parent that the child is ready */
 	if (write(pipefd, "", 1) < 0) {
@@ -54,7 +53,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
 		timeout--;
 	}
 
-	munmap(buf, nr_pages * PAGE_SIZE);
+	munmap(buf, nr_pages * psize());
 
 	return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
 }
@@ -87,7 +86,7 @@ static int child_main(int pipefd[], size_t size)
 
 	/* Allocate and fault-in memory and wait to be killed */
 	close(pipefd[0]);
-	res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
+	res = alloc_noexit(MB(size) / psize(), pipefd[1]);
 	close(pipefd[1]);
 	return res;
 }
diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
index e3f00adb1b82..ba9d37ad3a89 100644
--- a/tools/testing/selftests/mm/transhuge-stress.c
+++ b/tools/testing/selftests/mm/transhuge-stress.c
@@ -15,7 +15,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/mman.h>
-#include "util.h"
+#include "vm_util.h"
 
 int backing_fd = -1;
 int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
@@ -34,10 +34,10 @@ int main(int argc, char **argv)
 	int pagemap_fd;
 
 	ram = sysconf(_SC_PHYS_PAGES);
-	if (ram > SIZE_MAX / sysconf(_SC_PAGESIZE) / 4)
+	if (ram > SIZE_MAX / psize() / 4)
 		ram = SIZE_MAX / 4;
 	else
-		ram *= sysconf(_SC_PAGESIZE);
+		ram *= psize();
 	len = ram;
 
 	while (++i < argc) {
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 
 	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
 	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
-	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
+	      ram >> (20 + HPAGE_SHIFT - pshift() - 1));
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
@@ -92,7 +92,7 @@ int main(int argc, char **argv)
 			if (pfn < 0) {
 				nr_failed++;
 			} else {
-				size_t idx = pfn >> (HPAGE_SHIFT - PAGE_SHIFT);
+				size_t idx = pfn >> (HPAGE_SHIFT - pshift());
 
 				nr_succeed++;
 				if (idx >= map_len) {
@@ -108,7 +108,7 @@ int main(int argc, char **argv)
 			}
 
 			/* split transhuge page, keep last page */
-			if (madvise(p, HPAGE_SIZE - PAGE_SIZE, MADV_DONTNEED))
+			if (madvise(p, HPAGE_SIZE - psize(), MADV_DONTNEED))
 				err(2, "MADV_DONTNEED");
 		}
 		clock_gettime(CLOCK_MONOTONIC, &b);
diff --git a/tools/testing/selftests/mm/util.h b/tools/testing/selftests/mm/util.h
deleted file mode 100644
index b27d26199334..000000000000
--- a/tools/testing/selftests/mm/util.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __KSELFTEST_VM_UTIL_H
-#define __KSELFTEST_VM_UTIL_H
-
-#include <stdint.h>
-#include <sys/mman.h>
-#include <err.h>
-#include <string.h> /* ffsl() */
-#include <unistd.h> /* _SC_PAGESIZE */
-
-static unsigned int __page_size;
-static unsigned int __page_shift;
-
-static inline unsigned int page_size(void)
-{
-	if (!__page_size)
-		__page_size = sysconf(_SC_PAGESIZE);
-	return __page_size;
-}
-
-static inline unsigned int page_shift(void)
-{
-	if (!__page_shift)
-		__page_shift = (ffsl(page_size()) - 1);
-	return __page_shift;
-}
-
-#define PAGE_SHIFT	(page_shift())
-#define PAGE_SIZE	(page_size())
-/*
- * On ppc64 this will only work with radix 2M hugepage size
- */
-#define HPAGE_SHIFT 21
-#define HPAGE_SIZE (1 << HPAGE_SHIFT)
-
-#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
-#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
-
-
-static inline int64_t allocate_transhuge(void *ptr, int pagemap_fd)
-{
-	uint64_t ent[2];
-
-	/* drop pmd */
-	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
-		 MAP_FIXED | MAP_ANONYMOUS |
-		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
-		errx(2, "mmap transhuge");
-
-	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
-
-	/* allocate transparent huge page */
-	*(volatile void **)ptr = ptr;
-
-	if (pread(pagemap_fd, ent, sizeof(ent),
-		  (uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
-		err(2, "read pagemap");
-
-	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
-	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
-	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
-		return PAGEMAP_PFN(ent[0]);
-
-	return -1;
-}
-
-#endif
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 40e795624ff3..0204c469be43 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -8,6 +8,9 @@
 #define SMAP_FILE_PATH "/proc/self/smaps"
 #define MAX_LINE_LENGTH 500
 
+unsigned int __page_size;
+unsigned int __page_shift;
+
 uint64_t pagemap_get_entry(int fd, char *start)
 {
 	const unsigned long pfn = (unsigned long)start / getpagesize();
@@ -149,3 +152,31 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
 {
 	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
 }
+
+int64_t allocate_transhuge(void *ptr, int pagemap_fd)
+{
+	uint64_t ent[2];
+
+	/* drop pmd */
+	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_FIXED | MAP_ANONYMOUS |
+		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
+		errx(2, "mmap transhuge");
+
+	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
+		err(2, "MADV_HUGEPAGE");
+
+	/* allocate transparent huge page */
+	*(volatile void **)ptr = ptr;
+
+	if (pread(pagemap_fd, ent, sizeof(ent),
+		  (uintptr_t)ptr >> (pshift() - 3)) != sizeof(ent))
+		err(2, "read pagemap");
+
+	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
+	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
+	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - pshift())) - 1)))
+		return PAGEMAP_PFN(ent[0]);
+
+	return -1;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 1995ee911ef2..6edeb531afc6 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -1,6 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdint.h>
 #include <stdbool.h>
+#include <sys/mman.h>
+#include <err.h>
+#include <string.h> /* ffsl() */
+#include <unistd.h> /* _SC_PAGESIZE */
+
+extern unsigned int __page_size;
+extern unsigned int __page_shift;
+
+static inline unsigned int psize(void)
+{
+	if (!__page_size)
+		__page_size = sysconf(_SC_PAGESIZE);
+	return __page_size;
+}
+
+static inline unsigned int pshift(void)
+{
+	if (!__page_shift)
+		__page_shift = (ffsl(psize()) - 1);
+	return __page_shift;
+}
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
@@ -13,3 +34,13 @@ uint64_t read_pmd_pagesize(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
+int64_t allocate_transhuge(void *ptr, int pagemap_fd);
+
+/*
+ * On ppc64 this will only work with radix 2M hugepage size
+ */
+#define HPAGE_SHIFT 21
+#define HPAGE_SIZE (1 << HPAGE_SHIFT)
+
+#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
+#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
-- 
2.39.1

