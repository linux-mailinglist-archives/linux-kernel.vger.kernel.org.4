Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250265E340
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjAEDLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAEDLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:11:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96B5D10B6D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:10:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E70165C;
        Wed,  4 Jan 2023 19:11:41 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 817393F663;
        Wed,  4 Jan 2023 19:10:56 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH V7 2/6] arm64/perf: Add BRBE registers and fields
Date:   Thu,  5 Jan 2023 08:40:35 +0530
Message-Id: <20230105031039.207972-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105031039.207972-1-anshuman.khandual@arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds BRBE related register definitions and various other related field
macros there in. These will be used subsequently in a BRBE driver which is
being added later on.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 103 ++++++++++++++++++++
 arch/arm64/tools/sysreg         | 161 ++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b..05b70e8b7f83 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -165,6 +165,109 @@
 #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
 #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
 
+#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
+#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
+#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))
+
+#define SYS_BRBINF0_EL1			__SYS_BRBINFO(0)
+#define SYS_BRBINF1_EL1			__SYS_BRBINFO(1)
+#define SYS_BRBINF2_EL1			__SYS_BRBINFO(2)
+#define SYS_BRBINF3_EL1			__SYS_BRBINFO(3)
+#define SYS_BRBINF4_EL1			__SYS_BRBINFO(4)
+#define SYS_BRBINF5_EL1			__SYS_BRBINFO(5)
+#define SYS_BRBINF6_EL1			__SYS_BRBINFO(6)
+#define SYS_BRBINF7_EL1			__SYS_BRBINFO(7)
+#define SYS_BRBINF8_EL1			__SYS_BRBINFO(8)
+#define SYS_BRBINF9_EL1			__SYS_BRBINFO(9)
+#define SYS_BRBINF10_EL1		__SYS_BRBINFO(10)
+#define SYS_BRBINF11_EL1		__SYS_BRBINFO(11)
+#define SYS_BRBINF12_EL1		__SYS_BRBINFO(12)
+#define SYS_BRBINF13_EL1		__SYS_BRBINFO(13)
+#define SYS_BRBINF14_EL1		__SYS_BRBINFO(14)
+#define SYS_BRBINF15_EL1		__SYS_BRBINFO(15)
+#define SYS_BRBINF16_EL1		__SYS_BRBINFO(16)
+#define SYS_BRBINF17_EL1		__SYS_BRBINFO(17)
+#define SYS_BRBINF18_EL1		__SYS_BRBINFO(18)
+#define SYS_BRBINF19_EL1		__SYS_BRBINFO(19)
+#define SYS_BRBINF20_EL1		__SYS_BRBINFO(20)
+#define SYS_BRBINF21_EL1		__SYS_BRBINFO(21)
+#define SYS_BRBINF22_EL1		__SYS_BRBINFO(22)
+#define SYS_BRBINF23_EL1		__SYS_BRBINFO(23)
+#define SYS_BRBINF24_EL1		__SYS_BRBINFO(24)
+#define SYS_BRBINF25_EL1		__SYS_BRBINFO(25)
+#define SYS_BRBINF26_EL1		__SYS_BRBINFO(26)
+#define SYS_BRBINF27_EL1		__SYS_BRBINFO(27)
+#define SYS_BRBINF28_EL1		__SYS_BRBINFO(28)
+#define SYS_BRBINF29_EL1		__SYS_BRBINFO(29)
+#define SYS_BRBINF30_EL1		__SYS_BRBINFO(30)
+#define SYS_BRBINF31_EL1		__SYS_BRBINFO(31)
+
+#define SYS_BRBSRC0_EL1			__SYS_BRBSRC(0)
+#define SYS_BRBSRC1_EL1			__SYS_BRBSRC(1)
+#define SYS_BRBSRC2_EL1			__SYS_BRBSRC(2)
+#define SYS_BRBSRC3_EL1			__SYS_BRBSRC(3)
+#define SYS_BRBSRC4_EL1			__SYS_BRBSRC(4)
+#define SYS_BRBSRC5_EL1			__SYS_BRBSRC(5)
+#define SYS_BRBSRC6_EL1			__SYS_BRBSRC(6)
+#define SYS_BRBSRC7_EL1			__SYS_BRBSRC(7)
+#define SYS_BRBSRC8_EL1			__SYS_BRBSRC(8)
+#define SYS_BRBSRC9_EL1			__SYS_BRBSRC(9)
+#define SYS_BRBSRC10_EL1		__SYS_BRBSRC(10)
+#define SYS_BRBSRC11_EL1		__SYS_BRBSRC(11)
+#define SYS_BRBSRC12_EL1		__SYS_BRBSRC(12)
+#define SYS_BRBSRC13_EL1		__SYS_BRBSRC(13)
+#define SYS_BRBSRC14_EL1		__SYS_BRBSRC(14)
+#define SYS_BRBSRC15_EL1		__SYS_BRBSRC(15)
+#define SYS_BRBSRC16_EL1		__SYS_BRBSRC(16)
+#define SYS_BRBSRC17_EL1		__SYS_BRBSRC(17)
+#define SYS_BRBSRC18_EL1		__SYS_BRBSRC(18)
+#define SYS_BRBSRC19_EL1		__SYS_BRBSRC(19)
+#define SYS_BRBSRC20_EL1		__SYS_BRBSRC(20)
+#define SYS_BRBSRC21_EL1		__SYS_BRBSRC(21)
+#define SYS_BRBSRC22_EL1		__SYS_BRBSRC(22)
+#define SYS_BRBSRC23_EL1		__SYS_BRBSRC(23)
+#define SYS_BRBSRC24_EL1		__SYS_BRBSRC(24)
+#define SYS_BRBSRC25_EL1		__SYS_BRBSRC(25)
+#define SYS_BRBSRC26_EL1		__SYS_BRBSRC(26)
+#define SYS_BRBSRC27_EL1		__SYS_BRBSRC(27)
+#define SYS_BRBSRC28_EL1		__SYS_BRBSRC(28)
+#define SYS_BRBSRC29_EL1		__SYS_BRBSRC(29)
+#define SYS_BRBSRC30_EL1		__SYS_BRBSRC(30)
+#define SYS_BRBSRC31_EL1		__SYS_BRBSRC(31)
+
+#define SYS_BRBTGT0_EL1			__SYS_BRBTGT(0)
+#define SYS_BRBTGT1_EL1			__SYS_BRBTGT(1)
+#define SYS_BRBTGT2_EL1			__SYS_BRBTGT(2)
+#define SYS_BRBTGT3_EL1			__SYS_BRBTGT(3)
+#define SYS_BRBTGT4_EL1			__SYS_BRBTGT(4)
+#define SYS_BRBTGT5_EL1			__SYS_BRBTGT(5)
+#define SYS_BRBTGT6_EL1			__SYS_BRBTGT(6)
+#define SYS_BRBTGT7_EL1			__SYS_BRBTGT(7)
+#define SYS_BRBTGT8_EL1			__SYS_BRBTGT(8)
+#define SYS_BRBTGT9_EL1			__SYS_BRBTGT(9)
+#define SYS_BRBTGT10_EL1		__SYS_BRBTGT(10)
+#define SYS_BRBTGT11_EL1		__SYS_BRBTGT(11)
+#define SYS_BRBTGT12_EL1		__SYS_BRBTGT(12)
+#define SYS_BRBTGT13_EL1		__SYS_BRBTGT(13)
+#define SYS_BRBTGT14_EL1		__SYS_BRBTGT(14)
+#define SYS_BRBTGT15_EL1		__SYS_BRBTGT(15)
+#define SYS_BRBTGT16_EL1		__SYS_BRBTGT(16)
+#define SYS_BRBTGT17_EL1		__SYS_BRBTGT(17)
+#define SYS_BRBTGT18_EL1		__SYS_BRBTGT(18)
+#define SYS_BRBTGT19_EL1		__SYS_BRBTGT(19)
+#define SYS_BRBTGT20_EL1		__SYS_BRBTGT(20)
+#define SYS_BRBTGT21_EL1		__SYS_BRBTGT(21)
+#define SYS_BRBTGT22_EL1		__SYS_BRBTGT(22)
+#define SYS_BRBTGT23_EL1		__SYS_BRBTGT(23)
+#define SYS_BRBTGT24_EL1		__SYS_BRBTGT(24)
+#define SYS_BRBTGT25_EL1		__SYS_BRBTGT(25)
+#define SYS_BRBTGT26_EL1		__SYS_BRBTGT(26)
+#define SYS_BRBTGT27_EL1		__SYS_BRBTGT(27)
+#define SYS_BRBTGT28_EL1		__SYS_BRBTGT(28)
+#define SYS_BRBTGT29_EL1		__SYS_BRBTGT(29)
+#define SYS_BRBTGT30_EL1		__SYS_BRBTGT(30)
+#define SYS_BRBTGT31_EL1		__SYS_BRBTGT(31)
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 184e58fd5631..a7f9054bd84c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -921,6 +921,167 @@ Enum	3:0	BT
 EndEnum
 EndSysreg
 
