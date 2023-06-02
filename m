Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850C571FA15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjFBG1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjFBG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:26:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67C7E49
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:26:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E621063;
        Thu,  1 Jun 2023 23:27:26 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 783573F67D;
        Thu,  1 Jun 2023 23:26:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/14] arm64/sysreg: Convert TRBLIMITR_EL1 register to automatic generation
Date:   Fri,  2 Jun 2023 11:55:46 +0530
Message-Id: <20230602062552.565992-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602062552.565992-1-anshuman.khandual@arm.com>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
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

This converts TRBLIMITR_EL1 register to automatic generation without
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h              | 12 ------------
 arch/arm64/tools/sysreg                      | 18 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h |  9 ---------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 114d38acdca5..643b7ccf6172 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -235,10 +235,6 @@
 
 /*** End of Statistical Profiling Extension ***/
 
-/*
- * TRBE Registers
- */
-#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
 #define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
 #define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
 #define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
@@ -246,14 +242,6 @@
 #define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
 #define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
 
-#define TRBLIMITR_EL1_LIMIT_MASK	GENMASK_ULL(63, 12)
-#define TRBLIMITR_EL1_LIMIT_SHIFT	12
-#define TRBLIMITR_EL1_nVM		BIT(5)
-#define TRBLIMITR_EL1_TM_MASK		GENMASK(4, 3)
-#define TRBLIMITR_EL1_TM_SHIFT		3
-#define TRBLIMITR_EL1_FM_MASK		GENMASK(2, 1)
-#define TRBLIMITR_EL1_FM_SHIFT		1
-#define TRBLIMITR_EL1_E			BIT(0)
 #define TRBPTR_EL1_PTR_MASK		GENMASK_ULL(63, 0)
 #define TRBPTR_EL1_PTR_SHIFT		0
 #define TRBBASER_EL1_BASE_MASK		GENMASK_ULL(63, 12)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c9a0d1fa3209..a43309607d42 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2200,3 +2200,21 @@ Sysreg	ICC_NMIAR1_EL1	3	0	12	9	5
 Res0	63:24
 Field	23:0	INTID
 EndSysreg
+
+Sysreg	TRBLIMITR_EL1	3	0	9	11	0
+Field	63:12	LIMIT
+Res0	11:7
+Field	6	XE
+Field	5	nVM
+Enum	4:3	TM
+	0b00	STOP
+	0b01	IRQ
+	0b11	IGNR
+EndEnum
+Enum	2:1	FM
+	0b00	FILL
+	0b01	WRAP
+	0b11	CBUF
+EndEnum
+Field	0	E
+EndSysreg
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index d661b062293f..77cbb5c63878 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -84,15 +84,6 @@ static inline bool is_trbe_running(u64 trbsr)
 	return !(trbsr & TRBSR_EL1_S);
 }
 
-#define TRBE_TRIG_MODE_STOP		0
-#define TRBE_TRIG_MODE_IRQ		1
-#define TRBLIMITR_EL1_TM_IGNR		3
-
-#define TRBLIMITR_EL1_FM_FILL		0
-#define TRBE_FILL_MODE_FILL		0
-#define TRBE_FILL_MODE_WRAP		1
-#define TRBE_FILL_MODE_CIRCULAR_BUFFER	3
-
 static inline bool get_trbe_flag_update(u64 trbidr)
 {
 	return trbidr & TRBIDR_EL1_F;
-- 
2.25.1

