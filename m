Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1913D655A05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiLXLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiLXLnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:43:47 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CA88DFAD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:43:44 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXXpbf5aZj9dVkCA--.18955S9;
        Sat, 24 Dec 2022 19:43:28 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v5 5/9] riscv/kprobe: Search free register(s) to clobber for 'AUIPC/JALR'
Date:   Sat, 24 Dec 2022 19:43:11 +0800
Message-Id: <20221224114315.850130-6-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXXpbf5aZj9dVkCA--.18955S9
X-Coremail-Antispam: 1UD129KBjvJXoWfJry3uryfWFy5Kr1kJryxXwb_yoWDAr15pF
        ZxGw4rtF4Utrs5W3y3tF1kJrWSgFs3Grs8Ar15t3yUZw43G3ySqFWvga43Zr1DCF13Zr48
        Jr4Y9rWI9r4DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
        GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
        8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSApnUUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwUKE2OmnMtouAAAsZ
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DRUGS_ERECTILE,
        DRUGS_ERECTILE_OBFU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

This patch implement the algorithm of searching free register(s) to
form a long-jump instruction pair.

AUIPC/JALR instruction pair is introduced with a much wider jump range
(4GB), where auipc loads the upper 20 bits to a free register and jalr
appends the lower 12 bits to form a 32 bit immediate. Since kprobes can
be instrumented at anywhere in kernel space, hence the free register
should be found in a generic way, not depending on the calling convention
or any other regulations.

The algorithm for finding the free register is inspired by the register
renaming in modern processors. From the perspective of register renaming,
a register could be represented as two different registers if two neighbour
instructions both write to it but no one ever reads. Extending this fact,
a register is considered to be free if there is no read before its next
write in the execution flow. We are free to change its value without
interfering normal execution.

In order to do jump optimization, it needs to search two free registers,
the first one is used to form AUIPC/JALR jumping to detour buffer, the
second one is used to form JR jumping back from detour buffer. If first
one never been updated by any instructions replaced by 'AUIPC/JALR',
both register supposes to the same one.

Let's use the example below to explain how the algorithm work. Given
kernel is RVI and RCV hybrid binary, and one kprobe is instrumented at
the entry of function idle_dummy.

Before			Optimized		Detour buffer
<idle_dummy>:					...
 #1 add  sp,sp,-16	auipc a0, #?		add  sp,sp,-16
 #2 sd   s0,8(sp)				sd   s0,8(sp)
 #3 addi s0,sp,16	jalr  a0, #?(a0)	addi s0,sp,16
 #4 ld   s0,8(sp)				ld   s0,8(sp)
 #5 li   a0,0		li   a0,0		auipc a0, #?
 #6 addi sp,sp,16	addi sp,sp,16		jr    x0, #?(a0)
 #7 ret			ret

For regular kprobe, it is trival to replace the first instruction with
C.EREABK, no more instruction and register will be clobber, in order to
optimize kprobe with long-jump, it used to patch the first 8 bytes with
AUIPC/JALR, and a0 will be chosen to save the address jumping to,
because from #1 to #7, a0 is the only one register that satifies two
conditions: (1) No read before write (2) Never been updated in detour
buffer. While s0 has been used as the source register at #2, so it is
not free to clobber.

The searching starts from the kprobe and stop at the last instruction of
function or the first branch/jump instruction, it decodes out the 'rs'
and 'rd' part of each visited instruction. If the 'rd' never been read
before, then record it to bitmask 'write'; if the 'rs' never been
written before, then record it to another bitmask 'read'. When searching
stops, the remaining bits of 'write' are the free registers to form
AUIPC/JALR or JR.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/kernel/probes/opt.c | 223 +++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index a4271e6033ba..a0d2ab39e3fa 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -12,6 +12,9 @@
 #include <asm/kprobes.h>
 #include <asm/patch.h>
 
