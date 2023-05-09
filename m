Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD16FC8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjEIOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjEIOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:23:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61CDC30E3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:23:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B7951063;
        Tue,  9 May 2023 07:24:02 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39FB43F663;
        Tue,  9 May 2023 07:23:15 -0700 (PDT)
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
Subject: [PATCH v2 01/11] KVM: arm64: initialize HCRX_EL2
Date:   Tue,  9 May 2023 15:22:25 +0100
Message-Id: <20230509142235.3284028-2-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509142235.3284028-1-kristina.martsenko@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARMv8.7/9.2 adds a new hypervisor configuration register HCRX_EL2.
Initialize the register to a safe value (all fields 0), to be robust
against firmware that has not initialized it. This is also needed to
ensure that the register is reinitialized after a kexec by a future
kernel.

In addition, move SMPME setup over to the new flags, as it would
otherwise get overridden. It is safe to set the bit even if SME is not
(uniformly) supported, as it will write to a RES0 bit (having no
effect), and SME will be disabled by the cpufeature framework.
(Similar to how e.g. the API bit is handled in HCR_HOST_NVHE_FLAGS.)

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/el2_setup.h | 18 ++++++++++--------
 arch/arm64/include/asm/kvm_arm.h   |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..0201577863ca 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -22,6 +22,15 @@
 	isb
 .endm
 
+.macro __init_el2_hcrx
+	mrs	x0, id_aa64mmfr1_el1
+	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
+	cbz	x0, .Lskip_hcrx_\@
+	mov_q	x0, HCRX_HOST_FLAGS
+	msr_s	SYS_HCRX_EL2, x0
+.Lskip_hcrx_\@:
+.endm
+
 /*
  * Allow Non-secure EL1 and EL0 to access physical timer and counter.
  * This is not necessary for VHE, since the host kernel runs in EL2,
@@ -184,6 +193,7 @@
  */
 .macro init_el2_state
 	__init_el2_sctlr
+	__init_el2_hcrx
 	__init_el2_timers
 	__init_el2_debug
 	__init_el2_lor
@@ -284,14 +294,6 @@
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
index baef29fcbeee..fb7fe28b8eb8 100644
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
-- 
2.25.1

