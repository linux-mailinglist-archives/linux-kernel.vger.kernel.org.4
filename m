Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E270E4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjEWSgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbjEWSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136EF139
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BE6635B6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ACDC433EF;
        Tue, 23 May 2023 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866989;
        bh=gSxLCAUCV6RPVUE1Qap7EtWP0tdGJ920xLzGkpNf2Hk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AOhqJPdsAk/pLy43Fs0rnVL4ZvbBFzzg5PxXojyFXRWGnNaP7ptM1VnCTQ4uX5bTz
         Y3EbSuzQzZKA55u8GjxzQ5NcBu80Jvnwu1OBdDy2oCtzi/+ZEqyGEx0A2Ic2PnU7UR
         ZPjspDsHPFByG3psBJdneRChANVRF+hBrd5SM3bvbxoVKag9SEhTcoNrlg2247qePR
         Zmnvfucc3cQq8U0dlEO9ddaT5yrd2spa4TO6ne43l2nVTKPS+b0Ne8Z0SBixKwOz8Y
         QvSTL/CUz1eztm1xHWjf/CQ3QlRUfOH/i7lx8qd4JkfrKYAMAZx/EP4N0YftPn8uAQ
         OY+ArOv1GiFQA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:36:00 +0100
Subject: [PATCH v2 3/7] arm64/sysreg: Standardise naming of bitfield
 constants in OSL[AS]R_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-3-e0064336e2dd@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-e0064336e2dd@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-e0064336e2dd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gSxLCAUCV6RPVUE1Qap7EtWP0tdGJ920xLzGkpNf2Hk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQee3XiICBLdmd0OeHK1e5ewznmaFHosUQsFNehQ
 7m4jtIuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0HngAKCRAk1otyXVSH0JiNB/
 9Htw/ZN9JAamsjDxYSfbX1czX5qy427lQZ4Z4tqBfvCGrlblnXC4dqXV8cObsNZTAp/y9GGTbzPAmb
 kVKa8PqCJVE6S6a1jaImOCypLeGHThjAH/sJbjMl6RmX0ET34ZH8rw/KHn7Cid46L7UnaE56RkT2PP
 KHz07HhuTAI2m65EUx5fsJwr+u2+T3h9lUG8seCnkwFw6uFhEjjoSRkw7EXKVfNdPFqOny42chpxhA
 ZqkPoFlByB0aXj6VQtoZxeK14zQwGI4nlxHF/LChcU4yk6hxvz/t338AKV7joxbGJqFrCgS+pRaAqY
 wQghPGVG6GsOQ0KnHG4MHZGuu6HGt0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our standard scheme for naming the constants for bitfields in system
registers includes _ELx in the name but not the SYS_, update the
constants for OSL[AS]R_EL1 to follow this convention.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/sysreg.h   | 10 +++++-----
 arch/arm64/kvm/sys_regs.c         | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7e7e19ef6993..e759e6b0cd02 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1031,7 +1031,7 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
 void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_os_lock_enabled(vcpu)		\
-	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & SYS_OSLSR_OSLK))
+	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & OSLSR_EL1_OSLK))
 
 int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 95de1aaee0e9..979975c8be2c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -144,13 +144,13 @@
 #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
 
 #define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
-#define SYS_OSLAR_OSLK			BIT(0)
+#define OSLAR_EL1_OSLK			BIT(0)
 
 #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
-#define SYS_OSLSR_OSLM_MASK		(BIT(3) | BIT(0))
-#define SYS_OSLSR_OSLM_NI		0
-#define SYS_OSLSR_OSLM_IMPLEMENTED	BIT(3)
-#define SYS_OSLSR_OSLK			BIT(1)
+#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
+#define OSLSR_EL1_OSLM_NI		0
+#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
+#define OSLSR_EL1_OSLK			BIT(1)
 
 #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
 #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 71b12094d613..e834d8897843 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -388,9 +388,9 @@ static bool trap_oslar_el1(struct kvm_vcpu *vcpu,
 		return read_from_write_only(vcpu, p, r);
 
 	/* Forward the OSLK bit to OSLSR */
-	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~SYS_OSLSR_OSLK;
-	if (p->regval & SYS_OSLAR_OSLK)
-		oslsr |= SYS_OSLSR_OSLK;
+	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~OSLSR_EL1_OSLK;
+	if (p->regval & OSLAR_EL1_OSLK)
+		oslsr |= OSLSR_EL1_OSLK;
 
 	__vcpu_sys_reg(vcpu, OSLSR_EL1) = oslsr;
 	return true;
@@ -414,7 +414,7 @@ static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	 * The only modifiable bit is the OSLK bit. Refuse the write if
 	 * userspace attempts to change any other bit in the register.
 	 */
-	if ((val ^ rd->val) & ~SYS_OSLSR_OSLK)
+	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
 		return -EINVAL;
 
 	__vcpu_sys_reg(vcpu, rd->reg) = val;
@@ -1781,7 +1781,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
 	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
-		SYS_OSLSR_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
+		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
 	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },

-- 
2.30.2

