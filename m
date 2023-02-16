Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B572699963
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBPQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBPQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:01:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A39454548
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:01:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 127B91042;
        Thu, 16 Feb 2023 08:02:21 -0800 (PST)
Received: from e126864.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37A003F881;
        Thu, 16 Feb 2023 08:01:35 -0800 (PST)
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
Subject: [PATCH 03/10] KVM: arm64: switch HCRX_EL2 between host and guest
Date:   Thu, 16 Feb 2023 16:00:05 +0000
Message-Id: <20230216160012.272345-4-kristina.martsenko@arm.com>
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

Switch the HCRX_EL2 register between host and guest configurations, in
order to enable different features in the host and guest.

Note that the guest flags are only set if all CPUs have HCRX_EL2.
Asymmetric systems where only some CPUs have HCRX_EL2 are not supported
and will result in guests running with the host flags set (and a "SANITY
CHECK" warning printed for the host).

After this change, SMPME is no longer set for guests, which should have
no effect as SME is currently disabled for guests.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---

I wasn't sure what to do about asymmetric systems. It seems a bit
fragile, maybe someone has a better idea?

 arch/arm64/include/asm/kvm_arm.h        | 1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index caa31f4ab1cd..cd8dd307aaba 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -93,6 +93,7 @@
 #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
+#define HCRX_GUEST_FLAGS 0
 #define HCRX_HOST_FLAGS (HCRX_EL2_SMPME)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 07d37ff88a3f..a1bf2d879db5 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -129,6 +129,9 @@ static inline void ___activate_traps(struct kvm_vcpu *vcpu)
 
 	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN) && (hcr & HCR_VSE))
 		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
+
+	if (cpus_have_final_cap(ARM64_HAS_HCX))
+		write_sysreg_s(HCRX_GUEST_FLAGS, SYS_HCRX_EL2);
 }
 
 static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
@@ -143,6 +146,9 @@ static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
 		vcpu->arch.hcr_el2 &= ~HCR_VSE;
 		vcpu->arch.hcr_el2 |= read_sysreg(hcr_el2) & HCR_VSE;
 	}
+
+	if (cpus_have_final_cap(ARM64_HAS_HCX))
+		write_sysreg_s(HCRX_HOST_FLAGS, SYS_HCRX_EL2);
 }
 
 static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
-- 
2.25.1

