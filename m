Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE12C60F62D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiJ0L2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiJ0L2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB6D8F74
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FDDA6229F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE5FC433C1;
        Thu, 27 Oct 2022 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666870086;
        bh=rfR3uxz2nrv8wuP4WSxkqf0ER2HjAAy6q3LNAW8RibE=;
        h=From:To:Cc:Subject:Date:From;
        b=hTrAA6yu6jDTyFqvVarawjZ/Snfol9ZNtiMzFr1/2+KXtALp7xi7jGI8PAJR8hT4m
         /YFt0M6CiiJ159KV+ipw9gV9Cd2+5I5mhDGMlND7WNkfpGh2hy4bfNumdKEJFpWY9y
         JKlmrWbx5qfwGTu0elvp/rBT59viOa1zxcjRCo6UEv9w+w00blNbxQEuJVxSBh0p6Y
         EvltS++m9uKFtgw/cYO7g5m6UBmdSyYxCW7oiOH54k02aV0+sR7007VsLyu7EFz+f/
         bPpOVdHt4nCAUibStFzEaUzEgX4WzqIxulEHSC3cBavrjOjNXJhB8g2dvrqQqct3x1
         i8EqApRdXQGLA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: [RFC PATCH] arm64: Enable data independent timing (DIT) in the kernel
Date:   Thu, 27 Oct 2022 13:27:41 +0200
Message-Id: <20221027112741.1678057-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4905; i=ardb@kernel.org; h=from:subject; bh=rfR3uxz2nrv8wuP4WSxkqf0ER2HjAAy6q3LNAW8RibE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjWmss5HvgEtb+M+fTHPG7UG8BaCDsaA8U8CpbKBkz CbOeQOiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1prLAAKCRDDTyI5ktmPJAD9C/ 92D9opEiWPI3flD77igvWHJ5Fwj5DbHbNcoTx3HNfOoJol9/q/VQxhasJlFrilMhZe/4tO8379YEi0 QE8rNflOfG90Q2rJxomU7DGG5xSc5kpMmqhuJ3h5R/Ag6N4xZejjlneKkuQHO5gBI8BpJSYFJ9KE/g 1w1hudpy5szBQ7rX40YVtyA6MmCV8VaV7wxMFK0pHAyMXT1UGAY/iXkVrN2Q4vqNyvZsFb4YPo/pDy S7uI6fXzNUvc7ehgnnx7xUK0tbrQlow3HRwJAYDKaetZicT6swPc3fkB2EkoTmnLGRIPMT7gOT4yFD geGRG+3T+YuDuaaN8mxenvpLQYiPguQ+eu/6hdYAtWbmubR9e6N9x16egSxyBZRaCkfmSLiC07Tuq/ XAavaKQ/Tqg1bPgMnYuV+gAxElwdHn1Hb7xOPeSvMCe01HeCRmnH2WeREwFfwm7omm6NaKVu8eZBQc 5yCJFL2c6GluhKG3wpS3Hj+ECzDpz4oskBmdQpDQp1nDU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM architecture revision v8.4 introduces a data independent timing
control (DIT) which can be set at any exception level, and instructs the
CPU to avoid optimizations that may result in a correlation between the
execution time of certain instructions and the value of the data they
operate on.

The DIT bit is part of PSTATE, and is therefore context switched as
usual, given that it becomes part of the saved program state (SPSR) when
taking an exception. We have also defined a hwcap for DIT, and so user
space can discover already whether or nor DIT is available. This means
that, as far as user space is concerned, DIT is wired up and fully
functional.

In the kernel, however, we never bothered with DIT: we disable at it
boot (i.e., INIT_PSTATE_EL1 has DIT cleared) and ignore the fact that we
might run with DIT enabled if user space happened to set it.

Given that running privileged code with DIT disabled on a CPU that
implements support for it may result in a side channel that exposes
privileged data to unprivileged user space processes, let's enable DIT
while running in the kernel if supported by all CPUs.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Adam Langley <agl@google.com>
Link: https://lore.kernel.org/all/YwgCrqutxmX0W72r@gmail.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/sysreg.h |  3 +++
 arch/arm64/kernel/cpufeature.c  | 16 ++++++++++++++++
 arch/arm64/kernel/entry.S       |  3 +++
 arch/arm64/tools/cpucaps        |  1 +
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a9..18e065f5130c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -94,15 +94,18 @@
 #define PSTATE_PAN			pstate_field(0, 4)
 #define PSTATE_UAO			pstate_field(0, 3)
 #define PSTATE_SSBS			pstate_field(3, 1)
+#define PSTATE_DIT			pstate_field(3, 2)
 #define PSTATE_TCO			pstate_field(3, 4)
 
 #define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
 #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
 #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE_DIT(x)		__emit_inst(0xd500401f | PSTATE_DIT | ((!!x) << PSTATE_Imm_shift))
 #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
 
 #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
 #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
+#define set_pstate_dit(x)		asm volatile(SET_PSTATE_DIT(x))
 #define set_pstate_ssbs(x)		asm volatile(SET_PSTATE_SSBS(x))
 
 #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6062454a9067..273a74df24fe 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2077,6 +2077,11 @@ static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
 }
 
+static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
+{
+	set_pstate_dit(1);
+}
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2640,6 +2645,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_trap_el0_impdef,
 	},
+	{
+		.desc = "Data independent timing control (DIT)",
+		.capability = ARM64_HAS_DIT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
+		.field_width = 4,
+		.min_field_value = 1,
+		.cpu_enable = cpu_enable_dit,
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e28137d64b76..229b505e6366 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -197,6 +197,9 @@ alternative_cb_end
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
+	.if	\el == 0
+	ALTERNATIVE(nop, SET_PSTATE_DIT(1), ARM64_HAS_DIT)
+	.endif
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
 	.endif
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a..a86ee376920a 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -20,6 +20,7 @@ HAS_CNP
 HAS_CRC32
 HAS_DCPODP
 HAS_DCPOP
+HAS_DIT
 HAS_E0PD
 HAS_ECV
 HAS_EPAN
-- 
2.35.1

