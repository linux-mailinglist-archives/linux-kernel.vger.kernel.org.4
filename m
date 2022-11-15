Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D662A153
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKOS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKOS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:29:15 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C82FFEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q71so14037153pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+CgD6b3VuRjXvN+H9oTC8+sOdeozxCPLL1LFRJAE7c=;
        b=DcMxx7DRBkE7cfl2G0MrzZbevyc+hmDxLJ95GRKE3hesCDxUvL18vQyoEMB0t27Snp
         SYqi/0I0t1zns6q62mPtM9geuwYeZv0m+pcz2Qt537doPYDH2nlh53hOT27pPwvjBlSG
         UDe3T+56318o8ql2nuTQjslk5K/vWpRj15rrsHPd6gf/b6wHktO7kLZ66fmw3G93Bvmn
         FJwSHo1EEO8Py5BA6fW8Q7nbKwkKpM8z5RM0fpx6vy6sTuDcdAIwqOx4EQALEhCI1Lac
         gVCt10HnuJ50rr0F4152yj7SoUs9oMeZcoFv64jCKQ4j+UeT8k/8aPF2QFC6+EVySP5B
         urTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+CgD6b3VuRjXvN+H9oTC8+sOdeozxCPLL1LFRJAE7c=;
        b=AJWjIKm+cDgIX3OAxTI7dtyv2JVnjD6AsDDXCNsn3DpIcjeCnvktfPqGmxVdnMiLvV
         NceVTWl95hYILpy92+54T1Wb+IL+qAXlXgCT3ynd85YlqR//VDhg+GoIGPdm2NiB5WlH
         ojHFc4HKEuE+/wNVDYcfX3kH3XYoKDubQsshQBW2H9CQSeangdkeQ51/C4ft2p+lgwmH
         Y/WL5s8T8R3yzFIR1Q2wVOh9ziZW/JRfH8HEXBK7v0FbACtXs/kTfPXkl1N1Q+QEEdeg
         fJHH70YrSDO6Qb802/HO+dKUJ0OvfHia6OUuCMsrKsducDGAEsn2swwxwlgIoaYdTT69
         ZSbg==
X-Gm-Message-State: ANoB5pnCz+rxLrzuhZE5Ls29GT+cew3SctAxhz2ePz22wQHM9MTtrgZf
        7umJQXvDBE5BLobaPDQUb7k=
X-Google-Smtp-Source: AA0mqf7i6JW5fSPGB3a/irLrZrIpTzGyhKZQPxL70HKFZLgQRVhdD/4Gk6F7Fboe6pSAjmAZjP5yLA==
X-Received: by 2002:a63:f006:0:b0:46f:d9f:2788 with SMTP id k6-20020a63f006000000b0046f0d9f2788mr17098327pgh.195.1668536947197;
        Tue, 15 Nov 2022 10:29:07 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0017f7c4e260fsm10233512plb.150.2022.11.15.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:29:06 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org
Subject: [PATCH 3/4] cachestat: implement cachestat syscall
Date:   Tue, 15 Nov 2022 10:29:00 -0800
Message-Id: <20221115182901.2755368-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115182901.2755368-1-nphamcs@gmail.com>
References: <20221115182901.2755368-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a new syscall that queries cache state of a file and
summarizes the number of cached pages, number of dirty pages, number of
pages marked for writeback, number of (recently) evicted pages, etc. in
a given range.

NAME
    cachestat - query the page cache status of a file.

SYNOPSIS
    #include <sys/mman.h>

    struct cachestat {
        unsigned long nr_cache;
        unsigned long nr_dirty;
        unsigned long nr_writeback;
        unsigned long nr_evicted;
        unsigned long nr_recently_evicted;
    };

    int cachestat(unsigned int fd, off_t off, size_t len,
        struct cachestat *cstat);

DESCRIPTION
    cachestat() queries the number of cached pages, number of dirty
    pages, number of pages marked for writeback, number of (recently)
    evicted pages, in the bytes range given by `off` and `len`.

    These values are returned in a cachestat struct, whose address is
    given by the `cstat` argument.

    The `off` argument must be a non-negative integers, If `off` + `len`
    >= `off`, the queried range is [`off`, `off` + `len`]. Otherwise, we
    will query in the range from `off` to the end of the file.

RETURN VALUE
    On success, cachestat returns 0. On error, -1 is returned, and errno
    is set to indicate the error.

