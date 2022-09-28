Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0885EEA62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiI1X7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiI1X72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:59:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199ED10E5CD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:59:10 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxFeLI3zRjToIjAA--.2987S2;
        Thu, 29 Sep 2022 07:59:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Remove some save operations in SAVE_SOME and handle_syscall
Date:   Thu, 29 Sep 2022 07:59:03 +0800
Message-Id: <1664409543-31214-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxFeLI3zRjToIjAA--.2987S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWkGr1fuw1UCr4kAw15twb_yoW8Aw1fpF
        1fArn2grW09ryxA3W8tr98uFyUAan7uw4aqa47JFWFyr43ZFyjvw18AFyDJFyYgw4rWw1I
        93Z3AwnavF4rJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6FWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j3_-PUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to save the control and status registers CRMD, EUEN, ECFG
and ESTAT in SAVE_SOME and handle_syscall as they are not restored
later in RESTORE_SOME.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h | 9 ---------
 arch/loongarch/kernel/entry.S           | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca9530..733dc9e 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -114,14 +114,6 @@
 	LONG_S	zero, sp, PT_R0
 	csrrd	t0, LOONGARCH_CSR_PRMD
 	LONG_S	t0, sp, PT_PRMD
-	csrrd	t0, LOONGARCH_CSR_CRMD
-	LONG_S	t0, sp, PT_CRMD
-	csrrd	t0, LOONGARCH_CSR_EUEN
-	LONG_S  t0, sp, PT_EUEN
-	csrrd	t0, LOONGARCH_CSR_ECFG
-	LONG_S	t0, sp, PT_ECFG
-	csrrd	t0, LOONGARCH_CSR_ESTAT
-	PTR_S	t0, sp, PT_ESTAT
 	cfi_st	ra, PT_R1, \docfi
 	cfi_st	a0, PT_R4, \docfi
 	cfi_st	a1, PT_R5, \docfi
@@ -140,7 +132,6 @@
 	cfi_st	fp, PT_R22, \docfi
 
 	/* Set thread_info if we're coming from user mode */
-	csrrd	t0, LOONGARCH_CSR_PRMD
 	andi	t0, t0, 0x3	/* extract pplv bit */
 	beqz	t0, 9f
 
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d53b631..893e632 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -31,14 +31,6 @@ SYM_FUNC_START(handle_syscall)
 	st.d	zero, sp, PT_R0
 	csrrd	t2, LOONGARCH_CSR_PRMD
 	st.d	t2, sp, PT_PRMD
-	csrrd	t2, LOONGARCH_CSR_CRMD
-	st.d	t2, sp, PT_CRMD
-	csrrd	t2, LOONGARCH_CSR_EUEN
-	st.d	t2, sp, PT_EUEN
-	csrrd	t2, LOONGARCH_CSR_ECFG
-	st.d	t2, sp, PT_ECFG
-	csrrd	t2, LOONGARCH_CSR_ESTAT
-	st.d	t2, sp, PT_ESTAT
 	cfi_st	ra, PT_R1
 	cfi_st	a0, PT_R4
 	cfi_st	a1, PT_R5
-- 
2.1.0

