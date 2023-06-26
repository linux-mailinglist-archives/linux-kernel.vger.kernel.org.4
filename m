Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143D73E5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjFZQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E669C4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F21760EC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4411AC433C8;
        Mon, 26 Jun 2023 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687798670;
        bh=D7OOp/89DCaiYbQMxKU0tOSDhjvcdtKgZcq1oLiZYw8=;
        h=From:To:Cc:Subject:Date:From;
        b=mH7PKJVyDXTVMM0pvqVTZGZvdM1pTfAZhbM2tmvYqv21ZLuWCizd5/AqVqL2/EY6i
         sFJYZoHET3zvjjKjCXV06M/ruxB21ID8bExYeIy75+ZTY2Frv30nCMAqU4wq8jTBzs
         lfc49vv+jxFKL4s0cr9XO5JWA+PyLk9E9uurc6k5RZKuyt05qEq2SobHhk051/mB0q
         q7gwjoJ2UXZc6A6RpUXHPJoZpj3oLfgFqy/tECf4oOrk4zIrRqpWKISigmCKlc8LmI
         E2klUHvloTfAnOQHCbbUkdsjQP5yqf5gx0eGloy2PVLHQTjFc0sglpyFXTiaupH3Sj
         GGPSInHOFd0MQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v2] riscv: Discard vector state on syscalls
Date:   Mon, 26 Jun 2023 18:57:36 +0200
Message-Id: <20230626165736.65927-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V vector specification states:
  Executing a system call causes all caller-saved vector registers
  (v0-v31, vl, vtype) and vstart to become unspecified.

The vector registers are set to all 1s, vill is set (invalid), and the
vector status is set to Initial.

That way we can prevent userspace from accidentally relying on the
stated save.

Rémi pointed out [1] that writing to the registers might be
superfluous, and setting vill is sufficient.

Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
Suggested-by: Darius Rad <darius@bluespec.com>
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v1->v2:
  Proper register restore for initial state (Andy)
  Set registers to 1s, and not 0s (Darius)
---
 arch/riscv/include/asm/vector.h | 42 ++++++++++++++++++++++++++++++---
 arch/riscv/kernel/traps.c       |  2 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 04c0b07bf6cd..93d702d9988c 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -139,14 +139,49 @@ static inline void riscv_v_vstate_save(struct task_struct *task,
 	}
 }
 
+static inline void __riscv_v_vstate_discard(void)
+{
+	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
+
+	riscv_v_enable();
+	asm volatile (
+		".option push\n\t"
+		".option arch, +v\n\t"
+		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
+		"vmv.v.i	v0, -1\n\t"
+		"vmv.v.i	v8, -1\n\t"
+		"vmv.v.i	v16, -1\n\t"
+		"vmv.v.i	v24, -1\n\t"
+		"vsetvl		%0, x0, %1\n\t"
+		".option pop\n\t"
+		: "=&r" (vl) : "r" (vtype_inval) : "memory");
+	riscv_v_disable();
+}
+
+static inline void riscv_v_vstate_discard(struct pt_regs *regs)
+{
+	if (!riscv_v_vstate_query(regs))
+		return;
+
+	__riscv_v_vstate_discard();
+	riscv_v_vstate_on(regs);
+}
+
 static inline void riscv_v_vstate_restore(struct task_struct *task,
 					  struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) != SR_VS_OFF) {
-		struct __riscv_v_ext_state *vstate = &task->thread.vstate;
-
+	struct __riscv_v_ext_state *vstate = &task->thread.vstate;
+	unsigned long status = regs->status & SR_VS;
+
+	switch (status) {
+	case SR_VS_INITIAL:
+		__riscv_v_vstate_discard();
+		break;
+	case SR_VS_CLEAN:
+	case SR_VS_DIRTY:
 		__riscv_v_vstate_restore(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
+		break;
 	}
 }
 
@@ -178,6 +213,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define __switch_to_vector(__prev, __next)	do {} while (0)
 #define riscv_v_vstate_off(regs)		do {} while (0)
 #define riscv_v_vstate_on(regs)			do {} while (0)
+#define riscv_v_vstate_discard(regs)		do {} while (0)
 
 #endif /* CONFIG_RISCV_ISA_V */
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 5158961ea977..5ff63a784a6d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -296,6 +296,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
 
+		riscv_v_vstate_discard(regs);
+
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
 		if (syscall < NR_syscalls)

base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
-- 
2.39.2

