Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F2686610
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBAMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBAMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:36:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41AB25D127;
        Wed,  1 Feb 2023 04:36:44 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx7eraXNpjZXkLAA--.23438S3;
        Wed, 01 Feb 2023 20:36:42 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3WXNpjUXImAA--.10032S5;
        Wed, 01 Feb 2023 20:36:41 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: treewide: Clean up BPF_ALU_* and BPF_JMP_*
Date:   Wed,  1 Feb 2023 20:36:37 +0800
Message-Id: <1675254998-4951-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxOL3WXNpjUXImAA--.10032S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjv_XoW8JFW8urW5Aw43Zw4DCF4xGrW3p5X_AFykAF
        43p34rXF1DAw4kXw45Aa4kKFy2qr13KrWkGrsrCas2gr1xA3y7J3W3Xa45ta13Awnxtr1r
        GwsIqr1UC3s7tayjkFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCT
        nIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJT
        RUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr
        0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ambiguos macro BPF_ALU_* and BPF_JMP_* with new macro
BPF_ALU32_* and BPF_JMP64_* in the kernel code.

sed -i "s/BPF_ALU_/BPF_ALU32_/g" `grep BPF_ALU_ -rl .`
sed -i "s/BPF_JMP_/BPF_JMP64_/g" `grep BPF_JMP_ -rl .`

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/bpf/verifier.rst                     |   4 +-
 include/linux/bpf_verifier.h                       |  14 +-
 include/linux/filter.h                             |  10 +-
 kernel/bpf/arraymap.c                              |  14 +-
 kernel/bpf/core.c                                  |   2 +-
 kernel/bpf/hashtab.c                               |   8 +-
 kernel/bpf/verifier.c                              |  40 +-
 lib/test_bpf.c                                     | 596 ++++++++++-----------
 net/core/filter.c                                  |  60 +--
 net/xdp/xskmap.c                                   |   4 +-
 samples/bpf/bpf_insn.h                             |   8 +-
 samples/bpf/cookie_uid_helper_example.c            |   4 +-
 samples/bpf/sock_example.c                         |   2 +-
 samples/bpf/test_cgrp2_attach.c                    |   4 +-
 samples/bpf/test_cgrp2_sock.c                      |   2 +-
 tools/bpf/bpf_dbg.c                                | 252 ++++-----
 tools/bpf/bpftool/feature.c                        |   4 +-
 tools/include/linux/filter.h                       |  10 +-
 tools/lib/bpf/gen_loader.c                         |  36 +-
 tools/perf/util/bpf-prologue.c                     |   6 +-
 tools/testing/selftests/bpf/prog_tests/align.c     |  24 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |  24 +-
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c |   2 +-
 .../bpf/prog_tests/flow_dissector_load_bytes.c     |   2 +-
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |  40 +-
 tools/testing/selftests/bpf/test_lru_map.c         |   4 +-
 tools/testing/selftests/bpf/test_sock.c            |  30 +-
 tools/testing/selftests/bpf/test_sock_addr.c       |   6 +-
 tools/testing/selftests/bpf/test_sysctl.c          | 172 +++---
 tools/testing/selftests/bpf/test_verifier.c        |  24 +-
 tools/testing/selftests/bpf/verifier/and.c         |   4 +-
 .../testing/selftests/bpf/verifier/array_access.c  |  46 +-
 tools/testing/selftests/bpf/verifier/atomic_and.c  |  14 +-
 .../testing/selftests/bpf/verifier/atomic_bounds.c |   2 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |  12 +-
 .../testing/selftests/bpf/verifier/atomic_fetch.c  |  12 +-
 .../selftests/bpf/verifier/atomic_fetch_add.c      |   8 +-
 tools/testing/selftests/bpf/verifier/atomic_or.c   |  12 +-
 tools/testing/selftests/bpf/verifier/atomic_xchg.c |   4 +-
 tools/testing/selftests/bpf/verifier/atomic_xor.c  |  10 +-
 tools/testing/selftests/bpf/verifier/basic_instr.c |  14 +-
 tools/testing/selftests/bpf/verifier/bounds.c      |  96 ++--
 .../selftests/bpf/verifier/bounds_deduction.c      |  24 +-
 .../bpf/verifier/bounds_mix_sign_unsign.c          | 100 ++--
 .../testing/selftests/bpf/verifier/bpf_get_stack.c |  12 +-
 .../selftests/bpf/verifier/bpf_loop_inline.c       |  14 +-
 tools/testing/selftests/bpf/verifier/calls.c       | 234 ++++----
 tools/testing/selftests/bpf/verifier/cfg.c         |  14 +-
 tools/testing/selftests/bpf/verifier/cgroup_skb.c  |   2 +-
 tools/testing/selftests/bpf/verifier/ctx_sk_msg.c  |   8 +-
 tools/testing/selftests/bpf/verifier/ctx_skb.c     | 124 ++---
 tools/testing/selftests/bpf/verifier/dead_code.c   |  40 +-
 .../selftests/bpf/verifier/direct_packet_access.c  |  90 ++--
 .../testing/selftests/bpf/verifier/div_overflow.c  |   8 +-
 .../selftests/bpf/verifier/helper_access_var_len.c |  74 +--
 .../selftests/bpf/verifier/helper_packet_access.c  |  42 +-
 .../selftests/bpf/verifier/helper_restricted.c     |  16 +-
 .../selftests/bpf/verifier/helper_value_access.c   | 132 ++---
 .../selftests/bpf/verifier/jeq_infer_not_null.c    |  32 +-
 tools/testing/selftests/bpf/verifier/jit.c         |  50 +-
 tools/testing/selftests/bpf/verifier/jmp32.c       |  26 +-
 tools/testing/selftests/bpf/verifier/jset.c        |  32 +-
 tools/testing/selftests/bpf/verifier/jump.c        | 230 ++++----
 tools/testing/selftests/bpf/verifier/ld_abs.c      |  10 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    |   6 +-
 tools/testing/selftests/bpf/verifier/leak_ptr.c    |   2 +-
 tools/testing/selftests/bpf/verifier/loops1.c      |  44 +-
 tools/testing/selftests/bpf/verifier/lwt.c         |  16 +-
 tools/testing/selftests/bpf/verifier/map_in_map.c  |  12 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |  68 +--
 .../selftests/bpf/verifier/map_ptr_mixing.c        |  20 +-
 tools/testing/selftests/bpf/verifier/map_ret_val.c |   4 +-
 tools/testing/selftests/bpf/verifier/meta_access.c |  30 +-
 tools/testing/selftests/bpf/verifier/precise.c     |  32 +-
 .../selftests/bpf/verifier/raw_tp_writable.c       |   2 +-
 .../testing/selftests/bpf/verifier/ref_tracking.c  | 118 ++--
 tools/testing/selftests/bpf/verifier/regalloc.c    |  60 +--
 tools/testing/selftests/bpf/verifier/ringbuf.c     |   6 +-
 tools/testing/selftests/bpf/verifier/runtime_jit.c |  24 +-
 .../selftests/bpf/verifier/search_pruning.c        |  56 +-
 tools/testing/selftests/bpf/verifier/sock.c        | 114 ++--
 tools/testing/selftests/bpf/verifier/spill_fill.c  |  18 +-
 tools/testing/selftests/bpf/verifier/spin_lock.c   |  44 +-
 tools/testing/selftests/bpf/verifier/stack_ptr.c   |   6 +-
 tools/testing/selftests/bpf/verifier/uninit.c      |   2 +-
 tools/testing/selftests/bpf/verifier/unpriv.c      |  44 +-
 tools/testing/selftests/bpf/verifier/value.c       |  10 +-
 .../selftests/bpf/verifier/value_adj_spill.c       |   4 +-
 .../selftests/bpf/verifier/value_illegal_alu.c     |  10 +-
 .../testing/selftests/bpf/verifier/value_or_null.c |  26 +-
 .../selftests/bpf/verifier/value_ptr_arith.c       | 186 +++----
 tools/testing/selftests/bpf/verifier/var_off.c     |   2 +-
 tools/testing/selftests/bpf/verifier/xadd.c        |  14 +-
 tools/testing/selftests/bpf/verifier/xdp.c         |   2 +-
 .../bpf/verifier/xdp_direct_packet_access.c        | 228 ++++----
 95 files changed, 2083 insertions(+), 2083 deletions(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index ecf6ead..16d0d19 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -427,7 +427,7 @@ accesses the memory with incorrect alignment::
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
   BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+  BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
   BPF_EXIT_INSN(),
 
@@ -452,7 +452,7 @@ to do so in the other side of 'if' branch::
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
   BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+  BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
   BPF_EXIT_INSN(),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa83de1..1fdbca0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -409,13 +409,13 @@ struct bpf_loop_inline_state {
 };
 
 /* Possible states for alu_state member. */
-#define BPF_ALU_SANITIZE_SRC		(1U << 0)
-#define BPF_ALU_SANITIZE_DST		(1U << 1)
-#define BPF_ALU_NEG_VALUE		(1U << 2)
-#define BPF_ALU_NON_POINTER		(1U << 3)
-#define BPF_ALU_IMMEDIATE		(1U << 4)
-#define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
-					 BPF_ALU_SANITIZE_DST)
+#define BPF_ALU32_SANITIZE_SRC		(1U << 0)
+#define BPF_ALU32_SANITIZE_DST		(1U << 1)
+#define BPF_ALU32_NEG_VALUE		(1U << 2)
+#define BPF_ALU32_NON_POINTER		(1U << 3)
+#define BPF_ALU32_IMMEDIATE		(1U << 4)
+#define BPF_ALU32_SANITIZE		(BPF_ALU32_SANITIZE_SRC | \
+					 BPF_ALU32_SANITIZE_DST)
 
 struct bpf_insn_aux_data {
 	union {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 347fcfa..c1f0182 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -303,7 +303,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 /* Conditional jumps against registers, if (dst_reg 'op' src_reg) goto pc + off16 */
 
-#define BPF_JMP_REG(OP, DST, SRC, OFF)				\
+#define BPF_JMP64_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
@@ -313,7 +313,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 /* Conditional jumps against immediates, if (dst_reg 'op' imm32) goto pc + off16 */
 
-#define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
+#define BPF_JMP64_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
@@ -321,7 +321,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = IMM })
 
-/* Like BPF_JMP_REG, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_REG, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
@@ -331,7 +331,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = 0 })
 
-/* Like BPF_JMP_IMM, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_IMM, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
@@ -343,7 +343,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 /* Unconditional jumps, goto pc + off16 */
 
-#define BPF_JMP_A(OFF)						\
+#define BPF_JMP64_A(OFF)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_JA,			\
 		.dst_reg = 0,					\
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 4847069..601e465 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -217,10 +217,10 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
+		*insn++ = BPF_JMP64_IMM(BPF_JGE, ret, map->max_entries, 4);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
+		*insn++ = BPF_JMP64_IMM(BPF_JGE, ret, map->max_entries, 3);
 	}
 
 	if (is_power_of_2(elem_size)) {
@@ -229,7 +229,7 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 		*insn++ = BPF_ALU64_IMM(BPF_MUL, ret, elem_size);
 	}
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, map_ptr);
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 	*insn++ = BPF_MOV64_IMM(ret, 0);
 	return insn - insn_buf;
 }
@@ -1347,10 +1347,10 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 6);
+		*insn++ = BPF_JMP64_IMM(BPF_JGE, ret, map->max_entries, 6);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+		*insn++ = BPF_JMP64_IMM(BPF_JGE, ret, map->max_entries, 5);
 	}
 	if (is_power_of_2(elem_size))
 		*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(elem_size));
@@ -1358,8 +1358,8 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 		*insn++ = BPF_ALU64_IMM(BPF_MUL, ret, elem_size);
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, map_ptr);
 	*insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, ret, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 	*insn++ = BPF_MOV64_IMM(ret, 0);
 
 	return insn - insn_buf;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d31b38c..ebc6c97 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1297,7 +1297,7 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 			off -= 2;
 		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, off);
+		*to++ = BPF_JMP64_REG(from->code, from->dst_reg, BPF_REG_AX, off);
 		break;
 
 	case BPF_JMP32 | BPF_JEQ  | BPF_K:
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 66bded1..aa74085 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -700,7 +700,7 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
 				round_up(map->key_size, 8));
@@ -741,11 +741,11 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, ret, 0, 4);
 	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret,
 			      offsetof(struct htab_elem, lru_node) +
 			      offsetof(struct bpf_lru_node, ref));
-	*insn++ = BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JNE, ref_reg, 0, 1);
 	*insn++ = BPF_ST_MEM(BPF_B, ret,
 			     offsetof(struct htab_elem, lru_node) +
 			     offsetof(struct bpf_lru_node, ref),
@@ -2492,7 +2492,7 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, ret, 0, 2);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
 				round_up(map->key_size, 8));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0869c50..46a4783 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9794,7 +9794,7 @@ static int sanitize_val_alu(struct bpf_verifier_env *env,
 	if (can_skip_alu_sanitation(env, insn))
 		return 0;
 
-	return update_alu_sanitation_state(aux, BPF_ALU_NON_POINTER, 0);
+	return update_alu_sanitation_state(aux, BPF_ALU32_NON_POINTER, 0);
 }
 
 static bool sanitize_needed(u8 opcode)
@@ -9877,10 +9877,10 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		alu_state = info->aux.alu_state;
 		alu_limit = abs(info->aux.alu_limit - alu_limit);
 	} else {
-		alu_state  = off_is_neg ? BPF_ALU_NEG_VALUE : 0;
-		alu_state |= off_is_imm ? BPF_ALU_IMMEDIATE : 0;
+		alu_state  = off_is_neg ? BPF_ALU32_NEG_VALUE : 0;
+		alu_state |= off_is_imm ? BPF_ALU32_IMMEDIATE : 0;
 		alu_state |= ptr_is_dst_reg ?
-			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
+			     BPF_ALU32_SANITIZE_SRC : BPF_ALU32_SANITIZE_DST;
 
 		/* Limit pruning on unknown scalars to enable deep search for
 		 * potential masking differences from other program paths.
@@ -15169,7 +15169,7 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 static void sanitize_dead_code(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	struct bpf_insn trap = BPF_JMP_IMM(BPF_JA, 0, 0, -1);
+	struct bpf_insn trap = BPF_JMP64_IMM(BPF_JA, 0, 0, -1);
 	struct bpf_insn *insn = env->prog->insnsi;
 	const int insn_cnt = env->prog->len;
 	int i;
@@ -15199,7 +15199,7 @@ static bool insn_is_cond_jump(u8 code)
 static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	struct bpf_insn ja = BPF_JMP64_IMM(BPF_JA, 0, 0, 0);
 	struct bpf_insn *insn = env->prog->insnsi;
 	const int insn_cnt = env->prog->len;
 	int i;
@@ -15248,7 +15248,7 @@ static int opt_remove_dead_code(struct bpf_verifier_env *env)
 
 static int opt_remove_nops(struct bpf_verifier_env *env)
 {
-	const struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	const struct bpf_insn ja = BPF_JMP64_IMM(BPF_JA, 0, 0, 0);
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	int i, err;
@@ -15937,7 +15937,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					     BPF_JNE | BPF_K, insn->src_reg,
 					     0, 2, 0),
 				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 				*insn,
 			};
 			struct bpf_insn chk_and_mod[] = {
@@ -15946,7 +15946,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					     BPF_JEQ | BPF_K, insn->src_reg,
 					     0, 1 + (is64 ? 0 : 1), 0),
 				*insn,
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
 
@@ -15995,13 +15995,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			aux = &env->insn_aux_data[i + delta];
 			if (!aux->alu_state ||
-			    aux->alu_state == BPF_ALU_NON_POINTER)
+			    aux->alu_state == BPF_ALU32_NON_POINTER)
 				continue;
 
-			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
-			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
-				BPF_ALU_SANITIZE_SRC;
-			isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
+			isneg = aux->alu_state & BPF_ALU32_NEG_VALUE;
+			issrc = (aux->alu_state & BPF_ALU32_SANITIZE) ==
+				BPF_ALU32_SANITIZE_SRC;
+			isimm = aux->alu_state & BPF_ALU32_IMMEDIATE;
 
 			off_reg = issrc ? insn->src_reg : insn->dst_reg;
 			if (isimm) {
@@ -16121,7 +16121,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			}
 
 			map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
-			insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
+			insn_buf[0] = BPF_JMP64_IMM(BPF_JGE, BPF_REG_3,
 						  map_ptr->max_entries, 2);
 			insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
 						    container_of(map_ptr,
@@ -16326,7 +16326,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[7] = BPF_JMP_A(1);
+			insn_buf[7] = BPF_JMP64_A(1);
 			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 			cnt = 9;
 
@@ -16459,9 +16459,9 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 		/* Return error and jump to the end of the patch if
 		 * expected number of iterations is too big.
 		 */
-		BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
+		BPF_JMP64_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
 		BPF_MOV32_IMM(BPF_REG_0, -E2BIG),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 16),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 16),
 		/* spill R6, R7, R8 to use these as loop vars */
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset),
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset),
@@ -16473,7 +16473,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 		/* loop header,
 		 * if reg_loop_cnt >= reg_loop_max skip the loop body
 		 */
-		BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
+		BPF_JMP64_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
 		/* callback call,
 		 * correct callback offset would be set after patching
 		 */
@@ -16483,7 +16483,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 		/* increment loop counter */
 		BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1),
 		/* jump to loop header if callback returned 0 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
 		/* return value of bpf_loop,
 		 * set R0 to the number of iterations
 		 */
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index be5f161..f84fc19 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -276,7 +276,7 @@ static int bpf_fill_maxinsns9(struct bpf_test *self)
 	if (!insn)
 		return -ENOMEM;
 
-	insn[0] = BPF_JMP_IMM(BPF_JA, 0, 0, len - 2);
+	insn[0] = BPF_JMP64_IMM(BPF_JA, 0, 0, len - 2);
 	insn[1] = BPF_ALU32_IMM(BPF_MOV, R0, 0xcbababab);
 	insn[2] = BPF_EXIT_INSN();
 
@@ -284,7 +284,7 @@ static int bpf_fill_maxinsns9(struct bpf_test *self)
 		insn[i] = BPF_ALU32_IMM(BPF_MOV, R0, 0xfefefefe);
 
 	insn[len - 2] = BPF_EXIT_INSN();
-	insn[len - 1] = BPF_JMP_IMM(BPF_JA, 0, 0, -(len - 1));
+	insn[len - 1] = BPF_JMP64_IMM(BPF_JA, 0, 0, -(len - 1));
 
 	self->u.ptr.insns = insn;
 	self->u.ptr.len = len;
@@ -303,11 +303,11 @@ static int bpf_fill_maxinsns10(struct bpf_test *self)
 		return -ENOMEM;
 
 	for (i = 0; i < hlen / 2; i++)
-		insn[i] = BPF_JMP_IMM(BPF_JA, 0, 0, hlen - 2 - 2 * i);
+		insn[i] = BPF_JMP64_IMM(BPF_JA, 0, 0, hlen - 2 - 2 * i);
 	for (i = hlen - 1; i > hlen / 2; i--)
-		insn[i] = BPF_JMP_IMM(BPF_JA, 0, 0, hlen - 1 - 2 * i);
+		insn[i] = BPF_JMP64_IMM(BPF_JA, 0, 0, hlen - 1 - 2 * i);
 
-	insn[hlen / 2] = BPF_JMP_IMM(BPF_JA, 0, 0, hlen / 2 - 1);
+	insn[hlen / 2] = BPF_JMP64_IMM(BPF_JA, 0, 0, hlen / 2 - 1);
 	insn[hlen]     = BPF_ALU32_IMM(BPF_MOV, R0, 0xabababac);
 	insn[hlen + 1] = BPF_EXIT_INSN();
 
@@ -490,7 +490,7 @@ static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm)
 
 	i = __bpf_ld_imm64(insns, R1, 0x0123456789abcdefULL);
 	insns[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 1);
-	insns[i++] = BPF_JMP_IMM(jmp, R0, imm, S16_MAX);
+	insns[i++] = BPF_JMP64_IMM(jmp, R0, imm, S16_MAX);
 	insns[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 2);
 	insns[i++] = BPF_EXIT_INSN();
 
@@ -651,7 +651,7 @@ static int __bpf_fill_alu_shift(struct bpf_test *self, u8 op,
 
 			/* Load reference and check the result */
 			i += __bpf_ld_imm64(&insn[i], R4, val);
-			insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R4, 1);
+			insn[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R4, 1);
 			insn[i++] = BPF_EXIT_INSN();
 		}
 	}
@@ -762,7 +762,7 @@ static int __bpf_fill_alu_shift_same_reg(struct bpf_test *self, u8 op,
 		i += __bpf_ld_imm64(&insn[i], R2, res);
 
 		/* Check the actual result */
-		insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R2, 1);
+		insn[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R2, 1);
 		insn[i++] = BPF_EXIT_INSN();
 	}
 
@@ -927,7 +927,7 @@ static int __bpf_emit_alu64_imm(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R1, dst);
 		i += __bpf_ld_imm64(&insns[i], R3, res);
 		insns[i++] = BPF_ALU64_IMM(op, R1, imm);
-		insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+		insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] = BPF_EXIT_INSN();
 	}
 
@@ -948,7 +948,7 @@ static int __bpf_emit_alu32_imm(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R1, dst);
 		i += __bpf_ld_imm64(&insns[i], R3, (u32)res);
 		insns[i++] = BPF_ALU32_IMM(op, R1, imm);
-		insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+		insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] = BPF_EXIT_INSN();
 	}
 
@@ -970,7 +970,7 @@ static int __bpf_emit_alu64_reg(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R2, src);
 		i += __bpf_ld_imm64(&insns[i], R3, res);
 		insns[i++] = BPF_ALU64_REG(op, R1, R2);
-		insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+		insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] = BPF_EXIT_INSN();
 	}
 
@@ -992,7 +992,7 @@ static int __bpf_emit_alu32_reg(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R2, src);
 		i += __bpf_ld_imm64(&insns[i], R3, (u32)res);
 		insns[i++] = BPF_ALU32_REG(op, R1, R2);
-		insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+		insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] = BPF_EXIT_INSN();
 	}
 
@@ -1626,13 +1626,13 @@ static int __bpf_emit_atomic64(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_ATOMIC_OP(BPF_DW, op, R10, R2, -8);
 	insns[i++] = BPF_LDX_MEM(BPF_DW, R1, R10, -8);
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R2, R4, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R2, R4, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R5, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R5, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
 	return i;
@@ -1673,13 +1673,13 @@ static int __bpf_emit_atomic32(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_ATOMIC_OP(BPF_W, op, R10, R2, -4);
 	insns[i++] = BPF_LDX_MEM(BPF_W, R1, R10, -4);
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R2, R4, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R2, R4, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R5, 1);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R5, 1);
 	insns[i++] = BPF_EXIT_INSN();
 
 	return i;
@@ -1702,11 +1702,11 @@ static int __bpf_emit_cmpxchg64(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -8);
 	insns[i++] = BPF_LDX_MEM(BPF_DW, R3, R10, -8);
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R1, R3, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R3, 2);
 	insns[i++] = BPF_MOV64_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R3, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R3, 2);
 	insns[i++] = BPF_MOV64_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
@@ -1714,11 +1714,11 @@ static int __bpf_emit_cmpxchg64(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -8);
 	insns[i++] = BPF_LDX_MEM(BPF_DW, R3, R10, -8);
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R2, R3, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R2, R3, 2);
 	insns[i++] = BPF_MOV64_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R1, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R1, 2);
 	insns[i++] = BPF_MOV64_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
@@ -1747,7 +1747,7 @@ static int __bpf_emit_cmpxchg32(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_MOV32_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R3, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R3, 2);
 	insns[i++] = BPF_MOV32_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
@@ -1761,7 +1761,7 @@ static int __bpf_emit_cmpxchg32(struct bpf_test *self, void *arg,
 	insns[i++] = BPF_MOV32_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
-	insns[i++] = BPF_JMP_REG(BPF_JEQ, R0, R1, 2);
+	insns[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R1, 2);
 	insns[i++] = BPF_MOV32_IMM(R0, __LINE__);
 	insns[i++] = BPF_EXIT_INSN();
 
@@ -1987,7 +1987,7 @@ static int __bpf_fill_atomic_reg_pairs(struct bpf_test *self, u8 width, u8 op)
 			/* Check destination register value */
 			if (!(rd == R0 && op == BPF_CMPXCHG) &&
 			    !(rd == rs && (op & BPF_FETCH))) {
-				insn[i++] = BPF_JMP_REG(BPF_JEQ, rd, R10, 2);
+				insn[i++] = BPF_JMP64_REG(BPF_JEQ, rd, R10, 2);
 				insn[i++] = BPF_MOV32_IMM(R0, __LINE__);
 				insn[i++] = BPF_EXIT_INSN();
 			}
@@ -2006,7 +2006,7 @@ static int __bpf_fill_atomic_reg_pairs(struct bpf_test *self, u8 width, u8 op)
 
 			insn[i++] = BPF_LDX_MEM(width, R0, R10, -8);
 			if (width == BPF_DW)
-				insn[i++] = BPF_JMP_REG(BPF_JEQ, R0, R1, 2);
+				insn[i++] = BPF_JMP64_REG(BPF_JEQ, R0, R1, 2);
 			else /* width == BPF_W */
 				insn[i++] = BPF_JMP32_REG(BPF_JEQ, R0, R1, 2);
 			insn[i++] = BPF_MOV32_IMM(R0, __LINE__);
@@ -2165,7 +2165,7 @@ static int bpf_fill_ld_imm64_magn(struct bpf_test *self)
 				insn[i++] = BPF_ALU64_REG(BPF_OR, R2, R3);
 
 				/* Check result */
-				insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R2, 1);
+				insn[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R2, 1);
 				insn[i++] = BPF_EXIT_INSN();
 			}
 		}
@@ -2229,7 +2229,7 @@ static int __bpf_fill_ld_imm64_bytes(struct bpf_test *self,
 		insn[i++] = BPF_ALU64_REG(BPF_OR, R2, R3);
 
 		/* Check result */
-		insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R2, 1);
+		insn[i++] = BPF_JMP64_REG(BPF_JEQ, R1, R2, 1);
 		insn[i++] = BPF_EXIT_INSN();
 	}
 
