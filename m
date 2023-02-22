Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5461D69ECAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBVCHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBVCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:07:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258630E80
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:07:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E20AEB811BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACBFC433EF;
        Wed, 22 Feb 2023 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677031628;
        bh=cXtie0AWW7t2PyZtZ9Da0Puvo5cDm2dpQe9NYtX53zY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=txmdopwrYQQLxVlms7QraSTb/xdV7EqFbwdQ2aT9JGjOoG5pVZkPzIU71RRDk7g2H
         3jNc0QEezK6870+25f67Z0iCPPX1lgVAMUsMsxcFSGkioZZW8adZ16Jwpt+gXeU3OU
         WndqpRdx/F2VCmIAi1vGGWm9G3DxigqHqNPGrSBq1gbzcdQfp1V1fFwWyzXChN12Ob
         VqgX2kG/RwtI/PrGLtQOl/5cdAomt6AP+KvNeksjRooifmxAR7urrInhOlUpT5Wuna
         faKzP5KGWy3gYihOD5qH+2Kph/czoh9uJne7evxDrPdn8X+E6l6/xVOL/+OAZXecFP
         oontUBEQlYhIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3191B5C10B5; Tue, 21 Feb 2023 18:07:08 -0800 (PST)
Date:   Tue, 21 Feb 2023 18:07:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     w@1wt.eu, svens@linux.ibm.com, imp@bsdimp.com,
        ammarfaizi2@gnuweeb.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [GIT PULL] nolibc changes for v6.3
Message-ID: <20230222020708.GA1345661@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.02.06a
  # HEAD: c54ba4178159e440bea3826d22d43a9d0d94b071: selftests/nolibc: Add a "run-user" target to test the program in user land (2023-01-24 15:35:45 -0800)

----------------------------------------------------------------
nolibc updates for v6.3

o	Add s390 support.

o	Add support for the ARM Thumb1 instruction set.

o	Fix O_* flags definitions for open() and fcntl().

o	Make errno a weak symbol instead of a static variable.

o	Export environ as a weak symbol.

o	Export _auxv as a weak symbol for auxilliary vector retrieval.

o	Implement getauxval() and getpagesize().

o	Further improve self tests, including permitting userland testing
	of the nolibc library.

----------------------------------------------------------------
Ammar Faizi (3):
      nolibc/stdlib: Implement `getauxval(3)` function
      nolibc/sys: Implement `getpagesize(2)` function
      selftests/nolibc: Add `getpagesize(2)` selftest

Sven Schnelle (7):
      nolibc: fix fd_set type
      nolibc: add support for s390
      selftests/nolibc: add s390 support
      rcutorture: add support for s390
      rcutorture: build initrd for rcutorture with nolibc
      tools/nolibc: export environ as a weak symbol on s390
      tools/nolibc: add auxiliary vector retrieval for s390

Warner Losh (1):
      tools/nolibc: Fix S_ISxxx macros

Willy Tarreau (23):
      tools/nolibc: restore mips branch ordering in the _start block
      tools/nolibc: fix missing includes causing build issues at -O0
      tools/nolibc: prevent gcc from making memset() loop over itself
      tools/nolibc: fix the O_* fcntl/open macro definitions for riscv
      tools/nolibc: make compiler and assembler agree on the section around _start
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
      selftests/nolibc: Support "x86_64" for arch name
      selftests/nolibc: Add a "run-user" target to test the program in user land

 tools/include/nolibc/arch-aarch64.h                |  52 ++---
 tools/include/nolibc/arch-arm.h                    | 138 ++++++++-----
 tools/include/nolibc/arch-i386.h                   |  60 +++---
 tools/include/nolibc/arch-mips.h                   |  77 +++----
 tools/include/nolibc/arch-riscv.h                  |  62 +++---
 tools/include/nolibc/arch-s390.h                   | 226 +++++++++++++++++++++
 tools/include/nolibc/arch-x86_64.h                 |  52 ++---
 tools/include/nolibc/arch.h                        |   2 +
 tools/include/nolibc/ctype.h                       |   3 +
 tools/include/nolibc/errno.h                       |   7 +-
 tools/include/nolibc/signal.h                      |   3 +
 tools/include/nolibc/stdio.h                       |   3 +
 tools/include/nolibc/stdlib.h                      |  30 +++
 tools/include/nolibc/string.h                      |   8 +-
 tools/include/nolibc/sys.h                         |  26 +++
 tools/include/nolibc/time.h                        |   3 +
 tools/include/nolibc/types.h                       |  70 ++++---
 tools/include/nolibc/unistd.h                      |   3 +
 tools/testing/selftests/nolibc/Makefile            |  17 +-
 tools/testing/selftests/nolibc/nolibc-test.c       |  30 +++
 .../testing/selftests/rcutorture/bin/functions.sh  |   6 +
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |   2 +-
 22 files changed, 649 insertions(+), 231 deletions(-)
 create mode 100644 tools/include/nolibc/arch-s390.h