+
+# This is just a dummy register declaration to get all common field masks and
+# shifts for accessing given BRBINF contents.
+Sysreg	BRBINF_EL1	2	1	8	0	0
+Res0	63:47
+Field	46	CCU
+Field	45:32	CC
+Res0	31:18
+Field	17	LASTFAILED
+Field	16	T
+Res0	15:14
+Enum	13:8		TYPE
+	0b000000	UNCOND_DIR
+	0b000001	INDIR
+	0b000010	DIR_LINK
+	0b000011	INDIR_LINK
+	0b000101	RET_SUB
+	0b000111	RET_EXCPT
+	0b001000	COND_DIR
+	0b100001	DEBUG_HALT
+	0b100010	CALL
+	0b100011	TRAP
+	0b100100	SERROR
+	0b100110	INST_DEBUG
+	0b100111	DATA_DEBUG
+	0b101010	ALGN_FAULT
+	0b101011	INST_FAULT
+	0b101100	DATA_FAULT
+	0b101110	IRQ
+	0b101111	FIQ
+	0b111001	DEBUG_EXIT
+EndEnum
+Enum	7:6	EL
+	0b00	EL0
+	0b01	EL1
+	0b10	EL2
+	0b11	EL3
+EndEnum
+Field	5	MPRED
+Res0	4:2
+Enum	1:0	VALID
+	0b00	NONE
+	0b01	TARGET
+	0b10	SOURCE
+	0b11	FULL
+EndEnum
+EndSysreg
+
+Sysreg	BRBCR_EL1	2	1	9	0	0
+Res0	63:24
+Field	23 	EXCEPTION
+Field	22 	ERTN
+Res0	21:9
+Field	8 	FZP
+Res0	7
+Enum	6:5	TS
+	0b01	VIRTUAL
+	0b10	GST_PHYSICAL
+	0b11	PHYSICAL
+EndEnum
+Field	4	MPRED
+Field	3	CC
+Res0	2
+Field	1	E1BRE
+Field	0	E0BRE
+EndSysreg
+
+Sysreg	BRBFCR_EL1	2	1	9	0	1
+Res0	63:30
+Enum	29:28	BANK
+	0b0	FIRST
+	0b1	SECOND
+EndEnum
+Res0	27:23
+Field	22	CONDDIR
+Field	21	DIRCALL
+Field	20	INDCALL
+Field	19	RTN
+Field	18	INDIRECT
+Field	17	DIRECT
+Field	16	EnI
+Res0	15:8
+Field	7	PAUSED
+Field	6	LASTFAILED
+Res0	5:0
+EndSysreg
+
+Sysreg	BRBTS_EL1	2	1	9	0	2
+Field	63:0	TS
+EndSysreg
+
+Sysreg	BRBINFINJ_EL1	2	1	9	1	0
+Res0	63:47
+Field	46	CCU
+Field	45:32	CC
+Res0	31:18
+Field	17	LASTFAILED
+Field	16	T
+Res0	15:14
+Enum	13:8		TYPE
+	0b000000	UNCOND_DIR
+	0b000001	INDIR
+	0b000010	DIR_LINK
+	0b000011	INDIR_LINK
+	0b000100	RET_SUB
+	0b000100	RET_SUB
+	0b000111	RET_EXCPT
+	0b001000	COND_DIR
+	0b100001	DEBUG_HALT
+	0b100010	CALL
+	0b100011	TRAP
+	0b100100	SERROR
+	0b100110	INST_DEBUG
+	0b100111	DATA_DEBUG
+	0b101010	ALGN_FAULT
+	0b101011	INST_FAULT
+	0b101100	DATA_FAULT
+	0b101110	IRQ
+	0b101111	FIQ
+	0b111001	DEBUG_EXIT
+EndEnum
+Enum	7:6	EL
+	0b00	EL0
+	0b01	EL1
+	0b10	EL2
+	0b11	EL3
+EndEnum
+Field	5	MPRED
+Res0	4:2
+Enum	1:0	VALID
+	0b00	NONE
+	0b01	TARGET
+	0b10	SOURCE
+	0b00	FULL
+EndEnum
+EndSysreg
+
+Sysreg	BRBSRCINJ_EL1	2	1	9	1	1
+Field	63:0 ADDRESS
+EndSysreg
+
+Sysreg	BRBTGTINJ_EL1	2	1	9	1	2
+Field	63:0 ADDRESS
+EndSysreg
+
+Sysreg	BRBIDR0_EL1	2	1	9	2	0
+Res0	63:16
+Enum	15:12	CC
+	0b101	20_BIT
+EndEnum
+Enum	11:8	FORMAT
+	0b0	0
+EndEnum
+Enum	7:0		NUMREC
+	0b1000		8
+	0b10000		16
+	0b100000	32
+	0b1000000	64
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 Enum	59:56	F64MM
-- 
2.25.1

