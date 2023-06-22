Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499173A75B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjFVRgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFVRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A12195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F3A618BF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46613C433C0;
        Thu, 22 Jun 2023 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687455381;
        bh=/OtlEWvMky8FwHoyDb4NvG0us2YcJyx1FBYe9wivhIo=;
        h=From:To:Cc:Subject:Date:From;
        b=SDP/87huKee/Zv1UWW27EOV4jrMoXFTtOyzBCCVV2HyEgaNUlEEUByq9LhmSB4cQK
         akKVNj+YyNFLugitTB+lUVjf2avCXVwEpZeOLECHKo91RYsbYxvVrgshCGdYAZSGn6
         Pcbf/v/6u2sZGEpbffUiKeA3Vux7ZXH88rKG/+xBRKsxo3gfRv9pmhjl3KaRCQ7GGB
         GT+jJOmenD9WBi2fLUfivHK5Jupp7GHhbEDJnkSS73TJVm4wegD6JxV9lNB/a+XeeA
         iFHcQOnUsZswGhaDS+pRpwrShuald9jYkTRJ4R65G/STQ1uWc06QiHga7mojE0upT+
         VoQDDDWWKH93g==
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
Subject: [PATCH] riscv: Discard vector state on syscalls
Date:   Thu, 22 Jun 2023 19:36:13 +0200
Message-Id: <20230622173613.30722-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

The vector registers are cleared, vill is set (invalid), and the
vector status is set to Initial.

That way we can prevent userspace from accidentally relying on the
stated save.

Rémi pointed out [1] that clearing the registers might be superfluous,
and setting vill is sufficient.

Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---

I figured I'd sent out a proper patch. I like Andy's optimization
patch, but TBH I think we should do that as a follow up.

As Rémi pointed out, the clearing might be opted out, but I left it in
here.


Björn

---
 arch/riscv/include/asm/vector.h | 25 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c       |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 04c0b07bf6cd..692ce55e4a69 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -163,6 +163,30 @@ static inline void __switch_to_vector(struct task_struct *prev,
 void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
 bool riscv_v_vstate_ctrl_user_allowed(void);
 
+static inline void riscv_v_vstate_discard(struct pt_regs *regs)
+{
+	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
+
+	if (!riscv_v_vstate_query(regs))
+		return;
+
+	riscv_v_enable();
+	asm volatile (
+		".option push\n\t"
+		".option arch, +v\n\t"
+		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
+		"vmv.v.i	v0, 0\n\t"
+		"vmv.v.i	v8, 0\n\t"
+		"vmv.v.i	v16, 0\n\t"
+		"vmv.v.i	v24, 0\n\t"
+		"vsetvl		%0, x0, %1\n\t"
+		".option pop\n\t"
+		: "=&r" (vl) : "r" (vtype_inval) : "memory");
+	riscv_v_disable();
+
+	riscv_v_vstate_on(regs);
+}
+
 #else /* ! CONFIG_RISCV_ISA_V  */
 
 struct pt_regs;
@@ -178,6 +202,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define __switch_to_vector(__prev, __next)	do {} while (0)
 #define riscv_v_vstate_off(regs)		do {} while (0)
 #define riscv_v_vstate_on(regs)			do {} while (0)
+#define riscv_v_vstate_discard(regs)		do {} while (0)
 
 #endif /* CONFIG_RISCV_ISA_V */
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05ffdcd1424e..00c68b57ff88 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -295,6 +295,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
 
+		riscv_v_vstate_discard(regs);
+
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
 		if (syscall < NR_syscalls)

base-commit: 4681dacadeefa5ca6017e00736adc1d7dc963c6a
-- 
2.39.2

