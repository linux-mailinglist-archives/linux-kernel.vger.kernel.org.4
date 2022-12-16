Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7764F1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiLPTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28057B67
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3328771pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfj7//KZGx3L4vs1asXbZHiEbvSE2W37vabxM0hoJ8=;
        b=XyvoQwzMgd30oKLXbNCSHtBaFKuZiO62uBdvtZ0V+ri6ypZX1wYUEYC6CfR9jnAIUZ
         oXovRbwVtPxgB8xGuhGfdOAADmxaUqygXmHamXKxCPOW7eJGEjBIOevihiXmmdOUuJyS
         SgBWKEpogOMb60EJL+GTwP/hvCjtOhvPAz2zhaG85oCoYeHRVFzrS80EM1bztbhLchFv
         P/XiJqCIg7w3Rlhu8FFDAxviL1e5ahSEpx7hnFilhVJCF0KDDYz1TzJV0glGWt7CDykz
         uSSwLQYRrFFBnKL4sTFD6V/4jx2878YW6rR4B+iHRm431MXqy3QZIxSiDTMMv3qrp7QO
         /ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcfj7//KZGx3L4vs1asXbZHiEbvSE2W37vabxM0hoJ8=;
        b=5iJn3TONG4RK/n8t1zUefuvXNVT0j6nRV1yuk7kJpIHSs4+tioDEBhT7OBnW8iNZ95
         ON7Q5ncyNhYh2g5kdzR38sTaJuhoNccsyvi8HLhcAn9Re+3jIUKfUXpXvEHRBwAWla7U
         DkIBJx1go6hepZqgh+5DD2TfmhIm1juN5JQcr6F0TzPW8NPD+eTK0NfaYg82MjESUBE/
         GmyGox8mAXjMf0GLvjXJkzL6QOImNgdQshwlz+KvUbe7eGVqCDD7ahA8X4+ZRkEwWEoQ
         enyIyybW7zDzx6qDp96IVBHurEd0agV1Y7OvSjgX8ySoEOMB0J5fOom8ymMBEAorKHgV
         xh6w==
X-Gm-Message-State: ANoB5pmpguLNWV1ygyZyTd8asJ9Rd1LQ2oNXNjG06I0IncClKjQnY4sy
        YUgMPm/CzWEWwnUiB/82aFE=
X-Google-Smtp-Source: AA0mqf4bcRH4p+Q+rVHAlrlNkaHfUfl6OGuj5i02Ow7BCv6Ht00/D1exiyR13xkrkMCQSdy3+eT0/g==
X-Received: by 2002:a17:902:8548:b0:18c:fd25:a934 with SMTP id d8-20020a170902854800b0018cfd25a934mr30262434plo.61.1671218514611;
        Fri, 16 Dec 2022 11:21:54 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001873aa85e1fsm1953676plb.305.2022.12.16.11.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:21:54 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v4 3/4] cachestat: implement cachestat syscall
Date:   Fri, 16 Dec 2022 11:21:48 -0800
Message-Id: <20221216192149.3902877-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216192149.3902877-1-nphamcs@gmail.com>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
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
          size_t cstat_size, struct cachestat *cstat,
          unsigned int flags);

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

    The `flags` argument is unused for now, but is included for future
    extensibility. User should pass 0 (i.e no flag specified).

RETURN VALUE
    On success, cachestat returns 0. On error, -1 is returned, and errno
    is set to indicate the error.

ERRORS
    EFAULT cstat points to an invalid address.

    EINVAL invalid `cstat_size` or `flags`

    EBADF  invalid file descriptor.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/fs.h                          |   3 +
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   5 +-
 include/uapi/linux/mman.h                   |   9 ++
 init/Kconfig                                |  10 ++
 kernel/sys_ni.c                             |   1 +
 mm/filemap.c                                | 137 ++++++++++++++++++++
 20 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ebacf37a8cf..1f13995d00d7 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,4 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	cachestat			sys_cachestat
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..8ebed8a13874 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..f8c74ffeeefb 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..4f504783371f 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..858d22bf275c 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 8a99c998da9b..7c84a72306d1 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 2bca64f96164..937460f0a8ec 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..7df0329d46cb 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	cachestat		sys_cachestat			sys_cachestat
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..97377e8c5025 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..faa835f3c54a 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
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
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..2b69c3c035b6 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..8902799121c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -46,6 +46,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/mman.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_space *mapping1,
 				 struct address_space *mapping2);
 void filemap_invalidate_unlock_two(struct address_space *mapping1,
 				   struct address_space *mapping2);
+void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+		pgoff_t last_index, struct cachestat *cs);
 
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..50f8c6999d99 100644
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
+		size_t cstat_size, struct cachestat __user *cstat, unsigned int flags);
 
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
index 694f7c160c9c..ecc4f781dd6c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1798,6 +1798,16 @@ config RSEQ
 
 	  If unsure, say Y.
 
+config CACHESTAT
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
index 08341616ae7a..29ffb906caa4 100644
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
+#include <uapi/linux/mman.h>
+
+#include "swap.h"
 
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
@@ -3949,3 +3953,136 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
+#ifdef CONFIG_CACHESTAT
+/**
+ * filemap_cachestat() - compute the page cache statistics of a mapping
+ * @mapping:	The mapping to compute the statistics for.
+ * @first_index:	The starting page cache index.
+ * @last_index:	The final page index (inclusive).
+ * @cs:	the cachestat struct to write the result to.
+ *
+ * This will query the page cache statistics of a mapping in the
+ * page range of [first_index, last_index] (inclusive). THe statistics
+ * queried include: number of dirty pages, number of pages marked for
+ * writeback, and the number of (recently) evicted pages.
+ */
+void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
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
+		/* Folios might straddle the range boundaries, only count covered subpages */
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
+			continue;
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
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(filemap_cachestat);
+
+/*
+ * The cachestat(5) system call.
+ *
+ * cachestat() returns the page cache statistics of a file in the
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
+ * The `flags` argument is unused for now, but is included for future
+ * extensibility. User should pass 0 (i.e no flag specified).
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
+SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
+		size_t, cstat_size, struct cachestat __user *, cstat,
+		unsigned int, flags)
+{
+	struct fd f = fdget(fd);
+	struct address_space *mapping;
+	struct cachestat cs;
+	pgoff_t first_index = off >> PAGE_SHIFT;
+	pgoff_t last_index =
+		len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
+
+	if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
+		return -EINVAL;
+
+	if (!f.file)
+		return -EBADF;
+
+	memset(&cs, 0, sizeof(struct cachestat));
+	mapping = f.file->f_mapping;
+	filemap_cachestat(mapping, first_index, last_index, &cs);
+	fdput(f);
+
+	if (copy_to_user(cstat, &cs, cstat_size))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* CONFIG_CACHESTAT */
-- 
2.30.2
