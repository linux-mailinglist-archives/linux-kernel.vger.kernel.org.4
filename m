Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E711693D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBMEyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC8469B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso13049580pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTK+xfsR0j+xCNHQsqpg9k6oGbLrp123IoZ4WeUeiW0=;
        b=br3K0OFLOLof60ras95igFKBghZGWly2Q/NOKBv+SdHVbeiNa/5kkviR8DuUOzHb5B
         XvJNmvmT4N381bU88daxdzoQ2tkb6utSR+ZHqJZujHFnB6nWMMHFdKDvPKReWKLwubJW
         0Chmt8KyjudEpkvTZ6Q0ZWEk8qdNzI8J+L5ZFB3mrXQQhyutoqvrYDixJkWEolbrpnn6
         9rPlCtIfOd+YZTbHm16JCqxUJwdV5BQ4j5KMAb3YOxzu/CwtRI9pOWwC75Ok7mgjKSUZ
         hJUikhZNY6X4T542UhOYRi63eacekCJIXRTwaBOk25rrdwYEEhzOVKZaFdSv7rO5EuxC
         VcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTK+xfsR0j+xCNHQsqpg9k6oGbLrp123IoZ4WeUeiW0=;
        b=64qzLBtiF+hPCr0JjFUuP8Eo8qoJProWk6wioDfsaeqjps7GRzhby2DbguroNDuG0e
         dxflTYL4H+cZY4XWvPEAiRSsL63LjSRk/JGNH9Ugx8wDLQ5+4dKRik8eM/qw0FskGh+i
         e8xMokz96Aq8KOSRccwiaRCP8nrMZVEc0kBIV+Lrz/A2vvnTy8bRhpz+4GMlhnLDTMWq
         nz6SZpa+ljMsPw7WjkJ9hAB0PP8Hyp2RnMcILV6mBq3wKTjae510roFQ2Zw8Ov3iZ74y
         UTQp4asU6bk4B+WZ/z2CZeh+1MMpKGYAl1WBklUOb3KiXwipIR6qWq+LYXJM33XTu8GD
         u85g==
X-Gm-Message-State: AO0yUKXR2X8aKaPRrH/hltK0UynkaoUr4N249V5LVnB+5nvhs0Z/602S
        jNdriIvtxl1iGFPOB4DfbpoT+Hb/yo+56Xle
X-Google-Smtp-Source: AK7set8xKRBvy/axmiQXhbS6PaG2dl35Kqax95hqZ2di9iPhyHTj7L0l7ihqDU/zTPKXG1WsBJH+tw==
X-Received: by 2002:a17:903:4091:b0:19a:73f7:675f with SMTP id z17-20020a170903409100b0019a73f7675fmr7653867plc.60.1676264041975;
        Sun, 12 Feb 2023 20:54:01 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:01 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 00/20] riscv control-flow integrity for U mode
Date:   Sun, 12 Feb 2023 20:53:29 -0800
Message-Id: <20230213045351.3945824-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I've been working on linux support for shadow stack and landing pad
instruction on riscv for a while.

These are still RFC quality. But atleast they're in a shape which can
start a discussion and I can get some feedback. So I decided to sending
out patches.

This patch series implements `zisslpcfi` extension which helps software
to enforce control-flow integrity (cfi) on riscv CPUs. Currently spec is
called zisslpcfi [1] spec. This literally means "unprivileged integer
shadow stack & landing pad based control-flow integrity".

Three major architectures [1, 2, 3] either already support or have
indicated support for control flow integrity extensions based on shadow
stack (for backward edge) and landing pads for indirect call/jmp (for
forward edge). Since these mechanisms are solving one common security
issue (control flow hijacking attacks) plaguing software ecosystem,
there're bound to be common similarities and thus need of abstracting
or having common code. These commonalities are:
  - Concept of shadow stack for program
  - Protection of shadow stack from regular stores but still allowing
    return address to be store via special mechanism(s)
  - Concept of indirect branch tracking and thus landing pad instruction
    as target for indirect branches.

Due to commonality in three arches for shadow stack and landing pad instr
support, patch series defines following arch-agnostic configs:
  - CONFIG_USER_SHADOW_STACK: Selecting this config means kernel will
    have support for programs compiled with optin of shadow stacks.
  - CONFIG_USER_INDIRECT_BR_LP: Selecting this config means kernel will
    have support for program compiled with optin of landing pad
    instructions on indirect branches.

There're stubs for abstraction on non-riscv architectures and specific
implementation for riscv architecture. Architecture owners can implement
those stubs abstractions on respective architectures to implement shadow
stack and branch tracking mechanism.

Additional highlights of this patch series specifically targeted towards
implementation of `zisslpcfi`

