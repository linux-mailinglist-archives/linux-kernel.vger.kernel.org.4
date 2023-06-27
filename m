Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E086673FAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjF0LVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0LVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:21:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52019BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:21:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbaa534dd4so898045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864860; x=1690456860;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PxQRpedS9dcTVAO6DNaUElspPgFCnO7G8bZjL8ZqDhA=;
        b=g1VQ/rjuy+1KBX9ErWWbPvXO6vfqNzeK9uAT7ufOR3dUAVfeui6bUCsvRhTHnrFmQ5
         iKs2sXkG9+u9bv7HMxljozKdvm8yIUH/LsCA0+VBOatdz+XQhnlxjWiHbRPpUIPVHE5L
         S6+GzHdIenq321f3lDeh0t5DBbv+Xp2EWA/a0GaYBL841fV5lX6XDFZiUeVM+bNksdC8
         o6kvxYQPA7vLXxU8MdcbBxOpC82MfT7gvrult9WGjgY8gtYsf8rMM0poM7Z9+LaCgL8A
         6t2zoVaTK/qdUqbuA4DnXopZw9w2ocoXaU7UJbSPyfBqCudqTDdWuLkwSb0a68dm+2m/
         fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864860; x=1690456860;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxQRpedS9dcTVAO6DNaUElspPgFCnO7G8bZjL8ZqDhA=;
        b=N8pPJzi0bZpRm2tH0cr3PS6EFUpwO9Z+0q3F3PrbuyQMv/u28MgR25pSq286wyW6ok
         yVO2LWrwh4HE0sl7C7xMP6N1B0UVNYADETNLD5gbfG/xdKnmjfVmH+sh0qrLJYwTLst0
         kC2JNb5LkbodD2aV3ZZIbniSelTasOjfEshPPCz3OgCKznD3b8eV54qVPeFJmqshQjJl
         uIrDn74Lo4QUHymnu/eiswOnHoMEWmJ5Nhzc0C7HI9cM3pqS5fTtIou62DX78QdQddUY
         G3kLKx6WNPI5fzsTBJYojkuD72j5ZT8rCeuxrvjhbKXzbUkh6Z7UF/7r7G912FcRBw2G
         7/YQ==
X-Gm-Message-State: AC+VfDxlIJG0O5bHMuVjzegZYVrEH+aoLXKJr4iY1WEORMjTJM7Jg4XT
        V2Y3RXbFrPsudXB2ur/Z7qo=
X-Google-Smtp-Source: ACHHUZ482uMcyDeNAkgliYOKmJXI5f69+6B+WZDXNA3Sd+GX6qYrLSwObmEwK2/w6hdo5k8Yxa6ViQ==
X-Received: by 2002:a5d:4acf:0:b0:313:ecee:5517 with SMTP id y15-20020a5d4acf000000b00313ecee5517mr8887258wrs.40.1687864860357;
        Tue, 27 Jun 2023 04:21:00 -0700 (PDT)
Received: from gmail.com (1F2EF7E2.nat.pool.telekom.hu. [31.46.247.226])
        by smtp.gmail.com with ESMTPSA id cs5-20020a056000088500b0030ab5ebefa8sm10174330wrb.46.2023.06.27.04.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:20:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 13:20:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.5
Message-ID: <ZJrGGfFl4MHEeftI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-06-27

   # HEAD: 301cf77e21317b3465c5e2bb0188df24bbf1c2e2 x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=y

objtool changes for v6.5:

- Build footprint & performance improvements:

    - Reduce memory usage with CONFIG_DEBUG_INFO=y

      In the worst case of an allyesconfig+CONFIG_DEBUG_INFO=y kernel, DWARF
      creates almost 200 million relocations, ballooning objtool's peak heap
      usage to 53GB.  These patches reduce that to 25GB.

      On a distro-type kernel with kernel IBT enabled, they reduce objtool's
      peak heap usage from 4.2GB to 2.8GB.

      These changes also improve the runtime significantly.

- Debuggability improvements:

    - Add the unwind_debug command-line option, for more extend unwinding
      debugging output.
    - Limit unreachable warnings to once per function
    - Add verbose option for disassembling affected functions
    - Include backtrace in verbose mode
    - Detect missing __noreturn annotations
    - Ignore exc_double_fault() __noreturn warnings
    - Remove superfluous global_noreturns entries
    - Move noreturn function list to separate file
    - Add __kunit_abort() to noreturns