@@ -2311,9 +2311,9 @@ static int __bpf_emit_jmp_imm(struct bpf_test *self, void *arg,
 		insns[i++] = BPF_ALU32_IMM(BPF_MOV, R0, match);
 
 		i += __bpf_ld_imm64(&insns[i], R1, dst);
-		insns[i++] = BPF_JMP_IMM(op, R1, imm, 1);
+		insns[i++] = BPF_JMP64_IMM(op, R1, imm, 1);
 		if (!match)
-			insns[i++] = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			insns[i++] = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 		insns[i++] = BPF_EXIT_INSN();
 
 		return i;
@@ -2334,7 +2334,7 @@ static int __bpf_emit_jmp32_imm(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R1, dst);
 		insns[i++] = BPF_JMP32_IMM(op, R1, imm, 1);
 		if (!match)
-			insns[i++] = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			insns[i++] = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 		insns[i++] = BPF_EXIT_INSN();
 
 		return i;
@@ -2354,9 +2354,9 @@ static int __bpf_emit_jmp_reg(struct bpf_test *self, void *arg,
 
 		i += __bpf_ld_imm64(&insns[i], R1, dst);
 		i += __bpf_ld_imm64(&insns[i], R2, src);
-		insns[i++] = BPF_JMP_REG(op, R1, R2, 1);
+		insns[i++] = BPF_JMP64_REG(op, R1, R2, 1);
 		if (!match)
-			insns[i++] = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			insns[i++] = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 		insns[i++] = BPF_EXIT_INSN();
 
 		return i;
@@ -2378,7 +2378,7 @@ static int __bpf_emit_jmp32_reg(struct bpf_test *self, void *arg,
 		i += __bpf_ld_imm64(&insns[i], R2, src);
 		insns[i++] = BPF_JMP32_REG(op, R1, R2, 1);
 		if (!match)
-			insns[i++] = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			insns[i++] = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 		insns[i++] = BPF_EXIT_INSN();
 
 		return i;
@@ -2712,7 +2712,7 @@ static int __bpf_fill_staggered_jumps(struct bpf_test *self,
 	insns[0] = BPF_ALU64_IMM(BPF_MOV, R0, 0);
 	insns[1] = BPF_ALU64_IMM(BPF_MOV, R1, r1);
 	insns[2] = BPF_ALU64_IMM(BPF_MOV, R2, r2);
-	insns[3] = BPF_JMP_IMM(BPF_JA, 0, 0, 3 * size / 2);
+	insns[3] = BPF_JMP64_IMM(BPF_JA, 0, 0, 3 * size / 2);
 
 	/* Sequence */
 	for (ind = 0, off = size; ind <= size; ind++, off -= 2) {
@@ -2723,7 +2723,7 @@ static int __bpf_fill_staggered_jumps(struct bpf_test *self,
 			off--;
 
 		loc = abs(off);
-		ins[0] = BPF_JMP_IMM(BPF_JNE, R0, loc - 1,
+		ins[0] = BPF_JMP64_IMM(BPF_JNE, R0, loc - 1,
 				     3 * (size - ind) + 1);
 		ins[1] = BPF_ALU64_IMM(BPF_MOV, R0, loc);
 		ins[2] = *jmp;
@@ -2742,7 +2742,7 @@ static int __bpf_fill_staggered_jumps(struct bpf_test *self,
 /* 64-bit unconditional jump */
 static int bpf_fill_staggered_ja(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JA, 0, 0, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 0, 0);
 }
@@ -2750,77 +2750,77 @@ static int bpf_fill_staggered_ja(struct bpf_test *self)
 /* 64-bit immediate jumps */
 static int bpf_fill_staggered_jeq_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JEQ, R1, 1234, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JEQ, R1, 1234, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 0);
 }
 
 static int bpf_fill_staggered_jne_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JNE, R1, 1234, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JNE, R1, 1234, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 4321, 0);
 }
 
 static int bpf_fill_staggered_jset_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JSET, R1, 0x82, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JSET, R1, 0x82, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 0x86, 0);
 }
 
 static int bpf_fill_staggered_jgt_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JGT, R1, 1234, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JGT, R1, 1234, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 0x80000000, 0);
 }
 
 static int bpf_fill_staggered_jge_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JGE, R1, 1234, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JGE, R1, 1234, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 0);
 }
 
 static int bpf_fill_staggered_jlt_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JLT, R1, 0x80000000, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JLT, R1, 0x80000000, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 0);
 }
 
 static int bpf_fill_staggered_jle_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JLE, R1, 1234, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JLE, R1, 1234, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 0);
 }
 
 static int bpf_fill_staggered_jsgt_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JSGT, R1, -2, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JSGT, R1, -2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -1, 0);
 }
 
 static int bpf_fill_staggered_jsge_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JSGE, R1, -2, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JSGE, R1, -2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -2, 0);
 }
 
 static int bpf_fill_staggered_jslt_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JSLT, R1, -1, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JSLT, R1, -1, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -2, 0);
 }
 
 static int bpf_fill_staggered_jsle_imm(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_IMM(BPF_JSLE, R1, -1, 0);
+	struct bpf_insn jmp = BPF_JMP64_IMM(BPF_JSLE, R1, -1, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -1, 0);
 }
@@ -2828,77 +2828,77 @@ static int bpf_fill_staggered_jsle_imm(struct bpf_test *self)
 /* 64-bit register jumps */
 static int bpf_fill_staggered_jeq_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JEQ, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JEQ, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 1234);
 }
 
 static int bpf_fill_staggered_jne_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JNE, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JNE, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 4321, 1234);
 }
 
 static int bpf_fill_staggered_jset_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JSET, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JSET, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 0x86, 0x82);
 }
 
 static int bpf_fill_staggered_jgt_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JGT, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JGT, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 0x80000000, 1234);
 }
 
 static int bpf_fill_staggered_jge_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JGE, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JGE, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 1234);
 }
 
 static int bpf_fill_staggered_jlt_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JLT, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JLT, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 0x80000000);
 }
 
 static int bpf_fill_staggered_jle_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JLE, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JLE, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, 1234, 1234);
 }
 
 static int bpf_fill_staggered_jsgt_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JSGT, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JSGT, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -1, -2);
 }
 
 static int bpf_fill_staggered_jsge_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JSGE, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JSGE, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -2, -2);
 }
 
 static int bpf_fill_staggered_jslt_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JSLT, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JSLT, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -2, -1);
 }
 
 static int bpf_fill_staggered_jsle_reg(struct bpf_test *self)
 {
-	struct bpf_insn jmp = BPF_JMP_REG(BPF_JSLE, R1, R2, 0);
+	struct bpf_insn jmp = BPF_JMP64_REG(BPF_JSLE, R1, R2, 0);
 
 	return __bpf_fill_staggered_jumps(self, &jmp, -1, -1);
 }
@@ -3725,7 +3725,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_MOV, R1, -1),
 			BPF_ALU64_IMM(BPF_MOV, R2, 3),
 			BPF_ALU64_REG(BPF_MUL, R1, R2),
-			BPF_JMP_IMM(BPF_JEQ, R1, 0xfffffffd, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 0xfffffffd, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -3742,7 +3742,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R2, 3),
 			BPF_ALU64_REG(BPF_MUL, R1, R2),
 			BPF_ALU64_IMM(BPF_RSH, R1, 8),
-			BPF_JMP_IMM(BPF_JEQ, R1, 0x2ffffff, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 0x2ffffff, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -3759,7 +3759,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R2, 3),
 			BPF_ALU32_REG(BPF_MUL, R1, R2),
 			BPF_ALU64_IMM(BPF_RSH, R1, 8),
-			BPF_JMP_IMM(BPF_JEQ, R1, 0xffffff, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 0xffffff, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -3815,7 +3815,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R0, R7),
 			BPF_ALU64_REG(BPF_ADD, R0, R8),
 			BPF_ALU64_REG(BPF_ADD, R0, R9), /* R0 == 155 */
-			BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 155, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R1, R0),
 			BPF_ALU64_REG(BPF_ADD, R1, R1),
@@ -3827,7 +3827,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R1, R7),
 			BPF_ALU64_REG(BPF_ADD, R1, R8),
 			BPF_ALU64_REG(BPF_ADD, R1, R9), /* R1 == 456 */
-			BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 456, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R2, R0),
 			BPF_ALU64_REG(BPF_ADD, R2, R1),
@@ -3839,7 +3839,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R2, R7),
 			BPF_ALU64_REG(BPF_ADD, R2, R8),
 			BPF_ALU64_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
-			BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R2, 1358, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R3, R0),
 			BPF_ALU64_REG(BPF_ADD, R3, R1),
@@ -3851,7 +3851,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R3, R7),
 			BPF_ALU64_REG(BPF_ADD, R3, R8),
 			BPF_ALU64_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
-			BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R3, 4063, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R4, R0),
 			BPF_ALU64_REG(BPF_ADD, R4, R1),
@@ -3863,7 +3863,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R4, R7),
 			BPF_ALU64_REG(BPF_ADD, R4, R8),
 			BPF_ALU64_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
-			BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R4, 12177, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R5, R0),
 			BPF_ALU64_REG(BPF_ADD, R5, R1),
@@ -3875,7 +3875,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R5, R7),
 			BPF_ALU64_REG(BPF_ADD, R5, R8),
 			BPF_ALU64_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
-			BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R5, 36518, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R6, R0),
 			BPF_ALU64_REG(BPF_ADD, R6, R1),
@@ -3887,7 +3887,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R6, R7),
 			BPF_ALU64_REG(BPF_ADD, R6, R8),
 			BPF_ALU64_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
-			BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R6, 109540, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R7, R0),
 			BPF_ALU64_REG(BPF_ADD, R7, R1),
@@ -3899,7 +3899,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R7, R7),
 			BPF_ALU64_REG(BPF_ADD, R7, R8),
 			BPF_ALU64_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
-			BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R7, 328605, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R8, R0),
 			BPF_ALU64_REG(BPF_ADD, R8, R1),
@@ -3911,7 +3911,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, R8, R7),
 			BPF_ALU64_REG(BPF_ADD, R8, R8),
 			BPF_ALU64_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
-			BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R8, 985799, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_ADD, R9, R0),
 			BPF_ALU64_REG(BPF_ADD, R9, R1),
@@ -3961,7 +3961,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R0, R7),
 			BPF_ALU32_REG(BPF_ADD, R0, R8),
 			BPF_ALU32_REG(BPF_ADD, R0, R9), /* R0 == 155 */
-			BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 155, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R1, R0),
 			BPF_ALU32_REG(BPF_ADD, R1, R1),
@@ -3973,7 +3973,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R1, R7),
 			BPF_ALU32_REG(BPF_ADD, R1, R8),
 			BPF_ALU32_REG(BPF_ADD, R1, R9), /* R1 == 456 */
-			BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 456, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R2, R0),
 			BPF_ALU32_REG(BPF_ADD, R2, R1),
@@ -3985,7 +3985,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R2, R7),
 			BPF_ALU32_REG(BPF_ADD, R2, R8),
 			BPF_ALU32_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
-			BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R2, 1358, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R3, R0),
 			BPF_ALU32_REG(BPF_ADD, R3, R1),
@@ -3997,7 +3997,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R3, R7),
 			BPF_ALU32_REG(BPF_ADD, R3, R8),
 			BPF_ALU32_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
-			BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R3, 4063, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R4, R0),
 			BPF_ALU32_REG(BPF_ADD, R4, R1),
@@ -4009,7 +4009,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R4, R7),
 			BPF_ALU32_REG(BPF_ADD, R4, R8),
 			BPF_ALU32_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
-			BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R4, 12177, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R5, R0),
 			BPF_ALU32_REG(BPF_ADD, R5, R1),
@@ -4021,7 +4021,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R5, R7),
 			BPF_ALU32_REG(BPF_ADD, R5, R8),
 			BPF_ALU32_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
-			BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R5, 36518, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R6, R0),
 			BPF_ALU32_REG(BPF_ADD, R6, R1),
@@ -4033,7 +4033,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R6, R7),
 			BPF_ALU32_REG(BPF_ADD, R6, R8),
 			BPF_ALU32_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
-			BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R6, 109540, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R7, R0),
 			BPF_ALU32_REG(BPF_ADD, R7, R1),
@@ -4045,7 +4045,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R7, R7),
 			BPF_ALU32_REG(BPF_ADD, R7, R8),
 			BPF_ALU32_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
-			BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R7, 328605, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R8, R0),
 			BPF_ALU32_REG(BPF_ADD, R8, R1),
@@ -4057,7 +4057,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_REG(BPF_ADD, R8, R7),
 			BPF_ALU32_REG(BPF_ADD, R8, R8),
 			BPF_ALU32_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
-			BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R8, 985799, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_REG(BPF_ADD, R9, R0),
 			BPF_ALU32_REG(BPF_ADD, R9, R1),
@@ -4100,7 +4100,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_SUB, R0, R8),
 			BPF_ALU64_REG(BPF_SUB, R0, R9),
 			BPF_ALU64_IMM(BPF_SUB, R0, 10),
-			BPF_JMP_IMM(BPF_JEQ, R0, -55, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, -55, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R1, R0),
 			BPF_ALU64_REG(BPF_SUB, R1, R2),
@@ -4214,58 +4214,58 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU64_REG(BPF_SUB, R0, R0),
 			BPF_ALU64_REG(BPF_XOR, R1, R1),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOV, R0, 10),
 			BPF_ALU64_IMM(BPF_MOV, R1, -1),
 			BPF_ALU64_REG(BPF_SUB, R1, R1),
 			BPF_ALU64_REG(BPF_XOR, R2, R2),
-			BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JEQ, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R2, R2),
 			BPF_ALU64_REG(BPF_XOR, R3, R3),
 			BPF_ALU64_IMM(BPF_MOV, R0, 10),
 			BPF_ALU64_IMM(BPF_MOV, R1, -1),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 1),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R3, R3),
 			BPF_ALU64_REG(BPF_XOR, R4, R4),
 			BPF_ALU64_IMM(BPF_MOV, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R5, -1),
-			BPF_JMP_REG(BPF_JEQ, R3, R4, 1),
+			BPF_JMP64_REG(BPF_JEQ, R3, R4, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R4, R4),
 			BPF_ALU64_REG(BPF_XOR, R5, R5),
 			BPF_ALU64_IMM(BPF_MOV, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R7, -1),
-			BPF_JMP_REG(BPF_JEQ, R5, R4, 1),
+			BPF_JMP64_REG(BPF_JEQ, R5, R4, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOV, R5, 1),
 			BPF_ALU64_REG(BPF_SUB, R5, R5),
 			BPF_ALU64_REG(BPF_XOR, R6, R6),
 			BPF_ALU64_IMM(BPF_MOV, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R8, -1),
-			BPF_JMP_REG(BPF_JEQ, R5, R6, 1),
+			BPF_JMP64_REG(BPF_JEQ, R5, R6, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R6, R6),
 			BPF_ALU64_REG(BPF_XOR, R7, R7),
-			BPF_JMP_REG(BPF_JEQ, R7, R6, 1),
+			BPF_JMP64_REG(BPF_JEQ, R7, R6, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R7, R7),
 			BPF_ALU64_REG(BPF_XOR, R8, R8),
-			BPF_JMP_REG(BPF_JEQ, R7, R8, 1),
+			BPF_JMP64_REG(BPF_JEQ, R7, R8, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R8, R8),
 			BPF_ALU64_REG(BPF_XOR, R9, R9),
-			BPF_JMP_REG(BPF_JEQ, R9, R8, 1),
+			BPF_JMP64_REG(BPF_JEQ, R9, R8, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R9, R9),
 			BPF_ALU64_REG(BPF_XOR, R0, R0),
-			BPF_JMP_REG(BPF_JEQ, R9, R0, 1),
+			BPF_JMP64_REG(BPF_JEQ, R9, R0, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_SUB, R1, R1),
 			BPF_ALU64_REG(BPF_XOR, R0, R0),
-			BPF_JMP_REG(BPF_JEQ, R9, R0, 2),
+			BPF_JMP64_REG(BPF_JEQ, R9, R0, 2),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
@@ -4299,7 +4299,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_MUL, R0, R8),
 			BPF_ALU64_REG(BPF_MUL, R0, R9),
 			BPF_ALU64_IMM(BPF_MUL, R0, 10),
-			BPF_JMP_IMM(BPF_JEQ, R0, 439084800, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 439084800, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_MUL, R1, R0),
 			BPF_ALU64_REG(BPF_MUL, R1, R2),
@@ -4313,11 +4313,11 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_MUL, R1, 10),
 			BPF_ALU64_REG(BPF_MOV, R2, R1),
 			BPF_ALU64_IMM(BPF_RSH, R2, 32),
-			BPF_JMP_IMM(BPF_JEQ, R2, 0x5a924, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R2, 0x5a924, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_LSH, R1, 32),
 			BPF_ALU64_IMM(BPF_ARSH, R1, 32),
-			BPF_JMP_IMM(BPF_JEQ, R1, 0xebb90000, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 0xebb90000, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_REG(BPF_MUL, R2, R0),
 			BPF_ALU64_REG(BPF_MUL, R2, R1),
@@ -4465,10 +4465,10 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_MOV, R2, 2),
 			BPF_ALU64_IMM(BPF_XOR, R2, 3),
 			BPF_ALU64_REG(BPF_DIV, R0, R2),
-			BPF_JMP_IMM(BPF_JEQ, R0, 10, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 10, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOD, R0, 3),
-			BPF_JMP_IMM(BPF_JEQ, R0, 1, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_MOV, R0, -1),
 			BPF_EXIT_INSN(),
@@ -4483,30 +4483,30 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_IMM(R0, -1234),
 			BPF_MOV64_IMM(R1, 1),
 			BPF_ALU32_REG(BPF_RSH, R0, R1),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0x7ffffd97, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0x7ffffd97, 1),
 			BPF_EXIT_INSN(),
 			BPF_MOV64_IMM(R2, 1),
 			BPF_ALU64_REG(BPF_LSH, R0, R2),
 			BPF_MOV32_IMM(R4, -1234),
-			BPF_JMP_REG(BPF_JEQ, R0, R4, 1),
+			BPF_JMP64_REG(BPF_JEQ, R0, R4, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU64_IMM(BPF_AND, R4, 63),
 			BPF_ALU64_REG(BPF_LSH, R0, R4), /* R0 <= 46 */
 			BPF_MOV64_IMM(R3, 47),
 			BPF_ALU64_REG(BPF_ARSH, R0, R3),
-			BPF_JMP_IMM(BPF_JEQ, R0, -617, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, -617, 1),
 			BPF_EXIT_INSN(),
 			BPF_MOV64_IMM(R2, 1),
 			BPF_ALU64_REG(BPF_LSH, R4, R2), /* R4 = 46 << 1 */
-			BPF_JMP_IMM(BPF_JEQ, R4, 92, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R4, 92, 1),
 			BPF_EXIT_INSN(),
 			BPF_MOV64_IMM(R4, 4),
 			BPF_ALU64_REG(BPF_LSH, R4, R4), /* R4 = 4 << 4 */
-			BPF_JMP_IMM(BPF_JEQ, R4, 64, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R4, 64, 1),
 			BPF_EXIT_INSN(),
 			BPF_MOV64_IMM(R4, 5),
 			BPF_ALU32_REG(BPF_LSH, R4, R4), /* R4 = 5 << 5 */
-			BPF_JMP_IMM(BPF_JEQ, R4, 160, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R4, 160, 1),
 			BPF_EXIT_INSN(),
 			BPF_MOV64_IMM(R0, -1),
 			BPF_EXIT_INSN(),
@@ -4881,9 +4881,9 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_LSH, R3, 32),
 			BPF_ALU64_IMM(BPF_RSH, R3, 32),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R2, 0x5678, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R2, 0x5678, 1),
 			BPF_EXIT_INSN(),
-			BPF_JMP_IMM(BPF_JEQ, R3, 0x1234, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R3, 0x1234, 1),
 			BPF_EXIT_INSN(),
 			BPF_LD_IMM64(R0, 0x1ffffffffLL),
 			BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
@@ -4965,7 +4965,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x00000000ffffffffLL),
 			BPF_ALU32_IMM(BPF_MOV, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5043,7 +5043,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0),
 			BPF_ALU64_IMM(BPF_MOV, R2, 0x0),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5059,7 +5059,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_MOV, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5142,7 +5142,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 2),
 			BPF_LD_IMM64(R1, 4294967294U),
 			BPF_ALU32_REG(BPF_ADD, R0, R1),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 2),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
@@ -5183,7 +5183,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R1, 4294967294U),
 			BPF_LD_IMM64(R2, 4294967296ULL),
 			BPF_ALU64_REG(BPF_ADD, R0, R1),
-			BPF_JMP_REG(BPF_JEQ, R0, R2, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R2, 2),
 			BPF_MOV32_IMM(R0, 0),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5232,7 +5232,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 4294967294U),
 			BPF_ALU32_IMM(BPF_ADD, R0, 2),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 2),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
@@ -5248,7 +5248,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0x00000000ffffffff),
 			BPF_ALU32_IMM(BPF_ADD, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5264,7 +5264,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0xffff),
 			BPF_ALU32_IMM(BPF_ADD, R2, 0xffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5280,7 +5280,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0x7fffffff),
 			BPF_ALU32_IMM(BPF_ADD, R2, 0x7fffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5296,7 +5296,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0x80000000),
 			BPF_ALU32_IMM(BPF_ADD, R2, 0x80000000),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5312,7 +5312,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0x80008000),
 			BPF_ALU32_IMM(BPF_ADD, R2, 0x80008000),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5361,7 +5361,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 4294967294U),
 			BPF_LD_IMM64(R1, 4294967296ULL),
 			BPF_ALU64_IMM(BPF_ADD, R0, 2),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
@@ -5388,7 +5388,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x1),
 			BPF_LD_IMM64(R3, 0x1),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0x0),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5404,7 +5404,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5420,7 +5420,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0xffff),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0xffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5436,7 +5436,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0x7fffffff),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0x7fffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5452,7 +5452,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0xffffffff80000000LL),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0x80000000),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5468,7 +5468,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0),
 			BPF_LD_IMM64(R3, 0xffffffff80008000LL),
 			BPF_ALU64_IMM(BPF_ADD, R2, 0x80008000),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5731,7 +5731,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x1),
 			BPF_LD_IMM64(R3, 0x00000000ffffffff),
 			BPF_ALU32_IMM(BPF_MUL, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5791,7 +5791,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x1),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_MUL, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5880,7 +5880,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R4, 0xffffffffffffffffLL),
 			BPF_LD_IMM64(R3, 0x0000000000000001LL),
 			BPF_ALU64_REG(BPF_DIV, R2, R4),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5930,7 +5930,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
 			BPF_LD_IMM64(R3, 0x1UL),
 			BPF_ALU32_IMM(BPF_DIV, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -5979,7 +5979,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
 			BPF_LD_IMM64(R3, 0x0000000000000001LL),
 			BPF_ALU64_IMM(BPF_DIV, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6205,7 +6205,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x0000000080a0c0e0LL),
 			BPF_ALU32_IMM(BPF_AND, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6243,7 +6243,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000000000000000LL),
 			BPF_ALU64_IMM(BPF_AND, R2, 0x0),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6259,7 +6259,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
 			BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6275,7 +6275,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6291,7 +6291,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x00000000090b0d0fLL),
 			BPF_ALU64_IMM(BPF_AND, R0, 0x0f0f0f0f),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6307,7 +6307,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x0123456780a0c0e0LL),
 			BPF_ALU64_IMM(BPF_AND, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6417,7 +6417,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x00000000f9fbfdffLL),
 			BPF_ALU32_IMM(BPF_OR, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6455,7 +6455,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
 			BPF_ALU64_IMM(BPF_OR, R2, 0x0),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6471,7 +6471,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6487,7 +6487,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000000000000000LL),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6503,7 +6503,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x012345678fafcfefLL),
 			BPF_ALU64_IMM(BPF_OR, R0, 0x0f0f0f0f),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6519,7 +6519,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0xfffffffff9fbfdffLL),
 			BPF_ALU64_IMM(BPF_OR, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6629,7 +6629,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x00000000795b3d1fLL),
 			BPF_ALU32_IMM(BPF_XOR, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6667,7 +6667,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
 			BPF_ALU64_IMM(BPF_XOR, R2, 0x0),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6683,7 +6683,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0xffff00000000ffffLL),
 			BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6699,7 +6699,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x0000000000000000LL),
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6715,7 +6715,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0x0123456786a4c2e0LL),
 			BPF_ALU64_IMM(BPF_XOR, R0, 0x0f0f0f0f),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -6731,7 +6731,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
 			BPF_LD_IMM64(R1, 0xfedcba98795b3d1fLL),
 			BPF_ALU64_IMM(BPF_XOR, R0, 0xf0f0f0f0),
-			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_JMP64_REG(BPF_JEQ, R0, R1, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -7849,7 +7849,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_B, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7869,7 +7869,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_B, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7886,7 +7886,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, R1, 512),
 			BPF_STX_MEM(BPF_B, R1, R2, -256),
 			BPF_LDX_MEM(BPF_B, R0, R1, -256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7902,7 +7902,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000000000088ULL),
 			BPF_STX_MEM(BPF_B, R1, R2, 256),
 			BPF_LDX_MEM(BPF_B, R0, R1, 256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7918,7 +7918,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000000000088ULL),
 			BPF_STX_MEM(BPF_B, R1, R2, 4096),
 			BPF_LDX_MEM(BPF_B, R0, R1, 4096),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7938,7 +7938,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_H, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7958,7 +7958,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_H, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7975,7 +7975,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, R1, 512),
 			BPF_STX_MEM(BPF_H, R1, R2, -256),
 			BPF_LDX_MEM(BPF_H, R0, R1, -256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -7991,7 +7991,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
 			BPF_STX_MEM(BPF_H, R1, R2, 256),
 			BPF_LDX_MEM(BPF_H, R0, R1, 256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8007,7 +8007,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
 			BPF_STX_MEM(BPF_H, R1, R2, 8192),
 			BPF_LDX_MEM(BPF_H, R0, R1, 8192),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8023,7 +8023,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
 			BPF_STX_MEM(BPF_H, R1, R2, 13),
 			BPF_LDX_MEM(BPF_H, R0, R1, 13),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8043,7 +8043,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_W, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8063,7 +8063,7 @@ static struct bpf_test tests[] = {
 #else
 			BPF_LDX_MEM(BPF_W, R0, R10, -8),
 #endif
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8080,7 +8080,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, R1, 512),
 			BPF_STX_MEM(BPF_W, R1, R2, -256),
 			BPF_LDX_MEM(BPF_W, R0, R1, -256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8096,7 +8096,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
 			BPF_STX_MEM(BPF_W, R1, R2, 256),
 			BPF_LDX_MEM(BPF_W, R0, R1, 256),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8112,7 +8112,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
 			BPF_STX_MEM(BPF_W, R1, R2, 16384),
 			BPF_LDX_MEM(BPF_W, R0, R1, 16384),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8128,7 +8128,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
 			BPF_STX_MEM(BPF_W, R1, R2, 13),
 			BPF_LDX_MEM(BPF_W, R0, R1, 13),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8143,7 +8143,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R1, 0x0102030405060708ULL),
 			BPF_STX_MEM(BPF_DW, R10, R1, -8),
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8158,7 +8158,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R1, 0x8182838485868788ULL),
 			BPF_STX_MEM(BPF_DW, R10, R1, -8),
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8174,7 +8174,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, R1, 512),
 			BPF_STX_MEM(BPF_DW, R1, R2, -256),
 			BPF_LDX_MEM(BPF_DW, R0, R1, -256),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8189,7 +8189,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
 			BPF_STX_MEM(BPF_DW, R1, R2, 256),
 			BPF_LDX_MEM(BPF_DW, R0, R1, 256),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8204,7 +8204,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
 			BPF_STX_MEM(BPF_DW, R1, R2, 32760),
 			BPF_LDX_MEM(BPF_DW, R0, R1, 32760),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8219,7 +8219,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
 			BPF_STX_MEM(BPF_DW, R1, R2, 13),
 			BPF_LDX_MEM(BPF_DW, R0, R1, 13),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8242,7 +8242,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_B, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8264,7 +8264,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_B, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8286,7 +8286,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_H, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8308,7 +8308,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_H, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8330,7 +8330,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_W, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8352,7 +8352,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_W, R10, R2, -8),
 #endif
 			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R3, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -8502,7 +8502,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
 			BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
 			BPF_LDX_MEM(BPF_DW, R2, R10, -40),
