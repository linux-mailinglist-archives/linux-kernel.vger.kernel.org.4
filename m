Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30767E3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjA0LmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjA0Llf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:41:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72D5D78AFC;
        Fri, 27 Jan 2023 03:41:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4CE2B;
        Fri, 27 Jan 2023 03:41:24 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 713E03F64C;
        Fri, 27 Jan 2023 03:40:40 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc:     suzuki.poulose@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC kvmtool 19/31] arm64: Don't try to set PSTATE for VCPUs belonging to a realm
Date:   Fri, 27 Jan 2023 11:39:20 +0000
Message-Id: <20230127113932.166089-20-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127113932.166089-1-suzuki.poulose@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoffer Dall <christoffer.dall@arm.com>

RME doesn't allow setting the PSTATE but resets it to an architectural
value, and KVM also does not allow setting this register from user
space, so stop trying to do that.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch64/kvm-cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index e7649239..37f9aa9d 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -92,11 +92,13 @@ static void reset_vcpu_aarch64(struct kvm_cpu *vcpu)
 
 	reg.addr = (u64)&data;
 
-	/* pstate = all interrupts masked */
-	data	= PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | PSR_MODE_EL1h;
-	reg.id	= ARM64_CORE_REG(regs.pstate);
-	if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg) < 0)
-		die_perror("KVM_SET_ONE_REG failed (spsr[EL1])");
+	if (!kvm->cfg.arch.is_realm) {
+		/* pstate = all interrupts masked */
+		data	= PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | PSR_MODE_EL1h;
+		reg.id	= ARM64_CORE_REG(regs.pstate);
+		if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg) < 0)
+			die_perror("KVM_SET_ONE_REG failed (PSTATE)");
+	}
 
 	/* x1...x3 = 0 */
 	data	= 0;
-- 
2.34.1

