Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26079642F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLERwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiLERvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:49 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40441EC5C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:51:47 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so11149874pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Nw3s1OJlt+QohVcTOOKp8qc8DHu5Xw6vYT/j54rUQ=;
        b=PIGWqACKG6oWbEugXMS+KTR2Px2Y3qGeZuVYT1au4PLZfEuAh4gVH0bY3f2R5dFtaq
         1uZxVz0caV+GcKDskviVDama9aByC8ikG5ZE5wfpd8hdrLaMVvLfB6nP9EHnC6yIcL04
         NJrSpyXi0RmgnV8Miwrdv4W+roV4ITaTBS0+RO71/51ZBG5Mr9l7GnA+e9ldsYbmUbOD
         PCSEPnxNpStL+QByu4xU1GVCsA62d9eDstAm2kB5o6hvyjnxwwcPkqAYMP+SyB0ekqi/
         owoFd4HK9Jzm1yJYjnFo767zpzz2YMWVfZBEiOweaCi5qbZBtawKw5h0Zm4tUSF8MWtD
         w8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Nw3s1OJlt+QohVcTOOKp8qc8DHu5Xw6vYT/j54rUQ=;
        b=N/ubIIJ4ddSTuSqtyg62HKv/6YOuPrKRd99NNI7AgGPU6xuDakwhKln4EjZpa7H83n
         c1Mu7eyCD5q1qdh3K7qKFNflpsHAvXPHIE1D6evMYmamCycuoSs7lMm5A2q5K5Qlblll
         8BilJHxxz6zDnQP3n4l8bQYDUfNWsVzanmAp5Io/oezBXaASOiX9w/UMUOjs57RX8owb
         u+JX4rVKTM2n1+VSY2a6GCPqM17NU8QP4swW6ax/yl6VO+TaT0wela8EB9NqX7G//NzB
         j7NeZLjUUOy/je+iMmYI+WZlPSnEtAkedfXEpUKpWyiZR/O127rALPdDGjHJKIkYb7A4
         pZyQ==
X-Gm-Message-State: ANoB5plb93kfhmktJVwEYtpurQohHPJl1WL8IHyJx4aCM/XnxoLbA+XB
        uyZLSOSY+BcDV0e6Yt16MR4=
X-Google-Smtp-Source: AA0mqf4QlNt4mCMUiETIzK8/hOhXtz8rV/ETSSKnqgcWPNDEjPOgqcYrNl4P0UIqYn7Og1R+J5EKTA==
X-Received: by 2002:a63:ec11:0:b0:470:5b0d:b50e with SMTP id j17-20020a63ec11000000b004705b0db50emr60322750pgh.488.1670262707128;
        Mon, 05 Dec 2022 09:51:47 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id e1-20020a621e01000000b0057621a437d7sm8187278pfe.116.2022.12.05.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:51:46 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v2 3/4] cachestat: implement cachestat syscall
Date:   Mon,  5 Dec 2022 09:51:39 -0800
Message-Id: <20221205175140.1543229-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205175140.1543229-1-nphamcs@gmail.com>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
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
        __u64 nr_cache;
        __u64 nr_dirty;
        __u64 nr_writeback;
        __u64 nr_evicted;
        __u64 nr_recently_evicted;
    };

    int cachestat(unsigned int fd, off_t off, size_t len,
        size_t cstat_size, struct cachestat *cstat);

