Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8865C6F0D07
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbjD0UWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjD0UWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:22:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A8420C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:22:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-956ff2399b1so1620196866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682626949; x=1685218949;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPyR0xIVA8OdGXcaerWpqCF8XEnfTCA7vC63hw/kejw=;
        b=pxy1wzngXNyRcqb+crD8aZ+feOHcCtbVuPB30YhnW/vLUVzQ/WSlUo27TAqLXVFUGe
         q47+WqzsicTs71LhPGLNf2+8hgnqSEcdHYSipkOVzKJPpuuhDYD2nhy33b7K76DrerVT
         3LAPOYdt0ql4xSBhDS5eWUgyM37a+Gc5c4O8KEJoSbLQ6UDYq0TSN3XvkpmQncb+44n5
         WdzRdY2kzSy4CPR9hVOJNaphvkdsdqsNl5xygn7qlPMHvtvejtV3IIF8NPeVtch2uK83
         9mBNPsISKJgvtxFLZps6yNBQPUhFaUNxQbhgx4s8VEQH35Y8ZN6FRRvewjmhqr3/4NMk
         x/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626949; x=1685218949;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPyR0xIVA8OdGXcaerWpqCF8XEnfTCA7vC63hw/kejw=;
        b=B/UUpmdSdJBtM58Y9//5wrk/AoZlum7XS42ASWLtOCoYXcNjmQyVb38G+28Gup0+NR
         YKL9oJ/9APaqU++kfUm+hF7Am8WlvE6aI5VL8tbeIFtfePvG3OfwebelEAgpGPRKRzPJ
         2fn3ZH9EgSct4x9yDrpg1G79TbPw5kJRuQqptJvI80rMsG6ubLBWEJPINlq06B1tqKqe
         51R6iaGLsFkpUBPKwWttX1D792A8Z3HW56ukvtwqYCeegk8bklwS1HS7lc6Xa7Rgj6za
         7IMZDdRkhEoJOw4C1OG2tO4ROwz7PpuyKwLUKJ7eiVWzV1s6Jux+5b/1d4FGXCnOgwHj
         X3TA==
X-Gm-Message-State: AC+VfDxwG2w+//gPpCDG0yPUjsOr27GI64GpoccPUx8juvWcWZN/8LfR
        zZ78vgiALsbuDhOo52+EjgY=
X-Google-Smtp-Source: ACHHUZ5dnG7v1PX4VJpZ8zPjU2lASmD06B/qHhKgFMZrxD+xDWNy6f+3elmkXUrOW7rkpJz7I9r5mw==
X-Received: by 2002:a17:907:26c3:b0:958:720:49bc with SMTP id bp3-20020a17090726c300b00958072049bcmr3455983ejc.10.1682626949034;
        Thu, 27 Apr 2023 13:22:29 -0700 (PDT)
Received: from gmail.com ([31.46.243.138])
        by smtp.gmail.com with ESMTPSA id wu9-20020a170906eec900b0095847b8d46esm7391315ejb.65.2023.04.27.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:22:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 27 Apr 2023 22:22:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v6.3
Message-ID: <ZErZgObZuVWSgxYY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-04-27

   # HEAD: 611d4c716db0141cfc436994dc5aff1d69c924ad x86/hyperv: Mark hv_ghcb_terminate() as noreturn

Objtool changes for v6.4:

 - Mark arch_cpu_idle_dead() __noreturn, make all architectures & drivers that did
   this inconsistently follow this new, common convention, and fix all the fallout
   that objtool can now detect statically.

 - Fix/improve the ORC unwinder becoming unreliable due to UNWIND_HINT_EMPTY ambiguity,
   split it into UNWIND_HINT_END_OF_STACK and UNWIND_HINT_UNDEFINED to resolve it.

 - Fix noinstr violations in the KCSAN code and the lkdtm/stackleak code.

 - Generate ORC data for __pfx code

 - Add more __noreturn annotations to various kernel startup/shutdown/panic functions.

 - Misc improvements & fixes.

MERGE NOTES:

With your latest tree there's 3 new conflicts if this tree is pulled:

  arch/x86/include/asm/mshyperv.h
  arch/x86/kernel/head_64.S
  tools/objtool/check.c

For any double-checking there are -tip internal merge resolutions at:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge

 Thanks,

	Ingo

------------------>
Guilherme G. Piccoli (1):
      x86/hyperv: Mark hv_ghcb_terminate() as noreturn

