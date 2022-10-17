Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7C600EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJQMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJQMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001F27CC4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDC66110F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E03C433D6;
        Mon, 17 Oct 2022 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666008890;
        bh=jIjZUXmNnSsrYzF+LkNo9322ZJPJnyhB/ZCFQbJbGB4=;
        h=Date:From:To:Cc:Subject:From;
        b=C6W9mLuHghjwnyFNKsx3ixYVagjJ8SFMNim6fd1zDvI4VyjU/QISsin8RUm9kKDtR
         TAOYd3BFjyWJMaCtrXOc2pYRGH8163aa1RGoEELp6mEVm2FaDOC8hsjwZchg7Eb4OG
         KcgK24q+xExqO+Vwi2wbnonlqZKfoH78E6SD496HYzoKjS7HYCjY4wG/RxuJ/R69W7
         iTxmQMyASseHs9hwQaUxQQ437Av5gs/ia2KnWag3gzftx8TnT/LHkjp2u7XLESE5VN
         OitX39znGOCB57+p+7pmrMAA5GzfNtWZ6zHI1ggVg9J+VNZnQ6MOrghT7kwjZ1HjZy
         psfLlC3VyClhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 57F41403B6; Mon, 17 Oct 2022 09:14:47 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:14:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync powerpc syscall tables with
 the kernel sources
Message-ID: <Y01HN2DGkWz8tC/J@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  e237506238352f3b ("powerpc/32: fix syscall wrappers with 64-bit arguments of unaligned register-pairs")

That doesn't cause any changes in the perf tools.

As a reminder, this table is used in tools perf to allow features such as:

  [root@five ~]# perf trace -e set_mempolicy_home_node
  ^C[root@five ~]#
  [root@five ~]# perf trace -v -e set_mempolicy_home_node
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 253729 && common_pid != 3585) && (id == 450)
  mmap size 528384B
  ^C[root@five ~]
  [root@five ~]# perf trace -v -e set*  --max-events 5
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 253734 && common_pid != 3585) && (id == 38 || id == 54 || id == 105 || id == 106 || id == 109 || id == 112 || id == 113 || id == 114 || id == 116 || id == 117 || id == 119 || id == 122 || id == 123 || id == 141 || id == 160 || id == 164 || id == 170 || id == 171 || id == 188 || id == 205 || id == 218 || id == 238 || id == 273 || id == 308 || id == 450)
  mmap size 528384B
       0.000 ( 0.008 ms): bash/253735 setpgid(pid: 253735 (bash), pgid: 253735 (bash))      = 0
    6849.011 ( 0.008 ms): bash/16046 setpgid(pid: 253736 (bash), pgid: 253736 (bash))       = 0
    6849.080 ( 0.005 ms): bash/253736 setpgid(pid: 253736 (bash), pgid: 253736 (bash))      = 0
    7437.718 ( 0.009 ms): gnome-shell/253737 set_robust_list(head: 0x7f34b527e920, len: 24) = 0
   13445.986 ( 0.010 ms): bash/16046 setpgid(pid: 253738 (bash), pgid: 253738 (bash))       = 0
  [root@five ~]#

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ find tools/perf/arch/ -name "syscall*tbl" | xargs grep -w set_mempolicy_home_node
  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
  tools/perf/arch/s390/entry/syscalls/syscall.tbl:450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
  $

  $ grep -w set_mempolicy_home_node /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
	[450] = "set_mempolicy_home_node",
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl' differs from latest version at 'arch/mips/kernel/syscalls/syscall_n64.tbl'
  diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/arch/powerpc/entry/syscalls/syscall.tbl | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 2bca64f96164af9d..e9e0df4f9a61a494 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -228,8 +228,10 @@
 176	64	rt_sigtimedwait			sys_rt_sigtimedwait
 177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-179	common	pread64				sys_pread64			compat_sys_ppc_pread64
-180	common	pwrite64			sys_pwrite64			compat_sys_ppc_pwrite64
+179	32	pread64				sys_ppc_pread64			compat_sys_ppc_pread64
+179	64	pread64				sys_pread64
+180	32	pwrite64			sys_ppc_pwrite64		compat_sys_ppc_pwrite64
+180	64	pwrite64			sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
@@ -242,10 +244,11 @@
 188	common 	putpmsg				sys_ni_syscall
 189	nospu	vfork				sys_vfork
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
-191	common	readahead			sys_readahead			compat_sys_ppc_readahead
+191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
+191	64	readahead			sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
-193	32	truncate64			sys_truncate64			compat_sys_ppc_truncate64
-194	32	ftruncate64			sys_ftruncate64			compat_sys_ppc_ftruncate64
+193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
+194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
 195	32	stat64				sys_stat64
 196	32	lstat64				sys_lstat64
 197	32	fstat64				sys_fstat64
@@ -288,7 +291,8 @@
 230	common	io_submit			sys_io_submit			compat_sys_io_submit
 231	common	io_cancel			sys_io_cancel
 232	nospu	set_tid_address			sys_set_tid_address
-233	common	fadvise64			sys_fadvise64			compat_sys_ppc32_fadvise64
+233	32	fadvise64			sys_ppc32_fadvise64		compat_sys_ppc32_fadvise64
+233	64	fadvise64			sys_fadvise64
 234	nospu	exit_group			sys_exit_group
 235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
 236	common	epoll_create			sys_epoll_create
-- 
2.37.3