DESCRIPTION
    cachestat() queries the number of cached pages, number of dirty
    pages, number of pages marked for writeback, number of (recently)
    evicted pages, in the bytes range given by `off` and `len`.

    These values are returned in a cachestat struct, whose address is
    given by the `cstat` argument.

    The `off` and `len` arguments must be non-negative integers. If
    `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
    0, we will query in the range from `off` to the end of the file.

    `cstat_size` allows users to obtain partial results. The syscall
    will copy the first `csstat_size` bytes to the specified userspace
    memory. `cstat_size` must be a non-negative value that is no larger
    than the current size of the cachestat struct.

RETURN VALUE
    On success, cachestat returns 0. On error, -1 is returned, and errno
    is set to indicate the error.

ERRORS
    EFAULT cstat points to an invalid address.

    EINVAL `off` or `len` is negative, or invalid `cstat_size`.

    EBADF  invalid file descriptor.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS                            |   7 ++
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mman.h              |   8 ++
 kernel/sys_ni.c                        |   1 +
 mm/Makefile                            |   2 +-
 mm/cachestat.c                         | 115 +++++++++++++++++++++++++
 9 files changed, 141 insertions(+), 2 deletions(-)
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
index a34b0f9a9972..55cea19b8bf6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct cachestat;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1056,6 +1057,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_cachestat(unsigned int fd, off_t off, size_t len,
+	size_t cstat_size, struct cachestat __user *cstat);

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
index f55bc680b5b0..ee2889e0654e 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,12 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB

+struct cachestat {
+	__u64 nr_cache;
+	__u64 nr_dirty;
+	__u64 nr_writeback;
+	__u64 nr_evicted;
+	__u64 nr_recently_evicted;
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
index 000000000000..59067f26eba3
--- /dev/null
+++ b/mm/cachestat.c
@@ -0,0 +1,115 @@
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
+ * The cachestat(4) system call.
+ *
+ * cachestat() returns the page cache status of a file in the
+ * bytes specified by `off` and `len`: number of cached pages,
+ * number of dirty pages, number of pages marked for writeback,
+ * number of (recently) evicted pages.
+ *
+ * `off` and `len` must be non-negative integers. If `len` > 0,
+ * the queried range is [`off`, `off` + `len`]. If `len` == 0,
+ * we will query in the range from `off` to the end of the file.
+ *
+ * `cstat_size` allows users to obtain partial results. The syscall
+ * will copy the first `csstat_size` bytes to the specified userspace
+ * memory. It also makes the cachestat struct extensible - new fields
+ * can be added in the future without breaking existing usage.
+ * `cstat_size` must be a non-negative value that is no larger than
+ * the current size of the cachestat struct.
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
+SYSCALL_DEFINE5(cachestat, unsigned int, fd, off_t, off, size_t, len,
+	size_t, cstat_size, struct cachestat __user *, cstat)
+{
+	struct fd f;
+	struct cachestat cs;
+
+	memset(&cs, 0, sizeof(struct cachestat));
+
+	if (off < 0 || len < 0 ||
+		cstat_size > sizeof(struct cachestat) ||
+		cstat_size < 0)
+		return -EINVAL;
+
+	if (!access_ok(cstat, sizeof(struct cachestat)))
+		return -EFAULT;
+
+	f = fdget(fd);
+	if (f.file) {
+		struct address_space *mapping = f.file->f_mapping;
+		pgoff_t first_index = off >> PAGE_SHIFT;
+		pgoff_t last_index =
+			len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
+		XA_STATE(xas, &mapping->i_pages, first_index);
+		struct folio *folio;
+
+		rcu_read_lock();
+		xas_for_each(&xas, folio, last_index) {
+			if (xas_retry(&xas, folio) || !folio)
+				continue;
+
+			if (xa_is_value(folio)) {
+				/* page is evicted */
+				void *shadow = (void *)folio;
+				bool workingset; /* not used */
+
+				cs.nr_evicted += 1;
+
+#if defined(CONFIG_SWAP) /* implies CONFIG_MMU */
+				if (shmem_mapping(mapping)) {
+					/* shmem file - in swap cache */
+					swp_entry_t swp = radix_to_swp_entry(folio);
+
+					shadow = get_shadow_from_swap_cache(swp);
+				}
+#endif
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
+		if (copy_to_user(cstat, &cs, cstat_size))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	return -EBADF;
+}
--
2.30.2