Josh Poimboeuf (50):
      alpha/cpu: Expose arch_cpu_idle_dead()'s prototype declaration
      alpha/cpu: Make sure arch_cpu_idle_dead() doesn't return
      arm/cpu: Add unreachable() to arch_cpu_idle_dead()
      arm64/cpu: Mark cpu_die() __noreturn
      csky/cpu: Make sure arch_cpu_idle_dead() doesn't return
      ia64/cpu: Mark play_dead() __noreturn
      loongarch/cpu: Make sure play_dead() doesn't return
      loongarch/cpu: Mark play_dead() __noreturn
      mips/cpu: Expose play_dead()'s prototype definition
      mips/cpu: Make sure play_dead() doesn't return
      mips/cpu: Mark play_dead() __noreturn
      powerpc/cpu: Mark start_secondary_resume() __noreturn
      sh/cpu: Make sure play_dead() doesn't return
      sh/cpu: Mark play_dead() __noreturn
      sh/cpu: Expose arch_cpu_idle_dead()'s prototype definition
      sparc/cpu: Mark cpu_play_dead() __noreturn
      x86/cpu: Make sure play_dead() doesn't return
      x86/cpu: Mark play_dead() __noreturn
      xtensa/cpu: Make sure cpu_die() doesn't return
      xtensa/cpu: Mark cpu_die() __noreturn
      sched/idle: Make sure weak version of arch_cpu_idle_dead() doesn't return
      sched/idle: Mark arch_cpu_idle_dead() __noreturn
      objtool: Add objtool_types.h
      objtool: Use relative pointers for annotations
      objtool: Change UNWIND_HINT() argument order
      x86,objtool: Introduce ORC_TYPE_*
      x86,objtool: Separate unret validation from unwind hints
      x86,objtool: Split UNWIND_HINT_EMPTY in two
      sched: Fix KCSAN noinstr violation
      lkdtm/stackleak: Fix noinstr violation
      Revert "objtool: Support addition to set CFA base"
      objtool: Add stackleak instrumentation to uaccess safe list
      context_tracking: Fix KCSAN noinstr violation
      scripts/objdump-func: Support multiple functions
      objtool: Add WARN_INSN()
      objtool: Add symbol iteration helpers
      objtool: Remove superfluous dead_end_function() check
      objtool: Separate prefix code from stack validation code
      x86/linkage: Fix padding for typed functions
      objtool: Generate ORC data for __pfx code
      init: Mark [arch_call_]rest_init() __noreturn
      init: Mark start_kernel() __noreturn
      x86/head: Mark *_start_kernel() __noreturn
      arm64/cpu: Mark cpu_park_loop() and friends __noreturn
      cpu: Mark panic_smp_self_stop() __noreturn
      cpu: Mark nmi_panic_self_stop() __noreturn
      objtool: Include weak functions in global_noreturns check
      btrfs: Mark btrfs_assertfail() __noreturn
      x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
      scsi: message: fusion: Mark mpt_halt_firmware() __noreturn