-			BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
+			BPF_JMP64_REG(BPF_JEQ, R2, R3, 2),
 			BPF_MOV32_IMM(R0, 2),
 			BPF_EXIT_INSN(),
 			BPF_MOV32_IMM(R0, 1),
@@ -8855,7 +8855,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_MOV, R0, R1),
 			BPF_STX_MEM(BPF_DW, R10, R1, -40),
 			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 1),
 			BPF_ALU64_REG(BPF_SUB, R0, R1),
 			BPF_EXIT_INSN(),
 		},
@@ -8873,7 +8873,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_DW, R10, R0, -40),
 			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
 			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_REG(BPF_SUB, R0, R2),
 			BPF_EXIT_INSN(),
 		},
@@ -8891,7 +8891,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, R0, 1),
 			BPF_STX_MEM(BPF_DW, R10, R1, -40),
 			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 1),
 			BPF_ALU64_REG(BPF_SUB, R0, R1),
 			BPF_EXIT_INSN(),
 		},
@@ -8910,7 +8910,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_DW, R10, R1, -40),
 			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
 			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 1),
 			BPF_ALU64_REG(BPF_SUB, R0, R1),
 			BPF_EXIT_INSN(),
 		},
@@ -8928,7 +8928,7 @@ static struct bpf_test tests[] = {
 			BPF_STX_MEM(BPF_DW, R10, R1, -40),
 			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
 			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_REG(BPF_SUB, R0, R2),
 			BPF_EXIT_INSN(),
 		},
@@ -9465,7 +9465,7 @@ static struct bpf_test tests[] = {
 		"JMP_JA: Unconditional jump: if (true) return 1",
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+			BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9480,7 +9480,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
-			BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSLT, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9494,7 +9494,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSLT, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
@@ -9509,7 +9509,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
+			BPF_JMP64_IMM(BPF_JSGT, R1, -2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9523,7 +9523,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSGT, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
@@ -9538,7 +9538,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
-			BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSLE, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9552,7 +9552,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSLE, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9566,13 +9566,13 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 6),
 			BPF_ALU64_IMM(BPF_SUB, R1, 1),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 4),
 			BPF_ALU64_IMM(BPF_SUB, R1, 1),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 2),
 			BPF_ALU64_IMM(BPF_SUB, R1, 1),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 1),
 			BPF_EXIT_INSN(),		/* bad exit */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
 			BPF_EXIT_INSN(),
@@ -9586,11 +9586,11 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 4),
 			BPF_ALU64_IMM(BPF_SUB, R1, 2),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 2),
 			BPF_ALU64_IMM(BPF_SUB, R1, 2),
-			BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JSLE, R1, 0, 1),
 			BPF_EXIT_INSN(),		/* bad exit */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
 			BPF_EXIT_INSN(),
@@ -9605,7 +9605,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
+			BPF_JMP64_IMM(BPF_JSGE, R1, -2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9619,7 +9619,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JSGE, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9633,13 +9633,13 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -3),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 6),
 			BPF_ALU64_IMM(BPF_ADD, R1, 1),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 4),
 			BPF_ALU64_IMM(BPF_ADD, R1, 1),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 2),
 			BPF_ALU64_IMM(BPF_ADD, R1, 1),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 1),
 			BPF_EXIT_INSN(),		/* bad exit */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
 			BPF_EXIT_INSN(),
@@ -9653,11 +9653,11 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -3),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 4),
 			BPF_ALU64_IMM(BPF_ADD, R1, 2),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 2),
 			BPF_ALU64_IMM(BPF_ADD, R1, 2),
-			BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JSGE, R1, 0, 1),
 			BPF_EXIT_INSN(),		/* bad exit */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
 			BPF_EXIT_INSN(),
@@ -9672,7 +9672,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
+			BPF_JMP64_IMM(BPF_JGT, R1, 2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9686,7 +9686,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
-			BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
+			BPF_JMP64_IMM(BPF_JGT, R1, 1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9701,7 +9701,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 2),
-			BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
+			BPF_JMP64_IMM(BPF_JLT, R1, 3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9715,7 +9715,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 1),
-			BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
+			BPF_JMP64_IMM(BPF_JLT, R1, -1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9730,7 +9730,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
+			BPF_JMP64_IMM(BPF_JGE, R1, 2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9745,7 +9745,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 2),
-			BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
+			BPF_JMP64_IMM(BPF_JLE, R1, 3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9758,12 +9758,12 @@ static struct bpf_test tests[] = {
 	{
 		"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
 		.u.insns_int = {
-			BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
+			BPF_JMP64_IMM(BPF_JA, 0, 0, 2), /* goto start */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
 			BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
-			BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
+			BPF_JMP64_IMM(BPF_JGT, R1, 2, -6), /* goto out */
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
@@ -9775,7 +9775,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
+			BPF_JMP64_IMM(BPF_JGE, R1, 3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9788,12 +9788,12 @@ static struct bpf_test tests[] = {
 	{
 		"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
 		.u.insns_int = {
-			BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
+			BPF_JMP64_IMM(BPF_JA, 0, 0, 2), /* goto start */
 			BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
 			BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
-			BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
+			BPF_JMP64_IMM(BPF_JLT, R1, 3, -6), /* goto out */
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
@@ -9805,7 +9805,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
+			BPF_JMP64_IMM(BPF_JLE, R1, 3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9820,7 +9820,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
+			BPF_JMP64_IMM(BPF_JNE, R1, 2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9835,7 +9835,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R1, 3, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9850,7 +9850,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
+			BPF_JMP64_IMM(BPF_JSET, R1, 2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9864,7 +9864,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
+			BPF_JMP64_IMM(BPF_JSET, R1, 0xffffffff, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9880,7 +9880,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -2),
-			BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSGT, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9895,7 +9895,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -1),
-			BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSGT, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
@@ -9911,7 +9911,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -2),
-			BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
+			BPF_JMP64_REG(BPF_JSLT, R2, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9926,7 +9926,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -1),
-			BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSLT, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
@@ -9942,7 +9942,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -2),
-			BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSGE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9957,7 +9957,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -1),
-			BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSGE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9973,7 +9973,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -2),
-			BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
+			BPF_JMP64_REG(BPF_JSLE, R2, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -9988,7 +9988,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, -1),
-			BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSLE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10004,7 +10004,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JGT, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JGT, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10019,7 +10019,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, 1),
-			BPF_JMP_REG(BPF_JGT, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JGT, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10035,7 +10035,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JLT, R2, R1, 1),
+			BPF_JMP64_REG(BPF_JLT, R2, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10050,7 +10050,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, -1),
 			BPF_LD_IMM64(R2, 1),
-			BPF_JMP_REG(BPF_JLT, R2, R1, 1),
+			BPF_JMP64_REG(BPF_JLT, R2, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10066,7 +10066,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JGE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JGE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10081,7 +10081,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 3),
-			BPF_JMP_REG(BPF_JGE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JGE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10097,7 +10097,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JLE, R2, R1, 1),
+			BPF_JMP64_REG(BPF_JLE, R2, R1, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10112,7 +10112,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 3),
-			BPF_JMP_REG(BPF_JLE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JLE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10128,7 +10128,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JGE, R1, R2, 2),
+			BPF_JMP64_REG(BPF_JGE, R1, R2, 2),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
 			BPF_EXIT_INSN(),
@@ -10143,7 +10143,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JGE, R1, R2, 0),
+			BPF_JMP64_REG(BPF_JGE, R1, R2, 0),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_EXIT_INSN(),
 		},
@@ -10157,7 +10157,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JGE, R1, R2, 4),
+			BPF_JMP64_REG(BPF_JGE, R1, R2, 4),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
 			BPF_EXIT_INSN(),
@@ -10172,7 +10172,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JLE, R2, R1, 2),
+			BPF_JMP64_REG(BPF_JLE, R2, R1, 2),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
 			BPF_EXIT_INSN(),
@@ -10187,7 +10187,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JLE, R2, R1, 0),
+			BPF_JMP64_REG(BPF_JLE, R2, R1, 0),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_EXIT_INSN(),
 		},
@@ -10201,7 +10201,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JLE, R2, R1, 4),
+			BPF_JMP64_REG(BPF_JLE, R2, R1, 4),
 			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
 			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
 			BPF_EXIT_INSN(),
@@ -10217,7 +10217,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10233,7 +10233,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 3),
-			BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JEQ, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10249,7 +10249,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSET, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -10264,7 +10264,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
+			BPF_JMP64_REG(BPF_JSET, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -11391,7 +11391,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(R2, R1),
 			BPF_ALU64_REG(BPF_AND, R2, R3),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
+			BPF_JMP64_IMM(BPF_JNE, R2, -17104896, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11407,7 +11407,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(R2, R1),
 			BPF_ALU64_REG(BPF_AND, R2, R3),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
+			BPF_JMP64_IMM(BPF_JNE, R2, 0xfefb0000, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11424,7 +11424,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(R2, R1),
 			BPF_ALU64_REG(BPF_AND, R2, R3),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JNE, R2, R4, 1),
+			BPF_JMP64_REG(BPF_JNE, R2, R4, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11437,7 +11437,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, -17104896),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
+			BPF_JMP64_IMM(BPF_JNE, R1, -17104896, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11450,7 +11450,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, 0xfefb0000),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
+			BPF_JMP64_IMM(BPF_JNE, R1, 0xfefb0000, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11463,7 +11463,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, 0x7efb0000),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
+			BPF_JMP64_IMM(BPF_JNE, R1, 0x7efb0000, 1),
 			BPF_ALU32_IMM(BPF_MOV, R0, 2),
 			BPF_EXIT_INSN(),
 		},
@@ -11572,16 +11572,16 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_MOV, R9, R9),		\
 			BPF_##alu(BPF_ ##op, dst, src),		\
 			BPF_ALU32_IMM(BPF_MOV, dst, dst),	\
-			BPF_JMP_IMM(BPF_JNE, R0, R0, 10),	\
-			BPF_JMP_IMM(BPF_JNE, R1, R1, 9),	\
-			BPF_JMP_IMM(BPF_JNE, R2, R2, 8),	\
-			BPF_JMP_IMM(BPF_JNE, R3, R3, 7),	\
-			BPF_JMP_IMM(BPF_JNE, R4, R4, 6),	\
-			BPF_JMP_IMM(BPF_JNE, R5, R5, 5),	\
-			BPF_JMP_IMM(BPF_JNE, R6, R6, 4),	\
-			BPF_JMP_IMM(BPF_JNE, R7, R7, 3),	\
-			BPF_JMP_IMM(BPF_JNE, R8, R8, 2),	\
-			BPF_JMP_IMM(BPF_JNE, R9, R9, 1),	\
+			BPF_JMP64_IMM(BPF_JNE, R0, R0, 10),	\
+			BPF_JMP64_IMM(BPF_JNE, R1, R1, 9),	\
+			BPF_JMP64_IMM(BPF_JNE, R2, R2, 8),	\
+			BPF_JMP64_IMM(BPF_JNE, R3, R3, 7),	\
+			BPF_JMP64_IMM(BPF_JNE, R4, R4, 6),	\
+			BPF_JMP64_IMM(BPF_JNE, R5, R5, 5),	\
+			BPF_JMP64_IMM(BPF_JNE, R6, R6, 4),	\
+			BPF_JMP64_IMM(BPF_JNE, R7, R7, 3),	\
+			BPF_JMP64_IMM(BPF_JNE, R8, R8, 2),	\
+			BPF_JMP64_IMM(BPF_JNE, R9, R9, 1),	\
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),		\
 			BPF_EXIT_INSN(),			\
 		},						\
@@ -11700,16 +11700,16 @@ static struct bpf_test tests[] = {
 				   (op) == BPF_CMPXCHG ? 0 :	\
 				   (op) & BPF_FETCH ? 1 : 0),	\
 			BPF_ATOMIC_OP(width, op, R10, R1, -8),	\
-			BPF_JMP_IMM(BPF_JNE, R0, 0, 10),	\
-			BPF_JMP_IMM(BPF_JNE, R1, 1, 9),		\
-			BPF_JMP_IMM(BPF_JNE, R2, 2, 8),		\
-			BPF_JMP_IMM(BPF_JNE, R3, 3, 7),		\
-			BPF_JMP_IMM(BPF_JNE, R4, 4, 6),		\
-			BPF_JMP_IMM(BPF_JNE, R5, 5, 5),		\
-			BPF_JMP_IMM(BPF_JNE, R6, 6, 4),		\
-			BPF_JMP_IMM(BPF_JNE, R7, 7, 3),		\
-			BPF_JMP_IMM(BPF_JNE, R8, 8, 2),		\
-			BPF_JMP_IMM(BPF_JNE, R9, 9, 1),		\
+			BPF_JMP64_IMM(BPF_JNE, R0, 0, 10),	\
+			BPF_JMP64_IMM(BPF_JNE, R1, 1, 9),	\
+			BPF_JMP64_IMM(BPF_JNE, R2, 2, 8),	\
+			BPF_JMP64_IMM(BPF_JNE, R3, 3, 7),	\
+			BPF_JMP64_IMM(BPF_JNE, R4, 4, 6),	\
+			BPF_JMP64_IMM(BPF_JNE, R5, 5, 5),	\
+			BPF_JMP64_IMM(BPF_JNE, R6, 6, 4),	\
+			BPF_JMP64_IMM(BPF_JNE, R7, 7, 3),	\
+			BPF_JMP64_IMM(BPF_JNE, R8, 8, 2),	\
+			BPF_JMP64_IMM(BPF_JNE, R9, 9, 1),	\
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),		\
 			BPF_EXIT_INSN(),			\
 		},						\
@@ -11824,7 +11824,7 @@ static struct bpf_test tests[] = {
 			BPF_LD_IMM64(R0, 0x0123456789acbdefULL),\
 			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 			BPF_JMP32_IMM(BPF_##op, R0, 1234, 1),	\
-			BPF_JMP_A(0), /* Nop */			\
+			BPF_JMP64_A(0), /* Nop */		\
 			BPF_ALU64_REG(BPF_SUB, R0, R1),		\
 			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 			BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
@@ -11858,7 +11858,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_REG(BPF_MOV, R2, R0),		\
 			BPF_ALU64_REG(BPF_MOV, R3, R1),		\
 			BPF_JMP32_IMM(BPF_##op, R0, R1, 1),	\
-			BPF_JMP_A(0), /* Nop */			\
+			BPF_JMP64_A(0), /* Nop */		\
 			BPF_ALU64_REG(BPF_SUB, R0, R2),		\
 			BPF_ALU64_REG(BPF_SUB, R1, R3),		\
 			BPF_ALU64_REG(BPF_OR, R0, R1),		\
@@ -13584,7 +13584,7 @@ static struct bpf_test tests[] = {
 		"JMP_JSET_K: imm = 0 -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JSET, R1, 0, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13596,7 +13596,7 @@ static struct bpf_test tests[] = {
 		"JMP_JLT_K: imm = 0 -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JLT, R1, 0, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13608,7 +13608,7 @@ static struct bpf_test tests[] = {
 		"JMP_JGE_K: imm = 0 -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
+			BPF_JMP64_IMM(BPF_JGE, R1, 0, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13620,7 +13620,7 @@ static struct bpf_test tests[] = {
 		"JMP_JGT_K: imm = 0xffffffff -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
+			BPF_JMP64_IMM(BPF_JGT, R1, U32_MAX, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13632,7 +13632,7 @@ static struct bpf_test tests[] = {
 		"JMP_JLE_K: imm = 0xffffffff -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
+			BPF_JMP64_IMM(BPF_JLE, R1, U32_MAX, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13692,7 +13692,7 @@ static struct bpf_test tests[] = {
 		"JMP_JEQ_X: dst = src -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JEQ, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13704,7 +13704,7 @@ static struct bpf_test tests[] = {
 		"JMP_JGE_X: dst = src -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JGE, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JGE, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13716,7 +13716,7 @@ static struct bpf_test tests[] = {
 		"JMP_JLE_X: dst = src -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JLE, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JLE, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13728,7 +13728,7 @@ static struct bpf_test tests[] = {
 		"JMP_JSGE_X: dst = src -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JSGE, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13740,7 +13740,7 @@ static struct bpf_test tests[] = {
 		"JMP_JSLE_X: dst = src -> always taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JSLE, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13752,7 +13752,7 @@ static struct bpf_test tests[] = {
 		"JMP_JNE_X: dst = src -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JNE, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JNE, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13764,7 +13764,7 @@ static struct bpf_test tests[] = {
 		"JMP_JGT_X: dst = src -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JGT, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JGT, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13776,7 +13776,7 @@ static struct bpf_test tests[] = {
 		"JMP_JLT_X: dst = src -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JLT, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JLT, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13788,7 +13788,7 @@ static struct bpf_test tests[] = {
 		"JMP_JSGT_X: dst = src -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JSGT, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13800,7 +13800,7 @@ static struct bpf_test tests[] = {
 		"JMP_JSLT_X: dst = src -> never taken",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 1),
-			BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
+			BPF_JMP64_REG(BPF_JSLT, R1, R1, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -13813,7 +13813,7 @@ static struct bpf_test tests[] = {
 		"Short relative jump: offset=0",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 0),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, -1),
 		},
@@ -13825,7 +13825,7 @@ static struct bpf_test tests[] = {
 		"Short relative jump: offset=1",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, -1),
@@ -13838,7 +13838,7 @@ static struct bpf_test tests[] = {
 		"Short relative jump: offset=2",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 2),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_EXIT_INSN(),
@@ -13852,7 +13852,7 @@ static struct bpf_test tests[] = {
 		"Short relative jump: offset=3",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 3),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
@@ -13867,7 +13867,7 @@ static struct bpf_test tests[] = {
 		"Short relative jump: offset=4",
 		.u.insns_int = {
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
-			BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
+			BPF_JMP64_IMM(BPF_JEQ, R0, 0, 4),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
 			BPF_ALU32_IMM(BPF_ADD, R0, 1),
@@ -14876,7 +14876,7 @@ struct tail_call_test {
 	BPF_LD_IMM64(R2, TAIL_CALL_MARKER),	       \
 	BPF_RAW_INSN(BPF_ALU32 | BPF_MOV | BPF_K, R3, 0, \
 		     offset, TAIL_CALL_MARKER),	       \
-	BPF_JMP_IMM(BPF_TAIL_CALL, 0, 0, 0)
+	BPF_JMP64_IMM(BPF_TAIL_CALL, 0, 0, 0)
 
 /*
  * A test function to be called from a BPF program, clobbering a lot of
@@ -14958,9 +14958,9 @@ static struct tail_call_test tail_call_tests[] = {
 			BPF_STX_MEM(BPF_DW, R3, R1, -8),
 			BPF_STX_MEM(BPF_DW, R3, R2, -16),
 			BPF_LDX_MEM(BPF_DW, R0, BPF_REG_FP, -8),
-			BPF_JMP_REG(BPF_JNE, R0, R1, 3),
+			BPF_JMP64_REG(BPF_JNE, R0, R1, 3),
 			BPF_LDX_MEM(BPF_DW, R0, BPF_REG_FP, -16),
-			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_JMP64_REG(BPF_JNE, R0, R2, 1),
 			BPF_ALU64_IMM(BPF_MOV, R0, 0),
 			BPF_EXIT_INSN(),
 		},
@@ -15141,7 +15141,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 				}
 				*insn = BPF_EMIT_CALL(addr);
 				if ((long)__bpf_call_base + insn->imm != addr)
-					*insn = BPF_JMP_A(0); /* Skip: NOP */
+					*insn = BPF_JMP64_A(0); /* Skip: NOP */
 				break;
 			}
 		}
diff --git a/net/core/filter.c b/net/core/filter.c
index 1cd5897..e1576e0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -329,7 +329,7 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		BUILD_BUG_ON(sizeof_field(struct sk_buff, vlan_all) != 4);
 		*insn++ = BPF_LDX_MEM(BPF_W, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_all));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, dst_reg, 0, 1);
 		*insn++ = BPF_ALU32_IMM(BPF_MOV, dst_reg, 1);
 		break;
 	}
@@ -368,7 +368,7 @@ static bool convert_bpf_extensions(struct sock_filter *fp,
 				      BPF_REG_TMP, BPF_REG_CTX,
 				      offsetof(struct sk_buff, dev));
 		/* if (tmp != 0) goto pc + 1 */
-		*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_TMP, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JNE, BPF_REG_TMP, 0, 1);
 		*insn++ = BPF_EXIT_INSN();
 		if (fp->k == SKF_AD_OFF + SKF_AD_IFINDEX)
 			*insn = BPF_LDX_MEM(BPF_W, BPF_REG_A, BPF_REG_TMP,
@@ -488,7 +488,7 @@ static bool convert_bpf_ld_abs(struct sock_filter *fp, struct bpf_insn **insnp)
 		*insn++ = BPF_MOV64_REG(BPF_REG_TMP, BPF_REG_H);
 		if (offset)
 			*insn++ = BPF_ALU64_IMM(BPF_SUB, BPF_REG_TMP, offset);
-		*insn++ = BPF_JMP_IMM(BPF_JSLT, BPF_REG_TMP,
+		*insn++ = BPF_JMP64_IMM(BPF_JSLT, BPF_REG_TMP,
 				      size, 2 + endian + (!ldx_off_ok * 2));
 		if (ldx_off_ok) {
 			*insn++ = BPF_LDX_MEM(BPF_SIZE(fp->code), BPF_REG_A,
@@ -501,7 +501,7 @@ static bool convert_bpf_ld_abs(struct sock_filter *fp, struct bpf_insn **insnp)
 		}
 		if (endian)
 			*insn++ = BPF_ENDIAN(BPF_FROM_BE, BPF_REG_A, size * 8);
-		*insn++ = BPF_JMP_A(8);
+		*insn++ = BPF_JMP64_A(8);
 	}
 
 	*insn++ = BPF_MOV64_REG(BPF_REG_ARG1, BPF_REG_CTX);
@@ -529,7 +529,7 @@ static bool convert_bpf_ld_abs(struct sock_filter *fp, struct bpf_insn **insnp)
 		return false;
 	}
 
-	*insn++ = BPF_JMP_IMM(BPF_JSGE, BPF_REG_A, 0, 2);
+	*insn++ = BPF_JMP64_IMM(BPF_JSGE, BPF_REG_A, 0, 2);
 	*insn++ = BPF_ALU32_REG(BPF_XOR, BPF_REG_A, BPF_REG_A);
 	*insn   = BPF_EXIT_INSN();
 
@@ -672,7 +672,7 @@ static int bpf_convert_filter(struct sock_filter *prog, int len,
 				/* Error with exception code on div/mod by 0.
 				 * For cBPF programs, this was always return 0.
 				 */
-				*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_X, 0, 2);
+				*insn++ = BPF_JMP64_IMM(BPF_JNE, BPF_REG_X, 0, 2);
 				*insn++ = BPF_ALU32_REG(BPF_XOR, BPF_REG_A, BPF_REG_A);
 				*insn++ = BPF_EXIT_INSN();
 			}
@@ -8602,7 +8602,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	 */
 	*insn++ = BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, CLONED_OFFSET);
 	*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_6, CLONED_MASK);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 7);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 7);
 
 	/* ret = bpf_skb_pull_data(skb, 0); */
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
@@ -8613,7 +8613,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	 *      goto restore;
 	 * return TC_ACT_SHOT;
 	 */
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2);
+	*insn++ = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2);
 	*insn++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, drop_verdict);
 	*insn++ = BPF_EXIT_INSN();
 
@@ -8653,7 +8653,7 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 		break;
 	}
 
-	*insn++ = BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 2);
+	*insn++ = BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 2);
 	*insn++ = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
 	*insn++ = BPF_EXIT_INSN();
 
@@ -9164,7 +9164,7 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
 	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
 				SKB_MONO_DELIVERY_TIME_MASK, 2);
 	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
-	*insn++ = BPF_JMP_A(1);
+	*insn++ = BPF_JMP64_A(1);
 	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
 
 	return insn;
@@ -9216,7 +9216,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
-		*insn++ = BPF_JMP_A(1);
+		*insn++ = BPF_JMP64_A(1);
 	}
 #endif
 
@@ -9246,7 +9246,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 		/* Writing __sk_buff->tstamp as ingress, goto <clear> */
 		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
 		/* goto <store> */
-		*insn++ = BPF_JMP_A(2);
+		*insn++ = BPF_JMP64_A(2);
 		/* <clear>: mono_delivery_time */
 		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, PKT_VLAN_PRESENT_OFFSET);
@@ -9307,7 +9307,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, dev),
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct sk_buff, dev));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
 				      bpf_target_off(struct net_device, ifindex, 4,
 						     target_size));
@@ -9342,7 +9342,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, queue_mapping):
 		if (type == BPF_WRITE) {
-			*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
+			*insn++ = BPF_JMP64_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
 			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff,
 							     queue_mapping,
@@ -9359,7 +9359,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff,
 						     vlan_all, 4, target_size));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_ALU32_IMM(BPF_MOV, si->dst_reg, 1);
 		break;
 
@@ -9453,7 +9453,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff, napi_id, 4,
 						     target_size));
-		*insn++ = BPF_JMP_IMM(BPF_JGE, si->dst_reg, MIN_NAPI_ID, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JGE, si->dst_reg, MIN_NAPI_ID, 1);
 		*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);
 #else
 		*target_size = 4;
@@ -9784,7 +9784,7 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				       sizeof_field(struct sock,
 						    sk_rx_queue_mapping),
 				       target_size));
-		*insn++ = BPF_JMP_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
+		*insn++ = BPF_JMP64_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
 				      1);
 		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
 #else
@@ -10068,7 +10068,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      fullsock_reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 					       is_fullsock));		      \
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
 		if (si->dst_reg == si->src_reg)				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
@@ -10082,14 +10082,14 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->dst_reg,		      \
 				      offsetof(OBJ, OBJ_FIELD));	      \
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP64_A(1);			      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
 		}							      \
 	} while (0)
 
-#define SOCK_OPS_GET_SK()							      \
+#define SOCK_OPS_GET_SK()						      \
 	do {								      \
 		int fullsock_reg = si->dst_reg, reg = BPF_REG_9, jmp = 1;     \
 		if (si->dst_reg == reg || si->src_reg == reg)		      \
@@ -10109,7 +10109,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      fullsock_reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 					       is_fullsock));		      \
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
 		if (si->dst_reg == si->src_reg)				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
