Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D30661F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjAIHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjAIHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:03 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D401413D30
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:00 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097snud026014;
        Mon, 9 Jan 2023 08:54:49 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Warner Losh <imp@bsdimp.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 0/6] pending bug fixes for nolibc
Date:   Mon,  9 Jan 2023 08:54:36 +0100
Message-Id: <20230109075442.25963-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

please consider the current patch series for merging into your fixes queue.
The intent is to get them before 6.2, then backported where relevant.

It addresses the following bugs:
  - fd_set was incorrectly defined as arrays of u32 instead of long,
    which breaks BE64. Fix courtesy of Sven Schnelle.

  - S_ISxxx macros were incorrectly testing the bits after applying them
    instead of applying S_ISFMT to the value. Fix from Warner Losh.

  - the mips code was randomly broken due to an unprotected "noreorder"
    directive in the _start code that would prevent the assembler from
    filling delayed slots, and randomly leaving other instructions there

  - since the split of the single include file into multiple files, we're
    implicitly refraining from including some which are not explicitly
    added in the code. It causes build failures when such files contain
    definitions for functions that may be used e.g. by libgcc, such as
    raise() or memset(), which are often called only by a few archs at
    certain optimization levels only.

  - gcc 11.3 in ARM thumb2 mode at -O2 was able to recognize a memset()
    construction inside the memset() definition, and it replaced it with
    a call to... memset(). We cannot impose to userland to build with
    -ffreestanding so the introduction of an empty asm() statement in
    the loop was enough to stop this.

  - most of the O_* macros were wrong on RISCV because their octal value
    was used as a hexadecimal one when the platform was introduced. This
    was revealed by the selftest breaking in getdents64().

The series was tested on x86_64, i386, armv5, armv7, thumb1, thumb2,
mips and riscv, all at -O0, -Os and -O3. This is based on the "nolibc"
branch of your linux-rcu tree. Do not hesitate to let me know if you
prefer that I rebase it on a different one.

Thank you!
Willy

---
Sven Schnelle (1):
  nolibc: fix fd_set type

Warner Losh (1):
  tools/nolibc: Fix S_ISxxx macros

Willy Tarreau (4):
  tools/nolibc: restore mips branch ordering in the _start block
  tools/nolibc: fix missing includes causing build issues at -O0
  tools/nolibc: prevent gcc from making memset() loop over itself
  tools/nolibc: fix the O_* fcntl/open macro definitions for riscv

 tools/include/nolibc/arch-mips.h  |  2 +
 tools/include/nolibc/arch-riscv.h | 14 +++----
 tools/include/nolibc/ctype.h      |  3 ++
 tools/include/nolibc/errno.h      |  3 ++
 tools/include/nolibc/signal.h     |  3 ++
 tools/include/nolibc/stdio.h      |  3 ++
 tools/include/nolibc/stdlib.h     |  3 ++
 tools/include/nolibc/string.h     |  8 +++-
 tools/include/nolibc/sys.h        |  2 +
 tools/include/nolibc/time.h       |  3 ++
 tools/include/nolibc/types.h      | 70 ++++++++++++++++++-------------
 tools/include/nolibc/unistd.h     |  3 ++
 12 files changed, 79 insertions(+), 38 deletions(-)

-- 
2.35.3

