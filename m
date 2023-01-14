Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093566AA72
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjANJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjANJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:40 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 312555BAB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:38 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxrOqJdcJjg50BAA--.5130S3;
        Sat, 14 Jan 2023 17:27:37 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+SBdcJjcVYZAA--.11667S8;
        Sat, 14 Jan 2023 17:27:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v11 6/6] LoongArch: Use common function sign_extend64()
Date:   Sat, 14 Jan 2023 17:27:24 +0800
Message-Id: <1673688444-24251-7-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
References: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bxb+SBdcJjcVYZAA--.11667S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrW7WF4UtryDWryUKw4rXwb_yoW5JF4kpr
        ZFyFykJFs8GF1Duryqy3s8XrWrWrn3Cr4aq3W3Kr1I9FWaqr129r18JrWqvF1kt3y0vFW0
        gFWfXw1Yva1UA3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists a common function sign_extend64() to sign extend a 64-bit
value using specified bit as sign-bit in include/linux/bitops.h, it is
more efficient, let us use it and remove the arch-specific sign_extend()
under arch/loongarch.

Suggested-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h   | 8 --------
 arch/loongarch/kernel/alternative.c | 6 +++---
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index e0771d2..ba18ce8 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -397,14 +397,6 @@ static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
 	return val < (1UL << bit);
 }
 
-static inline unsigned long sign_extend(unsigned long val, unsigned int idx)
-{
-	if (!is_imm_negative(val, idx + 1))
-		return ((1UL << idx) - 1) & val;
-	else
-		return ~((1UL << idx) - 1) | val;
-}
-
 #define DEF_EMIT_REG0I26_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
 			       int offset)				\
diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
index c5aebea..4ad1384 100644
--- a/arch/loongarch/kernel/alternative.c
+++ b/arch/loongarch/kernel/alternative.c
@@ -74,7 +74,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
 	switch (src->reg0i26_format.opcode) {
 	case b_op:
 	case bl_op:
-		jump_addr = cur_pc + sign_extend((si_h << 16 | si_l) << 2, 27);
+		jump_addr = cur_pc + sign_extend64((si_h << 16 | si_l) << 2, 27);
 		if (in_alt_jump(jump_addr, start, end))
 			return;
 		offset = jump_addr - pc;
@@ -93,7 +93,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
 		fallthrough;
 	case beqz_op:
 	case bnez_op:
-		jump_addr = cur_pc + sign_extend((si_h << 16 | si_l) << 2, 22);
+		jump_addr = cur_pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
 		if (in_alt_jump(jump_addr, start, end))
 			return;
 		offset = jump_addr - pc;
@@ -112,7 +112,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
 	case bge_op:
 	case bltu_op:
 	case bgeu_op:
-		jump_addr = cur_pc + sign_extend(si << 2, 17);
+		jump_addr = cur_pc + sign_extend64(si << 2, 17);
 		if (in_alt_jump(jump_addr, start, end))
 			return;
 		offset = jump_addr - pc;
-- 
2.1.0

