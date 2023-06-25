Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A373D1C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjFYPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFYPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114EC4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8AFA60B94
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A06C433C0;
        Sun, 25 Jun 2023 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687707593;
        bh=jhPnN6xqET8asHZScraEM4yKUiQATKjNqh1tiKxtc2g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=U245k0jW7SjaOHAl3hhNUC7s/tiOcdIGMmfBrC/Zz9tQLcP5k/qe6fzIVdoPDQHCV
         HyFFbBO87khM+rJGHvwWfvBcnniCtM83RnvRZkKxeKVNrPd51B09zSVHml6rrwAF+x
         OOVSqAxcNttfWb/lULxA8cYxdekwGijwQ65tTfqN+SNWP4en5N7/6mAKSeWxzFsTZ5
         eSY0gCi8pDtzuVCVWn18iAT5x0TDVIrh6rxpkgyHy0XwJs/tSCvBDNJ8D7dJ77Ec1h
         R4L1T2Ip7/azOAqH1BVgTRWhSORNfeckuocz7C3sgITZ4n/2Ioee4fkm0Nkhp2mvUZ
         sbpgFF4c2ZK4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E0F4DCE39D8; Sun, 25 Jun 2023 08:39:52 -0700 (PDT)
Date:   Sun, 25 Jun 2023 08:39:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
        gwml@vger.gnuweeb.org, linux@weissschuh.net, broonie@kernel.org,
        falcon@tinylab.org
Subject: [GIT PULL] nolibc changes for v6.5
Message-ID: <85e93ea8-7cb9-4848-88e3-c3437ccc309c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.06.22a
  dd58d666ac08eb5eb81e4956172fc52b3bf0ab38: selftests/nolibc: make sure gcc always use little endian on MIPS (2023-06-09 11:46:10 -0700)

----------------------------------------------------------------
nolibc updates for v6.5

o	Add stackprotector support.

o	Fix RISC-V load-store instruction syntax to support 32-bit
	binaries, plus fixes for generic 32-bit support.

o	Fix use of s390 sys_fork().

o	Add my_syscall6() for ARM.

o	Support different platforms having different errno definitions.

o	Fix ppoll/ppoll_time64 arguments (add the fifth argument).

o	Force use of little endian on MIPS.

o	Improved testing, for example, better handling of different
	compilers and compiler versions, comparing nolibc behavior
	to that of libc, and additional test cases.

o	Improve syntax and header ordering.

o	Use existing <linux/reboot.h> instead of redefining constants.

o	Add syscall().

----------------------------------------------------------------
Mark Brown (1):
      tools/nolibc: Fix build of stdio.h due to header ordering

Thomas Weißschuh (33):
      tools/nolibc: tests: use volatile to force stack smashing
      tools/nolibc: add libc-test binary
      tools/nolibc: add wrapper for memfd_create
      tools/nolibc: implement fd-based FILE streams
      tools/nolibc: add testcases for vfprintf
      tools/nolibc: use standard __asm__ statements
      tools/nolibc: use __inline__ syntax
      tools/nolibc: use C89 comment syntax
      tools/nolibc: validate C89 compatibility
      tools/nolibc: s390: provide custom implementation for sys_fork
      tools/nolibc: add testcase for fork()/waitpid()
      tools/nolibc: remove LINUX_REBOOT_ constants
      tools/nolibc/unistd: add syscall()
      selftests/nolibc: reduce syscalls during space padding
      tools/nolibc: aarch64: add stackprotector support
      tools/nolibc: arm: add stackprotector support
      tools/nolibc: loongarch: add stackprotector support
      tools/nolibc: mips: add stackprotector support
      tools/nolibc: riscv: add stackprotector support
      tools/nolibc: fix typo pint -> point
      tools/nolibc: x86_64: disable stack protector for _start
      tools/nolibc: ensure stack protector guard is never zero
      tools/nolibc: add test for __stack_chk_guard initialization
      tools/nolibc: reformat list of headers to be installed
      tools/nolibc: add autodetection for stackprotector support
      tools/nolibc: simplify stackprotector compiler flags
      tools/nolibc: fix segfaults on compilers without attribute no_stack_protector
      tools/nolibc: s390: disable stackprotector in _start
      tools/nolibc: add support for prctl()
      selftests/nolibc: prevent coredumps during test execution
      tools/nolibc: support nanoseconds in stat()
      tools/nolibc: ensure fast64 integer types have 64 bits
      selftests/nolibc: remove test gettimeofday_null

Willy Tarreau (4):
      tools/nolibc: tests: fix build on non-c99 compliant compilers
      tools/nolibc: fix build of the test case using glibc
      selftests/nolibc: also count skipped and failed tests in output
      selftests/nolibc: make sure gcc always use little endian on MIPS

Zhangjin Wu (15):
      tools/nolibc: riscv: Fix up load/store instructions for rv32
      selftests/nolibc: syscall_args: use generic __NR_statx
      selftests/nolibc: print name instead of number for EOVERFLOW
      selftests/nolibc: remove the duplicated gettimeofday_bad2
      tools/nolibc: ppoll/ppoll_time64: add a missing argument
      selftests/nolibc: test_fork: fix up duplicated print
      selftests/nolibc: allow specify extra arguments for qemu
      selftests/nolibc: fix up compile warning with glibc on x86_64
      selftests/nolibc: not include limits.h for nolibc
      selftests/nolibc: use INT_MAX instead of __INT_MAX__
      tools/nolibc: arm: add missing my_syscall6
      tools/nolibc: open: fix up compile warning for arm
      selftests/nolibc: support two errnos with EXPECT_SYSER2()
      selftests/nolibc: remove gettimeofday_bad1/2 completely
      selftests/nolibc: add new gettimeofday test cases

 tools/include/nolibc/Makefile                |  19 ++-
 tools/include/nolibc/arch-aarch64.h          |  39 +++--
 tools/include/nolibc/arch-arm.h              |  74 ++++++---
 tools/include/nolibc/arch-i386.h             |  48 +++---
 tools/include/nolibc/arch-loongarch.h        |  49 +++---
 tools/include/nolibc/arch-mips.h             |  64 ++++----
 tools/include/nolibc/arch-riscv.h            |  51 +++---
 tools/include/nolibc/arch-s390.h             |  15 +-
 tools/include/nolibc/arch-x86_64.h           |  42 ++---
 tools/include/nolibc/arch.h                  |   2 +-
 tools/include/nolibc/compiler.h              |  25 +++
 tools/include/nolibc/nolibc.h                |   2 +-
 tools/include/nolibc/stackprotector.h        |  19 +--
 tools/include/nolibc/stdint.h                |  24 ++-
 tools/include/nolibc/stdio.h                 |  95 +++++++----
 tools/include/nolibc/stdlib.h                |  18 +--
 tools/include/nolibc/string.h                |   4 +-
 tools/include/nolibc/sys.h                   | 131 ++++++++++-----
 tools/include/nolibc/types.h                 |  14 +-
 tools/include/nolibc/unistd.h                |  15 ++
 tools/testing/selftests/nolibc/.gitignore    |   1 +
 tools/testing/selftests/nolibc/Makefile      |  35 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 231 ++++++++++++++++++++++-----
 23 files changed, 704 insertions(+), 313 deletions(-)
 create mode 100644 tools/include/nolibc/compiler.h
