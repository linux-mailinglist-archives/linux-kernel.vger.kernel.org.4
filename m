Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8506ACF68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCFUqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:46:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E514C6E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24F2FB810CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0F0C433D2;
        Mon,  6 Mar 2023 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678135603;
        bh=6a4ictEgwFqzep70FKcRKHnanGrxuqikBJymadz16M4=;
        h=From:Date:Subject:To:Cc:From;
        b=JVWCl24M4jVZ3/XF7wyeXi9c7jlXuc16XU+4BbwtEcemTSmrboIdIogsAFf05dmWb
         GIcdvUnK1YqA7bHYQBkSqcsrQCuA8OOxyrChIzdNrVK6OYAcEwnkpgHD5tJ3+6X77l
         GunjOL/sZaCrfwzaIHFTqiFIFumktSaPLw7Az0D5ojChxUpjDTobPDvKi938HBxNNO
         /fCKS/iq10UPgEpvKzYkBXJdl84v0qz5tGflO39Oxz0LOfcMHBFOADMXQBweb9doB+
         4Xvr4PN/5xD5DfXP8euhkq4nAIwTx9U1noN8vQon8nKRQnDDDMKcm+nitoA13RfVQY
         DdC9tifHkUrZQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 20:46:18 +0000
Subject: [PATCH] arm64/sysreg: Convert HW[RW]TR_EL2 to automatic generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org>
X-B4-Tracking: v=1; b=H4sIABlRBmQC/x2NQQqDMBAAvyJ7diEm1kK/Ih42uhv3YCobKQXx7
 409zsAwJxQ25QKv5gTjjxZ95wpd28C8Uk6MulQG73xwwQ1Itg09SjrQOGHijFH8MzxYqF8Eahe
 pMEajPK93eWz7bXdj0e//NE7X9QOnj9bAeQAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6a4ictEgwFqzep70FKcRKHnanGrxuqikBJymadz16M4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBlExIpFfNWJNWHB7K9QIvlrL2znZH8XFz/nAW/2S
 6YifdtKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAZRMQAKCRAk1otyXVSH0DVqCA
 CC+sUGrWzfH6tOWNUAOxRz1eneEjEb1j/Em2XCWwRkp1ZMddn86H6B0D5H8CoJJs5B+FGeXzvjhlP2
 O6gg6QYDnp8MjtUVkpnCX+mjCxkDtPZhDR7rBe6QRDvtypou8IeOs0h6JvdXP8rSFMCd8t0vTaH5+/
 Cd54hEOkI72UkWsvXgNdGLOBnRsHAIqhA05h53CdUv+aNfYVPsZw479Btj6QrZoVYwyQxvO34hQ1A8
 AqeY0xzSwsuOph9AyCOvFizvwhs9piNs8pAe1HEHjEEtCfZbP5TfDepePrXMHmvv7rY77mpid2FiBz
 IlOh1kJaEtkBHoX7tEKtHVoFeMNKz0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index dd5a9c7e310f..cbf8c7ed633f 100644
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
+Field	57	nPIR_EL0
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

