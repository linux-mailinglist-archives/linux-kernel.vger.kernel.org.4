Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1F6B2B94
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCIRHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjCIRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:06:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79580F738C;
        Thu,  9 Mar 2023 09:02:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i3so2673791plg.6;
        Thu, 09 Mar 2023 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzDWyyuJKDTCZnE2ja8gdqmsnS+AxwsEMIGip3aqD5E=;
        b=hQhGe6nVuv0xZt67nHAHISqcUVPVZjfz21EoeqNsxeoRrU91oWa9sccOx2VcPS0Kzo
         2ZEOHMRxvTCOyZWMu6bOXI8Eo7YMITqckIdrtOrnvlO/Vp7J8VTFvJ0pg+0qllmR4hZ4
         hDEstqfq9f3c84rMStL3bfkH6qaXsZaXTHTL7U+OncKqPukj/7OqlSXMTEjhUbmDwTqc
         y5yenNxlo8iYEf0WSO18URTHhQTJ/wjovk4PmHsB/7M3jlwK+DLoMftKDQDI52fDZsEe
         Eg4NabMm2mXSsDE2OCZGiqwZrPqszzOGKPUCj0oKHDPWiQixTIDezMVYKTRzxJ/RiaOT
         8uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzDWyyuJKDTCZnE2ja8gdqmsnS+AxwsEMIGip3aqD5E=;
        b=CCpnIc1TfHLBdZ/v7U9BFnbatsr6+StotEUa552s+awF1G9ubnYVw2fyLMpGSpRcxq
         yY1316UI4Kw54diH//2h+cXKSA38zTN6UUODhPYSAudoW6vBrCFc0KGEmAKRob81WYRy
         H7nVeHyPTvQOObqOqA/W+iCTdjpzBlILpK1BTi0XzeCIoZvHfGtowmMHbRdHy/5gXAFc
         zvdGnzQ7POSjotYj7Dqq6GfL6CjCNu5zgaIhPdbuYpKCnKE4ejG2BfTe3J4mEsSIjd+u
         5qNAlGTYZOmiDgbbEKeVrACcFPN5vDbF60qalqspTrPEV6g7ux61lPeGYxXqPeDVlQp5
         oM2A==
X-Gm-Message-State: AO0yUKWWUfyWo5RqrOzkwULaURLxekF6SwVWVLAIVJmddTgqA64fy0Lr
        aCyvPHm2C2WotfnRcamQRU4=
X-Google-Smtp-Source: AK7set9vbI8HCgEPwFjpD9AoVR87dPS4efYobQNj2CInAqra5LNcIuxkByOQfpHmRJMkf0BgwvNWwQ==
X-Received: by 2002:a17:902:ab0c:b0:19b:c491:21be with SMTP id ik12-20020a170902ab0c00b0019bc49121bemr20320078plb.64.1678381354630;
        Thu, 09 Mar 2023 09:02:34 -0800 (PST)
Received: from localhost ([113.161.42.54])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b0019a74afe97dsm11704665plb.187.2023.03.09.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:02:33 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v11 2/3] cachestat: implement cachestat syscall
Date:   Thu,  9 Mar 2023 09:02:31 -0800
Message-Id: <20230309170231.755569-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308032748.609510-3-nphamcs@gmail.com>
References: <20230308032748.609510-3-nphamcs@gmail.com>
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

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page
information in that case. The user also needs to mmap and unmap each
file as it goes along, which can be quite slow as well.

This patch implements a new syscall that queries cache state of a file
and summarizes the number of cached pages, number of dirty pages, number
of pages marked for writeback, number of (recently) evicted pages, etc.
in a given range. Currently, the syscall is only wired in for x86
architecture.

NAME
    cachestat - query the page cache statistics of a file.

