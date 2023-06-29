Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDA742062
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjF2G23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjF2G1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2A1B2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44733614AC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C7C433C8;
        Thu, 29 Jun 2023 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688020057;
        bh=YQhuBQ3j9NEc7Bo7uyfWxsU+RoSkYIM6Un+O+o02yNs=;
        h=From:To:Cc:Subject:Date:From;
        b=cP051lzRT7C0TFbto2MNtQweDI2SV7bTfB3NWG1Z/1EupqLqJ/CaA3IX1ktNKgb33
         YUvDm45rLg6NfT1gpm2ur6hJWTGvVbqUHdrpJ4zXqLIzMhaRk33/HZzkTkxOzRWFK8
         42BOLaDhgD1s37sWxWV3TtwtFvyzPm9IBgrhWywoT8pUnD52ECgcBZ/jyzozJSrRIy
         4S2S4/JrHdwSe2cvBaARUn/L74WIL58VVxNfB4sb/BIvO3rhlg7Xa29kmeSISaqe/Q
         BEbbdPW+IcUa+n0ir3tldKu/VDDytX5Ay9l+j3ueELp/hWspZ5J4pYmdy5bZw1IOXS
         9DmFiTgRVP/5A==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>
Subject: [PATCH v3] riscv: Discard vector state on syscalls
Date:   Thu, 29 Jun 2023 08:27:30 +0200
Message-Id: <20230629062730.985184-1-bjorn@kernel.org>
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
vector status is set to Dirty.

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

v2->v3:
  Set state to Dirty after discard, for proper ptrace() handling
  (Andy)

v1->v2:
  Proper register restore for initial state (Andy)
  Set registers to 1s, and not 0s (Darius)

---
 arch/riscv/include/asm/vector.h | 33 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c       |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 04c0b07bf6cd..0b23056503c5 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -33,6 +33,11 @@ static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
 	regs->status = (regs->status & ~SR_VS) | SR_VS_CLEAN;
 }
 
+static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
+{
+	regs->status = (regs->status & ~SR_VS) | SR_VS_DIRTY;
+}
+
 static inline void riscv_v_vstate_off(struct pt_regs *regs)
 {
 	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
@@ -128,6 +133,34 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 	riscv_v_disable();
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
+	if ((regs->status & SR_VS) == SR_VS_OFF)
+		return;
+
+	__riscv_v_vstate_discard();
+	__riscv_v_vstate_dirty(regs);
+}
+
 static inline void riscv_v_vstate_save(struct task_struct *task,
 				       struct pt_regs *regs)
 {
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