- Unwinder improvements:

    - Allow stack operations in UNWIND_HINT_UNDEFINED regions
    - drm/vmwgfx: Add unwind hints around RBP clobber

- Cleanups:

    - Move the x86 entry thunk restore code into thunk functions
    - x86/unwind/orc: Use swap() instead of open coding it
    - Remove unnecessary/unused variables

- Fixes for modern stack canary handling

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=y

Jiapeng Chong (1):
      x86/unwind/orc: Use swap() instead of open coding it

Josh Poimboeuf (36):
      x86/unwind/orc: Add 'unwind_debug' cmdline option
      objtool: Limit unreachable warnings to once per function
      objtool: Add verbose option for disassembling affected functions
      objtool: Include backtrace in verbose mode
      objtool: Detect missing __noreturn annotations
      objtool: Ignore exc_double_fault() __noreturn warnings
      objtool: Remove superfluous global_noreturns entries
      tools/lib/subcmd: Replace NORETURN usage with __noreturn
      objtool: Move noreturn function list to separate file
      objtool: Add __kunit_abort() to noreturns
      Revert "x86/orc: Make it callthunk aware"
      x86/entry: Move thunk restore code into thunk functions
      objtool: Allow stack operations in UNWIND_HINT_UNDEFINED regions
      drm/vmwgfx: Add unwind hints around RBP clobber
      objtool: Tidy elf.h
      objtool: Remove flags argument from elf_create_section()
      objtool: Improve reloc naming
      objtool: Consolidate rel/rela handling
      objtool: Fix reloc_hash size
      objtool: Add mark_sec_changed()
      objtool: Add elf_create_section_pair()
      objtool: Keep GElf_Rel[a] structs synced
      objtool: Don't free memory in elf_close()
      objtool: Add for_each_reloc()
      objtool: Allocate relocs in advance for new rela sections
      objtool: Get rid of reloc->list
      objtool: Get rid of reloc->idx
      objtool: Get rid of reloc->offset
      objtool: Get rid of reloc->type
      objtool: Get rid of reloc->addend
      objtool: Get rid of reloc->jump_table_start
      objtool: Shrink reloc->sym_reloc_entry
      objtool: Shrink elf hash nodes
      objtool: Get rid of reloc->rel[a]
      objtool: Free insns when done
      objtool: Skip reading DWARF section data

Lu Hongfei (1):
      tools: Remove unnecessary variables

Peter Zijlstra (1):
      lkdtm: Avoid objtool/ibt warning

ndesaulniers@google.com (2):
      start_kernel: Add __no_stack_protector function attribute
      start_kernel: Omit prevent_tail_call_optimization() for newer toolchains


 Documentation/admin-guide/kernel-parameters.txt |   6 +
 arch/powerpc/kernel/smp.c                       |   1 +
 arch/x86/entry/thunk_64.S                       |  20 +-
 arch/x86/include/asm/alternative.h              |   5 -
 arch/x86/include/asm/unwind_hints.h             |   9 +
 arch/x86/kernel/callthunks.c                    |   4 +-
 arch/x86/kernel/unwind_orc.c                    |  75 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h         |  16 +-
 drivers/misc/lkdtm/bugs.c                       |   1 +
 include/linux/compiler_attributes.h             |  12 +
 init/main.c                                     |   9 +-
 tools/lib/subcmd/parse-options.h                |   8 +-
 tools/lib/subcmd/subcmd-util.h                  |   5 +-
 tools/objtool/Documentation/objtool.txt         |  10 +
 tools/objtool/arch/powerpc/include/arch/elf.h   |  11 +-
 tools/objtool/arch/x86/decode.c                 |   6 +-
 tools/objtool/arch/x86/include/arch/elf.h       |  11 +-
 tools/objtool/arch/x86/special.c                |   6 +-
 tools/objtool/builtin-check.c                   |   5 +
 tools/objtool/check.c                           | 643 ++++++++++++++----------
 tools/objtool/elf.c                             | 537 ++++++++------------
 tools/objtool/include/objtool/builtin.h         |   1 +
 tools/objtool/include/objtool/cfi.h             |   1 +
 tools/objtool/include/objtool/elf.h             | 327 ++++++++----
 tools/objtool/include/objtool/warn.h            |  21 +-
 tools/objtool/noreturns.h                       |  46 ++
 tools/objtool/orc_gen.c                         |   8 +-
 tools/objtool/special.c                         |   4 +-
 28 files changed, 1038 insertions(+), 770 deletions(-)
 create mode 100644 tools/objtool/noreturns.h