ERRORS
    EFAULT cstat points to an invalid address.

    EINVAL `off` is negative.

    EBADF  invalid file descriptor.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS                            |   7 ++
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mman.h              |   8 ++
 kernel/sys_ni.c                        |   1 +
 mm/Makefile                            |   2 +-
 mm/cachestat.c                         | 109 +++++++++++++++++++++++++
 9 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 mm/cachestat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a198da986146..baa081a1fe52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4552,6 +4552,13 @@ S:	Supported
 F:	Documentation/filesystems/caching/cachefiles.rst
 F:	fs/cachefiles/
 
+CACHESTAT: PAGE CACHE STATS FOR A FILE
+M:	Nhat Pham <nphamcs@gmail.com>
+M:	Johannes Weiner <hannes@cmpxchg.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/cachestat.c
+
 CADENCE MIPI-CSI2 BRIDGES
 M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..bc0a3c941b35 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	cachestat		sys_cachestat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..8eed4cdc7965 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat	sys_cachestat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..59e4d56225ae 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,6 +1056,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_cachestat(unsigned int fd, off_t off, size_t len,
+	struct cachestat __user *ret_cstat);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..cd639fae9086 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_cachestat 451
+__SYSCALL(__NR_cachestat, sys_cachestat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..8690c82acd02 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,12 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+struct cachestat {
+	unsigned long nr_cache;
+	unsigned long nr_dirty;
+	unsigned long nr_writeback;
+	unsigned long nr_evicted;
+	unsigned long nr_recently_evicted;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..04bfb1e4d377 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -299,6 +299,7 @@ COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
+COND_SYSCALL(cachestat);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..e71b15743ce6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o cachestat.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/cachestat.c b/mm/cachestat.c
new file mode 100644
index 000000000000..193151cb0767
--- /dev/null
+++ b/mm/cachestat.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * The cachestat() system call.
+ */
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/syscalls.h>
+#include <linux/shmem_fs.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <uapi/linux/mman.h>
+
+#include "swap.h"
+
+/*
+ * The cachestat(3) system call.
+ *
+ * cachestat() returns the page cache status of a file in the
+ * bytes specified by `off` and `len`: number of cached pages,
+ * number of dirty pages, number of pages marked for writeback,
+ * number of (recently) evicted pages.
+ *
+ * If `off` + `len` >= `off`, the queried range is [`off`, `off` + `len`].
+ * Otherwise, we will query in the range from `off` to the end of the file.
+ *
+ * Because the status of a page can change after cachestat() checks it
+ * but before it returns to the application, the returned values may
+ * contain stale information.
+ *
+ * return values:
+ *  zero    - success
+ *  -EFAULT - cstat points to an illegal address
+ *  -EINVAL - invalid arguments
+ *  -EBADF	- invalid file descriptor
+ */
+SYSCALL_DEFINE4(cachestat, unsigned int, fd, off_t, off, size_t, len,
+	struct cachestat __user *, cstat)
+{
+	struct fd f;
+	struct cachestat cs;
+
+	memset(&cs, 0, sizeof(struct cachestat));
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (!access_ok(cstat, sizeof(struct cachestat)))
+		return -EFAULT;
+
+	f = fdget(fd);
+	if (f.file) {
+		struct address_space *mapping = f.file->f_mapping;
+		pgoff_t first_index = off >> PAGE_SHIFT;
+		XA_STATE(xas, &mapping->i_pages, first_index);
+		struct folio *folio;
+		pgoff_t last_index = (off + len - 1) >> PAGE_SHIFT;
+
+		if (last_index < first_index)
+			last_index = ULONG_MAX;
+
+		rcu_read_lock();
+		xas_for_each(&xas, folio, last_index) {
+			if (xas_retry(&xas, folio) || !folio)
+				continue;
+
+			if (xa_is_value(folio)) {
+				/* page is evicted */
+				void *shadow;
+				bool workingset; /* not used */
+
+				cs.nr_evicted += 1;
+
+				if (shmem_mapping(mapping)) {
+					/* shmem file - in swap cache */
+					swp_entry_t swp = radix_to_swp_entry(folio);
+
+					shadow = get_shadow_from_swap_cache(swp);
+				} else {
+					/* in page cache */
+					shadow = (void *) folio;
+				}
+
+				if (workingset_test_recent(shadow, true, &workingset))
+					cs.nr_recently_evicted += 1;
+
+				continue;
+			}
+
+			/* page is in cache */
+			cs.nr_cache += 1;
+
+			if (folio_test_dirty(folio))
+				cs.nr_dirty += 1;
+
+			if (folio_test_writeback(folio))
+				cs.nr_writeback += 1;
+		}
+		rcu_read_unlock();
+		fdput(f);
+
+		if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	return -EBADF;
+}
-- 
2.30.2

