Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F391871FA1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjFBG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjFBG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:27:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1832FE52
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:27:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 055FA1042;
        Thu,  1 Jun 2023 23:27:53 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111DE3F67D;
        Thu,  1 Jun 2023 23:27:03 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/14] arm64/sysreg: Convert TRBIDR_EL1 register to automatic generation
Date:   Fri,  2 Jun 2023 11:55:52 +0530
Message-Id: <20230602062552.565992-15-anshuman.khandual@arm.com>
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

This converts TRBIDR_EL1 register to automatic generation without
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
 arch/arm64/include/asm/sysreg.h | 6 ------
 arch/arm64/tools/sysreg         | 9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b3a32a67088f..4f6e60f6c7cf 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -235,14 +235,8 @@
 
 /*** End of Statistical Profiling Extension ***/
 
-#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
-
 #define TRBSR_EL1_BSC_MASK		GENMASK(5, 0)
 #define TRBSR_EL1_BSC_SHIFT		0
-#define TRBIDR_EL1_F			BIT(5)
-#define TRBIDR_EL1_P			BIT(4)
-#define TRBIDR_EL1_Align_MASK		GENMASK(3, 0)
-#define TRBIDR_EL1_Align_SHIFT		0
 
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 98dff7010b86..af823803eca2 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2255,3 +2255,12 @@ Sysreg	TRBTRG_EL1	3	0	9	11	6
 Res0	63:32
 Field	31:0	TRG
 EndSysreg
+
+Sysreg	TRBIDR_EL1	3	0	9	11	7
+Res0	63:12
+Field	11:8	EA
+Res0	7:6
+Field	5	F
+Field	4	P
+Field	3:0	Align
+EndSysreg
-- 
2.25.1

