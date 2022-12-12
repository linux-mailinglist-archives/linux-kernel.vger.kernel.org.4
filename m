Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B594064975C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 01:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiLLAYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 19:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiLLAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:24:48 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89C8BC31
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 16:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OI5HLslC+z3DmW3rc/yULXtISTSqb9054+WIvaHHec4=; b=dY9BFoXW4Pr+WglDSg1lK/tuak
        eoBePhJZ4vcqpSbhtKPF028689dnz261V9bWmB6sC68JOEr3uTgQovsPMAwVxP0e05xeBxzQBzKYf
        Dp6G5fqBZY2Rk/1EiKLj2/bV0amC1Lc4X45bMo9TeKuWFXsOca5ukyrDQFjIsq5FHX6Pfinqkcfez
        pnGdYGhTGBk2X7KdFR5wGDQ26h8QxmnBOfjl3P6gptXua/4MxpUaNiKKlzOtg3hGyQElqu2A1vcE3
        GkhyCFVWJ2aadgWWQlSxdwAoQMZiOieBpY3BJdMP5aw9Pu43okl7DWhrw4WUlcAORdodnCl2H1B7+
        tECSLcyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Wce-00B7yj-1u;
        Mon, 12 Dec 2022 00:24:44 +0000
Date:   Mon, 12 Dec 2022 00:24:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git elfcore pile
Message-ID: <Y5Z0zPBjWtXTWxLF@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-elfcore

for you to fetch changes up to 38ba2f11d9ce0e7c9444e57cb1bb418d1979534b:

  [elf] get rid of get_note_info_size() (2022-11-24 23:26:04 -0500)

Trivial conflicts with Kees' binfmt_elf branch; some of the whitespace
changes in his branch are in the code eliminated in this one.

----------------------------------------------------------------
Unification of regset and non-regset sides of ELF coredump
handling.  Collecting per-thread register values is the
only thing that needs to be ifdefed there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (10):
      kill signal_pt_regs()
      kill coredump_params->regs
      kill extern of vsyscall32_sysctl
      [elf][regset] clean fill_note_info() a bit
      [elf][regset] simplify thread list handling in fill_note_info()
      elf_core_copy_task_regs(): task_pt_regs is defined everywhere
      [elf][non-regset] uninline elf_core_copy_task_fpregs() (and lose pt_regs argument)
      [elf][non-regset] use elf_core_copy_task_regs() for dumper as well
      [elf] unify regset and non-regset cases
      [elf] get rid of get_note_info_size()

 arch/alpha/include/asm/elf.h     |   6 -
 arch/alpha/include/asm/ptrace.h  |   1 -
 arch/alpha/kernel/process.c      |   8 +-
 arch/csky/kernel/process.c       |   4 +-
 arch/m68k/kernel/process.c       |   4 +-
 arch/microblaze/kernel/process.c |   2 +-
 arch/um/kernel/process.c         |   3 +-
 arch/x86/include/asm/elf.h       |   1 -
 arch/x86/um/asm/elf.h            |   4 -
 fs/binfmt_elf.c                  | 271 ++++++++-------------------------------
 fs/coredump.c                    |   1 -
 include/linux/coredump.h         |   1 -
 include/linux/elfcore.h          |  13 +-
 include/linux/ptrace.h           |   9 --
 kernel/signal.c                  |   2 +-
 15 files changed, 64 insertions(+), 266 deletions(-)