@@ -10119,7 +10119,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,		      \
 				      offsetof(struct bpf_sock_ops_kern, sk));\
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP64_A(1);			      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
@@ -10156,7 +10156,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      reg, si->dst_reg,			      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 					       is_fullsock));		      \
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);		      \
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, reg, 0, 2);		      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern, sk),\
 				      reg, si->dst_reg,			      \
@@ -10427,7 +10427,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sock_ops_kern,
 					       skb));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, data),
 				      si->dst_reg, si->dst_reg,
 				      offsetof(struct sk_buff, data));
@@ -10438,7 +10438,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sock_ops_kern,
 					       skb));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, len),
 				      si->dst_reg, si->dst_reg,
 				      offsetof(struct sk_buff, len));
@@ -10452,7 +10452,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sock_ops_kern,
 					       skb));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct tcp_skb_cb,
 						       tcp_flags),
 				      si->dst_reg, si->dst_reg, off);
@@ -10472,8 +10472,8 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      bpf_target_off(struct skb_shared_info,
 						     hwtstamps, 8,
 						     target_size));
-		*jmp_on_null_skb = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0,
-					       insn - jmp_on_null_skb - 1);
+		*jmp_on_null_skb = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0,
+						 insn - jmp_on_null_skb - 1);
 		break;
 	}
 	}
@@ -11337,7 +11337,7 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_access_type type,
 		off += bpf_target_off(struct in6_addr, s6_addr32[0], 4, target_size);
 		*insn++ = BPF_LDX_MEM(BPF_SIZEOF(void *), si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sk_lookup_kern, v6.saddr));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg, off);
 #else
 		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
@@ -11353,7 +11353,7 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_access_type type,
 		off += bpf_target_off(struct in6_addr, s6_addr32[0], 4, target_size);
 		*insn++ = BPF_LDX_MEM(BPF_SIZEOF(void *), si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sk_lookup_kern, v6.daddr));
-		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_JMP64_IMM(BPF_JEQ, si->dst_reg, 0, 1);
 		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg, off);
 #else
 		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 771d0fa..2f16ab1 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -116,12 +116,12 @@ static int xsk_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	struct bpf_insn *insn = insn_buf;
 
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+	*insn++ = BPF_JMP64_IMM(BPF_JGE, ret, map->max_entries, 5);
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_sock *)));
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, xsk_map));
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, mp);
 	*insn++ = BPF_LDX_MEM(BPF_SIZEOF(struct xsk_sock *), ret, ret, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+	*insn++ = BPF_JMP64_IMM(BPF_JA, 0, 0, 1);
 	*insn++ = BPF_MOV64_IMM(ret, 0);
 	return insn - insn_buf;
 }
diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
index 1c55a77..7ba92d6 100644
--- a/samples/bpf/bpf_insn.h
+++ b/samples/bpf/bpf_insn.h
@@ -172,7 +172,7 @@ struct bpf_insn;
 
 /* Conditional jumps against registers, if (dst_reg 'op' src_reg) goto pc + off16 */
 
-#define BPF_JMP_REG(OP, DST, SRC, OFF)				\
+#define BPF_JMP64_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
@@ -180,7 +180,7 @@ struct bpf_insn;
 		.off   = OFF,					\
 		.imm   = 0 })
 
-/* Like BPF_JMP_REG, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_REG, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
@@ -192,7 +192,7 @@ struct bpf_insn;
 
 /* Conditional jumps against immediates, if (dst_reg 'op' imm32) goto pc + off16 */
 
-#define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
+#define BPF_JMP64_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
@@ -200,7 +200,7 @@ struct bpf_insn;
 		.off   = OFF,					\
 		.imm   = IMM })
 
-/* Like BPF_JMP_IMM, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_IMM, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index ddc6223..7579460 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -106,7 +106,7 @@ static void prog_load(void)
 		 * stored already
 		 * Otherwise do pc10-22 to setup a new data entry.
 		 */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 14),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 14),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_get_socket_uid),
@@ -139,7 +139,7 @@ static void prog_load(void)
 		BPF_MOV64_IMM(BPF_REG_4, 0),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 				BPF_FUNC_map_update_elem),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 5),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 5),
 		/*
 		 * pc24-30 update the packet info to a exist data entry, it can
 		 * be done by directly write to pointers instead of using
diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index 3e8d74d..123cd75 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -53,7 +53,7 @@ static int test_sock(void)
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
index b8331e7..ed330f7 100644
--- a/samples/bpf/test_cgrp2_attach.c
+++ b/samples/bpf/test_cgrp2_attach.c
@@ -52,7 +52,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd), /* load map fd to r1 */
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 
@@ -63,7 +63,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct __sk_buff, len)), /* r1 = skb->len */
 
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index 5447bce..18ddee1 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -54,7 +54,7 @@ static int prog_load(__u32 idx, __u32 mark, __u32 prio)
 
 		/* if uid is 0, use given mark, else use the uid as the mark */
 		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 		BPF_MOV64_IMM(BPF_REG_3, mark),
 
 		/* set the mark on the new socket */
diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 6f7ed34..fa78389 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -56,22 +56,22 @@
 
 #define BPF_LDX_B	(BPF_LDX | BPF_B)
 #define BPF_LDX_W	(BPF_LDX | BPF_W)
-#define BPF_JMP_JA	(BPF_JMP64 | BPF_JA)
-#define BPF_JMP_JEQ	(BPF_JMP64 | BPF_JEQ)
-#define BPF_JMP_JGT	(BPF_JMP64 | BPF_JGT)
-#define BPF_JMP_JGE	(BPF_JMP64 | BPF_JGE)
-#define BPF_JMP_JSET	(BPF_JMP64 | BPF_JSET)
-#define BPF_ALU_ADD	(BPF_ALU32 | BPF_ADD)
-#define BPF_ALU_SUB	(BPF_ALU32 | BPF_SUB)
-#define BPF_ALU_MUL	(BPF_ALU32 | BPF_MUL)
-#define BPF_ALU_DIV	(BPF_ALU32 | BPF_DIV)
-#define BPF_ALU_MOD	(BPF_ALU32 | BPF_MOD)
-#define BPF_ALU_NEG	(BPF_ALU32 | BPF_NEG)
-#define BPF_ALU_AND	(BPF_ALU32 | BPF_AND)
-#define BPF_ALU_OR	(BPF_ALU32 | BPF_OR)
-#define BPF_ALU_XOR	(BPF_ALU32 | BPF_XOR)
-#define BPF_ALU_LSH	(BPF_ALU32 | BPF_LSH)
-#define BPF_ALU_RSH	(BPF_ALU32 | BPF_RSH)
+#define BPF_JMP64_JA	(BPF_JMP64 | BPF_JA)
+#define BPF_JMP64_JEQ	(BPF_JMP64 | BPF_JEQ)
+#define BPF_JMP64_JGT	(BPF_JMP64 | BPF_JGT)
+#define BPF_JMP64_JGE	(BPF_JMP64 | BPF_JGE)
+#define BPF_JMP64_JSET	(BPF_JMP64 | BPF_JSET)
+#define BPF_ALU32_ADD	(BPF_ALU32 | BPF_ADD)
+#define BPF_ALU32_SUB	(BPF_ALU32 | BPF_SUB)
+#define BPF_ALU32_MUL	(BPF_ALU32 | BPF_MUL)
+#define BPF_ALU32_DIV	(BPF_ALU32 | BPF_DIV)
+#define BPF_ALU32_MOD	(BPF_ALU32 | BPF_MOD)
+#define BPF_ALU32_NEG	(BPF_ALU32 | BPF_NEG)
+#define BPF_ALU32_AND	(BPF_ALU32 | BPF_AND)
+#define BPF_ALU32_OR	(BPF_ALU32 | BPF_OR)
+#define BPF_ALU32_XOR	(BPF_ALU32 | BPF_XOR)
+#define BPF_ALU32_LSH	(BPF_ALU32 | BPF_LSH)
+#define BPF_ALU32_RSH	(BPF_ALU32 | BPF_RSH)
 #define BPF_MISC_TAX	(BPF_MISC | BPF_TAX)
 #define BPF_MISC_TXA	(BPF_MISC | BPF_TXA)
 #define BPF_LD_B	(BPF_LD | BPF_B)
@@ -149,22 +149,22 @@ static const char * const op_table[] = {
 	[BPF_LD_W]	= "ld",
 	[BPF_LDX]	= "ldx",
 	[BPF_LDX_B]	= "ldxb",
-	[BPF_JMP_JA]	= "ja",
-	[BPF_JMP_JEQ]	= "jeq",
-	[BPF_JMP_JGT]	= "jgt",
-	[BPF_JMP_JGE]	= "jge",
-	[BPF_JMP_JSET]	= "jset",
-	[BPF_ALU_ADD]	= "add",
-	[BPF_ALU_SUB]	= "sub",
-	[BPF_ALU_MUL]	= "mul",
-	[BPF_ALU_DIV]	= "div",
-	[BPF_ALU_MOD]	= "mod",
-	[BPF_ALU_NEG]	= "neg",
-	[BPF_ALU_AND]	= "and",
-	[BPF_ALU_OR]	= "or",
-	[BPF_ALU_XOR]	= "xor",
-	[BPF_ALU_LSH]	= "lsh",
-	[BPF_ALU_RSH]	= "rsh",
+	[BPF_JMP64_JA]	= "ja",
+	[BPF_JMP64_JEQ]	= "jeq",
+	[BPF_JMP64_JGT]	= "jgt",
+	[BPF_JMP64_JGE]	= "jge",
+	[BPF_JMP64_JSET] = "jset",
+	[BPF_ALU32_ADD]	= "add",
+	[BPF_ALU32_SUB]	= "sub",
+	[BPF_ALU32_MUL]	= "mul",
+	[BPF_ALU32_DIV]	= "div",
+	[BPF_ALU32_MOD]	= "mod",
+	[BPF_ALU32_NEG]	= "neg",
+	[BPF_ALU32_AND]	= "and",
+	[BPF_ALU32_OR]	= "or",
+	[BPF_ALU32_XOR]	= "xor",
+	[BPF_ALU32_LSH]	= "lsh",
+	[BPF_ALU32_RSH]	= "rsh",
 	[BPF_MISC_TAX]	= "tax",
 	[BPF_MISC_TXA]	= "txa",
 	[BPF_RET]	= "ret",
@@ -296,125 +296,125 @@ static void bpf_disasm(const struct sock_filter f, unsigned int i)
 		op = op_table[BPF_LDX];
 		fmt = "M[%d]";
 		break;
-	case BPF_JMP_JA:
-		op = op_table[BPF_JMP_JA];
+	case BPF_JMP64_JA:
+		op = op_table[BPF_JMP64_JA];
 		fmt = "%d";
 		val = i + 1 + f.k;
 		break;
-	case BPF_JMP_JGT | BPF_X:
-		op = op_table[BPF_JMP_JGT];
+	case BPF_JMP64_JGT | BPF_X:
+		op = op_table[BPF_JMP64_JGT];
 		fmt = "x";
 		break;
-	case BPF_JMP_JGT | BPF_K:
-		op = op_table[BPF_JMP_JGT];
+	case BPF_JMP64_JGT | BPF_K:
+		op = op_table[BPF_JMP64_JGT];
 		fmt = "#%#x";
 		break;
-	case BPF_JMP_JGE | BPF_X:
-		op = op_table[BPF_JMP_JGE];
+	case BPF_JMP64_JGE | BPF_X:
+		op = op_table[BPF_JMP64_JGE];
 		fmt = "x";
 		break;
-	case BPF_JMP_JGE | BPF_K:
-		op = op_table[BPF_JMP_JGE];
+	case BPF_JMP64_JGE | BPF_K:
+		op = op_table[BPF_JMP64_JGE];
 		fmt = "#%#x";
 		break;
-	case BPF_JMP_JEQ | BPF_X:
-		op = op_table[BPF_JMP_JEQ];
+	case BPF_JMP64_JEQ | BPF_X:
+		op = op_table[BPF_JMP64_JEQ];
 		fmt = "x";
 		break;
-	case BPF_JMP_JEQ | BPF_K:
-		op = op_table[BPF_JMP_JEQ];
+	case BPF_JMP64_JEQ | BPF_K:
+		op = op_table[BPF_JMP64_JEQ];
 		fmt = "#%#x";
 		break;
-	case BPF_JMP_JSET | BPF_X:
-		op = op_table[BPF_JMP_JSET];
+	case BPF_JMP64_JSET | BPF_X:
+		op = op_table[BPF_JMP64_JSET];
 		fmt = "x";
 		break;
-	case BPF_JMP_JSET | BPF_K:
-		op = op_table[BPF_JMP_JSET];
+	case BPF_JMP64_JSET | BPF_K:
+		op = op_table[BPF_JMP64_JSET];
 		fmt = "#%#x";
 		break;
-	case BPF_ALU_NEG:
-		op = op_table[BPF_ALU_NEG];
+	case BPF_ALU32_NEG:
+		op = op_table[BPF_ALU32_NEG];
 		fmt = "";
 		break;
-	case BPF_ALU_LSH | BPF_X:
-		op = op_table[BPF_ALU_LSH];
+	case BPF_ALU32_LSH | BPF_X:
+		op = op_table[BPF_ALU32_LSH];
 		fmt = "x";
 		break;
-	case BPF_ALU_LSH | BPF_K:
-		op = op_table[BPF_ALU_LSH];
+	case BPF_ALU32_LSH | BPF_K:
+		op = op_table[BPF_ALU32_LSH];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_RSH | BPF_X:
-		op = op_table[BPF_ALU_RSH];
+	case BPF_ALU32_RSH | BPF_X:
+		op = op_table[BPF_ALU32_RSH];
 		fmt = "x";
 		break;
-	case BPF_ALU_RSH | BPF_K:
-		op = op_table[BPF_ALU_RSH];
+	case BPF_ALU32_RSH | BPF_K:
+		op = op_table[BPF_ALU32_RSH];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_ADD | BPF_X:
-		op = op_table[BPF_ALU_ADD];
+	case BPF_ALU32_ADD | BPF_X:
+		op = op_table[BPF_ALU32_ADD];
 		fmt = "x";
 		break;
-	case BPF_ALU_ADD | BPF_K:
-		op = op_table[BPF_ALU_ADD];
+	case BPF_ALU32_ADD | BPF_K:
+		op = op_table[BPF_ALU32_ADD];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_SUB | BPF_X:
-		op = op_table[BPF_ALU_SUB];
+	case BPF_ALU32_SUB | BPF_X:
+		op = op_table[BPF_ALU32_SUB];
 		fmt = "x";
 		break;
-	case BPF_ALU_SUB | BPF_K:
-		op = op_table[BPF_ALU_SUB];
+	case BPF_ALU32_SUB | BPF_K:
+		op = op_table[BPF_ALU32_SUB];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_MUL | BPF_X:
-		op = op_table[BPF_ALU_MUL];
+	case BPF_ALU32_MUL | BPF_X:
+		op = op_table[BPF_ALU32_MUL];
 		fmt = "x";
 		break;
-	case BPF_ALU_MUL | BPF_K:
-		op = op_table[BPF_ALU_MUL];
+	case BPF_ALU32_MUL | BPF_K:
+		op = op_table[BPF_ALU32_MUL];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_DIV | BPF_X:
-		op = op_table[BPF_ALU_DIV];
+	case BPF_ALU32_DIV | BPF_X:
+		op = op_table[BPF_ALU32_DIV];
 		fmt = "x";
 		break;
-	case BPF_ALU_DIV | BPF_K:
-		op = op_table[BPF_ALU_DIV];
+	case BPF_ALU32_DIV | BPF_K:
+		op = op_table[BPF_ALU32_DIV];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_MOD | BPF_X:
-		op = op_table[BPF_ALU_MOD];
+	case BPF_ALU32_MOD | BPF_X:
+		op = op_table[BPF_ALU32_MOD];
 		fmt = "x";
 		break;
-	case BPF_ALU_MOD | BPF_K:
-		op = op_table[BPF_ALU_MOD];
+	case BPF_ALU32_MOD | BPF_K:
+		op = op_table[BPF_ALU32_MOD];
 		fmt = "#%d";
 		break;
-	case BPF_ALU_AND | BPF_X:
-		op = op_table[BPF_ALU_AND];
+	case BPF_ALU32_AND | BPF_X:
+		op = op_table[BPF_ALU32_AND];
 		fmt = "x";
 		break;
-	case BPF_ALU_AND | BPF_K:
-		op = op_table[BPF_ALU_AND];
+	case BPF_ALU32_AND | BPF_K:
+		op = op_table[BPF_ALU32_AND];
 		fmt = "#%#x";
 		break;
-	case BPF_ALU_OR | BPF_X:
-		op = op_table[BPF_ALU_OR];
+	case BPF_ALU32_OR | BPF_X:
+		op = op_table[BPF_ALU32_OR];
 		fmt = "x";
 		break;
-	case BPF_ALU_OR | BPF_K:
-		op = op_table[BPF_ALU_OR];
+	case BPF_ALU32_OR | BPF_K:
+		op = op_table[BPF_ALU32_OR];
 		fmt = "#%#x";
 		break;
-	case BPF_ALU_XOR | BPF_X:
-		op = op_table[BPF_ALU_XOR];
+	case BPF_ALU32_XOR | BPF_X:
+		op = op_table[BPF_ALU32_XOR];
 		fmt = "x";
 		break;
-	case BPF_ALU_XOR | BPF_K:
-		op = op_table[BPF_ALU_XOR];
+	case BPF_ALU32_XOR | BPF_K:
+		op = op_table[BPF_ALU32_XOR];
 		fmt = "#%#x";
 		break;
 	default:
@@ -727,111 +727,111 @@ static void bpf_single_step(struct bpf_regs *r, struct sock_filter *f,
 	case BPF_LDX | BPF_MEM:
 		r->X = r->M[K];
 		break;
-	case BPF_JMP_JA:
+	case BPF_JMP64_JA:
 		r->Pc += K;
 		break;
-	case BPF_JMP_JGT | BPF_X:
+	case BPF_JMP64_JGT | BPF_X:
 		r->Pc += r->A > r->X ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JGT | BPF_K:
+	case BPF_JMP64_JGT | BPF_K:
 		r->Pc += r->A > K ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JGE | BPF_X:
+	case BPF_JMP64_JGE | BPF_X:
 		r->Pc += r->A >= r->X ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JGE | BPF_K:
+	case BPF_JMP64_JGE | BPF_K:
 		r->Pc += r->A >= K ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JEQ | BPF_X:
+	case BPF_JMP64_JEQ | BPF_X:
 		r->Pc += r->A == r->X ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JEQ | BPF_K:
+	case BPF_JMP64_JEQ | BPF_K:
 		r->Pc += r->A == K ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JSET | BPF_X:
+	case BPF_JMP64_JSET | BPF_X:
 		r->Pc += r->A & r->X ? f->jt : f->jf;
 		break;
-	case BPF_JMP_JSET | BPF_K:
+	case BPF_JMP64_JSET | BPF_K:
 		r->Pc += r->A & K ? f->jt : f->jf;
 		break;
-	case BPF_ALU_NEG:
+	case BPF_ALU32_NEG:
 		r->A = -r->A;
 		break;
-	case BPF_ALU_LSH | BPF_X:
+	case BPF_ALU32_LSH | BPF_X:
 		r->A <<= r->X;
 		break;
-	case BPF_ALU_LSH | BPF_K:
+	case BPF_ALU32_LSH | BPF_K:
 		r->A <<= K;
 		break;
-	case BPF_ALU_RSH | BPF_X:
+	case BPF_ALU32_RSH | BPF_X:
 		r->A >>= r->X;
 		break;
-	case BPF_ALU_RSH | BPF_K:
+	case BPF_ALU32_RSH | BPF_K:
 		r->A >>= K;
 		break;
-	case BPF_ALU_ADD | BPF_X:
+	case BPF_ALU32_ADD | BPF_X:
 		r->A += r->X;
 		break;
-	case BPF_ALU_ADD | BPF_K:
+	case BPF_ALU32_ADD | BPF_K:
 		r->A += K;
 		break;
-	case BPF_ALU_SUB | BPF_X:
+	case BPF_ALU32_SUB | BPF_X:
 		r->A -= r->X;
 		break;
-	case BPF_ALU_SUB | BPF_K:
+	case BPF_ALU32_SUB | BPF_K:
 		r->A -= K;
 		break;
-	case BPF_ALU_MUL | BPF_X:
+	case BPF_ALU32_MUL | BPF_X:
 		r->A *= r->X;
 		break;
-	case BPF_ALU_MUL | BPF_K:
+	case BPF_ALU32_MUL | BPF_K:
 		r->A *= K;
 		break;
-	case BPF_ALU_DIV | BPF_X:
-	case BPF_ALU_MOD | BPF_X:
+	case BPF_ALU32_DIV | BPF_X:
+	case BPF_ALU32_MOD | BPF_X:
 		if (r->X == 0) {
 			set_return(r);
 			break;
 		}
 		goto do_div;
-	case BPF_ALU_DIV | BPF_K:
-	case BPF_ALU_MOD | BPF_K:
+	case BPF_ALU32_DIV | BPF_K:
+	case BPF_ALU32_MOD | BPF_K:
 		if (K == 0) {
 			set_return(r);
 			break;
 		}
 do_div:
 		switch (f->code) {
-		case BPF_ALU_DIV | BPF_X:
+		case BPF_ALU32_DIV | BPF_X:
 			r->A /= r->X;
 			break;
-		case BPF_ALU_DIV | BPF_K:
+		case BPF_ALU32_DIV | BPF_K:
 			r->A /= K;
 			break;
-		case BPF_ALU_MOD | BPF_X:
+		case BPF_ALU32_MOD | BPF_X:
 			r->A %= r->X;
 			break;
-		case BPF_ALU_MOD | BPF_K:
+		case BPF_ALU32_MOD | BPF_K:
 			r->A %= K;
 			break;
 		}
 		break;
-	case BPF_ALU_AND | BPF_X:
+	case BPF_ALU32_AND | BPF_X:
 		r->A &= r->X;
 		break;
-	case BPF_ALU_AND | BPF_K:
+	case BPF_ALU32_AND | BPF_K:
 		r->A &= K;
 		break;
-	case BPF_ALU_OR | BPF_X:
+	case BPF_ALU32_OR | BPF_X:
 		r->A |= r->X;
 		break;
-	case BPF_ALU_OR | BPF_K:
+	case BPF_ALU32_OR | BPF_K:
 		r->A |= K;
 		break;
-	case BPF_ALU_XOR | BPF_X:
+	case BPF_ALU32_XOR | BPF_X:
 		r->A ^= r->X;
 		break;
-	case BPF_ALU_XOR | BPF_K:
+	case BPF_ALU32_XOR | BPF_K:
 		r->A ^= K;
 		break;
 	}
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index da16e6a..58e4f8f 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -835,7 +835,7 @@ probe_bounded_loops(const char *define_prefix, __u32 ifindex)
 	struct bpf_insn insns[4] = {
 		BPF_MOV64_IMM(BPF_REG_0, 10),
 		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -2),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, -2),
 		BPF_EXIT_INSN()
 	};
 
@@ -855,7 +855,7 @@ probe_v2_isa_extension(const char *define_prefix, __u32 ifindex)
 {
 	struct bpf_insn insns[4] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 0, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN()
 	};
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index cf111f1..97169b1 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -207,7 +207,7 @@
 
 /* Conditional jumps against registers, if (dst_reg 'op' src_reg) goto pc + off16 */
 
-#define BPF_JMP_REG(OP, DST, SRC, OFF)				\
+#define BPF_JMP64_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
@@ -215,7 +215,7 @@
 		.off   = OFF,					\
 		.imm   = 0 })
 
-/* Like BPF_JMP_REG, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_REG, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_REG(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
@@ -227,7 +227,7 @@
 
 /* Conditional jumps against immediates, if (dst_reg 'op' imm32) goto pc + off16 */
 
-#define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
+#define BPF_JMP64_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
@@ -235,7 +235,7 @@
 		.off   = OFF,					\
 		.imm   = IMM })
 
-/* Like BPF_JMP_IMM, but with 32-bit wide operands for comparison. */
+/* Like BPF_JMP64_IMM, but with 32-bit wide operands for comparison. */
 
 #define BPF_JMP32_IMM(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
@@ -247,7 +247,7 @@
 
 /* Unconditional jumps, goto pc + off16 */
 
-#define BPF_JMP_A(OFF)						\
+#define BPF_JMP64_A(OFF)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP64 | BPF_JA,			\
 		.dst_reg = 0,					\
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 23f5c46..d1dc6d5 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -130,7 +130,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* amount of stack actually used, only used to calculate iterations, not stack offset */
 	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
 	/* jump over cleanup code */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
+	emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0,
 			      /* size of cleanup code below (including map fd cleanup) */
 			      (nr_progs_sz / 4) * 3 + 2 +
 			      /* 6 insns for emit_sys_close_blob,
@@ -143,7 +143,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* emit cleanup code: close all temp FDs */
 	for (i = 0; i < nr_progs_sz; i += 4) {
 		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
-		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
+		emit(gen, BPF_JMP64_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
 		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
 	}
 	for (i = 0; i < nr_maps; i++)
@@ -243,7 +243,7 @@ static void move_ctx2blob(struct bpf_gen *gen, int off, int size, int ctx_off,
 		/* If value in ctx is zero don't update the blob.
 		 * For example: when ctx->map.max_entries == 0, keep default max_entries from bpf.c
 		 */
-		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3));
+		emit(gen, BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3));
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, off));
 	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_1, BPF_REG_0, 0));
@@ -287,10 +287,10 @@ static void emit_check_err(struct bpf_gen *gen)
 	 * if (R7 < 0) goto cleanup;
 	 */
 	if (is_simm16(off)) {
-		emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
+		emit(gen, BPF_JMP64_IMM(BPF_JSLT, BPF_REG_7, 0, off));
 	} else {
 		gen->error = -ERANGE;
-		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
+		emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0, -1));
 	}
 }
 
@@ -343,7 +343,7 @@ static void debug_ret(struct bpf_gen *gen, const char *fmt, ...)
 
 static void __emit_sys_close(struct bpf_gen *gen)
 {
-	emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0,
+	emit(gen, BPF_JMP64_IMM(BPF_JSLE, BPF_REG_1, 0,
 			      /* 2 is the number of the following insns
 			       * * 6 is additional insns in debug_regs
 			       */
@@ -688,23 +688,23 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 	}
 	kdesc->off = btf_fd_idx;
 	/* jump to success case */
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	emit(gen, BPF_JMP64_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
 	/* set value for imm, off as 0 */
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, imm), 0));
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
 	/* skip success case for ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 10));
+	emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0, 10));
 	/* store btf_id into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7, offsetof(struct bpf_insn, imm)));
 	/* obtain fd in BPF_REG_9 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_7));
 	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_9, 32));
 	/* jump to fd_array store if fd denotes module BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
+	emit(gen, BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 0, 2));
 	/* set the default value for off */
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
 	/* skip BTF fd store for vmlinux BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
+	emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0, 4));
 	/* load fd_array slot pointer */
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, blob_fd_array_off(gen, btf_fd_idx)));
@@ -768,7 +768,7 @@ static void emit_relo_ksym_typeless(struct bpf_gen *gen,
 	/* skip typeless ksym_desc in fd closing loop in cleanup_relos */
 	kdesc->typeless = true;
 	emit_bpf_kallsyms_lookup_name(gen, relo);
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, -ENOENT, 1));
+	emit(gen, BPF_JMP64_IMM(BPF_JEQ, BPF_REG_7, -ENOENT, 1));
 	emit_check_err(gen);
 	/* store lower half of addr into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_9, offsetof(struct bpf_insn, imm)));
@@ -809,7 +809,7 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 		move_blob2blob(gen, insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm), 4,
 			       kdesc->insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm));
 		/* jump over src_reg adjustment if imm is not 0, reuse BPF_REG_0 from move_blob2blob */
