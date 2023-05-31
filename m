Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8E717668
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjEaFzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEaFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:55:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB880EE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:55:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA1C1042;
        Tue, 30 May 2023 22:56:19 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B2CA3F6C4;
        Tue, 30 May 2023 22:55:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, coresight@lists.linaro.org
Subject: [PATCH] arm64/sysreg: Convert TRBE registers to automatic generation
Date:   Wed, 31 May 2023 11:25:24 +0530
Message-Id: <20230531055524.16562-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
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

This converts all TRBE related registers to automatic generation and update
the driver as required. This does not cause any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.linux.dev
Cc: coresight@lists.linaro.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.4-rc4.

 arch/arm64/include/asm/el2_setup.h           |  2 +-
 arch/arm64/include/asm/sysreg.h              | 49 ----------------
 arch/arm64/kvm/debug.c                       |  2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  2 +-
 arch/arm64/tools/sysreg                      | 59 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.c | 33 +++++------
 drivers/hwtracing/coresight/coresight-trbe.h | 38 +++++--------
 7 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..80e0460ca8bb 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -69,7 +69,7 @@
 	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
 
 	mrs_s	x0, SYS_TRBIDR_EL1
-	and	x0, x0, TRBIDR_PROG
+	and	x0, x0, TRBIDR_EL1_PROG
 	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
 
 	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e72d9aaab6b1..51d97ea89972 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -235,55 +235,6 @@
 
 /*** End of Statistical Profiling Extension ***/
 
-/*
- * TRBE Registers
- */
-#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
-#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
-#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
-#define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
-#define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
-#define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
-#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
-
-#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
-#define TRBLIMITR_LIMIT_SHIFT		12
-#define TRBLIMITR_NVM			BIT(5)
-#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
-#define TRBLIMITR_TRIG_MODE_SHIFT	3
-#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
-#define TRBLIMITR_FILL_MODE_SHIFT	1
-#define TRBLIMITR_ENABLE		BIT(0)
-#define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
-#define TRBPTR_PTR_SHIFT		0
-#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
-#define TRBBASER_BASE_SHIFT		12
-#define TRBSR_EC_MASK			GENMASK(5, 0)
-#define TRBSR_EC_SHIFT			26
-#define TRBSR_IRQ			BIT(22)
-#define TRBSR_TRG			BIT(21)
-#define TRBSR_WRAP			BIT(20)
-#define TRBSR_ABORT			BIT(18)
-#define TRBSR_STOP			BIT(17)
-#define TRBSR_MSS_MASK			GENMASK(15, 0)
-#define TRBSR_MSS_SHIFT			0
-#define TRBSR_BSC_MASK			GENMASK(5, 0)
-#define TRBSR_BSC_SHIFT			0
-#define TRBSR_FSC_MASK			GENMASK(5, 0)
-#define TRBSR_FSC_SHIFT			0
-#define TRBMAR_SHARE_MASK		GENMASK(1, 0)
-#define TRBMAR_SHARE_SHIFT		8
-#define TRBMAR_OUTER_MASK		GENMASK(3, 0)
-#define TRBMAR_OUTER_SHIFT		4
-#define TRBMAR_INNER_MASK		GENMASK(3, 0)
-#define TRBMAR_INNER_SHIFT		0
-#define TRBTRG_TRG_MASK			GENMASK(31, 0)
-#define TRBTRG_TRG_SHIFT		0
-#define TRBIDR_FLAG			BIT(5)
-#define TRBIDR_PROG			BIT(4)
-#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
-#define TRBIDR_ALIGN_SHIFT		0
-
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 55f80fb93925..e09b9607ed52 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -333,7 +333,7 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 
 	/* Check if we have TRBE implemented and available at the host */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
-	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
+	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_PROG))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index d756b939f296..9b08f8b498fe 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -56,7 +56,7 @@ static void __debug_save_trace(u64 *trfcr_el1)
 	*trfcr_el1 = 0;
 
 	/* Check if the TRBE is enabled */
