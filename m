Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC8699961
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBPQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:01:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F8256487
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:01:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CF3113E;
        Thu, 16 Feb 2023 08:02:12 -0800 (PST)
Received: from e126864.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83E83F881;
        Thu, 16 Feb 2023 08:01:26 -0800 (PST)
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
Subject: [PATCH 01/10] KVM: arm64: initialize HCRX_EL2
Date:   Thu, 16 Feb 2023 16:00:03 +0000
Message-Id: <20230216160012.272345-2-kristina.martsenko@arm.com>
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

ARMv8.7/9.2 adds a new hypervisor configuration register HCRX_EL2.
Initialize the register to a safe value (all fields 0), to be robust
against firmware that has not initialized it. This is also needed to
ensure that the register is reinitialized after kexec.

In addition, move SMPME setup over to the new flags, as it would
otherwise get overridden. It is safe to set the bit even if SME is not
(uniformly) supported, as it will write to a RES0 bit (having no
effect), and SME will be disabled by the cpufeature framework.
(Similar to how e.g. the API bit is handled in HCR_HOST_NVHE_FLAGS.)

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/el2_setup.h | 8 --------
 arch/arm64/include/asm/kvm_arm.h   | 3 +++
 arch/arm64/kernel/head.S           | 7 +++++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 6 ++++++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index e62785923ff6..699154229b15 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -284,14 +284,6 @@
 	cbz     x1, .Lskip_sme_\@
 
 	msr_s	SYS_SMPRIMAP_EL2, xzr		// Make all priorities equal
-
-	mrs	x1, id_aa64mmfr1_el1		// HCRX_EL2 present?
-	ubfx	x1, x1, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
-	cbz	x1, .Lskip_sme_\@
-
-	mrs_s	x1, SYS_HCRX_EL2
-	orr	x1, x1, #HCRX_EL2_SMPME_MASK	// Enable priority mapping
-	msr_s	SYS_HCRX_EL2, x1
 .Lskip_sme_\@:
 .endm
 
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 5a4b2342d571..caa31f4ab1cd 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -9,6 +9,7 @@
 
 #include <asm/esr.h>
 #include <asm/memory.h>
+#include <asm/sysreg.h>
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
@@ -92,6 +93,8 @@
 #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
+#define HCRX_HOST_FLAGS (HCRX_EL2_SMPME)
+
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))
 #define TCR_EL2_TBI		(1 << 20)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 212d93aca5e6..e06b34322339 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -572,6 +572,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	hcr_el2, x0
 	isb
 
+	mrs	x0, ID_AA64MMFR1_EL1
+	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
+	cbz	x0, 3f
+	mov_q	x1, HCRX_HOST_FLAGS
+	msr_s	SYS_HCRX_EL2, x1
+	isb
+3:
 	init_el2_state
 
 	/* Hypervisor stub */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index a6d67c2bb5ae..01f854697c70 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -95,6 +95,12 @@ SYM_CODE_START_LOCAL(___kvm_hyp_init)
 	ldr	x1, [x0, #NVHE_INIT_HCR_EL2]
 	msr	hcr_el2, x1
 
+	mrs	x1, ID_AA64MMFR1_EL1
+	ubfx	x1, x1, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
+	cbz	x1, 1f
+	mov_q	x2, HCRX_HOST_FLAGS
+	msr_s	SYS_HCRX_EL2, x2
+1:
 	ldr	x1, [x0, #NVHE_INIT_VTTBR]
 	msr	vttbr_el2, x1
 
-- 
2.25.1

