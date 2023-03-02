Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D76A8C28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCBWr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCBWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:47:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BD524D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:47:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1A2D615FE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CE4C433D2;
        Thu,  2 Mar 2023 22:47:53 +0000 (UTC)
Date:   Thu, 2 Mar 2023 22:47:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.3-rc1
Message-ID: <ZAEnlmDoISrqfWOU@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please pull the changes below? There are a few arm64 fixes
that turned up during the merging window or just before it opened. They
are based on top of the arm64-upstream tag I sent last week. There is a
near conflict in arch/arm64/Kconfig but it seems that git is smart
enough to figure it out. Thanks.

The following changes since commit d54170812ef1c80e0fa3ed3e554a0bbfc2920d9d:

  arm64: fix .idmap.text assertion for large kernels (2023-02-20 18:23:35 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 010338d729c1090036eb40d2a60b7b7bce2445b8:

  arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN (2023-02-28 11:21:04 +0000)

----------------------------------------------------------------
arm64 fixes:

- In copy_highpage(), only reset the tag of the destination pointer if
  KASAN_HW_TAGS is enabled so that user-space MTE does not interfere
  with KASAN_SW_TAGS (which relies on top-byte-ignore).

- Remove warning if SME is detected without SVE, the kernel can cope
  with such configuration (though none in the field currently).

- In cfi_handler(), pass the ESR_EL1 value to die() for consistency with
  other die() callers.

- Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP on arm64 since the pte
  manipulation from the generic vmemmap_remap_pte() does not follow the
  required ARM break-before-make sequence (clear the pte, flush the
  TLBs, set the new pte). It may be re-enabled once this sequence is
  sorted.

- Fix possible memory leak in the arm64 ACPI code if the SMCCC version
  and conduit checks fail.

- Forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE since gcc ignores
  -falign-functions=N with -Os.

- Don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN as no
  randomisation would actually take place.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN

Catalin Marinas (1):
      arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP

Mark Brown (1):
      arm64/fpsimd: Remove warning for SME without SVE

Mark Rutland (1):
      arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE

Peter Collingbourne (1):
      arm64: Reset KASAN tag in copy_highpage with HW tags only

Sangmoon Kim (1):
      arm64: pass ESR_ELx to die() of cfi_handler

Sudeep Holla (1):
      arm64: acpi: Fix possible memory leak of ffh_ctxt

 arch/arm64/Kconfig              |  4 ++--
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 arch/arm64/kernel/acpi.c        |  8 ++++----
 arch/arm64/kernel/cpufeature.c  |  2 +-
 arch/arm64/kernel/fpsimd.c      |  3 ---
 arch/arm64/kernel/kaslr.c       |  2 +-
 arch/arm64/kernel/traps.c       |  2 +-
 arch/arm64/mm/copypage.c        |  3 ++-
 8 files changed, 22 insertions(+), 13 deletions(-)

-- 
Catalin
