Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0D61295C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ3JWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ3JVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:21:41 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C89AB845
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:21:36 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXCVmKPV5jkxYmBw--.33365S8;
        Sun, 30 Oct 2022 17:02:18 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH 4/8] riscv/kprobe: Add common RVI and RVC instruction decoder code
Date:   Sun, 30 Oct 2022 17:01:37 +0800
Message-Id: <20221030090141.2550837-5-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXCVmKPV5jkxYmBw--.33365S8
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8GFW5JFWkKFWUuF1kAFb_yoW3trWrpw
        s5Cw1Y93ykGF93C397tr48CrWFqw4rGrs8Kay0ga1avF12qr1UXr97try3tF4kWFWFgr47
        CFZ8JrWkGrW2y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1KsjDUUUU
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCgIPE2NeGqorWgAAso
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

This patch adds code that can be used to decode RVI and RVC instructions
in searching one register for 'AUIPC/JALR'. As mentioned in previous
patch, kprobe can't be optimized until one free integer register can be
found to save the jump target, in order to figure out the register
searching, all instructions starting from the kprobe point to the last
one of function needs to be decoded and tested if it contains one
candidate register.

For all RVI instruction format, the position and length of 'rs1', 'rs2'
,'rd' and 'opcode' part are uniform, but the rule of RVC instruction
format is more complicated, so it addresses a couple of inline functions
to decode rs1/rs2/rd for RVC.

These instruction decoders are supposed to be consistent with the RVC and
RV32/RV64G instruction set list specified in the riscv instruction
reference published at August 25, 2022.

Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/include/asm/bug.h             |   5 +-
 arch/riscv/kernel/probes/decode-insn.h   | 145 +++++++++++++++++++++++
 arch/riscv/kernel/probes/simulate-insn.h |  41 +++++++
 3 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..9c33d3b58225 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -19,11 +19,14 @@
 #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
 #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
 
+#define RVI_INSN_LEN	4UL
+#define RVC_INSN_LEN	2UL
+
 #define GET_INSN_LENGTH(insn)						\
 ({									\
 	unsigned long __len;						\
 	__len = ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ?	\
-		4UL : 2UL;						\
+		RVI_INSN_LEN : RVC_INSN_LEN;				\
 	__len;								\
 })
 
diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
index 42269a7d676d..1c202b0ac7d4 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -3,6 +3,7 @@
 #ifndef _RISCV_KERNEL_KPROBES_DECODE_INSN_H
 #define _RISCV_KERNEL_KPROBES_DECODE_INSN_H
 
+#include <linux/bitops.h>
 #include <asm/sections.h>
 #include <asm/kprobes.h>
 
@@ -15,4 +16,148 @@ enum probe_insn {
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
+static inline u16 rvi_rs1(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 15) & 0x1f);
+}
+
+static inline u16 rvi_rs2(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 20) & 0x1f);
+}
+
+static inline u16 rvi_rd(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x1f);
+}
+
+static inline s32 rvi_branch_imme(kprobe_opcode_t opcode)
+{
+	u32 imme = 0;
+
+	imme |= (((opcode >> 8)  & 0xf)   << 1)  |
+		(((opcode >> 25) & 0x3f)  << 5)  |
+		(((opcode >> 7)  & 0x1)   << 11) |
+		(((opcode >> 31) & 0x1)   << 12);
+
+	return sign_extend32(imme, 13);
+}
+
+static inline s32 rvi_jal_imme(kprobe_opcode_t opcode)
+{
+	u32 imme = 0;
+
+	imme |= (((opcode >> 21) & 0x3ff) << 1)  |
+		(((opcode >> 20) & 0x1)   << 11) |
+		(((opcode >> 12) & 0xff)  << 12) |
+		(((opcode >> 31) & 0x1)   << 20);
+
+	return sign_extend32(imme, 21);
+}
+
+#ifdef CONFIG_RISCV_ISA_C
+static inline u16 rvc_r_rs1(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x1f);
+}
+
+static inline u16 rvc_r_rs2(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x1f);
+}
+
+static inline u16 rvc_r_rd(kprobe_opcode_t opcode)
+{
+	return rvc_r_rs1(opcode);
+}
+
+static inline u16 rvc_i_rs1(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x1f);
+}
+
+static inline u16 rvc_i_rd(kprobe_opcode_t opcode)
+{
+	return rvc_i_rs1(opcode);
+}
+
+static inline u16 rvc_ss_rs2(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x1f);
+}
+
+static inline u16 rvc_l_rd(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x7);
+}
+
+static inline u16 rvc_l_rs(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x7);
+}
+
+static inline u16 rvc_s_rs2(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x7);
+}
+
+static inline u16 rvc_s_rs1(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x7);
+}
+
+static inline u16 rvc_a_rs2(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 2) & 0x7);
+}
+
+static inline u16 rvc_a_rs1(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x7);
+}
+
+static inline u16 rvc_a_rd(kprobe_opcode_t opcode)
+{
+	return rvc_a_rs1(opcode);
+}
+
+static inline u16 rvc_b_rd(kprobe_opcode_t opcode)
+{
+	return (u16)((opcode >> 7) & 0x7);
+}
+
+static inline u16 rvc_b_rs(kprobe_opcode_t opcode)
+{
+	return rvc_b_rd(opcode);
+}
+
+static inline s32 rvc_branch_imme(kprobe_opcode_t opcode)
+{
+	u32 imme = 0;
+
+	imme |= (((opcode >> 3)  & 0x3) << 1) |
+		(((opcode >> 10) & 0x3) << 3) |
+		(((opcode >> 2)  & 0x1) << 5) |
+		(((opcode >> 5)  & 0x3) << 6) |
+		(((opcode >> 12) & 0x1) << 8);
+
+	return sign_extend32(imme, 9);
+}
+
+static inline s32 rvc_jal_imme(kprobe_opcode_t opcode)
+{
+	u32 imme = 0;
+
+	imme |= (((opcode >> 3)  & 0x3) << 1) |
+		(((opcode >> 11) & 0x1) << 4) |
+		(((opcode >> 2)  & 0x1) << 5) |
+		(((opcode >> 7)  & 0x1) << 6) |
+		(((opcode >> 6)  & 0x1) << 7) |
+		(((opcode >> 9)  & 0x3) << 8) |
+		(((opcode >> 8)  & 0x1) << 10) |
+		(((opcode >> 12) & 0x1) << 11);
+
+	return sign_extend32(imme, 12);
+}
+#endif /* CONFIG_RISCV_ISA_C */
 #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index cb6ff7dccb92..74d8c1ba9064 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -37,6 +37,40 @@ __RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
 __RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
 __RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
 __RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);
