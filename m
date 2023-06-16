Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B173336B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjFPOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFPOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:22:08 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E02695;
        Fri, 16 Jun 2023 07:22:07 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qAAKy-00G3KG-5o; Fri, 16 Jun 2023 15:22:04 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qAAKx-000hxx-2l;
        Fri, 16 Jun 2023 15:22:03 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-riscv@lists.infradead.org
Cc:     kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, atishp@atishpatra.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] riscv: kvm: define vcpu_sbi_ext_pmu in header
Date:   Fri, 16 Jun 2023 15:22:03 +0100
Message-Id: <20230616142203.168996-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse is giving a warning about vcpu_sbi_ext_pmu not being
defined, so add a definition to the relevant header to fix
the following:

arch/riscv/kvm/vcpu_sbi_pmu.c:81:37: warning: symbol 'vcpu_sbi_ext_pmu' was not declared. Should it be static?

Fixes: cbddc4c4cb9e ("RISC-V: KVM: Add SBI PMU extension support")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - correct the fixes tag as suggested by Conor Dooley
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 3 +++
 arch/riscv/kvm/vcpu_sbi.c             | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 4278125a38a5..b94c7e958da7 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -66,4 +66,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
 
+#ifdef CONFIG_RISCV_PMU_SBI
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
+#endif
 #endif /* __RISCV_KVM_VCPU_SBI_H__ */
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index e52fde504433..c973d92a0ba5 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -20,9 +20,7 @@ static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01 = {
 };
 #endif
 
-#ifdef CONFIG_RISCV_PMU_SBI
-extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
-#else
+#ifndef CONFIG_RISCV_PMU_SBI
 static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu = {
 	.extid_start = -1UL,
 	.extid_end = -1UL,
-- 
2.39.2

