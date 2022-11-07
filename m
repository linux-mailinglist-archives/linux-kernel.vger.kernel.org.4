Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1E61FB32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiKGRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiKGRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:24:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAE12ABE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A62C3B81607
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41B5C433D6;
        Mon,  7 Nov 2022 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667841850;
        bh=JTqHVMAnLRDuS59/KQho5vfw/08ICMwl26xYT9jZGaw=;
        h=From:To:Cc:Subject:Date:From;
        b=ONmwvSgnof641xcPHZJQt7W0jk86EeE4MQOAclEKzHYLBnvJH5ELMrPOk8YVKE1yA
         aMH/sHT2BeR3VrBYqqXYXQ5pVrUrBlWnrrsD8UAS3MaSrLRsNB+tfxswOlXTNBMEZZ
         xgjOGE8WUFpYlEIjbtpxmXa8GYSFu2+uA4xwP1FpxCqbI9G6TySOQBWhVFEHi2ETKO
         f8/fB49Hr2YdWwTtDn7grF3dYW+LoMadhTUlDmtDsl1tllfUp4d4knsNS/EoXxuDTM
         MZHq6GsOHirb5guK2iVMvkpYdVYP0Jw2oZLT+eOCWtkyr6p5kX0lPeqYmAP7kFDdL0
         UROcCJ4UCrCPw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: [PATCH v2] arm64: Enable data independent timing (DIT) in the kernel
Date:   Mon,  7 Nov 2022 18:24:00 +0100
Message-Id: <20221107172400.1851434-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6920; i=ardb@kernel.org; h=from:subject; bh=JTqHVMAnLRDuS59/KQho5vfw/08ICMwl26xYT9jZGaw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjaT8vsX5vWi+Uk2D/eR/+1Os7/WkNHOPumKXI3PHY X9ScIbaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2k/LwAKCRDDTyI5ktmPJNmhC/ wLkHECASV8fUtHk33mgENb14RuvJjs0v3tmnS9WD7vusxr4LWq5mKVV4zbJhl4hXtOcGBhFVmWId6G GH+/tQvcCmopb4o/P5YKclovQctqZ5BvMqbmxFXhHbpXey3ILW8NiLpoi9td+KniW6OIkacl7nszT9 W0E+o3vfj9ebwbCIF74ctz4tDAIC2bj8hFBeevmBnKwkxs+4vLFWY/FjiSI0WdUf1ef94RYEBhoNI+ jpFS/sCKNBbs6XnW0GxHRfJqT89v5YDQnHZhhhZxdlSuh14xyUwOBEft+iQUkPdCfgmyE0AW3nxn+o oMe1g0czn6sO6xE4iL4Z16t0hOTSdMd+0kjfcZd8r2tHaycQ+3nh63hntLC5IUVqxGGtlI4mTm3nyd cusxrZLWWicfCbxuu0Mg3gnSQnmeGvM9nIs2hT9rIxXgO/7VgCVV1O03GbfUsVMVi9cOeEGCjUTvgk ApHSun+MFeyUm5aL8qS6LzoQCIW6bimD7s0Z141vS2sAY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Currently, we have no idea whether or not running privileged code with
DIT disabled on a CPU that implements support for it may result in a
side channel that exposes privileged data to unprivileged user space
processes, so let's be cautious and just enable DIT while running in the
kernel if supported by all CPUs.

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
v2:
- enable DIT on resume-from-suspend path
- tidy up some issues spotted by Eric
- avoid some code duplication in SET_PSTATE_xxx macro definitions
- tweak the commit log so that it doesn't read as if we are fixing an
  actual vulnerability

 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/sysreg.h     | 12 ++++++++----
 arch/arm64/kernel/cpufeature.c      | 17 +++++++++++++++++
 arch/arm64/kernel/entry.S           |  3 +++
 arch/arm64/kernel/suspend.c         |  2 ++
 arch/arm64/tools/cpucaps            |  1 +
 6 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f73f11b5504254be..f44579bca9f8107e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -875,6 +875,11 @@ static inline bool cpu_has_pan(void)
 						    ID_AA64MMFR1_EL1_PAN_SHIFT);
 }
 
+static inline bool cpu_has_dit(void)
+{
+	return cpus_have_const_cap(ARM64_HAS_DIT);
+}
+
 #ifdef CONFIG_ARM64_AMU_EXTN
 /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
 extern bool cpu_has_amu_feat(int cpu);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a93692..1f3f52ce407fe942 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -90,20 +90,24 @@
  */
 #define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
 #define PSTATE_Imm_shift		CRm_shift
+#define SET_PSTATE(x, r)		__emit_inst(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
 
 #define PSTATE_PAN			pstate_field(0, 4)
 #define PSTATE_UAO			pstate_field(0, 3)
 #define PSTATE_SSBS			pstate_field(3, 1)
+#define PSTATE_DIT			pstate_field(3, 2)
 #define PSTATE_TCO			pstate_field(3, 4)
 
-#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
-#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
-#define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
-#define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE_PAN(x)		SET_PSTATE((x), PAN)
+#define SET_PSTATE_UAO(x)		SET_PSTATE((x), UAO)
+#define SET_PSTATE_SSBS(x)		SET_PSTATE((x), SSBS)
+#define SET_PSTATE_DIT(x)		SET_PSTATE((x), DIT)
+#define SET_PSTATE_TCO(x)		SET_PSTATE((x), TCO)
 
 #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
 #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
 #define set_pstate_ssbs(x)		asm volatile(SET_PSTATE_SSBS(x))
+#define set_pstate_dit(x)		asm volatile(SET_PSTATE_DIT(x))
 
 #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
 	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6062454a90674317..74ceec411ea8b597 100644
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
@@ -2640,6 +2645,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_trap_el0_impdef,
 	},
+	{
+		.desc = "Data independent timing control (DIT)",
+		.capability = ARM64_HAS_DIT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
+		.field_width = 4,
+		.min_field_value = ID_AA64PFR0_EL1_DIT_IMP,
+		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_dit,
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e28137d64b7688e2..11cb99c4d298784d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -197,6 +197,9 @@ alternative_cb_end
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
+	.if	\el == 0
+	alternative_insn nop, SET_PSTATE_DIT(1), ARM64_HAS_DIT
+	.endif
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
 	.endif
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 8b02d310838f9240..3032a82ea51a19f7 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -60,6 +60,8 @@ void notrace __cpu_suspend_exit(void)
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
 	 * features that might not have been set correctly.
 	 */
+	if (cpu_has_dit())
+		set_pstate_dit(1);
 	__uaccess_enable_hw_pan();
 
 	/*
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a85c7..a86ee376920a08dd 100644
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

