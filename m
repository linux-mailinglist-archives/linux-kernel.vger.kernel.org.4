Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF227052A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjEPPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjEPPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA97EDD;
        Tue, 16 May 2023 08:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F3D63B7C;
        Tue, 16 May 2023 15:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536B2C4339B;
        Tue, 16 May 2023 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251976;
        bh=HVMOSVBRtRWuvJiKuo6QBNcBWtc5UfnuPAacEuJdnH8=;
        h=From:To:Cc:Subject:Date:From;
        b=TXUqyuaWUan4sgxVkh+q9nw6WB4VKvsFJYDbi/5NVFQNyZO2rmxm7u5NqoMACYmiv
         UEHy3KL9h28gXCgfIrVdJ350UaPLjpBsqm4PsvmtT6nCBQncl6Po8e8hz56o/71aeI
         2FkdidLD6DXwvxqL8W/EKuby9Q7ggMuXCMz/ejLCZRP1GO4farriOFQrJX62SoJz55
         oA1puvIJkcEJx+nxz+epdsGLg3xvYPcb2B7sE156jzMRJEqYIuF8tWa8P2xh4tsOns
         6wufUcj0DvYREXR3SdjIf9UTgu5ylkyZ/8gVkI7zoiCM38BIPJj5qJJBXzcE3r+Y0Y
         nlpXP/cESnu4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 00/16] ARM: address -Wmissing-prototype warnings
Date:   Tue, 16 May 2023 17:45:49 +0200
Message-Id: <20230516154605.517690-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

This addresses all arm specific warnings outside of the mach-*/ code,
which I've submitted separately. The majority of the patches should be
straightforward, either adding an #include statement to get the right
header, or ensuring that an unused global function is left out of the
build when the prototype is hidden.

The ones that are a bit awkward are those that just add a prototype to
shut up the warning, but the prototypes are never used for calling the
function because the only caller is in assembler code. I tried to come
up with other ways to shut up the compiler, and ideally this would be
triggered by the 'asmlinkage' keyword as Ard suggested in the past, but
I could not come up with a way to do this.

All of the warnings have to be addressed in some form before the
warning can be enabled by default.

    Arnd

Link: https://people.kernel.org/arnd/missing-prototype-warnings-in-the-kernel

Arnd Bergmann (16):
  ARM: dma-mapping: hide unused dma_contiguous_early_fixup function
  ARM: traps: hide unused functions on NOMMU
  ARM: vfp: include asm/neon.h in vfpmodule.c
  ARM: vdso: add missing prototypes
  ARM: kprobes: avoid missing-declaration warnings
  ARM: tcm: move tcm_init() prototype to asm/tcm.h
  ARM: add prototype for function called only from asm
  ARM: add clear/copy_user_highpage declarations
  ARM: cacheflush: avoid __flush_anon_page() missing-prototype warning
  ARM: nommu: include asm/idmap.h
  ARM: move setup functions to header
  ARM: fiq: include asm/mach/irq.h for prototypes
  ARM: vfp: add vfp_entry prototype
  ARM: add missing syscall prototypes
  ARM: decompressor: move function prototypes to misc.h
  ARM: xip-kernel: add __inflate_kernel_data prototype

 arch/arm/boot/compressed/atags_to_fdt.c       |  1 +
 .../arm/boot/compressed/fdt_check_mem_start.c |  1 +
 arch/arm/boot/compressed/misc.c               |  6 ---
 arch/arm/boot/compressed/misc.h               | 11 ++++
 arch/arm/include/asm/ftrace.h                 |  4 ++
 arch/arm/include/asm/page.h                   | 22 ++++++++
 arch/arm/include/asm/ptrace.h                 |  3 ++
 arch/arm/include/asm/setup.h                  |  7 +++
 arch/arm/include/asm/signal.h                 |  5 ++
 arch/arm/include/asm/spectre.h                |  4 ++
 arch/arm/include/asm/suspend.h                |  1 +
 arch/arm/include/asm/syscalls.h               | 51 +++++++++++++++++++
 arch/arm/include/asm/tcm.h                    | 11 ++--
 arch/arm/include/asm/traps.h                  |  9 ++++
 arch/arm/include/asm/unwind.h                 |  4 ++
 arch/arm/include/asm/vdso.h                   |  5 ++
 arch/arm/include/asm/vfp.h                    |  1 +
 arch/arm/kernel/fiq.c                         |  1 +
 arch/arm/kernel/head-inflate-data.c           |  5 +-
 arch/arm/kernel/head.h                        |  8 +++
 arch/arm/kernel/setup.c                       |  7 ---
 arch/arm/kernel/signal.c                      |  1 +
 arch/arm/kernel/sys_arm.c                     |  1 +
 arch/arm/kernel/sys_oabi-compat.c             |  2 +
 arch/arm/kernel/traps.c                       |  2 +
 arch/arm/mm/dma-mapping.c                     |  2 +
 arch/arm/mm/fault.h                           |  4 ++
 arch/arm/mm/flush.c                           |  1 +
 arch/arm/mm/mmu.c                             |  2 +-
 arch/arm/mm/nommu.c                           |  1 +
 arch/arm/mm/tcm.h                             | 17 -------
 arch/arm/probes/kprobes/checkers-common.c     |  2 +-
 arch/arm/probes/kprobes/core.c                |  2 +-
 arch/arm/probes/kprobes/opt-arm.c             |  2 -
 arch/arm/probes/kprobes/test-core.c           |  2 +-
 arch/arm/probes/kprobes/test-core.h           |  4 ++
 arch/arm/vdso/vgettimeofday.c                 |  2 +
 arch/arm/vfp/vfp.h                            |  3 ++
 arch/arm/vfp/vfpmodule.c                      |  1 +
 39 files changed, 175 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/include/asm/syscalls.h
 create mode 100644 arch/arm/kernel/head.h
 delete mode 100644 arch/arm/mm/tcm.h

To: Russell King <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org


-- 
2.39.2

