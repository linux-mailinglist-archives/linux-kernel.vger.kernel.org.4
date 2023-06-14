Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533872F550
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjFNHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbjFNHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:01:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E4E82130
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:00:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31232F4;
        Wed, 14 Jun 2023 00:01:41 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B05A3F663;
        Wed, 14 Jun 2023 00:00:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 10/14] arm64/sysreg: Convert TRBBASER_EL1 register to automatic generation
Date:   Wed, 14 Jun 2023 12:29:45 +0530
Message-Id: <20230614065949.146187-11-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614065949.146187-1-anshuman.khandual@arm.com>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
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

This converts TRBBASER_EL1 register to automatic generation without
causing any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 3 ---
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6f2a0bef1db8..72765f0df4c5 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -241,14 +241,11 @@
 
 /*** End of Statistical Profiling Extension ***/
 
-#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
 #define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
 #define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
 #define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
 #define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
 
-#define TRBBASER_EL1_BASE_MASK		GENMASK_ULL(63, 12)
-#define TRBBASER_EL1_BASE_SHIFT		12
 #define TRBSR_EL1_EC_MASK		GENMASK(31, 26)
 #define TRBSR_EL1_EC_SHIFT		26
 #define TRBSR_EL1_IRQ			BIT(22)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ad6da3ea1cd5..c58731f69467 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2222,3 +2222,8 @@ EndSysreg
 Sysreg	TRBPTR_EL1	3	0	9	11	1
 Field	63:0	PTR
 EndSysreg
+
+Sysreg	TRBBASER_EL1	3	0	9	11	2
+Field	63:12	BASE
+Res0	11:0
+EndSysreg
-- 
2.25.1