SYNOPSIS
    #include <sys/mman.h>

    struct cachestat {
        __u64 nr_cache;
        __u64 nr_dirty;
        __u64 nr_writeback;
        __u64 nr_evicted;
        __u64 nr_recently_evicted;
    };

    int cachestat(unsigned int fd, size_t len, loff_t off,
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
    EFAULT cstat points to an invalid address.

    EINVAL invalid offset or flags.

    EBADF  invalid file descriptor.

    EOPNOTSUPP file descriptor is of a hugetlbfs file

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/compat.h                 |   4 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mman.h              |   9 ++
 init/Kconfig                           |  10 ++
 kernel/sys_ni.c                        |   1 +
 mm/filemap.c                           | 166 +++++++++++++++++++++++++
 9 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..01d1cc009250 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	cachestat		sys_cachestat		compat_sys_cachestat
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..6e2b7b8bdb1e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -426,6 +426,7 @@ struct compat_sysctl_args;
 struct compat_kexec_segment;
 struct compat_mq_attr;
 struct compat_msgbuf;
+struct cachestat;

 void copy_siginfo_to_external32(struct compat_siginfo *to,
 		const struct kernel_siginfo *from);
@@ -817,6 +818,9 @@ asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned int flags);

 /* mm/filemap.c: No generic prototype for readahead */
+asmlinkage long compat_sys_cachestat(unsigned int fd, size_t len,
+		compat_arg_u64(off), struct cachestat __user *cstat,
+		unsigned int flags);

 /* security/keys/keyctl.c */
 asmlinkage long compat_sys_keyctl(u32 option,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..9f384a6d7e77 100644
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
+asmlinkage long sys_cachestat(unsigned int fd, size_t len, loff_t offset,
+		struct cachestat __user *cstat, unsigned int flags);

 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..dc5fcfee7f09 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)

+#define __NR_cachestat 451
+__SC_COMP(__NR_cachestat, sys_cachestat, compat_sys_cachestat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452

 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..fe03ed0b7587 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -4,6 +4,7 @@

 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
+#include <linux/types.h>

 #define MREMAP_MAYMOVE		1
 #define MREMAP_FIXED		2
@@ -41,4 +42,12 @@
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
diff --git a/init/Kconfig b/init/Kconfig
index 694f7c160c9c..da96ac29af1d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1798,6 +1798,16 @@ config RSEQ

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
index 08341616ae7a..749c4f59c625 100644
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
@@ -55,6 +56,9 @@
 #include <linux/buffer_head.h> /* for try_to_free_buffers */

 #include <asm/mman.h>
+#include <linux/mman.h>
+
+#include "swap.h"

 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
@@ -3949,3 +3953,165 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
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
+static void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+		pgoff_t last_index, struct cachestat *cs)
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
+		if (xa_is_value(folio)) {
+			/* page is evicted */
+			void *shadow = (void *)folio;
+			bool workingset; /* not used */
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
+#ifdef CONFIG_CACHESTAT_SYSCALL
+static long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
+		struct cachestat __user *cstat, unsigned int flags)
+{
+	struct fd f = fdget(fd);
+	struct address_space *mapping;
+	struct cachestat cs;
+	pgoff_t first_index = off >> PAGE_SHIFT;
+	pgoff_t last_index =
+		len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
+
+	if (!f.file)
+		return -EBADF;
+
+	/* hugetlbfs is not supported */
+	if (is_file_hugepages(f.file)) {
+		fdput(f);
+		return -EOPNOTSUPP;
+	}
+
+	if (off < 0 || flags != 0) {
+		fdput(f);
+		return -EINVAL;
+	}
+
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
+
+/*
+ * The cachestat(5) system call.
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
+ *  -EFAULT     - cstat points to an illegal address
+ *  -EINVAL     - invalid arguments
+ *  -EBADF      - invalid file descriptor
+ *  -EOPNOTSUPP - file descriptor is of a hugetlbfs file
+ */
+SYSCALL_DEFINE5(cachestat, unsigned int, fd, size_t, len, loff_t, off,
+		struct cachestat __user *, cstat, unsigned int, flags)
+{
+	return ksys_cachestat(fd, len, off, cstat, flags);
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
+		compat_arg_u64_dual(off), struct cachestat __user *, cstat,
+		unsigned int, flags)
+{
+	return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
+}
+#endif
+#endif /* CONFIG_CACHESTAT_SYSCALL */
--
2.39.2