-	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_ENABLE))
+	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_ENABLE))
 		return;
 	/*
 	 * Prohibit trace generation while we are in guest.
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c9a0d1fa3209..2396fa550251 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2200,3 +2200,62 @@ Sysreg	ICC_NMIAR1_EL1	3	0	12	9	5
 Res0	63:24
 Field	23:0	INTID
 EndSysreg
+
+Sysreg	TRBLIMITR_EL1	3	0	9	11	0
+Field	63:12	LIMIT
+Res0	11:6
+Field	5	NVM
+Enum	4:3	TRIG_MODE
+	0b00	STOP
+	0b01	IRQ
+	0b11	IGNR
+EndEnum
+Enum	2:1	FILL_MODE
+	0b00	FILL
+	0b01	WRAP
+	0b11	CBUF
+EndEnum
+Field	0	ENABLE
+EndSysreg
+
+Sysreg	TRBPTR_EL1	3	0	9	11	1
+Field	63:0	PTR
+EndSysreg
+
+Sysreg	TRBBASER_EL1	3	0	9	11	2
+Field	63:12	BASE
+Res0	11:0
+EndSysreg
+
+Sysreg	TRBSR_EL1	3	0	9	11	3
+Res0	63:32
+Field	31:26	EC
+Res0	25:23
+Field	22	IRQ
+Field	21	TRG
+Field	20	WRAP
+Res0	19
+Field	18	ABORT
+Field	17	STOP
+Res0	16
+Res0	15:6
+Field	5:0	BSC
+EndSysreg
+
+Sysreg	TRBMAR_EL1	3	0	9	11	4
+Res0	63:10
+Field	9:8	SH
+Field	7:0	ATTR
+EndSysreg
+
+Sysreg	TRBTRG_EL1	3	0	9	11	6
+Res0	63:32
+Field	31:0	TRG
+EndSysreg
+
+Sysreg	TRBIDR_EL1	3	0	9	11	7
+Res0	63:6
+Field	5	FLAG
+Field	4	PROG
+Field	3:0	ALIGN
+EndSysreg
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 1fc4fd79a1c6..f8f6adb5b0f5 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -218,7 +218,7 @@ static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
 	 * Enable the TRBE without clearing LIMITPTR which
 	 * might be required for fetching the buffer limits.
 	 */
-	trblimitr |= TRBLIMITR_ENABLE;
+	trblimitr |= TRBLIMITR_EL1_ENABLE;
 	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
 
 	/* Synchronize the TRBE enable event */
@@ -236,7 +236,7 @@ static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
 	 * Disable the TRBE without clearing LIMITPTR which
 	 * might be required for fetching the buffer limits.
 	 */
-	trblimitr &= ~TRBLIMITR_ENABLE;
+	trblimitr &= ~TRBLIMITR_EL1_ENABLE;
 	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
 
 	if (trbe_needs_drain_after_disable(cpudata))
@@ -582,12 +582,12 @@ static void clr_trbe_status(void)
 	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
 
 	WARN_ON(is_trbe_enabled());
-	trbsr &= ~TRBSR_IRQ;
-	trbsr &= ~TRBSR_TRG;
-	trbsr &= ~TRBSR_WRAP;
-	trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
-	trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
-	trbsr &= ~TRBSR_STOP;
+	trbsr &= ~TRBSR_EL1_IRQ;
+	trbsr &= ~TRBSR_EL1_TRG;
+	trbsr &= ~TRBSR_EL1_WRAP;
+	trbsr &= ~TRBSR_EL1_EC_MASK;
+	trbsr &= ~TRBSR_EL1_BSC_MASK;
+	trbsr &= ~TRBSR_EL1_STOP;
 	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
 }
 
@@ -596,13 +596,13 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 	unsigned long addr = buf->trbe_limit;
 
-	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_EL1_LIMIT_SHIFT)));
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 
-	trblimitr &= ~TRBLIMITR_NVM;
-	trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
-	trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
-	trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
+	trblimitr &= ~TRBLIMITR_EL1_NVM;
+	trblimitr &= ~TRBLIMITR_EL1_FILL_MODE_MASK;
+	trblimitr &= ~TRBLIMITR_EL1_TRIG_MODE_MASK;
+	trblimitr &= ~TRBLIMITR_EL1_LIMIT_MASK;
 
 	/*
 	 * Fill trace buffer mode is used here while configuring the
@@ -613,14 +613,15 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 	 * trace data in the interrupt handler, before reconfiguring
 	 * the TRBE.
 	 */
-	trblimitr |= (TRBE_FILL_MODE_FILL & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
+	trblimitr |= (TRBLIMITR_EL1_FILL_MODE_FILL << TRBLIMITR_EL1_FILL_MODE_SHIFT) &
+		     TRBLIMITR_EL1_FILL_MODE_MASK;
 
 	/*
 	 * Trigger mode is not used here while configuring the TRBE for
 	 * the trace capture. Hence just keep this in the ignore mode.
 	 */
-	trblimitr |= (TRBE_TRIG_MODE_IGNORE & TRBLIMITR_TRIG_MODE_MASK) <<
-		      TRBLIMITR_TRIG_MODE_SHIFT;
+	trblimitr |= (TRBLIMITR_EL1_TRIG_MODE_IGNR << TRBLIMITR_EL1_TRIG_MODE_SHIFT) &
+		     TRBLIMITR_EL1_TRIG_MODE_MASK;
 	trblimitr |= (addr & PAGE_MASK);
 	set_trbe_enabled(buf->cpudata, trblimitr);
 }
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 98ff1b17ad07..be0ef7c9b4e6 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -30,7 +30,7 @@ static inline bool is_trbe_enabled(void)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
-	return trblimitr & TRBLIMITR_ENABLE;
+	return trblimitr & TRBLIMITR_EL1_ENABLE;
 }
 
 #define TRBE_EC_OTHERS		0
