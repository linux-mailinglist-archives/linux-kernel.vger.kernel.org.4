Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8189674F273
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGKOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGKOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26763E4F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88366150B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3767C433C7;
        Tue, 11 Jul 2023 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086296;
        bh=Swg/IFZ2TdWBH9aj6OulRZHbENcokaLkM5oytamj+Ds=;
        h=Date:From:To:Cc:Subject:From;
        b=MPqtCvjRcLZALP58cugS1C8NIA7lSCR46a1mSotQoC2rjQDdTgqVqVjpMe9nMX1Wz
         m2awZnVqTXUEX1SqM8IoFgNonqyBKRSDN52EeHb8tw7RM+/8f0Lh94HjVeq13t3hLw
         5TP1/Jpbughc6gVCCHZjuVKAZ8BNBEbKyJj4Ccro8JmWxGzOM7n9qNBaBqizfnI5t/
         6Q/TWbTcl6/QCMTZhz+TTRggJHvgo8LXvnAO81UqiUaj/VTxrDrA4gLQS86lxJvpKV
         k6oBqienb2lnzCCF6Dn3BHulWzp+7wi4nGpcPRSeGPjMTFAxWib9A2vtORUDf+t68s
         wcigBxiQV87OA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE28F40516; Tue, 11 Jul 2023 11:38:12 -0300 (-03)
Date:   Tue, 11 Jul 2023 11:38:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync files changed by new
 cachestat syscall with the kernel sources
Message-ID: <ZK1pVBJpbjujJNJW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in these csets:

  cf264e1329fb0307 ("cachestat: implement cachestat syscall")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible:

  # perf trace -e cachestat
  ^C[root@five ~]#
  # perf trace -v -e cachestat
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 3163687 && common_pid != 3147) && (id == 451)
  mmap size 528384B
  ^C[root@five ~]

  # perf trace -v -e *stat* --max-events=10
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 3163713 && common_pid != 3147) && (id == 4 || id == 5 || id == 6 || id == 136 || id == 137 || id == 138 || id == 262 || id == 332 || id == 451)
  mmap size 528384B
       0.000 ( 0.009 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, buf: 0x7f8745725b60)                     = 0
       0.012 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: 0x45635288, statbuf: 0x7f874569d250)   = 0
       0.036 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: 0x541b7093, statbuf: 0x7f87457256f0, flag: 4096) = 0
       0.372 ( 0.006 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, buf: 0x7f8745725b10)                     = 0
       0.379 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: 0x45635288, statbuf: 0x7f874569d250)   = 0
       0.390 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: 0x541b7093, statbuf: 0x7f87457256a0, flag: 4096) = 0
       0.609 ( 0.005 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, buf: 0x7f8745725b60)                     = 0
       0.615 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: 0x45635288, statbuf: 0x7f874569d250)   = 0
       0.625 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: 0x541b7093, statbuf: 0x7f87457256f0, flag: 4096) = 0
       0.826 ( 0.005 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, buf: 0x7f8745725b10)                     = 0
  #

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ find tools/perf/arch/ -name "syscall*tbl" | xargs grep -w sys_cachestat
  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:451	n64	cachestat			sys_cachestat
  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:451	common	cachestat			sys_cachestat
  tools/perf/arch/s390/entry/syscalls/syscall.tbl:451  common	cachestat		sys_cachestat			sys_cachestat
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:451	common	cachestat		sys_cachestat
  $

  $ grep -w cachestat /tmp/build/perf-tools/arch/x86/include/generated/asm/syscalls_64.c
  	[451] = "cachestat",
  $

This addresses these perf build warnings:

Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h            |  5 ++++-
 tools/include/uapi/linux/mman.h                    | 14 ++++++++++++++
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 6 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index dd7d8e10f16d83a1..fd6c1cb585db43c4 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -817,8 +817,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
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
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index f55bc680b5b0a45e..a246e11988d5e0e2 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
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
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 3f1886ad9d8060b4..cfda2511badf3ad0 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,4 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	cachestat			sys_cachestat
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index a0be127475b1f761..8c0b08b7a80ec4b7 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -537,3 +537,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index b68f47541169f9af..a6935af2235cab6c 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	cachestat		sys_cachestat			sys_cachestat
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2de9e..227538b0ce801eeb 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat		sys_cachestat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.37.1