Philippe Mathieu-Daudé (1):
      x86/cpu: Expose arch_cpu_idle_dead()'s prototype definition


 Documentation/livepatch/reliable-stacktrace.rst |   2 +-
 MAINTAINERS                                     |   2 +-
 arch/alpha/kernel/process.c                     |   4 +-
 arch/arm/kernel/smp.c                           |   6 +-
 arch/arm64/include/asm/exception.h              |   4 +-
 arch/arm64/include/asm/smp.h                    |   9 +-
 arch/arm64/kernel/entry-common.c                |   2 +-
 arch/arm64/kernel/process.c                     |   2 +-
 arch/arm64/kernel/smp.c                         |  12 +-
 arch/arm64/kernel/traps.c                       |   3 +-
 arch/csky/kernel/smp.c                          |   4 +-
 arch/ia64/kernel/process.c                      |   6 +-
 arch/loongarch/include/asm/smp.h                |   2 +-
 arch/loongarch/kernel/process.c                 |   2 +-
 arch/loongarch/kernel/smp.c                     |   2 +-
 arch/mips/cavium-octeon/smp.c                   |   1 +
 arch/mips/include/asm/smp.h                     |   2 +-
 arch/mips/kernel/process.c                      |   2 +-
 arch/mips/kernel/smp-bmips.c                    |   4 +
 arch/mips/kernel/smp-cps.c                      |   1 +
 arch/mips/loongson64/smp.c                      |   2 +
 arch/parisc/kernel/process.c                    |   2 +-
 arch/powerpc/include/asm/smp.h                  |   2 +-
 arch/powerpc/kernel/setup_64.c                  |   2 +-
 arch/powerpc/kernel/smp.c                       |   2 +-
 arch/riscv/kernel/cpu-hotplug.c                 |   2 +-
 arch/s390/kernel/idle.c                         |   2 +-
 arch/s390/kernel/setup.c                        |   2 +-
 arch/sh/include/asm/smp-ops.h                   |   5 +-
 arch/sh/kernel/idle.c                           |   3 +-
 arch/sparc/include/asm/smp_64.h                 |   2 +-
 arch/sparc/kernel/process_64.c                  |   2 +-
 arch/x86/entry/entry_64.S                       |  26 +-
 arch/x86/hyperv/ivm.c                           |   2 +-
 arch/x86/include/asm/linkage.h                  |   2 +-
 arch/x86/include/asm/mshyperv.h                 |   2 +-
 arch/x86/include/asm/nospec-branch.h            |  14 +-
 arch/x86/include/asm/orc_types.h                |  12 +-
 arch/x86/include/asm/reboot.h                   |   1 -
 arch/x86/include/asm/setup.h                    |   6 +-
 arch/x86/include/asm/smp.h                      |   5 +-
 arch/x86/include/asm/unwind_hints.h             |  18 +-
 arch/x86/kernel/ftrace_64.S                     |   2 +-
 arch/x86/kernel/head32.c                        |   2 +-
 arch/x86/kernel/head64.c                        |   4 +-
 arch/x86/kernel/head_64.S                       |  17 +-
 arch/x86/kernel/process.c                       |   5 +-
 arch/x86/kernel/reboot.c                        |   2 +-
 arch/x86/kernel/relocate_kernel_64.S            |  10 +-
 arch/x86/kernel/smpboot.c                       |   2 +-
 arch/x86/kernel/unwind_orc.c                    |  27 +-
 arch/x86/lib/retpoline.S                        |   6 +-
 arch/x86/platform/pvh/head.S                    |   2 +-
 arch/x86/power/cpu.c                            |   2 +-
 arch/x86/xen/xen-asm.S                          |   4 +-
 arch/x86/xen/xen-head.S                         |   4 +-
 arch/xtensa/include/asm/smp.h                   |   2 +-
 arch/xtensa/kernel/smp.c                        |   4 +-
 drivers/message/fusion/mptbase.c                |   2 +-
 drivers/message/fusion/mptbase.h                |   2 +-
 drivers/misc/lkdtm/stackleak.c                  |   6 +
 fs/btrfs/messages.c                             |   2 +-
 fs/btrfs/messages.h                             |   2 +-
 include/linux/context_tracking.h                |   2 +-
 include/linux/cpu.h                             |   2 +-
 include/linux/objtool.h                         |  81 ++--
 include/linux/objtool_types.h                   |  57 +++
 include/linux/sched/task_stack.h                |   2 +-
 include/linux/smp.h                             |   4 +-
 include/linux/start_kernel.h                    |   6 +-
 init/main.c                                     |   6 +-
 kernel/panic.c                                  |   4 +-
 kernel/sched/idle.c                             |   2 +-
 scripts/objdump-func                            |  34 +-
 scripts/sorttable.h                             |   2 +-
 tools/arch/x86/include/asm/orc_types.h          |  12 +-
 tools/include/linux/objtool.h                   | 200 ----------
 tools/include/linux/objtool_types.h             |  57 +++
 tools/objtool/check.c                           | 477 ++++++++++++------------
 tools/objtool/elf.c                             |   2 +-
 tools/objtool/include/objtool/check.h           |   4 +-
 tools/objtool/include/objtool/elf.h             |   9 +
 tools/objtool/include/objtool/warn.h            |   5 +
 tools/objtool/orc_dump.c                        |  15 +-
 tools/objtool/orc_gen.c                         |  48 ++-
 tools/objtool/sync-check.sh                     |   2 +-
 86 files changed, 644 insertions(+), 686 deletions(-)
 create mode 100644 include/linux/objtool_types.h
 delete mode 100644 tools/include/linux/objtool.h
 create mode 100644 tools/include/linux/objtool_types.h
