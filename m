Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F2699968
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBPQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBPQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:02:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 700BF56EFE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:01:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7996113E;
        Thu, 16 Feb 2023 08:02:36 -0800 (PST)
Received: from e126864.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CE73F881;
        Thu, 16 Feb 2023 08:01:51 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] arm64: mops: handle MOPS exceptions
Date:   Thu, 16 Feb 2023 16:00:09 +0000
Message-Id: <20230216160012.272345-8-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216160012.272345-1-kristina.martsenko@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory copy/set instructions added as part of FEAT_MOPS can take an
exception part-way through their execution and resume execution
afterwards. If however the task is re-scheduled and execution resumes on
a different CPU, then the CPU may take a new type of exception to
indicate this. In this case the OS has to reset the registers and restart
execution from the prologue instruction. The algorithm for doing this is
provided as part of the Arm ARM.

Add an exception handler for the new exception and wire it up for
userspace tasks.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/esr.h       | 11 +++++++-
 arch/arm64/include/asm/exception.h |  1 +
 arch/arm64/kernel/entry-common.c   | 11 ++++++++
 arch/arm64/kernel/traps.c          | 45 ++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index c9f15b9e3c71..96caaaee97a3 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -47,7 +47,7 @@
 #define ESR_ELx_EC_DABT_LOW	(0x24)
 #define ESR_ELx_EC_DABT_CUR	(0x25)
 #define ESR_ELx_EC_SP_ALIGN	(0x26)
-/* Unallocated EC: 0x27 */
+#define ESR_ELx_EC_MOPS		(0x27)
 #define ESR_ELx_EC_FP_EXC32	(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
 #define ESR_ELx_EC_FP_EXC64	(0x2C)
@@ -352,6 +352,15 @@
 #define ESR_ELx_SME_ISS_ZA_DISABLED	3
 #define ESR_ELx_SME_ISS_ZT_DISABLED	4
 
+/* ISS field definitions for MOPS exceptions */
+#define ESR_ELx_MOPS_ISS_MEM_INST	(UL(1) << 24)
+#define ESR_ELx_MOPS_ISS_FROM_EPILOGUE	(UL(1) << 18)
+#define ESR_ELx_MOPS_ISS_WRONG_OPTION	(UL(1) << 17)
+#define ESR_ELx_MOPS_ISS_OPTION_A	(UL(1) << 16)
+#define ESR_ELx_MOPS_ISS_DESTREG(esr)	(((esr) & (UL(0x1f) << 10)) >> 10)
+#define ESR_ELx_MOPS_ISS_SRCREG(esr)	(((esr) & (UL(0x1f) << 5)) >> 5)
+#define ESR_ELx_MOPS_ISS_SIZEREG(esr)	(((esr) & (UL(0x1f) << 0)) >> 0)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 92963f98afec..5a6dc3643e9b 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -77,6 +77,7 @@ void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
 void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
+void do_el0_mops(struct pt_regs *regs, unsigned long esr);
 void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167199e3..2ef3ab5d7555 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -611,6 +611,14 @@ static void noinstr el0_bti(struct pt_regs *regs)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_el0_mops(regs, esr);
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -688,6 +696,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_BTI:
 		el0_bti(regs);
 		break;
+	case ESR_ELx_EC_MOPS:
+		el0_mops(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_WATCHPT_LOW:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0ccc063daccb..689188712909 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -507,6 +507,50 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 	die("Oops - FPAC", regs, esr);
 }
 
+void do_el0_mops(struct pt_regs *regs, unsigned long esr)
+{
+	bool wrong_option = esr & ESR_ELx_MOPS_ISS_WRONG_OPTION;
+	bool option_a = esr & ESR_ELx_MOPS_ISS_OPTION_A;
+	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
+	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
+	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
+	unsigned long dst, src, size;
+
+	dst = pt_regs_read_reg(regs, dstreg);
+	src = pt_regs_read_reg(regs, srcreg);
+	size = pt_regs_read_reg(regs, sizereg);
+
+	/*
+	 * Put the registers back in the original format suitable for a
+	 * prologue instruction, using the generic return routine from the
+	 * Arm ARM (DDI 0487I.a) rules CNTMJ and MWFQH.
+	 */
+	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
+		if ((!option_a && wrong_option) || (option_a && !wrong_option)) {
+			pt_regs_write_reg(regs, dstreg, dst + size);
+			pt_regs_write_reg(regs, sizereg, -size);
+		}
+	} else {
+		if ((option_a && wrong_option) || (!option_a && !wrong_option)) {
+			if (regs->pstate & PSR_N_BIT) {
+				pt_regs_write_reg(regs, dstreg, dst - size);
+				pt_regs_write_reg(regs, srcreg, src - size);
+			}
+		} else {
+			if (size & BIT(63)) {
+				pt_regs_write_reg(regs, dstreg, dst + size);
+				pt_regs_write_reg(regs, srcreg, src + size);
+				pt_regs_write_reg(regs, sizereg, -size);
+			}
+		}
+	}
+
+	if (esr & ESR_ELx_MOPS_ISS_FROM_EPILOGUE)
+		regs->pc -= 8;
+	else
+		regs->pc -= 4;
+}
+
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= TASK_SIZE_MAX) {				\
 		res = -EFAULT;					\
@@ -817,6 +861,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
 	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
 	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
+	[ESR_ELx_EC_MOPS]		= "MOPS",
 	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
 	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
 	[ESR_ELx_EC_SERROR]		= "SError",
-- 
2.25.1