@@ -39,7 +39,7 @@ static inline bool is_trbe_enabled(void)
 
 static inline int get_trbe_ec(u64 trbsr)
 {
-	return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
+	return (trbsr & TRBSR_EL1_EC_MASK) >> TRBSR_EL1_EC_SHIFT;
 }
 
 #define TRBE_BSC_NOT_STOPPED 0
@@ -48,63 +48,55 @@ static inline int get_trbe_ec(u64 trbsr)
 
 static inline int get_trbe_bsc(u64 trbsr)
 {
-	return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
+	return (trbsr & TRBSR_EL1_BSC_MASK) >> TRBSR_EL1_BSC_SHIFT;
 }
 
 static inline void clr_trbe_irq(void)
 {
 	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
 
-	trbsr &= ~TRBSR_IRQ;
+	trbsr &= ~TRBSR_EL1_IRQ;
 	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
 }
 
 static inline bool is_trbe_irq(u64 trbsr)
 {
-	return trbsr & TRBSR_IRQ;
+	return trbsr & TRBSR_EL1_IRQ;
 }
 
 static inline bool is_trbe_trg(u64 trbsr)
 {
-	return trbsr & TRBSR_TRG;
+	return trbsr & TRBSR_EL1_TRG;
 }
 
 static inline bool is_trbe_wrap(u64 trbsr)
 {
-	return trbsr & TRBSR_WRAP;
+	return trbsr & TRBSR_EL1_WRAP;
 }
 
 static inline bool is_trbe_abort(u64 trbsr)
 {
-	return trbsr & TRBSR_ABORT;
+	return trbsr & TRBSR_EL1_ABORT;
 }
 
 static inline bool is_trbe_running(u64 trbsr)
 {
-	return !(trbsr & TRBSR_STOP);
+	return !(trbsr & TRBSR_EL1_STOP);
 }
 
-#define TRBE_TRIG_MODE_STOP		0
-#define TRBE_TRIG_MODE_IRQ		1
-#define TRBE_TRIG_MODE_IGNORE		3
-
-#define TRBE_FILL_MODE_FILL		0
-#define TRBE_FILL_MODE_WRAP		1
-#define TRBE_FILL_MODE_CIRCULAR_BUFFER	3
-
 static inline bool get_trbe_flag_update(u64 trbidr)
 {
-	return trbidr & TRBIDR_FLAG;
+	return trbidr & TRBIDR_EL1_FLAG;
 }
 
 static inline bool is_trbe_programmable(u64 trbidr)
 {
-	return !(trbidr & TRBIDR_PROG);
+	return !(trbidr & TRBIDR_EL1_PROG);
 }
 
 static inline int get_trbe_address_align(u64 trbidr)
 {
-	return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
+	return (trbidr & TRBIDR_EL1_ALIGN_MASK) >> TRBIDR_EL1_ALIGN_SHIFT;
 }
 
 static inline unsigned long get_trbe_write_pointer(void)
@@ -121,7 +113,7 @@ static inline void set_trbe_write_pointer(unsigned long addr)
 static inline unsigned long get_trbe_limit_pointer(void)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
-	unsigned long addr = trblimitr & (TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
+	unsigned long addr = trblimitr & TRBLIMITR_EL1_LIMIT_MASK;
 
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	return addr;
@@ -130,7 +122,7 @@ static inline unsigned long get_trbe_limit_pointer(void)
 static inline unsigned long get_trbe_base_pointer(void)
 {
 	u64 trbbaser = read_sysreg_s(SYS_TRBBASER_EL1);
-	unsigned long addr = trbbaser & (TRBBASER_BASE_MASK << TRBBASER_BASE_SHIFT);
+	unsigned long addr = trbbaser & TRBBASER_EL1_BASE_MASK;
 
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	return addr;
@@ -139,7 +131,7 @@ static inline unsigned long get_trbe_base_pointer(void)
 static inline void set_trbe_base_pointer(unsigned long addr)
 {
 	WARN_ON(is_trbe_enabled());
-	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBBASER_BASE_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBBASER_EL1_BASE_SHIFT)));
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	write_sysreg_s(addr, SYS_TRBBASER_EL1);
 }
-- 
2.25.1

