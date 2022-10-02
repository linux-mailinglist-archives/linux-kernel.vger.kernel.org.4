Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60B5F2129
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 05:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJBDXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 23:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 23:23:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E0357D6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 20:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B74D5B8058E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 03:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A187C433D7;
        Sun,  2 Oct 2022 03:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664681023;
        bh=VS59tYiGsQdCHNiHo5eCbkTLASyrdfm1yTtawTD1Y5Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YL/UnOrP+6yhbbYz9adtV4vgFc4K3XwFE0PGNFjqDZPwfuhtdC14E0AMHemZTtCuI
         VG9SyXEAFOsvwhpMqpBYr974GmcAHNIDsZ1GwsjcgtNXR4htjfQfM3ScPN9LQMVeVc
         7Ht9nKnLLWkbNxm5U13dTUAOR2f3J13av5jSkLNakDorncoTw0FrFB1k+GXZ6BCtEI
         v8OyOhKAScPHRMCqdwKAt0K5nlKY8kKL6uFBr37aj78B1/NFb6IyBpBcNS7R17JCUJ
         WA6sPMB+J3CbNjVYE5yYq9EaDTRYb6slTqeBlsN2V/ipdInEoLFOItoQ9hirNI08J9
         qr06iF8tlx3Ow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E7ADD5C05B1; Sat,  1 Oct 2022 20:23:42 -0700 (PDT)
Date:   Sat, 1 Oct 2022 20:23:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, w@1wt.eu
Subject: [GIT PULL] nolibc changes for v6.1
Message-ID: <20221002032342.GA3512899@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.09.30a
  HEAD: 43cf168fa99992ee70ff041a61f866f56aa47f3b: selftests/nolibc: Avoid generated files being committed (2022-08-31 05:17:45 -0700)

----------------------------------------------------------------
nolibc pull request for v6.1

This pull request provides nolibc updates, most notably greatly improved
testing.  These tests are located in tools/testing/selftests/nolibc.  The
output of "make help" is as follows:

	Supported targets under selftests/nolibc:
	  all          call the "run" target below
	  help         this help
	  sysroot      create the nolibc sysroot here (uses $ARCH)
	  nolibc-test  build the executable (uses $CC and $CROSS_COMPILE)
	  initramfs    prepare the initramfs with nolibc-test
	  defconfig    create a fresh new default config (uses $ARCH)
	  kernel       (re)build the kernel with the initramfs (uses $ARCH)
	  run          runs the kernel in QEMU after building it (uses $ARCH, $TEST)
	  rerun        runs a previously prebuilt kernel in QEMU (uses $ARCH, $TEST)
	  clean        clean the sysroot, initramfs, build and output files

	The output file is "run.out". Test ranges may be passed using $TEST.

	Currently using the following variables:
	  ARCH          = x86
	  CROSS_COMPILE =
	  CC            = gcc
	  OUTPUT        = /home/git/linux-rcu/tools/testing/selftests/nolibc/
	  TEST          =
	  QEMU_ARCH     = x86_64 [determined from $ARCH]
	  IMAGE_NAME    = bzImage [determined from $ARCH]

The output of a successful x86 "make run" is currently as follows,
with kernel build output omitted:

	$ make run
	71 test(s) passed.
	$

----------------------------------------------------------------
Fernanda Ma'rouf (1):
      selftests/nolibc: Avoid generated files being committed

Willy Tarreau (17):
      tools/nolibc: make argc 32-bit in riscv startup code
      tools/nolibc: fix build warning in sys_mmap() when my_syscall6 is not defined
      tools/nolibc: make sys_mmap() automatically use the right __NR_mmap definition
      selftests/nolibc: add basic infrastructure to ease creation of nolibc tests
      selftests/nolibc: support a test definition format
      selftests/nolibc: implement a few tests for various syscalls
      selftests/nolibc: add a few tests for some libc functions
      selftests/nolibc: exit with poweroff on success when getpid() == 1
      selftests/nolibc: on x86, support exiting with isa-debug-exit
      selftests/nolibc: recreate and populate /dev and /proc if missing
      selftests/nolibc: condition some tests on /proc existence
      selftests/nolibc: support glibc as well
      selftests/nolibc: add a "kernel" target to build the kernel with the initramfs
      selftests/nolibc: add a "defconfig" target
      selftests/nolibc: add a "run" target to start the kernel in QEMU
      selftests/nolibc: "sysroot" target installs a local copy of the sysroot
      selftests/nolibc: add a "help" target

 MAINTAINERS                                  |   1 +
 tools/include/nolibc/arch-riscv.h            |   2 +-
 tools/include/nolibc/sys.h                   |   4 +-
 tools/testing/selftests/nolibc/.gitignore    |   4 +
 tools/testing/selftests/nolibc/Makefile      | 135 +++++
 tools/testing/selftests/nolibc/nolibc-test.c | 757 +++++++++++++++++++++++++++
 6 files changed, 900 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/nolibc/.gitignore
 create mode 100644 tools/testing/selftests/nolibc/Makefile
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test.c
