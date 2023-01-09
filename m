Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F01662073
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjAIInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjAIImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:42:24 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33BF613F35
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:23 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gCE3027419;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 00/22] nolibc: usability improvements (errno, environ, auxv)
Date:   Mon,  9 Jan 2023 09:41:46 +0100
Message-Id: <20230109084208.27355-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

this 3rd series aims at generally improving usability and maintainance
of nolibc. It needs to be applied on top of the s390 series:

  https://lore.kernel.org/lkml/20230109080910.26594-1-w@1wt.eu/

- first, I've encountered remaining problems related to section
  reordering happening at certain optimization levels and that is also
  arch-dependent. We were fortunate they didn't appear in rcutorture,
  but I could reproduce them with ARM in Thumb mode at -O0. The problem
  is that our out-of-block asm() statement changes the current section
  to ".text" without the compiler knowing. Thus the compiler may believe
  it's still in .bss and emit variables immediately after (e.g. errno),
  which end up in the wrong section. Switching the section at the end
  to .bss doesn't work either because at -Os I was seeing sys_brk()
  placed immediately after and crashing as .bss is not executable. The
  only safe solution is to turn _start to real functions. This was
  tested on all archs at -O0,-O1,-O2,-O3,-Os and all of them now work.

- second, thumb mode support was in complete on ARM. Only thumb-2 was
  supported and depending on how the toolchain is configured, passing
  "-mthumb" would result in thumb-1 (if armv4/5 was the default) or
  thumb-2 (when armv7 was the default). I discovered this when first
  trying the toolchains from kernel.org because mine works in v7 by
  default, hence thumb-2. The change only replaces a few instructions
  that are not available in thumb-1 by their compatible equivalent. In
  addition, thumb cannot be used at -O0 or with frame pointers in general
  because register r7 is the frame pointer there, and cannot be assigned
  by the compiler. That's bad because r7 carries the syscall number. Now
  when thumb is detected, we simply use a slightly larger setup code
  which uses r6 and swaps it with r7 when performing the call.

- third, the definitions of the (possibly wrong) arch-specific O_* values
  were dropped in favor of those coming from asm/fcntl.h. Not only these
  ones are correct, but doing so will avoid build redefinition warnings
  should the file be included for whatever other reason.

- the errno, environ and the auxiliary vector were really a pain to
  use. errno was declared as a static variable, showing a different
  one to each build unit. environ had to be declared by the application,
  and the auxv had to be both declared and found by the application if
  needed. All three of them have now been declared as weak symbols,
  and environ and _auxv are setup during startup, so that only one
  instance of them exists across the whole binary, and that code
  currently declaring them continues to work. This now means that code
  not using them will not optimize them away anymore, but let's face
  it, errno was always used and no relevant application manages to get
  rid of .bss, so the amount of extra space is really just 8-16 bytes
  total for a much better simplicity for the user.

- getauxval() and getpagesize() were added by Ammar Faizi (along with
  the associated selftests).

This was tested on arm64/armv5/armv7/thumb1/thumb2/i386/x86_64/mips/riscv
and s390 at all optimization levels. I could also verify that my original
preinit code continues to build and work fine, so please consider queuing
it.

Thank you!
Willy

---

Ammar Faizi (3):
  nolibc/stdlib: Implement `getauxval(3)` function
  nolibc/sys: Implement `getpagesize(2)` function
  selftests/nolibc: Add `getpagesize(2)` selftest

Sven Schnelle (2):
  tools/nolibc: export environ as a weak symbol on s390
  tools/nolibc: add auxiliary vector retrieval for s390

Willy Tarreau (17):
  tools/nolibc: make compiler and assembler agree on the section around
    _start
  tools/nolibc: enable support for thumb1 mode for ARM
  tools/nolibc: support thumb mode with frame pointers on ARM
  tools/nolibc: remove local definitions of O_* flags for open/fcntl
  tools/nolibc: make errno a weak symbol instead of a static one
  tools/nolibc: export environ as a weak symbol on x86_64
  tools/nolibc: export environ as a weak symbol on i386
  tools/nolibc: export environ as a weak symbol on arm64
  tools/nolibc: export environ as a weak symbol on arm
  tools/nolibc: export environ as a weak symbol on mips
  tools/nolibc: export environ as a weak symbol on riscv
  tools/nolibc: add auxiliary vector retrieval for i386
  tools/nolibc: add auxiliary vector retrieval for x86_64
  tools/nolibc: add auxiliary vector retrieval for arm64
  tools/nolibc: add auxiliary vector retrieval for arm
  tools/nolibc: add auxiliary vector retrieval for riscv
  tools/nolibc: add auxiliary vector retrieval for mips

 tools/include/nolibc/arch-aarch64.h          |  52 +++----
 tools/include/nolibc/arch-arm.h              | 138 ++++++++++++-------
 tools/include/nolibc/arch-i386.h             |  60 ++++----
 tools/include/nolibc/arch-mips.h             |  79 ++++++-----
 tools/include/nolibc/arch-riscv.h            |  62 +++++----
 tools/include/nolibc/arch-s390.h             |  70 +++++-----
 tools/include/nolibc/arch-x86_64.h           |  52 +++----
 tools/include/nolibc/errno.h                 |   4 +-
 tools/include/nolibc/stdlib.h                |  27 ++++
 tools/include/nolibc/sys.h                   |  22 +++
 tools/testing/selftests/nolibc/nolibc-test.c |  30 ++++
 11 files changed, 363 insertions(+), 233 deletions(-)

-- 
2.17.5

