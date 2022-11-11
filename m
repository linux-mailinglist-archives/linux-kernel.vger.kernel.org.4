Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92F626536
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKKXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiKKXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:08:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C827DDF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:08:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC62620C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7461C433D7;
        Fri, 11 Nov 2022 23:08:41 +0000 (UTC)
Date:   Fri, 11 Nov 2022 23:08:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.1-rc5
Message-ID: <Y27V9E6qezdKTFQB@arm.com>
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

Please pull the arm64 fixes below. Thanks.

The following changes since commit 85f1506337f0c79a4955edfeee86a18628e3735f:

  arm64: cpufeature: Fix the visibility of compat hwcaps (2022-11-03 18:04:56 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to acfc35cfcee5df419391671ef1a631f43feee4e3:

  arm64/syscall: Include asm/ptrace.h in syscall_wrapper header. (2022-11-09 09:52:25 +0000)

----------------------------------------------------------------
arm64 fixes:

- Another fix for rodata=full. Since rodata= is not a simple boolean on
  arm64 (accepting 'full' as well), it got inadvertently broken by
  changes in the core code. If rodata=on is the default and rodata=off
  is passed on the kernel command line, rodata_full is never disabled.

- Fix gcc compiler warning of shifting 0xc0 into bits 31:24 without an
  explicit conversion to u32 (triggered by the AMPERE1 MIDR definition).

- Include asm/ptrace.h in asm/syscall_wrapper.h to fix an incomplete
  struct pt_regs type causing the BPF verifier to refuse to load a
  tracing program which accesses pt_regs.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: fix rodata=full again

D Scott Phillips (1):
      arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro

Kuniyuki Iwashima (1):
      arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.

 arch/arm64/include/asm/cputype.h         | 2 +-
 arch/arm64/include/asm/syscall_wrapper.h | 2 +-
 arch/arm64/mm/pageattr.c                 | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
Catalin
