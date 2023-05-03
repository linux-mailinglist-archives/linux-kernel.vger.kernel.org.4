Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E06F4E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjECBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECBgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:36:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7352D5E;
        Tue,  2 May 2023 18:36:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24dfc3c662eso2147447a91.3;
        Tue, 02 May 2023 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683077772; x=1685669772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VX1P6p4S44WrbFadgyxcCHiNhnuoZy6JRGXDkBCmYw=;
        b=ZUi5CHiSpNlwcO0k6OK5+buqnIzWlJEj+oOp4gzxGMfDwuYeEQCHHYTs5skf8QdGwT
         HbW9SlITQhs1GRxpbGgQDKekbP1G9s1Dzb3JCUmsYxtozfUyKeIDSB/wnq8zRyP+/a7W
         1L33O5u5TbSy1rNUS6AGQaqie/J3MG+dloAXIMmEt96VXPC4/c4Gae4kXTZL5pLuaMMw
         mgv2h+N719a3+9DAI0U5kzthZGbSJkDNxknp4u9VTpua0oJ6EZ4YOhWXTSicqKI9vfjx
         J/RmIUMSPakSUOHSJlgP1jMV4B7B7vpK/7VMKF41+DKctXGlmUF68t79aE7067QWo2Qz
         by1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683077772; x=1685669772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VX1P6p4S44WrbFadgyxcCHiNhnuoZy6JRGXDkBCmYw=;
        b=TldcMS+mmHK1jeUG8zrgHGLB/cvPcUN7jrlva86iOe0/n3awlMWF+bntoom8cXaSmI
         Nu6/zyA9HTLJpp+NhrAV6mXljS5z174ZGUu4+0MbJWbwXHQW5lpufnkUUy0H4kEGjdXe
         Vn6kCUrE3Vq186Xql1353LugZ5sxPaMXdU2IjdoSxDBgfbeoOtNLZ7V65ltWplk1Qysa
         lt1DlF26DMxJQGknn2AIQQO8n5iXBoUbj3zFrXC7dZfqkwdDxwCPwqGceqzqVyAmulSW
         84F6j5WhpK2Hlmjz6sDFTCXrb/IChHhMDilmydtGkWnUTlHL7G3zqdtAHSRM1TmCN5tI
         5Afw==
X-Gm-Message-State: AC+VfDyF3Sp65DsPO5EdIbJhV6BLTUzZnMb9+U/16Eoby8eN08czVNca
        PmPuOiyL1qwN4/ENb2Kc1zFWMd1xMDI=
X-Google-Smtp-Source: ACHHUZ5mT5eL4Sj54XO1uOUSYuiNrzkj4TzUJHkEX2lumO7/W84k3Mwf9FNqtXIlbWEEZwcclO+UPA==
X-Received: by 2002:a17:90b:33cc:b0:24d:ee34:57b6 with SMTP id lk12-20020a17090b33cc00b0024dee3457b6mr11070768pjb.41.1683077771422;
        Tue, 02 May 2023 18:36:11 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id co1-20020a17090afe8100b0024de5227d1fsm48108pjb.40.2023.05.02.18.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 18:36:11 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v13 2/3] cachestat: implement cachestat syscall
Date:   Tue,  2 May 2023 18:36:07 -0700
Message-Id: <20230503013608.2431726-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503013608.2431726-1-nphamcs@gmail.com>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page
information in that case. The user also needs to mmap and unmap each
file as it goes along, which can be quite slow as well.

Some use cases where this information could come in handy:
  * Allowing database to decide whether to perform an index scan or
    direct table queries based on the in-memory cache state of the
    index.
  * Visibility into the writeback algorithm, for performance issues
    diagnostic.
  * Workload-aware writeback pacing: estimating IO fulfilled by page
    cache (and IO to be done) within a range of a file, allowing for
    more frequent syncing when and where there is IO capacity, and
    batching when there is not.
  * Computing memory usage of large files/directory trees, analogous to
    the du tool for disk usage.

More information about these use cases could be found in the following
thread:

https://lore.kernel.org/lkml/20230315170934.GA97793@cmpxchg.org/

This patch implements a new syscall that queries cache state of a file
and summarizes the number of cached pages, number of dirty pages, number
of pages marked for writeback, number of (recently) evicted pages, etc.
in a given range. Currently, the syscall is only wired in for x86
architecture.

NAME
    cachestat - query the page cache statistics of a file.