+/* RVC(S) instructions contain rs1 and rs2 */
+__RISCV_INSN_FUNCS(c_sq,	0xe003, 0xa000);
+__RISCV_INSN_FUNCS(c_sw,	0xe003, 0xc000);
+__RISCV_INSN_FUNCS(c_sd,	0xe003, 0xe000);
+/* RVC(A) instructions contain rs1 and rs2 */
+__RISCV_INSN_FUNCS(c_sub,	0xfc03, 0x8c01);
+__RISCV_INSN_FUNCS(c_subw,	0xfc43, 0x9c01);
+/* RVC(L) instructions contain rs1 */
+__RISCV_INSN_FUNCS(c_lq,	0xe003, 0x2000);
+__RISCV_INSN_FUNCS(c_lw,	0xe003, 0x4000);
+__RISCV_INSN_FUNCS(c_ld,	0xe003, 0x6000);
+/* RVC(I) instructions contain rs1 */
+__RISCV_INSN_FUNCS(c_addi,	0xe003, 0x0001);
+__RISCV_INSN_FUNCS(c_addiw,	0xe003, 0x2001);
+__RISCV_INSN_FUNCS(c_addi16sp,	0xe183, 0x6101);
+__RISCV_INSN_FUNCS(c_slli,	0xe003, 0x0002);
+/* RVC(B) instructions contain rs1 */
+__RISCV_INSN_FUNCS(c_sri,	0xe803, 0x8001);
+__RISCV_INSN_FUNCS(c_andi,	0xec03, 0x8801);
+/* RVC(SS) instructions contain rs2 */
+__RISCV_INSN_FUNCS(c_sqsp,	0xe003, 0xa002);
+__RISCV_INSN_FUNCS(c_swsp,	0xe003, 0xc002);
+__RISCV_INSN_FUNCS(c_sdsp,	0xe003, 0xe002);
+/* RVC(R) instructions contain rs2 and rd */
+__RISCV_INSN_FUNCS(c_mv,	0xe003, 0x8002);
+/* RVC(I) instructions contain sp and rd */
+__RISCV_INSN_FUNCS(c_lqsp,	0xe003, 0x2002);
+__RISCV_INSN_FUNCS(c_lwsp,	0xe003, 0x4002);
+__RISCV_INSN_FUNCS(c_ldsp,	0xe003, 0x6002);
+/* RVC(CW) instructions contain sp and rd */
+__RISCV_INSN_FUNCS(c_addi4spn,	0xe003, 0x0000);
+/* RVC(I) instructions contain rd */
+__RISCV_INSN_FUNCS(c_li,	0xe003, 0x4001);
+__RISCV_INSN_FUNCS(c_lui,	0xe003, 0x6001);
 
 __RISCV_INSN_FUNCS(auipc,	0x7f, 0x17);
 __RISCV_INSN_FUNCS(branch,	0x7f, 0x63);
@@ -44,4 +78,11 @@ __RISCV_INSN_FUNCS(branch,	0x7f, 0x63);
 __RISCV_INSN_FUNCS(jal,		0x7f, 0x6f);
 __RISCV_INSN_FUNCS(jalr,	0x707f, 0x67);
 
+__RISCV_INSN_FUNCS(arith_rr,	0x77, 0x33);
+__RISCV_INSN_FUNCS(arith_ri,	0x77, 0x13);
+__RISCV_INSN_FUNCS(lui,		0x7f, 0x37);
+__RISCV_INSN_FUNCS(load,	0x7f, 0x03);
+__RISCV_INSN_FUNCS(store,	0x7f, 0x23);
+__RISCV_INSN_FUNCS(amo,		0x7f, 0x2f);
+
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.25.1

