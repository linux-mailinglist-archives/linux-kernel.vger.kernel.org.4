Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09471FA17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjFBG1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjFBG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:27:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD75E5C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:26:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7295D1474;
        Thu,  1 Jun 2023 23:27:31 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F36913F67D;
        Thu,  1 Jun 2023 23:26:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/14] arm64/sysreg: Convert TRBPTR_EL1 register to automatic generation
Date:   Fri,  2 Jun 2023 11:55:47 +0530
Message-Id: <20230602062552.565992-10-anshuman.khandual@arm.com>
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

This converts TRBPTR_EL1 register to automatic generation without
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
 arch/arm64/include/asm/sysreg.h | 3 ---
 arch/arm64/tools/sysreg         | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 643b7ccf6172..13b144075381 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -235,15 +235,12 @@
 
 /*** End of Statistical Profiling Extension ***/
 
-#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
 #define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
 #define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
 #define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
 #define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
 #define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
 
-#define TRBPTR_EL1_PTR_MASK		GENMASK_ULL(63, 0)
-#define TRBPTR_EL1_PTR_SHIFT		0
 #define TRBBASER_EL1_BASE_MASK		GENMASK_ULL(63, 12)
 #define TRBBASER_EL1_BASE_SHIFT		12
 #define TRBSR_EL1_EC_MASK		GENMASK(31, 26)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a43309607d42..ad6da3ea1cd5 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2218,3 +2218,7 @@ Enum	2:1	FM
 EndEnum
 Field	0	E
 EndSysreg
+
+Sysreg	TRBPTR_EL1	3	0	9	11	1
+Field	63:0	PTR
+EndSysreg
-- 
2.25.1

