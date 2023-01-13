Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EFB66941C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAMK3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjAMK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:29:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C9BCB4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E059D6102A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E572C433D2;
        Fri, 13 Jan 2023 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673605782;
        bh=YDvQoWJ7edXI9gdF4qw6CZaWr1jswR3Pv0hDCq9hXuc=;
        h=Date:From:To:Cc:Subject:From;
        b=KJbHHgYMMetrNfn/P3eGoP9kwRxTrQ3cEhvUTs3UgHDCl4HiVmDMmtYS5UYxNKn2e
         N49h9Y8Mmm6AdAu+4AxRo11ZZTy3tOjVLYQa8hL6hLdqtrtEEzB7ijjKqZh61VHMfX
         tw8UlozW64Ma96DGLGW3bNYy578pCRxdpxi2c3Bwt11WaUTfAgEwJ21vnbN4q4ObpA
         gEimhv8gIuQsH6MBRwegXfMOgPNeZqaX7zAc6XjizXYGgywnX7Khh64PcfuR3Hzxee
         Yiz10Wq0aoKknpRe6p669Hd7oxj4okJgWXO3ue2cz9EbFtiIvzaKLl15hzscXuXABJ
         PgJl9WNcwfqOA==
Date:   Fri, 13 Jan 2023 10:29:37 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20230113102936.GA12734@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a sizeable batch of Friday the 13th arm64 fixes for -rc4.
What could possibly go wrong?

The obvious reason we have so much here is because of the holiday season
right after the merge window, but we've also brought back an erratum
workaround that was previously dropped at the last minute and there's an
MTE coredumping fix that strays outside of the arch/arm64 directory.

Anyway, it's all been in -next, the CI robots seem happy enough and
there's the usual summary in the tag.

Please pull.

Cheers,

Will

--->8

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 68a63a412d18bd2e2577c8928139f92541afa7a6:

  arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y (2023-01-09 15:59:42 +0000)

----------------------------------------------------------------
arm64 fixes for -rc4

- Fix PAGE_TABLE_CHECK failures on hugepage splitting path

- Fix PSCI encoding of MEM_PROTECT_RANGE function in UAPI header

- Fix NULL deref when accessing debugfs node if PSCI is not present

- Fix MTE core dumping when VMA list is being updated concurrently

- Fix SME signal frame handling when SVE is not implemented by the CPU

- Fix asm constraints for cmpxchg_double() to hazard both words

- Fix build failure with stack tracer and older versions of Clang

- Bring back workaround for Cortex-A715 erratum 2645198

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption

Catalin Marinas (3):
      arm64: mte: Fix double-freeing of the temporary tag storage during coredump
      elfcore: Add a cprm parameter to elf_core_extra_{phdrs,data_size}
      arm64: mte: Avoid the racy walk of the vma list during core dump

James Clark (1):
      arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y

Liu Shixin (2):
      arm64/mm: fix incorrect file_map_count for invalid pmd
      arm64/mm: add pud_user_exec() check in pud_user_accessible_page()

Marc Zyngier (1):
      firmware/psci: Don't register with debugfs if PSCI isn't available

Mark Brown (3):
      arm64/sme: Fix context switch for SME only systems
      arm64/signal: Always accept SVE signal frames on SME only systems
      arm64/signal: Always allocate SVE signal frames on SME only systems

Mark Rutland (1):
      arm64: cmpxchg_double*: hazard against entire exchange variable

Will Deacon (2):
      firmware/psci: Fix MEM_PROTECT_RANGE function numbers
      arm64/mm: Define dummy pud_user_exec() when using 2-level page-table

Zenghui Yu (1):
      arm64: ptrace: Use ARM64_SME to guard the SME register enumerations

junhua huang (1):
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 18 ++++++++--
 arch/arm64/include/asm/atomic_ll_sc.h  |  2 +-
 arch/arm64/include/asm/atomic_lse.h    |  2 +-
 arch/arm64/include/asm/hugetlb.h       |  9 +++++
 arch/arm64/include/asm/pgtable.h       | 16 +++++++--
 arch/arm64/include/asm/uprobes.h       |  2 +-
 arch/arm64/kernel/cpu_errata.c         |  7 ++++
 arch/arm64/kernel/elfcore.c            | 61 ++++++++++++++++------------------
 arch/arm64/kernel/fpsimd.c             |  2 +-
 arch/arm64/kernel/ptrace.c             |  2 +-
 arch/arm64/kernel/signal.c             |  9 +++--
 arch/arm64/mm/hugetlbpage.c            | 21 ++++++++++++
 arch/arm64/mm/mmu.c                    | 21 ++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 arch/ia64/kernel/elfcore.c             |  4 +--
 arch/x86/um/elfcore.c                  |  4 +--
 drivers/firmware/psci/psci.c           |  3 ++
 fs/binfmt_elf.c                        |  4 +--
 fs/binfmt_elf_fdpic.c                  |  4 +--
 include/linux/elfcore.h                |  8 ++---
 include/uapi/linux/psci.h              |  4 +--
 22 files changed, 147 insertions(+), 59 deletions(-)