-		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3));
+		emit(gen, BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3));
 		goto clear_src_reg;
 	}
 	/* remember insn offset, so we can copy BTF ID and FD later */
@@ -818,12 +818,12 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	if (!relo->is_weak)
 		emit_check_err(gen);
 	/* jump to success case */
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	emit(gen, BPF_JMP64_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
 	/* set values for insn[insn_idx].imm, insn[insn_idx + 1].imm as 0 */
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, imm), 0));
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm), 0));
 	/* skip success case for ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
+	emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0, 4));
 	/* store btf_id into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7, offsetof(struct bpf_insn, imm)));
 	/* store btf_obj_fd into insn[insn_idx + 1].imm */
@@ -831,7 +831,7 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7,
 			      sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm)));
 	/* skip src_reg adjustment */
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	emit(gen, BPF_JMP64_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
 clear_src_reg:
 	/* clear bpf_object__relocate_data's src_reg assignment, otherwise we get a verifier failure */
 	reg_mask = src_reg_mask();
@@ -1054,15 +1054,15 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 			      sizeof(struct bpf_loader_ctx) +
 			      sizeof(struct bpf_map_desc) * map_idx +
 			      offsetof(struct bpf_map_desc, initial_value)));
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
+	emit(gen, BPF_JMP64_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, value));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
 	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
 			      offsetof(struct bpf_loader_ctx, flags)));
-	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
+	emit(gen, BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
+	emit(gen, BPF_JMP64_IMM(BPF_JA, 0, 0, 1));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
 
 	map_update_attr = add_data(gen, &attr, attr_size);
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 16b3957..b4ea8cc 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -166,7 +166,7 @@ gen_read_mem(struct bpf_insn_pos *pos,
 	 * will be relocated. Target should be the start of
 	 * error processing code.
 	 */
-	ins(BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, JMP_TO_ERROR_CODE),
+	ins(BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, JMP_TO_ERROR_CODE),
 	    pos);
 
 	return check_pos(pos);
@@ -314,7 +314,7 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
 				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
 	}
 
-	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
+	ins(BPF_JMP64_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
 
 	return check_pos(pos);
 errout:
@@ -468,7 +468,7 @@ int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
 					  BPF_PROLOGUE_START_ARG_REG + i,
 					  0),
 			    &pos);
-		ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_USER_CODE),
+		ins(BPF_JMP64_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_USER_CODE),
 				&pos);
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 4666f88..d7fba94 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -138,7 +138,7 @@ static struct bpf_align_test tests[] = {
 	PREP_PKT_POINTERS, \
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2), \
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8), \
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 1), \
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 1), \
 	BPF_EXIT_INSN(), \
 	BPF_LDX_MEM(BPF_B, DST_REG, BPF_REG_2, 0)
 
@@ -218,7 +218,7 @@ static struct bpf_align_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 
 			BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_5, 0),
@@ -258,7 +258,7 @@ static struct bpf_align_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
 
@@ -271,7 +271,7 @@ static struct bpf_align_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
 
@@ -286,7 +286,7 @@ static struct bpf_align_test tests[] = {
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
 
@@ -374,7 +374,7 @@ static struct bpf_align_test tests[] = {
 			/* Check bounds and perform a read */
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
 			/* Make a (4n) offset from the value we just read */
@@ -385,7 +385,7 @@ static struct bpf_align_test tests[] = {
 			/* Check bounds and perform a read */
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -442,7 +442,7 @@ static struct bpf_align_test tests[] = {
 			 */
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			/* Then make sure it's nonnegative */
-			BPF_JMP_IMM(BPF_JSGE, BPF_REG_5, 0, 1),
+			BPF_JMP64_IMM(BPF_JSGE, BPF_REG_5, 0, 1),
 			BPF_EXIT_INSN(),
 			/* Add it to packet pointer */
 			BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
@@ -450,7 +450,7 @@ static struct bpf_align_test tests[] = {
 			/* Check bounds and perform a read */
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_6),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_6, 0),
 			BPF_EXIT_INSN(),
@@ -494,7 +494,7 @@ static struct bpf_align_test tests[] = {
 			BPF_ALU64_IMM(BPF_LSH, BPF_REG_7, 2),
 			BPF_ALU64_REG(BPF_SUB, BPF_REG_6, BPF_REG_7),
 			/* Bounds-check the result */
-			BPF_JMP_IMM(BPF_JSGE, BPF_REG_6, 0, 1),
+			BPF_JMP64_IMM(BPF_JSGE, BPF_REG_6, 0, 1),
 			BPF_EXIT_INSN(),
 			/* Add it to the packet pointer */
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
@@ -502,7 +502,7 @@ static struct bpf_align_test tests[] = {
 			/* Check bounds and perform a read */
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
 			BPF_EXIT_INSN(),
@@ -556,7 +556,7 @@ static struct bpf_align_test tests[] = {
 			/* Check bounds and perform a read */
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
+			BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
 			BPF_EXIT_INSN(),
 			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
 			BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index e9a214b..a429f8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5986,7 +5986,7 @@ static struct prog_info_raw_test {
 	},
 	BTF_STR_SEC("\0int\0/* dead jmp */\0int a=1;\0int b=2;\0return a + b;\0return a + b;"),
 	.insns = {
-		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -6019,7 +6019,7 @@ static struct prog_info_raw_test {
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, 1),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, 1),
 		BPF_EXIT_INSN(),
 		BPF_EXIT_INSN(),
 	},
@@ -6058,7 +6058,7 @@ static struct prog_info_raw_test {
 		BPF_MOV64_IMM(BPF_REG_2, 1),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 8),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 8),
 		BPF_MOV64_IMM(BPF_REG_2, 1),
 		BPF_MOV64_IMM(BPF_REG_2, 1),
 		BPF_MOV64_IMM(BPF_REG_2, 1),
@@ -6116,7 +6116,7 @@ static struct prog_info_raw_test {
 		    "\0return bla + 1;\0return func(a);\0b+=1;\0return b;"),
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_2, 1),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 		BPF_CALL_REL(3),
 		BPF_CALL_REL(5),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -6167,7 +6167,7 @@ static struct prog_info_raw_test {
 		    "\0return 0;\0/* dead */\0/* dead */"),
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_2, 1),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 		BPF_CALL_REL(2),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -6210,9 +6210,9 @@ static struct prog_info_raw_test {
 		    "\0/* dead */\0/* dead */\0/* dead */\0/* dead */"
 		    "\0return b + 1;\0return b + 1;\0return b + 1;"),
 	.insns = {
-		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_2, 1),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 		BPF_CALL_REL(3),
 		BPF_CALL_REL(5),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -6220,7 +6220,7 @@ static struct prog_info_raw_test {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_CALL_REL(1),
 		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 		BPF_MOV64_REG(BPF_REG_0, 2),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
@@ -6269,7 +6269,7 @@ static struct prog_info_raw_test {
 		    "\0return bla + 1;\0return func(a);\0b+=1;\0return b;"),
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_2, 1),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 		BPF_CALL_REL(3),
 		BPF_CALL_REL(5),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -6277,7 +6277,7 @@ static struct prog_info_raw_test {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_CALL_REL(1),
 		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 		BPF_MOV64_REG(BPF_REG_0, 2),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
@@ -6320,12 +6320,12 @@ static struct prog_info_raw_test {
 	BTF_STR_SEC("\0int\0x\0main\0func\0/* main linfo */\0/* func linfo */"),
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 1, 3),
+		BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 1, 3),
 		BPF_CALL_REL(3),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 		BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 87c5434..2fe3d4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -43,7 +43,7 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
index ca3bcd7..9f26fde 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -17,7 +17,7 @@ void serial_test_flow_dissector_load_bytes(void)
 		// bpf_skb_load_bytes(ctx, sizeof(pkt_v4), ptr, 1)
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_skb_load_bytes),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 		// if (ret == 0) return BPF_DROP (2)
 		BPF_MOV64_IMM(BPF_REG_0, BPF_DROP),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 3656ed2..d3be966 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -125,14 +125,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, level)),
 
 			/* if (ctx->level == 123) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 123, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 123, 4),
 			/* ctx->retval = 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, retval)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -168,14 +168,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optname)),
 
 			/* if (ctx->optname == 123) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 123, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 123, 4),
 			/* ctx->retval = 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, retval)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -229,14 +229,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optlen)),
 
 			/* if (ctx->optlen == 64) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 64, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 64, 4),
 			/* ctx->retval = 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, retval)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -356,7 +356,7 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optval_end)),
 
 			/* if (ctx->optval + 1 <= ctx->optval_end) { */
-			BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+			BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
 			/* ctx->optval[0] = 0xF0 */
 			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xF0),
 			/* } */
@@ -470,14 +470,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, level)),
 
 			/* if (ctx->level == 123) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 123, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 123, 4),
 			/* ctx->optlen = -1 */
 			BPF_MOV64_IMM(BPF_REG_0, -1),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, optlen)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -524,14 +524,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optname)),
 
 			/* if (ctx->optname == 123) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 123, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 123, 4),
 			/* ctx->optlen = -1 */
 			BPF_MOV64_IMM(BPF_REG_0, -1),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, optlen)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -578,14 +578,14 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optlen)),
 
 			/* if (ctx->optlen == 64) { */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 64, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 64, 4),
 			/* ctx->optlen = -1 */
 			BPF_MOV64_IMM(BPF_REG_0, -1),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, optlen)),
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } else { */
 			/* return 0 */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -664,7 +664,7 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optval_end)),
 
 			/* if (ctx->optval + 1 <= ctx->optval_end) { */
-			BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+			BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
 			/* ctx->optval[0] = 1 << 3 */
 			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 1 << 3),
 			/* } */
@@ -768,15 +768,15 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optval_end)),
 
 			/* if (ctx->optval + 1 <= ctx->optval_end) { */
-			BPF_JMP_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 4),
+			BPF_JMP64_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 4),
 
 			/* r9 = ctx->optval[0] */
 			BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_6, 0),
 
 			/* if (ctx->optval[0] < 128) */
-			BPF_JMP_IMM(BPF_JGT, BPF_REG_9, 128, 2),
+			BPF_JMP64_IMM(BPF_JGT, BPF_REG_9, 128, 2),
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } */
 
 			/* } else { */
@@ -814,15 +814,15 @@ static struct sockopt_test {
 				    offsetof(struct bpf_sockopt, optval_end)),
 
 			/* if (ctx->optval + 1 <= ctx->optval_end) { */
-			BPF_JMP_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 4),
+			BPF_JMP64_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 4),
 
 			/* r9 = ctx->optval[0] */
 			BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_6, 0),
 
 			/* if (ctx->optval[0] < 128) */
-			BPF_JMP_IMM(BPF_JGT, BPF_REG_9, 128, 2),
+			BPF_JMP64_IMM(BPF_JGT, BPF_REG_9, 128, 2),
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 			/* } */
 
 			/* } else { */
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4d0650c..0aa4287 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -50,11 +50,11 @@ static int bpf_map_lookup_elem_with_ref_bit(int fd, unsigned long long key,
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_DW, BPF_REG_9, BPF_REG_1, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 42),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	};
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 810c374..6f6dcae 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -201,15 +201,15 @@ static struct sock_test tests[] = {
 			/* if (ip == expected && port == expected) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_ip6[3])),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7,
 				    __bpf_constant_ntohl(0x00000001), 4),
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -231,15 +231,15 @@ static struct sock_test tests[] = {
 			/* if (ip == expected && port == expected) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7,
 				    __bpf_constant_ntohl(0x7F000001), 4),
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -261,15 +261,15 @@ static struct sock_test tests[] = {
 			/* if (ip == expected && port == expected) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7,
 				    __bpf_constant_ntohl(0x7F000001), 4),
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -292,15 +292,15 @@ static struct sock_test tests[] = {
 			/* if (ip == expected && port == expected) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7,
 				    __bpf_constant_ntohl(0x7F000001), 4),
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -323,15 +323,15 @@ static struct sock_test tests[] = {
 			/* if (ip == expected && port == expected) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_ip6[3])),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7,
 				    __bpf_constant_ntohl(0x00000001), 4),
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 2c89674..5703546 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -766,12 +766,12 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 		/* if (sk.family == AF_INET && */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, family)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET, 8),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, AF_INET, 8),
 
 		/*     sk.type == SOCK_DGRAM)  { */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, type)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, SOCK_DGRAM, 6),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, SOCK_DGRAM, 6),
 
 		/*      msg_src_ip4 = src4_rw_ip */
 		BPF_MOV32_IMM(BPF_REG_7, src4_rw_ip.s_addr),
@@ -829,7 +829,7 @@ static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 		/* if (sk.family == AF_INET6) { */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, family)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET6, 18),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, AF_INET6, 18),
 
 #define STORE_IPV6_WORD_N(DST, SRC, N)					       \
 		BPF_MOV32_IMM(BPF_REG_7, SRC[N]),			       \
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index bcdbd27..4ab32dd 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -83,11 +83,11 @@ static struct sysctl_test tests[] = {
 			/* If (write) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, write)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 1, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 1, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -104,11 +104,11 @@ static struct sysctl_test tests[] = {
 			/* If (write) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, write)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 1, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 1, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -164,11 +164,11 @@ static struct sysctl_test tests[] = {
 			/* If (file_pos == X) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 3, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 3, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -191,11 +191,11 @@ static struct sysctl_test tests[] = {
 			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos) + 3),
 #endif
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 4, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 4, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -244,16 +244,16 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, sizeof("tcp_mem") - 1, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, sizeof("tcp_mem") - 1, 6),
 			/*     buf == "tcp_mem\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x7463705f6d656d00ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -285,17 +285,17 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:7] == "tcp_me\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x7463705f6d650000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -329,28 +329,28 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 16, 14),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 16, 14),
 
 			/*     buf[0:8] == "net/ipv4" && */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x6e65742f69707634ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
 
 			/*     buf[8:16] == "/tcp_mem" && */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x2f7463705f6d656dULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
 			/*     buf[16:24] == "\0") */
 			BPF_LD_IMM64(BPF_REG_8, 0x0ULL),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 16),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -383,23 +383,23 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 10),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 10),
 
 			/*     buf[0:8] == "net/ipv4" && */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x6e65742f69707634ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
 			/*     buf[8:16] == "/tcp_me\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x2f7463705f6d6500ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -431,17 +431,17 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:8] == "net/ip\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x6e65742f69700000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -467,17 +467,17 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 6, 6),
 
 			/*     buf[0:6] == "Linux\n\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x4c696e75780a0000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -506,17 +506,17 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 6, 6),
 
 			/*     buf[0:6] == "Linux\n\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x4c696e75780a0000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -545,17 +545,17 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:6] == "Linux\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x4c696e7578000000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -582,15 +582,15 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 4),
 
 			/*     buf[0:8] is NUL-filled) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 0, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -618,16 +618,16 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 4, 6),
 
 			/*     buf[0:4] == expected) */
 			BPF_LD_IMM64(BPF_REG_8, FIXUP_SYSCTL_VALUE),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -657,11 +657,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -688,16 +688,16 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 3, 4),
 
 			/*     buf[0:4] == "606\0") */
 			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9,
 				    bpf_ntohl(0x36303600), 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -725,29 +725,29 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 23, 14),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 23, 14),
 
 			/*     buf[0:8] == "3000000 " && */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x3330303030303020ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
 
 			/*     buf[8:16] == "4000000 " && */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x3430303030303020ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
 			/*     buf[16:24] == "6000000\0") */
 			BPF_LD_IMM64(BPF_REG_8,
 				     bpf_be64_to_cpu(0x3630303030303000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 16),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -777,16 +777,16 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 4),
 
 			/*     buf[0:3] == "60\0") */
 			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9,
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9,
 				    bpf_ntohl(0x36300000), 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -817,11 +817,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_set_new_value),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -851,11 +851,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_sysctl_set_new_value),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -893,14 +893,14 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 3, 4),
 			/*     res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 600, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 600, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -937,10 +937,10 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 18),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 3, 18),
 			/*     res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 600, 16),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 600, 16),
 
 			/*     arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
@@ -963,14 +963,14 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/*     if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 4, 4),
 			/*         res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 602, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 602, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1040,14 +1040,14 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 3, 4),
 			/*     res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 63, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 63, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1084,11 +1084,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1125,11 +1125,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1167,11 +1167,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1209,14 +1209,14 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtol),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 3, 4),
 			/*     res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, -6, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, -6, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1254,14 +1254,14 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtol),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 4),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 4, 4),
 			/*     res == expected) */
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 254, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_9, 254, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1304,15 +1304,15 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtol),
 
 			/* if (ret == expected && */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 19, 6),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 19, 6),
 			/*     res == expected) */
 			BPF_LD_IMM64(BPF_REG_8, 0x7fffffffffffffffULL),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+			BPF_JMP64_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1355,11 +1355,11 @@ static struct sysctl_test tests[] = {
 			BPF_EMIT_CALL(BPF_FUNC_strtol),
 
 			/* if (ret == expected) */
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -ERANGE, 2),
+			BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, -ERANGE, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
+			BPF_JMP64_A(1),
 
 			/* else return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 83319c0..6864c95 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -210,7 +210,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_3, 2);
 		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_skb_vlan_push),
-		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
+		insn[i] = BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
 	}
 
@@ -221,7 +221,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_skb_vlan_pop),
-		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
+		insn[i] = BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
 	}
 	if (++k < 5)
@@ -229,7 +229,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 
 	for (; i < len - 3; i++)
 		insn[i] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0xbef);
-	insn[len - 3] = BPF_JMP_A(1);
+	insn[len - 3] = BPF_JMP64_A(1);
 	/* error label */
 	insn[len - 2] = BPF_MOV32_IMM(BPF_REG_0, 0);
 	insn[len - 1] = BPF_EXIT_INSN();
@@ -250,7 +250,7 @@ static void bpf_fill_jump_around_ld_abs(struct bpf_test *self)
 
 	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	insn[i++] = BPF_LD_ABS(BPF_B, 0);
-	insn[i] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 10, len - i - 2);
+	insn[i] = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 10, len - i - 2);
 	i++;
 	while (i < len - 1)
 		insn[i++] = BPF_LD_ABS(BPF_B, 1);
@@ -296,7 +296,7 @@ static void bpf_fill_scale1(struct bpf_test *self)
 	while (k++ < MAX_JMP_SEQ) {
 		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_get_prandom_u32);
-		insn[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
+		insn[i++] = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
 		insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
 					-8 * (k % 64 + 1));
@@ -328,7 +328,7 @@ static void bpf_fill_scale2(struct bpf_test *self)
 	while (k++ < MAX_JMP_SEQ) {
 		insn[i++] = BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0,
 					 BPF_FUNC_get_prandom_u32);
-		insn[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
+		insn[i++] = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, bpf_semi_rand_get(), 2);
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
 		insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
 					-8 * (k % (64 - 4 * FUNC_NEST) + 1));
@@ -360,8 +360,8 @@ static int bpf_fill_torturous_jumps_insn_1(struct bpf_insn *insn)
 
 	insn[0] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
 	for (i = 1; i <= hlen; i++) {
-		insn[i]        = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, i, hlen);
-		insn[i + hlen] = BPF_JMP_A(hlen - i);
+		insn[i]        = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, i, hlen);
+		insn[i + hlen] = BPF_JMP64_A(hlen - i);
 	}
 	insn[len - 2] = BPF_MOV64_IMM(BPF_REG_0, 1);
 	insn[len - 1] = BPF_EXIT_INSN();
@@ -376,12 +376,12 @@ static int bpf_fill_torturous_jumps_insn_2(struct bpf_insn *insn)
 
 	insn[0] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
 	for (i = 1; i <= jmp_off; i++) {
-		insn[i] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, i, jmp_off);
+		insn[i] = BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, i, jmp_off);
 	}
-	insn[i++] = BPF_JMP_A(jmp_off);
+	insn[i++] = BPF_JMP64_A(jmp_off);
 	for (; i <= jmp_off * 2 + 1; i+=16) {
 		for (j = 0; j < 16; j++) {
-			insn[i + j] = BPF_JMP_A(16 - j - 1);
+			insn[i + j] = BPF_JMP64_A(16 - j - 1);
 		}
 	}
 
@@ -494,7 +494,7 @@ static void bpf_fill_big_prog_with_loop_1(struct bpf_test *self)
 		    offsetof(struct __sk_buff, data_end)),		\
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),				\
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),				\
-	BPF_JMP_REG(BPF_JLE, BPF_REG_4, BPF_REG_3, 1),			\
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_4, BPF_REG_3, 1),		\
 	BPF_EXIT_INSN()
 
 /* BPF_RAND_UEXT_R7 contains 4 instructions, it initializes R7 into a random
diff --git a/tools/testing/selftests/bpf/verifier/and.c b/tools/testing/selftests/bpf/verifier/and.c
index 6edbfe3..b6d7a804 100644
--- a/tools/testing/selftests/bpf/verifier/and.c
+++ b/tools/testing/selftests/bpf/verifier/and.c
@@ -6,7 +6,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
@@ -27,7 +27,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 12),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 12),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 	BPF_ALU32_IMM(BPF_MOD, BPF_REG_1, 2),
diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
index f32bd8b..69a9ed9 100644
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ b/tools/testing/selftests/bpf/verifier/array_access.c
@@ -6,7 +6,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_EXIT_INSN(),
 	},
@@ -23,7 +23,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -44,9 +44,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 3),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 3),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
@@ -66,12 +66,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP32_IMM(BPF_JSGT, BPF_REG_1, 0xffffffff, 1),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -92,7 +92,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, (MAX_ENTRIES + 1) << 2,
 		   offsetof(struct test_val, foo)),
 	BPF_EXIT_INSN(),
@@ -109,7 +109,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, MAX_ENTRIES + 1),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -129,7 +129,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -149,10 +149,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -174,10 +174,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES + 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -199,14 +199,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
 		    offsetof(struct test_val, foo)),
@@ -225,7 +225,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -241,7 +241,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
@@ -266,7 +266,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_EXIT_INSN(),
 	},
@@ -283,7 +283,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
@@ -305,7 +305,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -323,7 +323,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
@@ -345,7 +345,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -361,7 +361,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
diff --git a/tools/testing/selftests/bpf/verifier/atomic_and.c b/tools/testing/selftests/bpf/verifier/atomic_and.c
index fe4bb70..2c67275 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_and.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_and.c
@@ -8,12 +8,12 @@
 		BPF_ATOMIC_OP(BPF_DW, BPF_AND, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x010) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x010, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0x010, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 		/* r1 should not be clobbered, no BPF_FETCH flag */
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	},
@@ -29,16 +29,16 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 0x110) exit(3); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_EXIT_INSN(),
 		/* if (val != 0x010) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_EXIT_INSN(),
 		/* Check R0 wasn't clobbered (for fear of x86 JIT bug) */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
@@ -84,12 +84,12 @@
 		BPF_MOV64_IMM(BPF_REG_0, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH, BPF_REG_10, BPF_REG_0, -8),
 		/* if (old != 0x110) exit(3); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x110, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0x110, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_EXIT_INSN(),
 		/* if (val != 0x010) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
index e82183e..436372f 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
@@ -18,7 +18,7 @@
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
 		/* Verifier should be able to tell that this infinite loop isn't reachable. */
 		/* if (b) while (true) continue; */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, -1),
 		BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index b39665f..4a334dc 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -8,12 +8,12 @@
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 3) exit(2); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 		/* if (val != 3) exit(3); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_EXIT_INSN(),
 		/* old = atomic_cmpxchg(&val, 3, 4); */
@@ -21,12 +21,12 @@
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 3) exit(4); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 4),
 		BPF_EXIT_INSN(),
 		/* if (val != 4) exit(5); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 5),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
@@ -110,7 +110,7 @@
 		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
 		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
 		/* if (r0 != r1) exit(1); */
-		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
+		BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
 		BPF_MOV32_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
@@ -130,7 +130,7 @@
 		BPF_MOV64_IMM(BPF_REG_1, 1),
 		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
 		/* if (r0 != 0) exit(1); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch.c b/tools/testing/selftests/bpf/verifier/atomic_fetch.c
index 5bf03fb..6941206 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_fetch.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch.c
@@ -12,7 +12,7 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -36,7 +36,7 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -60,7 +60,7 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -83,7 +83,7 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -104,12 +104,12 @@
 			BPF_ATOMIC_OP(BPF_DW, op,			\
 				      dst_reg, src_reg, -8),		\
 			/* if (old != operand1) exit(1); */		\
-			BPF_JMP_IMM(BPF_JEQ, src_reg, operand1, 2),	\
+			BPF_JMP64_IMM(BPF_JEQ, src_reg, operand1, 2),	\
 			BPF_MOV64_IMM(BPF_REG_0, 1),			\
 			BPF_EXIT_INSN(),				\
 			/* if (val != result) exit (2); */		\
 			BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),	\
-			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, expect, 2),	\
+			BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, expect, 2),	\
 			BPF_MOV64_IMM(BPF_REG_0, 2),			\
 			BPF_EXIT_INSN(),				\
 			/* exit(0); */					\
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
index a91de8c..5602b5d 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
@@ -8,13 +8,13 @@
 		BPF_MOV64_IMM(BPF_REG_1, 1),
 		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
 		/* Check the value we loaded back was 3 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* Load value from stack */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
 		/* Check value loaded from stack was 4 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 	},
@@ -30,13 +30,13 @@
 		BPF_MOV32_IMM(BPF_REG_1, 1),
 		BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -4),
 		/* Check the value we loaded back was 3 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* Load value from stack */
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
 		/* Check value loaded from stack was 4 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
index 9d0716a..c1baeb6 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -8,12 +8,12 @@
 		BPF_ATOMIC_OP(BPF_DW, BPF_OR, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x111) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x111, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0x111, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 		/* r1 should not be clobbered, no BPF_FETCH flag */
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	},
@@ -29,16 +29,16 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 0x110) exit(3); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_EXIT_INSN(),
 		/* if (val != 0x111) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x111, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x111, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_EXIT_INSN(),
 		/* Check R0 wasn't clobbered (for fear of x86 JIT bug) */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
@@ -91,7 +91,7 @@
 		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
 		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
 		/* if (r2 != r1) exit(1); */
-		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
+		BPF_JMP64_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
 		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xchg.c b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
