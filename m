Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0D70E4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbjEWSiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbjEWShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15C196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B199D62DAB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2BAC433EF;
        Tue, 23 May 2023 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867040;
        bh=gSxLCAUCV6RPVUE1Qap7EtWP0tdGJ920xLzGkpNf2Hk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TtQNdJkKcOkYN/D3Tet3X9vgiR2Ib6t/ImwmhszFWSqVGE6ZiWuP3xKugYWH8Z83p
         2ncIBUgRX1bphSViWKScGmFzeScIHb8UQszkuC/wbTkP+0qwpmtnfVMu3IFMpvF7Pp
         ocNZf+v4Hjt6O4UvoBrzexW3vOuUoOy0JXnIqwrwZHHOeROKrjf4H4b5UTkdl3LCIg
         B0dAxboH/99SbnrGNKJ847kvw8twTvjItwGTTjy+r00CmCYHkM4XOOMpCZENAvDg4N
         2/duVdiAm+maenT394UIFqbanr889KVxP6jZ42XPW8lkgPupj6vrPr2Re8HNjGIjOZ
         MvWjEujxbc8tA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:01 +0100
Subject: [PATCH v2 3/7] arm64/sysreg: Standardise naming of bitfield
 constants in OSL[AS]R_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-3-4c6add1f6257@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfR73/Q0St/2vaw/RMqWlwmOA3S+gAyS3FBlhZG
 K9J+/JiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H0QAKCRAk1otyXVSH0M3CB/
 9+txif1N+MGKDLaN9BFPGWrdZxbUIRED1gGJYEDM24XqcUF9PZXpFy+ipzgL47TIAsL5eEo4cItgHI
 Tkv4bedJSXZF5j5jfd/a6LewgCWeHX1uOlbvWbWyxki8i/UiibyFN753sFpfZBBzWwvTdpMIcC+oGY
 PYZW1uSXpYlfaDUVoAj13DFJTezqJ2T8gRqpX26JPvJZxtfrmHcM5rD82hLV911akcDbRWj9/o61DY
 dntc97hs9Oy7tFbQK8GctGgCT9ipt8QX2VGWqZzGrrrkLUBw9v+STBgQm8+JhXS5NQj5pV5WGHan+J
 p+q+FikGQp8J56R7AT+aQ8AGDRr0Ef
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

