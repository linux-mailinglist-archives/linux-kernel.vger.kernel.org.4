Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CC721E44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFEGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFEGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:39:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3773FDA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:39:13 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxP_AQg31k9wUAAA--.161S3;
        Mon, 05 Jun 2023 14:39:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axa9YPg31kHQcAAA--.72S4;
        Mon, 05 Jun 2023 14:39:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 2/6] LoongArch: Add larch_insn_gen_break() to generate break insns
Date:   Mon,  5 Jun 2023 14:39:06 +0800
Message-Id: <1685947150-4949-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Axa9YPg31kHQcAAA--.72S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1UJw13AF45KF17KFWrtFc_yoW8trW3pF
        nrZwn5KrW5GryfGr9Iq345ur13Jws7WwsFqFsxta4xGr4UX3W5XFy0gryqqFyjvw4kWFW0
        q3WSqw12v3W5JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
        6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exist various break insns such as BRK_KPROBE_BP, BRK_KPROBE_SSTEPBP,
BRK_UPROBE_BP and BRK_UPROBE_XOLBP, add larch_insn_gen_break() to generate
break insns simpler, this is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Jeff Xie <xiehuan09@gmail.com>
---
 arch/loongarch/include/asm/inst.h | 12 ++++++++++++
 arch/loongarch/kernel/inst.c      |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index c9e5435..01fb789 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -447,6 +447,8 @@ u32 larch_insn_gen_nop(void);
 u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
 u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest);
 
+u32 larch_insn_gen_break(int imm);
+
 u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongarch_gpr rk);
 u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
 
@@ -465,6 +467,16 @@ static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
 	return val < (1UL << bit);
 }
 
+#define DEF_EMIT_REG0I15_FORMAT(NAME, OP)				\
+static inline void emit_##NAME(union loongarch_instruction *insn,	\
+			       int imm)					\
+{									\
+	insn->reg0i15_format.opcode = OP;				\
+	insn->reg0i15_format.immediate = imm;				\
+}
+
+DEF_EMIT_REG0I15_FORMAT(break, break_op)
+
 #define DEF_EMIT_REG0I26_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
 			       int offset)				\
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 6f61956..1d7d579 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -247,6 +247,15 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 	return insn.word;
 }
 
+u32 larch_insn_gen_break(int imm)
+{
+	union loongarch_instruction insn;
+
+	emit_break(&insn, imm);
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongarch_gpr rk)
 {
 	union loongarch_instruction insn;
-- 
2.1.0