index 33e2d6c..1ec8295 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_xchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
@@ -7,12 +7,12 @@
 		BPF_MOV64_IMM(BPF_REG_1, 4),
 		BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 3) exit(1); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* if (val != 4) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xor.c b/tools/testing/selftests/bpf/verifier/atomic_xor.c
index 74e8fb4..34c8009 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_xor.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_xor.c
@@ -8,12 +8,12 @@
 		BPF_ATOMIC_OP(BPF_DW, BPF_XOR, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x101) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x101, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0x101, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
 		/* r1 should not be clobbered, no BPF_FETCH flag */
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	},
@@ -29,16 +29,16 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
 		/* if (old != 0x110) exit(3); */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 3),
 		BPF_EXIT_INSN(),
 		/* if (val != 0x101) exit(2); */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x101, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x101, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 2),
 		BPF_EXIT_INSN(),
 		/* Check R0 wasn't clobbered (fxor fear of x86 JIT bug) */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 		/* exit(0); */
diff --git a/tools/testing/selftests/bpf/verifier/basic_instr.c b/tools/testing/selftests/bpf/verifier/basic_instr.c
index 071dbc8..2630d8c 100644
--- a/tools/testing/selftests/bpf/verifier/basic_instr.c
+++ b/tools/testing/selftests/bpf/verifier/basic_instr.c
@@ -21,7 +21,7 @@
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_2, 0xffff),
 	BPF_ALU32_REG(BPF_XOR, BPF_REG_2, BPF_REG_2),
 	BPF_MOV32_IMM(BPF_REG_0, 2),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -96,7 +96,7 @@
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_LD_IMM64(BPF_REG_1, 1),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -110,7 +110,7 @@
 	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -124,7 +124,7 @@
 	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -138,7 +138,7 @@
 	BPF_LD_IMM64(BPF_REG_1, 1),
 	BPF_LD_IMM64(BPF_REG_2, 0),
 	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -153,7 +153,7 @@
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
 	BPF_LD_IMM64(BPF_REG_3, 0),
 	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_3),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -168,7 +168,7 @@
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
 	BPF_LD_IMM64(BPF_REG_3, 0),
 	BPF_ALU64_REG(BPF_ARSH, BPF_REG_1, BPF_REG_3),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index f822f2b..80066f7 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -6,11 +6,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 7),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 0xff, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 0xff, 5),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, 0xff, 5),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 56),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -31,11 +31,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 6),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 0xff, 6),
 	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 0xff, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, 0xff, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
@@ -64,7 +64,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_ARG2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -83,7 +83,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0x0000'0000'ffff'ffff */
 	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff),
 	/* r2 = 0 */
@@ -107,7 +107,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0xffff'ffff'ffff'ffff */
 	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
 	/* r2 = 0xffff'ffff */
@@ -132,7 +132,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* r2 = 0xffff'ffff'ffff'ffff */
 	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
 	/* r2 = 0xfff'ffff */
@@ -159,7 +159,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 29) - 1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
@@ -183,7 +183,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 30) - 1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
@@ -205,7 +205,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
@@ -238,7 +238,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
@@ -272,7 +272,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
@@ -307,7 +307,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	/* r1 = 0x7fff'ffff */
 	BPF_MOV64_IMM(BPF_REG_1, 0x7fffffff),
 	/* r1 = 0xffff'fffe */
@@ -333,7 +333,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_2, 32),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
 	/* r1 = (u32)1 << (u32)32 = ? */
@@ -360,7 +360,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	/* r1 = [-0x01, 0xfe] */
@@ -389,7 +389,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	/* r1 = 2 */
 	BPF_MOV64_IMM(BPF_REG_1, 2),
 	/* r1 = 1<<32 */
@@ -416,11 +416,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x7ffffffe),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(0),
+	BPF_JMP64_A(0),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -435,13 +435,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(0),
+	BPF_JMP64_A(0),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -457,12 +457,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 0x1fffffff),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 0x1fffffff),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 2),
-	BPF_JMP_A(0),
+	BPF_JMP64_A(0),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -478,13 +478,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 1000000),
 	BPF_ALU64_IMM(BPF_MUL, BPF_REG_1, 1000000),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 2),
-	BPF_JMP_A(0),
+	BPF_JMP64_A(0),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -503,7 +503,7 @@
 	/* check ALU64 op keeps 32bit bounds */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_JMP32_IMM(BPF_JGT, BPF_REG_1, 2, 1),
-	BPF_JMP_A(1),
+	BPF_JMP64_A(1),
 	/* invalid ldx if bounds are lost above */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -1),
 	BPF_EXIT_INSN(),
@@ -524,8 +524,8 @@
 	/* r1 = 0x2 */
 	BPF_ALU32_IMM(BPF_ADD, BPF_REG_1, 1),
 	/* check ALU32 op zero extends 64bit bounds */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 1),
-	BPF_JMP_A(1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_A(1),
 	/* invalid ldx if bounds are lost above */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -1),
 	BPF_EXIT_INSN(),
@@ -547,7 +547,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_8, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_8, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_6, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -564,11 +564,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -586,7 +586,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 1),
@@ -608,11 +608,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 2),
 	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -630,11 +630,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -652,7 +652,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 3),
@@ -674,12 +674,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_1, 0, 3),
 	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -697,7 +697,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_JMP32_IMM(BPF_JLE, BPF_REG_1, 0, 3),
@@ -720,11 +720,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	/* This used to reduce the max bound to 0x7fffffff */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0x7fffffff, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 0x7fffffff, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -741,9 +741,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_1, 1, 1),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_1, 1, 1),
 	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_1, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
index 3931c48..cea299f 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
@@ -2,7 +2,7 @@
 	"check deducing bounds from const, 1",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 0),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 1, 0),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
 	},
@@ -14,9 +14,9 @@
 	"check deducing bounds from const, 2",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
 		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 1, 1),
+		BPF_JMP64_IMM(BPF_JSLE, BPF_REG_0, 1, 1),
 		BPF_EXIT_INSN(),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
 		BPF_EXIT_INSN(),
@@ -30,7 +30,7 @@
 	"check deducing bounds from const, 3",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
 	},
@@ -43,9 +43,9 @@
 	.insns = {
 		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JSLE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_6, BPF_REG_0),
 		BPF_EXIT_INSN(),
@@ -58,7 +58,7 @@
 	"check deducing bounds from const, 5",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
 	},
@@ -70,7 +70,7 @@
 	"check deducing bounds from const, 6",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
@@ -83,7 +83,7 @@
 	"check deducing bounds from const, 7",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, ~0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 			    offsetof(struct __sk_buff, mark)),
@@ -98,7 +98,7 @@
 	"check deducing bounds from const, 8",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, ~0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 			    offsetof(struct __sk_buff, mark)),
@@ -113,7 +113,7 @@
 	"check deducing bounds from const, 9",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
 	},
@@ -125,7 +125,7 @@
 	"check deducing bounds from const, 10",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
 		/* Marks reg as unknown. */
 		BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0),
 		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
index 47b56b0ed..839e316 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
@@ -6,12 +6,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 4, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 4, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -29,12 +29,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -52,14 +52,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -77,13 +77,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -101,12 +101,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -123,12 +123,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
@@ -148,8 +148,8 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_6, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_4, 1, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_4, 1, 4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	BPF_ST_MEM(BPF_H, BPF_REG_10, -512, 0),
@@ -168,12 +168,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1024 * 1024 * 1024),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -190,14 +190,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -215,14 +215,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_LD_IMM64(BPF_REG_2, -9223372036854775808ULL),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -239,14 +239,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -264,15 +264,15 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
 	/* Dead branch. */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -290,14 +290,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -315,17 +315,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_7, 1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, 0, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_7, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, 4, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_7, 4, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_7),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -345,20 +345,20 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_8, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 42, 6),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_8, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_9, 42, 6),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_8, BPF_REG_1, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -7),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -7),
 	},
 	.fixup_map_hash_8b = { 4 },
 	.errstr = "unbounded min value",
@@ -372,15 +372,15 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_0, 1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
index 6c02db4..5c51c09 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -7,7 +7,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 28),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 28),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_9, sizeof(struct test_val)/2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
@@ -19,7 +19,7 @@
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 32),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_8, 16),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_1, BPF_REG_8, 16),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_8),
@@ -31,7 +31,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_5, sizeof(struct test_val)/2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_5),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 4),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_9),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
@@ -53,10 +53,10 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -66,7 +66,7 @@
 	BPF_MOV64_IMM(BPF_REG_3, 48),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_EMIT_CALL(BPF_FUNC_get_task_stack),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
index 31c71dc..ac62f40 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -38,9 +38,9 @@
 	 * subsequent bpf_loop insn processing steps
 	 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
 
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
@@ -71,9 +71,9 @@
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 9),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 0, 9),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 0),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0, 0),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 7),
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
@@ -82,7 +82,7 @@
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -10),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -10),
 	/* callback */
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -101,12 +101,12 @@
 	.insns = {
 	/* main */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
 
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 10),
 	BPF_RAW_INSN(0, 0, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 
 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 986bf68..4e0e559 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -13,7 +13,7 @@
 	"calls: invalid kfunc call unreachable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_0, 0, 2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -122,7 +122,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -143,7 +143,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
@@ -165,7 +165,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
@@ -190,15 +190,15 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 3),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_2, 4, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 3),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -225,7 +225,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -252,7 +252,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -307,7 +307,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -332,13 +332,13 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, data)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 42),
 	BPF_EXIT_INSN(),
 	},
@@ -356,20 +356,20 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, data)),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
 		    offsetof(struct __sk_buff, data)),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 64),
@@ -394,8 +394,8 @@
 {
 	"calls: wrong recursive calls",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 4),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -2),
@@ -446,7 +446,7 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -462,7 +462,7 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -479,14 +479,14 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -6),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -6),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -6),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
 	.errstr_unpriv = "back-edge from insn",
@@ -499,12 +499,12 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -5),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	},
@@ -516,12 +516,12 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -6),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	},
@@ -535,7 +535,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, -3),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
@@ -632,7 +632,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_8, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_8, BPF_REG_7, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_8, BPF_REG_7, 2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
 	/* clear_all_pkt_pointers() has to walk all frames
 	 * to make sure that pkt pointers in the caller
@@ -662,11 +662,11 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -740,10 +740,10 @@
 	"calls: calls control flow, jump test",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 43),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -754,9 +754,9 @@
 	"calls: calls control flow, jump test 2",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 43),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -3),
 	BPF_EXIT_INSN(),
 	},
@@ -779,7 +779,7 @@
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, len)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -856,7 +856,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -866,7 +866,7 @@
 {
 	"calls: jumping across function bodies. test2",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -884,7 +884,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.errstr = "not an exit",
@@ -1107,17 +1107,17 @@
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 6), /* call A */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 8), /* call B */
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_6, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_6, 0, 1),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -64, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* A */
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 10, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_1, 10, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -224, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -3),
 	/* B */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 1),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 2, 1),
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, -6), /* call A */
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -256, 0),
 	BPF_EXIT_INSN(),
@@ -1160,13 +1160,13 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* A */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
 	BPF_EXIT_INSN(),
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call B */
 	BPF_EXIT_INSN(),
 	/* B */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1217,7 +1217,7 @@
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 1), /* call A */
 	BPF_EXIT_INSN(),
 	/* A */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_RAW_INSN(BPF_JMP64|BPF_CALL, 0, 1, 0, 2), /* call B */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1333,7 +1333,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1355,12 +1355,12 @@
 
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	/* fetch secound map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -16),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1413,7 +1413,7 @@
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	/* first time with fp-8 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 9),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	/* write into map value */
@@ -1421,7 +1421,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	/* second time with fp-16 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch secound map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
 	/* write into map value */
@@ -1436,7 +1436,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(), /* return 0 */
 	/* write map_value_ptr into stack frame of main prog */
@@ -1467,7 +1467,7 @@
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	/* first time with fp-8 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 9),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
 	/* write into map value */
@@ -1475,7 +1475,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	/* second time with fp-16 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	/* fetch secound map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
 	/* write into map value */
@@ -1490,7 +1490,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(), /* return 0 */
 	/* write map_value_ptr into stack frame of main prog */
@@ -1525,9 +1525,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
@@ -1538,9 +1538,9 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, /* 24 */
 		     BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
@@ -1555,14 +1555,14 @@
 
 	/* subprog 2 */
 	/* if arg2 == 1 do *arg1 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 
 	/* if arg4 == 1 do *arg3 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_4, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	/* write into map value */
@@ -1597,9 +1597,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
@@ -1610,9 +1610,9 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, /* 24 */
 		     BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
@@ -1627,14 +1627,14 @@
 
 	/* subprog 2 */
 	/* if arg2 == 1 do *arg1 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 
 	/* if arg4 == 1 do *arg3 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_4, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	/* write into map value */
@@ -1654,7 +1654,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 
@@ -1667,9 +1667,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -24),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
@@ -1679,9 +1679,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -24),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),  // 26
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	/* write map_value_ptr into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
@@ -1691,24 +1691,24 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_9),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1), // 34
-	BPF_JMP_IMM(BPF_JA, 0, 0, -30),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1), // 34
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -30),
 
 	/* subprog 2 */
 	/* if arg2 == 1 do *arg1 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 
 	/* if arg4 == 1 do *arg3 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_4, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -8),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -8),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_hash_8b = { 12, 22 },
@@ -1740,9 +1740,9 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 
 	/* 2nd lookup from map */
@@ -1752,9 +1752,9 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 
 	/* call 3rd func with fp-8, 0|1, fp-16, 0|1 */
@@ -1767,14 +1767,14 @@
 
 	/* subprog 2 */
 	/* if arg2 == 1 do *arg1 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 
 	/* if arg4 == 1 do *arg3 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_4, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	/* write into map value */
@@ -1809,9 +1809,9 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-8 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 
 	/* 2nd lookup from map */
@@ -1821,9 +1821,9 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	/* write map_value_ptr_or_null into stack frame of main prog at fp-16 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 
 	/* call 3rd func with fp-8, 0|1, fp-16, 0|1 */
@@ -1836,14 +1836,14 @@
 
 	/* subprog 2 */
 	/* if arg2 == 1 do *arg1 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 1, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 
 	/* if arg4 == 0 do *arg3 = 0 */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_4, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_4, 0, 2),
 	/* fetch map_value_ptr from the stack of this function */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	/* write into map value */
@@ -1872,7 +1872,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	/* spill unchecked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	/* now the pkt range is verified, read pkt_ptr from stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_4, 0),
 	/* write 4 bytes into packet */
@@ -1904,7 +1904,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	/* spill unchecked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	/* now the pkt range is verified, read pkt_ptr from stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_4, 0),
 	/* write 4 bytes into packet */
@@ -1922,7 +1922,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* Marking is still kept and safe here. */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_ST_MEM(BPF_W, BPF_REG_4, 0, 0),
@@ -1938,7 +1938,7 @@
 	/* spill unchecked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
 	/* now the pkt range is verified, read pkt_ptr from stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_4, 0),
@@ -1958,7 +1958,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* Check marking propagated. */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_ST_MEM(BPF_W, BPF_REG_4, 0, 0),
@@ -1974,7 +1974,7 @@
 	/* spill unchecked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
 	/* don't read back pkt_ptr from stack here */
 	/* write 4 bytes into packet */
@@ -2006,7 +2006,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	/* spill checked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
@@ -2042,7 +2042,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	/* spill checked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
@@ -2077,7 +2077,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	/* spill checked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
@@ -2101,7 +2101,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
@@ -2119,7 +2119,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	/* spill checked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
@@ -2142,7 +2142,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
@@ -2162,7 +2162,7 @@
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	/* spill unchecked pkt_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_5, 1),
 	/* don't read back pkt_ptr from stack here */
 	/* write 4 bytes into packet */
@@ -2185,14 +2185,14 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	/* fetch map_value_or_null or const_zero from stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	/* store into map_value */
 	BPF_ST_MEM(BPF_W, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
 
 	/* subprog 1 */
 	/* if (ctx == 0) return; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 8),
 	/* else bpf_map_lookup() and *(fp - 8) = r0 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
@@ -2221,9 +2221,9 @@
 	 * that fp-8 stack slot was unused in the fall-through
 	 * branch and will accept the program incorrectly
 	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 2),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_1, 2, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -2240,7 +2240,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 5),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -2264,15 +2264,15 @@
 	 */
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
@@ -2285,19 +2285,19 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
@@ -2356,7 +2356,7 @@
 	 *                         ; only in 'insn_idx'
 	 * r9 = r8
 	 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
 	/* r9 = *r9                ; verifier get's to this point via two paths:
 	 *                         ; (I) one including r9 = r8, verified first;
@@ -2369,7 +2369,7 @@
 	 * if r9 == 0 goto <exit>
 	 */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
 	/* r8 = *r8                ; read map value via r8, this is not safe
 	 * r0 = *r8                ; because r8 might be not equal to r9.
 	 */
diff --git a/tools/testing/selftests/bpf/verifier/cfg.c b/tools/testing/selftests/bpf/verifier/cfg.c
index 4eb76ed..54f7b02 100644
--- a/tools/testing/selftests/bpf/verifier/cfg.c
+++ b/tools/testing/selftests/bpf/verifier/cfg.c
@@ -10,8 +10,8 @@
 {
 	"unreachable2",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unreachable",
@@ -20,7 +20,7 @@
 {
 	"out of range jump",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "jump out of range",
@@ -29,7 +29,7 @@
 {
 	"out of range jump2",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, -2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -2),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "jump out of range",
@@ -38,7 +38,7 @@
 {
 	"loop (back-edge)",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, -1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unreachable insn 1",
@@ -51,7 +51,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -4),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unreachable insn 4",
@@ -64,7 +64,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "infinite loop detected",
diff --git a/tools/testing/selftests/bpf/verifier/cgroup_skb.c b/tools/testing/selftests/bpf/verifier/cgroup_skb.c
index 52e4c03b..e2eb2bb 100644
--- a/tools/testing/selftests/bpf/verifier/cgroup_skb.c
+++ b/tools/testing/selftests/bpf/verifier/cgroup_skb.c
@@ -21,7 +21,7 @@
 		    offsetof(struct __sk_buff, vlan_present)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c b/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
index c6c6922..bcc73a7 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
@@ -134,7 +134,7 @@
 		    offsetof(struct sk_msg_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -151,7 +151,7 @@
 		    offsetof(struct sk_msg_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -168,10 +168,10 @@
 		    offsetof(struct sk_msg_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_2, 6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index fc55789..bde7240 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -3,28 +3,28 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, len)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, pkt_type)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, queue_mapping)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, protocol)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, vlan_present)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, vlan_tci)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, napi_id)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -41,13 +41,13 @@
 {
 	"access skb fields bad2",
 	.insns = {
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 9),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 9),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
@@ -62,7 +62,7 @@
 {
 	"access skb fields bad3",
 	.insns = {
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, pkt_type)),
 	BPF_EXIT_INSN(),
@@ -71,10 +71,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -12),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -12),
 	},
 	.fixup_map_hash_8b = { 6 },
 	.errstr = "different pointers",
@@ -84,7 +84,7 @@
 {
 	"access skb fields bad4",
 	.insns = {
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 3),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, len)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -94,10 +94,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -13),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -13),
 	},
 	.fixup_map_hash_8b = { 7 },
 	.errstr = "different pointers",
@@ -321,7 +321,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -338,7 +338,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -355,10 +355,10 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_2, 6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -907,12 +907,12 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[4])),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, tc_index)),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
@@ -1150,44 +1150,44 @@
 	.result = REJECT,
 },
 {
-       "pkt > pkt_end taken check",
-       .insns = {
-       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,                //  0. r2 = *(u32 *)(r1 + data_end)
-                   offsetof(struct __sk_buff, data_end)),
-       BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,                //  1. r4 = *(u32 *)(r1 + data)
-                   offsetof(struct __sk_buff, data)),
-       BPF_MOV64_REG(BPF_REG_3, BPF_REG_4),                    //  2. r3 = r4
-       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 42),                  //  3. r3 += 42
-       BPF_MOV64_IMM(BPF_REG_1, 0),                            //  4. r1 = 0
-       BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 2),          //  5. if r3 > r2 goto 8
-       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 14),                  //  6. r4 += 14
-       BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),                    //  7. r1 = r4
-       BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),          //  8. if r3 > r2 goto 10
-       BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1, 9),            //  9. r2 = *(u8 *)(r1 + 9)
-       BPF_MOV64_IMM(BPF_REG_0, 0),                            // 10. r0 = 0
-       BPF_EXIT_INSN(),                                        // 11. exit
-       },
-       .result = ACCEPT,
-       .prog_type = BPF_PROG_TYPE_SK_SKB,
-},
-{
-       "pkt_end < pkt taken check",
-       .insns = {
-       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,                //  0. r2 = *(u32 *)(r1 + data_end)
-                   offsetof(struct __sk_buff, data_end)),
-       BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,                //  1. r4 = *(u32 *)(r1 + data)
-                   offsetof(struct __sk_buff, data)),
-       BPF_MOV64_REG(BPF_REG_3, BPF_REG_4),                    //  2. r3 = r4
-       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 42),                  //  3. r3 += 42
-       BPF_MOV64_IMM(BPF_REG_1, 0),                            //  4. r1 = 0
-       BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 2),          //  5. if r3 > r2 goto 8
-       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 14),                  //  6. r4 += 14
-       BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),                    //  7. r1 = r4
-       BPF_JMP_REG(BPF_JLT, BPF_REG_2, BPF_REG_3, 1),          //  8. if r2 < r3 goto 10
-       BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1, 9),            //  9. r2 = *(u8 *)(r1 + 9)
-       BPF_MOV64_IMM(BPF_REG_0, 0),                            // 10. r0 = 0
-       BPF_EXIT_INSN(),                                        // 11. exit
-       },
-       .result = ACCEPT,
-       .prog_type = BPF_PROG_TYPE_SK_SKB,
+	"pkt > pkt_end taken check",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,                //  0. r2 = *(u32 *)(r1 + data_end)
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,                //  1. r4 = *(u32 *)(r1 + data)
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_4),                    //  2. r3 = r4
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 42),                  //  3. r3 += 42
+	BPF_MOV64_IMM(BPF_REG_1, 0),                            //  4. r1 = 0
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 2),        //  5. if r3 > r2 goto 8
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 14),                  //  6. r4 += 14
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),                    //  7. r1 = r4
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),        //  8. if r3 > r2 goto 10
+	BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1, 9),            //  9. r2 = *(u8 *)(r1 + 9)
+	BPF_MOV64_IMM(BPF_REG_0, 0),                            // 10. r0 = 0
+	BPF_EXIT_INSN(),                                        // 11. exit
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_SKB,
+},
+{
+	"pkt_end < pkt taken check",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,                //  0. r2 = *(u32 *)(r1 + data_end)
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,                //  1. r4 = *(u32 *)(r1 + data)
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_4),                    //  2. r3 = r4
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 42),                  //  3. r3 += 42
+	BPF_MOV64_IMM(BPF_REG_1, 0),                            //  4. r1 = 0
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 2),        //  5. if r3 > r2 goto 8
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 14),                  //  6. r4 += 14
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),                    //  7. r1 = r4
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_2, BPF_REG_3, 1),        //  8. if r2 < r3 goto 10
+	BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1, 9),            //  9. r2 = *(u8 *)(r1 + 9)
+	BPF_MOV64_IMM(BPF_REG_0, 0),                            // 10. r0 = 0
+	BPF_EXIT_INSN(),                                        // 11. exit
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_SKB,
 },
diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c b/tools/testing/selftests/bpf/verifier/dead_code.c
index 6cd9d1b..57d9d07 100644
--- a/tools/testing/selftests/bpf/verifier/dead_code.c
+++ b/tools/testing/selftests/bpf/verifier/dead_code.c
@@ -1,11 +1,11 @@
 {
 	"dead code: start",
 	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, -4),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, -4),
 	BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R9 !read_ok",
@@ -17,8 +17,8 @@
 	"dead code: mid 1",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, 0),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, 0),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -28,9 +28,9 @@
 	"dead code: mid 2",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 4),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 4),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 7),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -43,7 +43,7 @@
 	"dead code: end 1",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, 1),
 	BPF_EXIT_INSN(),
 	BPF_EXIT_INSN(),
 	},
@@ -54,7 +54,7 @@
 	"dead code: end 2",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 12),
 	BPF_EXIT_INSN(),
@@ -66,12 +66,12 @@
 	"dead code: end 3",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 8, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 10, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 12),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -5),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -5),
 	},
 	.result = ACCEPT,
 	.retval = 7,
@@ -80,7 +80,7 @@
 	"dead code: tail of main + func",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 8, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 8, 1),
 	BPF_EXIT_INSN(),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
@@ -96,7 +96,7 @@
 	"dead code: tail of main + two functions",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 8, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 8, 1),
 	BPF_EXIT_INSN(),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
@@ -119,7 +119,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 12),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 7),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 7, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 7, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -5),
 	BPF_EXIT_INSN(),
 	},
@@ -132,7 +132,7 @@
 	"dead code: middle of main before call",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 2, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 2, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
@@ -150,7 +150,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, 2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 	BPF_EXIT_INSN(),
 	},
@@ -164,7 +164,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
index 46bf9e6..609963b 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -21,7 +21,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -39,7 +39,7 @@
 		    offsetof(struct __sk_buff, data)),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 15),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 15),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_3, 12),
 	BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 14),
@@ -55,7 +55,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
 		    offsetof(struct __sk_buff, data_end)),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_3, 4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -84,7 +84,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -101,7 +101,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
@@ -120,7 +120,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -140,7 +140,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -161,8 +161,8 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -182,10 +182,10 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -203,7 +203,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
@@ -223,7 +223,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 144),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
@@ -248,7 +248,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 144),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
@@ -273,13 +273,13 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 13),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 13),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 14),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 24),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
@@ -304,7 +304,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
 	BPF_MOV64_IMM(BPF_REG_5, 12),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_5, 4),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
@@ -328,7 +328,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
 	BPF_MOV64_IMM(BPF_REG_5, 4096),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
@@ -354,7 +354,7 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -374,13 +374,13 @@
 		    offsetof(struct __sk_buff, mark)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 14),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 1, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_7, 1, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_A(-6),
+	BPF_JMP64_A(-6),
 	},
 	.errstr = "misaligned packet access off 2+(0x0; 0x0)+15+-4 size 4",
 	.result = REJECT,
@@ -396,7 +396,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_IMM(BPF_REG_0, 8),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -413,7 +413,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
 	BPF_MOV64_IMM(BPF_REG_4, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
 	BPF_STX_MEM(BPF_B, BPF_REG_4, BPF_REG_4, 0),
@@ -438,7 +438,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -456,7 +456,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
 	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
@@ -464,7 +464,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -485,7 +485,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_3, -16),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 11),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 11),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_4, -8),
@@ -494,7 +494,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_STX_MEM(BPF_H, BPF_REG_4, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -522,7 +522,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0xffff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -549,7 +549,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -567,11 +567,11 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -4),
 	},
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -585,11 +585,11 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 3),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -3),
 	},
 	.result = REJECT,
 	.errstr = "invalid access to packet",
