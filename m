Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F3623942
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiKJByW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiKJByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:54:20 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F526311
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:54:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668045253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0K3at+tNKaP0/XbZ4HFUAvRHCj+YDnrPrqun7nyIUM=;
        b=L3Jgqsb2RQ7n2NJlQBeisEZTDbrDv5ycAnr166nq5KUJ/G8ftX5TI388ZxauPxR6teuHwI
        cT5+4sobg/U8kItzFxpwyVOKmM7rVKLn+5go2Nr2uEOFEtkNPxkWqBkIGq5fYMIJI8OVIK
        2jAPmOs29OSkml5yXjsu1qSzli+SOfs=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] KVM: arm64: Use a generalized accessor for SMCCC args
Date:   Thu, 10 Nov 2022 01:53:25 +0000
Message-Id: <20221110015327.3389351-2-oliver.upton@linux.dev>
In-Reply-To: <20221110015327.3389351-1-oliver.upton@linux.dev>
References: <20221110015327.3389351-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the need to introduce yet another accessor for every argument
position with a generalized one instead. Align with the SMCCC
specification and count arguments starting from 1.

No functional change intended.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_hypercalls.h | 22 ++++++++--------------
 arch/arm64/kvm/hypercalls.c             |  4 ++--
 arch/arm64/kvm/psci.c                   | 14 +++++++-------
 arch/arm64/kvm/pvtime.c                 |  2 +-
 arch/arm64/kvm/trng.c                   |  4 ++--
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hypercalls.h b/arch/arm64/include/asm/kvm_hypercalls.h
index dfebe8dd8dcd..c30d6ae76000 100644
--- a/arch/arm64/include/asm/kvm_hypercalls.h
+++ b/arch/arm64/include/asm/kvm_hypercalls.h
@@ -13,20 +13,14 @@ static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
 	return vcpu_get_reg(vcpu, 0);
 }
 
-static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 1);
-}
-
-static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 2);
-}
-
-static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 3);
-}
+#define smccc_get_arg(vcpu, arg)			\
+({							\
+	u64 __val;					\
+							\
+	BUILD_BUG_ON(arg < 1 || arg > 17);		\
+	__val = vcpu_get_reg(vcpu, arg);		\
+	__val;						\
+})
 
 static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 				    unsigned long a0,
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 6804075ce57f..62ce45d0d957 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -40,7 +40,7 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	 * (virtual or physical) with the first argument of the SMCCC
 	 * call. In case the identifier is not supported, error out.
 	 */
-	feature = smccc_get_arg1(vcpu);
+	feature = smccc_get_arg(vcpu, 1);
 	switch (feature) {
 	case KVM_PTP_VIRT_COUNTER:
 		cycles = systime_snapshot.cycles - vcpu_read_sys_reg(vcpu, CNTVOFF_EL2);
@@ -136,7 +136,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		val[0] = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		feature = smccc_get_arg1(vcpu);
+		feature = smccc_get_arg(vcpu, 1);
 		switch (feature) {
 		case ARM_SMCCC_ARCH_WORKAROUND_1:
 			switch (arm64_get_spectre_v2_state()) {
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 809710808b25..15a380858ccb 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -63,7 +63,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	struct kvm_vcpu *vcpu = NULL;
 	unsigned long cpu_id;
 
-	cpu_id = smccc_get_arg1(source_vcpu);
+	cpu_id = smccc_get_arg(source_vcpu, 1);
 	if (!kvm_psci_valid_affinity(source_vcpu, cpu_id))
 		return PSCI_RET_INVALID_PARAMS;
 
@@ -84,7 +84,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 
 	reset_state = &vcpu->arch.reset_state;
 
-	reset_state->pc = smccc_get_arg2(source_vcpu);
+	reset_state->pc = smccc_get_arg(source_vcpu, 2);
 
 	/* Propagate caller endianness */
 	reset_state->be = kvm_vcpu_is_be(source_vcpu);
@@ -93,7 +93,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general purpose registers are undefined upon CPU_ON.
 	 */
-	reset_state->r0 = smccc_get_arg3(source_vcpu);
+	reset_state->r0 = smccc_get_arg(source_vcpu, 3);
 
 	WRITE_ONCE(reset_state->reset, true);
 	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
@@ -120,8 +120,8 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
-	target_affinity = smccc_get_arg1(vcpu);
-	lowest_affinity_level = smccc_get_arg2(vcpu);
+	target_affinity = smccc_get_arg(vcpu, 1);
+	lowest_affinity_level = smccc_get_arg(vcpu, 2);
 
 	if (!kvm_psci_valid_affinity(vcpu, target_affinity))
 		return PSCI_RET_INVALID_PARAMS;
@@ -317,7 +317,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 		val = minor == 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
 		break;
 	case PSCI_1_0_FN_PSCI_FEATURES:
-		arg = smccc_get_arg1(vcpu);
+		arg = smccc_get_arg(vcpu, 1);
 		val = kvm_psci_check_allowed_function(vcpu, arg);
 		if (val)
 			break;
@@ -371,7 +371,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 		fallthrough;
 	case PSCI_1_1_FN64_SYSTEM_RESET2:
 		if (minor >= 1) {
-			arg = smccc_get_arg1(vcpu);
+			arg = smccc_get_arg(vcpu, 1);
 
 			if (arg <= PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET ||
 			    arg >= PSCI_1_1_RESET_TYPE_VENDOR_START) {
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 614b2e70b815..587eadf77f29 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -33,7 +33,7 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
 {
-	u32 feature = smccc_get_arg1(vcpu);
+	u32 feature = smccc_get_arg(vcpu, 1);
 	long val = SMCCC_RET_NOT_SUPPORTED;
 
 	switch (feature) {
diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
index b257d4eace50..953cb0d1b6ff 100644
--- a/arch/arm64/kvm/trng.c
+++ b/arch/arm64/kvm/trng.c
@@ -23,7 +23,7 @@ static const uuid_t arm_smc_trng_uuid __aligned(4) = UUID_INIT(
 static int kvm_trng_do_rnd(struct kvm_vcpu *vcpu, int size)
 {
 	DECLARE_BITMAP(bits, TRNG_MAX_BITS64);
-	u32 num_bits = smccc_get_arg1(vcpu);
+	u32 num_bits = smccc_get_arg(vcpu, 1);
 	int i;
 
 	if (num_bits > 3 * size) {
@@ -59,7 +59,7 @@ int kvm_trng_call(struct kvm_vcpu *vcpu)
 		val = ARM_SMCCC_TRNG_VERSION_1_0;
 		break;
 	case ARM_SMCCC_TRNG_FEATURES:
-		switch (smccc_get_arg1(vcpu)) {
+		switch (smccc_get_arg(vcpu, 1)) {
 		case ARM_SMCCC_TRNG_VERSION:
 		case ARM_SMCCC_TRNG_FEATURES:
 		case ARM_SMCCC_TRNG_GET_UUID:
-- 
2.38.1.431.g37b22c650d-goog

