Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312B6DFB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDLQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjDLQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE71121
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXTqxDSTsrRiAkVZ6NC5Z+aMCLpRXkWfeIKb5BVB8IM=;
        b=fgdkG03qPmFecnq2VdojiCE+h8YgurP5RcjNw/cjepcl5600s+39PgLNsqW5RdGZZzMU2I
        XP3bIAMskc4R7v27uzV0Zgkp2FR9kmRExcCHj72HEMcmdvdX88fe15jPTE1sNZoGu3lSlU
        J2kJxZnxKnAa1l7fLfhjzH60nQ2LszY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-zoU5faxTMbWdZdZxE_la3Q-1; Wed, 12 Apr 2023 12:41:30 -0400
X-MC-Unique: zoU5faxTMbWdZdZxE_la3Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5e965c54827so8739426d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317685; x=1683909685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXTqxDSTsrRiAkVZ6NC5Z+aMCLpRXkWfeIKb5BVB8IM=;
        b=BULATiRAiMhzp5mO0BXOSWnXIwuQAVXEHPx0+boOp4v7pTg6a+YInVLwFXQWZwdo61
         nMQexTzJu9ZdauPTqH9AboNheHDXkNiOVAGUXSLyB+Zz6bSk4ObIo0bnNVPOpomWKCPS
         JmnHt+2xgx6cHWDvzHA4eSLiz/ptkE4yCiwWMah5hsxTax2Wi30wKov9Kv6PIYqLBHt1
         zTkZ9v3T8dbbdB1+PQR3V4I3D7veowlI3x6wMRRxttwVPYo6kZNhGEdrYL1e4Yd0rjRp
         kWuMzUUbg3VZ96UgWHwOY3jb8z1g27LKypHMcZbsb8B1z/B85JedX0Gw6HGj5JTPbe9/
         SfdA==
X-Gm-Message-State: AAQBX9eSBf8pgka5/D25/8GjdtkOiUYFzQ+b+FWmUmPS+KfT2uuJ0Zyd
        9lrmf7k+zsywFlByQ3/ONMfTtqIi/YnDU3aHB58gyBt2OQ1Tkw2jagMoHIkKPruAgGtg2J1jJAW
        EGHG0YMrAWXpe74F6s6s1nlHRPxXYi6D0Bp5Bbh6aktVkRQX01ugdXqpb8C6GdNehyLku6t3yaK
        Kw8ZPjAQ==
X-Received: by 2002:ad4:5de6:0:b0:5da:b965:1efd with SMTP id jn6-20020ad45de6000000b005dab9651efdmr27656371qvb.2.1681317684954;
        Wed, 12 Apr 2023 09:41:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ajUEBNrrqlo7NLbMBFZBxhABZNBWjNLqBWj6Qhq7WnBXzPQ9lMhNrGPdDfuPO/IRJuRxGCtQ==
X-Received: by 2002:ad4:5de6:0:b0:5da:b965:1efd with SMTP id jn6-20020ad45de6000000b005dab9651efdmr27656333qvb.2.1681317684546;
        Wed, 12 Apr 2023 09:41:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id m10-20020ad44b6a000000b005e1075e21b7sm5013110qvx.15.2023.04.12.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:41:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 04/31] selftests/mm: Merge util.h into vm_util.h
Date:   Wed, 12 Apr 2023 12:41:20 -0400
Message-Id: <20230412164120.327731-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
index 8235dddbbbc6..9d9822b4bf24 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -113,6 +113,10 @@ $(OUTPUT)/mkdirty: vm_util.c
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
index f9eb4d67e0dd..74281593a124 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -12,7 +12,7 @@
 
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
index 8dc74dd022c2..85411ee7ff8b 100644
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