@@ -604,7 +604,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -622,11 +622,11 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 2),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -4),
 	},
 	.result = REJECT,
 	.errstr = "invalid access to packet",
@@ -642,12 +642,12 @@
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -675,8 +675,8 @@
 	/* if r6 > 100 goto exit
 	 * if r7 > 100 goto exit
 	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 100, 9),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 100, 8),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_6, 100, 9),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_7, 100, 8),
 	/* r2 += r6              ; this forces assignment of ID to r2
 	 * r2 += 1               ; get some fixed off for r2
 	 * r3 += r7              ; this forces assignment of ID to r3
@@ -691,10 +691,10 @@
 	 *                       ; only in 'insn_idx'
 	 * r2 = r3               ; optionally share ID between r2 and r3
 	 */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
 	/* if r3 > ctx->data_end goto exit */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 1),
 	/* r5 = *(u8 *) (r2 - 1) ; access packet memory using r2,
 	 *                       ; this is not always safe
 	 */
diff --git a/tools/testing/selftests/bpf/verifier/div_overflow.c b/tools/testing/selftests/bpf/verifier/div_overflow.c
index acab4f0..96f5277 100644
--- a/tools/testing/selftests/bpf/verifier/div_overflow.c
+++ b/tools/testing/selftests/bpf/verifier/div_overflow.c
@@ -32,7 +32,7 @@
 	BPF_LD_IMM64(BPF_REG_2, LLONG_MIN),
 	BPF_ALU64_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
 	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -46,7 +46,7 @@
 	BPF_LD_IMM64(BPF_REG_1, LLONG_MIN),
 	BPF_ALU64_IMM(BPF_DIV, BPF_REG_1, -1),
 	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -85,7 +85,7 @@
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_ALU64_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
 	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -100,7 +100,7 @@
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_MOD, BPF_REG_2, -1),
 	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
 	BPF_MOV32_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 37be14d..7f665e8 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -17,7 +17,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -53,7 +53,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 65),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -80,9 +80,9 @@
 	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 64, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -108,9 +108,9 @@
 	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, 64, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -127,9 +127,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 5),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 64, 5),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 3),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
@@ -148,9 +148,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 65, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 65, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -169,7 +169,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -188,7 +188,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 64, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -206,7 +206,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, 64, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -224,14 +224,14 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val), 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val), 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -250,14 +250,14 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) + 1, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) + 1, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -276,15 +276,15 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 20),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 20, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 20, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -303,15 +303,15 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 20),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 19, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 19, 4),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -379,7 +379,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -400,9 +400,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 7),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 8, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
@@ -424,10 +424,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 8, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
@@ -447,10 +447,10 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 8, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
@@ -509,7 +509,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -528,9 +528,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 8, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -549,10 +549,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 2),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_2, 8, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/helper_packet_access.c b/tools/testing/selftests/bpf/verifier/helper_packet_access.c
index 926ef8d..a7ce6b9 100644
--- a/tools/testing/selftests/bpf/verifier/helper_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/helper_packet_access.c
@@ -6,7 +6,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
@@ -41,13 +41,13 @@
 			offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
 	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_5),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
@@ -66,7 +66,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -88,7 +88,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -108,7 +108,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
@@ -144,13 +144,13 @@
 			offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
 	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_5),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
@@ -170,7 +170,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -193,7 +193,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -214,7 +214,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_7, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_7, 4),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 42),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
@@ -235,7 +235,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
@@ -256,7 +256,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -279,7 +279,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 4),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -302,7 +302,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 12),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -326,7 +326,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -350,7 +350,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, -9),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -374,7 +374,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, ~0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -398,7 +398,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -421,7 +421,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -445,7 +445,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
diff --git a/tools/testing/selftests/bpf/verifier/helper_restricted.c b/tools/testing/selftests/bpf/verifier/helper_restricted.c
index 423556b..bf75880 100644
--- a/tools/testing/selftests/bpf/verifier/helper_restricted.c
+++ b/tools/testing/selftests/bpf/verifier/helper_restricted.c
@@ -50,7 +50,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
@@ -70,7 +70,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
@@ -90,7 +90,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
@@ -110,7 +110,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
@@ -130,7 +130,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
 	BPF_EXIT_INSN(),
@@ -148,7 +148,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
 	BPF_EXIT_INSN(),
@@ -166,7 +166,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
 	BPF_EXIT_INSN(),
@@ -184,7 +184,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/helper_value_access.c b/tools/testing/selftests/bpf/verifier/helper_value_access.c
index 1c7882d..a1e1ffb 100644
--- a/tools/testing/selftests/bpf/verifier/helper_value_access.c
+++ b/tools/testing/selftests/bpf/verifier/helper_value_access.c
@@ -6,7 +6,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -25,7 +25,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -44,7 +44,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
@@ -63,7 +63,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val) + 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -83,7 +83,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -103,7 +103,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2,
@@ -124,7 +124,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
@@ -144,7 +144,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -164,7 +164,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2,
@@ -186,7 +186,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
@@ -207,7 +207,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
@@ -228,7 +228,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -250,7 +250,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -271,7 +271,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -292,7 +292,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -316,7 +316,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -338,7 +338,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -360,10 +360,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) - offsetof(struct test_val, foo)),
@@ -383,10 +383,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
@@ -405,10 +405,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 3),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
@@ -427,7 +427,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -449,10 +449,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) -
@@ -474,10 +474,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -497,10 +497,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_3, 32, 4),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_3, 32, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -521,10 +521,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
@@ -544,10 +544,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_3, 32, 4),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_3, 32, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -568,13 +568,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 0, -3),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, 0, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -592,13 +592,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -616,13 +616,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -641,13 +641,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 0, -3),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, 0, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -665,13 +665,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -689,13 +689,13 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -714,7 +714,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
@@ -732,7 +732,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
@@ -752,7 +752,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
@@ -774,7 +774,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, offsetof(struct other_val, bar)),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -793,7 +793,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, sizeof(struct other_val) - 4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -813,7 +813,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -833,7 +833,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct other_val, bar)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
@@ -853,7 +853,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct other_val) - 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
@@ -874,7 +874,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, -4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
@@ -895,10 +895,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar), 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar), 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
@@ -916,7 +916,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
@@ -937,10 +937,10 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar) + 1, 4),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar) + 1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
index 67a1c07..0a4e3ee 100644
--- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -17,7 +17,7 @@
 	/* r6 = skb->sk; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
 	/* r7 = sk_fullsock(skb); */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
@@ -26,9 +26,9 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
 	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* if (r0 == r7) r0 = *(r7->type); */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
 	/* return 0 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -48,7 +48,7 @@
 	/* r6 = skb->sk */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
 	/* r7 = sk_fullsock(skb); */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
@@ -57,10 +57,10 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
 	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	/* if (r0 == r7) return 0; */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	/* r0 = *(r7->type); */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
 	/* return 0 */
@@ -80,7 +80,7 @@
 	/* r6 = skb->sk; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	/* if (r6 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
 	/* r7 = sk_fullsock(skb); */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
@@ -89,10 +89,10 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
 	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	/* if (r0 != r7) return 0; */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	/* r0 = *(r7->type); */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
 	/* return 0; */
@@ -113,7 +113,7 @@
 	/* r6 = skb->sk; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	/* if (r6 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
 	/* r7 = sk_fullsock(skb); */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
@@ -122,9 +122,9 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
 	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* if (r0 != r7) r0 = *(r7->type); */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
 	/* return 0; */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -159,9 +159,9 @@
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
 	/* if (r6 != r7) return 0; */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
 	/* read *r7; */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_xdp_sock, queue_id)),
 	/* return 0; */
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/selftests/bpf/verifier/jit.c
index 8bf37e5..2c6f883 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -5,14 +5,14 @@
 	BPF_MOV64_IMM(BPF_REG_1, 0xff),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 1),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 1),
 	BPF_ALU32_IMM(BPF_RSH, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
@@ -28,15 +28,15 @@
 	BPF_MOV64_IMM(BPF_REG_1, 0xff),
 	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
 	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_4),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_1),
 	BPF_ALU32_REG(BPF_RSH, BPF_REG_4, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0xff, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 0xff, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ARSH, BPF_REG_4, BPF_REG_4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
@@ -51,7 +51,7 @@
 	BPF_LD_IMM64(BPF_REG_1, 0xfeffffffffffffffULL),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
 	BPF_LD_IMM64(BPF_REG_2, 0xfeffffffULL),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
@@ -64,7 +64,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_LD_IMM64(BPF_REG_1, 0x1ffffffffULL),
 	BPF_LD_IMM64(BPF_REG_2, 0xffffffffULL),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
@@ -78,46 +78,46 @@
 	BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
 	BPF_LD_IMM64(BPF_REG_1, 0xefefefULL),
 	BPF_ALU64_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
 	BPF_ALU64_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
 	BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 0xefefef),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV32_REG(BPF_REG_2, BPF_REG_2),
 	BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
 	BPF_ALU32_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
 	BPF_ALU32_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
 	BPF_ALU32_IMM(BPF_MUL, BPF_REG_3, 0xefefef),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
 	BPF_LD_IMM64(BPF_REG_2, 0x2ad4d4aaULL),
 	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 0x2b),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_0, 0x952a7bbcULL),
 	BPF_LD_IMM64(BPF_REG_1, 0xfefefeULL),
 	BPF_LD_IMM64(BPF_REG_5, 0xeeff0d413122ULL),
 	BPF_ALU32_REG(BPF_MUL, BPF_REG_5, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_5, BPF_REG_0, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_5, BPF_REG_0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -133,38 +133,38 @@
 	BPF_LD_IMM64(BPF_REG_0, 0xeeff0d413122ULL),
 	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
 	BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_3, 0xeeff0d413122ULL),
 	BPF_ALU64_IMM(BPF_DIV, BPF_REG_3, 0xfefeeeULL),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_2, 0xaa93ULL),
 	BPF_ALU64_IMM(BPF_MOD, BPF_REG_1, 0xbeefULL),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
 	BPF_LD_IMM64(BPF_REG_3, 0xbeefULL),
 	BPF_ALU64_REG(BPF_MOD, BPF_REG_1, BPF_REG_3),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_2, 0x5ee1dULL),
 	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
 	BPF_LD_IMM64(BPF_REG_3, 0x2bULL),
 	BPF_ALU32_REG(BPF_DIV, BPF_REG_1, BPF_REG_3),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU32_REG(BPF_DIV, BPF_REG_1, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_MOD, BPF_REG_2, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_2, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -178,11 +178,11 @@
 	.insns = {
 	BPF_LD_IMM64(BPF_REG_1, 0x80000000ULL),
 	BPF_LD_IMM64(BPF_REG_2, 0x0ULL),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_2, 2),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_1, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 
-	BPF_JMP_REG(BPF_JSLT, BPF_REG_2, BPF_REG_1, 2),
+	BPF_JMP64_REG(BPF_JSLT, BPF_REG_2, BPF_REG_1, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 
diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index 59be762..d88c1b1 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -5,7 +5,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_2, 0),
 	/* reg, high bits shouldn't be tested */
 	BPF_JMP32_IMM(BPF_JSET, BPF_REG_7, -2, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_JMP32_IMM(BPF_JSET, BPF_REG_7, 1, 1),
@@ -36,7 +36,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_2, 0),
 	BPF_LD_IMM64(BPF_REG_8, 0x8000000000000000),
 	BPF_JMP32_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_LD_IMM64(BPF_REG_8, 0x8000000000000001),
@@ -67,7 +67,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_7, 0x8000000000000000),
 	BPF_LD_IMM64(BPF_REG_8, 0x8000000000000000),
-	BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+	BPF_JMP64_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -212,7 +212,7 @@
 	BPF_RAND_UEXT_R7,
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_JMP32_IMM(BPF_JNE, BPF_REG_7, 0x10, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x10, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0x10, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
@@ -352,7 +352,7 @@
 	BPF_LD_IMM64(BPF_REG_8, 0x7ffffff0 | 1ULL << 32),
 	BPF_JMP32_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 0x7ffffff0, 1),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_7, 0x7ffffff0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -492,7 +492,7 @@
 	BPF_LD_IMM64(BPF_REG_8, 0x7ffffff0 | 1ULL << 32),
 	BPF_JMP32_REG(BPF_JLT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0x7ffffff0, 1),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_7, 0x7ffffff0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -562,7 +562,7 @@
 	BPF_LD_IMM64(BPF_REG_8, 0x7ffffff0 | 1ULL << 32),
 	BPF_JMP32_REG(BPF_JSGE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0x7ffffff0, 1),
+	BPF_JMP64_IMM(BPF_JSGE, BPF_REG_7, 0x7ffffff0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -632,7 +632,7 @@
 	BPF_LD_IMM64(BPF_REG_8, (__u32)(-2) | 1ULL << 32),
 	BPF_JMP32_REG(BPF_JSGT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, -2, 1),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_7, -2, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -702,7 +702,7 @@
 	BPF_LD_IMM64(BPF_REG_8, 0x7ffffff0 | 1ULL << 32),
 	BPF_JMP32_REG(BPF_JSLE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_7, 0x7ffffff0, 1),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_7, 0x7ffffff0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -790,7 +790,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
@@ -817,7 +817,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
@@ -845,7 +845,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
@@ -873,7 +873,7 @@
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
 	BPF_ALU32_REG(BPF_OR, BPF_REG_2, BPF_REG_6),
 	BPF_JMP32_IMM(BPF_JNE, BPF_REG_2, 8, 5),
-	BPF_JMP_IMM(BPF_JSGE, BPF_REG_2, 500, 2),
+	BPF_JMP64_IMM(BPF_JSGE, BPF_REG_2, 500, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
diff --git a/tools/testing/selftests/bpf/verifier/jset.c b/tools/testing/selftests/bpf/verifier/jset.c
index feb1c01..49cbed5 100644
--- a/tools/testing/selftests/bpf/verifier/jset.c
+++ b/tools/testing/selftests/bpf/verifier/jset.c
@@ -6,21 +6,21 @@
 
 	/* reg, bit 63 or bit 0 set, taken */
 	BPF_LD_IMM64(BPF_REG_8, 0x8000000000000001),
-	BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+	BPF_JMP64_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 
 	/* reg, bit 62, not taken */
 	BPF_LD_IMM64(BPF_REG_8, 0x4000000000000000),
-	BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* imm, any bit set, taken */
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_7, -1, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_7, -1, 1),
 	BPF_EXIT_INSN(),
 
 	/* imm, bit 31 set, taken */
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
 	BPF_EXIT_INSN(),
 
 	/* all good - return r0 == 2 */
@@ -61,7 +61,7 @@
 	BPF_DIRECT_PKT_R2,
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_2, 0),
 
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_MOV64_IMM(BPF_REG_0, 2),
@@ -77,7 +77,7 @@
 	"jset: known const compare",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -91,7 +91,7 @@
 	"jset: known const compare bad",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -105,8 +105,8 @@
 	"jset: unknown const compare taken",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -120,7 +120,7 @@
 	"jset: unknown const compare not taken",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -135,7 +135,7 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_0, 2),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 3, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_0, 3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -152,13 +152,13 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xff),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0xf0, 3),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 0x10, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_1, 0xf0, 3),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_1, 0x10, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0x10, 1),
+	BPF_JMP64_IMM(BPF_JSET, BPF_REG_1, 0x10, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0x10, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0x10, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/jump.c b/tools/testing/selftests/bpf/verifier/jump.c
index f5c0866..f0baadd 100644
--- a/tools/testing/selftests/bpf/verifier/jump.c
+++ b/tools/testing/selftests/bpf/verifier/jump.c
@@ -3,17 +3,17 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -16, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 2, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 2, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -16, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 5, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 5, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -32, 5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -26,22 +26,22 @@
 	"jump test 2",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 14),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 14),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -16, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 11),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 2, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 2, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -32, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -40, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 5),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 4, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -48, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 5, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 5, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -56, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -54,27 +54,27 @@
 	"jump test 3",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 19),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 19),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 1, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -16, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 15),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 2, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 15),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 2, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -32, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -32),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 11),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 3, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -40, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -40),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 7),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 4, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -48, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -48),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 5, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 5, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, -56, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -56),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -90,46 +90,46 @@
 {
 	"jump test 4",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -142,35 +142,35 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -183,27 +183,27 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_1, 16),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -20),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_0, BPF_REG_1, 16),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -20),
 	},
 	.result = ACCEPT,
 	.retval = 2,
@@ -212,10 +212,10 @@
 	"jump test 7",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, 16),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 2, 16),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -232,7 +232,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -20),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -20),
 	},
 	.result = ACCEPT,
 	.retval = 3,
@@ -242,10 +242,10 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_1, 16),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_0, BPF_REG_1, 16),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -262,7 +262,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -20),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -20),
 	},
 	.result = ACCEPT,
 	.retval = 3,
@@ -271,10 +271,10 @@
 	"jump/call test 9",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, 16),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 2, 16),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -305,7 +305,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, 16),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 2, 16),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -339,7 +339,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, 26),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 2, 26),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -381,13 +381,13 @@
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_3, 0),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_3, 32767),
-	BPF_JMP_IMM(BPF_JSGE, BPF_REG_3, 0, 1),
+	BPF_JMP64_IMM(BPF_JSGE, BPF_REG_3, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 0x8000, 1),
+	BPF_JMP64_IMM(BPF_JSLE, BPF_REG_3, 0x8000, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -32767),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_3, 0, 1),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_3, 0, 1),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/ld_abs.c b/tools/testing/selftests/bpf/verifier/ld_abs.c
index 06e5ad0..298ca01 100644
--- a/tools/testing/selftests/bpf/verifier/ld_abs.c
+++ b/tools/testing/selftests/bpf/verifier/ld_abs.c
@@ -121,9 +121,9 @@
 	.insns = {
 		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 		BPF_LD_ABS(BPF_H, 12),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0x806, 28),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0x806, 28),
 		BPF_LD_ABS(BPF_H, 12),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0x806, 26),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0x806, 26),
 		BPF_MOV32_IMM(BPF_REG_0, 18),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -64),
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_10, -64),
@@ -134,9 +134,9 @@
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_10, -56),
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -60),
 		BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_7),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 15),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 15),
 		BPF_LD_ABS(BPF_H, 12),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0x806, 13),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0x806, 13),
 		BPF_MOV32_IMM(BPF_REG_0, 22),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -56),
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_10, -56),
@@ -147,7 +147,7 @@
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_10, -48),
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -52),
 		BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_7),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 		BPF_MOV32_IMM(BPF_REG_0, 256),
 		BPF_EXIT_INSN(),
 		BPF_MOV32_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index f929790..630c560 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -1,7 +1,7 @@
 {
 	"test1 ld_imm64",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 1),
@@ -16,7 +16,7 @@
 {
 	"test2 ld_imm64",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 1),
@@ -30,7 +30,7 @@
 {
 	"test3 ld_imm64",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/leak_ptr.c b/tools/testing/selftests/bpf/verifier/leak_ptr.c
index 892eb00..f3f0c8a 100644
--- a/tools/testing/selftests/bpf/verifier/leak_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/leak_ptr.c
@@ -53,7 +53,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_6, 0),
diff --git a/tools/testing/selftests/bpf/verifier/loops1.c b/tools/testing/selftests/bpf/verifier/loops1.c
index eb69c65..2a81e26 100644
--- a/tools/testing/selftests/bpf/verifier/loops1.c
+++ b/tools/testing/selftests/bpf/verifier/loops1.c
@@ -3,7 +3,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -15,7 +15,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 20, -2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 20, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -25,9 +25,9 @@
 	"bounded loop, count from positive unknown to 4",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -39,7 +39,7 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -50,7 +50,7 @@
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, -2),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 4, -2),
 		BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -60,9 +60,9 @@
 	"bounded loop, start in the middle",
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_A(1),
+		BPF_JMP64_A(1),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+		BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 		BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -75,8 +75,8 @@
 	.insns = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -3),
+		BPF_JMP64_REG(BPF_JEQ, BPF_REG_0, BPF_REG_0, 0),
+		BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -3),
 		BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -88,9 +88,9 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_6, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 10000, 2),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_6, 10000, 2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_A(-4),
+	BPF_JMP64_A(-4),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -100,9 +100,9 @@
 	"infinite loop after a conditional jump",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 5),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, 2),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, 2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_A(-2),
+	BPF_JMP64_A(-2),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -117,7 +117,7 @@
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 4, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_1, 4, 1),
 	BPF_EXIT_INSN(),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, -5),
 	BPF_EXIT_INSN(),
@@ -130,8 +130,8 @@
 	"infinite loop in two jumps",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_A(0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_JMP64_A(0),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -144,15 +144,15 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 2, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 2, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, -11),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_0, 2, -11),
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
@@ -163,7 +163,7 @@
 	"not-taken loop with back jump to 1st insn",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 123),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, -2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 4, -2),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -179,7 +179,7 @@
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, -3),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/lwt.c b/tools/testing/selftests/bpf/verifier/lwt.c
index 5c8944d..0978328 100644
--- a/tools/testing/selftests/bpf/verifier/lwt.c
+++ b/tools/testing/selftests/bpf/verifier/lwt.c
@@ -7,7 +7,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -25,7 +25,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -43,7 +43,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -60,7 +60,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -77,7 +77,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -94,7 +94,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -111,10 +111,10 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_2, 6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/map_in_map.c b/tools/testing/selftests/bpf/verifier/map_in_map.c
index 7e58a19..bf9d225 100644
--- a/tools/testing/selftests/bpf/verifier/map_in_map.c
+++ b/tools/testing/selftests/bpf/verifier/map_in_map.c
@@ -6,7 +6,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
@@ -27,21 +27,21 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -60,7 +60,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 2aca724..750c687 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -9,7 +9,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
@@ -29,7 +29,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_W, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
@@ -49,16 +49,16 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_2, 4, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
@@ -79,16 +79,16 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_2, 4, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_3),
@@ -111,7 +111,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 7),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
@@ -132,15 +132,15 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_2, 4, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
@@ -162,10 +162,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
@@ -186,7 +186,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
@@ -207,10 +207,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 32),
 	BPF_EXIT_INSN(),
@@ -230,10 +230,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
@@ -254,10 +254,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_EXIT_INSN(),
 	},
@@ -275,7 +275,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -298,7 +298,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -326,7 +326,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 8),
@@ -348,14 +348,14 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
@@ -379,7 +379,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
@@ -387,7 +387,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
@@ -413,7 +413,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 8),
@@ -434,7 +434,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 8, 0),
 	BPF_EXIT_INSN(),
@@ -454,7 +454,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
index 253d711..329eef0 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
@@ -2,16 +2,16 @@
 	"calls: two calls returning different map pointers for lookup (hash, array)",
 	.insns = {
 	/* main prog */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_CALL_REL(11),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_CALL_REL(12),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -32,16 +32,16 @@
 	"calls: two calls returning different map pointers for lookup (hash, map in map)",
 	.insns = {
 	/* main prog */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_CALL_REL(11),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_CALL_REL(12),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
@@ -63,9 +63,9 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 0, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 7),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -84,9 +84,9 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 7),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
diff --git a/tools/testing/selftests/bpf/verifier/map_ret_val.c b/tools/testing/selftests/bpf/verifier/map_ret_val.c
index 24078fe..81ae6fd 100644
--- a/tools/testing/selftests/bpf/verifier/map_ret_val.c
+++ b/tools/testing/selftests/bpf/verifier/map_ret_val.c
@@ -34,7 +34,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -51,7 +51,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
 	BPF_EXIT_INSN(),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
diff --git a/tools/testing/selftests/bpf/verifier/meta_access.c b/tools/testing/selftests/bpf/verifier/meta_access.c
index 54e5a0b..a175909 100644
--- a/tools/testing/selftests/bpf/verifier/meta_access.c
+++ b/tools/testing/selftests/bpf/verifier/meta_access.c
@@ -6,7 +6,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -24,7 +24,7 @@
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -42,7 +42,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -61,7 +61,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -78,7 +78,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_4, 3),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_4, 3),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_meta),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 0),
@@ -99,7 +99,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -118,7 +118,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -134,7 +134,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0xFFFF),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -151,7 +151,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0xFFFF),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -173,12 +173,12 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_5, 100, 6),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_5),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_5, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_5, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -198,12 +198,12 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
+	BPF_JMP64_IMM(BPF_JGT, BPF_REG_5, 100, 6),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_5),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_5, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -221,11 +221,11 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 5),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 5),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 0),
 	BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 0fdfa42..4247871 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -8,7 +8,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
@@ -17,14 +17,14 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -= map_value_ptr */
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_2, 8, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=scalar(umin=1, umax=8) */
@@ -68,7 +68,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
@@ -77,14 +77,14 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -= map_value_ptr */
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_2, 8, 1),
 	BPF_EXIT_INSN(),
 
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=scalar(umin=1, umax=8) */
@@ -120,19 +120,19 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_8, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_9, 1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
@@ -144,11 +144,11 @@
 	"precise: ST insn causing spi > allocated_stack",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
@@ -170,11 +170,11 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
@@ -200,10 +200,10 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_2, 0x1000),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 42),
diff --git a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c b/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
index cc66892..38389bb 100644
--- a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
+++ b/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
@@ -15,7 +15,7 @@
 			     BPF_FUNC_map_lookup_elem),
 
 		/* exit clean if null */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
 
 		/* shift the buffer pointer to a variable location */
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index f3cf02e..e8caeac 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -90,7 +90,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, -3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -111,7 +111,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -256,7 +256,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -268,7 +268,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(skc_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -280,7 +280,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -294,7 +294,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -310,7 +310,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3), /* goto end */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3), /* goto end */
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -330,15 +330,15 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 16),
 	/* if (offsetof(skb, mark) > data_len) exit; */
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1), /* mark == 0? */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 1), /* mark == 0? */
 	/* Leak reference in R0 */
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -358,17 +358,17 @@
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 16),
 	/* if (offsetof(skb, mark) > data_len) exit; */
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
 		    offsetof(struct __sk_buff, mark)),
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 4), /* mark == 0? */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 4), /* mark == 0? */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -388,7 +388,7 @@
 
 	/* subprog 1 */
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -408,7 +408,7 @@
 
 	/* subprog 1 */
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -444,7 +444,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 
@@ -504,7 +504,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_5, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	/* now the sk_ptr is verified, free the reference */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_4, 0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -523,7 +523,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_LD_ABS(BPF_B, 0),
 	BPF_LD_ABS(BPF_H, 0),
@@ -542,7 +542,7 @@
 	BPF_LD_ABS(BPF_H, 0),
 	BPF_LD_ABS(BPF_W, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -556,7 +556,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_MOV64_IMM(BPF_REG_7, 1),
 	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
@@ -577,7 +577,7 @@
 	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -592,7 +592,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 7),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 7),
 	/* bpf_tail_call() */
 	BPF_MOV64_IMM(BPF_REG_3, 3),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -614,7 +614,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	/* bpf_tail_call() */
 	BPF_MOV64_IMM(BPF_REG_3, 3),
@@ -643,7 +643,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -660,7 +660,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* if (!sk) goto end */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	/* bpf_tail_call() */
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
@@ -682,7 +682,7 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
 	},