SYNOPSIS
    #include <sys/mman.h>

    struct cachestat_range {
        __u64 off;
        __u64 len;
    };

    struct cachestat {
        __u64 nr_cache;
        __u64 nr_dirty;
        __u64 nr_writeback;
        __u64 nr_evicted;
        __u64 nr_recently_evicted;
    };

    int cachestat(unsigned int fd, struct cachestat_range *cstat_range,
        struct cachestat *cstat, unsigned int flags);

DESCRIPTION
    cachestat() queries the number of cached pages, number of dirty
    pages, number of pages marked for writeback, number of evicted
    pages, number of recently evicted pages, in the bytes range given by
    `off` and `len`.

    An evicted page is a page that is previously in the page cache but
    has been evicted since. A page is recently evicted if its last
    eviction was recent enough that its reentry to the cache would
    indicate that it is actively being used by the system, and that
    there is memory pressure on the system.

    These values are returned in a cachestat struct, whose address is
    given by the `cstat` argument.

    The `off` and `len` arguments must be non-negative integers. If
    `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
    0, we will query in the range from `off` to the end of the file.

    The `flags` argument is unused for now, but is included for future
    extensibility. User should pass 0 (i.e no flag specified).

    Currently, hugetlbfs is not supported.

    Because the status of a page can change after cachestat() checks it
    but before it returns to the application, the returned values may
    contain stale information.

RETURN VALUE
    On success, cachestat returns 0. On error, -1 is returned, and errno
    is set to indicate the error.

ERRORS
    EFAULT cstat or cstat_args points to an invalid address.

    EINVAL invalid flags.

    EBADF  invalid file descriptor.

    EOPNOTSUPP file descriptor is of a hugetlbfs file

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/syscalls.h               |   5 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mman.h              |  14 ++
 init/Kconfig                           |  10 ++
 kernel/sys_ni.c                        |   1 +
 mm/filemap.c                           | 172 +++++++++++++++++++++++++
 8 files changed, 208 insertions(+), 1 deletion(-)

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
index c84d12608cd2..227538b0ce80 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat		sys_cachestat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..6648c07c4381 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,8 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct cachestat_range;
+struct cachestat;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1058,6 +1060,9 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_cachestat(unsigned int fd,
+		struct cachestat_range __user *cstat_range,
+		struct cachestat __user *cstat, unsigned int flags);
 
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
index f55bc680b5b0..a246e11988d5 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -4,6 +4,7 @@
 
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
+#include <linux/types.h>
 
 #define MREMAP_MAYMOVE		1
 #define MREMAP_FIXED		2
@@ -41,4 +42,17 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+struct cachestat_range {
+	__u64 off;
+	__u64 len;
+};
+
+struct cachestat {
+	__u64 nr_cache;
+	__u64 nr_dirty;
+	__u64 nr_writeback;
+	__u64 nr_evicted;
+	__u64 nr_recently_evicted;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..f7f65af4ee12 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1771,6 +1771,16 @@ config RSEQ
 
 	  If unsure, say Y.
 
+config CACHESTAT_SYSCALL
+	bool "Enable cachestat() system call" if EXPERT
+	default y
+	help
+	  Enable the cachestat system call, which queries the page cache
+	  statistics of a file (number of cached pages, dirty pages,
+	  pages marked for writeback, (recently) evicted pages).
+
+	  If unsure say Y here.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enabled debugging of rseq() system call" if EXPERT
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
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..73b043240cef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -58,6 +59,8 @@
 
 #include <asm/mman.h>
 
+#include "swap.h"
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -4119,3 +4122,172 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
+#ifdef CONFIG_CACHESTAT_SYSCALL
+/**
+ * filemap_cachestat() - compute the page cache statistics of a mapping
+ * @mapping:	The mapping to compute the statistics for.
+ * @first_index:	The starting page cache index.
+ * @last_index:	The final page index (inclusive).
+ * @cs:	the cachestat struct to write the result to.
+ *
+ * This will query the page cache statistics of a mapping in the
+ * page range of [first_index, last_index] (inclusive). The statistics
+ * queried include: number of dirty pages, number of pages marked for
+ * writeback, and the number of (recently) evicted pages.
+ */
+static void filemap_cachestat(struct address_space *mapping,
+		pgoff_t first_index, pgoff_t last_index, struct cachestat *cs)
+{
+	XA_STATE(xas, &mapping->i_pages, first_index);
+	struct folio *folio;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_index) {
+		unsigned long nr_pages;
+		pgoff_t folio_first_index, folio_last_index;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		if (xa_is_value(folio)) {
+			/* page is evicted */
+			void *shadow = (void *)folio;
+			bool workingset; /* not used */
+			int order = xa_get_order(xas.xa, xas.xa_index);
+
+			nr_pages = 1 << order;
+			/* rounds down to the nearest multiple of 2^order */
+			folio_first_index = xas.xa_index >> order << order;
+			folio_last_index = folio_first_index + nr_pages - 1;
+
+			/* Folios might straddle the range boundaries, only count covered pages */
+			if (folio_first_index < first_index)
+				nr_pages -= first_index - folio_first_index;
+
+			if (folio_last_index > last_index)
+				nr_pages -= folio_last_index - last_index;
+
+			cs->nr_evicted += nr_pages;
+
+#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
+			if (shmem_mapping(mapping)) {
+				/* shmem file - in swap cache */
+				swp_entry_t swp = radix_to_swp_entry(folio);
+
+				shadow = get_shadow_from_swap_cache(swp);
+			}
+#endif
+			if (workingset_test_recent(shadow, true, &workingset))
+				cs->nr_recently_evicted += nr_pages;
+
+			goto resched;
+		}
+
+		nr_pages = folio_nr_pages(folio);
+		folio_first_index = folio_pgoff(folio);
+		folio_last_index = folio_first_index + nr_pages - 1;
+
+		/* Folios might straddle the range boundaries, only count covered pages */
+		if (folio_first_index < first_index)
+			nr_pages -= first_index - folio_first_index;
+
+		if (folio_last_index > last_index)
+			nr_pages -= folio_last_index - last_index;
+
+		/* page is in cache */
+		cs->nr_cache += nr_pages;
+
+		if (folio_test_dirty(folio))
+			cs->nr_dirty += nr_pages;
+
+		if (folio_test_writeback(folio))
+			cs->nr_writeback += nr_pages;
+
+resched:
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * The cachestat(2) system call.
+ *
+ * cachestat() returns the page cache statistics of a file in the
+ * bytes range specified by `off` and `len`: number of cached pages,
+ * number of dirty pages, number of pages marked for writeback,
+ * number of evicted pages, and number of recently evicted pages.
+ *
+ * An evicted page is a page that is previously in the page cache
+ * but has been evicted since. A page is recently evicted if its last
+ * eviction was recent enough that its reentry to the cache would
+ * indicate that it is actively being used by the system, and that
+ * there is memory pressure on the system.
+ *
+ * `off` and `len` must be non-negative integers. If `len` > 0,
+ * the queried range is [`off`, `off` + `len`]. If `len` == 0,
+ * we will query in the range from `off` to the end of the file.
+ *
+ * The `flags` argument is unused for now, but is included for future
+ * extensibility. User should pass 0 (i.e no flag specified).
+ *
+ * Currently, hugetlbfs is not supported.
+ *
+ * Because the status of a page can change after cachestat() checks it
+ * but before it returns to the application, the returned values may
+ * contain stale information.
+ *
+ * return values:
+ *  zero        - success
+ *  -EFAULT     - cstat or cstat_range points to an illegal address
+ *  -EINVAL     - invalid flags
+ *  -EBADF      - invalid file descriptor
+ *  -EOPNOTSUPP - file descriptor is of a hugetlbfs file
+ */
+SYSCALL_DEFINE4(cachestat, unsigned int, fd,
+		struct cachestat_range __user *, cstat_range,
+		struct cachestat __user *, cstat, unsigned int, flags)
+{
+	struct fd f = fdget(fd);
+	struct address_space *mapping;
+	struct cachestat_range csr;
+	struct cachestat cs;
+	pgoff_t first_index, last_index;
+
+	if (!f.file)
+		return -EBADF;
+
+	if (copy_from_user(&csr, cstat_range,
+			sizeof(struct cachestat_range))) {
+		fdput(f);
+		return -EFAULT;
+	}
+
+	/* hugetlbfs is not supported */
+	if (is_file_hugepages(f.file)) {
+		fdput(f);
+		return -EOPNOTSUPP;
+	}
+
+	if (flags != 0) {
+		fdput(f);
+		return -EINVAL;
+	}
+
+	first_index = csr.off >> PAGE_SHIFT;
+	last_index =
+		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
+	memset(&cs, 0, sizeof(struct cachestat));
+	mapping = f.file->f_mapping;
+	filemap_cachestat(mapping, first_index, last_index, &cs);
+	fdput(f);
+
+	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* CONFIG_CACHESTAT_SYSCALL */
-- 
2.34.1
