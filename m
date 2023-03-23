Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1A6C71C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCWUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCWUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:45:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A40518B3E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DBFBB8224D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82484C433A4;
        Thu, 23 Mar 2023 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604333;
        bh=kvBBr75CsPjkEV7cYPTetKap1L2dFc3Y02As/bgqHcs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BKxJddDZJsPaFabEFjFxi0hFB5W6PBwEOezguoeNk6QWe9dwUiWyO0S5JVnQOipeZ
         MU2UseALm9HsvF45THeIDAbYpk41ixuRpBiJxSPRZhPiBtn/VeLJjprshsHNYgZnjf
         lSc8gx48cOyAl0KwrQ4YuMvRuPNO/CCe+Hj2gYaw4FSPmAADbxQfMiK5ckQuvZI4uC
         QqZxpLpqrOI1EUxtrEREJJDFrw7G49UCiDC3gLje2NU+Ae/oI56Mt0bYEAwV106cOn
         GmHUmGJbKX8Rq/AsJG60QB/cA5G5GR7+aeBHr6FwBP+UAklQs1prYBQY/AJG6nQEPf
         xvYZbreYX1k7A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Mar 2023 20:44:53 +0000
Subject: [PATCH v3 1/2] arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v3-1-decba93cbaab@kernel.org>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
In-Reply-To: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kvBBr75CsPjkEV7cYPTetKap1L2dFc3Y02As/bgqHcs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHLpooC1ip/a1XfD9tuSMB4J2vbxBF12jCmAdEXz3
 0Rf/P2OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZBy6aAAKCRAk1otyXVSH0K2VB/
 9gDYKhZO7wszAf1fRG+vdb0o96Yra2zc7hZ8ON6vbxJ9Cci0oPO7uxnQIe0dt0ueSANX85jTDVsgVW
 I1ck3T3zkDU3yK309JLqepsz+0vnbm9mZHVnlfG+QL67QEsONrG7diKfYCk2KS9uDn2v4ZNtwqMRge
 j/+25CgbTk5zLalcoYrXmBDwTrg7tPn3K1SrRixguP5n6UHD6VBPqcTwjs5b0n3o9jit+YwwkW9SV/
 sciGxoA+2zExHgADIFLAsNef9QNHUVU06alIXCqAJM8DCFUnGjEDqkp7bC0+8x+BrZbLSsr/Jek5+Q
 dFx4S4OrO+WjUeZ2fxscv2isHzKdNL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fine grained traps read and write control registers to
automatic generation as per DDI0601 2022-12. No functional changes.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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

-- 
2.30.2

