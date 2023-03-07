Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DC6AF58A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjCGT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjCGTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:25:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB7A838D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B615CE1C92
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C13C433D2;
        Tue,  7 Mar 2023 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678216291;
        bh=jatUZMjZVMrOMw98i0PBylG6VZoVmRRIWBKzI9bTImg=;
        h=From:Date:Subject:To:Cc:From;
        b=IyQ9tkfoiaTr241FKIFyJ9Ug+qhppOEa76s97AJm/Xvi1YwzmuzTMdYh6TYCfqfCB
         qKYfnaExmiLk2X7muAKXNz3ecDkNoQYpIEFbMZW+1KzIE2rUJUyq92IqOwK6aEkppB
         4rQlizwaXLhLoIa9xprO+Opg27NTcm2nWEoySgjn7Be8aJeopDWBz1uQzfzOMDElYN
         gRCpHWng1AXHJy04+knZVWKgXllTSxf/3EueI3FINDjzcI+uhZcXs2B9L+4rw/9Qmf
         HOmgntcFqTd5IuP+bE281cid1fgtTQKc3xDkpHBafBFPWCT0GwjJYAEi3vUNAMwMYa
         uDg3lQqDK4DJg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 07 Mar 2023 19:11:09 +0000
Subject: [PATCH v2] arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v2-1-7e166c5b3b42@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEyMB2QC/32NSwqDMBQAryJv3Vdi/GFX3qO4SOJLDK1RXkRax
 Ls3eoAuZ2CYHSKxpwiPbAemzUc/hwTyloEZVXCEfkgMUshCFKJGxVNdonUrMjl0FFBb2RQVWVU
 OFlKnVSTUrIIZz3KdltMuTNZ/rtOzTzz6uM78vcZbftp/jy3HHNtKG2HaxlgauhdxoPd9Zgf9c
 Rw/f7RZ48kAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jatUZMjZVMrOMw98i0PBylG6VZoVmRRIWBKzI9bTImg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkB4xgiMoKhdZaa8jXqp+b2vqOlaJoVkra7fOhyjt+
 sEYPaZqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAeMYAAKCRAk1otyXVSH0NxUB/
 9SODyGZ1psOILmjdaywiY9XcOJK/zcTvHZ+jz0Ecq6jIYB/0MFmaJoAm0558rRQf3wtUWqY0Lo+4rN
 9+D5m3msPMfo2Pql1r/6AvgBHlwmATr5sEDp15TQL8qfS7/LZ3dVqhUPIzE5tElLDQKyPu2robAN4a
 AsJ2kgmOwEHdAZDJZmISqnkP1bpKbPrbnfm3uvFrwK1+FuvMbWmYRbDTn+aSsOPTBLMhv8c/BwWG9a
 btxkqSsCsjHL5tN0zDr6FKHPHWety5BPboLU34HwKawGhINdCOhpNU9g/LwgYhl8dUC8VYbGu1UVG/
 TW324irHEGhaAFv6mZkLt5OGxYWu3J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fine grained traps read and write control registers to
automatic generation as per DDI0601 2022-12. No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Correct naming of nPIRE0_EL1.
- Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org
---
 arch/arm64/include/asm/sysreg.h |  8 -----
 arch/arm64/tools/sysreg         | 75 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e3ecba3c4e6..e5ca9ece1606 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -419,8 +419,6 @@
 #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
 #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
 #define SYS_HSTR_EL2			sys_reg(3, 4, 1, 1, 3)
-#define SYS_HFGRTR_EL2			sys_reg(3, 4, 1, 1, 4)
-#define SYS_HFGWTR_EL2			sys_reg(3, 4, 1, 1, 5)
 #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
 #define SYS_HACR_EL2			sys_reg(3, 4, 1, 1, 7)
 
@@ -758,12 +756,6 @@
 #define ICH_VTR_TDS_SHIFT	19
 #define ICH_VTR_TDS_MASK	(1 << ICH_VTR_TDS_SHIFT)
 
-/* HFG[WR]TR_EL2 bit definitions */
-#define HFGxTR_EL2_nTPIDR2_EL0_SHIFT	55
-#define HFGxTR_EL2_nTPIDR2_EL0_MASK	BIT_MASK(HFGxTR_EL2_nTPIDR2_EL0_SHIFT)
-#define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
-#define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
-
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index dd5a9c7e310f..60829a9409f0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1866,6 +1866,81 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+SysregFields	HFGxTR_EL2
+Field	63	nAMIAIR2_EL1
+Field	62	nMAIR2_EL1
+Field	61	nS2POR_EL1
+Field	60	nPOR_EL1
+Field	59	nPOR_EL0
+Field	58	nPIR_EL1
+Field	57	nPIRE0_EL1
+Field	56	nRCWMASK_EL1
+Field	55	nTPIDR2_EL0
+Field	54	nSMPRI_EL1
+Field	53	nGCS_EL1
+Field	52	nGCS_EL0
+Res0	51
+Field	50	nACCDATA_EL1
+Field	49	ERXADDR_EL1
+Field	48	EXRPFGCDN_EL1
+Field	47	EXPFGCTL_EL1
+Field	46	EXPFGF_EL1
+Field	45	ERXMISCn_EL1
+Field	44	ERXSTATUS_EL1
+Field	43	ERXCTLR_EL1
+Field	42	ERXFR_EL1
+Field	41	ERRSELR_EL1
+Field	40	ERRIDR_EL1
+Field	39	ICC_IGRPENn_EL1
+Field	38	VBAR_EL1
+Field	37	TTBR1_EL1
+Field	36	TTBR0_EL1
+Field	35	TPIDR_EL0
+Field	34	TPIDRRO_EL0
+Field	33	TPIDR_EL1
+Field	32	TCR_EL1
+Field	31	SCTXNUM_EL0
+Field	30	SCTXNUM_EL1
+Field	29	SCTLR_EL1
+Field	28	REVIDR_EL1
+Field	27	PAR_EL1
+Field	26	MPIDR_EL1
+Field	25	MIDR_EL1
+Field	24	MAIR_EL1
+Field	23	LORSA_EL1
+Field	22	LORN_EL1
+Field	21	LORID_EL1
+Field	20	LOREA_EL1
+Field	19	LORC_EL1
+Field	18	ISR_EL1
+Field	17	FAR_EL1
+Field	16	ESR_EL1
+Field	15	DCZID_EL0
+Field	14	CTR_EL0
+Field	13	CSSELR_EL1
+Field	12	CPACR_EL1
+Field	11	CONTEXTIDR_EL1
+Field	10	CLIDR_EL1
+Field	9	CCSIDR_EL1
+Field	8	APIBKey
+Field	7	APIAKey
+Field	6	APGAKey
+Field	5	APDBKey
+Field	4	APDAKey
+Field	3	AMAIR_EL1
+Field	2	AIDR_EL1
+Field	1	AFSR1_EL1
+Field	0	AFSR0_EL1
+EndSysregFields
+
+Sysreg HFGRTR_EL2	3	4	1	1	4
+Fields	HFGxTR_EL2
+EndSysreg
+
+Sysreg HFGWTR_EL2	3	4	1	1	5
+Fields	HFGxTR_EL2
+EndSysreg
+
 Sysreg	ZCR_EL2	3	4	1	2	0
 Fields	ZCR_ELx
 EndSysreg

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230306-arm64-fgt-reg-gen-bf2735efa4df

Best regards,
-- 
Mark Brown <broonie@kernel.org>