@@ -695,7 +695,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -709,7 +709,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -723,7 +723,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_LD_IMM64(BPF_REG_2, 42),
 	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2,
@@ -742,7 +742,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -757,7 +757,7 @@
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
 	BPF_EXIT_INSN(),
@@ -776,14 +776,14 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 64),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
 	/* sk = sk_lookup_tcp(ctx, skb->data, ...) */
 	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct bpf_sock_tuple)),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -796,12 +796,12 @@
 	"reference tracking: use ptr from bpf_tcp_sock() after release",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -820,12 +820,12 @@
 	"reference tracking: use ptr from bpf_sk_fullsock() after release",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -844,12 +844,12 @@
 	"reference tracking: use ptr from bpf_sk_fullsock(tp) after release",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -858,7 +858,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, offsetof(struct bpf_sock, type)),
 	BPF_EXIT_INSN(),
@@ -872,12 +872,12 @@
 	"reference tracking: use sk after bpf_sk_release(tp)",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -895,12 +895,12 @@
 	"reference tracking: use ptr from bpf_get_listener_sock() after bpf_sk_release(sk)",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_listener_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -917,12 +917,12 @@
 	"reference tracking: bpf_sk_release(listen_sk)",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_listener_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -942,7 +942,7 @@
 	"reference tracking: tp->snd_cwnd after bpf_sk_fullsock(sk) and bpf_tcp_sock(sk)",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -951,7 +951,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_7, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -970,9 +970,9 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -986,9 +986,9 @@
 	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 1234, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 1234, 2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -1001,12 +1001,12 @@
 	"reference tracking: bpf_sk_release(btf_tcp_sock)",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -1023,12 +1023,12 @@
 	"reference tracking: use ptr from bpf_skc_to_tcp_sock() after release",
 	.insns = {
 	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_EXIT_INSN(),
@@ -1053,7 +1053,7 @@
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
 
@@ -1062,7 +1062,7 @@
 		BPF_MOV64_IMM(BPF_REG_2, 8),
 		BPF_MOV64_IMM(BPF_REG_3, 0),
 		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 		BPF_EXIT_INSN(),
 		BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 
diff --git a/tools/testing/selftests/bpf/verifier/regalloc.c b/tools/testing/selftests/bpf/verifier/regalloc.c
index ead6db9..2b1d572 100644
--- a/tools/testing/selftests/bpf/verifier/regalloc.c
+++ b/tools/testing/selftests/bpf/verifier/regalloc.c
@@ -7,12 +7,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 20, 4),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -32,12 +32,12 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 24, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 24, 4),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
@@ -57,13 +57,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 5),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 20, 5),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -83,13 +83,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 22, 5),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 22, 5),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -110,17 +110,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 7),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 20, 7),
 	/* r0 has upper bound that should propagate into r2 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8), /* spill r2 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 0), /* clear r0 and r2 */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 */
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
 	/* r3 has lower and upper bounds */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -140,17 +140,17 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 48, 7),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 48, 7),
 	/* r0 has upper bound that should propagate into r2 */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8), /* spill r2 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 0), /* clear r0 and r2 */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 */
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
 	/* r3 has lower and upper bounds */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -171,13 +171,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 12, 5),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_0, 12, 5),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_4),
@@ -198,14 +198,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 6),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 20, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_9, 0, 3),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_8, 20, 4),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_9, 0, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_8),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
@@ -227,7 +227,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -235,8 +235,8 @@
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 20, 5),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
+	BPF_JMP64_IMM(BPF_JSGT, BPF_REG_1, 20, 5),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
@@ -259,14 +259,14 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8), /* spill r0 */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 0),
 	/* The verifier will walk the rest twice with r0 == 0 and r0 == map_value */
 	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 20, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_2, 20, 0),
 	/* The verifier will walk the rest two more times with r0 == 20 and r0 == unknown */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 with map_value */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 1), /* skip ldx if map_value == NULL */
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_3, 0, 1), /* skip ldx if map_value == NULL */
 	/* Buggy verifier will think that r3 == 20 here */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0), /* read from map_value */
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
index d288253..a2738c2 100644
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
@@ -10,7 +10,7 @@
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	/* spill R6(mem) into the stack */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
 	/* fill it back in R7 */
@@ -42,7 +42,7 @@
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	/* spill R6(mem) into the stack */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
 	/* fill it back in R7 */
@@ -74,7 +74,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	/* pass allocated ring buffer memory to fib lookup */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
diff --git a/tools/testing/selftests/bpf/verifier/runtime_jit.c b/tools/testing/selftests/bpf/verifier/runtime_jit.c
index 160911b..9944e90 100644
--- a/tools/testing/selftests/bpf/verifier/runtime_jit.c
+++ b/tools/testing/selftests/bpf/verifier/runtime_jit.c
@@ -58,10 +58,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -80,10 +80,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -102,10 +102,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -124,10 +124,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -146,10 +146,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
@@ -171,10 +171,10 @@
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index 1a4d06b..967ceeb 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -6,11 +6,11 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(1),
+	BPF_JMP64_A(1),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
-	BPF_JMP_A(0),
+	BPF_JMP64_A(0),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -27,9 +27,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
-	BPF_JMP_A(1),
+	BPF_JMP64_A(1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -45,9 +45,9 @@
 	/* Get an unknown value */
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
 	/* branch conditions teach us nothing about R2 */
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_2, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -63,14 +63,14 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
 	BPF_MOV32_IMM(BPF_REG_1, 0),
 	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
 	BPF_EXIT_INSN(),
 	},
@@ -89,16 +89,16 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
 		BPF_MOV64_IMM(BPF_REG_4, 0),
-		BPF_JMP_A(1),
+		BPF_JMP64_A(1),
 		BPF_MOV64_IMM(BPF_REG_4, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -16),
 		BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -16),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_5, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_5, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_6, 0),
 		BPF_ST_MEM(BPF_DW, BPF_REG_6, 0, 0xdead),
 		BPF_EXIT_INSN(),
@@ -116,12 +116,12 @@
 		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
 		BPF_MOV64_IMM(BPF_REG_4, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -16),
-		BPF_JMP_A(1),
+		BPF_JMP64_A(1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -24),
 		BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -16),
@@ -138,13 +138,13 @@
 		BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
 		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 		BPF_MOV32_IMM(BPF_REG_6, 32),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_MOV32_IMM(BPF_REG_6, 4),
 		/* Additional insns to introduce a pruning point. */
 		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
 		BPF_MOV64_IMM(BPF_REG_3, 0),
 		BPF_MOV64_IMM(BPF_REG_3, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_MOV64_IMM(BPF_REG_3, 0),
 		/* u32 spill/fill */
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -8),
@@ -155,7 +155,7 @@
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -178,7 +178,7 @@
 		BPF_MOV64_IMM(BPF_REG_3, 1),
 		BPF_MOV64_IMM(BPF_REG_3, 1),
 		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 		BPF_MOV64_IMM(BPF_REG_3, 1),
 		BPF_ALU32_IMM(BPF_DIV, BPF_REG_3, 0),
 		/* u32 spills, u64 fill */
@@ -186,14 +186,14 @@
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, -8),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, -8),
 		/* if r8 != X goto pc+1  r8 known in fallthrough branch */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_8, 0xffffffff, 1),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_8, 0xffffffff, 1),
 		BPF_MOV64_IMM(BPF_REG_3, 1),
 		/* if r8 == X goto pc+1  condition always true on first
 		 * traversal, so starts backtracking to mark r8 as requiring
 		 * precision. r7 marked as needing precision. r6 not marked
 		 * since it's not tracked.
 		 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 0xffffffff, 1),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_8, 0xffffffff, 1),
 		/* fails if r8 correctly marked unknown after fill. */
 		BPF_ALU32_IMM(BPF_DIV, BPF_REG_3, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -209,16 +209,16 @@
 		BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
 		BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 		BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+		BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, -8),
 		BPF_STX_MEM(BPF_B, BPF_REG_10, BPF_REG_7, -9),
 		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_10, -9),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 0),
+		BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 0),
 		BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index d11d0b2..9f89ade 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -14,7 +14,7 @@
 	"skb->sk: sk->family [non fullsock field]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, offsetof(struct bpf_sock, family)),
@@ -28,7 +28,7 @@
 	"skb->sk: sk->type [fullsock field]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, offsetof(struct bpf_sock, type)),
@@ -55,7 +55,7 @@
 	"sk_fullsock(skb->sk): no NULL check on ret",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
@@ -71,11 +71,11 @@
 	"sk_fullsock(skb->sk): sk->type [fullsock field]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
@@ -89,11 +89,11 @@
 	"sk_fullsock(skb->sk): sk->family [non fullsock field]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, family)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -106,11 +106,11 @@
 	"sk_fullsock(skb->sk): sk->state [narrow load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, state)),
@@ -124,11 +124,11 @@
 	"sk_fullsock(skb->sk): sk->dst_port [word load] (backward compatibility)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
@@ -142,11 +142,11 @@
 	"sk_fullsock(skb->sk): sk->dst_port [half load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
@@ -160,11 +160,11 @@
 	"sk_fullsock(skb->sk): sk->dst_port [half load] (invalid)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
@@ -179,11 +179,11 @@
 	"sk_fullsock(skb->sk): sk->dst_port [byte load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
@@ -198,11 +198,11 @@
 	"sk_fullsock(skb->sk): sk->dst_port [byte load] (invalid)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
@@ -217,11 +217,11 @@
 	"sk_fullsock(skb->sk): past sk->dst_port [half load] (invalid)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_sock, dst_port)),
@@ -236,11 +236,11 @@
 	"sk_fullsock(skb->sk): sk->dst_ip6 [load 2nd byte]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_ip6[0]) + 1),
@@ -254,11 +254,11 @@
 	"sk_fullsock(skb->sk): sk->type [narrow load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
@@ -272,11 +272,11 @@
 	"sk_fullsock(skb->sk): sk->protocol [narrow load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, protocol)),
@@ -290,11 +290,11 @@
 	"sk_fullsock(skb->sk): beyond last field",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_sock, rx_queue_mapping)),
@@ -321,7 +321,7 @@
 	"bpf_tcp_sock(skb->sk): no NULL check on ret",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
@@ -337,11 +337,11 @@
 	"bpf_tcp_sock(skb->sk): tp->snd_cwnd",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, snd_cwnd)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -354,11 +354,11 @@
 	"bpf_tcp_sock(skb->sk): tp->bytes_acked",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, bytes_acked)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -371,11 +371,11 @@
 	"bpf_tcp_sock(skb->sk): beyond last field",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_tcp_sock, bytes_acked)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -389,15 +389,15 @@
 	"bpf_tcp_sock(bpf_sk_fullsock(skb->sk)): tp->snd_cwnd",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, snd_cwnd)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -410,7 +410,7 @@
 	"bpf_sk_release(skb->sk)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -423,11 +423,11 @@
 	"bpf_sk_release(bpf_sk_fullsock(skb->sk))",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -442,11 +442,11 @@
 	"bpf_sk_release(bpf_tcp_sock(skb->sk))",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -461,11 +461,11 @@
 	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
@@ -484,11 +484,11 @@
 	"sk_storage_get(map, skb->sk, 1, 1): value == 1",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_4, 1),
@@ -510,11 +510,11 @@
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_4, 1),
@@ -536,11 +536,11 @@
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_4, 1),
@@ -581,7 +581,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_xdp_sock, queue_id)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -631,7 +631,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
@@ -650,7 +650,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
@@ -710,7 +710,7 @@
 	"mark null check on return value of bpf_skc_to helpers",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
@@ -719,7 +719,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_request_sock),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_8, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_8, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 5b8d764..0c47475 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -40,7 +40,7 @@
 	/* store a pointer to the reserved memory in R6 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	/* spill R6(mem) into the stack */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
 	/* fill it back in R7 */
@@ -72,7 +72,7 @@
 	/* add invalid offset to memory or NULL */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
 	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	/* should not be able to access *(R7) = 0 */
 	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0),
 	/* submit the reserved ringbuf memory */
@@ -150,7 +150,7 @@
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r2 R0=pkt,off=20,r=20 R2=pkt,r=20 R3=pkt_end R4=20 */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -193,7 +193,7 @@
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -225,7 +225,7 @@
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -253,7 +253,7 @@
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -283,7 +283,7 @@
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=U32_MAX */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 	/* if (r0 > r3) R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r2 R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -302,7 +302,7 @@
 		    offsetof(struct __sk_buff, data_end)),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1,
 		    offsetof(struct __sk_buff, tstamp)),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_4, 40, 2),
+	BPF_JMP64_IMM(BPF_JLE, BPF_REG_4, 40, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* *(u32 *)(r10 -8) = r4 R4=umax=40 */
@@ -316,7 +316,7 @@
 	/* r2 += 20 R0=pkt,umax=40 R2=pkt,umax=40 */
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 20),
 	/* if (r2 > r3) R0=pkt,umax=40 R2=pkt,off=20,umax=40 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
 	/* r0 = *(u32 *)r0 R0=pkt,r=20,umax=40 R2=pkt,off=20,r=20,umax=40 */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
index 8f24b17..016786e 100644
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
@@ -7,7 +7,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -35,7 +35,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -64,7 +64,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -94,7 +94,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -124,7 +124,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -153,7 +153,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -162,7 +162,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -183,12 +183,12 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
@@ -213,7 +213,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -245,7 +245,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
@@ -253,7 +253,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
@@ -281,7 +281,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -313,7 +313,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -342,21 +342,21 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
@@ -396,7 +396,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 24),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 24),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
 	/* r8 = map_lookup_elem(...) */
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
@@ -404,7 +404,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1,
 		      0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 18),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 18),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	/* r7 = ktime_get_ns() */
 	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
@@ -419,12 +419,12 @@
 	 * r9 = r8
 	 * goto unlock
 	 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 5),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
 	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
-	BPF_JMP_A(3),
+	BPF_JMP64_A(3),
 	/* spin_lock(r9) */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
diff --git a/tools/testing/selftests/bpf/verifier/stack_ptr.c b/tools/testing/selftests/bpf/verifier/stack_ptr.c
index 8ab94d6..fac4daa 100644
--- a/tools/testing/selftests/bpf/verifier/stack_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/stack_ptr.c
@@ -302,7 +302,7 @@
 	"stack pointer arithmetic",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -10),
@@ -326,7 +326,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -346,7 +346,7 @@
 	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_9, 0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_1, 0),
 	/* Should read back as same value. */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_2, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
diff --git a/tools/testing/selftests/bpf/verifier/uninit.c b/tools/testing/selftests/bpf/verifier/uninit.c
index 987a587..bde33e4 100644
--- a/tools/testing/selftests/bpf/verifier/uninit.c
+++ b/tools/testing/selftests/bpf/verifier/uninit.c
@@ -28,7 +28,7 @@
 {
 	"program doesn't init R0 before exit in all branches",
 	.insns = {
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index e035e92..d14b292 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -42,7 +42,7 @@
 {
 	"unpriv: cmp pointer with const",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -53,7 +53,7 @@
 {
 	"unpriv: cmp pointer with pointer",
 	.insns = {
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
+	BPF_JMP64_REG(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -223,11 +223,11 @@
 	BPF_MOV64_IMM(BPF_REG_3, 42),
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
 	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
@@ -252,10 +252,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	/* if (skb == NULL) *target = sock; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
 	/* else *target = skb; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	/* struct __sk_buff *skb = *target; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
@@ -264,7 +264,7 @@
 	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
 		    offsetof(struct __sk_buff, mark)),
 	/* if (sk) bpf_sk_release(sk) */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 		BPF_EMIT_CALL(BPF_FUNC_sk_release),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -286,10 +286,10 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	/* if (skb == NULL) *target = sock; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
 	/* else *target = skb; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	/* struct __sk_buff *skb = *target; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
@@ -317,15 +317,15 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	/* if (skb) *target = skb */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	/* else *target = sock */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
 	/* struct bpf_sock *sk = *target; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
 	/* if (sk) u32 foo = sk->mark; bpf_sk_release(sk); */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
 		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
 			    offsetof(struct bpf_sock, mark)),
 		BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -349,15 +349,15 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	/* if (skb) *target = skb */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	/* else *target = sock */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
 	/* struct bpf_sock *sk = *target; */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
 	/* if (sk) sk->mark = 42; bpf_sk_release(sk); */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 		BPF_MOV64_IMM(BPF_REG_3, 42),
 		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
 			    offsetof(struct bpf_sock, mark)),
@@ -375,13 +375,13 @@
 	.insns = {
 	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
 		      -(__s32)offsetof(struct bpf_perf_event_data,
 				       sample_period) - 8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1,
@@ -401,7 +401,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -416,7 +416,7 @@
 	BPF_MOV32_IMM(BPF_REG_7, 0),
 	BPF_ALU32_IMM(BPF_AND, BPF_REG_7, 1),
 	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -455,7 +455,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -490,7 +490,7 @@
 {
 	"unpriv: cmp of frame pointer",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_10, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_10, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -529,7 +529,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 0),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_2, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/value.c b/tools/testing/selftests/bpf/verifier/value.c
index 0e42592b..4e9e41d 100644
--- a/tools/testing/selftests/bpf/verifier/value.c
+++ b/tools/testing/selftests/bpf/verifier/value.c
@@ -6,7 +6,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -24,7 +24,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 17),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 2, 43),
@@ -58,9 +58,9 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 9),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 9),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 2),
@@ -86,7 +86,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, offsetof(struct test_val, foo)),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
diff --git a/tools/testing/selftests/bpf/verifier/value_adj_spill.c b/tools/testing/selftests/bpf/verifier/value_adj_spill.c
index 7135e80..32576ac 100644
--- a/tools/testing/selftests/bpf/verifier/value_adj_spill.c
+++ b/tools/testing/selftests/bpf/verifier/value_adj_spill.c
@@ -6,7 +6,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -184),
@@ -31,7 +31,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -152),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_3, 0, 42),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c b/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
index d6f29eb..0dc9c99 100644
--- a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
@@ -6,7 +6,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
 	BPF_EXIT_INSN(),
@@ -23,7 +23,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
 	BPF_EXIT_INSN(),
@@ -40,7 +40,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_DIV, BPF_REG_0, 42),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
 	BPF_EXIT_INSN(),
@@ -57,7 +57,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ENDIAN(BPF_FROM_BE, BPF_REG_0, 64),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
 	BPF_EXIT_INSN(),
@@ -77,7 +77,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_IMM(BPF_REG_3, 4096),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
diff --git a/tools/testing/selftests/bpf/verifier/value_or_null.c b/tools/testing/selftests/bpf/verifier/value_or_null.c
index 1ea97759..6013cee 100644
--- a/tools/testing/selftests/bpf/verifier/value_or_null.c
+++ b/tools/testing/selftests/bpf/verifier/value_or_null.c
@@ -8,7 +8,7 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -28,7 +28,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -48,7 +48,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, -1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -68,7 +68,7 @@
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -92,7 +92,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -113,12 +113,12 @@
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_IMM(BPF_REG_2, 10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0, 3),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -134,9 +134,9 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES-1, 1),
+	BPF_JMP64_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES-1, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -160,8 +160,8 @@
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_6, 0, 1),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_10, 10),
 	BPF_EXIT_INSN(),
 	},
@@ -198,10 +198,10 @@
 	 *                       ; only in 'insn_idx'
 	 * r9 = r8               ; optionally share ID between r9 and r8
 	 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
 	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
 	/* if r9 == 0 goto <exit> */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
 	/* read map value via r8, this is not always
 	 * safe because r8 might be not equal to r9.
 	 */
diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
index af7a406..5ce7066 100644
--- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
@@ -6,18 +6,18 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 3),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -39,16 +39,16 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
 	BPF_MOV64_IMM(BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
@@ -72,16 +72,16 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
 	BPF_MOV64_IMM(BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -103,16 +103,16 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -132,18 +132,18 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
@@ -165,18 +165,18 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
@@ -200,18 +200,18 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x3),
@@ -235,12 +235,12 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -260,12 +260,12 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -288,12 +288,12 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 1, 2),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -315,29 +315,29 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	// load some number from the map into r1
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 3),
 	// branch A
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_A(2),
+	BPF_JMP64_A(2),
 	// branch B
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
 	// common instruction
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
 	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	// branch A
-	BPF_JMP_A(4),
+	BPF_JMP64_A(4),
 	// branch B
 	BPF_MOV64_IMM(BPF_REG_0, 0x13371337),
 	// verifier follows fall-through
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	// fake-dead code; targeted from branch A to
@@ -362,29 +362,29 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	// load some number from the map into r1
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	// branch A
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
-	BPF_JMP_A(2),
+	BPF_JMP64_A(2),
 	// branch B
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	// common instruction
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
 	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_1, 0, 1),
 	// branch A
-	BPF_JMP_A(4),
+	BPF_JMP64_A(4),
 	// branch B
 	BPF_MOV64_IMM(BPF_REG_0, 0x13371337),
 	// verifier follows fall-through
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	// fake-dead code; targeted from branch A to
@@ -409,13 +409,13 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
-	BPF_JMP_A(2),
+	BPF_JMP64_A(2),
 	BPF_MOV64_IMM(BPF_REG_2, 42),
 	BPF_MOV64_IMM(BPF_REG_3, 0x100001),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
@@ -476,7 +476,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 48),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -498,7 +498,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 49),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -520,7 +520,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -540,7 +540,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 48),
@@ -563,7 +563,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 48),
@@ -588,7 +588,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 47),
@@ -609,7 +609,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -628,7 +628,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -647,7 +647,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 49),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -666,7 +666,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, -1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -685,7 +685,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_MOV64_IMM(BPF_REG_1, 5),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, -2),
@@ -708,7 +708,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, (6 + 1) * sizeof(int)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
@@ -726,7 +726,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, (3 + 1) * sizeof(int)),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 3 * sizeof(int)),
@@ -746,7 +746,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV32_IMM(BPF_REG_1, 0x12345678),
 	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
@@ -767,7 +767,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -787,7 +787,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
@@ -807,7 +807,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_MOV64_IMM(BPF_REG_1, -1),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
@@ -833,7 +833,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_1, 19),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
@@ -856,7 +856,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -876,7 +876,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -896,20 +896,20 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 16),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 1),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_3, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 4),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_3),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, -3),
 	},
 	.fixup_map_array_48b = { 3 },
 	.result = ACCEPT,
@@ -923,7 +923,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -941,7 +941,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
@@ -960,7 +960,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_1, 4),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
@@ -979,7 +979,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_IMM(BPF_REG_1, 6),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
@@ -1000,7 +1000,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
@@ -1020,7 +1020,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
@@ -1040,7 +1040,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_1, 0x7),
@@ -1066,7 +1066,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_JMP64_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_0),
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -1086,7 +1086,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_MOV32_IMM(BPF_REG_1, 0xFFFFFFFF),
@@ -1109,7 +1109,7 @@
 		    offsetof(struct __sk_buff, data)),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
 	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_7),
 	BPF_ALU32_REG(BPF_SUB, BPF_REG_6, BPF_REG_4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -1128,7 +1128,7 @@
 		    offsetof(struct __sk_buff, data)),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
 	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_6),
 	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 769b20f..97d7664 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -146,7 +146,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
 							   bytes_received)),
 	/* Check the lower bound but don't check the upper one. */
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_4, 0, 4),
+	BPF_JMP64_IMM(BPF_JSLT, BPF_REG_4, 0, 4),
 	/* Point the lower bound to initialized stack. Offset is now in range
 	 * from fp-16 to fp+0x7fffffffffffffef, i.e. max value is unbounded.
 	 */
diff --git a/tools/testing/selftests/bpf/verifier/xadd.c b/tools/testing/selftests/bpf/verifier/xadd.c
index 8ce0171..7c7a4f4 100644
--- a/tools/testing/selftests/bpf/verifier/xadd.c
+++ b/tools/testing/selftests/bpf/verifier/xadd.c
@@ -19,7 +19,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP64 | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_JMP64_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
 	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 3),
@@ -39,9 +39,9 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 2),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 99),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 6),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 6),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 3, 0),
@@ -64,8 +64,8 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
 	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
@@ -84,8 +84,8 @@
 	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -8),
 	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
 	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
+	BPF_JMP64_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 42),
diff --git a/tools/testing/selftests/bpf/verifier/xdp.c b/tools/testing/selftests/bpf/verifier/xdp.c
index 5ac3905..8d83b90 100644
--- a/tools/testing/selftests/bpf/verifier/xdp.c
+++ b/tools/testing/selftests/bpf/verifier/xdp.c
@@ -4,7 +4,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
 		    offsetof(struct xdp_md, ingress_ifindex)),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 1, 1),
+	BPF_JMP64_IMM(BPF_JLT, BPF_REG_2, 1, 1),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c b/tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c
index b4ec228..404cc8b 100644
--- a/tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c
@@ -7,7 +7,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -25,7 +25,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_3, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -42,7 +42,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -59,7 +59,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -77,7 +77,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 0),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -95,7 +95,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -112,7 +112,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -130,8 +130,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -148,8 +148,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -167,7 +167,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -185,8 +185,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -203,8 +203,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -221,8 +221,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -239,8 +239,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -258,7 +258,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -276,8 +276,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -294,8 +294,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -312,7 +312,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -329,7 +329,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -347,7 +347,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 0),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -365,7 +365,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -382,7 +382,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -400,7 +400,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -417,7 +417,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -435,7 +435,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 0),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -453,7 +453,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -470,7 +470,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -487,8 +487,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -505,8 +505,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -524,7 +524,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -542,8 +542,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -560,8 +560,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -579,8 +579,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -597,8 +597,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -616,7 +616,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -634,8 +634,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -652,8 +652,8 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -671,7 +671,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -688,7 +688,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -706,7 +706,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 0),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -724,7 +724,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -741,7 +741,7 @@
 		    offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -758,7 +758,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -775,7 +775,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -793,7 +793,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 0),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -811,7 +811,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -828,7 +828,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -846,8 +846,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -864,8 +864,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -883,7 +883,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -901,8 +901,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -919,8 +919,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -937,8 +937,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -955,8 +955,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -974,7 +974,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -992,8 +992,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1010,8 +1010,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1028,7 +1028,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1045,7 +1045,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1063,7 +1063,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 0),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1081,7 +1081,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1098,7 +1098,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLT, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1116,7 +1116,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1133,7 +1133,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1151,7 +1151,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 0),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1169,7 +1169,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1186,7 +1186,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1203,8 +1203,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1221,8 +1221,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1240,7 +1240,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1258,8 +1258,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1276,8 +1276,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1295,8 +1295,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1313,8 +1313,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -4),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1332,7 +1332,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1350,8 +1350,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 9),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -9),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1368,8 +1368,8 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_1, BPF_REG_3, 1),
+	BPF_JMP64_IMM(BPF_JA, 0, 0, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1387,7 +1387,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1404,7 +1404,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -6),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1422,7 +1422,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 0),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 0),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, -5),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1440,7 +1440,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -7),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -1457,7 +1457,7 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
+	BPF_JMP64_REG(BPF_JLE, BPF_REG_3, BPF_REG_1, 1),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-- 
2.1.0