+#include "simulate-insn.h"
+#include "decode-insn.h"
+
 static inline int in_auipc_jalr_range(long val)
 {
 #ifdef CONFIG_ARCH_RV32I
@@ -37,15 +40,235 @@ static void prepare_detour_buffer(kprobe_opcode_t *code, kprobe_opcode_t *slot,
 {
 }
 
+/* Registers the first usage of which is the destination of instruction */
+#define WRITE_ON(reg)	\
+	(*write |= (((*read >> (reg)) ^ 1UL) & 1) << (reg))
+/* Registers the first usage of which is the source of instruction */
+#define READ_ON(reg)	\
+	(*read |= (((*write >> (reg)) ^ 1UL) & 1) << (reg))
+
 /*
  * In RISC-V ISA, AUIPC/JALR clobber one register to form target address,
  * by inspired by register renaming in OoO processor, this involves search
  * backwards that is not previously used as a source register and is used
  * as a destination register before any branch or jump instruction.
  */
+static void find_register(unsigned long start, unsigned long end,
+			  unsigned long *write, unsigned long *read)
+{
+	kprobe_opcode_t insn;
+	unsigned long addr, offset = 0UL;
+
+	for (addr = start; addr < end; addr += offset) {
+		insn = *(kprobe_opcode_t *)addr;
+		offset = GET_INSN_LENGTH(insn);
+
+#ifdef CONFIG_RISCV_ISA_C
+		if (offset == RVI_INSN_LEN)
+			goto is_rvi;
+
+		insn &= __COMPRESSED_INSN_MASK;
+		/* Stop searching until any control transfer instruction */
+		if (riscv_insn_is_c_ebreak(insn) || riscv_insn_is_c_j(insn))
+			break;
+
+		if (riscv_insn_is_c_jal(insn)) {
+			/* The rd of C.JAL is x1 by default */
+			WRITE_ON(1);
+			break;
+		}
+
+		if (riscv_insn_is_c_jr(insn)) {
+			READ_ON(rvc_r_rs1(insn));
+			break;
+		}
+
+		if (riscv_insn_is_c_jalr(insn)) {
+			READ_ON(rvc_r_rs1(insn));
+			/* The rd of C.JALR is x1 by default */
+			WRITE_ON(1);
+			break;
+		}
+
+		if (riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn)) {
+			READ_ON(rvc_b_rs(insn));
+			break;
+		}
+
+		/*
+		 * Decode RVC instructions that encode integer registers, try
+		 * to find out some destination register, the number of which
+		 * are equal with 'least' and never be used as source register.
+		 */
+		if (riscv_insn_is_c_sub(insn) || riscv_insn_is_c_subw(insn)) {
+			READ_ON(rvc_a_rs1(insn));
+			READ_ON(rvc_a_rs2(insn));
+			continue;
+		} else if (riscv_insn_is_c_sq(insn) ||
+			   riscv_insn_is_c_sw(insn) ||
+			   riscv_insn_is_c_sd(insn)) {
+			READ_ON(rvc_s_rs1(insn));
+			READ_ON(rvc_s_rs2(insn));
+			continue;
+		} else if (riscv_insn_is_c_addi16sp(insn) ||
+			   riscv_insn_is_c_addi(insn) ||
+			   riscv_insn_is_c_addiw(insn) ||
+			   riscv_insn_is_c_slli(insn)) {
+			READ_ON(rvc_i_rs1(insn));
+			continue;
+		} else if (riscv_insn_is_c_sri(insn) ||
+			   riscv_insn_is_c_andi(insn)) {
+			READ_ON(rvc_b_rs(insn));
+			continue;
+		} else if (riscv_insn_is_c_sqsp(insn) ||
+			   riscv_insn_is_c_swsp(insn) ||
+			   riscv_insn_is_c_sdsp(insn)) {
+			READ_ON(rvc_ss_rs2(insn));
+			/* The rs2 of C.SQSP/SWSP/SDSP are x2 by default */
+			READ_ON(2);
+			continue;
+		} else if (riscv_insn_is_c_mv(insn)) {
+			READ_ON(rvc_r_rs2(insn));
+			WRITE_ON(rvc_r_rd(insn));
+		} else if (riscv_insn_is_c_addi4spn(insn)) {
+			/* The rs of C.ADDI4SPN is x2 by default */
+			READ_ON(2);
+			WRITE_ON(rvc_l_rd(insn));
+		} else if (riscv_insn_is_c_lq(insn) ||
+			   riscv_insn_is_c_lw(insn) ||
+			   riscv_insn_is_c_ld(insn)) {
+			/* FIXME: c.lw/c.ld share opcode with c.flw/c.fld */
+			READ_ON(rvc_l_rs(insn));
+			WRITE_ON(rvc_l_rd(insn));
+		} else if (riscv_insn_is_c_lqsp(insn) ||
+			   riscv_insn_is_c_lwsp(insn) ||
+			   riscv_insn_is_c_ldsp(insn)) {
+			/*
+			 * FIXME: c.lwsp/c.ldsp share opcode with c.flwsp/c.fldsp
+			 * The rs of C.LQSP/C.LWSP/C.LDSP is x2 by default.
+			 */
+			READ_ON(2);
+			WRITE_ON(rvc_i_rd(insn));
+		} else if (riscv_insn_is_c_li(insn) ||
+			   riscv_insn_is_c_lui(insn)) {
+			WRITE_ON(rvc_i_rd(insn));
+		}
+
+		if ((*write > 1UL) && __builtin_ctzl(*write & ~1UL))
+			return;
+is_rvi:
+#endif
+		/* Stop searching until any control transfer instruction */
+		if (riscv_insn_is_branch(insn)) {
+			READ_ON(rvi_rs1(insn));
+			READ_ON(rvi_rs2(insn));
+			break;
+		}
+
+		if (riscv_insn_is_jal(insn)) {
+			WRITE_ON(rvi_rd(insn));
+			break;
+		}
+
+		if (riscv_insn_is_jalr(insn)) {
+			READ_ON(rvi_rs1(insn));
+			WRITE_ON(rvi_rd(insn));
+			break;
+		}
+
+		if (riscv_insn_is_system(insn)) {
+			/* csrrw, csrrs, csrrc */
+			if (rvi_rs1(insn))
+				READ_ON(rvi_rs1(insn));
+			/* csrrwi, csrrsi, csrrci, csrrw, csrrs, csrrc */
+			if (rvi_rd(insn))
+				WRITE_ON(rvi_rd(insn));
+			break;
+		}
+
+		/*
+		 * Decode RVC instructions that has rd and rs, try to find out
+		 * some rd, the number of which are equal with 'least' and never
+		 * be used as rs.
+		 */
+		if (riscv_insn_is_lui(insn) || riscv_insn_is_auipc(insn)) {
+			WRITE_ON(rvi_rd(insn));
+		} else if (riscv_insn_is_arith_ri(insn) ||
+			   riscv_insn_is_load(insn)) {
+			READ_ON(rvi_rs1(insn));
+			WRITE_ON(rvi_rd(insn));
+		} else if (riscv_insn_is_arith_rr(insn) ||
+			   riscv_insn_is_store(insn) ||
+			   riscv_insn_is_amo(insn)) {
+			READ_ON(rvi_rs1(insn));
+			READ_ON(rvi_rs2(insn));
+			WRITE_ON(rvi_rd(insn));
+		}
+
+		if ((*write > 1UL) && __builtin_ctzl(*write & ~1UL))
+			return;
+	}
+}
+
 static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
 				int *rd, int *ra)
 {
+	unsigned long start, end;
+	/*
+	 * Searching algorithm explanation:
+	 *
+	 * 1. Define two types of instruction area firstly:
+	 *
+	 * +-----+
+	 * +     +
+	 * +     + ---> instrunctions modified by optprobe, named 'O-Area'.
+	 * +     +
+	 * +-----+
+	 * +     +
+	 * +     + ---> instructions after optprobe, named 'K-Area'.
+	 * +     +
+	 * +  ~  +
+	 *
+	 * 2. There are two usages for each GPR in given instruction area.
+	 *
+	 *   - W: GPR is used as the RD oprand at first emergence.
+	 *   - R: GPR is used as the RS oprand at first emergence.
+	 *
+	 * Then there are 4 different usages for each GPR totally:
+	 *
+	 *   1. Used as W in O-Area, Used as W in K-Area.
+	 *   2. Used as W in O-Area, Used as R in K-Area.
+	 *   3. Used as R in O-Area, Used as W in K-Area.
+	 *   4. Used as R in O-Area, Used as R in K-Area.
+	 *
+	 * All registers satisfy #1 or #3 could be chosen to form 'AUIPC/JALR'
+	 * jumping to detour buffer.
+	 *
+	 * All registers satisfy #1 or #2, could be chosen to form 'JR' jumping
+	 * back from detour buffer.
+	 */
+	unsigned long kw = 0UL, kr = 0UL, ow = 0UL, or = 0UL;
+
+	/* Search one free register used to form AUIPC/JALR */
+	start = (unsigned long)&kp->opcode;
+	end = start + GET_INSN_LENGTH(kp->opcode);
+	find_register(start, end, &ow, &or);
+
+	start = (unsigned long)kp->addr + GET_INSN_LENGTH(kp->opcode);
+	end = (unsigned long)kp->addr + op->optinsn.length;
+	find_register(start, end, &ow, &or);
+
+	/* Search one free register used to form JR */
+	find_register(end, (unsigned long)_end, &kw, &kr);
+
+	if ((kw & ow) > 1UL) {
+		*rd = __builtin_ctzl((kw & ow) & ~1UL);
+		*ra = *rd;
+		return;
+	}
+
+	*rd = ((kw | ow) == 1UL) ? 0 : __builtin_ctzl((kw | ow) & ~1UL);
+	*ra = (kw == 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
 }
 
 /*
-- 
2.34.1