Shadow stack and landing pad state
----------------------------------
On riscv I choose to insert shadow stack and landing pad state in
thread_info. pt_regs is one choice but I didn't see a compelling reason
to put these in pt_regs. If you do have a compelling reason to put this
in pt_regs, we can make that change.

Shadow stack
------------
Shadow stack is already present on x86 [2] and is going to be part of
riscv and aarch64 [3] architecture. Since shadow stack are writeable
memory but at the same time are not allowed to be writeable by regular
stores. They have special meaning and this patch series proposes a new
`mmap` protection flag `PROT_SHADOWSTACK`. Repsective architecture can
choose to implement this memory protection. With respect to vma flags, 
riscv implementation chooses to have only `VM_WRITE` as shadow stack
meaning and is analogous to riscv architecture's  PTE encodings
(X=0,R=0,W=1) as shadow stack. On riscv, all stores to shadow stack
memory raise access store faults. Similarly all shadow stack load and
stores on non-shadow stack memory (but valid) will raise access
load/store faults. This patch series creates a synthetic exception code
(=14) which is reserved in privileged spec and feeds that into common
page fault handling routine.

ELF parsing
------------
There're two ways to enable forward cfi and backward cfi
- prctls: `ld` can issue prctls to enable it on the runtime.
- elf marker: Some sort of marker in elf header which kernel can recognize
              and setup forward and backward cfi state.

This patch series uses .note.gnu.property section and assumes two flags
exist there for forward cfi and backward cfi, if present kernel setups
the respective cfi state.

Please note that this part will change because risc-v is moving towards
using `.riscv.attributes` section to host such flags. So I'll change the
implementation in future revisions.

Signal & ucontext
------------------
This patch series steals 4(32bit)/8(64bit) bytes from a padding structure
in ucontext. This padding exist for future use case which we don't know yet.
But stealing few bytes from this padding allows us to keep the structure
size same and save some compatiblity issues. Signal patches still need
some work (have to work out a shadow stack token save on signal delivery
and restore mechanism on sigreturn. This will prevent any abuse of
sigreturns to hijack control flow)

Audit mode
-----------
Since this is a RFC, current set of patches suppresses cfi violations in
program and let the program make forward progress. However this shouldn't
be allowed by default and can be built into a policy.

More on `zisslpcfi` riscv extension
------------------------------------

zisslpcfi (CFI) extends ISA in following manner:

Forward cfi (indirect call/jmp)
- Landing pad instruction requirement for indirect call/jmp
  All indirect call and jump must land on landing pad instruction `lpcll`
  else CPU will raise illegal instruction exception. `lpcll` stands for
  land pad check lower label.

- Static label (25bit label) checking instructions for indirect call/jmp
  Extension provides mechanism using which a compiler generated label
  value can be set in a designated CSR at call site and it can be checked
  at the call target. If mismatch happens, CPU will raise illegal
  instruction exception. Compiler can generate hash based on function
  signature type. Extension provide mechanisms using which label value
  is part of the instruction itself as immediate and thus has static
  immutable property.

Backward cfi (returns)
- Shadow stack (SS) for function returns
  Extension provides sspush x1/x5, sspop x1/x5 and sschkra instructions.
  sspush will push on shadow stack while sspop will pop from shadow stack
  sschkra will succeed only when x1 == x5 is true else it will raise
  illegal instruction exception. Shadow stacks introduces new virtual
  memory type and thus new PTE encodings. Existing reserved encoding of
  R=0,W=1,X=0 is now shadow stack PTE encoding (only if backward cfi is
  enabled for current mode). New virtual memory type allows CPU to
  distinguish so that stores coming from sspush or ssamoswap can succeed
  while regular stores raise access violations.

opcodes:
zisslpcfi opcodes are carved out of new opcode encodings. These opcodes
encodings were reserved until now. A new extension called zimops make
these opcodes into "may be operations". zimops stands for unprivileged
may be operations (mops) and if implemented default behavior is to mov 0
to rd. zisslpcfi extension changes executable in a way where it should be
able to run on riscv cpu which implements cfi extension as well as riscv
cpu which doesn't implement cfi extension. As long as zimops is
implemented, all such instructions will not fault and simply move 0 to rd.
A hart implementing cfi must implement zimops. Any future extension can
re-purpose zimops to change behavior and claim them while also not
breaking binary/executable compatiblity . zisslpcfi is first such
extension to modify zimops behavior.

Instructions:
zisslpcfi defines following instructions.

Backward control flow:

sspush x1/x5:
Decrement shadow stack pointer and pushes x1 or x5 on shadow stack.

sspop x1/x5:
Pops from shadow stack into x1 or x5. Increments shadow stack pointer.

ssprr:
Reads current shadow stack pointer into a destination register.

sschckra:
Compares x1 with x5. Raises illegal instr exception if x1 != x5.

ssamoswap:
Atomically swaps value on top of shadow stack.


Forward control flow:

