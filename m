Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A68660D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBAMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBAMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:36:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA9D5CD07;
        Wed,  1 Feb 2023 04:36:43 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxCerZXNpjX3kLAA--.23499S3;
        Wed, 01 Feb 2023 20:36:41 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3WXNpjUXImAA--.10032S4;
        Wed, 01 Feb 2023 20:36:39 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: treewide: Clean up BPF_ALU and BPF_JMP
Date:   Wed,  1 Feb 2023 20:36:36 +0800
Message-Id: <1675254998-4951-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxOL3WXNpjUXImAA--.10032S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjv_XoW8JF47GF1Utw15CrWxKrWkWryDp5X_AF4UZF
        1fpa4rXasFyw1UX3y3Xryvgry2vF13Kr48GrnrAasFgw17Z3y7X3W3X3W5ta13Jw13Jr1r
        W39IvF1093s7Zay8uFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCT
        nIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJT
        RUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr
        0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ambiguos macro BPF_ALU and BPF_JMP with new macro BPF_ALU32
and BPF_JMP64 in the kernel code.

sed -i "s/\<BPF_ALU\>/BPF_ALU32/g" `grep BPF_ALU -rwl --exclude="bpf_common.h" .`
sed -i "s/\<BPF_JMP\>/BPF_JMP64/g" `grep BPF_JMP -rwl --exclude="bpf_common.h" .`

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/bpf/clang-notes.rst                  |   2 +-
 Documentation/bpf/classic_vs_extended.rst          |  26 +-
 Documentation/bpf/instruction-set.rst              |  28 +-
 Documentation/bpf/verifier.rst                     |  10 +-
 Documentation/networking/cdc_mbim.rst              |   8 +-
 arch/arm/net/bpf_jit_32.c                          | 110 +++---
 arch/arm64/net/bpf_jit_comp.c                      | 112 +++---
 arch/loongarch/net/bpf_jit.c                       | 108 +++---
 arch/mips/net/bpf_jit_comp32.c                     | 106 +++---
 arch/mips/net/bpf_jit_comp64.c                     | 106 +++---
 arch/powerpc/net/bpf_jit_comp.c                    |   2 +-
 arch/powerpc/net/bpf_jit_comp32.c                  | 152 ++++----
 arch/powerpc/net/bpf_jit_comp64.c                  | 162 ++++----
 arch/riscv/net/bpf_jit_comp32.c                    | 108 +++---
 arch/riscv/net/bpf_jit_comp64.c                    | 120 +++---
 arch/s390/net/bpf_jit_comp.c                       | 108 +++---
 arch/sparc/net/bpf_jit_comp_32.c                   |  72 ++--
 arch/sparc/net/bpf_jit_comp_64.c                   | 108 +++---
 arch/x86/net/bpf_jit_comp.c                        | 118 +++---
 arch/x86/net/bpf_jit_comp32.c                      | 116 +++---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       | 124 +++----
 drivers/net/ethernet/netronome/nfp/bpf/main.h      |   8 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |   4 +-
 include/linux/filter.h                             |  28 +-
 kernel/bpf/core.c                                  |  50 +--
 kernel/bpf/disasm.c                                |  22 +-
 kernel/bpf/syscall.c                               |  12 +-
 kernel/bpf/verifier.c                              |  66 ++--
 kernel/seccomp.c                                   |  68 ++--
 lib/test_bpf.c                                     | 408 ++++++++++-----------
 net/core/filter.c                                  | 182 ++++-----
 samples/bpf/bpf_insn.h                             |  14 +-
 samples/bpf/cookie_uid_helper_example.c            |   8 +-
 samples/bpf/sock_example.c                         |   2 +-
 samples/bpf/test_cgrp2_attach.c                    |   4 +-
 samples/bpf/test_cgrp2_sock.c                      |   2 +-
 samples/seccomp/bpf-direct.c                       |  18 +-
 samples/seccomp/bpf-helper.c                       |   2 +-
 samples/seccomp/bpf-helper.h                       |  56 +--
 samples/seccomp/dropper.c                          |   4 +-
 samples/seccomp/user-trap.c                        |   2 +-
 tools/bpf/bpf_dbg.c                                |  34 +-
 tools/bpf/bpf_exp.y                                | 130 +++----
 tools/bpf/bpftool/cfg.c                            |   4 +-
 tools/include/linux/filter.h                       |  24 +-
 tools/lib/bpf/bpf_endian.h                         |   2 +-
 tools/lib/bpf/libbpf.c                             |  14 +-
 tools/lib/bpf/linker.c                             |   2 +-
 tools/lib/bpf/relo_core.c                          |   4 +-
 tools/perf/util/bpf-prologue.c                     |   2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   8 +-
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c |   6 +-
 .../bpf/prog_tests/flow_dissector_load_bytes.c     |   2 +-
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |   2 +-
 tools/testing/selftests/bpf/progs/pyperf600.c      |   2 +-
 tools/testing/selftests/bpf/progs/syscall.c        |   2 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c  |   4 +-
 tools/testing/selftests/bpf/test_verifier.c        |  20 +-
 tools/testing/selftests/bpf/test_verifier_log.c    |   2 +-
 tools/testing/selftests/bpf/verifier/and.c         |   6 +-
 .../testing/selftests/bpf/verifier/array_access.c  |  46 +--
 tools/testing/selftests/bpf/verifier/basic_call.c  |  14 +-
 tools/testing/selftests/bpf/verifier/basic_stack.c |   2 +-
 tools/testing/selftests/bpf/verifier/bounds.c      |  58 +--
 .../bpf/verifier/bounds_mix_sign_unsign.c          |  32 +-
 .../testing/selftests/bpf/verifier/bpf_get_stack.c |   4 +-
 .../selftests/bpf/verifier/bpf_loop_inline.c       |  26 +-
 tools/testing/selftests/bpf/verifier/calls.c       | 360 +++++++++---------
 .../selftests/bpf/verifier/cgroup_storage.c        |  28 +-
 tools/testing/selftests/bpf/verifier/ctx.c         |  24 +-
 tools/testing/selftests/bpf/verifier/ctx_skb.c     |   6 +-
 tools/testing/selftests/bpf/verifier/d_path.c      |   4 +-
 tools/testing/selftests/bpf/verifier/dead_code.c   |  16 +-
 .../selftests/bpf/verifier/direct_packet_access.c  |   2 +-
 .../testing/selftests/bpf/verifier/event_output.c  |   2 +-
 .../selftests/bpf/verifier/helper_access_var_len.c |   6 +-
 .../selftests/bpf/verifier/helper_packet_access.c  |  42 +--
 .../selftests/bpf/verifier/helper_restricted.c     |  24 +-
 tools/testing/selftests/bpf/verifier/jmp32.c       |   6 +-
 tools/testing/selftests/bpf/verifier/jset.c        |   8 +-
 tools/testing/selftests/bpf/verifier/jump.c        |  12 +-
 tools/testing/selftests/bpf/verifier/junk_insn.c   |   2 +-
 tools/testing/selftests/bpf/verifier/ld_abs.c      |   4 +-
 tools/testing/selftests/bpf/verifier/leak_ptr.c    |   2 +-
 tools/testing/selftests/bpf/verifier/loops1.c      |  14 +-
 tools/testing/selftests/bpf/verifier/map_in_map.c  |  20 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |  58 +--
 tools/testing/selftests/bpf/verifier/map_ptr.c     |   4 +-
 .../selftests/bpf/verifier/map_ptr_mixing.c        |   8 +-
 tools/testing/selftests/bpf/verifier/map_ret_val.c |   8 +-
 tools/testing/selftests/bpf/verifier/meta_access.c |   2 +-
 tools/testing/selftests/bpf/verifier/precise.c     |  12 +-
 .../selftests/bpf/verifier/prevent_map_lookup.c    |   4 +-
 tools/testing/selftests/bpf/verifier/raw_stack.c   |  32 +-
 .../selftests/bpf/verifier/raw_tp_writable.c       |   2 +-
 .../testing/selftests/bpf/verifier/ref_tracking.c  |  46 +--
 tools/testing/selftests/bpf/verifier/regalloc.c    |   4 +-
 tools/testing/selftests/bpf/verifier/ringbuf.c     |  14 +-
 tools/testing/selftests/bpf/verifier/runtime_jit.c |  26 +-
 .../selftests/bpf/verifier/search_pruning.c        |  10 +-
 tools/testing/selftests/bpf/verifier/spill_fill.c  |   8 +-
 tools/testing/selftests/bpf/verifier/spin_lock.c   |  82 ++---
 tools/testing/selftests/bpf/verifier/subreg.c      |  96 ++---
 tools/testing/selftests/bpf/verifier/unpriv.c      |  16 +-
 .../testing/selftests/bpf/verifier/value_or_null.c |  20 +-
 .../selftests/bpf/verifier/value_ptr_arith.c       |  80 ++--
 tools/testing/selftests/bpf/verifier/var_off.c     |   4 +-
 tools/testing/selftests/bpf/verifier/xadd.c        |   2 +-
 tools/testing/selftests/net/csum.c                 |   6 +-
 tools/testing/selftests/net/gro.c                  |   8 +-
 tools/testing/selftests/net/psock_fanout.c         |  12 +-
 tools/testing/selftests/net/reuseport_bpf.c        |   6 +-
 tools/testing/selftests/net/reuseport_bpf_numa.c   |   4 +-
 tools/testing/selftests/net/toeplitz.c             |   6 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  68 ++--
 115 files changed, 2224 insertions(+), 2224 deletions(-)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 528fedd..4306f5d 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -17,7 +17,7 @@ Clang can select the eBPF ISA version using ``-mcpu=v3`` for example to select v
 Arithmetic instructions
 =======================
 
-For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
+For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU32`` support with
 ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
 
 Atomic operations
diff --git a/Documentation/bpf/classic_vs_extended.rst b/Documentation/bpf/classic_vs_extended.rst
index 2f81a81..6a0e7ea 100644
--- a/Documentation/bpf/classic_vs_extended.rst
+++ b/Documentation/bpf/classic_vs_extended.rst
@@ -261,8 +261,8 @@ Three LSB bits store instruction class which is one of:
   BPF_LDX   0x01          BPF_LDX   0x01
   BPF_ST    0x02          BPF_ST    0x02
   BPF_STX   0x03          BPF_STX   0x03
-  BPF_ALU   0x04          BPF_ALU   0x04
-  BPF_JMP   0x05          BPF_JMP   0x05
+  BPF_ALU32 0x04          BPF_ALU32 0x04
+  BPF_JMP64 0x05          BPF_JMP64 0x05
   BPF_RET   0x06          BPF_JMP32 0x06
   BPF_MISC  0x07          BPF_ALU64 0x07
   ===================     ===============
@@ -286,7 +286,7 @@ The 4th bit encodes the source operand ...
 
 ... and four MSB bits store operation code.
 
-If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of::
+If BPF_CLASS(code) == BPF_ALU32 or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of::
 
   BPF_ADD   0x00
   BPF_SUB   0x10
@@ -303,9 +303,9 @@ If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of::
   BPF_ARSH  0xc0  /* eBPF only: sign extending shift right */
   BPF_END   0xd0  /* eBPF only: endianness conversion */
 
-If BPF_CLASS(code) == BPF_JMP or BPF_JMP32 [ in eBPF ], BPF_OP(code) is one of::
+If BPF_CLASS(code) == BPF_JMP64 or BPF_JMP32 [ in eBPF ], BPF_OP(code) is one of::
 
-  BPF_JA    0x00  /* BPF_JMP only */
+  BPF_JA    0x00  /* BPF_JMP64 only */
   BPF_JEQ   0x10
   BPF_JGT   0x20
   BPF_JGE   0x30
@@ -313,32 +313,32 @@ If BPF_CLASS(code) == BPF_JMP or BPF_JMP32 [ in eBPF ], BPF_OP(code) is one of::
   BPF_JNE   0x50  /* eBPF only: jump != */
   BPF_JSGT  0x60  /* eBPF only: signed '>' */
   BPF_JSGE  0x70  /* eBPF only: signed '>=' */
-  BPF_CALL  0x80  /* eBPF BPF_JMP only: function call */
-  BPF_EXIT  0x90  /* eBPF BPF_JMP only: function return */
+  BPF_CALL  0x80  /* eBPF BPF_JMP64 only: function call */
+  BPF_EXIT  0x90  /* eBPF BPF_JMP64 only: function return */
   BPF_JLT   0xa0  /* eBPF only: unsigned '<' */
   BPF_JLE   0xb0  /* eBPF only: unsigned '<=' */
   BPF_JSLT  0xc0  /* eBPF only: signed '<' */
   BPF_JSLE  0xd0  /* eBPF only: signed '<=' */
 
-So BPF_ADD | BPF_X | BPF_ALU means 32-bit addition in both classic BPF
+So BPF_ADD | BPF_X | BPF_ALU32 means 32-bit addition in both classic BPF
 and eBPF. There are only two registers in classic BPF, so it means A += X.
 In eBPF it means dst_reg = (u32) dst_reg + (u32) src_reg; similarly,
-BPF_XOR | BPF_K | BPF_ALU means A ^= imm32 in classic BPF and analogous
+BPF_XOR | BPF_K | BPF_ALU32 means A ^= imm32 in classic BPF and analogous
 src_reg = (u32) src_reg ^ (u32) imm32 in eBPF.
 
 Classic BPF is using BPF_MISC class to represent A = X and X = A moves.
-eBPF is using BPF_MOV | BPF_X | BPF_ALU code instead. Since there are no
+eBPF is using BPF_MOV | BPF_X | BPF_ALU32 code instead. Since there are no
 BPF_MISC operations in eBPF, the class 7 is used as BPF_ALU64 to mean
-exactly the same operations as BPF_ALU, but with 64-bit wide operands
+exactly the same operations as BPF_ALU32, but with 64-bit wide operands
 instead. So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition, i.e.:
 dst_reg = dst_reg + src_reg
 
 Classic BPF wastes the whole BPF_RET class to represent a single ``ret``
 operation. Classic BPF_RET | BPF_K means copy imm32 into return register
-and perform function exit. eBPF is modeled to match CPU, so BPF_JMP | BPF_EXIT
+and perform function exit. eBPF is modeled to match CPU, so BPF_JMP64 | BPF_EXIT
 in eBPF means function exit only. The eBPF program needs to store return
 value into register R0 before doing a BPF_EXIT. Class 6 in eBPF is used as
-BPF_JMP32 to mean exactly the same operations as BPF_JMP, but with 32-bit wide
+BPF_JMP32 to mean exactly the same operations as BPF_JMP64, but with 32-bit wide
 operands for the comparisons instead.
 
 For load and store instructions the 8-bit 'code' field is divided as::
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59..6fbf982 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -56,8 +56,8 @@ BPF_LD     0x00   non-standard load operations     `Load and store instructions`
 BPF_LDX    0x01   load into register operations    `Load and store instructions`_
 BPF_ST     0x02   store from immediate operations  `Load and store instructions`_
 BPF_STX    0x03   store from register operations   `Load and store instructions`_
-BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and jump instructions`_
-BPF_JMP    0x05   64-bit jump operations           `Arithmetic and jump instructions`_
+BPF_ALU32  0x04   32-bit arithmetic operations     `Arithmetic and jump instructions`_
+BPF_JMP64  0x05   64-bit jump operations           `Arithmetic and jump instructions`_
 BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and jump instructions`_
 BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump instructions`_
 =========  =====  ===============================  ===================================
@@ -65,7 +65,7 @@ BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump instruct
 Arithmetic and jump instructions
 ================================
 
-For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` and
+For arithmetic and jump instructions (``BPF_ALU32``, ``BPF_ALU64``, ``BPF_JMP64`` and
 ``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
 
 ==============  ======  =================
@@ -89,7 +89,7 @@ The four MSB bits store the operation code.
 Arithmetic instructions
 -----------------------
 
-``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
+``BPF_ALU32`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
 otherwise identical operations.
 The 'code' field encodes the operation as below:
 
@@ -116,10 +116,10 @@ Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
 result in division by zero, the destination register is instead set to zero.
 If execution would result in modulo by zero, for ``BPF_ALU64`` the value of
-the destination register is unchanged whereas for ``BPF_ALU`` the upper
+the destination register is unchanged whereas for ``BPF_ALU32`` the upper
 32 bits of the destination register are zeroed.
 
-``BPF_ADD | BPF_X | BPF_ALU`` means::
+``BPF_ADD | BPF_X | BPF_ALU32`` means::
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
@@ -127,7 +127,7 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
 
   dst_reg = dst_reg + src_reg
 
-``BPF_XOR | BPF_K | BPF_ALU`` means::
+``BPF_XOR | BPF_K | BPF_ALU32`` means::
 
   dst_reg = (u32) dst_reg ^ (u32) imm32
 
@@ -136,7 +136,7 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
   dst_reg = dst_reg ^ imm32
 
 Also note that the division and modulo operations are unsigned. Thus, for
-``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
+``BPF_ALU32``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
 for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
 interpreted as an unsigned 64-bit value. There are no instructions for
 signed division or modulo.
@@ -144,7 +144,7 @@ signed division or modulo.
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
 
-The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
+The byte swap instructions use an instruction class of ``BPF_ALU32`` and a 4-bit
 'code' field of ``BPF_END``.
 
 The byte swap instructions operate on the destination register
@@ -165,25 +165,25 @@ are supported: 16, 32 and 64.
 
 Examples:
 
-``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
+``BPF_ALU32 | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
   dst_reg = htole16(dst_reg)
 
-``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
+``BPF_ALU32 | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
   dst_reg = htobe64(dst_reg)
 
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
+``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP64`` uses 64-bit wide operands for
 otherwise identical operations.
 The 'code' field encodes the operation as below:
 
 ========  =====  =========================  ============
 code      value  description                notes
 ========  =====  =========================  ============
-BPF_JA    0x00   PC += off                  BPF_JMP only
+BPF_JA    0x00   PC += off                  BPF_JMP64 only
 BPF_JEQ   0x10   PC += off if dst == src
 BPF_JGT   0x20   PC += off if dst > src     unsigned
 BPF_JGE   0x30   PC += off if dst >= src    unsigned
@@ -192,7 +192,7 @@ BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
 BPF_CALL  0x80   function call
-BPF_EXIT  0x90   function / program return  BPF_JMP only
+BPF_EXIT  0x90   function / program return  BPF_JMP64 only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
 BPF_JSLT  0xc0   PC += off if dst < src     signed
diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 3afa548..ecf6ead 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -369,7 +369,7 @@ Program that doesn't initialize stack before passing its address into function::
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_EXIT_INSN(),
 
 Error::
@@ -386,7 +386,7 @@ Program that uses invalid map_fd=0 while calling to map_lookup_elem() function::
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_EXIT_INSN(),
 
 Error::
@@ -405,7 +405,7 @@ map element::
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
   BPF_EXIT_INSN(),
 
@@ -426,7 +426,7 @@ accesses the memory with incorrect alignment::
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
   BPF_EXIT_INSN(),
@@ -451,7 +451,7 @@ to do so in the other side of 'if' branch::
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
   BPF_EXIT_INSN(),
diff --git a/Documentation/networking/cdc_mbim.rst b/Documentation/networking/cdc_mbim.rst
index 0048409..d927ccb 100644
--- a/Documentation/networking/cdc_mbim.rst
+++ b/Documentation/networking/cdc_mbim.rst
@@ -249,16 +249,16 @@ example::
   static struct sock_filter dssfilter[] = {
 	/* use special negative offsets to get VLAN tag */
 	BPF_STMT(BPF_LD|BPF_B|BPF_ABS, SKF_AD_OFF + SKF_AD_VLAN_TAG_PRESENT),
-	BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, 1, 0, 6), /* true */
+	BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, 1, 0, 6), /* true */
 
 	/* verify DSS VLAN range */
 	BPF_STMT(BPF_LD|BPF_H|BPF_ABS, SKF_AD_OFF + SKF_AD_VLAN_TAG),
-	BPF_JUMP(BPF_JMP|BPF_JGE|BPF_K, 256, 0, 4),	/* 256 is first DSS VLAN */
-	BPF_JUMP(BPF_JMP|BPF_JGE|BPF_K, 512, 3, 0),	/* 511 is last DSS VLAN */
+	BPF_JUMP(BPF_JMP64|BPF_JGE|BPF_K, 256, 0, 4),	/* 256 is first DSS VLAN */
+	BPF_JUMP(BPF_JMP64|BPF_JGE|BPF_K, 512, 3, 0),	/* 511 is last DSS VLAN */
 
 	/* verify ethertype */
 	BPF_STMT(BPF_LD|BPF_H|BPF_ABS, 2 * ETH_ALEN),
-	BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, ETH_P_802_3, 0, 1),
+	BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, ETH_P_802_3, 0, 1),
 
 	BPF_STMT(BPF_RET|BPF_K, (u_int)-1),	/* accept */
 	BPF_STMT(BPF_RET|BPF_K, 0),		/* ignore */
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fc..f189ed5 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -492,7 +492,7 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 #endif
 
 	/*
-	 * For BPF_ALU | BPF_DIV | BPF_K instructions
+	 * For BPF_ALU32 | BPF_DIV | BPF_K instructions
 	 * As ARM_R1 and ARM_R0 contains 1st argument of bpf
 	 * function, we need to save it on caller side to save
 	 * it from getting destroyed within callee.
@@ -1374,8 +1374,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* ALU operations */
 
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_K:
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		switch (BPF_SRC(code)) {
@@ -1401,21 +1401,21 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = dst * src/imm */
 	/* dst = dst << src */
 	/* dst = dst >> src */
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_ADD | BPF_X:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_X:
-	case BPF_ALU | BPF_OR | BPF_K:
-	case BPF_ALU | BPF_OR | BPF_X:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_X:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_X:
-	case BPF_ALU | BPF_MUL | BPF_K:
-	case BPF_ALU | BPF_MUL | BPF_X:
-	case BPF_ALU | BPF_LSH | BPF_X:
-	case BPF_ALU | BPF_RSH | BPF_X:
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
@@ -1444,10 +1444,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* dst = dst / src(imm) */
 	/* dst = dst % src(imm) */
-	case BPF_ALU | BPF_DIV | BPF_K:
-	case BPF_ALU | BPF_DIV | BPF_X:
-	case BPF_ALU | BPF_MOD | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 		rd_lo = arm_bpf_get_reg32(dst_lo, tmp2[1], ctx);
 		switch (BPF_SRC(code)) {
 		case BPF_X:
@@ -1474,9 +1474,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = dst << imm */
 	/* dst = dst >> imm */
 	/* dst = dst >> imm (signed) */
-	case BPF_ALU | BPF_LSH | BPF_K:
-	case BPF_ALU | BPF_RSH | BPF_K:
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 		if (unlikely(imm > 31))
 			return -EINVAL;
 		if (imm)
@@ -1515,7 +1515,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_a32_arsh_i64(dst, imm, ctx);
 		break;
 	/* dst = ~dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 		emit_a32_alu_i(dst_lo, 0, ctx, BPF_OP(code));
 		if (!ctx->prog->aux->verifier_zext)
 			emit_a32_mov_i(dst_hi, 0, ctx);
@@ -1545,8 +1545,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		rd = arm_bpf_get_reg64(dst, tmp, ctx);
 		if (BPF_SRC(code) == BPF_FROM_LE)
 			goto emit_bswap_uxt;
@@ -1650,17 +1650,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* PC += off if dst < src (signed) */
 	/* PC += off if dst <= src (signed) */
 	/* PC += off if dst & src */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
 	case BPF_JMP32 | BPF_JGE | BPF_X:
@@ -1687,17 +1687,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* PC += off if dst < imm (signed) */
 	/* PC += off if dst <= imm (signed) */
 	/* PC += off if dst & imm */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
 	case BPF_JMP32 | BPF_JGE | BPF_K:
@@ -1721,7 +1721,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 
 		/* Check for the condition */
 		emit_ar_r(rd[0], rd[1], rm, rn, ctx, BPF_OP(code),
-			  BPF_CLASS(code) == BPF_JMP);
+			  BPF_CLASS(code) == BPF_JMP64);
 
 		/* Setup JUMP instruction */
 		jmp_offset = bpf2a32_offset(i+off, i, ctx);
@@ -1760,7 +1760,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		break;
 	/* JMP OFF */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 	{
 		if (off == 0)
 			break;
@@ -1770,12 +1770,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	}
 	/* tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(ctx))
 			return -EFAULT;
 		break;
 	/* function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		const s8 *r0 = bpf2a32[BPF_REG_0];
 		const s8 *r1 = bpf2a32[BPF_REG_1];
@@ -1798,7 +1798,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	}
 	/* function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		/* Optimization: when last instruction is EXIT
 		 * simply fallthrough to epilogue.
 		 */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 62f805f..9de7a15 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -765,7 +765,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
-			  BPF_CLASS(code) == BPF_JMP;
+			  BPF_CLASS(code) == BPF_JMP64;
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
@@ -776,64 +776,64 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 
 	switch (code) {
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		emit(A64_MOV(is64, dst, src), ctx);
 		break;
 	/* dst = dst OP src */
-	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit(A64_ADD(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
 		emit(A64_SUB(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit(A64_AND(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit(A64_ORR(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit(A64_EOR(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit(A64_MUL(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit(A64_UDIV(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit(A64_UDIV(is64, tmp, dst, src), ctx);
 		emit(A64_MSUB(is64, dst, dst, tmp, src), ctx);
 		break;
-	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit(A64_LSLV(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit(A64_LSRV(is64, dst, dst, src), ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
 		emit(A64_ASRV(is64, dst, dst, src), ctx);
 		break;
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
 		emit(A64_NEG(is64, dst, dst), ctx);
 		break;
 	/* dst = BSWAP##imm(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 #ifdef CONFIG_CPU_BIG_ENDIAN
 		if (BPF_SRC(code) == BPF_FROM_BE)
 			goto emit_bswap_uxt;
@@ -872,12 +872,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		}
 		break;
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_a64_mov_i(is64, dst, imm, ctx);
 		break;
 	/* dst = dst OP imm */
-	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 		if (is_addsub_imm(imm)) {
 			emit(A64_ADD_I(is64, dst, dst, imm), ctx);
@@ -888,7 +888,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ADD(is64, dst, dst, tmp), ctx);
 		}
 		break;
-	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		if (is_addsub_imm(imm)) {
 			emit(A64_SUB_I(is64, dst, dst, imm), ctx);
@@ -899,7 +899,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_SUB(is64, dst, dst, tmp), ctx);
 		}
 		break;
-	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
 		a64_insn = A64_AND_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
@@ -909,7 +909,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_AND(is64, dst, dst, tmp), ctx);
 		}
 		break;
-	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
 		a64_insn = A64_ORR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
@@ -919,7 +919,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ORR(is64, dst, dst, tmp), ctx);
 		}
 		break;
-	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
 		a64_insn = A64_EOR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
@@ -929,52 +929,52 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_EOR(is64, dst, dst, tmp), ctx);
 		}
 		break;
-	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_a64_mov_i(is64, tmp, imm, ctx);
 		emit(A64_MUL(is64, dst, dst, tmp), ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		emit_a64_mov_i(is64, tmp, imm, ctx);
 		emit(A64_UDIV(is64, dst, dst, tmp), ctx);
 		break;
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		emit_a64_mov_i(is64, tmp2, imm, ctx);
 		emit(A64_UDIV(is64, tmp, dst, tmp2), ctx);
 		emit(A64_MSUB(is64, dst, dst, tmp, tmp2), ctx);
 		break;
-	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit(A64_LSL(is64, dst, dst, imm), ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		emit(A64_LSR(is64, dst, dst, imm), ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		emit(A64_ASR(is64, dst, dst, imm), ctx);
 		break;
 
 	/* JUMP off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		jmp_offset = bpf2a64_offset(i, off, ctx);
 		check_imm26(jmp_offset);
 		emit(A64_B(jmp_offset), ctx);
 		break;
 	/* IF (dst COND src) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
 	case BPF_JMP32 | BPF_JLT | BPF_X:
@@ -1026,21 +1026,21 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		}
 		emit(A64_B_(jmp_cond, jmp_offset), ctx);
 		break;
-	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
 	case BPF_JMP32 | BPF_JSET | BPF_X:
 		emit(A64_TST(is64, dst, src), ctx);
 		goto emit_cond_jmp;
 	/* IF (dst COND imm) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
 	case BPF_JMP32 | BPF_JLT | BPF_K:
@@ -1060,7 +1060,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_CMP(is64, dst, tmp), ctx);
 		}
 		goto emit_cond_jmp;
-	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		a64_insn = A64_TST_I(is64, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
@@ -1071,7 +1071,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		}
 		goto emit_cond_jmp;
 	/* function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		bool func_addr_fixed;
@@ -1086,12 +1086,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		break;
 	}
 	/* tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(ctx))
 			return -EFAULT;
 		break;
 	/* function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
@@ -1338,7 +1338,7 @@ static int find_fpb_offset(struct bpf_prog *prog)
 			break;
 
 		case BPF_JMP32:
-		case BPF_JMP:
+		case BPF_JMP64:
 			break;
 
 		case BPF_LDX:
@@ -1352,7 +1352,7 @@ static int find_fpb_offset(struct bpf_prog *prog)
 				offset = off;
 			break;
 
-		case BPF_ALU:
+		case BPF_ALU32:
 		case BPF_ALU64:
 		default:
 			/* fp holds ALU result */
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c4b1947..f18eaaa 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -462,31 +462,31 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
-	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
+	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU32 || BPF_CLASS(insn->code) == BPF_JMP32;
 
 	switch (code) {
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		move_reg(ctx, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		move_imm(ctx, dst, imm, is32);
 		break;
 
 	/* dst = dst + src */
-	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_insn(ctx, addd, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst + imm */
-	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 		if (is_signed_imm12(imm)) {
 			emit_insn(ctx, addid, dst, dst, imm);
@@ -498,14 +498,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst - src */
-	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
 		emit_insn(ctx, subd, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst - imm */
-	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		if (is_signed_imm12(-imm)) {
 			emit_insn(ctx, addid, dst, dst, -imm);
@@ -517,14 +517,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst * src */
-	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit_insn(ctx, muld, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst * imm */
-	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		move_imm(ctx, t1, imm, is32);
 		emit_insn(ctx, muld, dst, dst, t1);
@@ -532,7 +532,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst / src */
-	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit_zext_32(ctx, dst, is32);
 		move_reg(ctx, t1, src);
@@ -542,7 +542,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst / imm */
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		move_imm(ctx, t1, imm, is32);
 		emit_zext_32(ctx, dst, is32);
@@ -551,7 +551,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst % src */
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit_zext_32(ctx, dst, is32);
 		move_reg(ctx, t1, src);
@@ -561,7 +561,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst % imm */
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		move_imm(ctx, t1, imm, is32);
 		emit_zext_32(ctx, dst, is32);
@@ -570,7 +570,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
 		move_imm(ctx, t1, imm, is32);
 		emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
@@ -578,14 +578,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst & src */
-	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit_insn(ctx, and, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst & imm */
-	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, andi, dst, dst, imm);
@@ -597,14 +597,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst | src */
-	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit_insn(ctx, or, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst | imm */
-	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, ori, dst, dst, imm);
@@ -616,14 +616,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst ^ src */
-	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit_insn(ctx, xor, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst ^ imm */
-	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, xori, dst, dst, imm);
@@ -635,7 +635,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst << src (logical) */
-	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
 		emit_insn(ctx, sllw, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -645,7 +645,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst << imm (logical) */
-	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
 		emit_insn(ctx, slliw, dst, dst, imm);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -655,7 +655,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst >> src (logical) */
-	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
 		emit_insn(ctx, srlw, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -665,7 +665,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst >> imm (logical) */
-	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
 		emit_insn(ctx, srliw, dst, dst, imm);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -675,7 +675,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst >> src (arithmetic) */
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 		emit_insn(ctx, sraw, dst, dst, src);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -685,7 +685,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = dst >> imm (arithmetic) */
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 		emit_insn(ctx, sraiw, dst, dst, imm);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -695,7 +695,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* dst = BSWAP##imm(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16:
 			/* zero-extend 16 bits into 64 bits */
@@ -711,7 +711,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		}
 		break;
 
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		switch (imm) {
 		case 16:
 			emit_insn(ctx, revb2h, dst, dst);
@@ -730,16 +730,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* PC += off if dst cond src */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JNE | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
@@ -765,16 +765,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* PC += off if dst cond imm */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JNE | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -806,7 +806,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* PC += off if dst & src */
-	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
 	case BPF_JMP32 | BPF_JSET | BPF_X:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		emit_insn(ctx, and, t1, dst, src);
@@ -816,7 +816,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* PC += off if dst & imm */
-	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		move_imm(ctx, t1, imm, is32);
@@ -827,14 +827,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* PC += off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		if (emit_uncond_jmp(ctx, jmp_offset) < 0)
 			goto toofar;
 		break;
 
 	/* function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 		mark_call(ctx);
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
@@ -847,14 +847,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	/* tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		mark_tail_call(ctx);
 		if (emit_bpf_tail_call(ctx) < 0)
 			return -EINVAL;
 		break;
 
 	/* function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		emit_sext_32(ctx, regmap[BPF_REG_0], true);
 
 		if (i == ctx->prog->len - 1)
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index ace5db3..6bd12f6 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1475,12 +1475,12 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 		emit_mov_i(ctx, lo(dst), imm);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
@@ -1490,7 +1490,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		}
 		break;
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 		emit_alu_i(ctx, lo(dst), 0, BPF_NEG);
 		emit_zext_ver(ctx, dst);
 		break;
@@ -1505,17 +1505,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst * imm */
 	/* dst = dst / imm */
 	/* dst = dst % imm */
-	case BPF_ALU | BPF_OR | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_LSH | BPF_K:
-	case BPF_ALU | BPF_RSH | BPF_K:
-	case BPF_ALU | BPF_ARSH | BPF_K:
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_MUL | BPF_K:
-	case BPF_ALU | BPF_DIV | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 		if (!valid_alu_i(BPF_OP(code), imm)) {
 			emit_mov_i(ctx, MIPS_R_T6, imm);
 			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
@@ -1535,17 +1535,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst * src */
 	/* dst = dst / src */
 	/* dst = dst % src */
-	case BPF_ALU | BPF_AND | BPF_X:
-	case BPF_ALU | BPF_OR | BPF_X:
-	case BPF_ALU | BPF_XOR | BPF_X:
-	case BPF_ALU | BPF_LSH | BPF_X:
-	case BPF_ALU | BPF_RSH | BPF_X:
-	case BPF_ALU | BPF_ARSH | BPF_X:
-	case BPF_ALU | BPF_ADD | BPF_X:
-	case BPF_ALU | BPF_SUB | BPF_X:
-	case BPF_ALU | BPF_MUL | BPF_X:
-	case BPF_ALU | BPF_DIV | BPF_X:
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
 		emit_zext_ver(ctx, dst);
 		break;
@@ -1633,8 +1633,8 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		if (BPF_SRC(code) ==
 #ifdef __BIG_ENDIAN
 		    BPF_FROM_LE
@@ -1814,17 +1814,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* PC += off if dst >= src (signed) */
 	/* PC += off if dst < src (signed) */
 	/* PC += off if dst <= src (signed) */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 		if (off == 0)
 			break;
 		setup_jmp_r(ctx, dst == src, BPF_OP(code), off, &jmp, &rel);
@@ -1843,17 +1843,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* PC += off if dst >= imm (signed) */
 	/* PC += off if dst < imm (signed) */
 	/* PC += off if dst <= imm (signed) */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 		if (off == 0)
 			break;
 		setup_jmp_i(ctx, imm, 64, BPF_OP(code), off, &jmp, &rel);
@@ -1862,24 +1862,24 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			goto toofar;
 		break;
 	/* PC += off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		if (off == 0)
 			break;
 		if (emit_ja(ctx, off) < 0)
 			goto toofar;
 		break;
 	/* Tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_tail_call(ctx) < 0)
 			goto invalid;
 		break;
 	/* Function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 		if (emit_call(ctx, insn) < 0)
 			goto invalid;
 		break;
 	/* Function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		/*
 		 * Optimization: when last instruction is EXIT
 		 * simply continue to epilogue.
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 0e7c1bd..05416f4 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -643,12 +643,12 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 		emit_mov_i(ctx, dst, imm);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
@@ -658,7 +658,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		}
 		break;
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 		emit_sext(ctx, dst, dst);
 		emit_alu_i(ctx, dst, 0, BPF_NEG);
 		emit_zext_ver(ctx, dst);
@@ -667,10 +667,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst | imm */
 	/* dst = dst ^ imm */
 	/* dst = dst << imm */
-	case BPF_ALU | BPF_OR | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
 		if (!valid_alu_i(BPF_OP(code), imm)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
 			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
@@ -686,13 +686,13 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst * imm */
 	/* dst = dst / imm */
 	/* dst = dst % imm */
-	case BPF_ALU | BPF_RSH | BPF_K:
-	case BPF_ALU | BPF_ARSH | BPF_K:
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_MUL | BPF_K:
-	case BPF_ALU | BPF_DIV | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 		if (!valid_alu_i(BPF_OP(code), imm)) {
 			emit_sext(ctx, dst, dst);
 			emit_mov_i(ctx, MIPS_R_T4, imm);
@@ -707,10 +707,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst | src */
 	/* dst = dst ^ src */
 	/* dst = dst << src */
-	case BPF_ALU | BPF_AND | BPF_X:
-	case BPF_ALU | BPF_OR | BPF_X:
-	case BPF_ALU | BPF_XOR | BPF_X:
-	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
 		emit_alu_r(ctx, dst, src, BPF_OP(code));
 		emit_zext_ver(ctx, dst);
 		break;
@@ -721,13 +721,13 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst * src */
 	/* dst = dst / src */
 	/* dst = dst % src */
-	case BPF_ALU | BPF_RSH | BPF_X:
-	case BPF_ALU | BPF_ARSH | BPF_X:
-	case BPF_ALU | BPF_ADD | BPF_X:
-	case BPF_ALU | BPF_SUB | BPF_X:
-	case BPF_ALU | BPF_MUL | BPF_X:
-	case BPF_ALU | BPF_DIV | BPF_X:
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 		emit_sext(ctx, dst, dst);
 		emit_sext(ctx, MIPS_R_T4, src);
 		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
@@ -800,8 +800,8 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		if (BPF_SRC(code) ==
 #ifdef __BIG_ENDIAN
 		    BPF_FROM_LE
@@ -970,17 +970,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* PC += off if dst >= src (signed) */
 	/* PC += off if dst < src (signed) */
 	/* PC += off if dst <= src (signed) */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 		if (off == 0)
 			break;
 		setup_jmp_r(ctx, dst == src, BPF_OP(code), off, &jmp, &rel);
@@ -999,17 +999,17 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* PC += off if dst >= imm (signed) */
 	/* PC += off if dst < imm (signed) */
 	/* PC += off if dst <= imm (signed) */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 		if (off == 0)
 			break;
 		setup_jmp_i(ctx, imm, 64, BPF_OP(code), off, &jmp, &rel);
@@ -1024,24 +1024,24 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			goto toofar;
 		break;
 	/* PC += off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		if (off == 0)
 			break;
 		if (emit_ja(ctx, off) < 0)
 			goto toofar;
 		break;
 	/* Tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_tail_call(ctx) < 0)
 			goto invalid;
 		break;
 	/* Function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 		if (emit_call(ctx, insn) < 0)
 			goto invalid;
 		break;
 	/* Function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		/*
 		 * Optimization: when last instruction is EXIT
 		 * simply continue to epilogue.
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 43e6341..c26dd9f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -43,7 +43,7 @@ static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
 		 * ensure that the JITed instruction sequence for these calls
 		 * are of fixed length by padding them with NOPs.
 		 */
-		if (insn[i].code == (BPF_JMP | BPF_CALL) &&
+		if (insn[i].code == (BPF_JMP64 | BPF_CALL) &&
 		    insn[i].src_reg == BPF_PSEUDO_CALL) {
 			ret = bpf_jit_get_func_addr(fp, &insn[i], true,
 						    &func_addr,
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index a379b0c..3e7b9f1 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -327,24 +327,24 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
 		 */
-		case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
+		case BPF_ALU32 | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
 			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
 			EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, src_reg));
 			EMIT(PPC_RAW_ADDE(dst_reg_h, dst_reg_h, src_reg_h));
 			break;
-		case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
+		case BPF_ALU32 | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
 			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
 			EMIT(PPC_RAW_SUBFC(dst_reg, src_reg, dst_reg));
 			EMIT(PPC_RAW_SUBFE(dst_reg_h, src_reg_h, dst_reg_h));
 			break;
-		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
+		case BPF_ALU32 | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 			imm = -imm;
 			fallthrough;
-		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
+		case BPF_ALU32 | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
 			if (IMM_HA(imm) & 0xffff)
 				EMIT(PPC_RAW_ADDIS(dst_reg, dst_reg, IMM_HA(imm)));
 			if (IMM_L(imm))
@@ -377,10 +377,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, _R0));
 			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, tmp_reg));
 			break;
-		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
+		case BPF_ALU32 | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
 			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
+		case BPF_ALU32 | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
 			if (imm >= -32768 && imm < 32768) {
 				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, imm));
 			} else {
@@ -410,10 +410,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, tmp_reg));
 			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, _R0));
 			break;
-		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
+		case BPF_ALU32 | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
 			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
+		case BPF_ALU32 | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
 			EMIT(PPC_RAW_DIVWU(_R0, dst_reg, src_reg));
 			EMIT(PPC_RAW_MULW(_R0, src_reg, _R0));
 			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, _R0));
@@ -422,7 +422,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			return -EOPNOTSUPP;
 		case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
 			return -EOPNOTSUPP;
-		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
+		case BPF_ALU32 | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
 			if (!imm)
 				return -EINVAL;
 			if (imm == 1)
@@ -431,7 +431,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			PPC_LI32(_R0, imm);
 			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, _R0));
 			break;
-		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
+		case BPF_ALU32 | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
 			if (!imm)
 				return -EINVAL;
 
@@ -480,7 +480,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
 			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, imm));
 			break;
-		case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
+		case BPF_ALU32 | BPF_NEG: /* (u32) dst = -dst */
 			EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
 			break;
 		case BPF_ALU64 | BPF_NEG: /* dst = -dst */
@@ -495,14 +495,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
 			EMIT(PPC_RAW_AND(dst_reg_h, dst_reg_h, src_reg_h));
 			break;
-		case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
+		case BPF_ALU32 | BPF_AND | BPF_X: /* (u32) dst = dst & src */
 			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
 			if (imm >= 0)
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			fallthrough;
-		case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
+		case BPF_ALU32 | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
 			if (!IMM_H(imm)) {
 				EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
 			} else if (!IMM_L(imm)) {
@@ -519,7 +519,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
 			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, src_reg_h));
 			break;
-		case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
+		case BPF_ALU32 | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
@@ -527,7 +527,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm < 0)
 				EMIT(PPC_RAW_LI(dst_reg_h, -1));
 			fallthrough;
-		case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
+		case BPF_ALU32 | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
 			if (IMM_L(imm))
 				EMIT(PPC_RAW_ORI(dst_reg, dst_reg, IMM_L(imm)));
 			if (IMM_H(imm))
@@ -542,7 +542,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_XOR(dst_reg_h, dst_reg_h, src_reg_h));
 			}
 			break;
-		case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
+		case BPF_ALU32 | BPF_XOR | BPF_X: /* (u32) dst ^= src */
 			if (dst_reg == src_reg)
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 			else
@@ -552,13 +552,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm < 0)
 				EMIT(PPC_RAW_NOR(dst_reg_h, dst_reg_h, dst_reg_h));
 			fallthrough;
-		case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
+		case BPF_ALU32 | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
 			if (IMM_L(imm))
 				EMIT(PPC_RAW_XORI(dst_reg, dst_reg, IMM_L(imm)));
 			if (IMM_H(imm))
 				EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
 			break;
-		case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
+		case BPF_ALU32 | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
 			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
@@ -572,7 +572,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
 			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, tmp_reg));
 			break;
-		case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<= (u32) imm */
+		case BPF_ALU32 | BPF_LSH | BPF_K: /* (u32) dst <<= (u32) imm */
 			if (!imm)
 				break;
 			EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
@@ -594,7 +594,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			EMIT(PPC_RAW_LI(dst_reg, 0));
 			break;
-		case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
+		case BPF_ALU32 | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
 			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
@@ -608,7 +608,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_SRW(dst_reg_h, dst_reg_h, src_reg));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp_reg));
 			break;
-		case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
+		case BPF_ALU32 | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
 			if (!imm)
 				break;
 			EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
@@ -630,7 +630,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 			EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			break;
-		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
+		case BPF_ALU32 | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
 			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
@@ -646,7 +646,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_SLW(tmp_reg, tmp_reg, _R0));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp_reg));
 			break;
-		case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
+		case BPF_ALU32 | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
 			if (!imm)
 				break;
 			EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
@@ -678,7 +678,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_MR(dst_reg, src_reg));
 			EMIT(PPC_RAW_MR(dst_reg_h, src_reg_h));
 			break;
-		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
+		case BPF_ALU32 | BPF_MOV | BPF_X: /* (u32) dst = src */
 			/* special mov32 for zext */
 			if (imm == 1)
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
@@ -689,14 +689,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			PPC_LI32(dst_reg, imm);
 			PPC_EX32(dst_reg_h, imm);
 			break;
-		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
+		case BPF_ALU32 | BPF_MOV | BPF_K: /* (u32) dst = imm */
 			PPC_LI32(dst_reg, imm);
 			break;
 
 		/*
 		 * BPF_FROM_BE/LE
 		 */
-		case BPF_ALU | BPF_END | BPF_FROM_LE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 			switch (imm) {
 			case 16:
 				/* Copy 16 bits to upper part */
@@ -732,7 +732,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				break;
 			}
 			break;
-		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 			switch (imm) {
 			case 16:
 				/* zero-extend 16 bits into 32 bits */
@@ -969,7 +969,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Return/Exit
 		 */
-		case BPF_JMP | BPF_EXIT:
+		case BPF_JMP64 | BPF_EXIT:
 			/*
 			 * If this isn't the very last instruction, branch to
 			 * the epilogue. If we _are_ the last instruction,
@@ -986,7 +986,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Call kernel helper or bpf function
 		 */
-		case BPF_JMP | BPF_CALL:
+		case BPF_JMP64 | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
 
 			ret = bpf_jit_get_func_addr(fp, &insn[i], false,
@@ -1010,64 +1010,64 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Jumps and branches
 		 */
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			PPC_JMP(addrs[i + 1 + off]);
 			break;
 
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JSGT | BPF_K:
-		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JSGT | BPF_K:
+		case BPF_JMP64 | BPF_JSGT | BPF_X:
 		case BPF_JMP32 | BPF_JGT | BPF_K:
 		case BPF_JMP32 | BPF_JGT | BPF_X:
 		case BPF_JMP32 | BPF_JSGT | BPF_K:
 		case BPF_JMP32 | BPF_JSGT | BPF_X:
 			true_cond = COND_GT;
 			goto cond_branch;
-		case BPF_JMP | BPF_JLT | BPF_K:
-		case BPF_JMP | BPF_JLT | BPF_X:
-		case BPF_JMP | BPF_JSLT | BPF_K:
-		case BPF_JMP | BPF_JSLT | BPF_X:
+		case BPF_JMP64 | BPF_JLT | BPF_K:
+		case BPF_JMP64 | BPF_JLT | BPF_X:
+		case BPF_JMP64 | BPF_JSLT | BPF_K:
+		case BPF_JMP64 | BPF_JSLT | BPF_X:
 		case BPF_JMP32 | BPF_JLT | BPF_K:
 		case BPF_JMP32 | BPF_JLT | BPF_X:
 		case BPF_JMP32 | BPF_JSLT | BPF_K:
 		case BPF_JMP32 | BPF_JSLT | BPF_X:
 			true_cond = COND_LT;
 			goto cond_branch;
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JSGE | BPF_K:
-		case BPF_JMP | BPF_JSGE | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JSGE | BPF_K:
+		case BPF_JMP64 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JGE | BPF_K:
 		case BPF_JMP32 | BPF_JGE | BPF_X:
 		case BPF_JMP32 | BPF_JSGE | BPF_K:
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 			true_cond = COND_GE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JLE | BPF_K:
-		case BPF_JMP | BPF_JLE | BPF_X:
-		case BPF_JMP | BPF_JSLE | BPF_K:
-		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP64 | BPF_JLE | BPF_K:
+		case BPF_JMP64 | BPF_JLE | BPF_X:
+		case BPF_JMP64 | BPF_JSLE | BPF_K:
+		case BPF_JMP64 | BPF_JSLE | BPF_X:
 		case BPF_JMP32 | BPF_JLE | BPF_K:
 		case BPF_JMP32 | BPF_JLE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			true_cond = COND_LE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
 		case BPF_JMP32 | BPF_JEQ | BPF_K:
 		case BPF_JMP32 | BPF_JEQ | BPF_X:
 			true_cond = COND_EQ;
 			goto cond_branch;
-		case BPF_JMP | BPF_JNE | BPF_K:
-		case BPF_JMP | BPF_JNE | BPF_X:
+		case BPF_JMP64 | BPF_JNE | BPF_K:
+		case BPF_JMP64 | BPF_JNE | BPF_X:
 		case BPF_JMP32 | BPF_JNE | BPF_K:
 		case BPF_JMP32 | BPF_JNE | BPF_X:
 			true_cond = COND_NE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			true_cond = COND_NE;
@@ -1075,12 +1075,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 
 cond_branch:
 			switch (code) {
-			case BPF_JMP | BPF_JGT | BPF_X:
-			case BPF_JMP | BPF_JLT | BPF_X:
-			case BPF_JMP | BPF_JGE | BPF_X:
-			case BPF_JMP | BPF_JLE | BPF_X:
-			case BPF_JMP | BPF_JEQ | BPF_X:
-			case BPF_JMP | BPF_JNE | BPF_X:
+			case BPF_JMP64 | BPF_JGT | BPF_X:
+			case BPF_JMP64 | BPF_JLT | BPF_X:
+			case BPF_JMP64 | BPF_JGE | BPF_X:
+			case BPF_JMP64 | BPF_JLE | BPF_X:
+			case BPF_JMP64 | BPF_JEQ | BPF_X:
+			case BPF_JMP64 | BPF_JNE | BPF_X:
 				/* unsigned comparison */
 				EMIT(PPC_RAW_CMPLW(dst_reg_h, src_reg_h));
 				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
@@ -1095,10 +1095,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				/* unsigned comparison */
 				EMIT(PPC_RAW_CMPLW(dst_reg, src_reg));
 				break;
-			case BPF_JMP | BPF_JSGT | BPF_X:
-			case BPF_JMP | BPF_JSLT | BPF_X:
-			case BPF_JMP | BPF_JSGE | BPF_X:
-			case BPF_JMP | BPF_JSLE | BPF_X:
+			case BPF_JMP64 | BPF_JSGT | BPF_X:
+			case BPF_JMP64 | BPF_JSLT | BPF_X:
+			case BPF_JMP64 | BPF_JSGE | BPF_X:
+			case BPF_JMP64 | BPF_JSLE | BPF_X:
 				/* signed comparison */
 				EMIT(PPC_RAW_CMPW(dst_reg_h, src_reg_h));
 				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
@@ -1111,7 +1111,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				/* signed comparison */
 				EMIT(PPC_RAW_CMPW(dst_reg, src_reg));
 				break;
-			case BPF_JMP | BPF_JSET | BPF_X:
+			case BPF_JMP64 | BPF_JSET | BPF_X:
 				EMIT(PPC_RAW_AND_DOT(_R0, dst_reg_h, src_reg_h));
 				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
 				EMIT(PPC_RAW_AND_DOT(_R0, dst_reg, src_reg));
@@ -1119,12 +1119,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			case BPF_JMP32 | BPF_JSET | BPF_X: {
 				EMIT(PPC_RAW_AND_DOT(_R0, dst_reg, src_reg));
 				break;
-			case BPF_JMP | BPF_JNE | BPF_K:
-			case BPF_JMP | BPF_JEQ | BPF_K:
-			case BPF_JMP | BPF_JGT | BPF_K:
-			case BPF_JMP | BPF_JLT | BPF_K:
-			case BPF_JMP | BPF_JGE | BPF_K:
-			case BPF_JMP | BPF_JLE | BPF_K:
+			case BPF_JMP64 | BPF_JNE | BPF_K:
+			case BPF_JMP64 | BPF_JEQ | BPF_K:
+			case BPF_JMP64 | BPF_JGT | BPF_K:
+			case BPF_JMP64 | BPF_JLT | BPF_K:
+			case BPF_JMP64 | BPF_JGE | BPF_K:
+			case BPF_JMP64 | BPF_JLE | BPF_K:
 				/*
 				 * Need sign-extended load, so only positive
 				 * values can be used as imm in cmplwi
@@ -1156,10 +1156,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				}
 				break;
 			}
-			case BPF_JMP | BPF_JSGT | BPF_K:
-			case BPF_JMP | BPF_JSLT | BPF_K:
-			case BPF_JMP | BPF_JSGE | BPF_K:
-			case BPF_JMP | BPF_JSLE | BPF_K:
+			case BPF_JMP64 | BPF_JSGT | BPF_K:
+			case BPF_JMP64 | BPF_JSLT | BPF_K:
+			case BPF_JMP64 | BPF_JSGE | BPF_K:
+			case BPF_JMP64 | BPF_JSLE | BPF_K:
 				if (imm >= 0 && imm < 65536) {
 					EMIT(PPC_RAW_CMPWI(dst_reg_h, imm < 0 ? -1 : 0));
 					PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
@@ -1188,7 +1188,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 					EMIT(PPC_RAW_CMPW(dst_reg, _R0));
 				}
 				break;
-			case BPF_JMP | BPF_JSET | BPF_K:
+			case BPF_JMP64 | BPF_JSET | BPF_K:
 				/* andi does not sign-extend the immediate */
 				if (imm >= 0 && imm < 32768) {
 					/* PPC_ANDI is _only/always_ dot-form */
@@ -1219,7 +1219,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Tail call
 		 */
-		case BPF_JMP | BPF_TAIL_CALL:
+		case BPF_JMP64 | BPF_TAIL_CALL:
 			ctx->seen |= SEEN_TAILCALL;
 			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
 			if (ret < 0)
@@ -1235,7 +1235,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			pr_err_ratelimited("eBPF filter opcode %04x (@%d) unsupported\n", code, i);
 			return -EOPNOTSUPP;
 		}
-		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext &&
+		if (BPF_CLASS(code) == BPF_ALU32 && !fp->aux->verifier_zext &&
 		    !insn_is_zext(&insn[i + 1]) && !(BPF_OP(code) == BPF_END && imm == 64))
 			EMIT(PPC_RAW_LI(dst_reg_h, 0));
 	}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 29ee306..3b6ee90 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -396,15 +396,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
 		 */
-		case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
+		case BPF_ALU32 | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
 		case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
 			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
+		case BPF_ALU32 | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
 		case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
 			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
+		case BPF_ALU32 | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
 		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
 			if (!imm) {
 				goto bpf_alu32_trunc;
@@ -415,7 +415,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_ADD(dst_reg, dst_reg, tmp1_reg));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
+		case BPF_ALU32 | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
 			if (!imm) {
 				goto bpf_alu32_trunc;
@@ -426,27 +426,27 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
+		case BPF_ALU32 | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
 		case BPF_ALU64 | BPF_MUL | BPF_X: /* dst *= src */
-			if (BPF_CLASS(code) == BPF_ALU)
+			if (BPF_CLASS(code) == BPF_ALU32)
 				EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
 			else
 				EMIT(PPC_RAW_MULD(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
+		case BPF_ALU32 | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
 		case BPF_ALU64 | BPF_MUL | BPF_K: /* dst *= imm */
 			if (imm >= -32768 && imm < 32768)
 				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, IMM_L(imm)));
 			else {
 				PPC_LI32(tmp1_reg, imm);
-				if (BPF_CLASS(code) == BPF_ALU)
+				if (BPF_CLASS(code) == BPF_ALU32)
 					EMIT(PPC_RAW_MULW(dst_reg, dst_reg, tmp1_reg));
 				else
 					EMIT(PPC_RAW_MULD(dst_reg, dst_reg, tmp1_reg));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
-		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
+		case BPF_ALU32 | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
+		case BPF_ALU32 | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
 			if (BPF_OP(code) == BPF_MOD) {
 				EMIT(PPC_RAW_DIVWU(tmp1_reg, dst_reg, src_reg));
 				EMIT(PPC_RAW_MULW(tmp1_reg, src_reg, tmp1_reg));
@@ -463,8 +463,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			} else
 				EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
-		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
+		case BPF_ALU32 | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
+		case BPF_ALU32 | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
 		case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
 		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
 			if (imm == 0)
@@ -480,7 +480,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 
 			PPC_LI32(tmp1_reg, imm);
 			switch (BPF_CLASS(code)) {
-			case BPF_ALU:
+			case BPF_ALU32:
 				if (BPF_OP(code) == BPF_MOD) {
 					EMIT(PPC_RAW_DIVWU(tmp2_reg, dst_reg, tmp1_reg));
 					EMIT(PPC_RAW_MULW(tmp1_reg, tmp1_reg, tmp2_reg));
@@ -498,7 +498,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				break;
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
+		case BPF_ALU32 | BPF_NEG: /* (u32) dst = -dst */
 		case BPF_ALU64 | BPF_NEG: /* dst = -dst */
 			EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
 			goto bpf_alu32_trunc;
@@ -506,11 +506,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Logical operations: AND/OR/XOR/[A]LSH/[A]RSH
 		 */
-		case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
+		case BPF_ALU32 | BPF_AND | BPF_X: /* (u32) dst = dst & src */
 		case BPF_ALU64 | BPF_AND | BPF_X: /* dst = dst & src */
 			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
+		case BPF_ALU32 | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
 		case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
 			if (!IMM_H(imm))
 				EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
@@ -520,11 +520,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_AND(dst_reg, dst_reg, tmp1_reg));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
+		case BPF_ALU32 | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
 		case BPF_ALU64 | BPF_OR | BPF_X: /* dst = dst | src */
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
+		case BPF_ALU32 | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
 		case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
 			if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
 				/* Sign-extended */
@@ -537,11 +537,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 					EMIT(PPC_RAW_ORIS(dst_reg, dst_reg, IMM_H(imm)));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
+		case BPF_ALU32 | BPF_XOR | BPF_X: /* (u32) dst ^= src */
 		case BPF_ALU64 | BPF_XOR | BPF_X: /* dst ^= src */
 			EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
+		case BPF_ALU32 | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
 		case BPF_ALU64 | BPF_XOR | BPF_K: /* dst ^= imm */
 			if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
 				/* Sign-extended */
@@ -554,7 +554,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 					EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
 			}
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
+		case BPF_ALU32 | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
 			/* slw clears top 32 bits */
 			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
 			/* skip zero extension move, but set address map. */
@@ -564,7 +564,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
 			EMIT(PPC_RAW_SLD(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<== (u32) imm */
+		case BPF_ALU32 | BPF_LSH | BPF_K: /* (u32) dst <<== (u32) imm */
 			/* with imm 0, we still need to clear top 32 bits */
 			EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
 			if (insn_is_zext(&insn[i + 1]))
@@ -574,7 +574,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm != 0)
 				EMIT(PPC_RAW_SLDI(dst_reg, dst_reg, imm));
 			break;
-		case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
+		case BPF_ALU32 | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
 			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
 			if (insn_is_zext(&insn[i + 1]))
 				addrs[++i] = ctx->idx * 4;
@@ -582,7 +582,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
 			EMIT(PPC_RAW_SRD(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
+		case BPF_ALU32 | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
 			EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
 			if (insn_is_zext(&insn[i + 1]))
 				addrs[++i] = ctx->idx * 4;
@@ -591,13 +591,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm != 0)
 				EMIT(PPC_RAW_SRDI(dst_reg, dst_reg, imm));
 			break;
-		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
+		case BPF_ALU32 | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
 			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
 		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
 			EMIT(PPC_RAW_SRAD(dst_reg, dst_reg, src_reg));
 			break;
-		case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
+		case BPF_ALU32 | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
 			EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
 			goto bpf_alu32_trunc;
 		case BPF_ALU64 | BPF_ARSH | BPF_K: /* (s64) dst >>= imm */
@@ -608,7 +608,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * MOV
 		 */
-		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
+		case BPF_ALU32 | BPF_MOV | BPF_X: /* (u32) dst = src */
 		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
 			if (imm == 1) {
 				/* special mov32 for zext */
@@ -617,7 +617,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			}
 			EMIT(PPC_RAW_MR(dst_reg, src_reg));
 			goto bpf_alu32_trunc;
-		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
+		case BPF_ALU32 | BPF_MOV | BPF_K: /* (u32) dst = imm */
 		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
 			PPC_LI32(dst_reg, imm);
 			if (imm < 0)
@@ -628,15 +628,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 
 bpf_alu32_trunc:
 		/* Truncate to 32-bits */
-		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext)
+		if (BPF_CLASS(code) == BPF_ALU32 && !fp->aux->verifier_zext)
 			EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
 		break;
 
 		/*
 		 * BPF_FROM_BE/LE
 		 */
-		case BPF_ALU | BPF_END | BPF_FROM_LE:
-		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_LE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 #ifdef __BIG_ENDIAN__
 			if (BPF_SRC(code) == BPF_FROM_BE)
 				goto emit_clear;
@@ -947,7 +947,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Return/Exit
 		 */
-		case BPF_JMP | BPF_EXIT:
+		case BPF_JMP64 | BPF_EXIT:
 			/*
 			 * If this isn't the very last instruction, branch to
 			 * the epilogue. If we _are_ the last instruction,
@@ -964,7 +964,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Call kernel helper or bpf function
 		 */
-		case BPF_JMP | BPF_CALL:
+		case BPF_JMP64 | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
 
 			ret = bpf_jit_get_func_addr(fp, &insn[i], false,
@@ -987,64 +987,64 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Jumps and branches
 		 */
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			PPC_JMP(addrs[i + 1 + off]);
 			break;
 
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JSGT | BPF_K:
-		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JSGT | BPF_K:
+		case BPF_JMP64 | BPF_JSGT | BPF_X:
 		case BPF_JMP32 | BPF_JGT | BPF_K:
 		case BPF_JMP32 | BPF_JGT | BPF_X:
 		case BPF_JMP32 | BPF_JSGT | BPF_K:
 		case BPF_JMP32 | BPF_JSGT | BPF_X:
 			true_cond = COND_GT;
 			goto cond_branch;
-		case BPF_JMP | BPF_JLT | BPF_K:
-		case BPF_JMP | BPF_JLT | BPF_X:
-		case BPF_JMP | BPF_JSLT | BPF_K:
-		case BPF_JMP | BPF_JSLT | BPF_X:
+		case BPF_JMP64 | BPF_JLT | BPF_K:
+		case BPF_JMP64 | BPF_JLT | BPF_X:
+		case BPF_JMP64 | BPF_JSLT | BPF_K:
+		case BPF_JMP64 | BPF_JSLT | BPF_X:
 		case BPF_JMP32 | BPF_JLT | BPF_K:
 		case BPF_JMP32 | BPF_JLT | BPF_X:
 		case BPF_JMP32 | BPF_JSLT | BPF_K:
 		case BPF_JMP32 | BPF_JSLT | BPF_X:
 			true_cond = COND_LT;
 			goto cond_branch;
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JSGE | BPF_K:
-		case BPF_JMP | BPF_JSGE | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JSGE | BPF_K:
+		case BPF_JMP64 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JGE | BPF_K:
 		case BPF_JMP32 | BPF_JGE | BPF_X:
 		case BPF_JMP32 | BPF_JSGE | BPF_K:
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 			true_cond = COND_GE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JLE | BPF_K:
-		case BPF_JMP | BPF_JLE | BPF_X:
-		case BPF_JMP | BPF_JSLE | BPF_K:
-		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP64 | BPF_JLE | BPF_K:
+		case BPF_JMP64 | BPF_JLE | BPF_X:
+		case BPF_JMP64 | BPF_JSLE | BPF_K:
+		case BPF_JMP64 | BPF_JSLE | BPF_X:
 		case BPF_JMP32 | BPF_JLE | BPF_K:
 		case BPF_JMP32 | BPF_JLE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			true_cond = COND_LE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
 		case BPF_JMP32 | BPF_JEQ | BPF_K:
 		case BPF_JMP32 | BPF_JEQ | BPF_X:
 			true_cond = COND_EQ;
 			goto cond_branch;
-		case BPF_JMP | BPF_JNE | BPF_K:
-		case BPF_JMP | BPF_JNE | BPF_X:
+		case BPF_JMP64 | BPF_JNE | BPF_K:
+		case BPF_JMP64 | BPF_JNE | BPF_X:
 		case BPF_JMP32 | BPF_JNE | BPF_K:
 		case BPF_JMP32 | BPF_JNE | BPF_X:
 			true_cond = COND_NE;
 			goto cond_branch;
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			true_cond = COND_NE;
@@ -1052,12 +1052,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 
 cond_branch:
 			switch (code) {
-			case BPF_JMP | BPF_JGT | BPF_X:
-			case BPF_JMP | BPF_JLT | BPF_X:
-			case BPF_JMP | BPF_JGE | BPF_X:
-			case BPF_JMP | BPF_JLE | BPF_X:
-			case BPF_JMP | BPF_JEQ | BPF_X:
-			case BPF_JMP | BPF_JNE | BPF_X:
+			case BPF_JMP64 | BPF_JGT | BPF_X:
+			case BPF_JMP64 | BPF_JLT | BPF_X:
+			case BPF_JMP64 | BPF_JGE | BPF_X:
+			case BPF_JMP64 | BPF_JLE | BPF_X:
+			case BPF_JMP64 | BPF_JEQ | BPF_X:
+			case BPF_JMP64 | BPF_JNE | BPF_X:
 			case BPF_JMP32 | BPF_JGT | BPF_X:
 			case BPF_JMP32 | BPF_JLT | BPF_X:
 			case BPF_JMP32 | BPF_JGE | BPF_X:
@@ -1070,10 +1070,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				else
 					EMIT(PPC_RAW_CMPLD(dst_reg, src_reg));
 				break;
-			case BPF_JMP | BPF_JSGT | BPF_X:
-			case BPF_JMP | BPF_JSLT | BPF_X:
-			case BPF_JMP | BPF_JSGE | BPF_X:
-			case BPF_JMP | BPF_JSLE | BPF_X:
+			case BPF_JMP64 | BPF_JSGT | BPF_X:
+			case BPF_JMP64 | BPF_JSLT | BPF_X:
+			case BPF_JMP64 | BPF_JSGE | BPF_X:
+			case BPF_JMP64 | BPF_JSLE | BPF_X:
 			case BPF_JMP32 | BPF_JSGT | BPF_X:
 			case BPF_JMP32 | BPF_JSLT | BPF_X:
 			case BPF_JMP32 | BPF_JSGE | BPF_X:
@@ -1084,21 +1084,21 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				else
 					EMIT(PPC_RAW_CMPD(dst_reg, src_reg));
 				break;
-			case BPF_JMP | BPF_JSET | BPF_X:
+			case BPF_JMP64 | BPF_JSET | BPF_X:
 			case BPF_JMP32 | BPF_JSET | BPF_X:
-				if (BPF_CLASS(code) == BPF_JMP) {
+				if (BPF_CLASS(code) == BPF_JMP64) {
 					EMIT(PPC_RAW_AND_DOT(tmp1_reg, dst_reg, src_reg));
 				} else {
 					EMIT(PPC_RAW_AND(tmp1_reg, dst_reg, src_reg));
 					EMIT(PPC_RAW_RLWINM_DOT(tmp1_reg, tmp1_reg, 0, 0, 31));
 				}
 				break;
-			case BPF_JMP | BPF_JNE | BPF_K:
-			case BPF_JMP | BPF_JEQ | BPF_K:
-			case BPF_JMP | BPF_JGT | BPF_K:
-			case BPF_JMP | BPF_JLT | BPF_K:
-			case BPF_JMP | BPF_JGE | BPF_K:
-			case BPF_JMP | BPF_JLE | BPF_K:
+			case BPF_JMP64 | BPF_JNE | BPF_K:
+			case BPF_JMP64 | BPF_JEQ | BPF_K:
+			case BPF_JMP64 | BPF_JGT | BPF_K:
+			case BPF_JMP64 | BPF_JLT | BPF_K:
+			case BPF_JMP64 | BPF_JGE | BPF_K:
+			case BPF_JMP64 | BPF_JLE | BPF_K:
 			case BPF_JMP32 | BPF_JNE | BPF_K:
 			case BPF_JMP32 | BPF_JEQ | BPF_K:
 			case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -1128,10 +1128,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				}
 				break;
 			}
-			case BPF_JMP | BPF_JSGT | BPF_K:
-			case BPF_JMP | BPF_JSLT | BPF_K:
-			case BPF_JMP | BPF_JSGE | BPF_K:
-			case BPF_JMP | BPF_JSLE | BPF_K:
+			case BPF_JMP64 | BPF_JSGT | BPF_K:
+			case BPF_JMP64 | BPF_JSLT | BPF_K:
+			case BPF_JMP64 | BPF_JSGE | BPF_K:
+			case BPF_JMP64 | BPF_JSLE | BPF_K:
 			case BPF_JMP32 | BPF_JSGT | BPF_K:
 			case BPF_JMP32 | BPF_JSLT | BPF_K:
 			case BPF_JMP32 | BPF_JSGE | BPF_K:
@@ -1157,7 +1157,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				}
 				break;
 			}
-			case BPF_JMP | BPF_JSET | BPF_K:
+			case BPF_JMP64 | BPF_JSET | BPF_K:
 			case BPF_JMP32 | BPF_JSET | BPF_K:
 				/* andi does not sign-extend the immediate */
 				if (imm >= 0 && imm < 32768)
@@ -1165,7 +1165,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 					EMIT(PPC_RAW_ANDI(tmp1_reg, dst_reg, imm));
 				else {
 					PPC_LI32(tmp1_reg, imm);
-					if (BPF_CLASS(code) == BPF_JMP) {
+					if (BPF_CLASS(code) == BPF_JMP64) {
 						EMIT(PPC_RAW_AND_DOT(tmp1_reg, dst_reg,
 								     tmp1_reg));
 					} else {
@@ -1182,7 +1182,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		/*
 		 * Tail call
 		 */
-		case BPF_JMP | BPF_TAIL_CALL:
+		case BPF_JMP64 | BPF_TAIL_CALL:
 			ctx->seen |= SEEN_TAILCALL;
 			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
 			if (ret < 0)
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 529a83b..b8674ba 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -955,7 +955,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		      bool extra_pass)
 {
 	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64 ||
-		BPF_CLASS(insn->code) == BPF_JMP;
+		BPF_CLASS(insn->code) == BPF_JMP64;
 	int s, e, rvoff, i = insn - ctx->prog->insnsi;
 	u8 code = insn->code;
 	s16 off = insn->off;
@@ -1012,7 +1012,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_alu_i64(dst, imm, ctx, BPF_OP(code));
 		break;
 
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext. */
 			emit_zext64(dst, ctx);
@@ -1020,24 +1020,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		}
 		fallthrough;
 
-	case BPF_ALU | BPF_ADD | BPF_X:
-	case BPF_ALU | BPF_SUB | BPF_X:
-	case BPF_ALU | BPF_AND | BPF_X:
-	case BPF_ALU | BPF_OR | BPF_X:
-	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
 
-	case BPF_ALU | BPF_MUL | BPF_X:
-	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
 
-	case BPF_ALU | BPF_DIV | BPF_X:
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
 
-	case BPF_ALU | BPF_MOD | BPF_X:
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 
-	case BPF_ALU | BPF_LSH | BPF_X:
-	case BPF_ALU | BPF_RSH | BPF_X:
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 		if (BPF_SRC(code) == BPF_K) {
 			emit_imm32(tmp2, imm, ctx);
 			src = tmp2;
@@ -1045,15 +1045,15 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_alu_r32(dst, src, ctx, BPF_OP(code));
 		break;
 
-	case BPF_ALU | BPF_MOV | BPF_K:
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_OR | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_LSH | BPF_K:
-	case BPF_ALU | BPF_RSH | BPF_K:
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 		/*
 		 * mul,div,mod are handled in the BPF_X case since there are
 		 * no RISC-V I-type equivalents.
@@ -1061,7 +1061,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_alu_i32(dst, imm, ctx, BPF_OP(code));
 		break;
 
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 		/*
 		 * src is ignored---choose tmp2 as a dummy register since it
 		 * is not on the stack.
@@ -1069,7 +1069,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
 		break;
 
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 	{
 		const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
 
@@ -1094,7 +1094,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	}
 
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 	{
 		const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
 
@@ -1128,12 +1128,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	}
 
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		rvoff = rv_offset(i, off, ctx);
 		emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
 		break;
 
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		bool fixed;
 		int ret;
@@ -1147,63 +1147,63 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	}
 
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(i, ctx))
 			return -1;
 		break;
 
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
 
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
 	case BPF_JMP32 | BPF_JNE | BPF_X:
 	case BPF_JMP32 | BPF_JNE | BPF_K:
 
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
 	case BPF_JMP32 | BPF_JLE | BPF_X:
 	case BPF_JMP32 | BPF_JLE | BPF_K:
 
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
 	case BPF_JMP32 | BPF_JLT | BPF_X:
 	case BPF_JMP32 | BPF_JLT | BPF_K:
 
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
 	case BPF_JMP32 | BPF_JGE | BPF_X:
 	case BPF_JMP32 | BPF_JGE | BPF_K:
 
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
 
-	case BPF_JMP | BPF_JSLE | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_X:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSLT | BPF_X:
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
 
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_X:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
 	case BPF_JMP32 | BPF_JSGT | BPF_X:
 	case BPF_JMP32 | BPF_JSGT | BPF_K:
 
-	case BPF_JMP | BPF_JSET | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_X:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
@@ -1221,7 +1221,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_branch_r32(dst, src, rvoff, ctx, BPF_OP(code));
 		break;
 
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		if (i == ctx->prog->len - 1)
 			break;
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f2417ac..5c1b9b0 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -381,17 +381,17 @@ static void init_regs(u8 *rd, u8 *rs, const struct bpf_insn *insn,
 	u8 code = insn->code;
 
 	switch (code) {
-	case BPF_JMP | BPF_JA:
-	case BPF_JMP | BPF_CALL:
-	case BPF_JMP | BPF_EXIT:
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_JA:
+	case BPF_JMP64 | BPF_CALL:
+	case BPF_JMP64 | BPF_EXIT:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		break;
 	default:
 		*rd = bpf_to_rv_reg(insn->dst_reg, ctx);
 	}
 
-	if (code & (BPF_ALU | BPF_X) || code & (BPF_ALU64 | BPF_X) ||
-	    code & (BPF_JMP | BPF_X) || code & (BPF_JMP32 | BPF_X) ||
+	if (code & (BPF_ALU32 | BPF_X) || code & (BPF_ALU64 | BPF_X) ||
+	    code & (BPF_JMP64 | BPF_X) || code & (BPF_JMP32 | BPF_X) ||
 	    code & BPF_LDX || code & BPF_STX)
 		*rs = bpf_to_rv_reg(insn->src_reg, ctx);
 }
@@ -626,7 +626,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		      bool extra_pass)
 {
 	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64 ||
-		    BPF_CLASS(insn->code) == BPF_JMP;
+		    BPF_CLASS(insn->code) == BPF_JMP64;
 	int s, e, rvoff, ret, i = insn - ctx->prog->insnsi;
 	struct bpf_prog_aux *aux = ctx->prog->aux;
 	u8 rd = -1, rs = -1, code = insn->code;
@@ -637,7 +637,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	switch (code) {
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext */
@@ -650,13 +650,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* dst = dst OP src */
-	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_add(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
 		if (is64)
 			emit_sub(rd, rd, rs, ctx);
@@ -666,55 +666,55 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit_and(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit_or(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit_xor(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU32 | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit(is64 ? rv_sll(rd, rd, rs) : rv_sllw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit(is64 ? rv_srl(rd, rd, rs) : rv_srlw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
 		emit(is64 ? rv_sra(rd, rd, rs) : rv_sraw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
@@ -722,7 +722,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
 		emit_sub(rd, RV_REG_ZERO, rd, ctx);
 		if (!is64 && !aux->verifier_zext)
@@ -730,7 +730,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* dst = BSWAP##imm(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16:
 			emit_slli(rd, rd, 48, ctx);
@@ -746,7 +746,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		}
 		break;
 
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		emit_li(RV_REG_T2, 0, ctx);
 
 		emit_andi(RV_REG_T1, rd, 0xff, ctx);
@@ -795,7 +795,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_imm(rd, imm, ctx);
 		if (!is64 && !aux->verifier_zext)
@@ -803,7 +803,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* dst = dst OP imm */
-	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 		if (is_12b_int(imm)) {
 			emit_addi(rd, rd, imm, ctx);
@@ -814,7 +814,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		if (is_12b_int(-imm)) {
 			emit_addi(rd, rd, -imm, ctx);
@@ -825,7 +825,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
 		if (is_12b_int(imm)) {
 			emit_andi(rd, rd, imm, ctx);
@@ -836,7 +836,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
 		if (is_12b_int(imm)) {
 			emit(rv_ori(rd, rd, imm), ctx);
@@ -847,7 +847,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
 		if (is_12b_int(imm)) {
 			emit(rv_xori(rd, rd, imm), ctx);
@@ -858,7 +858,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
@@ -866,7 +866,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
@@ -874,7 +874,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
@@ -882,14 +882,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit_slli(rd, rd, imm, ctx);
 
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		if (is64)
 			emit_srli(rd, rd, imm, ctx);
@@ -899,7 +899,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		if (is64)
 			emit_srai(rd, rd, imm, ctx);
@@ -911,7 +911,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* JUMP off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		rvoff = rv_offset(i, off, ctx);
 		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
 		if (ret)
@@ -919,27 +919,27 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* IF (dst COND src) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
 	case BPF_JMP32 | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
 	case BPF_JMP32 | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
 	case BPF_JMP32 | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
 	case BPF_JMP32 | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
 	case BPF_JMP32 | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
 	case BPF_JMP32 | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
 	case BPF_JMP32 | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
 	case BPF_JMP32 | BPF_JSLE | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X:
 	case BPF_JMP32 | BPF_JSET | BPF_X:
 		rvoff = rv_offset(i, off, ctx);
 		if (!is64) {
@@ -966,25 +966,25 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* IF (dst COND imm) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
 	case BPF_JMP32 | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
 	case BPF_JMP32 | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
 	case BPF_JMP32 | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
 	case BPF_JMP32 | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
 	case BPF_JMP32 | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
 		s = ctx->ninsns;
@@ -1008,7 +1008,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
 		break;
 
-	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
 		s = ctx->ninsns;
@@ -1030,7 +1030,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 
 	/* function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		bool fixed;
 		u64 addr;
@@ -1046,13 +1046,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	}
 	/* tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(i, ctx))
 			return -1;
 		break;
 
 	/* function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		if (i == ctx->prog->len - 1)
 			break;
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d0846ba..d6bff91 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -795,7 +795,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_MOV
 	 */
-	case BPF_ALU | BPF_MOV | BPF_X: /* dst = (u32) src */
+	case BPF_ALU32 | BPF_MOV | BPF_X: /* dst = (u32) src */
 		/* llgfr %dst,%src */
 		EMIT4(0xb9160000, dst_reg, src_reg);
 		if (insn_is_zext(&insn[1]))
@@ -805,7 +805,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* lgr %dst,%src */
 		EMIT4(0xb9040000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_MOV | BPF_K: /* dst = (u32) imm */
+	case BPF_ALU32 | BPF_MOV | BPF_K: /* dst = (u32) imm */
 		/* llilf %dst,imm */
 		EMIT6_IMM(0xc00f0000, dst_reg, imm);
 		if (insn_is_zext(&insn[1]))
@@ -832,7 +832,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_ADD
 	 */
-	case BPF_ALU | BPF_ADD | BPF_X: /* dst = (u32) dst + (u32) src */
+	case BPF_ALU32 | BPF_ADD | BPF_X: /* dst = (u32) dst + (u32) src */
 		/* ar %dst,%src */
 		EMIT2(0x1a00, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -841,7 +841,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* agr %dst,%src */
 		EMIT4(0xb9080000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_ADD | BPF_K: /* dst = (u32) dst + (u32) imm */
+	case BPF_ALU32 | BPF_ADD | BPF_K: /* dst = (u32) dst + (u32) imm */
 		if (imm != 0) {
 			/* alfi %dst,imm */
 			EMIT6_IMM(0xc20b0000, dst_reg, imm);
@@ -857,7 +857,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_SUB
 	 */
-	case BPF_ALU | BPF_SUB | BPF_X: /* dst = (u32) dst - (u32) src */
+	case BPF_ALU32 | BPF_SUB | BPF_X: /* dst = (u32) dst - (u32) src */
 		/* sr %dst,%src */
 		EMIT2(0x1b00, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -866,7 +866,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* sgr %dst,%src */
 		EMIT4(0xb9090000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_SUB | BPF_K: /* dst = (u32) dst - (u32) imm */
+	case BPF_ALU32 | BPF_SUB | BPF_K: /* dst = (u32) dst - (u32) imm */
 		if (imm != 0) {
 			/* alfi %dst,-imm */
 			EMIT6_IMM(0xc20b0000, dst_reg, -imm);
@@ -887,7 +887,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_MUL
 	 */
-	case BPF_ALU | BPF_MUL | BPF_X: /* dst = (u32) dst * (u32) src */
+	case BPF_ALU32 | BPF_MUL | BPF_X: /* dst = (u32) dst * (u32) src */
 		/* msr %dst,%src */
 		EMIT4(0xb2520000, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -896,7 +896,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* msgr %dst,%src */
 		EMIT4(0xb90c0000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_MUL | BPF_K: /* dst = (u32) dst * (u32) imm */
+	case BPF_ALU32 | BPF_MUL | BPF_K: /* dst = (u32) dst * (u32) imm */
 		if (imm != 1) {
 			/* msfi %r5,imm */
 			EMIT6_IMM(0xc2010000, dst_reg, imm);
@@ -912,8 +912,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_DIV / BPF_MOD
 	 */
-	case BPF_ALU | BPF_DIV | BPF_X: /* dst = (u32) dst / (u32) src */
-	case BPF_ALU | BPF_MOD | BPF_X: /* dst = (u32) dst % (u32) src */
+	case BPF_ALU32 | BPF_DIV | BPF_X: /* dst = (u32) dst / (u32) src */
+	case BPF_ALU32 | BPF_MOD | BPF_X: /* dst = (u32) dst % (u32) src */
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
@@ -944,8 +944,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9040000, dst_reg, rc_reg);
 		break;
 	}
-	case BPF_ALU | BPF_DIV | BPF_K: /* dst = (u32) dst / (u32) imm */
-	case BPF_ALU | BPF_MOD | BPF_K: /* dst = (u32) dst % (u32) imm */
+	case BPF_ALU32 | BPF_DIV | BPF_K: /* dst = (u32) dst / (u32) imm */
+	case BPF_ALU32 | BPF_MOD | BPF_K: /* dst = (u32) dst % (u32) imm */
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
@@ -1013,7 +1013,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_AND
 	 */
-	case BPF_ALU | BPF_AND | BPF_X: /* dst = (u32) dst & (u32) src */
+	case BPF_ALU32 | BPF_AND | BPF_X: /* dst = (u32) dst & (u32) src */
 		/* nr %dst,%src */
 		EMIT2(0x1400, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -1022,7 +1022,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* ngr %dst,%src */
 		EMIT4(0xb9800000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_AND | BPF_K: /* dst = (u32) dst & (u32) imm */
+	case BPF_ALU32 | BPF_AND | BPF_K: /* dst = (u32) dst & (u32) imm */
 		/* nilf %dst,imm */
 		EMIT6_IMM(0xc00b0000, dst_reg, imm);
 		EMIT_ZERO(dst_reg);
@@ -1045,7 +1045,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_OR
 	 */
-	case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
+	case BPF_ALU32 | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
 		/* or %dst,%src */
 		EMIT2(0x1600, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -1054,7 +1054,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* ogr %dst,%src */
 		EMIT4(0xb9810000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_OR | BPF_K: /* dst = (u32) dst | (u32) imm */
+	case BPF_ALU32 | BPF_OR | BPF_K: /* dst = (u32) dst | (u32) imm */
 		/* oilf %dst,imm */
 		EMIT6_IMM(0xc00d0000, dst_reg, imm);
 		EMIT_ZERO(dst_reg);
@@ -1077,7 +1077,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_XOR
 	 */
-	case BPF_ALU | BPF_XOR | BPF_X: /* dst = (u32) dst ^ (u32) src */
+	case BPF_ALU32 | BPF_XOR | BPF_X: /* dst = (u32) dst ^ (u32) src */
 		/* xr %dst,%src */
 		EMIT2(0x1700, dst_reg, src_reg);
 		EMIT_ZERO(dst_reg);
@@ -1086,7 +1086,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* xgr %dst,%src */
 		EMIT4(0xb9820000, dst_reg, src_reg);
 		break;
-	case BPF_ALU | BPF_XOR | BPF_K: /* dst = (u32) dst ^ (u32) imm */
+	case BPF_ALU32 | BPF_XOR | BPF_K: /* dst = (u32) dst ^ (u32) imm */
 		if (imm != 0) {
 			/* xilf %dst,imm */
 			EMIT6_IMM(0xc0070000, dst_reg, imm);
@@ -1111,7 +1111,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_LSH
 	 */
-	case BPF_ALU | BPF_LSH | BPF_X: /* dst = (u32) dst << (u32) src */
+	case BPF_ALU32 | BPF_LSH | BPF_X: /* dst = (u32) dst << (u32) src */
 		/* sll %dst,0(%src) */
 		EMIT4_DISP(0x89000000, dst_reg, src_reg, 0);
 		EMIT_ZERO(dst_reg);
@@ -1120,7 +1120,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* sllg %dst,%dst,0(%src) */
 		EMIT6_DISP_LH(0xeb000000, 0x000d, dst_reg, dst_reg, src_reg, 0);
 		break;
-	case BPF_ALU | BPF_LSH | BPF_K: /* dst = (u32) dst << (u32) imm */
+	case BPF_ALU32 | BPF_LSH | BPF_K: /* dst = (u32) dst << (u32) imm */
 		if (imm != 0) {
 			/* sll %dst,imm(%r0) */
 			EMIT4_DISP(0x89000000, dst_reg, REG_0, imm);
@@ -1136,7 +1136,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_RSH
 	 */
-	case BPF_ALU | BPF_RSH | BPF_X: /* dst = (u32) dst >> (u32) src */
+	case BPF_ALU32 | BPF_RSH | BPF_X: /* dst = (u32) dst >> (u32) src */
 		/* srl %dst,0(%src) */
 		EMIT4_DISP(0x88000000, dst_reg, src_reg, 0);
 		EMIT_ZERO(dst_reg);
@@ -1145,7 +1145,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* srlg %dst,%dst,0(%src) */
 		EMIT6_DISP_LH(0xeb000000, 0x000c, dst_reg, dst_reg, src_reg, 0);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_K: /* dst = (u32) dst >> (u32) imm */
+	case BPF_ALU32 | BPF_RSH | BPF_K: /* dst = (u32) dst >> (u32) imm */
 		if (imm != 0) {
 			/* srl %dst,imm(%r0) */
 			EMIT4_DISP(0x88000000, dst_reg, REG_0, imm);
@@ -1161,7 +1161,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_ARSH
 	 */
-	case BPF_ALU | BPF_ARSH | BPF_X: /* ((s32) dst) >>= src */
+	case BPF_ALU32 | BPF_ARSH | BPF_X: /* ((s32) dst) >>= src */
 		/* sra %dst,%dst,0(%src) */
 		EMIT4_DISP(0x8a000000, dst_reg, src_reg, 0);
 		EMIT_ZERO(dst_reg);
@@ -1170,7 +1170,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* srag %dst,%dst,0(%src) */
 		EMIT6_DISP_LH(0xeb000000, 0x000a, dst_reg, dst_reg, src_reg, 0);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_K: /* ((s32) dst >> imm */
+	case BPF_ALU32 | BPF_ARSH | BPF_K: /* ((s32) dst >> imm */
 		if (imm != 0) {
 			/* sra %dst,imm(%r0) */
 			EMIT4_DISP(0x8a000000, dst_reg, REG_0, imm);
@@ -1186,7 +1186,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_NEG
 	 */
-	case BPF_ALU | BPF_NEG: /* dst = (u32) -dst */
+	case BPF_ALU32 | BPF_NEG: /* dst = (u32) -dst */
 		/* lcr %dst,%dst */
 		EMIT2(0x1300, dst_reg, dst_reg);
 		EMIT_ZERO(dst_reg);
@@ -1198,7 +1198,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_FROM_BE/LE
 	 */
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		/* s390 is big endian, therefore only clear high order bytes */
 		switch (imm) {
 		case 16: /* dst = (u16) cpu_to_be16(dst) */
@@ -1216,7 +1216,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			break;
 		}
 		break;
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16: /* dst = (u16) cpu_to_le16(dst) */
 			/* lrvr %dst,%dst */
@@ -1397,9 +1397,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg, REG_0, off);
 		break;
 	/*
-	 * BPF_JMP / CALL
+	 * BPF_JMP64 / CALL
 	 */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		const struct btf_func_model *m;
 		bool func_addr_fixed;
@@ -1449,7 +1449,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 		break;
 	}
-	case BPF_JMP | BPF_TAIL_CALL: {
+	case BPF_JMP64 | BPF_TAIL_CALL: {
 		int patch_1_clrj, patch_2_clij, patch_3_brc;
 
 		/*
@@ -1539,7 +1539,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		break;
 	}
-	case BPF_JMP | BPF_EXIT: /* return b0 */
+	case BPF_JMP64 | BPF_EXIT: /* return b0 */
 		last = (i == fp->len - 1) ? 1 : 0;
 		if (last)
 			break;
@@ -1570,50 +1570,50 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 * instruction itself (loop) and for BPF with offset 0 we
 	 * branch to the instruction behind the branch.
 	 */
-	case BPF_JMP | BPF_JA: /* if (true) */
+	case BPF_JMP64 | BPF_JA: /* if (true) */
 		mask = 0xf000; /* j */
 		goto branch_oc;
-	case BPF_JMP | BPF_JSGT | BPF_K: /* ((s64) dst > (s64) imm) */
+	case BPF_JMP64 | BPF_JSGT | BPF_K: /* ((s64) dst > (s64) imm) */
 	case BPF_JMP32 | BPF_JSGT | BPF_K: /* ((s32) dst > (s32) imm) */
 		mask = 0x2000; /* jh */
 		goto branch_ks;
-	case BPF_JMP | BPF_JSLT | BPF_K: /* ((s64) dst < (s64) imm) */
+	case BPF_JMP64 | BPF_JSLT | BPF_K: /* ((s64) dst < (s64) imm) */
 	case BPF_JMP32 | BPF_JSLT | BPF_K: /* ((s32) dst < (s32) imm) */
 		mask = 0x4000; /* jl */
 		goto branch_ks;
-	case BPF_JMP | BPF_JSGE | BPF_K: /* ((s64) dst >= (s64) imm) */
+	case BPF_JMP64 | BPF_JSGE | BPF_K: /* ((s64) dst >= (s64) imm) */
 	case BPF_JMP32 | BPF_JSGE | BPF_K: /* ((s32) dst >= (s32) imm) */
 		mask = 0xa000; /* jhe */
 		goto branch_ks;
-	case BPF_JMP | BPF_JSLE | BPF_K: /* ((s64) dst <= (s64) imm) */
+	case BPF_JMP64 | BPF_JSLE | BPF_K: /* ((s64) dst <= (s64) imm) */
 	case BPF_JMP32 | BPF_JSLE | BPF_K: /* ((s32) dst <= (s32) imm) */
 		mask = 0xc000; /* jle */
 		goto branch_ks;
-	case BPF_JMP | BPF_JGT | BPF_K: /* (dst_reg > imm) */
+	case BPF_JMP64 | BPF_JGT | BPF_K: /* (dst_reg > imm) */
 	case BPF_JMP32 | BPF_JGT | BPF_K: /* ((u32) dst_reg > (u32) imm) */
 		mask = 0x2000; /* jh */
 		goto branch_ku;
-	case BPF_JMP | BPF_JLT | BPF_K: /* (dst_reg < imm) */
+	case BPF_JMP64 | BPF_JLT | BPF_K: /* (dst_reg < imm) */
 	case BPF_JMP32 | BPF_JLT | BPF_K: /* ((u32) dst_reg < (u32) imm) */
 		mask = 0x4000; /* jl */
 		goto branch_ku;
-	case BPF_JMP | BPF_JGE | BPF_K: /* (dst_reg >= imm) */
+	case BPF_JMP64 | BPF_JGE | BPF_K: /* (dst_reg >= imm) */
 	case BPF_JMP32 | BPF_JGE | BPF_K: /* ((u32) dst_reg >= (u32) imm) */
 		mask = 0xa000; /* jhe */
 		goto branch_ku;
-	case BPF_JMP | BPF_JLE | BPF_K: /* (dst_reg <= imm) */
+	case BPF_JMP64 | BPF_JLE | BPF_K: /* (dst_reg <= imm) */
 	case BPF_JMP32 | BPF_JLE | BPF_K: /* ((u32) dst_reg <= (u32) imm) */
 		mask = 0xc000; /* jle */
 		goto branch_ku;
-	case BPF_JMP | BPF_JNE | BPF_K: /* (dst_reg != imm) */
+	case BPF_JMP64 | BPF_JNE | BPF_K: /* (dst_reg != imm) */
 	case BPF_JMP32 | BPF_JNE | BPF_K: /* ((u32) dst_reg != (u32) imm) */
 		mask = 0x7000; /* jne */
 		goto branch_ku;
-	case BPF_JMP | BPF_JEQ | BPF_K: /* (dst_reg == imm) */
+	case BPF_JMP64 | BPF_JEQ | BPF_K: /* (dst_reg == imm) */
 	case BPF_JMP32 | BPF_JEQ | BPF_K: /* ((u32) dst_reg == (u32) imm) */
 		mask = 0x8000; /* je */
 		goto branch_ku;
-	case BPF_JMP | BPF_JSET | BPF_K: /* (dst_reg & imm) */
+	case BPF_JMP64 | BPF_JSET | BPF_K: /* (dst_reg & imm) */
 	case BPF_JMP32 | BPF_JSET | BPF_K: /* ((u32) dst_reg & (u32) imm) */
 		mask = 0x7000; /* jnz */
 		if (BPF_CLASS(insn->code) == BPF_JMP32) {
@@ -1629,47 +1629,47 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		goto branch_oc;
 
-	case BPF_JMP | BPF_JSGT | BPF_X: /* ((s64) dst > (s64) src) */
+	case BPF_JMP64 | BPF_JSGT | BPF_X: /* ((s64) dst > (s64) src) */
 	case BPF_JMP32 | BPF_JSGT | BPF_X: /* ((s32) dst > (s32) src) */
 		mask = 0x2000; /* jh */
 		goto branch_xs;
-	case BPF_JMP | BPF_JSLT | BPF_X: /* ((s64) dst < (s64) src) */
+	case BPF_JMP64 | BPF_JSLT | BPF_X: /* ((s64) dst < (s64) src) */
 	case BPF_JMP32 | BPF_JSLT | BPF_X: /* ((s32) dst < (s32) src) */
 		mask = 0x4000; /* jl */
 		goto branch_xs;
-	case BPF_JMP | BPF_JSGE | BPF_X: /* ((s64) dst >= (s64) src) */
+	case BPF_JMP64 | BPF_JSGE | BPF_X: /* ((s64) dst >= (s64) src) */
 	case BPF_JMP32 | BPF_JSGE | BPF_X: /* ((s32) dst >= (s32) src) */
 		mask = 0xa000; /* jhe */
 		goto branch_xs;
-	case BPF_JMP | BPF_JSLE | BPF_X: /* ((s64) dst <= (s64) src) */
+	case BPF_JMP64 | BPF_JSLE | BPF_X: /* ((s64) dst <= (s64) src) */
 	case BPF_JMP32 | BPF_JSLE | BPF_X: /* ((s32) dst <= (s32) src) */
 		mask = 0xc000; /* jle */
 		goto branch_xs;
-	case BPF_JMP | BPF_JGT | BPF_X: /* (dst > src) */
+	case BPF_JMP64 | BPF_JGT | BPF_X: /* (dst > src) */
 	case BPF_JMP32 | BPF_JGT | BPF_X: /* ((u32) dst > (u32) src) */
 		mask = 0x2000; /* jh */
 		goto branch_xu;
-	case BPF_JMP | BPF_JLT | BPF_X: /* (dst < src) */
+	case BPF_JMP64 | BPF_JLT | BPF_X: /* (dst < src) */
 	case BPF_JMP32 | BPF_JLT | BPF_X: /* ((u32) dst < (u32) src) */
 		mask = 0x4000; /* jl */
 		goto branch_xu;
-	case BPF_JMP | BPF_JGE | BPF_X: /* (dst >= src) */
+	case BPF_JMP64 | BPF_JGE | BPF_X: /* (dst >= src) */
 	case BPF_JMP32 | BPF_JGE | BPF_X: /* ((u32) dst >= (u32) src) */
 		mask = 0xa000; /* jhe */
 		goto branch_xu;
-	case BPF_JMP | BPF_JLE | BPF_X: /* (dst <= src) */
+	case BPF_JMP64 | BPF_JLE | BPF_X: /* (dst <= src) */
 	case BPF_JMP32 | BPF_JLE | BPF_X: /* ((u32) dst <= (u32) src) */
 		mask = 0xc000; /* jle */
 		goto branch_xu;
-	case BPF_JMP | BPF_JNE | BPF_X: /* (dst != src) */
+	case BPF_JMP64 | BPF_JNE | BPF_X: /* (dst != src) */
 	case BPF_JMP32 | BPF_JNE | BPF_X: /* ((u32) dst != (u32) src) */
 		mask = 0x7000; /* jne */
 		goto branch_xu;
-	case BPF_JMP | BPF_JEQ | BPF_X: /* (dst == src) */
+	case BPF_JMP64 | BPF_JEQ | BPF_X: /* (dst == src) */
 	case BPF_JMP32 | BPF_JEQ | BPF_X: /* ((u32) dst == (u32) src) */
 		mask = 0x8000; /* je */
 		goto branch_xu;
-	case BPF_JMP | BPF_JSET | BPF_X: /* (dst & src) */
+	case BPF_JMP64 | BPF_JSET | BPF_X: /* (dst & src) */
 	case BPF_JMP32 | BPF_JSET | BPF_X: /* ((u32) dst & (u32) src) */
 	{
 		bool is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a74e500..44ff90f 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -396,56 +396,56 @@ void bpf_jit_compile(struct bpf_prog *fp)
 			int ilen;
 
 			switch (code) {
-			case BPF_ALU | BPF_ADD | BPF_X:	/* A += X; */
+			case BPF_ALU32 | BPF_ADD | BPF_X:	/* A += X; */
 				emit_alu_X(ADD);
 				break;
-			case BPF_ALU | BPF_ADD | BPF_K:	/* A += K; */
+			case BPF_ALU32 | BPF_ADD | BPF_K:	/* A += K; */
 				emit_alu_K(ADD, K);
 				break;
-			case BPF_ALU | BPF_SUB | BPF_X:	/* A -= X; */
+			case BPF_ALU32 | BPF_SUB | BPF_X:	/* A -= X; */
 				emit_alu_X(SUB);
 				break;
-			case BPF_ALU | BPF_SUB | BPF_K:	/* A -= K */
+			case BPF_ALU32 | BPF_SUB | BPF_K:	/* A -= K */
 				emit_alu_K(SUB, K);
 				break;
-			case BPF_ALU | BPF_AND | BPF_X:	/* A &= X */
+			case BPF_ALU32 | BPF_AND | BPF_X:	/* A &= X */
 				emit_alu_X(AND);
 				break;
-			case BPF_ALU | BPF_AND | BPF_K:	/* A &= K */
+			case BPF_ALU32 | BPF_AND | BPF_K:	/* A &= K */
 				emit_alu_K(AND, K);
 				break;
-			case BPF_ALU | BPF_OR | BPF_X:	/* A |= X */
+			case BPF_ALU32 | BPF_OR | BPF_X:	/* A |= X */
 				emit_alu_X(OR);
 				break;
-			case BPF_ALU | BPF_OR | BPF_K:	/* A |= K */
+			case BPF_ALU32 | BPF_OR | BPF_K:	/* A |= K */
 				emit_alu_K(OR, K);
 				break;
 			case BPF_ANC | SKF_AD_ALU_XOR_X: /* A ^= X; */
-			case BPF_ALU | BPF_XOR | BPF_X:
+			case BPF_ALU32 | BPF_XOR | BPF_X:
 				emit_alu_X(XOR);
 				break;
-			case BPF_ALU | BPF_XOR | BPF_K:	/* A ^= K */
+			case BPF_ALU32 | BPF_XOR | BPF_K:	/* A ^= K */
 				emit_alu_K(XOR, K);
 				break;
-			case BPF_ALU | BPF_LSH | BPF_X:	/* A <<= X */
+			case BPF_ALU32 | BPF_LSH | BPF_X:	/* A <<= X */
 				emit_alu_X(SLL);
 				break;
-			case BPF_ALU | BPF_LSH | BPF_K:	/* A <<= K */
+			case BPF_ALU32 | BPF_LSH | BPF_K:	/* A <<= K */
 				emit_alu_K(SLL, K);
 				break;
-			case BPF_ALU | BPF_RSH | BPF_X:	/* A >>= X */
+			case BPF_ALU32 | BPF_RSH | BPF_X:	/* A >>= X */
 				emit_alu_X(SRL);
 				break;
-			case BPF_ALU | BPF_RSH | BPF_K:	/* A >>= K */
+			case BPF_ALU32 | BPF_RSH | BPF_K:	/* A >>= K */
 				emit_alu_K(SRL, K);
 				break;
-			case BPF_ALU | BPF_MUL | BPF_X:	/* A *= X; */
+			case BPF_ALU32 | BPF_MUL | BPF_X:	/* A *= X; */
 				emit_alu_X(MUL);
 				break;
-			case BPF_ALU | BPF_MUL | BPF_K:	/* A *= K */
+			case BPF_ALU32 | BPF_MUL | BPF_K:	/* A *= K */
 				emit_alu_K(MUL, K);
 				break;
-			case BPF_ALU | BPF_DIV | BPF_K:	/* A /= K with K != 0*/
+			case BPF_ALU32 | BPF_DIV | BPF_K:	/* A /= K with K != 0*/
 				if (K == 1)
 					break;
 				emit_write_y(G0);
@@ -458,7 +458,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_nop();
 				emit_alu_K(DIV, K);
 				break;
-			case BPF_ALU | BPF_DIV | BPF_X:	/* A /= X; */
+			case BPF_ALU32 | BPF_DIV | BPF_X:	/* A /= X; */
 				emit_cmpi(r_X, 0);
 				if (pc_ret0 > 0) {
 					t_offset = addrs[pc_ret0 - 1];
@@ -480,7 +480,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_nop();
 				emit_alu_X(DIV);
 				break;
-			case BPF_ALU | BPF_NEG:
+			case BPF_ALU32 | BPF_NEG:
 				emit_neg();
 				break;
 			case BPF_RET | BPF_K:
@@ -629,7 +629,7 @@ common_load_ind:		seen |= SEEN_DATAREF | SEEN_XREG;
 			case BPF_LD | BPF_B | BPF_IND:
 				func = bpf_jit_load_byte;
 				goto common_load_ind;
-			case BPF_JMP | BPF_JA:
+			case BPF_JMP64 | BPF_JA:
 				emit_jump(addrs[i + K]);
 				emit_nop();
 				break;
@@ -640,14 +640,14 @@ common_load_ind:		seen |= SEEN_DATAREF | SEEN_XREG;
 		f_op = FOP;		\
 		goto cond_branch
 
-			COND_SEL(BPF_JMP | BPF_JGT | BPF_K, BGU, BLEU);
-			COND_SEL(BPF_JMP | BPF_JGE | BPF_K, BGEU, BLU);
-			COND_SEL(BPF_JMP | BPF_JEQ | BPF_K, BE, BNE);
-			COND_SEL(BPF_JMP | BPF_JSET | BPF_K, BNE, BE);
-			COND_SEL(BPF_JMP | BPF_JGT | BPF_X, BGU, BLEU);
-			COND_SEL(BPF_JMP | BPF_JGE | BPF_X, BGEU, BLU);
-			COND_SEL(BPF_JMP | BPF_JEQ | BPF_X, BE, BNE);
-			COND_SEL(BPF_JMP | BPF_JSET | BPF_X, BNE, BE);
+			COND_SEL(BPF_JMP64 | BPF_JGT | BPF_K, BGU, BLEU);
+			COND_SEL(BPF_JMP64 | BPF_JGE | BPF_K, BGEU, BLU);
+			COND_SEL(BPF_JMP64 | BPF_JEQ | BPF_K, BE, BNE);
+			COND_SEL(BPF_JMP64 | BPF_JSET | BPF_K, BNE, BE);
+			COND_SEL(BPF_JMP64 | BPF_JGT | BPF_X, BGU, BLEU);
+			COND_SEL(BPF_JMP64 | BPF_JGE | BPF_X, BGEU, BLU);
+			COND_SEL(BPF_JMP64 | BPF_JEQ | BPF_X, BE, BNE);
+			COND_SEL(BPF_JMP64 | BPF_JSET | BPF_X, BNE, BE);
 
 cond_branch:			f_offset = addrs[i + filter[i].jf];
 				t_offset = addrs[i + filter[i].jt];
@@ -660,19 +660,19 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 				}
 
 				switch (code) {
-				case BPF_JMP | BPF_JGT | BPF_X:
-				case BPF_JMP | BPF_JGE | BPF_X:
-				case BPF_JMP | BPF_JEQ | BPF_X:
+				case BPF_JMP64 | BPF_JGT | BPF_X:
+				case BPF_JMP64 | BPF_JGE | BPF_X:
+				case BPF_JMP64 | BPF_JEQ | BPF_X:
 					seen |= SEEN_XREG;
 					emit_cmp(r_A, r_X);
 					break;
-				case BPF_JMP | BPF_JSET | BPF_X:
+				case BPF_JMP64 | BPF_JSET | BPF_X:
 					seen |= SEEN_XREG;
 					emit_btst(r_A, r_X);
 					break;
-				case BPF_JMP | BPF_JEQ | BPF_K:
-				case BPF_JMP | BPF_JGT | BPF_K:
-				case BPF_JMP | BPF_JGE | BPF_K:
+				case BPF_JMP64 | BPF_JEQ | BPF_K:
+				case BPF_JMP64 | BPF_JGT | BPF_K:
+				case BPF_JMP64 | BPF_JGE | BPF_K:
 					if (is_simm13(K)) {
 						emit_cmpi(r_A, K);
 					} else {
@@ -680,7 +680,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 						emit_cmp(r_A, r_TMP);
 					}
 					break;
-				case BPF_JMP | BPF_JSET | BPF_K:
+				case BPF_JMP64 | BPF_JSET | BPF_K:
 					if (is_simm13(K)) {
 						emit_btsti(r_A, K);
 					} else {
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index fa0759b..5de22bc 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -906,7 +906,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 
 	switch (code) {
 	/* dst = src */
-	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU32 | BPF_MOV | BPF_X:
 		emit_alu3_K(SRL, src, 0, dst, ctx);
 		if (insn_is_zext(&insn[1]))
 			return 1;
@@ -915,33 +915,33 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_reg_move(src, dst, ctx);
 		break;
 	/* dst = dst OP src */
-	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU32 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_alu(ADD, src, dst, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU32 | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
 		emit_alu(SUB, src, dst, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU32 | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit_alu(AND, src, dst, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU32 | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit_alu(OR, src, dst, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU32 | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit_alu(XOR, src, dst, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU32 | BPF_MUL | BPF_X:
 		emit_alu(MUL, src, dst, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit_alu(MULX, src, dst, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU32 | BPF_DIV | BPF_X:
 		emit_write_y(G0, ctx);
 		emit_alu(DIV, src, dst, ctx);
 		if (insn_is_zext(&insn[1]))
@@ -950,7 +950,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit_alu(UDIVX, src, dst, ctx);
 		break;
-	case BPF_ALU | BPF_MOD | BPF_X: {
+	case BPF_ALU32 | BPF_MOD | BPF_X: {
 		const u8 tmp = bpf2sparc[TMP_REG_1];
 
 		ctx->tmp_1_used = true;
@@ -971,13 +971,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_alu3(SUB, dst, tmp, dst, ctx);
 		break;
 	}
-	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU32 | BPF_LSH | BPF_X:
 		emit_alu(SLL, src, dst, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit_alu(SLLX, src, dst, ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU32 | BPF_RSH | BPF_X:
 		emit_alu(SRL, src, dst, ctx);
 		if (insn_is_zext(&insn[1]))
 			return 1;
@@ -985,7 +985,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit_alu(SRLX, src, dst, ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU32 | BPF_ARSH | BPF_X:
 		emit_alu(SRA, src, dst, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
@@ -993,12 +993,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	/* dst = -dst */
-	case BPF_ALU | BPF_NEG:
+	case BPF_ALU32 | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
 		emit(SUB | RS1(0) | RS2(dst) | RD(dst), ctx);
 		goto do_alu32_trunc;
 
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 		switch (imm) {
 		case 16:
 			emit_alu_K(SLL, dst, 16, ctx);
@@ -1018,7 +1018,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	/* dst = BSWAP##imm(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE: {
+	case BPF_ALU32 | BPF_END | BPF_FROM_LE: {
 		const u8 tmp = bpf2sparc[TMP_REG_1];
 		const u8 tmp2 = bpf2sparc[TMP_REG_2];
 
@@ -1061,7 +1061,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	}
 	/* dst = imm */
-	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
 		emit_loadimm32(imm, dst, ctx);
 		if (insn_is_zext(&insn[1]))
 			return 1;
@@ -1070,33 +1070,33 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_loadimm_sext(imm, dst, ctx);
 		break;
 	/* dst = dst OP imm */
-	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 		emit_alu_K(ADD, dst, imm, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		emit_alu_K(SUB, dst, imm, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
 		emit_alu_K(AND, dst, imm, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU32 | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
 		emit_alu_K(OR, dst, imm, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
 		emit_alu_K(XOR, dst, imm, ctx);
 		goto do_alu32_trunc;
-	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
 		emit_alu_K(MUL, dst, imm, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_alu_K(MULX, dst, imm, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
 		if (imm == 0)
 			return -EINVAL;
 
@@ -1110,7 +1110,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_alu_K(UDIVX, dst, imm, ctx);
 		break;
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_K: {
+	case BPF_ALU32 | BPF_MOD | BPF_K: {
 		const u8 tmp = bpf2sparc[TMP_REG_2];
 		unsigned int div;
 
@@ -1139,13 +1139,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		goto do_alu32_trunc;
 	}
-	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU32 | BPF_LSH | BPF_K:
 		emit_alu_K(SLL, dst, imm, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit_alu_K(SLLX, dst, imm, ctx);
 		break;
-	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU32 | BPF_RSH | BPF_K:
 		emit_alu_K(SRL, dst, imm, ctx);
 		if (insn_is_zext(&insn[1]))
 			return 1;
@@ -1153,7 +1153,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		emit_alu_K(SRLX, dst, imm, ctx);
 		break;
-	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU32 | BPF_ARSH | BPF_K:
 		emit_alu_K(SRA, dst, imm, ctx);
 		goto do_alu32_trunc;
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
@@ -1161,28 +1161,28 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	do_alu32_trunc:
-		if (BPF_CLASS(code) == BPF_ALU &&
+		if (BPF_CLASS(code) == BPF_ALU32 &&
 		    !ctx->prog->aux->verifier_zext)
 			emit_alu_K(SRL, dst, 0, ctx);
 		break;
 
 	/* JUMP off */
-	case BPF_JMP | BPF_JA:
+	case BPF_JMP64 | BPF_JA:
 		emit_branch(BA, ctx->idx, ctx->offset[i + off], ctx);
 		emit_nop(ctx);
 		break;
 	/* IF (dst COND src) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_X:
-	case BPF_JMP | BPF_JGT | BPF_X:
-	case BPF_JMP | BPF_JLT | BPF_X:
-	case BPF_JMP | BPF_JGE | BPF_X:
-	case BPF_JMP | BPF_JLE | BPF_X:
-	case BPF_JMP | BPF_JNE | BPF_X:
-	case BPF_JMP | BPF_JSGT | BPF_X:
-	case BPF_JMP | BPF_JSLT | BPF_X:
-	case BPF_JMP | BPF_JSGE | BPF_X:
-	case BPF_JMP | BPF_JSLE | BPF_X:
-	case BPF_JMP | BPF_JSET | BPF_X: {
+	case BPF_JMP64 | BPF_JEQ | BPF_X:
+	case BPF_JMP64 | BPF_JGT | BPF_X:
+	case BPF_JMP64 | BPF_JLT | BPF_X:
+	case BPF_JMP64 | BPF_JGE | BPF_X:
+	case BPF_JMP64 | BPF_JLE | BPF_X:
+	case BPF_JMP64 | BPF_JNE | BPF_X:
+	case BPF_JMP64 | BPF_JSGT | BPF_X:
+	case BPF_JMP64 | BPF_JSLT | BPF_X:
+	case BPF_JMP64 | BPF_JSGE | BPF_X:
+	case BPF_JMP64 | BPF_JSLE | BPF_X:
+	case BPF_JMP64 | BPF_JSET | BPF_X: {
 		int err;
 
 		err = emit_compare_and_branch(code, dst, src, 0, false, i + off, ctx);
@@ -1191,17 +1191,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	}
 	/* IF (dst COND imm) JUMP off */
-	case BPF_JMP | BPF_JEQ | BPF_K:
-	case BPF_JMP | BPF_JGT | BPF_K:
-	case BPF_JMP | BPF_JLT | BPF_K:
-	case BPF_JMP | BPF_JGE | BPF_K:
-	case BPF_JMP | BPF_JLE | BPF_K:
-	case BPF_JMP | BPF_JNE | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K: {
+	case BPF_JMP64 | BPF_JEQ | BPF_K:
+	case BPF_JMP64 | BPF_JGT | BPF_K:
+	case BPF_JMP64 | BPF_JLT | BPF_K:
+	case BPF_JMP64 | BPF_JGE | BPF_K:
+	case BPF_JMP64 | BPF_JLE | BPF_K:
+	case BPF_JMP64 | BPF_JNE | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K: {
 		int err;
 
 		err = emit_compare_and_branch(code, dst, 0, imm, true, i + off, ctx);
@@ -1211,7 +1211,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	}
 
 	/* function call */
-	case BPF_JMP | BPF_CALL:
+	case BPF_JMP64 | BPF_CALL:
 	{
 		u8 *func = ((u8 *)__bpf_call_base) + imm;
 
@@ -1225,12 +1225,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	}
 
 	/* tail call */
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP64 | BPF_TAIL_CALL:
 		emit_tail_call(ctx);
 		break;
 
 	/* function return */
-	case BPF_JMP | BPF_EXIT:
+	case BPF_JMP64 | BPF_EXIT:
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf..273c9e9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -870,7 +870,7 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
 	int i;
 
 	for (i = 1; i <= insn_cnt; i++, insn++) {
-		if (insn->code == (BPF_JMP | BPF_TAIL_CALL))
+		if (insn->code == (BPF_JMP64 | BPF_TAIL_CALL))
 			*tail_call_seen = true;
 		if (insn->dst_reg == BPF_REG_6 || insn->src_reg == BPF_REG_6)
 			regs_used[0] = true;
@@ -1010,11 +1010,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 		switch (insn->code) {
 			/* ALU */
-		case BPF_ALU | BPF_ADD | BPF_X:
-		case BPF_ALU | BPF_SUB | BPF_X:
-		case BPF_ALU | BPF_AND | BPF_X:
-		case BPF_ALU | BPF_OR | BPF_X:
-		case BPF_ALU | BPF_XOR | BPF_X:
+		case BPF_ALU32 | BPF_ADD | BPF_X:
+		case BPF_ALU32 | BPF_SUB | BPF_X:
+		case BPF_ALU32 | BPF_AND | BPF_X:
+		case BPF_ALU32 | BPF_OR | BPF_X:
+		case BPF_ALU32 | BPF_XOR | BPF_X:
 		case BPF_ALU64 | BPF_ADD | BPF_X:
 		case BPF_ALU64 | BPF_SUB | BPF_X:
 		case BPF_ALU64 | BPF_AND | BPF_X:
@@ -1027,25 +1027,25 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
-		case BPF_ALU | BPF_MOV | BPF_X:
+		case BPF_ALU32 | BPF_MOV | BPF_X:
 			emit_mov_reg(&prog,
 				     BPF_CLASS(insn->code) == BPF_ALU64,
 				     dst_reg, src_reg);
 			break;
 
 			/* neg dst */
-		case BPF_ALU | BPF_NEG:
+		case BPF_ALU32 | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
 			maybe_emit_1mod(&prog, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
 			break;
 
-		case BPF_ALU | BPF_ADD | BPF_K:
-		case BPF_ALU | BPF_SUB | BPF_K:
-		case BPF_ALU | BPF_AND | BPF_K:
-		case BPF_ALU | BPF_OR | BPF_K:
-		case BPF_ALU | BPF_XOR | BPF_K:
+		case BPF_ALU32 | BPF_ADD | BPF_K:
+		case BPF_ALU32 | BPF_SUB | BPF_K:
+		case BPF_ALU32 | BPF_AND | BPF_K:
+		case BPF_ALU32 | BPF_OR | BPF_K:
+		case BPF_ALU32 | BPF_XOR | BPF_K:
 		case BPF_ALU64 | BPF_ADD | BPF_K:
 		case BPF_ALU64 | BPF_SUB | BPF_K:
 		case BPF_ALU64 | BPF_AND | BPF_K:
@@ -1090,7 +1090,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_K:
-		case BPF_ALU | BPF_MOV | BPF_K:
+		case BPF_ALU32 | BPF_MOV | BPF_K:
 			emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
 				       dst_reg, imm32);
 			break;
@@ -1102,10 +1102,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 			/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
-		case BPF_ALU | BPF_MOD | BPF_X:
-		case BPF_ALU | BPF_DIV | BPF_X:
-		case BPF_ALU | BPF_MOD | BPF_K:
-		case BPF_ALU | BPF_DIV | BPF_K:
+		case BPF_ALU32 | BPF_MOD | BPF_X:
+		case BPF_ALU32 | BPF_DIV | BPF_X:
+		case BPF_ALU32 | BPF_MOD | BPF_K:
+		case BPF_ALU32 | BPF_DIV | BPF_K:
 		case BPF_ALU64 | BPF_MOD | BPF_X:
 		case BPF_ALU64 | BPF_DIV | BPF_X:
 		case BPF_ALU64 | BPF_MOD | BPF_K:
@@ -1160,7 +1160,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 		}
 
-		case BPF_ALU | BPF_MUL | BPF_K:
+		case BPF_ALU32 | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
 			maybe_emit_mod(&prog, dst_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
@@ -1176,7 +1176,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 					    imm32);
 			break;
 
-		case BPF_ALU | BPF_MUL | BPF_X:
+		case BPF_ALU32 | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_X:
 			maybe_emit_mod(&prog, src_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
@@ -1186,9 +1186,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 			/* Shifts */
-		case BPF_ALU | BPF_LSH | BPF_K:
-		case BPF_ALU | BPF_RSH | BPF_K:
-		case BPF_ALU | BPF_ARSH | BPF_K:
+		case BPF_ALU32 | BPF_LSH | BPF_K:
+		case BPF_ALU32 | BPF_RSH | BPF_K:
+		case BPF_ALU32 | BPF_ARSH | BPF_K:
 		case BPF_ALU64 | BPF_LSH | BPF_K:
 		case BPF_ALU64 | BPF_RSH | BPF_K:
 		case BPF_ALU64 | BPF_ARSH | BPF_K:
@@ -1202,9 +1202,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
 			break;
 
-		case BPF_ALU | BPF_LSH | BPF_X:
-		case BPF_ALU | BPF_RSH | BPF_X:
-		case BPF_ALU | BPF_ARSH | BPF_X:
+		case BPF_ALU32 | BPF_LSH | BPF_X:
+		case BPF_ALU32 | BPF_RSH | BPF_X:
+		case BPF_ALU32 | BPF_ARSH | BPF_X:
 		case BPF_ALU64 | BPF_LSH | BPF_X:
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
@@ -1261,7 +1261,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 			break;
 
-		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 			switch (imm32) {
 			case 16:
 				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
@@ -1293,7 +1293,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			}
 			break;
 
-		case BPF_ALU | BPF_END | BPF_FROM_LE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 			switch (imm32) {
 			case 16:
 				/*
@@ -1533,7 +1533,7 @@ st:			if (is_imm8(insn->off))
 			break;
 
 			/* call */
-		case BPF_JMP | BPF_CALL: {
+		case BPF_JMP64 | BPF_CALL: {
 			int offs;
 
 			func = (u8 *) __bpf_call_base + imm32;
@@ -1554,7 +1554,7 @@ st:			if (is_imm8(insn->off))
 			break;
 		}
 
-		case BPF_JMP | BPF_TAIL_CALL:
+		case BPF_JMP64 | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
 							  &prog, image + addrs[i - 1],
@@ -1570,16 +1570,16 @@ st:			if (is_imm8(insn->off))
 			break;
 
 			/* cond jump */
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JNE | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JLT | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JLE | BPF_X:
-		case BPF_JMP | BPF_JSGT | BPF_X:
-		case BPF_JMP | BPF_JSLT | BPF_X:
-		case BPF_JMP | BPF_JSGE | BPF_X:
-		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JNE | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JLT | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JLE | BPF_X:
+		case BPF_JMP64 | BPF_JSGT | BPF_X:
+		case BPF_JMP64 | BPF_JSLT | BPF_X:
+		case BPF_JMP64 | BPF_JSGE | BPF_X:
+		case BPF_JMP64 | BPF_JSLE | BPF_X:
 		case BPF_JMP32 | BPF_JEQ | BPF_X:
 		case BPF_JMP32 | BPF_JNE | BPF_X:
 		case BPF_JMP32 | BPF_JGT | BPF_X:
@@ -1592,36 +1592,36 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			/* cmp dst_reg, src_reg */
 			maybe_emit_mod(&prog, dst_reg, src_reg,
-				       BPF_CLASS(insn->code) == BPF_JMP);
+				       BPF_CLASS(insn->code) == BPF_JMP64);
 			EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			/* test dst_reg, src_reg */
 			maybe_emit_mod(&prog, dst_reg, src_reg,
-				       BPF_CLASS(insn->code) == BPF_JMP);
+				       BPF_CLASS(insn->code) == BPF_JMP64);
 			EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
-		case BPF_JMP | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 			/* test dst_reg, imm32 */
 			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) == BPF_JMP);
+					BPF_CLASS(insn->code) == BPF_JMP64);
 			EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
 			goto emit_cond_jmp;
 
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JNE | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JLT | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JLE | BPF_K:
-		case BPF_JMP | BPF_JSGT | BPF_K:
-		case BPF_JMP | BPF_JSLT | BPF_K:
-		case BPF_JMP | BPF_JSGE | BPF_K:
-		case BPF_JMP | BPF_JSLE | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JNE | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JLT | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JLE | BPF_K:
+		case BPF_JMP64 | BPF_JSGT | BPF_K:
+		case BPF_JMP64 | BPF_JSLT | BPF_K:
+		case BPF_JMP64 | BPF_JSGE | BPF_K:
+		case BPF_JMP64 | BPF_JSLE | BPF_K:
 		case BPF_JMP32 | BPF_JEQ | BPF_K:
 		case BPF_JMP32 | BPF_JNE | BPF_K:
 		case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -1635,14 +1635,14 @@ st:			if (is_imm8(insn->off))
 			/* test dst_reg, dst_reg to save one extra byte */
 			if (imm32 == 0) {
 				maybe_emit_mod(&prog, dst_reg, dst_reg,
-					       BPF_CLASS(insn->code) == BPF_JMP);
+					       BPF_CLASS(insn->code) == BPF_JMP64);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
 
 			/* cmp dst_reg, imm8/32 */
 			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) == BPF_JMP);
+					BPF_CLASS(insn->code) == BPF_JMP64);
 
 			if (is_imm8(imm32))
 				EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
@@ -1729,7 +1729,7 @@ st:			if (is_imm8(insn->off))
 
 			break;
 
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			if (insn->off == -1)
 				/* -1 jmp instructions will always jump
 				 * backwards two bytes. Explicitly handling
@@ -1799,7 +1799,7 @@ st:			if (is_imm8(insn->off))
 			}
 			break;
 
-		case BPF_JMP | BPF_EXIT:
+		case BPF_JMP64 | BPF_EXIT:
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i];
 				goto emit_jmp;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c..580ecd7 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1558,7 +1558,7 @@ static u8 get_cond_jmp_opcode(const u8 op, bool is_cmp_lo)
  * the jmp_offset relative to the jit-insn address immediately
  * following the call (0xE8) instruction.  At this point, it knows
  * the end of the jit-insn address after completely translated the
- * current (BPF_JMP | BPF_CALL) bpf-insn.  It is passed as "end_addr"
+ * current (BPF_JMP64 | BPF_CALL) bpf-insn.  It is passed as "end_addr"
  * to the emit_kfunc_call().  Thus, it can learn the "immediate-follow-call"
  * address by figuring out how many jit-insn is generated between
  * the call (0xE8) and the end_addr:
@@ -1686,8 +1686,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		switch (code) {
 		/* ALU operations */
 		/* dst = src */
-		case BPF_ALU | BPF_MOV | BPF_K:
-		case BPF_ALU | BPF_MOV | BPF_X:
+		case BPF_ALU32 | BPF_MOV | BPF_K:
+		case BPF_ALU32 | BPF_MOV | BPF_X:
 		case BPF_ALU64 | BPF_MOV | BPF_K:
 		case BPF_ALU64 | BPF_MOV | BPF_X:
 			switch (BPF_SRC(code)) {
@@ -1715,16 +1715,16 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		/* dst = dst * src/imm */
 		/* dst = dst << src */
 		/* dst = dst >> src */
-		case BPF_ALU | BPF_ADD | BPF_K:
-		case BPF_ALU | BPF_ADD | BPF_X:
-		case BPF_ALU | BPF_SUB | BPF_K:
-		case BPF_ALU | BPF_SUB | BPF_X:
-		case BPF_ALU | BPF_OR | BPF_K:
-		case BPF_ALU | BPF_OR | BPF_X:
-		case BPF_ALU | BPF_AND | BPF_K:
-		case BPF_ALU | BPF_AND | BPF_X:
-		case BPF_ALU | BPF_XOR | BPF_K:
-		case BPF_ALU | BPF_XOR | BPF_X:
+		case BPF_ALU32 | BPF_ADD | BPF_K:
+		case BPF_ALU32 | BPF_ADD | BPF_X:
+		case BPF_ALU32 | BPF_SUB | BPF_K:
+		case BPF_ALU32 | BPF_SUB | BPF_X:
+		case BPF_ALU32 | BPF_OR | BPF_K:
+		case BPF_ALU32 | BPF_OR | BPF_X:
+		case BPF_ALU32 | BPF_AND | BPF_K:
+		case BPF_ALU32 | BPF_AND | BPF_X:
+		case BPF_ALU32 | BPF_XOR | BPF_K:
+		case BPF_ALU32 | BPF_XOR | BPF_X:
 		case BPF_ALU64 | BPF_ADD | BPF_K:
 		case BPF_ALU64 | BPF_ADD | BPF_X:
 		case BPF_ALU64 | BPF_SUB | BPF_K:
@@ -1748,8 +1748,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 				break;
 			}
 			break;
-		case BPF_ALU | BPF_MUL | BPF_K:
-		case BPF_ALU | BPF_MUL | BPF_X:
+		case BPF_ALU32 | BPF_MUL | BPF_K:
+		case BPF_ALU32 | BPF_MUL | BPF_X:
 			switch (BPF_SRC(code)) {
 			case BPF_X:
 				emit_ia32_mul_r(dst_lo, src_lo, dstk,
@@ -1766,10 +1766,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (!bpf_prog->aux->verifier_zext)
 				emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 			break;
-		case BPF_ALU | BPF_LSH | BPF_X:
-		case BPF_ALU | BPF_RSH | BPF_X:
-		case BPF_ALU | BPF_ARSH | BPF_K:
-		case BPF_ALU | BPF_ARSH | BPF_X:
+		case BPF_ALU32 | BPF_LSH | BPF_X:
+		case BPF_ALU32 | BPF_RSH | BPF_X:
+		case BPF_ALU32 | BPF_ARSH | BPF_K:
+		case BPF_ALU32 | BPF_ARSH | BPF_X:
 			switch (BPF_SRC(code)) {
 			case BPF_X:
 				emit_ia32_shift_r(BPF_OP(code), dst_lo, src_lo,
@@ -1789,10 +1789,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			break;
 		/* dst = dst / src(imm) */
 		/* dst = dst % src(imm) */
-		case BPF_ALU | BPF_DIV | BPF_K:
-		case BPF_ALU | BPF_DIV | BPF_X:
-		case BPF_ALU | BPF_MOD | BPF_K:
-		case BPF_ALU | BPF_MOD | BPF_X:
+		case BPF_ALU32 | BPF_DIV | BPF_K:
+		case BPF_ALU32 | BPF_DIV | BPF_X:
+		case BPF_ALU32 | BPF_MOD | BPF_K:
+		case BPF_ALU32 | BPF_MOD | BPF_X:
 			switch (BPF_SRC(code)) {
 			case BPF_X:
 				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
@@ -1817,8 +1817,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			goto notyet;
 		/* dst = dst >> imm */
 		/* dst = dst << imm */
-		case BPF_ALU | BPF_RSH | BPF_K:
-		case BPF_ALU | BPF_LSH | BPF_K:
+		case BPF_ALU32 | BPF_RSH | BPF_K:
+		case BPF_ALU32 | BPF_LSH | BPF_K:
 			if (unlikely(imm32 > 31))
 				return -EINVAL;
 			/* mov ecx,imm32*/
@@ -1859,7 +1859,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			emit_ia32_arsh_i64(dst, imm32, dstk, &prog);
 			break;
 		/* dst = ~dst */
-		case BPF_ALU | BPF_NEG:
+		case BPF_ALU32 | BPF_NEG:
 			emit_ia32_alu_i(is64, false, BPF_OP(code),
 					dst_lo, 0, dstk, &prog);
 			if (!bpf_prog->aux->verifier_zext)
@@ -1882,12 +1882,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			}
 			break;
 		/* dst = htole(dst) */
-		case BPF_ALU | BPF_END | BPF_FROM_LE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_LE:
 			emit_ia32_to_le_r64(dst, imm32, dstk, &prog,
 					    bpf_prog->aux);
 			break;
 		/* dst = htobe(dst) */
-		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU32 | BPF_END | BPF_FROM_BE:
 			emit_ia32_to_be_r64(dst, imm32, dstk, &prog,
 					    bpf_prog->aux);
 			break;
@@ -2080,7 +2080,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			}
 			break;
 		/* call */
-		case BPF_JMP | BPF_CALL:
+		case BPF_JMP64 | BPF_CALL:
 		{
 			const u8 *r1 = bpf2ia32[BPF_REG_1];
 			const u8 *r2 = bpf2ia32[BPF_REG_2];
@@ -2137,17 +2137,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			EMIT3(0x83, add_1reg(0xC0, IA32_ESP), 32);
 			break;
 		}
-		case BPF_JMP | BPF_TAIL_CALL:
+		case BPF_JMP64 | BPF_TAIL_CALL:
 			emit_bpf_tail_call(&prog, image + addrs[i - 1]);
 			break;
 
 		/* cond jump */
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JNE | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JLT | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JLE | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JNE | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JLT | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JLE | BPF_X:
 		case BPF_JMP32 | BPF_JEQ | BPF_X:
 		case BPF_JMP32 | BPF_JNE | BPF_X:
 		case BPF_JMP32 | BPF_JGT | BPF_X:
@@ -2158,7 +2158,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 		case BPF_JMP32 | BPF_JSLT | BPF_X:
 		case BPF_JMP32 | BPF_JSGE | BPF_X: {
-			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
+			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP64;
 			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
@@ -2193,10 +2193,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
 			goto emit_cond_jmp;
 		}
-		case BPF_JMP | BPF_JSGT | BPF_X:
-		case BPF_JMP | BPF_JSLE | BPF_X:
-		case BPF_JMP | BPF_JSLT | BPF_X:
-		case BPF_JMP | BPF_JSGE | BPF_X: {
+		case BPF_JMP64 | BPF_JSGT | BPF_X:
+		case BPF_JMP64 | BPF_JSLE | BPF_X:
+		case BPF_JMP64 | BPF_JSLT | BPF_X:
+		case BPF_JMP64 | BPF_JSGE | BPF_X: {
 			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
@@ -2227,9 +2227,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
 			goto emit_cond_jmp_signed;
 		}
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X: {
-			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
+			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP64;
 			u8 dreg_lo = IA32_EAX;
 			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
@@ -2271,9 +2271,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			}
 			goto emit_cond_jmp;
 		}
-		case BPF_JMP | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K: {
-			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
+			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP64;
 			u8 dreg_lo = IA32_EAX;
 			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = IA32_ECX;
@@ -2313,12 +2313,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			}
 			goto emit_cond_jmp;
 		}
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JNE | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JLT | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JLE | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JNE | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JLT | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JLE | BPF_K:
 		case BPF_JMP32 | BPF_JEQ | BPF_K:
 		case BPF_JMP32 | BPF_JNE | BPF_K:
 		case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -2329,7 +2329,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 		case BPF_JMP32 | BPF_JSLT | BPF_K:
 		case BPF_JMP32 | BPF_JSGE | BPF_K: {
-			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
+			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP64;
 			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 			u8 sreg_lo = IA32_ECX;
@@ -2373,10 +2373,10 @@ emit_cond_jmp:		jmp_cond = get_cond_jmp_opcode(BPF_OP(code), false);
 			}
 			break;
 		}
-		case BPF_JMP | BPF_JSGT | BPF_K:
-		case BPF_JMP | BPF_JSLE | BPF_K:
-		case BPF_JMP | BPF_JSLT | BPF_K:
-		case BPF_JMP | BPF_JSGE | BPF_K: {
+		case BPF_JMP64 | BPF_JSGT | BPF_K:
+		case BPF_JMP64 | BPF_JSLE | BPF_K:
+		case BPF_JMP64 | BPF_JSLT | BPF_K:
+		case BPF_JMP64 | BPF_JSGE | BPF_K: {
 			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 			u8 sreg_lo = IA32_ECX;
@@ -2433,7 +2433,7 @@ emit_cond_jmp:		jmp_cond = get_cond_jmp_opcode(BPF_OP(code), false);
 			}
 			break;
 		}
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			if (insn->off == -1)
 				/* -1 jmp instructions will always jump
 				 * backwards two bytes. Explicitly handling
@@ -2461,7 +2461,7 @@ emit_cond_jmp:		jmp_cond = get_cond_jmp_opcode(BPF_OP(code), false);
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			goto notyet;
-		case BPF_JMP | BPF_EXIT:
+		case BPF_JMP64 | BPF_EXIT:
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i];
 				goto emit_jmp;
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index df2ab5c..82345a4 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -3442,30 +3442,30 @@ static const instr_cb_t instr_cb[256] = {
 	[BPF_ALU64 | BPF_RSH | BPF_K] =	shr_imm64,
 	[BPF_ALU64 | BPF_ARSH | BPF_X] = ashr_reg64,
 	[BPF_ALU64 | BPF_ARSH | BPF_K] = ashr_imm64,
-	[BPF_ALU | BPF_MOV | BPF_X] =	mov_reg,
-	[BPF_ALU | BPF_MOV | BPF_K] =	mov_imm,
-	[BPF_ALU | BPF_XOR | BPF_X] =	xor_reg,
-	[BPF_ALU | BPF_XOR | BPF_K] =	xor_imm,
-	[BPF_ALU | BPF_AND | BPF_X] =	and_reg,
-	[BPF_ALU | BPF_AND | BPF_K] =	and_imm,
-	[BPF_ALU | BPF_OR | BPF_X] =	or_reg,
-	[BPF_ALU | BPF_OR | BPF_K] =	or_imm,
-	[BPF_ALU | BPF_ADD | BPF_X] =	add_reg,
-	[BPF_ALU | BPF_ADD | BPF_K] =	add_imm,
-	[BPF_ALU | BPF_SUB | BPF_X] =	sub_reg,
-	[BPF_ALU | BPF_SUB | BPF_K] =	sub_imm,
-	[BPF_ALU | BPF_MUL | BPF_X] =	mul_reg,
-	[BPF_ALU | BPF_MUL | BPF_K] =	mul_imm,
-	[BPF_ALU | BPF_DIV | BPF_X] =	div_reg,
-	[BPF_ALU | BPF_DIV | BPF_K] =	div_imm,
-	[BPF_ALU | BPF_NEG] =		neg_reg,
-	[BPF_ALU | BPF_LSH | BPF_X] =	shl_reg,
-	[BPF_ALU | BPF_LSH | BPF_K] =	shl_imm,
-	[BPF_ALU | BPF_RSH | BPF_X] =	shr_reg,
-	[BPF_ALU | BPF_RSH | BPF_K] =	shr_imm,
-	[BPF_ALU | BPF_ARSH | BPF_X] =	ashr_reg,
-	[BPF_ALU | BPF_ARSH | BPF_K] =	ashr_imm,
-	[BPF_ALU | BPF_END | BPF_X] =	end_reg32,
+	[BPF_ALU32 | BPF_MOV | BPF_X] =	mov_reg,
+	[BPF_ALU32 | BPF_MOV | BPF_K] =	mov_imm,
+	[BPF_ALU32 | BPF_XOR | BPF_X] =	xor_reg,
+	[BPF_ALU32 | BPF_XOR | BPF_K] =	xor_imm,
+	[BPF_ALU32 | BPF_AND | BPF_X] =	and_reg,
+	[BPF_ALU32 | BPF_AND | BPF_K] =	and_imm,
+	[BPF_ALU32 | BPF_OR | BPF_X] =	or_reg,
+	[BPF_ALU32 | BPF_OR | BPF_K] =	or_imm,
+	[BPF_ALU32 | BPF_ADD | BPF_X] =	add_reg,
+	[BPF_ALU32 | BPF_ADD | BPF_K] =	add_imm,
+	[BPF_ALU32 | BPF_SUB | BPF_X] =	sub_reg,
+	[BPF_ALU32 | BPF_SUB | BPF_K] =	sub_imm,
+	[BPF_ALU32 | BPF_MUL | BPF_X] =	mul_reg,
+	[BPF_ALU32 | BPF_MUL | BPF_K] =	mul_imm,
+	[BPF_ALU32 | BPF_DIV | BPF_X] =	div_reg,
+	[BPF_ALU32 | BPF_DIV | BPF_K] =	div_imm,
+	[BPF_ALU32 | BPF_NEG] =		neg_reg,
+	[BPF_ALU32 | BPF_LSH | BPF_X] =	shl_reg,
+	[BPF_ALU32 | BPF_LSH | BPF_K] =	shl_imm,
+	[BPF_ALU32 | BPF_RSH | BPF_X] =	shr_reg,
+	[BPF_ALU32 | BPF_RSH | BPF_K] =	shr_imm,
+	[BPF_ALU32 | BPF_ARSH | BPF_X] = ashr_reg,
+	[BPF_ALU32 | BPF_ARSH | BPF_K] = ashr_imm,
+	[BPF_ALU32 | BPF_END | BPF_X] =	end_reg32,
 	[BPF_LD | BPF_IMM | BPF_DW] =	imm_ld8,
 	[BPF_LD | BPF_ABS | BPF_B] =	data_ld1,
 	[BPF_LD | BPF_ABS | BPF_H] =	data_ld2,
@@ -3487,53 +3487,53 @@ static const instr_cb_t instr_cb[256] = {
 	[BPF_ST | BPF_MEM | BPF_H] =	mem_st2,
 	[BPF_ST | BPF_MEM | BPF_W] =	mem_st4,
 	[BPF_ST | BPF_MEM | BPF_DW] =	mem_st8,
-	[BPF_JMP | BPF_JA | BPF_K] =	jump,
-	[BPF_JMP | BPF_JEQ | BPF_K] =	jeq_imm,
-	[BPF_JMP | BPF_JGT | BPF_K] =	cmp_imm,
-	[BPF_JMP | BPF_JGE | BPF_K] =	cmp_imm,
-	[BPF_JMP | BPF_JLT | BPF_K] =	cmp_imm,
-	[BPF_JMP | BPF_JLE | BPF_K] =	cmp_imm,
-	[BPF_JMP | BPF_JSGT | BPF_K] =  cmp_imm,
-	[BPF_JMP | BPF_JSGE | BPF_K] =  cmp_imm,
-	[BPF_JMP | BPF_JSLT | BPF_K] =  cmp_imm,
-	[BPF_JMP | BPF_JSLE | BPF_K] =  cmp_imm,
-	[BPF_JMP | BPF_JSET | BPF_K] =	jset_imm,
-	[BPF_JMP | BPF_JNE | BPF_K] =	jne_imm,
-	[BPF_JMP | BPF_JEQ | BPF_X] =	jeq_reg,
-	[BPF_JMP | BPF_JGT | BPF_X] =	cmp_reg,
-	[BPF_JMP | BPF_JGE | BPF_X] =	cmp_reg,
-	[BPF_JMP | BPF_JLT | BPF_X] =	cmp_reg,
-	[BPF_JMP | BPF_JLE | BPF_X] =	cmp_reg,
-	[BPF_JMP | BPF_JSGT | BPF_X] =  cmp_reg,
-	[BPF_JMP | BPF_JSGE | BPF_X] =  cmp_reg,
-	[BPF_JMP | BPF_JSLT | BPF_X] =  cmp_reg,
-	[BPF_JMP | BPF_JSLE | BPF_X] =  cmp_reg,
-	[BPF_JMP | BPF_JSET | BPF_X] =	jset_reg,
-	[BPF_JMP | BPF_JNE | BPF_X] =	jne_reg,
+	[BPF_JMP64 | BPF_JA | BPF_K] =	jump,
+	[BPF_JMP64 | BPF_JEQ | BPF_K] =	jeq_imm,
+	[BPF_JMP64 | BPF_JGT | BPF_K] =	cmp_imm,
+	[BPF_JMP64 | BPF_JGE | BPF_K] =	cmp_imm,
+	[BPF_JMP64 | BPF_JLT | BPF_K] =	cmp_imm,
+	[BPF_JMP64 | BPF_JLE | BPF_K] =	cmp_imm,
+	[BPF_JMP64 | BPF_JSGT | BPF_K] = cmp_imm,
+	[BPF_JMP64 | BPF_JSGE | BPF_K] = cmp_imm,
+	[BPF_JMP64 | BPF_JSLT | BPF_K] = cmp_imm,
+	[BPF_JMP64 | BPF_JSLE | BPF_K] = cmp_imm,
+	[BPF_JMP64 | BPF_JSET | BPF_K] = jset_imm,
+	[BPF_JMP64 | BPF_JNE | BPF_K] =	jne_imm,
+	[BPF_JMP64 | BPF_JEQ | BPF_X] =	jeq_reg,
+	[BPF_JMP64 | BPF_JGT | BPF_X] =	cmp_reg,
+	[BPF_JMP64 | BPF_JGE | BPF_X] =	cmp_reg,
+	[BPF_JMP64 | BPF_JLT | BPF_X] =	cmp_reg,
+	[BPF_JMP64 | BPF_JLE | BPF_X] =	cmp_reg,
+	[BPF_JMP64 | BPF_JSGT | BPF_X] = cmp_reg,
+	[BPF_JMP64 | BPF_JSGE | BPF_X] = cmp_reg,
+	[BPF_JMP64 | BPF_JSLT | BPF_X] = cmp_reg,
+	[BPF_JMP64 | BPF_JSLE | BPF_X] = cmp_reg,
+	[BPF_JMP64 | BPF_JSET | BPF_X] = jset_reg,
+	[BPF_JMP64 | BPF_JNE | BPF_X] =	jne_reg,
 	[BPF_JMP32 | BPF_JEQ | BPF_K] =	jeq32_imm,
 	[BPF_JMP32 | BPF_JGT | BPF_K] =	cmp_imm,
 	[BPF_JMP32 | BPF_JGE | BPF_K] =	cmp_imm,
 	[BPF_JMP32 | BPF_JLT | BPF_K] =	cmp_imm,
 	[BPF_JMP32 | BPF_JLE | BPF_K] =	cmp_imm,
-	[BPF_JMP32 | BPF_JSGT | BPF_K] =cmp_imm,
-	[BPF_JMP32 | BPF_JSGE | BPF_K] =cmp_imm,
-	[BPF_JMP32 | BPF_JSLT | BPF_K] =cmp_imm,
-	[BPF_JMP32 | BPF_JSLE | BPF_K] =cmp_imm,
-	[BPF_JMP32 | BPF_JSET | BPF_K] =jset_imm,
+	[BPF_JMP32 | BPF_JSGT | BPF_K] = cmp_imm,
+	[BPF_JMP32 | BPF_JSGE | BPF_K] = cmp_imm,
+	[BPF_JMP32 | BPF_JSLT | BPF_K] = cmp_imm,
+	[BPF_JMP32 | BPF_JSLE | BPF_K] = cmp_imm,
+	[BPF_JMP32 | BPF_JSET | BPF_K] = jset_imm,
 	[BPF_JMP32 | BPF_JNE | BPF_K] =	jne_imm,
 	[BPF_JMP32 | BPF_JEQ | BPF_X] =	jeq_reg,
 	[BPF_JMP32 | BPF_JGT | BPF_X] =	cmp_reg,
 	[BPF_JMP32 | BPF_JGE | BPF_X] =	cmp_reg,
 	[BPF_JMP32 | BPF_JLT | BPF_X] =	cmp_reg,
 	[BPF_JMP32 | BPF_JLE | BPF_X] =	cmp_reg,
-	[BPF_JMP32 | BPF_JSGT | BPF_X] =cmp_reg,
-	[BPF_JMP32 | BPF_JSGE | BPF_X] =cmp_reg,
-	[BPF_JMP32 | BPF_JSLT | BPF_X] =cmp_reg,
-	[BPF_JMP32 | BPF_JSLE | BPF_X] =cmp_reg,
-	[BPF_JMP32 | BPF_JSET | BPF_X] =jset_reg,
+	[BPF_JMP32 | BPF_JSGT | BPF_X] = cmp_reg,
+	[BPF_JMP32 | BPF_JSGE | BPF_X] = cmp_reg,
+	[BPF_JMP32 | BPF_JSLT | BPF_X] = cmp_reg,
+	[BPF_JMP32 | BPF_JSLE | BPF_X] = cmp_reg,
+	[BPF_JMP32 | BPF_JSET | BPF_X] = jset_reg,
 	[BPF_JMP32 | BPF_JNE | BPF_X] =	jne_reg,
-	[BPF_JMP | BPF_CALL] =		call,
-	[BPF_JMP | BPF_EXIT] =		jmp_exit,
+	[BPF_JMP64 | BPF_CALL] =	call,
+	[BPF_JMP64 | BPF_EXIT] =	jmp_exit,
 };
 
 /* --- Assembler logic --- */
@@ -3562,7 +3562,7 @@ static int nfp_fixup_branches(struct nfp_prog *nfp_prog)
 			continue;
 		if (!is_mbpf_jmp(meta))
 			continue;
-		if (meta->insn.code == (BPF_JMP | BPF_EXIT) &&
+		if (meta->insn.code == (BPF_JMP64 | BPF_EXIT) &&
 		    !nfp_is_main_function(meta))
 			continue;
 		if (is_mbpf_helper_call(meta))
@@ -3587,7 +3587,7 @@ static int nfp_fixup_branches(struct nfp_prog *nfp_prog)
 			return -ELOOP;
 		}
 
-		if (meta->insn.code == (BPF_JMP | BPF_EXIT))
+		if (meta->insn.code == (BPF_JMP64 | BPF_EXIT))
 			continue;
 
 		/* Leave special branches for later */
@@ -4292,7 +4292,7 @@ static void nfp_bpf_opt_pkt_cache(struct nfp_prog *nfp_prog)
 		insn = &meta->insn;
 
 		if (is_mbpf_store_pkt(meta) ||
-		    insn->code == (BPF_JMP | BPF_CALL) ||
+		    insn->code == (BPF_JMP64 | BPF_CALL) ||
 		    is_mbpf_classic_store_pkt(meta) ||
 		    is_mbpf_classic_load(meta)) {
 			cache_avail = false;
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/main.h b/drivers/net/ethernet/netronome/nfp/bpf/main.h
index 16841bb7..e23a588 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/main.h
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.h
@@ -370,7 +370,7 @@ static inline u8 mbpf_mode(const struct nfp_insn_meta *meta)
 
 static inline bool is_mbpf_alu(const struct nfp_insn_meta *meta)
 {
-	return mbpf_class(meta) == BPF_ALU64 || mbpf_class(meta) == BPF_ALU;
+	return mbpf_class(meta) == BPF_ALU64 || mbpf_class(meta) == BPF_ALU32;
 }
 
 static inline bool is_mbpf_load(const struct nfp_insn_meta *meta)
@@ -385,7 +385,7 @@ static inline bool is_mbpf_jmp32(const struct nfp_insn_meta *meta)
 
 static inline bool is_mbpf_jmp64(const struct nfp_insn_meta *meta)
 {
-	return mbpf_class(meta) == BPF_JMP;
+	return mbpf_class(meta) == BPF_JMP64;
 }
 
 static inline bool is_mbpf_jmp(const struct nfp_insn_meta *meta)
@@ -461,7 +461,7 @@ static inline bool is_mbpf_helper_call(const struct nfp_insn_meta *meta)
 {
 	struct bpf_insn insn = meta->insn;
 
-	return insn.code == (BPF_JMP | BPF_CALL) &&
+	return insn.code == (BPF_JMP64 | BPF_CALL) &&
 		insn.src_reg != BPF_PSEUDO_CALL;
 }
 
@@ -469,7 +469,7 @@ static inline bool is_mbpf_pseudo_call(const struct nfp_insn_meta *meta)
 {
 	struct bpf_insn insn = meta->insn;
 
-	return insn.code == (BPF_JMP | BPF_CALL) &&
+	return insn.code == (BPF_JMP64 | BPF_CALL) &&
 		insn.src_reg == BPF_PSEUDO_CALL;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index 9d235c0..e4b3e44 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -651,7 +651,7 @@ int nfp_verify_insn(struct bpf_verifier_env *env, int insn_idx,
 
 	if (is_mbpf_helper_call(meta))
 		return nfp_bpf_check_helper_call(nfp_prog, env, meta);
-	if (meta->insn.code == (BPF_JMP | BPF_EXIT))
+	if (meta->insn.code == (BPF_JMP64 | BPF_EXIT))
 		return nfp_bpf_check_exit(nfp_prog, env);
 
 	if (is_mbpf_load(meta))
@@ -816,7 +816,7 @@ int nfp_bpf_opt_replace_insn(struct bpf_verifier_env *env, u32 off,
 
 	/* conditional jump to jump conversion */
 	if (is_mbpf_cond_jump(meta) &&
-	    insn->code == (BPF_JMP | BPF_JA | BPF_K)) {
+	    insn->code == (BPF_JMP64 | BPF_JA | BPF_K)) {
 		unsigned int tgt_off;
 
 		tgt_off = off + insn->off + 1;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1727898..347fcfa 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -100,7 +100,7 @@ struct ctl_table_header;
 
 #define BPF_ALU32_REG(OP, DST, SRC)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -118,7 +118,7 @@ struct ctl_table_header;
 
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -128,7 +128,7 @@ struct ctl_table_header;
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_END | BPF_SRC(TYPE),	\
+		.code  = BPF_ALU32 | BPF_END | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -146,7 +146,7 @@ struct ctl_table_header;
 
 #define BPF_MOV32_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -164,7 +164,7 @@ struct ctl_table_header;
 
 #define BPF_MOV32_IMM(DST, IMM)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -173,7 +173,7 @@ struct ctl_table_header;
 /* Special form of mov32, used for doing explicit zero extension on dst. */
 #define BPF_ZEXT_REG(DST)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = DST,					\
 		.off   = 0,					\
@@ -181,7 +181,7 @@ struct ctl_table_header;
 
 static inline bool insn_is_zext(const struct bpf_insn *insn)
 {
-	return insn->code == (BPF_ALU | BPF_MOV | BPF_X) && insn->imm == 1;
+	return insn->code == (BPF_ALU32 | BPF_MOV | BPF_X) && insn->imm == 1;
 }
 
 /* BPF_LD_IMM64 macro encodes single 'load 64-bit immediate' insn */
@@ -218,7 +218,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_MOV32_RAW(TYPE, DST, SRC, IMM)			\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_SRC(TYPE),	\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -305,7 +305,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_JMP_REG(OP, DST, SRC, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = OFF,					\
@@ -315,7 +315,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = OFF,					\
@@ -345,7 +345,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_JMP_A(OFF)						\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_JA,			\
+		.code  = BPF_JMP64 | BPF_JA,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = OFF,					\
@@ -355,7 +355,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_CALL_REL(TGT)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_CALL,			\
+		.code  = BPF_JMP64 | BPF_CALL,			\
 		.dst_reg = 0,					\
 		.src_reg = BPF_PSEUDO_CALL,			\
 		.off   = 0,					\
@@ -367,7 +367,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_CALL,			\
+		.code  = BPF_JMP64 | BPF_CALL,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -387,7 +387,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 #define BPF_EXIT_INSN()						\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_EXIT,			\
+		.code  = BPF_JMP64 | BPF_EXIT,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 16da510..d31b38c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -409,7 +409,7 @@ static int bpf_adj_branches(struct bpf_prog *prog, u32 pos, s32 end_old,
 			continue;
 		}
 		code = insn->code;
-		if ((BPF_CLASS(code) != BPF_JMP &&
+		if ((BPF_CLASS(code) != BPF_JMP64 &&
 		     BPF_CLASS(code) != BPF_JMP32) ||
 		    BPF_OP(code) == BPF_EXIT)
 			continue;
@@ -1245,22 +1245,22 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 		goto out;
 
 	if (from->imm == 0 &&
-	    (from->code == (BPF_ALU   | BPF_MOV | BPF_K) ||
+	    (from->code == (BPF_ALU32   | BPF_MOV | BPF_K) ||
 	     from->code == (BPF_ALU64 | BPF_MOV | BPF_K))) {
 		*to++ = BPF_ALU64_REG(BPF_XOR, from->dst_reg, from->dst_reg);
 		goto out;
 	}
 
 	switch (from->code) {
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_OR  | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_MUL | BPF_K:
-	case BPF_ALU | BPF_MOV | BPF_K:
-	case BPF_ALU | BPF_DIV | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU32 | BPF_ADD | BPF_K:
+	case BPF_ALU32 | BPF_SUB | BPF_K:
+	case BPF_ALU32 | BPF_AND | BPF_K:
+	case BPF_ALU32 | BPF_OR  | BPF_K:
+	case BPF_ALU32 | BPF_XOR | BPF_K:
+	case BPF_ALU32 | BPF_MUL | BPF_K:
+	case BPF_ALU32 | BPF_MOV | BPF_K:
+	case BPF_ALU32 | BPF_DIV | BPF_K:
+	case BPF_ALU32 | BPF_MOD | BPF_K:
 		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ = BPF_ALU32_REG(from->code, from->dst_reg, BPF_REG_AX);
@@ -1280,17 +1280,17 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 		*to++ = BPF_ALU64_REG(from->code, from->dst_reg, BPF_REG_AX);
 		break;
 
-	case BPF_JMP | BPF_JEQ  | BPF_K:
-	case BPF_JMP | BPF_JNE  | BPF_K:
-	case BPF_JMP | BPF_JGT  | BPF_K:
-	case BPF_JMP | BPF_JLT  | BPF_K:
-	case BPF_JMP | BPF_JGE  | BPF_K:
-	case BPF_JMP | BPF_JLE  | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP64 | BPF_JEQ  | BPF_K:
+	case BPF_JMP64 | BPF_JNE  | BPF_K:
+	case BPF_JMP64 | BPF_JGT  | BPF_K:
+	case BPF_JMP64 | BPF_JLT  | BPF_K:
+	case BPF_JMP64 | BPF_JGE  | BPF_K:
+	case BPF_JMP64 | BPF_JLE  | BPF_K:
+	case BPF_JMP64 | BPF_JSGT | BPF_K:
+	case BPF_JMP64 | BPF_JSLT | BPF_K:
+	case BPF_JMP64 | BPF_JSGE | BPF_K:
+	case BPF_JMP64 | BPF_JSLE | BPF_K:
+	case BPF_JMP64 | BPF_JSET | BPF_K:
 		/* Accommodate for extra offset in case of a backjump. */
 		off = from->off;
 		if (off < 0)
@@ -1651,8 +1651,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		/* Now overwrite non-defaults ... */
 		BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
 		/* Non-UAPI available opcodes. */
-		[BPF_JMP | BPF_CALL_ARGS] = &&JMP_CALL_ARGS,
-		[BPF_JMP | BPF_TAIL_CALL] = &&JMP_TAIL_CALL,
+		[BPF_JMP64 | BPF_CALL_ARGS] = &&JMP_CALL_ARGS,
+		[BPF_JMP64 | BPF_TAIL_CALL] = &&JMP_TAIL_CALL,
 		[BPF_ST  | BPF_NOSPEC] = &&ST_NOSPEC,
 		[BPF_LDX | BPF_PROBE_MEM | BPF_B] = &&LDX_PROBE_MEM_B,
 		[BPF_LDX | BPF_PROBE_MEM | BPF_H] = &&LDX_PROBE_MEM_H,
@@ -2072,7 +2072,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 	insn->off = (s16) insn->imm;
 	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
 		__bpf_call_base_args;
-	insn->code = BPF_JMP | BPF_CALL_ARGS;
+	insn->code = BPF_JMP64 | BPF_CALL_ARGS;
 }
 
 #else
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 7b4afb7..53ce1b4 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -64,8 +64,8 @@ const char *const bpf_class_string[8] = {
 	[BPF_LDX]   = "ldx",
 	[BPF_ST]    = "st",
 	[BPF_STX]   = "stx",
-	[BPF_ALU]   = "alu",
-	[BPF_JMP]   = "jmp",
+	[BPF_ALU32]   = "alu",
+	[BPF_JMP64]   = "jmp",
 	[BPF_JMP32] = "jmp32",
 	[BPF_ALU64] = "alu64",
 };
@@ -135,7 +135,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 	const bpf_insn_print_t verbose = cbs->cb_print;
 	u8 class = BPF_CLASS(insn->code);
 
-	if (class == BPF_ALU || class == BPF_ALU64) {
+	if (class == BPF_ALU32 || class == BPF_ALU64) {
 		if (BPF_OP(insn->code) == BPF_END) {
 			if (class == BPF_ALU64)
 				verbose(cbs->private_data, "BUG_alu64_%02x\n", insn->code);
@@ -143,19 +143,19 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				print_bpf_end_insn(verbose, cbs->private_data, insn);
 		} else if (BPF_OP(insn->code) == BPF_NEG) {
 			verbose(cbs->private_data, "(%02x) %c%d = -%c%d\n",
-				insn->code, class == BPF_ALU ? 'w' : 'r',
-				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
+				insn->code, class == BPF_ALU32 ? 'w' : 'r',
+				insn->dst_reg, class == BPF_ALU32 ? 'w' : 'r',
 				insn->dst_reg);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data, "(%02x) %c%d %s %c%d\n",
-				insn->code, class == BPF_ALU ? 'w' : 'r',
+				insn->code, class == BPF_ALU32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_alu_string[BPF_OP(insn->code) >> 4],
-				class == BPF_ALU ? 'w' : 'r',
+				class == BPF_ALU32 ? 'w' : 'r',
 				insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "(%02x) %c%d %s %d\n",
-				insn->code, class == BPF_ALU ? 'w' : 'r',
+				insn->code, class == BPF_ALU32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_alu_string[BPF_OP(insn->code) >> 4],
 				insn->imm);
@@ -258,7 +258,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_ld_%02x\n", insn->code);
 			return;
 		}
-	} else if (class == BPF_JMP32 || class == BPF_JMP) {
+	} else if (class == BPF_JMP32 || class == BPF_JMP64) {
 		u8 opcode = BPF_OP(insn->code);
 
 		if (opcode == BPF_CALL) {
@@ -276,10 +276,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
-		} else if (insn->code == (BPF_JMP | BPF_JA)) {
+		} else if (insn->code == (BPF_JMP64 | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
-		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
+		} else if (insn->code == (BPF_JMP64 | BPF_EXIT)) {
 			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 99417b3..a96e4d2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3837,15 +3837,15 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 	for (i = 0; i < prog->len; i++) {
 		code = insns[i].code;
 
-		if (code == (BPF_JMP | BPF_TAIL_CALL)) {
-			insns[i].code = BPF_JMP | BPF_CALL;
+		if (code == (BPF_JMP64 | BPF_TAIL_CALL)) {
+			insns[i].code = BPF_JMP64 | BPF_CALL;
 			insns[i].imm = BPF_FUNC_tail_call;
 			/* fall-through */
 		}
-		if (code == (BPF_JMP | BPF_CALL) ||
-		    code == (BPF_JMP | BPF_CALL_ARGS)) {
-			if (code == (BPF_JMP | BPF_CALL_ARGS))
-				insns[i].code = BPF_JMP | BPF_CALL;
+		if (code == (BPF_JMP64 | BPF_CALL) ||
+		    code == (BPF_JMP64 | BPF_CALL_ARGS)) {
+			if (code == (BPF_JMP64 | BPF_CALL_ARGS))
+				insns[i].code = BPF_JMP64 | BPF_CALL;
 			if (!bpf_dump_raw_ok(f_cred))
 				insns[i].imm = 0;
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cc0e70..0869c50 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -123,7 +123,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  *    BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),  // after this insn R2 type is FRAME_PTR
  *    BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), // after this insn R2 type is PTR_TO_STACK
  *    BPF_LD_MAP_FD(BPF_REG_1, map_fd),      // after this insn R1 type is CONST_PTR_TO_MAP
- *    BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+ *    BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
  * here verifier looks at prototype of map_lookup_elem() and sees:
  * .arg1_type == ARG_CONST_MAP_PTR and R1->type == CONST_PTR_TO_MAP, which is ok,
  * Now verifier knows that this map has key of R1->map_ptr->key_size bytes
@@ -235,13 +235,13 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 
 static bool bpf_pseudo_call(const struct bpf_insn *insn)
 {
-	return insn->code == (BPF_JMP | BPF_CALL) &&
+	return insn->code == (BPF_JMP64 | BPF_CALL) &&
 	       insn->src_reg == BPF_PSEUDO_CALL;
 }
 
 static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
 {
-	return insn->code == (BPF_JMP | BPF_CALL) &&
+	return insn->code == (BPF_JMP64 | BPF_CALL) &&
 	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
 }
 
@@ -2453,14 +2453,14 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; i++) {
 		u8 code = insn[i].code;
 
-		if (code == (BPF_JMP | BPF_CALL) &&
+		if (code == (BPF_JMP64 | BPF_CALL) &&
 		    insn[i].imm == BPF_FUNC_tail_call &&
 		    insn[i].src_reg != BPF_PSEUDO_CALL)
 			subprog[cur_subprog].has_tail_call = true;
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
-		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
+		if (BPF_CLASS(code) != BPF_JMP64 && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
@@ -2475,8 +2475,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			 * the last insn of the subprog should be either exit
 			 * or unconditional jump back
 			 */
-			if (code != (BPF_JMP | BPF_EXIT) &&
-			    code != (BPF_JMP | BPF_JA)) {
+			if (code != (BPF_JMP64 | BPF_EXIT) &&
+			    code != (BPF_JMP64 | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				return -EINVAL;
 			}
@@ -2578,7 +2578,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	code = insn->code;
 	class = BPF_CLASS(code);
 	op = BPF_OP(code);
-	if (class == BPF_JMP) {
+	if (class == BPF_JMP64) {
 		/* BPF_EXIT for "main" will reach here. Return TRUE
 		 * conservatively.
 		 */
@@ -2602,12 +2602,12 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (class == BPF_ALU64 || class == BPF_JMP ||
-	    /* BPF_END always use BPF_ALU class. */
-	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
+	if (class == BPF_ALU64 || class == BPF_JMP64 ||
+	    /* BPF_END always use BPF_ALU32 class. */
+	    (class == BPF_ALU32 && op == BPF_END && insn->imm == 64))
 		return true;
 
-	if (class == BPF_ALU || class == BPF_JMP32)
+	if (class == BPF_ALU32 || class == BPF_JMP32)
 		return false;
 
 	if (class == BPF_LDX) {
@@ -2658,7 +2658,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 static int insn_def_regno(const struct bpf_insn *insn)
 {
 	switch (BPF_CLASS(insn->code)) {
-	case BPF_JMP:
+	case BPF_JMP64:
 	case BPF_JMP32:
 	case BPF_ST:
 		return -1;
@@ -2842,7 +2842,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
 
-	if (class == BPF_ALU || class == BPF_ALU64) {
+	if (class == BPF_ALU32 || class == BPF_ALU64) {
 		if (!(*reg_mask & dreg))
 			return 0;
 		if (opcode == BPF_MOV) {
@@ -2919,7 +2919,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 		*stack_mask &= ~(1ull << spi);
 		if (class == BPF_STX)
 			*reg_mask |= sreg;
-	} else if (class == BPF_JMP || class == BPF_JMP32) {
+	} else if (class == BPF_JMP64 || class == BPF_JMP32) {
 		if (opcode == BPF_CALL) {
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return -ENOTSUPP;
@@ -7433,7 +7433,7 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (insn->code == (BPF_JMP | BPF_CALL) &&
+	if (insn->code == (BPF_JMP64 | BPF_CALL) &&
 	    insn->src_reg == 0 &&
 	    insn->imm == BPF_FUNC_timer_set_callback) {
 		struct bpf_verifier_state *async_cb;
@@ -11211,14 +11211,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 	} else if (opcode > BPF_END) {
-		verbose(env, "invalid BPF_ALU opcode %x\n", opcode);
+		verbose(env, "invalid BPF_ALU32 opcode %x\n", opcode);
 		return -EINVAL;
 
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
 			if (insn->imm != 0 || insn->off != 0) {
-				verbose(env, "BPF_ALU uses reserved fields\n");
+				verbose(env, "BPF_ALU32 uses reserved fields\n");
 				return -EINVAL;
 			}
 			/* check src1 operand */
@@ -11227,7 +11227,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				return err;
 		} else {
 			if (insn->src_reg != BPF_REG_0 || insn->off != 0) {
-				verbose(env, "BPF_ALU uses reserved fields\n");
+				verbose(env, "BPF_ALU32 uses reserved fields\n");
 				return -EINVAL;
 			}
 		}
@@ -11997,13 +11997,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	/* Only conditional jumps are expected to reach here. */
 	if (opcode == BPF_JA || opcode > BPF_JSLE) {
-		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
+		verbose(env, "invalid BPF_JMP64/JMP32 opcode %x\n", opcode);
 		return -EINVAL;
 	}
 
 	if (BPF_SRC(insn->code) == BPF_X) {
 		if (insn->imm != 0) {
-			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
+			verbose(env, "BPF_JMP64/JMP32 uses reserved fields\n");
 			return -EINVAL;
 		}
 
@@ -12020,7 +12020,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		src_reg = &regs[insn->src_reg];
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
-			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
+			verbose(env, "BPF_JMP64/JMP32 uses reserved fields\n");
 			return -EINVAL;
 		}
 	}
@@ -12740,7 +12740,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return visit_func_call_insn(t, insns, env, true);
 
 	/* All non-branch instructions have a single fall-through edge. */
-	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
+	if (BPF_CLASS(insns[t].code) != BPF_JMP64 &&
 	    BPF_CLASS(insns[t].code) != BPF_JMP32)
 		return push_insn(t, t + 1, FALLTHROUGH, env, false);
 
@@ -14184,7 +14184,7 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
-		if (class == BPF_ALU || class == BPF_ALU64) {
+		if (class == BPF_ALU32 || class == BPF_ALU64) {
 			err = check_alu_op(env, insn);
 			if (err)
 				return err;
@@ -14303,7 +14303,7 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
-		} else if (class == BPF_JMP || class == BPF_JMP32) {
+		} else if (class == BPF_JMP64 || class == BPF_JMP32) {
 			u8 opcode = BPF_OP(insn->code);
 
 			env->jmps_processed++;
@@ -15189,7 +15189,7 @@ static bool insn_is_cond_jump(u8 code)
 	if (BPF_CLASS(code) == BPF_JMP32)
 		return true;
 
-	if (BPF_CLASS(code) != BPF_JMP)
+	if (BPF_CLASS(code) != BPF_JMP64)
 		return false;
 
 	op = BPF_OP(code);
@@ -15926,14 +15926,14 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
-		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
-		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
+		    insn->code == (BPF_ALU32 | BPF_MOD | BPF_X) ||
+		    insn->code == (BPF_ALU32 | BPF_DIV | BPF_X)) {
 			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
 			struct bpf_insn *patchlet;
 			struct bpf_insn chk_and_div[] = {
 				/* [R,W]x div 0 -> 0 */
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+				BPF_RAW_INSN((is64 ? BPF_JMP64 : BPF_JMP32) |
 					     BPF_JNE | BPF_K, insn->src_reg,
 					     0, 2, 0),
 				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
@@ -15942,7 +15942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			};
 			struct bpf_insn chk_and_mod[] = {
 				/* [R,W]x mod 0 -> [R,W]x */
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+				BPF_RAW_INSN((is64 ? BPF_JMP64 : BPF_JMP32) |
 					     BPF_JEQ | BPF_K, insn->src_reg,
 					     0, 1 + (is64 ? 0 : 1), 0),
 				*insn,
@@ -16037,7 +16037,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		if (insn->code != (BPF_JMP | BPF_CALL))
+		if (insn->code != (BPF_JMP64 | BPF_CALL))
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
@@ -16081,7 +16081,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * that doesn't support bpf_tail_call yet
 			 */
 			insn->imm = 0;
-			insn->code = BPF_JMP | BPF_TAIL_CALL;
+			insn->code = BPF_JMP64 | BPF_TAIL_CALL;
 
 			aux = &env->insn_aux_data[i + delta];
 			if (env->bpf_capable && !prog->blinding_requested &&
@@ -16511,7 +16511,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 
 static bool is_bpf_loop_call(struct bpf_insn *insn)
 {
-	return insn->code == (BPF_JMP | BPF_CALL) &&
+	return insn->code == (BPF_JMP64 | BPF_CALL) &&
 		insn->src_reg == 0 &&
 		insn->imm == BPF_FUNC_loop;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e9852d1..7ba3252 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -298,25 +298,25 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 		/* Explicitly include allowed calls. */
 		case BPF_RET | BPF_K:
 		case BPF_RET | BPF_A:
-		case BPF_ALU | BPF_ADD | BPF_K:
-		case BPF_ALU | BPF_ADD | BPF_X:
-		case BPF_ALU | BPF_SUB | BPF_K:
-		case BPF_ALU | BPF_SUB | BPF_X:
-		case BPF_ALU | BPF_MUL | BPF_K:
-		case BPF_ALU | BPF_MUL | BPF_X:
-		case BPF_ALU | BPF_DIV | BPF_K:
-		case BPF_ALU | BPF_DIV | BPF_X:
-		case BPF_ALU | BPF_AND | BPF_K:
-		case BPF_ALU | BPF_AND | BPF_X:
-		case BPF_ALU | BPF_OR | BPF_K:
-		case BPF_ALU | BPF_OR | BPF_X:
-		case BPF_ALU | BPF_XOR | BPF_K:
-		case BPF_ALU | BPF_XOR | BPF_X:
-		case BPF_ALU | BPF_LSH | BPF_K:
-		case BPF_ALU | BPF_LSH | BPF_X:
-		case BPF_ALU | BPF_RSH | BPF_K:
-		case BPF_ALU | BPF_RSH | BPF_X:
-		case BPF_ALU | BPF_NEG:
+		case BPF_ALU32 | BPF_ADD | BPF_K:
+		case BPF_ALU32 | BPF_ADD | BPF_X:
+		case BPF_ALU32 | BPF_SUB | BPF_K:
+		case BPF_ALU32 | BPF_SUB | BPF_X:
+		case BPF_ALU32 | BPF_MUL | BPF_K:
+		case BPF_ALU32 | BPF_MUL | BPF_X:
+		case BPF_ALU32 | BPF_DIV | BPF_K:
+		case BPF_ALU32 | BPF_DIV | BPF_X:
+		case BPF_ALU32 | BPF_AND | BPF_K:
+		case BPF_ALU32 | BPF_AND | BPF_X:
+		case BPF_ALU32 | BPF_OR | BPF_K:
+		case BPF_ALU32 | BPF_OR | BPF_X:
+		case BPF_ALU32 | BPF_XOR | BPF_K:
+		case BPF_ALU32 | BPF_XOR | BPF_X:
+		case BPF_ALU32 | BPF_LSH | BPF_K:
+		case BPF_ALU32 | BPF_LSH | BPF_X:
+		case BPF_ALU32 | BPF_RSH | BPF_K:
+		case BPF_ALU32 | BPF_RSH | BPF_X:
+		case BPF_ALU32 | BPF_NEG:
 		case BPF_LD | BPF_IMM:
 		case BPF_LDX | BPF_IMM:
 		case BPF_MISC | BPF_TAX:
@@ -325,15 +325,15 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 		case BPF_LDX | BPF_MEM:
 		case BPF_ST:
 		case BPF_STX:
-		case BPF_JMP | BPF_JA:
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JA:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 			continue;
 		default:
 			return -EINVAL;
@@ -749,13 +749,13 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 		case BPF_RET | BPF_K:
 			/* reached return with constant values only, check allow */
 			return k == SECCOMP_RET_ALLOW;
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			pc += insn->k;
 			break;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
 			switch (BPF_OP(code)) {
 			case BPF_JEQ:
 				op_res = reg_value == k;
@@ -776,7 +776,7 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 
 			pc += op_res ? insn->jt : insn->jf;
 			break;
-		case BPF_ALU | BPF_AND | BPF_K:
+		case BPF_ALU32 | BPF_AND | BPF_K:
 			reg_value &= k;
 			break;
 		default:
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ade9ac6..be5f161 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -142,7 +142,7 @@ static int bpf_fill_maxinsns3(struct bpf_test *self)
 	for (i = 0; i < len - 1; i++) {
 		__u32 k = prandom_u32_state(&rnd);
 
-		insn[i] = __BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, k);
+		insn[i] = __BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, k);
 	}
 
 	insn[len - 1] = __BPF_STMT(BPF_RET | BPF_A, 0);
@@ -182,7 +182,7 @@ static int bpf_fill_maxinsns5(struct bpf_test *self)
 	if (!insn)
 		return -ENOMEM;
 
-	insn[0] = __BPF_JUMP(BPF_JMP | BPF_JA, len - 2, 0, 0);
+	insn[0] = __BPF_JUMP(BPF_JMP64 | BPF_JA, len - 2, 0, 0);
 
 	for (i = 1; i < len - 1; i++)
 		insn[i] = __BPF_STMT(BPF_RET | BPF_K, 0xfefefefe);
@@ -234,7 +234,7 @@ static int bpf_fill_maxinsns7(struct bpf_test *self)
 	insn[len - 4] = __BPF_STMT(BPF_MISC | BPF_TAX, 0);
 	insn[len - 3] = __BPF_STMT(BPF_LD | BPF_W | BPF_ABS, SKF_AD_OFF +
 				   SKF_AD_CPU);
-	insn[len - 2] = __BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0);
+	insn[len - 2] = __BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_X, 0);
 	insn[len - 1] = __BPF_STMT(BPF_RET | BPF_A, 0);
 
 	self->u.ptr.insns = insn;
@@ -256,7 +256,7 @@ static int bpf_fill_maxinsns8(struct bpf_test *self)
 	insn[0] = __BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff);
 
 	for (i = 1; i < len - 1; i++)
-		insn[i] = __BPF_JUMP(BPF_JMP | BPF_JGT, 0xffffffff, jmp_off--, 0);
+		insn[i] = __BPF_JUMP(BPF_JMP64 | BPF_JGT, 0xffffffff, jmp_off--, 0);
 
 	insn[len - 1] = __BPF_STMT(BPF_RET | BPF_A, 0);
 
@@ -332,10 +332,10 @@ static int __bpf_fill_ja(struct bpf_test *self, unsigned int len,
 
 	for (i = 0; i + plen < len; i += plen)
 		for (j = 0; j < plen; j++)
-			insn[i + j] = __BPF_JUMP(BPF_JMP | BPF_JA,
+			insn[i + j] = __BPF_JUMP(BPF_JMP64 | BPF_JA,
 						 plen - 1 - j, 0, 0);
 	for (j = 0; j < rlen; j++)
-		insn[i + j] = __BPF_JUMP(BPF_JMP | BPF_JA, rlen - 1 - j,
+		insn[i + j] = __BPF_JUMP(BPF_JMP64 | BPF_JA, rlen - 1 - j,
 					 0, 0);
 
 	insn[len - 1] = __BPF_STMT(BPF_RET | BPF_K, 0xababcbac);
@@ -362,7 +362,7 @@ static int bpf_fill_maxinsns12(struct bpf_test *self)
 	if (!insn)
 		return -ENOMEM;
 
-	insn[0] = __BPF_JUMP(BPF_JMP | BPF_JA, len - 2, 0, 0);
+	insn[0] = __BPF_JUMP(BPF_JMP64 | BPF_JA, len - 2, 0, 0);
 
 	for (i = 1; i < len - 1; i++)
 		insn[i] = __BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
@@ -389,7 +389,7 @@ static int bpf_fill_maxinsns13(struct bpf_test *self)
 		insn[i] = __BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
 
 	insn[len - 3] = __BPF_STMT(BPF_LD | BPF_IMM, 0xabababab);
-	insn[len - 2] = __BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0);
+	insn[len - 2] = __BPF_STMT(BPF_ALU32 | BPF_XOR | BPF_X, 0);
 	insn[len - 1] = __BPF_STMT(BPF_RET | BPF_A, 0);
 
 	self->u.ptr.insns = insn;
@@ -3067,11 +3067,11 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_IMM, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 2),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
-			BPF_STMT(BPF_ALU | BPF_NEG, 0), /* A == -3 */
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_NEG, 0), /* A == -3 */
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_LEN, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0), /* X == len - 3 */
 			BPF_STMT(BPF_LD | BPF_B | BPF_IND, 1),
 			BPF_STMT(BPF_RET | BPF_A, 0)
@@ -3085,7 +3085,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0) /* A == len * 2 */
 		},
 		CLASSIC,
@@ -3096,11 +3096,11 @@ static struct bpf_test tests[] = {
 		"ADD_SUB_MUL_K",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, 1),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 2),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 2),
 			BPF_STMT(BPF_LDX | BPF_IMM, 3),
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0xffffffff),
-			BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 3),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 0xffffffff),
+			BPF_STMT(BPF_ALU32 | BPF_MUL | BPF_K, 3),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -3111,20 +3111,20 @@ static struct bpf_test tests[] = {
 		"DIV_MOD_KX",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, 8),
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 2),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_K, 2),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_X, 0),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x70000000),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_K, 0x70000000),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
-			BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_MOD | BPF_X, 0),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
-			BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x70000000),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_MOD | BPF_K, 0x70000000),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -3135,12 +3135,12 @@ static struct bpf_test tests[] = {
 		"AND_OR_LSH_K",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, 0xff),
-			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
-			BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 27),
+			BPF_STMT(BPF_ALU32 | BPF_AND | BPF_K, 0xf0),
+			BPF_STMT(BPF_ALU32 | BPF_LSH | BPF_K, 27),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xf),
-			BPF_STMT(BPF_ALU | BPF_OR | BPF_K, 0xf0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_OR | BPF_K, 0xf0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -3151,7 +3151,7 @@ static struct bpf_test tests[] = {
 		"LD_IMM_0",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, 0), /* ld #0 */
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 		},
@@ -3186,7 +3186,7 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF + 1),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC,
@@ -3198,7 +3198,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, SKF_LL_OFF - 1),
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
@@ -3213,7 +3213,7 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF + 1),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC,
@@ -3225,7 +3225,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_IMM, SKF_NET_OFF - 15),
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
@@ -3239,15 +3239,15 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 SKF_AD_OFF + SKF_AD_PKTTYPE),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 SKF_AD_OFF + SKF_AD_PKTTYPE),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 SKF_AD_OFF + SKF_AD_PKTTYPE),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
@@ -3292,13 +3292,13 @@ static struct bpf_test tests[] = {
 		"LD_PROTOCOL",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 1),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 20, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 20, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0),
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 SKF_AD_OFF + SKF_AD_PROTOCOL),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 30, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 30, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
@@ -3365,7 +3365,7 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 SKF_AD_OFF + SKF_AD_CPU),
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC,
@@ -3473,17 +3473,17 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 2),
-			BPF_STMT(BPF_ALU | BPF_RSH, 1),
-			BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_RSH, 1),
+			BPF_STMT(BPF_ALU32 | BPF_XOR | BPF_X, 0),
 			BPF_STMT(BPF_ST, 1), /* M1 = 1 ^ len */
-			BPF_STMT(BPF_ALU | BPF_XOR | BPF_K, 0x80000000),
+			BPF_STMT(BPF_ALU32 | BPF_XOR | BPF_K, 0x80000000),
 			BPF_STMT(BPF_ST, 2), /* M2 = 1 ^ len ^ 0x80000000 */
 			BPF_STMT(BPF_STX, 15), /* M3 = len */
 			BPF_STMT(BPF_LDX | BPF_MEM, 1),
 			BPF_STMT(BPF_LD | BPF_MEM, 2),
-			BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_XOR | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 15),
-			BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_XOR | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0)
 		},
 		CLASSIC,
@@ -3495,7 +3495,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3508,7 +3508,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
-			BPF_JUMP(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3521,7 +3521,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3534,7 +3534,7 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3547,13 +3547,13 @@ static struct bpf_test tests[] = {
 		.u.insns = {
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_LD | BPF_B | BPF_IND, MAX_K),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 1, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_K, 1, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 10),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 2, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_K, 2, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 20),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 3, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_K, 3, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 4, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_K, 4, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 40),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3564,28 +3564,28 @@ static struct bpf_test tests[] = {
 	{
 		"JSET",
 		.u.insns = {
-			BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
-			BPF_JUMP(BPF_JMP | BPF_JA, 1, 1, 1),
-			BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
-			BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JA, 0, 0, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JA, 1, 1, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JA, 0, 0, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JA, 0, 0, 0),
 			BPF_STMT(BPF_LDX | BPF_LEN, 0),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, 4),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_K, 4),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_W | BPF_IND, 0),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 1, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 1, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 10),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x80000000, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0x80000000, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 20),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0xffffff, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0xffffff, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0xffffff, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0xffffff, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0xffffff, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 30),
 			BPF_STMT(BPF_RET | BPF_K, MAX_K)
 		},
@@ -3597,27 +3597,27 @@ static struct bpf_test tests[] = {
 		"tcpdump port 22",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 0, 8), /* IPv6 */
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x86dd, 0, 8), /* IPv6 */
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 20),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 17),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x84, 2, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x6, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x11, 0, 17),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 54),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 14, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 14, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 56),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 12, 13),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0800, 0, 12), /* IPv4 */
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 12, 13),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x0800, 0, 12), /* IPv4 */
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 8),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x84, 2, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x6, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x11, 0, 8),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 6, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0x1fff, 6, 0),
 			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
 			BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 2, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 0xffff),
 			BPF_STMT(BPF_RET | BPF_K, 0),
 		},
@@ -3646,36 +3646,36 @@ static struct bpf_test tests[] = {
 			 * (len > 115 or len < 30000000000)' -d
 			 */
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 30, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x800, 0, 29),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x86dd, 30, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x800, 0, 29),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 0, 27),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x6, 0, 27),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
-			BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 25, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JSET | BPF_K, 0x1fff, 25, 0),
 			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
 			BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 2, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 20),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 22, 0, 20),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 16),
 			BPF_STMT(BPF_ST, 1),
 			BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 14),
-			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf),
-			BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 2),
+			BPF_STMT(BPF_ALU32 | BPF_AND | BPF_K, 0xf),
+			BPF_STMT(BPF_ALU32 | BPF_LSH | BPF_K, 2),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0x5), /* libpcap emits K on TAX */
 			BPF_STMT(BPF_LD | BPF_MEM, 1),
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_X, 0),
 			BPF_STMT(BPF_ST, 5),
 			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
 			BPF_STMT(BPF_LD | BPF_B | BPF_IND, 26),
-			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
-			BPF_STMT(BPF_ALU | BPF_RSH | BPF_K, 2),
+			BPF_STMT(BPF_ALU32 | BPF_AND | BPF_K, 0xf0),
+			BPF_STMT(BPF_ALU32 | BPF_RSH | BPF_K, 2),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0x9), /* libpcap emits K on TAX */
 			BPF_STMT(BPF_LD | BPF_MEM, 5),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 4, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 4, 0),
 			BPF_STMT(BPF_LD | BPF_LEN, 0),
-			BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, 0x73, 1, 0),
-			BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 0xfc23ac00, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGT | BPF_K, 0x73, 1, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE | BPF_K, 0xfc23ac00, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0xffff),
 			BPF_STMT(BPF_RET | BPF_K, 0),
 		},
@@ -4545,7 +4545,7 @@ static struct bpf_test tests[] = {
 	{
 		"check: div_k_0",
 		.u.insns = {
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_K, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0)
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
@@ -4583,7 +4583,7 @@ static struct bpf_test tests[] = {
 		"JUMPS + HOLES",
 		.u.insns = {
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 15),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE, 0, 13, 15),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
@@ -4597,12 +4597,12 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 3, 4),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x90c2894d, 3, 4),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 1, 2),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x90c2894d, 1, 2),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
-			BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE, 0, 14, 15),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE, 0, 13, 14),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
@@ -4616,11 +4616,11 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 2, 3),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 1, 2),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x2ac28349, 2, 3),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x2ac28349, 1, 2),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
-			BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE, 0, 14, 15),
+			BPF_JUMP(BPF_JMP64 | BPF_JGE, 0, 13, 14),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
@@ -4634,8 +4634,8 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 2, 3),
-			BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 1, 2),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x90d2ff41, 2, 3),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ, 0x90d2ff41, 1, 2),
 			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0),
@@ -4691,82 +4691,82 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_STX, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 0),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 1),
 			BPF_STMT(BPF_LDX | BPF_MEM, 1),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 2),
 			BPF_STMT(BPF_LDX | BPF_MEM, 2),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 3),
 			BPF_STMT(BPF_LDX | BPF_MEM, 3),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 4),
 			BPF_STMT(BPF_LDX | BPF_MEM, 4),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 5),
 			BPF_STMT(BPF_LDX | BPF_MEM, 5),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 6),
 			BPF_STMT(BPF_LDX | BPF_MEM, 6),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 7),
 			BPF_STMT(BPF_LDX | BPF_MEM, 7),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 8),
 			BPF_STMT(BPF_LDX | BPF_MEM, 8),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 9),
 			BPF_STMT(BPF_LDX | BPF_MEM, 9),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 10),
 			BPF_STMT(BPF_LDX | BPF_MEM, 10),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 11),
 			BPF_STMT(BPF_LDX | BPF_MEM, 11),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 12),
 			BPF_STMT(BPF_LDX | BPF_MEM, 12),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 13),
 			BPF_STMT(BPF_LDX | BPF_MEM, 13),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 14),
 			BPF_STMT(BPF_LDX | BPF_MEM, 14),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_STX, 15),
 			BPF_STMT(BPF_LDX | BPF_MEM, 15),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 1),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0),
 		},
@@ -4812,35 +4812,35 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LDX | BPF_MEM, 0),
 			BPF_STMT(BPF_MISC | BPF_TXA, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 1),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 2),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 3),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 4),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 5),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 6),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 7),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 8),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 9),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 10),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 11),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 12),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 13),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 14),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_LDX | BPF_MEM, 15),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -4893,7 +4893,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } }
 	},
-	/* BPF_ALU | BPF_MOV | BPF_X */
+	/* BPF_ALU32 | BPF_MOV | BPF_X */
 	{
 		"ALU_MOV_X: dst = 2",
 		.u.insns_int = {
@@ -4938,7 +4938,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 4294967295U } },
 	},
-	/* BPF_ALU | BPF_MOV | BPF_K */
+	/* BPF_ALU32 | BPF_MOV | BPF_K */
 	{
 		"ALU_MOV_K: dst = 2",
 		.u.insns_int = {
@@ -5111,7 +5111,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } }
 	},
-	/* BPF_ALU | BPF_ADD | BPF_X */
+	/* BPF_ALU32 | BPF_ADD | BPF_X */
 	{
 		"ALU_ADD_X: 1 + 2 = 3",
 		.u.insns_int = {
@@ -5193,7 +5193,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_ALU | BPF_ADD | BPF_K */
+	/* BPF_ALU32 | BPF_ADD | BPF_K */
 	{
 		"ALU_ADD_K: 1 + 2 = 3",
 		.u.insns_int = {
@@ -5478,7 +5478,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
-	/* BPF_ALU | BPF_SUB | BPF_X */
+	/* BPF_ALU32 | BPF_SUB | BPF_X */
 	{
 		"ALU_SUB_X: 3 - 1 = 2",
 		.u.insns_int = {
@@ -5527,7 +5527,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_ALU | BPF_SUB | BPF_K */
+	/* BPF_ALU32 | BPF_SUB | BPF_K */
 	{
 		"ALU_SUB_K: 3 - 1 = 2",
 		.u.insns_int = {
@@ -5605,7 +5605,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, -1 } },
 	},
-	/* BPF_ALU | BPF_MUL | BPF_X */
+	/* BPF_ALU32 | BPF_MUL | BPF_X */
 	{
 		"ALU_MUL_X: 2 * 3 = 6",
 		.u.insns_int = {
@@ -5691,7 +5691,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x2236d88f } }
 	},
-	/* BPF_ALU | BPF_MUL | BPF_K */
+	/* BPF_ALU32 | BPF_MUL | BPF_K */
 	{
 		"ALU_MUL_K: 2 * 3 = 6",
 		.u.insns_int = {
@@ -5824,7 +5824,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xc28f5c28 } }
 	},
-	/* BPF_ALU | BPF_DIV | BPF_X */
+	/* BPF_ALU32 | BPF_DIV | BPF_X */
 	{
 		"ALU_DIV_X: 6 / 2 = 3",
 		.u.insns_int = {
@@ -5890,7 +5890,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
-	/* BPF_ALU | BPF_DIV | BPF_K */
+	/* BPF_ALU32 | BPF_DIV | BPF_K */
 	{
 		"ALU_DIV_K: 6 / 2 = 3",
 		.u.insns_int = {
@@ -5989,7 +5989,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
-	/* BPF_ALU | BPF_MOD | BPF_X */
+	/* BPF_ALU32 | BPF_MOD | BPF_X */
 	{
 		"ALU_MOD_X: 3 % 2 = 1",
 		.u.insns_int = {
@@ -6038,7 +6038,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 2 } },
 	},
-	/* BPF_ALU | BPF_MOD | BPF_K */
+	/* BPF_ALU32 | BPF_MOD | BPF_K */
 	{
 		"ALU_MOD_K: 3 % 2 = 1",
 		.u.insns_int = {
@@ -6105,7 +6105,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 2 } },
 	},
-	/* BPF_ALU | BPF_AND | BPF_X */
+	/* BPF_ALU32 | BPF_AND | BPF_X */
 	{
 		"ALU_AND_X: 3 & 2 = 2",
 		.u.insns_int = {
@@ -6154,7 +6154,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } },
 	},
-	/* BPF_ALU | BPF_AND | BPF_K */
+	/* BPF_ALU32 | BPF_AND | BPF_K */
 	{
 		"ALU_AND_K: 3 & 2 = 2",
 		.u.insns_int = {
@@ -6317,7 +6317,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } }
 	},
-	/* BPF_ALU | BPF_OR | BPF_X */
+	/* BPF_ALU32 | BPF_OR | BPF_X */
 	{
 		"ALU_OR_X: 1 | 2 = 3",
 		.u.insns_int = {
@@ -6366,7 +6366,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } },
 	},
-	/* BPF_ALU | BPF_OR | BPF_K */
+	/* BPF_ALU32 | BPF_OR | BPF_K */
 	{
 		"ALU_OR_K: 1 | 2 = 3",
 		.u.insns_int = {
@@ -6529,7 +6529,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } }
 	},
-	/* BPF_ALU | BPF_XOR | BPF_X */
+	/* BPF_ALU32 | BPF_XOR | BPF_X */
 	{
 		"ALU_XOR_X: 5 ^ 6 = 3",
 		.u.insns_int = {
@@ -6578,7 +6578,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xfffffffe } },
 	},
-	/* BPF_ALU | BPF_XOR | BPF_K */
+	/* BPF_ALU32 | BPF_XOR | BPF_K */
 	{
 		"ALU_XOR_K: 5 ^ 6 = 3",
 		.u.insns_int = {
@@ -6741,7 +6741,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } }
 	},
-	/* BPF_ALU | BPF_LSH | BPF_X */
+	/* BPF_ALU32 | BPF_LSH | BPF_X */
 	{
 		"ALU_LSH_X: 1 << 1 = 2",
 		.u.insns_int = {
@@ -6902,7 +6902,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x01234567 } }
 	},
-	/* BPF_ALU | BPF_LSH | BPF_K */
+	/* BPF_ALU32 | BPF_LSH | BPF_K */
 	{
 		"ALU_LSH_K: 1 << 1 = 2",
 		.u.insns_int = {
@@ -7049,7 +7049,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x89abcdef } }
 	},
-	/* BPF_ALU | BPF_RSH | BPF_X */
+	/* BPF_ALU32 | BPF_RSH | BPF_X */
 	{
 		"ALU_RSH_X: 2 >> 1 = 1",
 		.u.insns_int = {
@@ -7210,7 +7210,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x81234567 } }
 	},
-	/* BPF_ALU | BPF_RSH | BPF_K */
+	/* BPF_ALU32 | BPF_RSH | BPF_K */
 	{
 		"ALU_RSH_K: 2 >> 1 = 1",
 		.u.insns_int = {
@@ -7357,7 +7357,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x89abcdef } }
 	},
-	/* BPF_ALU | BPF_ARSH | BPF_X */
+	/* BPF_ALU32 | BPF_ARSH | BPF_X */
 	{
 		"ALU32_ARSH_X: -1234 >> 7 = -10",
 		.u.insns_int = {
@@ -7482,7 +7482,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x81234567 } }
 	},
-	/* BPF_ALU | BPF_ARSH | BPF_K */
+	/* BPF_ALU32 | BPF_ARSH | BPF_K */
 	{
 		"ALU32_ARSH_K: -1234 >> 7 = -10",
 		.u.insns_int = {
@@ -7596,7 +7596,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x89abcdef } }
 	},
-	/* BPF_ALU | BPF_NEG */
+	/* BPF_ALU32 | BPF_NEG */
 	{
 		"ALU_NEG: -(3) = -3",
 		.u.insns_int = {
@@ -7641,7 +7641,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 3 } },
 	},
-	/* BPF_ALU | BPF_END | BPF_FROM_BE */
+	/* BPF_ALU32 | BPF_END | BPF_FROM_BE */
 	{
 		"ALU_END_FROM_BE 16: 0x0123456789abcdef -> 0xcdef",
 		.u.insns_int = {
@@ -7690,7 +7690,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) (cpu_to_be64(0x0123456789abcdefLL) >> 32) } },
 	},
-	/* BPF_ALU | BPF_END | BPF_FROM_BE, reversed */
+	/* BPF_ALU32 | BPF_END | BPF_FROM_BE, reversed */
 	{
 		"ALU_END_FROM_BE 16: 0xfedcba9876543210 -> 0x3210",
 		.u.insns_int = {
@@ -7739,7 +7739,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) (cpu_to_be64(0xfedcba9876543210ULL) >> 32) } },
 	},
-	/* BPF_ALU | BPF_END | BPF_FROM_LE */
+	/* BPF_ALU32 | BPF_END | BPF_FROM_LE */
 	{
 		"ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd",
 		.u.insns_int = {
@@ -7788,7 +7788,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) (cpu_to_le64(0x0123456789abcdefLL) >> 32) } },
 	},
-	/* BPF_ALU | BPF_END | BPF_FROM_LE, reversed */
+	/* BPF_ALU32 | BPF_END | BPF_FROM_LE, reversed */
 	{
 		"ALU_END_FROM_LE 16: 0xfedcba9876543210 -> 0x1032",
 		.u.insns_int = {
@@ -9448,7 +9448,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, -12345678 } }
 	},
-	/* BPF_JMP | BPF_EXIT */
+	/* BPF_JMP64 | BPF_EXIT */
 	{
 		"JMP_EXIT",
 		.u.insns_int = {
@@ -9460,7 +9460,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x4711 } },
 	},
-	/* BPF_JMP | BPF_JA */
+	/* BPF_JMP64 | BPF_JA */
 	{
 		"JMP_JA: Unconditional jump: if (true) return 1",
 		.u.insns_int = {
@@ -9474,7 +9474,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSLT | BPF_K */
+	/* BPF_JMP64 | BPF_JSLT | BPF_K */
 	{
 		"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
 		.u.insns_int = {
@@ -9503,7 +9503,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSGT | BPF_K */
+	/* BPF_JMP64 | BPF_JSGT | BPF_K */
 	{
 		"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
 		.u.insns_int = {
@@ -9532,7 +9532,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSLE | BPF_K */
+	/* BPF_JMP64 | BPF_JSLE | BPF_K */
 	{
 		"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
 		.u.insns_int = {
@@ -9599,7 +9599,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSGE | BPF_K */
+	/* BPF_JMP64 | BPF_JSGE | BPF_K */
 	{
 		"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
 		.u.insns_int = {
@@ -9666,7 +9666,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JGT | BPF_K */
+	/* BPF_JMP64 | BPF_JGT | BPF_K */
 	{
 		"JMP_JGT_K: if (3 > 2) return 1",
 		.u.insns_int = {
@@ -9695,7 +9695,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JLT | BPF_K */
+	/* BPF_JMP64 | BPF_JLT | BPF_K */
 	{
 		"JMP_JLT_K: if (2 < 3) return 1",
 		.u.insns_int = {
@@ -9724,7 +9724,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JGE | BPF_K */
+	/* BPF_JMP64 | BPF_JGE | BPF_K */
 	{
 		"JMP_JGE_K: if (3 >= 2) return 1",
 		.u.insns_int = {
@@ -9739,7 +9739,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JLE | BPF_K */
+	/* BPF_JMP64 | BPF_JLE | BPF_K */
 	{
 		"JMP_JLE_K: if (2 <= 3) return 1",
 		.u.insns_int = {
@@ -9754,7 +9754,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
+	/* BPF_JMP64 | BPF_JGT | BPF_K jump backwards */
 	{
 		"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
 		.u.insns_int = {
@@ -9784,7 +9784,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
+	/* BPF_JMP64 | BPF_JLT | BPF_K jump backwards */
 	{
 		"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
 		.u.insns_int = {
@@ -9814,7 +9814,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JNE | BPF_K */
+	/* BPF_JMP64 | BPF_JNE | BPF_K */
 	{
 		"JMP_JNE_K: if (3 != 2) return 1",
 		.u.insns_int = {
@@ -9829,7 +9829,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JEQ | BPF_K */
+	/* BPF_JMP64 | BPF_JEQ | BPF_K */
 	{
 		"JMP_JEQ_K: if (3 == 3) return 1",
 		.u.insns_int = {
@@ -9844,7 +9844,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSET | BPF_K */
+	/* BPF_JMP64 | BPF_JSET | BPF_K */
 	{
 		"JMP_JSET_K: if (0x3 & 0x2) return 1",
 		.u.insns_int = {
@@ -9873,7 +9873,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSGT | BPF_X */
+	/* BPF_JMP64 | BPF_JSGT | BPF_X */
 	{
 		"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
 		.u.insns_int = {
@@ -9904,7 +9904,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSLT | BPF_X */
+	/* BPF_JMP64 | BPF_JSLT | BPF_X */
 	{
 		"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
 		.u.insns_int = {
@@ -9935,7 +9935,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSGE | BPF_X */
+	/* BPF_JMP64 | BPF_JSGE | BPF_X */
 	{
 		"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
 		.u.insns_int = {
@@ -9966,7 +9966,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSLE | BPF_X */
+	/* BPF_JMP64 | BPF_JSLE | BPF_X */
 	{
 		"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
 		.u.insns_int = {
@@ -9997,7 +9997,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JGT | BPF_X */
+	/* BPF_JMP64 | BPF_JGT | BPF_X */
 	{
 		"JMP_JGT_X: if (3 > 2) return 1",
 		.u.insns_int = {
@@ -10028,7 +10028,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JLT | BPF_X */
+	/* BPF_JMP64 | BPF_JLT | BPF_X */
 	{
 		"JMP_JLT_X: if (2 < 3) return 1",
 		.u.insns_int = {
@@ -10059,7 +10059,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JGE | BPF_X */
+	/* BPF_JMP64 | BPF_JGE | BPF_X */
 	{
 		"JMP_JGE_X: if (3 >= 2) return 1",
 		.u.insns_int = {
@@ -10090,7 +10090,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JLE | BPF_X */
+	/* BPF_JMP64 | BPF_JLE | BPF_X */
 	{
 		"JMP_JLE_X: if (2 <= 3) return 1",
 		.u.insns_int = {
@@ -10210,7 +10210,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JNE | BPF_X */
+	/* BPF_JMP64 | BPF_JNE | BPF_X */
 	{
 		"JMP_JNE_X: if (3 != 2) return 1",
 		.u.insns_int = {
@@ -10226,7 +10226,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JEQ | BPF_X */
+	/* BPF_JMP64 | BPF_JEQ | BPF_X */
 	{
 		"JMP_JEQ_X: if (3 == 3) return 1",
 		.u.insns_int = {
@@ -10242,7 +10242,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
-	/* BPF_JMP | BPF_JSET | BPF_X */
+	/* BPF_JMP64 | BPF_JSET | BPF_X */
 	{
 		"JMP_JSET_X: if (0x3 & 0x2) return 1",
 		.u.insns_int = {
@@ -11207,7 +11207,7 @@ static struct bpf_test tests[] = {
 			 * ret A
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11221,7 +11221,7 @@ static struct bpf_test tests[] = {
 			 * A = A + 0x42
 			 * ret A
 			 */
-			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
+			BPF_STMT(BPF_ALU32 | BPF_ADD | BPF_K, 0x42),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11237,7 +11237,7 @@ static struct bpf_test tests[] = {
 			 * ret A
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x66),
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11251,7 +11251,7 @@ static struct bpf_test tests[] = {
 			 * A = A - -0x66
 			 * ret A
 			 */
-			BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
+			BPF_STMT(BPF_ALU32 | BPF_SUB | BPF_K, -0x66),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11267,7 +11267,7 @@ static struct bpf_test tests[] = {
 			 * ret A
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
-			BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_MUL | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11281,7 +11281,7 @@ static struct bpf_test tests[] = {
 			 * A = A * 0x66
 			 * ret A
 			 */
-			BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
+			BPF_STMT(BPF_ALU32 | BPF_MUL | BPF_K, 0x66),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11297,7 +11297,7 @@ static struct bpf_test tests[] = {
 			 * ret 0x42
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0x42),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11311,7 +11311,7 @@ static struct bpf_test tests[] = {
 			 * A = A / 1
 			 * ret A
 			 */
-			BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
+			BPF_STMT(BPF_ALU32 | BPF_DIV | BPF_K, 0x1),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11327,7 +11327,7 @@ static struct bpf_test tests[] = {
 			 * ret 0x42
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
-			BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
+			BPF_STMT(BPF_ALU32 | BPF_MOD | BPF_X, 0),
 			BPF_STMT(BPF_RET | BPF_K, 0x42),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11341,7 +11341,7 @@ static struct bpf_test tests[] = {
 			 * A = A mod 1
 			 * ret A
 			 */
-			BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
+			BPF_STMT(BPF_ALU32 | BPF_MOD | BPF_K, 0x1),
 			BPF_STMT(BPF_RET | BPF_A, 0x0),
 		},
 		CLASSIC | FLAG_NO_DATA,
@@ -11356,7 +11356,7 @@ static struct bpf_test tests[] = {
 			 * ret 0x42
 			 * ret 0x66
 			 */
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0x0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 0x42),
 			BPF_STMT(BPF_RET | BPF_K, 0x66),
 		},
@@ -11374,7 +11374,7 @@ static struct bpf_test tests[] = {
 			 * ret 0x66
 			 */
 			BPF_STMT(BPF_LD | BPF_IMM, 0x0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_X, 0x0, 0, 1),
 			BPF_STMT(BPF_RET | BPF_K, 0x42),
 			BPF_STMT(BPF_RET | BPF_K, 0x66),
 		},
@@ -11477,8 +11477,8 @@ static struct bpf_test tests[] = {
 			BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
 			BPF_STMT(BPF_MISC | BPF_TAX, 0),
 			BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
-			BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
+			BPF_STMT(BPF_ALU32 | BPF_AND | BPF_X, 0),
+			BPF_JUMP(BPF_JMP64 | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
 			BPF_STMT(BPF_RET | BPF_K, 1),
 			BPF_STMT(BPF_RET | BPF_K, 2),
 		},
@@ -14874,7 +14874,7 @@ struct tail_call_test {
 
 #define TAIL_CALL(offset)			       \
 	BPF_LD_IMM64(R2, TAIL_CALL_MARKER),	       \
-	BPF_RAW_INSN(BPF_ALU | BPF_MOV | BPF_K, R3, 0, \
+	BPF_RAW_INSN(BPF_ALU32 | BPF_MOV | BPF_K, R3, 0, \
 		     offset, TAIL_CALL_MARKER),	       \
 	BPF_JMP_IMM(BPF_TAIL_CALL, 0, 0, 0)
 
@@ -15101,7 +15101,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 				insn[1].imm = ((u64)(long)progs) >> 32;
 				break;
 
-			case BPF_ALU | BPF_MOV | BPF_K:
+			case BPF_ALU32 | BPF_MOV | BPF_K:
 				if (insn->imm != TAIL_CALL_MARKER)
 					break;
 				if (insn->off == TAIL_CALL_NULL)
@@ -15113,7 +15113,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 				insn->off = 0;
 				break;
 
-			case BPF_JMP | BPF_CALL:
+			case BPF_JMP64 | BPF_CALL:
 				if (insn->src_reg != BPF_PSEUDO_CALL)
 					break;
 				switch (insn->imm) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 0039cf1..1cd5897 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -625,27 +625,27 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 
 		switch (fp->code) {
 		/* All arithmetic insns and skb loads map as-is. */
-		case BPF_ALU | BPF_ADD | BPF_X:
-		case BPF_ALU | BPF_ADD | BPF_K:
-		case BPF_ALU | BPF_SUB | BPF_X:
-		case BPF_ALU | BPF_SUB | BPF_K:
-		case BPF_ALU | BPF_AND | BPF_X:
-		case BPF_ALU | BPF_AND | BPF_K:
-		case BPF_ALU | BPF_OR | BPF_X:
-		case BPF_ALU | BPF_OR | BPF_K:
-		case BPF_ALU | BPF_LSH | BPF_X:
-		case BPF_ALU | BPF_LSH | BPF_K:
-		case BPF_ALU | BPF_RSH | BPF_X:
-		case BPF_ALU | BPF_RSH | BPF_K:
-		case BPF_ALU | BPF_XOR | BPF_X:
-		case BPF_ALU | BPF_XOR | BPF_K:
-		case BPF_ALU | BPF_MUL | BPF_X:
-		case BPF_ALU | BPF_MUL | BPF_K:
-		case BPF_ALU | BPF_DIV | BPF_X:
-		case BPF_ALU | BPF_DIV | BPF_K:
-		case BPF_ALU | BPF_MOD | BPF_X:
-		case BPF_ALU | BPF_MOD | BPF_K:
-		case BPF_ALU | BPF_NEG:
+		case BPF_ALU32 | BPF_ADD | BPF_X:
+		case BPF_ALU32 | BPF_ADD | BPF_K:
+		case BPF_ALU32 | BPF_SUB | BPF_X:
+		case BPF_ALU32 | BPF_SUB | BPF_K:
+		case BPF_ALU32 | BPF_AND | BPF_X:
+		case BPF_ALU32 | BPF_AND | BPF_K:
+		case BPF_ALU32 | BPF_OR | BPF_X:
+		case BPF_ALU32 | BPF_OR | BPF_K:
+		case BPF_ALU32 | BPF_LSH | BPF_X:
+		case BPF_ALU32 | BPF_LSH | BPF_K:
+		case BPF_ALU32 | BPF_RSH | BPF_X:
+		case BPF_ALU32 | BPF_RSH | BPF_K:
+		case BPF_ALU32 | BPF_XOR | BPF_X:
+		case BPF_ALU32 | BPF_XOR | BPF_K:
+		case BPF_ALU32 | BPF_MUL | BPF_X:
+		case BPF_ALU32 | BPF_MUL | BPF_K:
+		case BPF_ALU32 | BPF_DIV | BPF_X:
+		case BPF_ALU32 | BPF_DIV | BPF_K:
+		case BPF_ALU32 | BPF_MOD | BPF_X:
+		case BPF_ALU32 | BPF_MOD | BPF_K:
+		case BPF_ALU32 | BPF_NEG:
 		case BPF_LD | BPF_ABS | BPF_W:
 		case BPF_LD | BPF_ABS | BPF_H:
 		case BPF_LD | BPF_ABS | BPF_B:
@@ -666,8 +666,8 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 				break;
 			}
 
-			if (fp->code == (BPF_ALU | BPF_DIV | BPF_X) ||
-			    fp->code == (BPF_ALU | BPF_MOD | BPF_X)) {
+			if (fp->code == (BPF_ALU32 | BPF_DIV | BPF_X) ||
+			    fp->code == (BPF_ALU32 | BPF_MOD | BPF_X)) {
 				*insn++ = BPF_MOV32_REG(BPF_REG_X, BPF_REG_X);
 				/* Error with exception code on div/mod by 0.
 				 * For cBPF programs, this was always return 0.
@@ -702,20 +702,20 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 		insn->off = off;					\
 	} while (0)
 
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			target = i + fp->k + 1;
 			insn->code = fp->code;
 			BPF_EMIT_JMP;
 			break;
 
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
 			if (BPF_SRC(fp->code) == BPF_K && (int) fp->k < 0) {
 				/* BPF immediates are signed, zero extend
 				 * immediate into tmp register and use it
@@ -735,7 +735,7 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 
 			/* Common case where 'jump_false' is next insn. */
 			if (fp->jf == 0) {
-				insn->code = BPF_JMP | BPF_OP(fp->code) | bpf_src;
+				insn->code = BPF_JMP64 | BPF_OP(fp->code) | bpf_src;
 				target = i + fp->jt + 1;
 				BPF_EMIT_JMP;
 				break;
@@ -745,13 +745,13 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 			if (fp->jt == 0) {
 				switch (BPF_OP(fp->code)) {
 				case BPF_JEQ:
-					insn->code = BPF_JMP | BPF_JNE | bpf_src;
+					insn->code = BPF_JMP64 | BPF_JNE | bpf_src;
 					break;
 				case BPF_JGT:
-					insn->code = BPF_JMP | BPF_JLE | bpf_src;
+					insn->code = BPF_JMP64 | BPF_JLE | bpf_src;
 					break;
 				case BPF_JGE:
-					insn->code = BPF_JMP | BPF_JLT | bpf_src;
+					insn->code = BPF_JMP64 | BPF_JLT | bpf_src;
 					break;
 				default:
 					goto jmp_rest;
@@ -764,11 +764,11 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 jmp_rest:
 			/* Other jumps are mapped into two insns: Jxx and JA. */
 			target = i + fp->jt + 1;
-			insn->code = BPF_JMP | BPF_OP(fp->code) | bpf_src;
+			insn->code = BPF_JMP64 | BPF_OP(fp->code) | bpf_src;
 			BPF_EMIT_JMP;
 			insn++;
 
-			insn->code = BPF_JMP | BPF_JA;
+			insn->code = BPF_JMP64 | BPF_JA;
 			target = i + fp->jf + 1;
 			BPF_EMIT_JMP;
 			break;
@@ -936,19 +936,19 @@ static int check_load_and_stores(const struct sock_filter *filter, int flen)
 				goto error;
 			}
 			break;
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			/* A jump must set masks on target */
 			masks[pc + 1 + filter[pc].k] &= memvalid;
 			memvalid = ~0;
 			break;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 			/* A jump must set masks on targets */
 			masks[pc + 1 + filter[pc].jt] &= memvalid;
 			masks[pc + 1 + filter[pc].jf] &= memvalid;
@@ -965,27 +965,27 @@ static bool chk_code_allowed(u16 code_to_probe)
 {
 	static const bool codes[] = {
 		/* 32 bit ALU operations */
-		[BPF_ALU | BPF_ADD | BPF_K] = true,
-		[BPF_ALU | BPF_ADD | BPF_X] = true,
-		[BPF_ALU | BPF_SUB | BPF_K] = true,
-		[BPF_ALU | BPF_SUB | BPF_X] = true,
-		[BPF_ALU | BPF_MUL | BPF_K] = true,
-		[BPF_ALU | BPF_MUL | BPF_X] = true,
-		[BPF_ALU | BPF_DIV | BPF_K] = true,
-		[BPF_ALU | BPF_DIV | BPF_X] = true,
-		[BPF_ALU | BPF_MOD | BPF_K] = true,
-		[BPF_ALU | BPF_MOD | BPF_X] = true,
-		[BPF_ALU | BPF_AND | BPF_K] = true,
-		[BPF_ALU | BPF_AND | BPF_X] = true,
-		[BPF_ALU | BPF_OR | BPF_K] = true,
-		[BPF_ALU | BPF_OR | BPF_X] = true,
-		[BPF_ALU | BPF_XOR | BPF_K] = true,
-		[BPF_ALU | BPF_XOR | BPF_X] = true,
-		[BPF_ALU | BPF_LSH | BPF_K] = true,
-		[BPF_ALU | BPF_LSH | BPF_X] = true,
-		[BPF_ALU | BPF_RSH | BPF_K] = true,
-		[BPF_ALU | BPF_RSH | BPF_X] = true,
-		[BPF_ALU | BPF_NEG] = true,
+		[BPF_ALU32 | BPF_ADD | BPF_K] = true,
+		[BPF_ALU32 | BPF_ADD | BPF_X] = true,
+		[BPF_ALU32 | BPF_SUB | BPF_K] = true,
+		[BPF_ALU32 | BPF_SUB | BPF_X] = true,
+		[BPF_ALU32 | BPF_MUL | BPF_K] = true,
+		[BPF_ALU32 | BPF_MUL | BPF_X] = true,
+		[BPF_ALU32 | BPF_DIV | BPF_K] = true,
+		[BPF_ALU32 | BPF_DIV | BPF_X] = true,
+		[BPF_ALU32 | BPF_MOD | BPF_K] = true,
+		[BPF_ALU32 | BPF_MOD | BPF_X] = true,
+		[BPF_ALU32 | BPF_AND | BPF_K] = true,
+		[BPF_ALU32 | BPF_AND | BPF_X] = true,
+		[BPF_ALU32 | BPF_OR | BPF_K] = true,
+		[BPF_ALU32 | BPF_OR | BPF_X] = true,
+		[BPF_ALU32 | BPF_XOR | BPF_K] = true,
+		[BPF_ALU32 | BPF_XOR | BPF_X] = true,
+		[BPF_ALU32 | BPF_LSH | BPF_K] = true,
+		[BPF_ALU32 | BPF_LSH | BPF_X] = true,
+		[BPF_ALU32 | BPF_RSH | BPF_K] = true,
+		[BPF_ALU32 | BPF_RSH | BPF_X] = true,
+		[BPF_ALU32 | BPF_NEG] = true,
 		/* Load instructions */
 		[BPF_LD | BPF_W | BPF_ABS] = true,
 		[BPF_LD | BPF_H | BPF_ABS] = true,
@@ -1010,15 +1010,15 @@ static bool chk_code_allowed(u16 code_to_probe)
 		[BPF_RET | BPF_K] = true,
 		[BPF_RET | BPF_A] = true,
 		/* Jump instructions */
-		[BPF_JMP | BPF_JA] = true,
-		[BPF_JMP | BPF_JEQ | BPF_K] = true,
-		[BPF_JMP | BPF_JEQ | BPF_X] = true,
-		[BPF_JMP | BPF_JGE | BPF_K] = true,
-		[BPF_JMP | BPF_JGE | BPF_X] = true,
-		[BPF_JMP | BPF_JGT | BPF_K] = true,
-		[BPF_JMP | BPF_JGT | BPF_X] = true,
-		[BPF_JMP | BPF_JSET | BPF_K] = true,
-		[BPF_JMP | BPF_JSET | BPF_X] = true,
+		[BPF_JMP64 | BPF_JA] = true,
+		[BPF_JMP64 | BPF_JEQ | BPF_K] = true,
+		[BPF_JMP64 | BPF_JEQ | BPF_X] = true,
+		[BPF_JMP64 | BPF_JGE | BPF_K] = true,
+		[BPF_JMP64 | BPF_JGE | BPF_X] = true,
+		[BPF_JMP64 | BPF_JGT | BPF_K] = true,
+		[BPF_JMP64 | BPF_JGT | BPF_X] = true,
+		[BPF_JMP64 | BPF_JSET | BPF_K] = true,
+		[BPF_JMP64 | BPF_JSET | BPF_X] = true,
 	};
 
 	if (code_to_probe >= ARRAY_SIZE(codes))
@@ -1068,14 +1068,14 @@ static int bpf_check_classic(const struct sock_filter *filter,
 
 		/* Some instructions need special checks */
 		switch (ftest->code) {
-		case BPF_ALU | BPF_DIV | BPF_K:
-		case BPF_ALU | BPF_MOD | BPF_K:
+		case BPF_ALU32 | BPF_DIV | BPF_K:
+		case BPF_ALU32 | BPF_MOD | BPF_K:
 			/* Check for division by zero */
 			if (ftest->k == 0)
 				return -EINVAL;
 			break;
-		case BPF_ALU | BPF_LSH | BPF_K:
-		case BPF_ALU | BPF_RSH | BPF_K:
+		case BPF_ALU32 | BPF_LSH | BPF_K:
+		case BPF_ALU32 | BPF_RSH | BPF_K:
 			if (ftest->k >= 32)
 				return -EINVAL;
 			break;
@@ -1087,7 +1087,7 @@ static int bpf_check_classic(const struct sock_filter *filter,
 			if (ftest->k >= BPF_MEMWORDS)
 				return -EINVAL;
 			break;
-		case BPF_JMP | BPF_JA:
+		case BPF_JMP64 | BPF_JA:
 			/* Note, the large ftest->k might cause loops.
 			 * Compare this with conditional jumps below,
 			 * where offsets are limited. --ANK (981016)
@@ -1095,14 +1095,14 @@ static int bpf_check_classic(const struct sock_filter *filter,
 			if (ftest->k >= (unsigned int)(flen - pc - 1))
 				return -EINVAL;
 			break;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-		case BPF_JMP | BPF_JEQ | BPF_X:
-		case BPF_JMP | BPF_JGE | BPF_K:
-		case BPF_JMP | BPF_JGE | BPF_X:
-		case BPF_JMP | BPF_JGT | BPF_K:
-		case BPF_JMP | BPF_JGT | BPF_X:
-		case BPF_JMP | BPF_JSET | BPF_K:
-		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP64 | BPF_JEQ | BPF_K:
+		case BPF_JMP64 | BPF_JEQ | BPF_X:
+		case BPF_JMP64 | BPF_JGE | BPF_K:
+		case BPF_JMP64 | BPF_JGE | BPF_X:
+		case BPF_JMP64 | BPF_JGT | BPF_K:
+		case BPF_JMP64 | BPF_JGT | BPF_X:
+		case BPF_JMP64 | BPF_JSET | BPF_K:
+		case BPF_JMP64 | BPF_JSET | BPF_X:
 			/* Both conditionals must be safe */
 			if (pc + ftest->jt + 1 >= flen ||
 			    pc + ftest->jf + 1 >= flen)
@@ -8607,7 +8607,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	/* ret = bpf_skb_pull_data(skb, 0); */
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	*insn++ = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			       BPF_FUNC_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
index 29c3bb6..1c55a77 100644
--- a/samples/bpf/bpf_insn.h
+++ b/samples/bpf/bpf_insn.h
@@ -17,7 +17,7 @@ struct bpf_insn;
 
 #define BPF_ALU32_REG(OP, DST, SRC)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -35,7 +35,7 @@ struct bpf_insn;
 
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -53,7 +53,7 @@ struct bpf_insn;
 
 #define BPF_MOV32_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -71,7 +71,7 @@ struct bpf_insn;
 
 #define BPF_MOV32_IMM(DST, IMM)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -174,7 +174,7 @@ struct bpf_insn;
 
 #define BPF_JMP_REG(OP, DST, SRC, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = OFF,					\
@@ -194,7 +194,7 @@ struct bpf_insn;
 
 #define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = OFF,					\
@@ -224,7 +224,7 @@ struct bpf_insn;
 
 #define BPF_EXIT_INSN()						\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_EXIT,			\
+		.code  = BPF_JMP64 | BPF_EXIT,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index f0df3dd..ddc6223 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -87,7 +87,7 @@ static void prog_load(void)
 		 * pc1: BPF_FUNC_get_socket_cookie takes one parameter,
 		 * R1: sk_buff
 		 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_get_socket_cookie),
 		/* pc2-4: save &socketCookie to r7 for future usage*/
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
@@ -99,7 +99,7 @@ static void prog_load(void)
 		 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_map_lookup_elem),
 		/*
 		 * pc9. if r0 != 0x0, go to pc+14, since we have the cookie
@@ -108,7 +108,7 @@ static void prog_load(void)
 		 */
 		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 14),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_get_socket_uid),
 		/*
 		 * Place a struct stats in the R10 stack and sequentially
@@ -137,7 +137,7 @@ static void prog_load(void)
 		BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -32),
 		BPF_MOV64_IMM(BPF_REG_4, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_map_update_elem),
 		BPF_JMP_IMM(BPF_JA, 0, 0, 5),
 		/*
diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index 5b66f24..3e8d74d 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -52,7 +52,7 @@ static int test_sock(void)
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
index 68ce694..b8331e7 100644
--- a/samples/bpf/test_cgrp2_attach.c
+++ b/samples/bpf/test_cgrp2_attach.c
@@ -51,7 +51,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd), /* load map fd to r1 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
@@ -62,7 +62,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct __sk_buff, len)), /* r1 = skb->len */
 
diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index a0811df..5447bce 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -48,7 +48,7 @@ static int prog_load(__u32 idx, __u32 mark, __u32 prio)
 	/* set mark on socket */
 	struct bpf_insn prog_mark[] = {
 		/* get uid of process */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_current_uid_gid),
 		BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffffffff),
 
diff --git a/samples/seccomp/bpf-direct.c b/samples/seccomp/bpf-direct.c
index c09e4a1..eda0b2a 100644
--- a/samples/seccomp/bpf-direct.c
+++ b/samples/seccomp/bpf-direct.c
@@ -114,29 +114,29 @@ static int install_filter(void)
 		/* Grab the system call number */
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS, syscall_nr),
 		/* Jump table for the allowed syscalls */
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_rt_sigreturn, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_rt_sigreturn, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
 #ifdef __NR_sigreturn
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_sigreturn, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_sigreturn, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
 #endif
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_exit_group, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_exit_group, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_exit, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_exit, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_read, 1, 0),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_write, 3, 2),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_read, 1, 0),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_write, 3, 2),
 
 		/* Check that read is only using stdin. */
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS, syscall_arg(0)),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, STDIN_FILENO, 4, 0),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDIN_FILENO, 4, 0),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL),
 
 		/* Check that write is only using stdout */
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS, syscall_arg(0)),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, STDOUT_FILENO, 1, 0),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDOUT_FILENO, 1, 0),
 		/* Trap attempts to write to stderr */
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, STDERR_FILENO, 1, 2),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDERR_FILENO, 1, 2),
 
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_TRAP),
diff --git a/samples/seccomp/bpf-helper.c b/samples/seccomp/bpf-helper.c
index ae260d7..5187790 100644
--- a/samples/seccomp/bpf-helper.c
+++ b/samples/seccomp/bpf-helper.c
@@ -30,7 +30,7 @@ int bpf_resolve_jumps(struct bpf_labels *labels,
 	for (i = 0; i < count; ++i) {
 		size_t offset = count - i - 1;
 		struct sock_filter *instr = &filter[offset];
-		if (instr->code != (BPF_JMP+BPF_JA))
+		if (instr->code != (BPF_JMP64+BPF_JA))
 			continue;
 		switch ((instr->jt<<8)|instr->jf) {
 		case (JUMP_JT<<8)|JUMP_JF:
diff --git a/samples/seccomp/bpf-helper.h b/samples/seccomp/bpf-helper.h
index 417e48a..b19812b 100644
--- a/samples/seccomp/bpf-helper.h
+++ b/samples/seccomp/bpf-helper.h
@@ -47,13 +47,13 @@ void seccomp_bpf_print(struct sock_filter *filter, size_t count);
 #define DENY \
 	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
 #define JUMP(labels, label) \
-	BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
+	BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
 		 JUMP_JT, JUMP_JF)
 #define LABEL(labels, label) \
-	BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
+	BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
 		 LABEL_JT, LABEL_JF)
 #define SYSCALL(nr, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (nr), 0, 1), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (nr), 0, 1), \
 	jt
 
 /* Lame, but just an example */
@@ -147,31 +147,31 @@ union arg64 {
 	BPF_STMT(BPF_ST, 1) /* hi -> M[1] */
 
 #define JEQ32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (value), 0, 1), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 0, 1), \
 	jt
 
 #define JNE32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (value), 1, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 1, 0), \
 	jt
 
 #define JA32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JSET+BPF_K, (value), 0, 1), \
+	BPF_JUMP(BPF_JMP64+BPF_JSET+BPF_K, (value), 0, 1), \
 	jt
 
 #define JGE32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (value), 0, 1), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (value), 0, 1), \
 	jt
 
 #define JGT32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (value), 0, 1), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (value), 0, 1), \
 	jt
 
 #define JLE32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (value), 1, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (value), 1, 0), \
 	jt
 
 #define JLT32(value, jt) \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (value), 1, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (value), 1, 0), \
 	jt
 
 /*
@@ -180,78 +180,78 @@ union arg64 {
  */
 #define JEQ64(lo, hi, jt) \
 	/* if (hi != arg.hi) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 5), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 5), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), /* swap in lo */ \
 	/* if (lo != arg.lo) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (lo), 0, 2), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (lo), 0, 2), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JNE64(lo, hi, jt) \
 	/* if (hi != arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 3), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 3), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo != arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (lo), 2, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (lo), 2, 0), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JA64(lo, hi, jt) \
 	/* if (hi & arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JSET+BPF_K, (hi), 3, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JSET+BPF_K, (hi), 3, 0), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo & arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JSET+BPF_K, (lo), 0, 2), \
+	BPF_JUMP(BPF_JMP64+BPF_JSET+BPF_K, (lo), 0, 2), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JGE64(lo, hi, jt) \
 	/* if (hi > arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (hi), 4, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (hi), 4, 0), \
 	/* if (hi != arg.hi) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 5), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 5), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo >= arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (lo), 0, 2), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (lo), 0, 2), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JGT64(lo, hi, jt) \
 	/* if (hi > arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (hi), 4, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (hi), 4, 0), \
 	/* if (hi != arg.hi) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 5), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 5), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo > arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (lo), 0, 2), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (lo), 0, 2), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JLE64(lo, hi, jt) \
 	/* if (hi < arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (hi), 0, 4), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (hi), 0, 4), \
 	/* if (hi != arg.hi) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 5), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 5), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo <= arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGT+BPF_K, (lo), 2, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGT+BPF_K, (lo), 2, 0), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
 
 #define JLT64(lo, hi, jt) \
 	/* if (hi < arg.hi) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (hi), 0, 4), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (hi), 0, 4), \
 	/* if (hi != arg.hi) goto NOMATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, (hi), 0, 5), \
+	BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (hi), 0, 5), \
 	BPF_STMT(BPF_LD+BPF_MEM, 0), \
 	/* if (lo < arg.lo) goto MATCH; */ \
-	BPF_JUMP(BPF_JMP+BPF_JGE+BPF_K, (lo), 2, 0), \
+	BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (lo), 2, 0), \
 	BPF_STMT(BPF_LD+BPF_MEM, 1), \
 	jt, \
 	BPF_STMT(BPF_LD+BPF_MEM, 1)
diff --git a/samples/seccomp/dropper.c b/samples/seccomp/dropper.c
index 4bca4b7..982c770 100644
--- a/samples/seccomp/dropper.c
+++ b/samples/seccomp/dropper.c
@@ -30,10 +30,10 @@ static int install_filter(int arch, int nr, int error)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
 			 (offsetof(struct seccomp_data, arch))),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, arch, 0, 3),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, arch, 0, 3),
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
 			 (offsetof(struct seccomp_data, nr))),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, nr, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, nr, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K,
 			 SECCOMP_RET_ERRNO|(error & SECCOMP_RET_DATA)),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 20291ec6..108ef31 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -88,7 +88,7 @@ static int user_trap_syscall(int nr, unsigned int flags)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, nr, 0, 1),
+		BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, nr, 0, 1),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_USER_NOTIF),
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
 	};
diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a..6f7ed34 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -56,22 +56,22 @@
 
 #define BPF_LDX_B	(BPF_LDX | BPF_B)
 #define BPF_LDX_W	(BPF_LDX | BPF_W)
-#define BPF_JMP_JA	(BPF_JMP | BPF_JA)
-#define BPF_JMP_JEQ	(BPF_JMP | BPF_JEQ)
-#define BPF_JMP_JGT	(BPF_JMP | BPF_JGT)
-#define BPF_JMP_JGE	(BPF_JMP | BPF_JGE)
-#define BPF_JMP_JSET	(BPF_JMP | BPF_JSET)
-#define BPF_ALU_ADD	(BPF_ALU | BPF_ADD)
-#define BPF_ALU_SUB	(BPF_ALU | BPF_SUB)
-#define BPF_ALU_MUL	(BPF_ALU | BPF_MUL)
-#define BPF_ALU_DIV	(BPF_ALU | BPF_DIV)
-#define BPF_ALU_MOD	(BPF_ALU | BPF_MOD)
-#define BPF_ALU_NEG	(BPF_ALU | BPF_NEG)
-#define BPF_ALU_AND	(BPF_ALU | BPF_AND)
-#define BPF_ALU_OR	(BPF_ALU | BPF_OR)
-#define BPF_ALU_XOR	(BPF_ALU | BPF_XOR)
-#define BPF_ALU_LSH	(BPF_ALU | BPF_LSH)
-#define BPF_ALU_RSH	(BPF_ALU | BPF_RSH)
+#define BPF_JMP_JA	(BPF_JMP64 | BPF_JA)
+#define BPF_JMP_JEQ	(BPF_JMP64 | BPF_JEQ)
+#define BPF_JMP_JGT	(BPF_JMP64 | BPF_JGT)
+#define BPF_JMP_JGE	(BPF_JMP64 | BPF_JGE)
+#define BPF_JMP_JSET	(BPF_JMP64 | BPF_JSET)
+#define BPF_ALU_ADD	(BPF_ALU32 | BPF_ADD)
+#define BPF_ALU_SUB	(BPF_ALU32 | BPF_SUB)
+#define BPF_ALU_MUL	(BPF_ALU32 | BPF_MUL)
+#define BPF_ALU_DIV	(BPF_ALU32 | BPF_DIV)
+#define BPF_ALU_MOD	(BPF_ALU32 | BPF_MOD)
+#define BPF_ALU_NEG	(BPF_ALU32 | BPF_NEG)
+#define BPF_ALU_AND	(BPF_ALU32 | BPF_AND)
+#define BPF_ALU_OR	(BPF_ALU32 | BPF_OR)
+#define BPF_ALU_XOR	(BPF_ALU32 | BPF_XOR)
+#define BPF_ALU_LSH	(BPF_ALU32 | BPF_LSH)
+#define BPF_ALU_RSH	(BPF_ALU32 | BPF_RSH)
 #define BPF_MISC_TAX	(BPF_MISC | BPF_TAX)
 #define BPF_MISC_TXA	(BPF_MISC | BPF_TXA)
 #define BPF_LD_B	(BPF_LD | BPF_B)
@@ -428,7 +428,7 @@ static void bpf_disasm(const struct sock_filter f, unsigned int i)
 	snprintf(buf, sizeof(buf), fmt, val);
 	buf[sizeof(buf) - 1] = 0;
 
-	if ((BPF_CLASS(f.code) == BPF_JMP && BPF_OP(f.code) != BPF_JA))
+	if ((BPF_CLASS(f.code) == BPF_JMP64 && BPF_OP(f.code) != BPF_JA))
 		rl_printf("l%d:\t%s %s, l%d, l%d\n", i, op, buf,
 			  i + 1 + f.jt, i + 1 + f.jf);
 	else
diff --git a/tools/bpf/bpf_exp.y b/tools/bpf/bpf_exp.y
index dfb7254..3dd6b0a 100644
--- a/tools/bpf/bpf_exp.y
+++ b/tools/bpf/bpf_exp.y
@@ -209,234 +209,234 @@ stx
 jmp
 	: OP_JMP label {
 		bpf_set_jmp_label($2, JKL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JA, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JA, 0, 0, 0); }
 	;
 
 jeq
 	: OP_JEQ '#' number ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_K, 0, 0, $3); }
 	| OP_JEQ 'x' ',' label ',' label {
 		bpf_set_jmp_label($4, JTL);
 		bpf_set_jmp_label($6, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	| OP_JEQ '%' 'x' ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	| OP_JEQ '#' number ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_K, 0, 0, $3); }
 	| OP_JEQ 'x' ',' label {
 		bpf_set_jmp_label($4, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	| OP_JEQ '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	;
 
 jneq
 	: OP_JNEQ '#' number ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_K, 0, 0, $3); }
 	| OP_JNEQ 'x' ',' label {
 		bpf_set_jmp_label($4, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	| OP_JNEQ '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JEQ | BPF_X, 0, 0, 0); }
 	;
 
 jlt
 	: OP_JLT '#' number ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_K, 0, 0, $3); }
 	| OP_JLT 'x' ',' label {
 		bpf_set_jmp_label($4, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	| OP_JLT '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	;
 
 jle
 	: OP_JLE '#' number ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_K, 0, 0, $3); }
 	| OP_JLE 'x' ',' label {
 		bpf_set_jmp_label($4, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	| OP_JLE '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	;
 
 jgt
 	: OP_JGT '#' number ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_K, 0, 0, $3); }
 	| OP_JGT 'x' ',' label ',' label {
 		bpf_set_jmp_label($4, JTL);
 		bpf_set_jmp_label($6, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	| OP_JGT '%' 'x' ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	| OP_JGT '#' number ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_K, 0, 0, $3); }
 	| OP_JGT 'x' ',' label {
 		bpf_set_jmp_label($4, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	| OP_JGT '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGT | BPF_X, 0, 0, 0); }
 	;
 
 jge
 	: OP_JGE '#' number ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_K, 0, 0, $3); }
 	| OP_JGE 'x' ',' label ',' label {
 		bpf_set_jmp_label($4, JTL);
 		bpf_set_jmp_label($6, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	| OP_JGE '%' 'x' ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	| OP_JGE '#' number ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_K, 0, 0, $3); }
 	| OP_JGE 'x' ',' label {
 		bpf_set_jmp_label($4, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	| OP_JGE '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JGE | BPF_X, 0, 0, 0); }
 	;
 
 jset
 	: OP_JSET '#' number ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_K, 0, 0, $3); }
 	| OP_JSET 'x' ',' label ',' label {
 		bpf_set_jmp_label($4, JTL);
 		bpf_set_jmp_label($6, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_X, 0, 0, 0); }
 	| OP_JSET '%' 'x' ',' label ',' label {
 		bpf_set_jmp_label($5, JTL);
 		bpf_set_jmp_label($7, JFL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_X, 0, 0, 0); }
 	| OP_JSET '#' number ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_K, 0, 0, $3); }
 	| OP_JSET 'x' ',' label {
 		bpf_set_jmp_label($4, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_X, 0, 0, 0); }
 	| OP_JSET '%' 'x' ',' label {
 		bpf_set_jmp_label($5, JTL);
-		bpf_set_curr_instr(BPF_JMP | BPF_JSET | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_JMP64 | BPF_JSET | BPF_X, 0, 0, 0); }
 	;
 
 add
 	: OP_ADD '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_ADD | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_ADD | BPF_K, 0, 0, $3); }
 	| OP_ADD 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_ADD | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_ADD | BPF_X, 0, 0, 0); }
 	| OP_ADD '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_ADD | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_ADD | BPF_X, 0, 0, 0); }
 	;
 
 sub
 	: OP_SUB '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_SUB | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_SUB | BPF_K, 0, 0, $3); }
 	| OP_SUB 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_SUB | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_SUB | BPF_X, 0, 0, 0); }
 	| OP_SUB '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_SUB | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_SUB | BPF_X, 0, 0, 0); }
 	;
 
 mul
 	: OP_MUL '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_MUL | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MUL | BPF_K, 0, 0, $3); }
 	| OP_MUL 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_MUL | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MUL | BPF_X, 0, 0, 0); }
 	| OP_MUL '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_MUL | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MUL | BPF_X, 0, 0, 0); }
 	;
 
 div
 	: OP_DIV '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_DIV | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_DIV | BPF_K, 0, 0, $3); }
 	| OP_DIV 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_DIV | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_DIV | BPF_X, 0, 0, 0); }
 	| OP_DIV '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_DIV | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_DIV | BPF_X, 0, 0, 0); }
 	;
 
 mod
 	: OP_MOD '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_MOD | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MOD | BPF_K, 0, 0, $3); }
 	| OP_MOD 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_MOD | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MOD | BPF_X, 0, 0, 0); }
 	| OP_MOD '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_MOD | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_MOD | BPF_X, 0, 0, 0); }
 	;
 
 neg
 	: OP_NEG {
-		bpf_set_curr_instr(BPF_ALU | BPF_NEG, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_NEG, 0, 0, 0); }
 	;
 
 and
 	: OP_AND '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_AND | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_AND | BPF_K, 0, 0, $3); }
 	| OP_AND 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_AND | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_AND | BPF_X, 0, 0, 0); }
 	| OP_AND '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_AND | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_AND | BPF_X, 0, 0, 0); }
 	;
 
 or
 	: OP_OR '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_OR | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_OR | BPF_K, 0, 0, $3); }
 	| OP_OR 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_OR | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_OR | BPF_X, 0, 0, 0); }
 	| OP_OR '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_OR | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_OR | BPF_X, 0, 0, 0); }
 	;
 
 xor
 	: OP_XOR '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_XOR | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_XOR | BPF_K, 0, 0, $3); }
 	| OP_XOR 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_XOR | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_XOR | BPF_X, 0, 0, 0); }
 	| OP_XOR '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_XOR | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_XOR | BPF_X, 0, 0, 0); }
 	;
 
 lsh
 	: OP_LSH '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_LSH | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_LSH | BPF_K, 0, 0, $3); }
 	| OP_LSH 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_LSH | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_LSH | BPF_X, 0, 0, 0); }
 	| OP_LSH '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_LSH | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_LSH | BPF_X, 0, 0, 0); }
 	;
 
 rsh
 	: OP_RSH '#' number {
-		bpf_set_curr_instr(BPF_ALU | BPF_RSH | BPF_K, 0, 0, $3); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_RSH | BPF_K, 0, 0, $3); }
 	| OP_RSH 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_RSH | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_RSH | BPF_X, 0, 0, 0); }
 	| OP_RSH '%' 'x' {
-		bpf_set_curr_instr(BPF_ALU | BPF_RSH | BPF_X, 0, 0, 0); }
+		bpf_set_curr_instr(BPF_ALU32 | BPF_RSH | BPF_X, 0, 0, 0); }
 	;
 
 ret
diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
index 1951219..8f509ab 100644
--- a/tools/bpf/bpftool/cfg.c
+++ b/tools/bpf/bpftool/cfg.c
@@ -138,7 +138,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, struct bpf_insn *cur,
 		return true;
 
 	for (; cur < end; cur++) {
-		if (cur->code != (BPF_JMP | BPF_CALL))
+		if (cur->code != (BPF_JMP64 | BPF_CALL))
 			continue;
 		if (cur->src_reg != BPF_PSEUDO_CALL)
 			continue;
@@ -159,7 +159,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, struct bpf_insn *cur,
 
 static bool is_jmp_insn(__u8 code)
 {
-	return BPF_CLASS(code) == BPF_JMP || BPF_CLASS(code) == BPF_JMP32;
+	return BPF_CLASS(code) == BPF_JMP64 || BPF_CLASS(code) == BPF_JMP32;
 }
 
 static bool func_partition_bb_head(struct func_node *func)
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 736bdec..cf111f1 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -41,7 +41,7 @@
 
 #define BPF_ALU32_REG(OP, DST, SRC)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -59,7 +59,7 @@
 
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -69,7 +69,7 @@
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_END | BPF_SRC(TYPE),	\
+		.code  = BPF_ALU32 | BPF_END | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -87,7 +87,7 @@
 
 #define BPF_MOV32_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -105,7 +105,7 @@
 
 #define BPF_MOV32_IMM(DST, IMM)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_K,		\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -123,7 +123,7 @@
 
 #define BPF_MOV32_RAW(TYPE, DST, SRC, IMM)			\
 	((struct bpf_insn) {					\
-		.code  = BPF_ALU | BPF_MOV | BPF_SRC(TYPE),	\
+		.code  = BPF_ALU32 | BPF_MOV | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -209,7 +209,7 @@
 
 #define BPF_JMP_REG(OP, DST, SRC, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_X,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = OFF,					\
@@ -229,7 +229,7 @@
 
 #define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
+		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = OFF,					\
@@ -249,7 +249,7 @@
 
 #define BPF_JMP_A(OFF)						\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_JA,			\
+		.code  = BPF_JMP64 | BPF_JA,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = OFF,					\
@@ -259,7 +259,7 @@
 
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_CALL,			\
+		.code  = BPF_JMP64 | BPF_CALL,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -322,7 +322,7 @@
 
 #define BPF_CALL_REL(TGT)					\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_CALL,			\
+		.code  = BPF_JMP64 | BPF_CALL,			\
 		.dst_reg = 0,					\
 		.src_reg = BPF_PSEUDO_CALL,			\
 		.off   = 0,					\
@@ -332,7 +332,7 @@
 
 #define BPF_EXIT_INSN()						\
 	((struct bpf_insn) {					\
-		.code  = BPF_JMP | BPF_EXIT,			\
+		.code  = BPF_JMP64 | BPF_EXIT,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
diff --git a/tools/lib/bpf/bpf_endian.h b/tools/lib/bpf/bpf_endian.h
index ec9db4f..6f8db8b 100644
--- a/tools/lib/bpf/bpf_endian.h
+++ b/tools/lib/bpf/bpf_endian.h
@@ -40,7 +40,7 @@
  * requested byte order.
  *
  * Note, LLVM's BPF target has different __builtin_bswapX()
- * semantics. It does map to BPF_ALU | BPF_END | BPF_TO_BE
+ * semantics. It does map to BPF_ALU32 | BPF_END | BPF_TO_BE
  * in bpfel and bpfeb case, which means below, that we map
  * to cpu_to_be16(). We could use it unconditionally in BPF
  * case, but better not rely on it, so that this header here
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec..1afea14 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -706,7 +706,7 @@ static void bpf_program__exit(struct bpf_program *prog)
 
 static bool insn_is_subprog_call(const struct bpf_insn *insn)
 {
-	return BPF_CLASS(insn->code) == BPF_JMP &&
+	return BPF_CLASS(insn->code) == BPF_JMP64 &&
 	       BPF_OP(insn->code) == BPF_CALL &&
 	       BPF_SRC(insn->code) == BPF_K &&
 	       insn->src_reg == BPF_PSEUDO_CALL &&
@@ -716,7 +716,7 @@ static bool insn_is_subprog_call(const struct bpf_insn *insn)
 
 static bool is_call_insn(const struct bpf_insn *insn)
 {
-	return insn->code == (BPF_JMP | BPF_CALL);
+	return insn->code == (BPF_JMP64 | BPF_CALL);
 }
 
 static bool insn_is_pseudo_func(struct bpf_insn *insn)
@@ -4045,7 +4045,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		}
 		pr_debug("prog '%s': found extern #%d '%s' (sym %d) for insn #%u\n",
 			 prog->name, i, ext->name, ext->sym_idx, insn_idx);
-		if (insn->code == (BPF_JMP | BPF_CALL))
+		if (insn->code == (BPF_JMP64 | BPF_CALL))
 			reloc_desc->type = RELO_EXTERN_FUNC;
 		else
 			reloc_desc->type = RELO_EXTERN_VAR;
@@ -4701,7 +4701,7 @@ static int probe_kern_probe_read_kernel(void)
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
 		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 = 8 */
 		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 = 0 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
 		BPF_EXIT_INSN(),
 	};
 	int fd, insn_cnt = ARRAY_SIZE(insns);
@@ -4800,7 +4800,7 @@ static int probe_perf_link(void)
 static int probe_kern_bpf_cookie(void)
 {
 	struct bpf_insn insns[] = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
 		BPF_EXIT_INSN(),
 	};
 	int ret, insn_cnt = ARRAY_SIZE(insns);
@@ -5833,7 +5833,7 @@ static void poison_map_ldimm64(struct bpf_program *prog, int relo_idx,
 
 	/* we turn single ldimm64 into two identical invalid calls */
 	for (i = 0; i < 2; i++) {
-		insn->code = BPF_JMP | BPF_CALL;
+		insn->code = BPF_JMP64 | BPF_CALL;
 		insn->dst_reg = 0;
 		insn->src_reg = 0;
 		insn->off = 0;
@@ -6663,7 +6663,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 
 static bool insn_is_helper_call(struct bpf_insn *insn, enum bpf_func_id *func_id)
 {
-	if (BPF_CLASS(insn->code) == BPF_JMP &&
+	if (BPF_CLASS(insn->code) == BPF_JMP64 &&
 	    BPF_OP(insn->code) == BPF_CALL &&
 	    BPF_SRC(insn->code) == BPF_K &&
 	    insn->src_reg == 0 &&
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 4ac02c2..bcad766 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2078,7 +2078,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 					 * (rom two different object files)
 					 */
 					insn = dst_linked_sec->raw_data + dst_rel->r_offset;
-					if (insn->code == (BPF_JMP | BPF_CALL))
+					if (insn->code == (BPF_JMP64 | BPF_CALL))
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index c4b0e81..2faaf75 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -971,7 +971,7 @@ static void bpf_core_poison_insn(const char *prog_name, int relo_idx,
 {
 	pr_debug("prog '%s': relo #%d: substituting insn #%d w/ invalid insn\n",
 		 prog_name, relo_idx, insn_idx);
-	insn->code = BPF_JMP | BPF_CALL;
+	insn->code = BPF_JMP64 | BPF_CALL;
 	insn->dst_reg = 0;
 	insn->src_reg = 0;
 	insn->off = 0;
@@ -1045,7 +1045,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	new_val = res->new_val;
 
 	switch (class) {
-	case BPF_ALU:
+	case BPF_ALU32:
 	case BPF_ALU64:
 		if (BPF_SRC(insn->code) != BPF_K)
 			return -EINVAL;
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 9887ae0..16b3957 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -335,7 +335,7 @@ prologue_relocate(struct bpf_insn_pos *pos, struct bpf_insn *error_code,
 		u8 class = BPF_CLASS(insn->code);
 		u8 opcode;
 
-		if (class != BPF_JMP)
+		if (class != BPF_JMP64)
 			continue;
 		opcode = BPF_OP(insn->code);
 		if (opcode == BPF_CALL)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index de1b5b9..e9a214b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5571,7 +5571,7 @@ static struct prog_info_raw_test {
 	.str_sec = "\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB",
 	.str_sec_size = sizeof("\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB"),
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -5602,7 +5602,7 @@ static struct prog_info_raw_test {
 	.str_sec = "\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB",
 	.str_sec_size = sizeof("\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB"),
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -5634,7 +5634,7 @@ static struct prog_info_raw_test {
 	.str_sec = "\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB",
 	.str_sec_size = sizeof("\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB"),
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -5666,7 +5666,7 @@ static struct prog_info_raw_test {
 	.str_sec = "\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB",
 	.str_sec_size = sizeof("\0int\0unsigned int\0a\0b\0c\0d\0funcA\0funcB"),
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index db0b7ba..87c5434 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -42,20 +42,20 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 
 		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, val),
 		BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 
 		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
 		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
index c7a47b5..ca3bcd7 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -15,7 +15,7 @@ void serial_test_flow_dissector_load_bytes(void)
 		// BPF_REG_4 - 4th argument: copy one byte
 		BPF_MOV64_IMM(BPF_REG_4, 1),
 		// bpf_skb_load_bytes(ctx, sizeof(pkt_v4), ptr, 1)
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_skb_load_bytes),
 		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 		// if (ret == 0) return BPF_DROP (2)
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf6..3656ed2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -861,7 +861,7 @@ static int load_prog(const struct bpf_insn *insns,
 	int fd, insns_cnt = 0;
 
 	for (;
-	     insns[insns_cnt].code != (BPF_JMP | BPF_EXIT);
+	     insns[insns_cnt].code != (BPF_JMP64 | BPF_EXIT);
 	     insns_cnt++) {
 	}
 	insns_cnt++;
diff --git a/tools/testing/selftests/bpf/progs/pyperf600.c b/tools/testing/selftests/bpf/progs/pyperf600.c
index ce1aa51..16d2aa2 100644
--- a/tools/testing/selftests/bpf/progs/pyperf600.c
+++ b/tools/testing/selftests/bpf/progs/pyperf600.c
@@ -3,7 +3,7 @@
 #define STACK_MAX_LEN 600
 /* Full unroll of 600 iterations will have total
  * program size close to 298k insns and this may
- * cause BPF_JMP insn out of 16-bit integer range.
+ * cause BPF_JMP64 insn out of 16-bit integer range.
  * So limit the unroll size to 150 so the
  * total program size is around 80k insns but
  * the loop will still execute 600 times.
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index e550f72..85451c9 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -66,7 +66,7 @@ int bpf_prog(struct args *ctx)
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 0861ea6..2fbb30f 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -19,7 +19,7 @@ int main(int argc, char **argv)
 	struct bpf_insn prog[] = {
 		BPF_LD_MAP_FD(BPF_REG_1, 0), /* percpu map fd */
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_local_storage),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
@@ -27,7 +27,7 @@ int main(int argc, char **argv)
 
 		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, 1),
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 8c80855..83319c0 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -208,7 +208,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_2, 1);
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_3, 2);
-		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_skb_vlan_push),
 		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
@@ -219,7 +219,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 		insn[i] = BPF_JMP32_IMM(BPF_JNE, BPF_REG_0, 0x34, len - i - 3);
 		i++;
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
-		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_skb_vlan_pop),
 		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
@@ -294,7 +294,7 @@ static void bpf_fill_scale1(struct bpf_test *self)
 	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	/* test to check that the long sequence of jumps is acceptable */
 	while (k++ < MAX_JMP_SEQ) {
-		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_get_prandom_u32);
 		insn[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
@@ -326,7 +326,7 @@ static void bpf_fill_scale2(struct bpf_test *self)
 	/* test to check that the long sequence of jumps is acceptable */
 	k = 0;
 	while (k++ < MAX_JMP_SEQ) {
-		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_get_prandom_u32);
 		insn[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
@@ -405,8 +405,8 @@ static void bpf_fill_torturous_jumps(struct bpf_test *self)
 		return;
 	case 3:
 		/* main */
-		insn[i++] = BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 4);
-		insn[i++] = BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 262);
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 4);
+		insn[i++] = BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 262);
 		insn[i++] = BPF_ST_MEM(BPF_B, BPF_REG_10, -32, 0);
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_0, 3);
 		insn[i++] = BPF_EXIT_INSN();
@@ -448,7 +448,7 @@ static void bpf_fill_big_prog_with_loop_1(struct bpf_test *self)
 	insn[i++] = BPF_RAW_INSN(0, 0, 0, 0, 0);
 	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0);
 	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0);
-	insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop);
+	insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop);
 
 	while (i < len - 3)
 		insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
@@ -501,7 +501,7 @@ static void bpf_fill_big_prog_with_loop_1(struct bpf_test *self)
  * positive u32, and zero-extend it into 64-bit.
  */
 #define BPF_RAND_UEXT_R7						\
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,			\
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,			\
 		     BPF_FUNC_get_prandom_u32),				\
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),				\
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_7, 33),				\
@@ -511,7 +511,7 @@ static void bpf_fill_big_prog_with_loop_1(struct bpf_test *self)
  * negative u32, and sign-extend it into 64-bit.
  */
 #define BPF_RAND_SEXT_R7						\
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,			\
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,			\
 		     BPF_FUNC_get_prandom_u32),				\
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),				\
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_7, 0x80000000),			\
@@ -594,7 +594,7 @@ static int create_prog_dummy_loop(enum bpf_prog_type prog_type, int mfd,
 	struct bpf_insn prog[] = {
 		BPF_MOV64_IMM(BPF_REG_3, idx),
 		BPF_LD_MAP_FD(BPF_REG_2, mfd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_tail_call),
 		BPF_MOV64_IMM(BPF_REG_0, ret),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/test_verifier_log.c b/tools/testing/selftests/bpf/test_verifier_log.c
index 70feda9..6cb0d17 100644
--- a/tools/testing/selftests/bpf/test_verifier_log.c
+++ b/tools/testing/selftests/bpf/test_verifier_log.c
@@ -33,7 +33,7 @@ static const struct bpf_insn code_sample[] = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_map_lookup_elem),
 	BPF_EXIT_INSN(),
 };
diff --git a/tools/testing/selftests/bpf/verifier/and.c b/tools/testing/selftests/bpf/verifier/and.c
index 7d7ebee..6edbfe3 100644
--- a/tools/testing/selftests/bpf/verifier/and.c
+++ b/tools/testing/selftests/bpf/verifier/and.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
@@ -26,7 +26,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 12),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
@@ -51,7 +51,7 @@
 {
 	"check known subreg with unknown reg",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFFFF1234),
diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
index 1b138cd..f32bd8b 100644
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ b/tools/testing/selftests/bpf/verifier/array_access.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_EXIT_INSN(),
@@ -22,7 +22,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
@@ -43,7 +43,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 3),
@@ -65,7 +65,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP32_IMM(BPF_JSGT, BPF_REG_1, 0xffffffff, 1),
@@ -91,7 +91,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, (MAX_ENTRIES + 1) << 2,
 		   offsetof(struct test_val, foo)),
@@ -108,7 +108,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, MAX_ENTRIES + 1),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
@@ -128,7 +128,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
@@ -148,7 +148,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
@@ -173,7 +173,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES + 1),
@@ -198,14 +198,14 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
@@ -224,7 +224,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -240,7 +240,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -248,7 +248,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_csum_diff),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
 	BPF_EXIT_INSN(),
@@ -265,7 +265,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_EXIT_INSN(),
@@ -282,13 +282,13 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_skb_load_bytes),
 	BPF_EXIT_INSN(),
 	},
@@ -304,7 +304,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -322,13 +322,13 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_skb_load_bytes),
 	BPF_EXIT_INSN(),
 	},
@@ -344,7 +344,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -360,7 +360,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -368,7 +368,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_csum_diff),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/basic_call.c b/tools/testing/selftests/bpf/verifier/basic_call.c
index a8c6ab4..55a0aad 100644
--- a/tools/testing/selftests/bpf/verifier/basic_call.c
+++ b/tools/testing/selftests/bpf/verifier/basic_call.c
@@ -1,7 +1,7 @@
 {
 	"invalid call insn1",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL | BPF_X, 0, 0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unknown opcode 8d",
@@ -10,7 +10,7 @@
 {
 	"invalid call insn2",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 1, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 1, 0),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "BPF_CALL uses reserved",
@@ -19,7 +19,7 @@
 {
 	"invalid function call",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, 1234567),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, 1234567),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "invalid func unknown#1234567",
@@ -28,8 +28,8 @@
 {
 	"invalid argument register",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "R1 !read_ok",
@@ -40,9 +40,9 @@
 	"non-invalid argument register",
 	.insns = {
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_cgroup_classid),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
diff --git a/tools/testing/selftests/bpf/verifier/basic_stack.c b/tools/testing/selftests/bpf/verifier/basic_stack.c
index f995777..20ab2d3 100644
--- a/tools/testing/selftests/bpf/verifier/basic_stack.c
+++ b/tools/testing/selftests/bpf/verifier/basic_stack.c
@@ -13,7 +13,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 2 },
diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 33125d5..f822f2b 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 7),
@@ -30,7 +30,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 6),
@@ -56,14 +56,14 @@
 	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_ARG2, 0, 9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_FP),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
 	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_ARG2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
@@ -82,7 +82,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0x0000'0000'ffff'ffff */
 	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff),
@@ -106,7 +106,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0xffff'ffff'ffff'ffff */
 	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
@@ -131,7 +131,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0xffff'ffff'ffff'ffff */
 	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
@@ -158,7 +158,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 29) - 1),
@@ -182,7 +182,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 30) - 1),
@@ -204,7 +204,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -237,7 +237,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -271,7 +271,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -306,7 +306,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	/* r1 = 0x7fff'ffff */
 	BPF_MOV64_IMM(BPF_REG_1, 0x7fffffff),
@@ -332,7 +332,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_2, 32),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
@@ -359,7 +359,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -388,7 +388,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	/* r1 = 2 */
 	BPF_MOV64_IMM(BPF_REG_1, 2),
@@ -415,7 +415,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x7ffffffe),
@@ -434,7 +434,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
@@ -456,7 +456,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 0x1fffffff),
@@ -477,7 +477,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 1000000),
@@ -563,7 +563,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
@@ -585,7 +585,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
@@ -607,7 +607,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 2),
@@ -629,7 +629,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -651,7 +651,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -673,7 +673,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -696,7 +696,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -719,7 +719,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	/* This used to reduce the max bound to 0x7fffffff */
@@ -740,7 +740,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JSLT, BPF_REG_1, 1, 1),
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
index c2aa6f2..47b56b0ed 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -28,7 +28,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -51,7 +51,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -76,7 +76,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -100,7 +100,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -122,7 +122,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -153,7 +153,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	BPF_ST_MEM(BPF_H, BPF_REG_10, -512, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -167,7 +167,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -189,7 +189,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -214,7 +214,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -238,7 +238,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -263,7 +263,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -289,7 +289,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -314,7 +314,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -344,7 +344,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
@@ -371,7 +371,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
index 3e024c89..6c02db4 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -6,7 +6,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 28),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_9, sizeof(struct test_val)/2),
@@ -52,7 +52,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
index a535d41..31c71dc 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -21,14 +21,14 @@
  * fields for pseudo calls
  */
 #define PSEUDO_CALL_INSN() \
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, \
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_CALL, \
 		     INSN_OFF_MASK, INSN_IMM_MASK)
 
 /* can't use BPF_FUNC_loop constant,
  * do_mix_fixups adjusts the IMM field
  */
 #define HELPER_CALL_INSN() \
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, INSN_OFF_MASK, INSN_IMM_MASK)
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, INSN_OFF_MASK, INSN_IMM_MASK)
 
 {
 	"inline simple bpf_loop call",
@@ -37,7 +37,7 @@
 	/* force verifier state branching to verify logic on first and
 	 * subsequent bpf_loop insn processing steps
 	 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
@@ -47,7 +47,7 @@
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* callback */
@@ -67,9 +67,9 @@
 	"don't inline bpf_loop call, flags non-zero",
 	.insns = {
 	/* main */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 9),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
@@ -78,7 +78,7 @@
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 7),
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
@@ -100,7 +100,7 @@
 	"don't inline bpf_loop call, callback non-constant",
 	.insns = {
 	/* main */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
 
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
@@ -114,7 +114,7 @@
 
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* callback */
@@ -152,7 +152,7 @@
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* callback */
@@ -186,14 +186,14 @@
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	/* bpf_loop call #2 */
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 16),
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	/* call func and exit */
 	BPF_CALL_REL(2),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
@@ -205,7 +205,7 @@
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* callback */
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 9d99392..986bf68 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1,7 +1,7 @@
 {
 	"calls: invalid kfunc call not eliminated",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -14,7 +14,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 0, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -26,7 +26,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -41,7 +41,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -56,7 +56,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -71,7 +71,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -86,7 +86,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -102,9 +102,9 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -121,12 +121,12 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -142,11 +142,11 @@
 	"calls: invalid kfunc call: don't match first member type when passed to release kfunc",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -164,13 +164,13 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -189,21 +189,21 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
 	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -224,14 +224,14 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -251,14 +251,14 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -274,7 +274,7 @@
 {
 	"calls: basic sanity",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -286,7 +286,7 @@
 {
 	"calls: not on unprivileged",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -301,7 +301,7 @@
 	"calls: div by 0 in subprog",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, data_end)),
@@ -326,7 +326,7 @@
 	"calls: multiple ret types in subprog 1",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, data_end)),
@@ -350,7 +350,7 @@
 	"calls: multiple ret types in subprog 2",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, data_end)),
@@ -368,7 +368,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
 		    offsetof(struct __sk_buff, data)),
@@ -383,7 +383,7 @@
 {
 	"calls: overlapping caller/callee",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -396,9 +396,9 @@
 	.insns = {
 	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -409,7 +409,7 @@
 {
 	"calls: wrong src reg",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 3, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 3, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -420,7 +420,7 @@
 {
 	"calls: wrong off value",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, -1, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, -1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -433,7 +433,7 @@
 {
 	"calls: jump back loop",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -1),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -447,7 +447,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -463,7 +463,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -500,7 +500,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -517,7 +517,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -534,7 +534,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -3),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
@@ -548,7 +548,7 @@
 {
 	"calls: using r0 returned by callee",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
@@ -559,7 +559,7 @@
 {
 	"calls: using uninit r0 from callee",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_EXIT_INSN(),
 	},
@@ -570,7 +570,7 @@
 {
 	"calls: callee is using r1",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, len)),
@@ -583,7 +583,7 @@
 {
 	"calls: callee using args1",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_EXIT_INSN(),
@@ -596,7 +596,7 @@
 {
 	"calls: callee using wrong args2",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_EXIT_INSN(),
@@ -613,7 +613,7 @@
 		    offsetof(struct __sk_buff, len)),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_6,
 		    offsetof(struct __sk_buff, len)),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
@@ -633,7 +633,7 @@
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_8, 8),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_8, BPF_REG_7, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	/* clear_all_pkt_pointers() has to walk all frames
 	 * to make sure that pkt pointers in the caller
 	 * are cleared when callee is calling a helper that
@@ -643,7 +643,7 @@
 	BPF_MOV32_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_head),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_head),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -661,7 +661,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
@@ -679,13 +679,13 @@
 {
 	"calls: two calls with args",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
 	BPF_EXIT_INSN(),
@@ -702,10 +702,10 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -721,10 +721,10 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -63),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -61),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -63),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -757,7 +757,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 43),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -767,13 +767,13 @@
 {
 	"calls: two calls with bad jump",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
 	BPF_EXIT_INSN(),
@@ -789,9 +789,9 @@
 {
 	"calls: recursive call. test1",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -1),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -801,9 +801,9 @@
 {
 	"calls: recursive call. test2",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -813,9 +813,9 @@
 {
 	"calls: unreachable code",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -829,9 +829,9 @@
 {
 	"calls: invalid call",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -4),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -841,9 +841,9 @@
 {
 	"calls: invalid call 2",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 0x7fffffff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 0x7fffffff),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -853,7 +853,7 @@
 {
 	"calls: jumping across function bodies. test1",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
@@ -867,7 +867,7 @@
 	"calls: jumping across function bodies. test2",
 	.insns = {
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EXIT_INSN(),
@@ -879,9 +879,9 @@
 {
 	"calls: call without exit",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
@@ -893,8 +893,8 @@
 {
 	"calls: call into middle of ld_imm64",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_0, 0),
@@ -907,8 +907,8 @@
 {
 	"calls: call into middle of other call",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -928,7 +928,7 @@
 	BPF_LD_ABS(BPF_W, 0),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
 	BPF_LD_ABS(BPF_B, 0),
 	BPF_LD_ABS(BPF_H, 0),
@@ -936,7 +936,7 @@
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_vlan_push),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_vlan_push),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -945,13 +945,13 @@
 {
 	"calls: two calls with bad fallthrough",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_0),
@@ -969,13 +969,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
 	BPF_EXIT_INSN(),
@@ -994,17 +994,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -16),
 	BPF_EXIT_INSN(),
 
 	/* subprog 1 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 7),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 7),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
 	/* write into stack frame of main prog */
@@ -1024,7 +1024,7 @@
 	.insns = {
 	/* prog 1 */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* prog 2 */
@@ -1040,7 +1040,7 @@
 	"calls: stack overflow using two frames (post-call access)",
 	.insns = {
 	/* prog 1 */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 2),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
 	BPF_EXIT_INSN(),
 
@@ -1057,8 +1057,8 @@
 	"calls: stack depth check using three frames. test1",
 	.insns = {
 	/* main */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 4), /* call A */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 5), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 4), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 5), /* call B */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -32, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1066,7 +1066,7 @@
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -256, 0),
 	BPF_EXIT_INSN(),
 	/* B */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, -3), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, -3), /* call A */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -64, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1080,8 +1080,8 @@
 	"calls: stack depth check using three frames. test2",
 	.insns = {
 	/* main */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 4), /* call A */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 5), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 4), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 5), /* call B */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -32, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1089,7 +1089,7 @@
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -64, 0),
 	BPF_EXIT_INSN(),
 	/* B */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, -3), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, -3), /* call A */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -256, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1104,9 +1104,9 @@
 	.insns = {
 	/* main */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 6), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 6), /* call A */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 8), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 8), /* call B */
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_6, 0, 1),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -64, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1118,7 +1118,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
 	/* B */
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, -6), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, -6), /* call A */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -256, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1152,18 +1152,18 @@
 	.insns = {
 	/* main */
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 6), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 6), /* call A */
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 4), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 4), /* call A */
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 7), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 7), /* call B */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* A */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call B */
 	BPF_EXIT_INSN(),
 	/* B */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
@@ -1178,28 +1178,28 @@
 	"calls: stack depth check using three frames. test5",
 	.insns = {
 	/* main */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call A */
 	BPF_EXIT_INSN(),
 	/* A */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call B */
 	BPF_EXIT_INSN(),
 	/* B */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call C */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call C */
 	BPF_EXIT_INSN(),
 	/* C */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call D */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call D */
 	BPF_EXIT_INSN(),
 	/* D */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call E */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call E */
 	BPF_EXIT_INSN(),
 	/* E */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call F */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call F */
 	BPF_EXIT_INSN(),
 	/* F */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call G */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call G */
 	BPF_EXIT_INSN(),
 	/* G */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1214,30 +1214,30 @@
 	.insns = {
 	/* main */
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call A */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call A */
 	BPF_EXIT_INSN(),
 	/* A */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2), /* call B */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 2), /* call B */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* B */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call C */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call C */
 	BPF_EXIT_INSN(),
 	/* C */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call D */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call D */
 	BPF_EXIT_INSN(),
 	/* D */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call E */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call E */
 	BPF_EXIT_INSN(),
 	/* E */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call F */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call F */
 	BPF_EXIT_INSN(),
 	/* F */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call G */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call G */
 	BPF_EXIT_INSN(),
 	/* G */
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
+	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1253,7 +1253,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1269,7 +1269,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
@@ -1283,7 +1283,7 @@
 {
 	"calls: write into callee stack frame",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
@@ -1303,16 +1303,16 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -16),
 	BPF_EXIT_INSN(),
 
 	/* subprog 1 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1327,10 +1327,10 @@
 	"calls: ambiguous return value",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
@@ -1351,7 +1351,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 8),
 
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
@@ -1371,10 +1371,10 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	/* first time with fp-8 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	/* second time with fp-16 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1384,7 +1384,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr into stack frame of main prog */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1403,7 +1403,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1412,7 +1412,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	/* first time with fp-8 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 9),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 9),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
@@ -1420,7 +1420,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	/* second time with fp-16 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch secound map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -1435,7 +1435,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(), /* return 0 */
@@ -1457,7 +1457,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1466,7 +1466,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	/* first time with fp-8 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 9),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 9),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
@@ -1474,7 +1474,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	/* second time with fp-16 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	/* fetch secound map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -1489,7 +1489,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(), /* return 0 */
@@ -1512,7 +1512,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1524,7 +1524,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
@@ -1536,7 +1536,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10), /* 20 */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, /* 24 */
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, /* 24 */
 		     BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
@@ -1550,7 +1550,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),  /* 34 */
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),  /* 34 */
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1584,7 +1584,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1596,7 +1596,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
@@ -1608,7 +1608,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10), /* 20 */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, /* 24 */
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, /* 24 */
 		     BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
@@ -1622,7 +1622,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),  /* 34 */
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),  /* 34 */
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1666,7 +1666,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -24),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
@@ -1678,7 +1678,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -24),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),  // 26
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
@@ -1725,7 +1725,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1737,7 +1737,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
@@ -1749,7 +1749,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
@@ -1762,7 +1762,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1794,7 +1794,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1806,7 +1806,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
@@ -1818,7 +1818,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
@@ -1831,7 +1831,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
@@ -1860,7 +1860,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* subprog 1 */
@@ -1889,7 +1889,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	/* Marking is still kept, but not in all cases safe. */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_ST_MEM(BPF_W, BPF_REG_4, 0, 0),
@@ -1921,7 +1921,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* Marking is still kept and safe here. */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
@@ -1957,7 +1957,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* Check marking propagated. */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
@@ -1993,7 +1993,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_4, 0),
 	BPF_EXIT_INSN(),
@@ -2029,7 +2029,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_4, 0),
 	BPF_EXIT_INSN(),
@@ -2064,7 +2064,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_4, 0),
 	BPF_EXIT_INSN(),
@@ -2106,7 +2106,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_4, 0),
 	BPF_EXIT_INSN(),
@@ -2147,7 +2147,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_4, 0),
 	BPF_EXIT_INSN(),
@@ -2182,7 +2182,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	/* fetch map_value_or_null or const_zero from stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -2199,7 +2199,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -2227,7 +2227,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 6 },
@@ -2239,10 +2239,10 @@
 	"calls: ctx read at start of subprog",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
 	BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
@@ -2262,12 +2262,12 @@
 	 * if (r8)
 	 *     do something bad;
 	 */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -2283,16 +2283,16 @@
 {
 	"calls: cross frame pruning - liveness propagation",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/cgroup_storage.c b/tools/testing/selftests/bpf/verifier/cgroup_storage.c
index 97057c0..89e245b 100644
--- a/tools/testing/selftests/bpf/verifier/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/verifier/cgroup_storage.c
@@ -3,7 +3,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -18,7 +18,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -34,7 +34,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -47,7 +47,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -63,7 +63,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
@@ -80,7 +80,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 7),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -96,7 +96,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -113,7 +113,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -128,7 +128,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -144,7 +144,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -157,7 +157,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -173,7 +173,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
@@ -190,7 +190,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_2, 7),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
@@ -206,7 +206,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index c8eaf05..a778020 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -38,7 +38,7 @@
 	"pass unmodified ctx pointer to helper",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_csum_update),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -51,7 +51,7 @@
 	.insns = {
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_csum_update),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -64,7 +64,7 @@
 	"pass modified ctx pointer to helper, 2",
 	.insns = {
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_socket_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -81,7 +81,7 @@
 		BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 4),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_csum_update),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -93,7 +93,7 @@
 {
 	"pass ctx or null check, 1: ctx",
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -106,7 +106,7 @@
 	"pass ctx or null check, 2: null",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -119,7 +119,7 @@
 	"pass ctx or null check, 3: 1",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_1, 1),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -133,7 +133,7 @@
 	"pass ctx or null check, 4: ctx - const",
 	.insns = {
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -147,7 +147,7 @@
 	"pass ctx or null check, 5: null (connect)",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -160,7 +160,7 @@
 	"pass ctx or null check, 6: null (bind)",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_netns_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -172,7 +172,7 @@
 {
 	"pass ctx or null check, 7: ctx (bind)",
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_socket_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -185,7 +185,7 @@
 	"pass ctx or null check, 8: null (bind)",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_socket_cookie),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index 83cecfb..fc55789 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -46,7 +46,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -70,7 +70,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -93,7 +93,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
diff --git a/tools/testing/selftests/bpf/verifier/d_path.c b/tools/testing/selftests/bpf/verifier/d_path.c
index b988396..5b6eb548 100644
--- a/tools/testing/selftests/bpf/verifier/d_path.c
+++ b/tools/testing/selftests/bpf/verifier/d_path.c
@@ -7,7 +7,7 @@
 	BPF_MOV64_IMM(BPF_REG_6, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
 	BPF_LD_IMM64(BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -25,7 +25,7 @@
 	BPF_MOV64_IMM(BPF_REG_6, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
 	BPF_LD_IMM64(BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c b/tools/testing/selftests/bpf/verifier/dead_code.c
index ee45432..6cd9d1b 100644
--- a/tools/testing/selftests/bpf/verifier/dead_code.c
+++ b/tools/testing/selftests/bpf/verifier/dead_code.c
@@ -27,7 +27,7 @@
 {
 	"dead code: mid 2",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 4),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
@@ -82,7 +82,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 7),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 8, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 12),
 	BPF_EXIT_INSN(),
@@ -98,9 +98,9 @@
 	BPF_MOV64_IMM(BPF_REG_0, 7),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 8, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 12),
 	BPF_EXIT_INSN(),
@@ -114,13 +114,13 @@
 	"dead code: function in the middle and mid of another func",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 12),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 7),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 7, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -5),
 	BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "loading/calling other bpf or kernel functions are allowed for",
@@ -134,7 +134,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, 2),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 2, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_EXIT_INSN(),
@@ -148,7 +148,7 @@
 	"dead code: start of a function",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
index dce2e28..46bf9e6 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -641,7 +641,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/event_output.c b/tools/testing/selftests/bpf/verifier/event_output.c
index c5e8059..0a1bc01 100644
--- a/tools/testing/selftests/bpf/verifier/event_output.c
+++ b/tools/testing/selftests/bpf/verifier/event_output.c
@@ -32,7 +32,7 @@
 	BPF_LD_MAP_FD(BPF_REG_2, 0),				\
 	BPF_MOV64_IMM(BPF_REG_3, 0),				\
 	BPF_MOV64_IMM(BPF_REG_5, 8),				\
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,		\
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,		\
 		     BPF_FUNC_perf_event_output),		\
 	BPF_MOV64_IMM(BPF_REG_0, 1),				\
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index a6c869a..37be14d 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -378,7 +378,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -399,7 +399,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 7),
@@ -423,7 +423,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/helper_packet_access.c b/tools/testing/selftests/bpf/verifier/helper_packet_access.c
index ae54587e..926ef8d 100644
--- a/tools/testing/selftests/bpf/verifier/helper_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/helper_packet_access.c
@@ -10,7 +10,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -24,7 +24,7 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -50,7 +50,7 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -70,7 +70,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -90,7 +90,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -112,7 +112,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -126,7 +126,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
 		    offsetof(struct __sk_buff, data)),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -153,7 +153,7 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -174,7 +174,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -195,7 +195,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -218,7 +218,7 @@
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 42),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_store_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_store_bytes),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -238,7 +238,7 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -262,7 +262,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -285,7 +285,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -308,7 +308,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -332,7 +332,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -356,7 +356,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -380,7 +380,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -404,7 +404,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -427,7 +427,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -450,7 +450,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/helper_restricted.c b/tools/testing/selftests/bpf/verifier/helper_restricted.c
index a067b70..423556b 100644
--- a/tools/testing/selftests/bpf/verifier/helper_restricted.c
+++ b/tools/testing/selftests/bpf/verifier/helper_restricted.c
@@ -1,7 +1,7 @@
 {
 	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE",
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
@@ -12,7 +12,7 @@
 {
 	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_TRACEPOINT",
 	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
@@ -23,7 +23,7 @@
 {
 	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_PERF_EVENT",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -34,7 +34,7 @@
 {
 	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -49,7 +49,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -69,7 +69,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -89,7 +89,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -109,7 +109,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -129,7 +129,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
@@ -147,7 +147,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
@@ -165,7 +165,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
@@ -183,7 +183,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index 1a27a62..59be762 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -789,7 +789,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
@@ -816,7 +816,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
@@ -844,7 +844,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
diff --git a/tools/testing/selftests/bpf/verifier/jset.c b/tools/testing/selftests/bpf/verifier/jset.c
index 11fc68d..feb1c01 100644
--- a/tools/testing/selftests/bpf/verifier/jset.c
+++ b/tools/testing/selftests/bpf/verifier/jset.c
@@ -104,7 +104,7 @@
 {
 	"jset: unknown const compare taken",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
@@ -119,7 +119,7 @@
 {
 	"jset: unknown const compare not taken",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
@@ -133,7 +133,7 @@
 {
 	"jset: half-known const compare",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_0, 2),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
@@ -148,7 +148,7 @@
 {
 	"jset: range",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xff),
diff --git a/tools/testing/selftests/bpf/verifier/jump.c b/tools/testing/selftests/bpf/verifier/jump.c
index 497fe17..f5c0866 100644
--- a/tools/testing/selftests/bpf/verifier/jump.c
+++ b/tools/testing/selftests/bpf/verifier/jump.c
@@ -78,7 +78,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -56, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -56),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 24 },
@@ -291,7 +291,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -20),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -20),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -302,7 +302,7 @@
 	"jump/call test 10",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, 16),
@@ -322,7 +322,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -20),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -20),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -333,7 +333,7 @@
 	"jump/call test 11",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
@@ -366,7 +366,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -31),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -31),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
diff --git a/tools/testing/selftests/bpf/verifier/junk_insn.c b/tools/testing/selftests/bpf/verifier/junk_insn.c
index 89d690f..4ec4fb8 100644
--- a/tools/testing/selftests/bpf/verifier/junk_insn.c
+++ b/tools/testing/selftests/bpf/verifier/junk_insn.c
@@ -40,6 +40,6 @@
 	BPF_RAW_INSN(0x7f, -1, -1, -1, -1),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "BPF_ALU uses reserved fields",
+	.errstr = "BPF_ALU32 uses reserved fields",
 	.result = REJECT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/ld_abs.c b/tools/testing/selftests/bpf/verifier/ld_abs.c
index f6599d2..06e5ad0 100644
--- a/tools/testing/selftests/bpf/verifier/ld_abs.c
+++ b/tools/testing/selftests/bpf/verifier/ld_abs.c
@@ -81,7 +81,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_vlan_push),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_vlan_push),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
 	BPF_LD_ABS(BPF_B, 0),
 	BPF_LD_ABS(BPF_H, 0),
@@ -257,7 +257,7 @@
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 		BPF_MOV64_IMM(BPF_REG_2, 1),
 		BPF_MOV64_IMM(BPF_REG_3, 2),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_skb_vlan_push),
 		BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
 		BPF_LD_ABS(BPF_B, 0),
diff --git a/tools/testing/selftests/bpf/verifier/leak_ptr.c b/tools/testing/selftests/bpf/verifier/leak_ptr.c
index 73f0dea..892eb00 100644
--- a/tools/testing/selftests/bpf/verifier/leak_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/leak_ptr.c
@@ -52,7 +52,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
diff --git a/tools/testing/selftests/bpf/verifier/loops1.c b/tools/testing/selftests/bpf/verifier/loops1.c
index 1af3718..eb69c65 100644
--- a/tools/testing/selftests/bpf/verifier/loops1.c
+++ b/tools/testing/selftests/bpf/verifier/loops1.c
@@ -24,7 +24,7 @@
 {
 	"bounded loop, count from positive unknown to 4",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
@@ -37,7 +37,7 @@
 {
 	"bounded loop, count from totally unknown to 4",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
@@ -89,7 +89,7 @@
 	BPF_MOV64_IMM(BPF_REG_6, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 10000, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_JMP_A(-4),
 	BPF_EXIT_INSN(),
 	},
@@ -113,13 +113,13 @@
 	"bounded recursion",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 4, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -5),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -175,7 +175,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 10),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
@@ -192,7 +192,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 10),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
diff --git a/tools/testing/selftests/bpf/verifier/map_in_map.c b/tools/testing/selftests/bpf/verifier/map_in_map.c
index 128a348..7e58a19 100644
--- a/tools/testing/selftests/bpf/verifier/map_in_map.c
+++ b/tools/testing/selftests/bpf/verifier/map_in_map.c
@@ -5,13 +5,13 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -26,21 +26,21 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
@@ -59,14 +59,14 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -81,12 +81,12 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 6914904..2aca724 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -8,7 +8,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
@@ -28,7 +28,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_W, BPF_REG_0, 0, 0),
@@ -48,7 +48,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
@@ -78,7 +78,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
@@ -93,7 +93,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -110,7 +110,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 7),
@@ -131,7 +131,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -161,7 +161,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
@@ -185,7 +185,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
@@ -206,7 +206,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
@@ -229,14 +229,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -253,7 +253,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
@@ -274,12 +274,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -297,13 +297,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -325,12 +325,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -347,21 +347,21 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -378,7 +378,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
@@ -386,12 +386,12 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -412,7 +412,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, 0),
@@ -433,7 +433,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 8, 0),
@@ -453,13 +453,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testing/selftests/bpf/verifier/map_ptr.c
index 17ee84d..a544056 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr.c
@@ -70,7 +70,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -88,7 +88,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_LD_MAP_FD(BPF_REG_0, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
index 1f2b8c4..253d711 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
@@ -10,7 +10,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -40,7 +40,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -68,7 +68,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -89,7 +89,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/map_ret_val.c b/tools/testing/selftests/bpf/verifier/map_ret_val.c
index bdd0e8d..24078fe 100644
--- a/tools/testing/selftests/bpf/verifier/map_ret_val.c
+++ b/tools/testing/selftests/bpf/verifier/map_ret_val.c
@@ -5,7 +5,7 @@
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "fd 0 is not pointing to valid bpf_map",
@@ -18,7 +18,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -33,7 +33,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
 	BPF_EXIT_INSN(),
@@ -50,7 +50,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/meta_access.c b/tools/testing/selftests/bpf/verifier/meta_access.c
index b45e8af..54e5a0b 100644
--- a/tools/testing/selftests/bpf/verifier/meta_access.c
+++ b/tools/testing/selftests/bpf/verifier/meta_access.c
@@ -80,7 +80,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_4, 3),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_meta),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_meta),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 6c03a7d..0fdfa42 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -118,16 +118,16 @@
 {
 	"precise: cross frame pruning",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -168,7 +168,7 @@
 {
 	"precise: STX insn causing spi > allocated_stack",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
@@ -202,12 +202,12 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_2, 0x1000),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 42),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c b/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
index fc4e301..0b09eb5 100644
--- a/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
+++ b/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_stacktrace = { 3 },
@@ -20,7 +20,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_prog2 = { 3 },
diff --git a/tools/testing/selftests/bpf/verifier/raw_stack.c b/tools/testing/selftests/bpf/verifier/raw_stack.c
index eb5ed9365..6f2cee2 100644
--- a/tools/testing/selftests/bpf/verifier/raw_stack.c
+++ b/tools/testing/selftests/bpf/verifier/raw_stack.c
@@ -22,7 +22,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -38,7 +38,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, ~0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -54,7 +54,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -70,7 +70,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -86,7 +86,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_6, 0, 0xcafe),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -103,7 +103,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
@@ -125,7 +125,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
 		    offsetof(struct __sk_buff, mark)),
@@ -147,7 +147,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,  0),
@@ -177,7 +177,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,  0),
@@ -200,7 +200,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -513),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -216,7 +216,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -1),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -232,7 +232,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 0xffffffff),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -248,7 +248,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -1),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 0x7fffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -264,7 +264,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 0x7fffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -280,7 +280,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -296,7 +296,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_4, 512),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c b/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
index 2978fb5..cc66892 100644
--- a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
+++ b/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
@@ -11,7 +11,7 @@
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
 		/* lookup in the map */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_map_lookup_elem),
 
 		/* exit clean if null */
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 9540164..f3cf02e 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -89,10 +89,10 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, -3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -110,10 +110,10 @@
 	"reference tracking: acquire/release system key reference",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -132,9 +132,9 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, -3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -153,9 +153,9 @@
 	"reference tracking: release system key reference without check",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -174,7 +174,7 @@
 	"reference tracking: release with NULL key pointer",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -193,7 +193,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, -3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_LSM,
@@ -210,7 +210,7 @@
 	"reference tracking: leak potential reference to system key",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_LSM,
@@ -382,7 +382,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -401,7 +401,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -421,7 +421,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -442,7 +442,7 @@
 	"reference tracking in call: alloc in subprog, release outside",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -461,7 +461,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -469,7 +469,7 @@
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
 	/* spill unchecked sk_ptr into stack of caller */
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
@@ -490,7 +490,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -498,7 +498,7 @@
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 8),
 	/* spill unchecked sk_ptr into stack of caller */
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
@@ -597,7 +597,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -620,7 +620,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -639,7 +639,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
@@ -665,7 +665,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
diff --git a/tools/testing/selftests/bpf/verifier/regalloc.c b/tools/testing/selftests/bpf/verifier/regalloc.c
index bb0dd89..ead6db9 100644
--- a/tools/testing/selftests/bpf/verifier/regalloc.c
+++ b/tools/testing/selftests/bpf/verifier/regalloc.c
@@ -203,7 +203,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 20, 4),
 	BPF_JMP_IMM(BPF_JSLT, BPF_REG_9, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_8),
@@ -233,7 +233,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 20, 5),
 	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
index 92e3f6a..d288253 100644
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
@@ -6,7 +6,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
@@ -22,7 +22,7 @@
 	/* add invalid offset to reserved ringbuf memory */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xcafe),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -38,7 +38,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
@@ -54,7 +54,7 @@
 	/* submit the reserved ringbuf memory */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -71,7 +71,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	/* check whether the reservation was successful */
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
@@ -81,11 +81,11 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 8),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_fib_lookup),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_fib_lookup),
 	/* submit the ringbuf memory */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/runtime_jit.c b/tools/testing/selftests/bpf/verifier/runtime_jit.c
index 94c399d..160911b 100644
--- a/tools/testing/selftests/bpf/verifier/runtime_jit.c
+++ b/tools/testing/selftests/bpf/verifier/runtime_jit.c
@@ -3,7 +3,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -16,7 +16,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, 1),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -29,7 +29,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -42,7 +42,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -64,7 +64,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -86,7 +86,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -108,7 +108,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -130,7 +130,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -152,7 +152,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -177,7 +177,7 @@
 	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -193,7 +193,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, 256),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -206,7 +206,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_3, -1),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -219,7 +219,7 @@
 	.insns = {
 	BPF_LD_IMM64(BPF_REG_3, 0x100000000ULL),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index 68b14fd..1a4d06b 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -5,7 +5,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_JMP_A(1),
@@ -26,7 +26,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
 	BPF_JMP_A(1),
@@ -62,7 +62,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
@@ -154,7 +154,7 @@
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
@@ -207,7 +207,7 @@
 	"allocated_stack",
 	.insns = {
 		BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 		BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 9bb302d..5b8d764 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -36,7 +36,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
@@ -50,7 +50,7 @@
 	/* submit the reserved ringbuf memory */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -66,7 +66,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* add invalid offset to memory or NULL */
@@ -78,7 +78,7 @@
 	/* submit the reserved ringbuf memory */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
index eaf114f..8f24b17 100644
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
@@ -6,17 +6,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -34,17 +34,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -63,17 +63,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -93,17 +93,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_6, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -123,17 +123,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -152,18 +152,18 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -182,18 +182,18 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -212,20 +212,20 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -244,7 +244,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -252,16 +252,16 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -280,19 +280,19 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -312,17 +312,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_LD_ABS(BPF_B, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -341,26 +341,26 @@
 	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/subreg.c b/tools/testing/selftests/bpf/verifier/subreg.c
index 4c4133c..ee18bb0 100644
--- a/tools/testing/selftests/bpf/verifier/subreg.c
+++ b/tools/testing/selftests/bpf/verifier/subreg.c
@@ -1,6 +1,6 @@
 /* This file contains sub-register zero extension checks for insns defining
  * sub-registers, meaning:
- *   - All insns under BPF_ALU class. Their BPF_ALU32 variants or narrow width
+ *   - All insns under BPF_ALU32 class. Their BPF_ALU32 variants or narrow width
  *     forms (BPF_END) could define sub-registers.
  *   - Narrow direct loads, BPF_B/H/W | BPF_LDX.
  *   - BPF_LD is not exposed to JIT back-ends, so no need for testing.
@@ -13,7 +13,7 @@
 {
 	"add32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
 	BPF_ALU32_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -26,7 +26,7 @@
 {
 	"add32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	/* An insn could have no effect on the low 32-bit, for example:
@@ -38,7 +38,7 @@
 	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, -2),
@@ -52,7 +52,7 @@
 {
 	"sub32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x1ffffffffULL),
 	BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -65,13 +65,13 @@
 {
 	"sub32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_SUB, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_SUB, BPF_REG_0, 1),
@@ -85,7 +85,7 @@
 {
 	"mul32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
 	BPF_ALU32_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
@@ -98,13 +98,13 @@
 {
 	"mul32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, -1),
@@ -118,7 +118,7 @@
 {
 	"div32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
 	BPF_ALU32_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
@@ -131,13 +131,13 @@
 {
 	"div32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_DIV, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_DIV, BPF_REG_0, 2),
@@ -151,7 +151,7 @@
 {
 	"or32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
 	BPF_ALU32_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
@@ -164,13 +164,13 @@
 {
 	"or32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_OR, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_OR, BPF_REG_0, 1),
@@ -184,7 +184,7 @@
 {
 	"and32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x1ffffffffULL),
@@ -198,13 +198,13 @@
 {
 	"and32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_AND, BPF_REG_0, -1),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_AND, BPF_REG_0, -2),
@@ -218,7 +218,7 @@
 {
 	"lsh32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
@@ -232,13 +232,13 @@
 {
 	"lsh32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_0, 1),
@@ -252,7 +252,7 @@
 {
 	"rsh32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
@@ -266,13 +266,13 @@
 {
 	"rsh32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_RSH, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_RSH, BPF_REG_0, 1),
@@ -286,7 +286,7 @@
 {
 	"neg32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_NEG, BPF_REG_0, 0),
@@ -299,7 +299,7 @@
 {
 	"mod32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
 	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
@@ -312,13 +312,13 @@
 {
 	"mod32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, 2),
@@ -332,7 +332,7 @@
 {
 	"xor32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
 	BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_1),
@@ -345,7 +345,7 @@
 {
 	"xor32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_XOR, BPF_REG_0, 1),
@@ -358,7 +358,7 @@
 {
 	"mov32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_1, BPF_REG_0),
 	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
@@ -372,13 +372,13 @@
 {
 	"mov32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_MOV32_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
@@ -392,7 +392,7 @@
 {
 	"arsh32 reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
@@ -406,13 +406,13 @@
 {
 	"arsh32 imm zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_ARSH, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_ALU32_IMM(BPF_ARSH, BPF_REG_0, 1),
@@ -426,10 +426,10 @@
 {
 	"end16 (to_le) reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
 	BPF_ENDIAN(BPF_TO_LE, BPF_REG_0, 16),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
@@ -441,10 +441,10 @@
 {
 	"end32 (to_le) reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
 	BPF_ENDIAN(BPF_TO_LE, BPF_REG_0, 32),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
@@ -456,10 +456,10 @@
 {
 	"end16 (to_be) reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
 	BPF_ENDIAN(BPF_TO_BE, BPF_REG_0, 16),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
@@ -471,10 +471,10 @@
 {
 	"end32 (to_be) reg zero extend check",
 	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
 	BPF_ENDIAN(BPF_TO_BE, BPF_REG_0, 32),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
@@ -489,7 +489,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
 	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
@@ -505,7 +505,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
 	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_6, 0),
@@ -521,7 +521,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
 	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index 878ca26..e035e92 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -69,7 +69,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_trace_printk),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_trace_printk),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -87,7 +87,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -103,7 +103,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -178,7 +178,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -193,7 +193,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -210,7 +210,7 @@
 	BPF_RAW_INSN(BPF_STX | BPF_ATOMIC | BPF_DW,
 		     BPF_REG_10, BPF_REG_0, -8, BPF_ADD),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -400,7 +400,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -441,7 +441,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_1),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/value_or_null.c b/tools/testing/selftests/bpf/verifier/value_or_null.c
index 52a8bca..1ea97759 100644
--- a/tools/testing/selftests/bpf/verifier/value_or_null.c
+++ b/tools/testing/selftests/bpf/verifier/value_or_null.c
@@ -6,7 +6,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
@@ -24,7 +24,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 2),
@@ -45,7 +45,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, -1),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -65,7 +65,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 1),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -87,11 +87,11 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
@@ -111,12 +111,12 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_2, 10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
@@ -133,7 +133,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES-1, 1),
@@ -158,7 +158,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
index 249187d..af7a406 100644
--- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
@@ -10,7 +10,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
@@ -43,7 +43,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
@@ -76,7 +76,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
@@ -107,7 +107,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
@@ -136,7 +136,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
@@ -169,7 +169,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
@@ -204,7 +204,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
@@ -239,7 +239,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -264,7 +264,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -292,7 +292,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -475,7 +475,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 48),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -497,7 +497,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 49),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -519,7 +519,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -539,7 +539,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -562,7 +562,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -587,7 +587,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -608,7 +608,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -627,7 +627,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -646,7 +646,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 49),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -665,7 +665,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, -1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -684,7 +684,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -707,7 +707,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, (6 + 1) * sizeof(int)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -725,7 +725,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, (3 + 1) * sizeof(int)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -745,7 +745,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV32_IMM(BPF_REG_1, 0x12345678),
 	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
@@ -766,7 +766,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
@@ -786,7 +786,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
@@ -806,7 +806,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_MOV64_IMM(BPF_REG_1, -1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -832,7 +832,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_1, 19),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -855,7 +855,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
@@ -875,7 +875,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
@@ -895,7 +895,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 8),
@@ -922,7 +922,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -940,7 +940,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
@@ -959,7 +959,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -978,7 +978,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
@@ -999,7 +999,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
@@ -1019,7 +1019,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
@@ -1039,7 +1039,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
@@ -1065,7 +1065,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -1085,7 +1085,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index d37f512..769b20f 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -178,7 +178,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
 	/* dereference it indirectly */
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -203,7 +203,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
 	/* dereference it indirectly */
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/xadd.c b/tools/testing/selftests/bpf/verifier/xadd.c
index b96ef35..8ce0171 100644
--- a/tools/testing/selftests/bpf/verifier/xadd.c
+++ b/tools/testing/selftests/bpf/verifier/xadd.c
@@ -18,7 +18,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index 82a1c183..3a2d2c8 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -494,11 +494,11 @@ static void __recv_prepare_packet_filter(int fd, int off_nexthdr, int off_dport)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
 		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, off_nexthdr),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_encap ? IPPROTO_UDP : cfg_proto, 0, 2),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, cfg_encap ? IPPROTO_UDP : cfg_proto, 0, 2),
 		BPF_STMT(BPF_LD + BPF_H + BPF_ABS, off_dport),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_port_dst, 1, 0),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, cfg_port_dst, 1, 0),
 		BPF_STMT(BPF_RET + BPF_K, 0),
 		BPF_STMT(BPF_RET + BPF_K, 0xFFFF),
 	};
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 30024d0..7709741 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -122,13 +122,13 @@ static void setup_sock_filter(int fd)
 
 	struct sock_filter filter[] = {
 			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, ethproto_off),
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 7),
+			BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 7),
 			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
+			BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
 			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, dport_off),
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, DPORT, 2, 0),
+			BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, DPORT, 2, 0),
 			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, dport_off + optlen),
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, DPORT, 0, 1),
+			BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, DPORT, 0, 1),
 			BPF_STMT(BPF_RET + BPF_K, 0xFFFFFFFF),
 			BPF_STMT(BPF_RET + BPF_K, 0),
 	};
diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 1a736f7..2fe7ead 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -149,13 +149,13 @@ static void sock_fanout_set_ebpf(int fd)
 	struct bpf_insn prog[] = {
 		{ BPF_ALU64 | BPF_MOV | BPF_X,   6, 1, 0, 0 },
 		{ BPF_LDX   | BPF_W   | BPF_MEM, 0, 6, len_off, 0 },
-		{ BPF_JMP   | BPF_JGE | BPF_K,   0, 0, 1, DATA_LEN },
-		{ BPF_JMP   | BPF_JA  | BPF_K,   0, 0, 4, 0 },
+		{ BPF_JMP64   | BPF_JGE | BPF_K,   0, 0, 1, DATA_LEN },
+		{ BPF_JMP64   | BPF_JA  | BPF_K,   0, 0, 4, 0 },
 		{ BPF_LD    | BPF_B   | BPF_ABS, 0, 0, 0, 0x50 },
-		{ BPF_JMP   | BPF_JEQ | BPF_K,   0, 0, 2, DATA_CHAR },
-		{ BPF_JMP   | BPF_JEQ | BPF_K,   0, 0, 1, DATA_CHAR_1 },
-		{ BPF_ALU   | BPF_MOV | BPF_K,   0, 0, 0, 0 },
-		{ BPF_JMP   | BPF_EXIT,          0, 0, 0, 0 }
+		{ BPF_JMP64   | BPF_JEQ | BPF_K,   0, 0, 2, DATA_CHAR },
+		{ BPF_JMP64   | BPF_JEQ | BPF_K,   0, 0, 1, DATA_CHAR_1 },
+		{ BPF_ALU32   | BPF_MOV | BPF_K,   0, 0, 0, 0 },
+		{ BPF_JMP64   | BPF_EXIT,          0, 0, 0, 0 }
 	};
 	union bpf_attr attr;
 	int pfd;
diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
index 65aea27..a4eab6d 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -103,7 +103,7 @@ static void attach_ebpf(int fd, uint16_t mod)
 		/* BPF_ALU64_IMM(BPF_MOD, BPF_REG_0, mod) */
 		{ BPF_ALU64 | BPF_MOD | BPF_K, BPF_REG_0, 0, 0, mod },
 		/* BPF_EXIT_INSN() */
-		{ BPF_JMP | BPF_EXIT, 0, 0, 0, 0 }
+		{ BPF_JMP64 | BPF_EXIT, 0, 0, 0, 0 }
 	};
 	union bpf_attr attr;
 
@@ -134,7 +134,7 @@ static void attach_cbpf(int fd, uint16_t mod)
 		/* A = (uint32_t)skb[0] */
 		{ BPF_LD  | BPF_W | BPF_ABS, 0, 0, 0 },
 		/* A = A % mod */
-		{ BPF_ALU | BPF_MOD, 0, 0, mod },
+		{ BPF_ALU32 | BPF_MOD, 0, 0, mod },
 		/* return A */
 		{ BPF_RET | BPF_A, 0, 0, 0 },
 	};
@@ -341,7 +341,7 @@ static void test_filter_no_reuseport(const struct test_params p)
 	const char bpf_license[] = "GPL";
 	struct bpf_insn ecode[] = {
 		{ BPF_ALU64 | BPF_MOV | BPF_K, BPF_REG_0, 0, 0, 10 },
-		{ BPF_JMP | BPF_EXIT, 0, 0, 0, 0 }
+		{ BPF_JMP64 | BPF_EXIT, 0, 0, 0, 0 }
 	};
 	struct sock_filter ccode[] = {{ BPF_RET | BPF_A, 0, 0, 0 }};
 	union bpf_attr eprog;
diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index c9ba36a..8def0fe 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -78,9 +78,9 @@ static void attach_bpf(int fd)
 	int bpf_fd;
 	const struct bpf_insn prog[] = {
 		/* R0 = bpf_get_numa_node_id() */
-		{ BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_numa_node_id },
+		{ BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_numa_node_id },
 		/* return R0 */
-		{ BPF_JMP | BPF_EXIT, 0, 0, 0, 0 }
+		{ BPF_JMP64 | BPF_EXIT, 0, 0, 0, 0 }
 	};
 	union bpf_attr attr;
 
diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 9ba0316..6774571 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -288,11 +288,11 @@ static void __set_filter(int fd, int off_proto, uint8_t proto, int off_dport)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
 		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, off_proto),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, proto, 0, 2),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, proto, 0, 2),
 		BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, off_dport),
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_dport, 1, 0),
+		BPF_JUMP(BPF_JMP64 + BPF_JEQ + BPF_K, cfg_dport, 1, 0),
 		BPF_STMT(BPF_RET + BPF_K, 0),
 		BPF_STMT(BPF_RET + BPF_K, 0xFFFF),
 	};
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9c2f448..9537f27 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -662,7 +662,7 @@ TEST_SIGNAL(KILL_one, SIGSYS)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -690,11 +690,11 @@ TEST_SIGNAL(KILL_one_arg_one, SIGSYS)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_times, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_times, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		/* Only both with lower 32-bit for now. */
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, syscall_arg(0)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K,
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K,
 			(unsigned long)&fatal_address, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -730,11 +730,11 @@ TEST_SIGNAL(KILL_one_arg_six, SIGSYS)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, sysno, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, sysno, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		/* Only both with lower 32-bit for now. */
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, syscall_arg(5)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, 0x0C0FFEE, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, 0x0C0FFEE, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -803,7 +803,7 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 	struct sock_filter filter_thread[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_THREAD),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -815,7 +815,7 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, kill),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -941,7 +941,7 @@ TEST(arg_out_of_range)
 	struct sock_filter _read_filter_##name[] = {			\
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,				\
 			offsetof(struct seccomp_data, nr)),		\
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 0, 1),	\
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_read, 0, 1),	\
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | errno),	\
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),		\
 	};								\
@@ -1048,7 +1048,7 @@ FIXTURE_SETUP(TRAP)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRAP),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -1167,35 +1167,35 @@ FIXTURE_SETUP(precedence)
 	struct sock_filter log_insns[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_LOG),
 	};
 	struct sock_filter trace_insns[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE),
 	};
 	struct sock_filter error_insns[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO),
 	};
 	struct sock_filter trap_insns[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRAP),
 	};
 	struct sock_filter kill_insns[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 1, 0),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 	};
@@ -1662,7 +1662,7 @@ FIXTURE_SETUP(TRACE_poke)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_read, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1001),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2117,13 +2117,13 @@ FIXTURE_SETUP(TRACE_syscall)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1002),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1003),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1004),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2221,7 +2221,7 @@ TEST_F_SIGNAL(TRACE_syscall, kill_immediate, SIGSYS)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_mknodat, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_mknodat, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_THREAD),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2244,7 +2244,7 @@ TEST_F(TRACE_syscall, skip_after)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EPERM),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2269,7 +2269,7 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after, SIGSYS)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2539,7 +2539,7 @@ FIXTURE_SETUP(TSYNC)
 	struct sock_filter apply_filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_read, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2648,7 +2648,7 @@ TEST_F(TSYNC, siblings_fail_prctl)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EINVAL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -2999,17 +2999,17 @@ TEST(syscall_restart)
 			 offsetof(struct seccomp_data, nr)),
 
 #ifdef __NR_sigreturn
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 7, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_sigreturn, 7, 0),
 #endif
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 6, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 5, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 4, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_nanosleep, 5, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_clock_nanosleep, 4, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_restart_syscall, 4, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_read, 6, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_exit, 5, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 4, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_nanosleep, 5, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_clock_nanosleep, 4, 0),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_restart_syscall, 4, 0),
 
 		/* Allow __NR_write for easy logging. */
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_write, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_write, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		/* The nanosleep jump target. */
@@ -3169,7 +3169,7 @@ TEST_SIGNAL(filter_flag_log, SIGSYS)
 	struct sock_filter kill_filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -3328,7 +3328,7 @@ static int user_notif_syscall(int nr, unsigned int flags)
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, nr, 0, 1),
+		BPF_JUMP(BPF_JMP64|BPF_JEQ|BPF_K, nr, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
-- 
2.1.0

