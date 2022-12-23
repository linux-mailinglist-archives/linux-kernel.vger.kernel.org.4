Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B8654AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiLWCIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWCIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:08:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8BF2205EE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:08:42 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxKemoDaVj6fwHAA--.14527S3;
        Fri, 23 Dec 2022 10:08:40 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxY+WoDaVj8sEIAA--.34210S2;
        Fri, 23 Dec 2022 10:08:40 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Simplifying larch_insn_gen_xxx implementation
Date:   Fri, 23 Dec 2022 10:08:40 +0800
Message-Id: <1671761320-31392-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxY+WoDaVj8sEIAA--.34210S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFy5Xr1rCw1furW8AF43Jrb_yoWrWFW5pr
        42vwn5JrW7JryFkrWDX3yrXr13Jws3WrZFqFsrWws7Gw4YqFyrXFyvk34vyFWqgw4Uua10
        qa13Ar43ZF45JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify larch_insn_gen_xxx implementation by reusing emit_xxx.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/inst.h |  1 +
 arch/loongarch/kernel/inst.c      | 45 +++++--------------------------
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index c00e1512d4fa..a463b518a636 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -401,6 +401,7 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 }
 
 DEF_EMIT_REG0I26_FORMAT(b, b_op)
+DEF_EMIT_REG0I26_FORMAT(bl, bl_op)
 
 #define DEF_EMIT_REG1I20_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 512579d79b22..badc59087042 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -58,7 +58,6 @@ u32 larch_insn_gen_nop(void)
 u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
 {
 	long offset = dest - pc;
-	unsigned int immediate_l, immediate_h;
 	union loongarch_instruction insn;
 
 	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
@@ -66,15 +65,7 @@ u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
 		return INSN_BREAK;
 	}
 
-	offset >>= 2;
-
-	immediate_l = offset & 0xffff;
-	offset >>= 16;
-	immediate_h = offset & 0x3ff;
-
-	insn.reg0i26_format.opcode = b_op;
-	insn.reg0i26_format.immediate_l = immediate_l;
-	insn.reg0i26_format.immediate_h = immediate_h;
+	emit_b(&insn, offset >> 2);
 
 	return insn.word;
 }
@@ -82,7 +73,6 @@ u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
 u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 {
 	long offset = dest - pc;
-	unsigned int immediate_l, immediate_h;
 	union loongarch_instruction insn;
 
 	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
@@ -90,15 +80,7 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 		return INSN_BREAK;
 	}
 
-	offset >>= 2;
-
-	immediate_l = offset & 0xffff;
-	offset >>= 16;
-	immediate_h = offset & 0x3ff;
-
-	insn.reg0i26_format.opcode = bl_op;
-	insn.reg0i26_format.immediate_l = immediate_l;
-	insn.reg0i26_format.immediate_h = immediate_h;
+	emit_bl(&insn, offset >> 2);
 
 	return insn.word;
 }
@@ -107,10 +89,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongar
 {
 	union loongarch_instruction insn;
 
-	insn.reg3_format.opcode = or_op;
-	insn.reg3_format.rd = rd;
-	insn.reg3_format.rj = rj;
-	insn.reg3_format.rk = rk;
+	emit_or(&insn, rd, rj, rk);
 
 	return insn.word;
 }
@@ -124,9 +103,7 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
 
-	insn.reg1i20_format.opcode = lu12iw_op;
-	insn.reg1i20_format.rd = rd;
-	insn.reg1i20_format.immediate = imm;
+	emit_lu12iw(&insn, rd, imm);
 
 	return insn.word;
 }
@@ -135,9 +112,7 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
 
-	insn.reg1i20_format.opcode = lu32id_op;
-	insn.reg1i20_format.rd = rd;
-	insn.reg1i20_format.immediate = imm;
+	emit_lu32id(&insn, rd, imm);
 
 	return insn.word;
 }
@@ -146,10 +121,7 @@ u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 {
 	union loongarch_instruction insn;
 
-	insn.reg2i12_format.opcode = lu52id_op;
-	insn.reg2i12_format.rd = rd;
-	insn.reg2i12_format.rj = rj;
-	insn.reg2i12_format.immediate = imm;
+	emit_lu52id(&insn, rd, rj, imm);
 
 	return insn.word;
 }
@@ -158,10 +130,7 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
 {
 	union loongarch_instruction insn;
 
-	insn.reg2i16_format.opcode = jirl_op;
-	insn.reg2i16_format.rd = rd;
-	insn.reg2i16_format.rj = rj;
-	insn.reg2i16_format.immediate = (dest - pc) >> 2;
+	emit_jirl(&insn, rj, rd, (dest - pc) >> 2);
 
 	return insn.word;
 }
-- 
2.37.3