Forward control flow extends architecture to allow software to set labels
(25bits of label) at call/jmp site and check labels at target. Extension
gives instructions to set label as part of immediate in instruction itself
. Since immediate is limited in terms of bit length, labels are set and
checked in ladder fashion of 9, 8 and 8 bits.

lpsll, lpsml, lpsul:
sets lower (9bit), mid (8bit) and upper (8bit) label values in CSR_LPLR
respectively.

lpcll, lpcml, lpcul:
checks lower (9bit), mid (8bit) and upper (8bit) label values with
CSR_LPLR respectively. Check label instructions raise illegal instruction
fault when labels mismatch. `lpcll` has dual purpose; it acts as landing
pad instruction as well label checking for lower 9 bits.


Tests and other bits
********************
For convenience this patch has been tested with followng qemu impl.
https://github.com/deepak0414/qemu/tree/scfi_menvcfg_gh_Zisslpcfi-0.1

I've been able to boot linux kernel using this implementation and run
very basic simple tests apps. For convenience here is the branch which
has implementation.
https://github.com/deepak0414/linux-riscv-cfi/tree/Zisslpcfi-0.4_v6.1-rc2

In order to perform unit-tests on qemu-impl, I've been using riscv-test
and created unit tests to test implementation. riscv-tests branch URL is
below
https://github.com/deepak0414/riscv-tests/tree/cfi_tests

[1] - https://github.com/riscv/riscv-cfi
[2] - https://www.intel.com/content/dam/develop/external/us/en/documents/catc17-introduction-intel-cet-844137.pdf
[3] - https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/arm-a-profile-architecture-2022

Deepak Gupta (20):
  sslp stubs: shadow stack and landing pad stubs
  riscv: zisslpcfi enumeration
  riscv: zisslpcfi extension csr and bit definitions
  riscv: kernel enabling user code for shadow stack and landing pad
  mmap : Introducing new protection "PROT_SHADOWSTACK" for mmap
  riscv: Implementing "PROT_SHADOWSTACK" on riscv
  elf: ELF header parsing in GNU property for cfi state
  riscv: ELF header parsing in GNU property for riscv zisslpcfi
  riscv mmu: riscv shadow stack page fault handling
  riscv mmu: write protect and shadow stack
  mmu: maybe_mkwrite updated to manufacture shadow stack PTEs
  riscv mm: manufacture shadow stack pte and is vma shadowstack
  riscv: illegal instruction handler for cfi violations
  riscv: audit mode for cfi violations
  sslp prctl: arch-agnostic prctl for shadow stack and landing pad instr
  riscv: Implements sslp prctls
  riscv ucontext: adding shadow stack pointer field in ucontext
  riscv signal: Save and restore of shadow stack for signal
  config: adding two new config for control flow integrity
  riscv: select config for shadow stack and landing pad instr support

 arch/riscv/Kconfig                     |   4 +
 arch/riscv/include/asm/csr.h           |  28 ++++
 arch/riscv/include/asm/elf.h           |  54 ++++++++
 arch/riscv/include/asm/hwcap.h         |   6 +-
 arch/riscv/include/asm/mman.h          |  19 +++
 arch/riscv/include/asm/pgtable.h       |  21 ++-
 arch/riscv/include/asm/processor.h     |  26 ++++
 arch/riscv/include/asm/thread_info.h   |   5 +
 arch/riscv/include/uapi/asm/ucontext.h |  32 ++++-
 arch/riscv/kernel/asm-offsets.c        |   5 +
 arch/riscv/kernel/cpu.c                |   1 +
 arch/riscv/kernel/cpufeature.c         |   1 +
 arch/riscv/kernel/entry.S              |  40 ++++++
 arch/riscv/kernel/process.c            | 155 +++++++++++++++++++++
 arch/riscv/kernel/signal.c             |  45 ++++++
 arch/riscv/kernel/sys_riscv.c          |  22 +++
 arch/riscv/kernel/traps.c              | 183 ++++++++++++++++++++++++-
 arch/riscv/mm/fault.c                  |  23 +++-
 arch/riscv/mm/init.c                   |   2 +-
 arch/riscv/mm/pageattr.c               |   7 +
 fs/binfmt_elf.c                        |   5 +
 include/linux/elf.h                    |   8 ++
 include/linux/mm.h                     |  23 +++-
 include/linux/pgtable.h                |   4 +
 include/linux/processor.h              |  17 +++
 include/uapi/asm-generic/mman-common.h |   6 +
 include/uapi/linux/elf.h               |   6 +
 include/uapi/linux/prctl.h             |  26 ++++
 init/Kconfig                           |  19 +++
 kernel/sys.c                           |  40 ++++++
 mm/mmap.c                              |   4 +
 31 files changed, 825 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/include/asm/mman.h

-- 
2.25.1

