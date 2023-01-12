Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3966680D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjALAo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjALAoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:44:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2C6386
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03F1ECE1D34
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF6C433D2;
        Thu, 12 Jan 2023 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673484281;
        bh=Im5QnBI7Bsl711yA3pWPvSGS3B6z+kG8K/q/8v/y+BU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=VDOPOghUv11MWsw0Zu8+9TtrH+Rc+DAISTgDH4YgCOc6TCnvVKS2aswc4RWndb4CP
         tn+JB1N3rv0J6jOmGF7LYfEZIGTCDHxGTo04W1lAGf0bIjia/pSwXqKS8n8NDJnEhH
         WAjnqHdBvSwD70DxZTKFzazfqc40kdYXHsSfeVEfqkuu34UXfHdYFp3s8sVmcIrbtU
         RvKLTCMkeIjXvDk1ZE2azO3olj+R1N7GdIvSsKU+7rteDqUVXtWc+I1eeHU9AjE1oT
         xCLBH3XJn9fmYW2fwSA9JtFUVnOxf2hOQHvspr0OXsnGLSjPV1vvmEHMM4XopjUPXM
         c/g4v0RY4R2TA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C12E95C0687; Wed, 11 Jan 2023 16:44:40 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:44:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        svens@linux.ibm.com, imp@bsdimp.com, w@1wt.eu
Subject: [GIT PULL] nolibc urgent fixes for v6.2
Message-ID: <20230112004440.GA3134351@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-nolibc.2023.01.09a

for you to fetch changes up to 00b18da4089330196906b9fe075c581c17eb726c:

  tools/nolibc: fix the O_* fcntl/open macro definitions for riscv (2023-01-09 09:36:05 -0800)

----------------------------------------------------------------
Fixes for nolibc for v6.2

This series addresses the following bugs:

o	The fd_set structure was incorrectly defined as arrays of u32
	instead of long, which breaks BE64. Fix courtesy of Sven Schnelle.

o	S_ISxxx macros were incorrectly testing the bits after applying
	them instead of bitwise ANDing S_FMT with the value. Fix from
	Warner Losh.

o	The mips code was randomly broken due to an unprotected
	"noreorder" directive in the _start code that could prevent the
	assembler from filling delayed slots.  This in turn resulted
	in random other instructions being placed into those slots.
	Fix courtesy of Willy Tarreau.

o	The current nolibc header layout refrains from including files
	that are not explicitly included by the code using nolibc.
	Unfortunately, this causes build failures when such files
	contain definitions that are used (for example) by libgcc.
	Example definitions include raise() and memset(), which are called
	by some architectures, but only at certain optimization levels.
	Fix courtesy of Willy Tarreau.

o	gcc 11.3 in ARM thumb2 mode at -O2 recognized a memset()
	construction inside the memset() definition.  The compiler
	replaced this construction with a call to... memset().	Userland
	cannot be forced to build with -ffreestanding, so an empty asm()
	statement was introduced into the loop the loop in order to
	prevent the compiler from making this unproductive transformation.
	Fix courtesy of Willy Tarreau.

o	Most of the O_* macros were wrong on RISCV because their
	octal values were coded as hexadecimal.  This resulted in the
	getdents64() selftest failing.	Fix courtesy of Willy Tarreau.

The series was tested on x86_64, i386, armv5, armv7, thumb1, thumb2,
mips and riscv, all at -O0, -Os and -O3.

----------------------------------------------------------------
Sven Schnelle (1):
      nolibc: fix fd_set type

Warner Losh (1):
      tools/nolibc: Fix S_ISxxx macros

Willy Tarreau (4):
      tools/nolibc: restore mips branch ordering in the _start block
      tools/nolibc: fix missing includes causing build issues at -O0
      tools/nolibc: prevent gcc from making memset() loop over itself
      tools/nolibc: fix the O_* fcntl/open macro definitions for riscv

 tools/include/nolibc/arch-mips.h  |  2 ++
 tools/include/nolibc/arch-riscv.h | 14 ++++----
 tools/include/nolibc/ctype.h      |  3 ++
 tools/include/nolibc/errno.h      |  3 ++
 tools/include/nolibc/signal.h     |  3 ++
 tools/include/nolibc/stdio.h      |  3 ++
 tools/include/nolibc/stdlib.h     |  3 ++
 tools/include/nolibc/string.h     |  8 ++++-
 tools/include/nolibc/sys.h        |  2 ++
 tools/include/nolibc/time.h       |  3 ++
 tools/include/nolibc/types.h      | 70 ++++++++++++++++++++++-----------------
 tools/include/nolibc/unistd.h     |  3 ++
 12 files changed, 79 insertions(+), 38 deletions(-)
