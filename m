Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9E6AE1DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjCGOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjCGOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C388884
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D709C61455
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52117C433A4;
        Tue,  7 Mar 2023 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198104;
        bh=cITyNqDHqP2MM3JyZX0FhteueW9phnpQCLtZyPbhWNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMJwLq0LCPwhiAjjMW4AY+5bLy27Tvgq5jAk+4mhMjQl49koLByrC2VNQ6UkY5m01
         VFaW231zd/9C4AXiMrS1FlTFKamQGl+YmvKHKDPY59bV0MiFVxXkJF1NkHtvoveqkH
         tiJUcwlAYpfJaMm1nJU10lXXclo/wRh/iLH2dnVopSG+x3fF8vycis0tlOOTJa4MAO
         Vbq2knjTuBdZiRRsA6nF1qud+Z9hh27i53La4cWjzVqdsC90dE0RJiPwJ/roCM1xq9
         bkgNrpXK/ylznhc1NlOoy0uqYb1wSllgF/a9bZluTdVXhdWsPhozqeowflcFl9Fhcc
         wTdY2hQVd7dig==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 44/60] arm64: mm: Add feature override support for LVA
Date:   Tue,  7 Mar 2023 15:05:06 +0100
Message-Id: <20230307140522.2311461-45-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6883; i=ardb@kernel.org; h=from:subject; bh=cITyNqDHqP2MM3JyZX0FhteueW9phnpQCLtZyPbhWNs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpbj107xtLxJ7T+TMELy/+PM36Tmhu+SLtpS4PmLnf nzrUoNxRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiItBjD/7B97rpLQvJ3H1d5 b3vsCp/uEy/eVZUN5kfSWT5XTjzcu4Phv2OP7I3tv5bMD5E7WH/Uqmyun8N2zcYcF96jPdL7vO/ FcgEA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for overriding the VARange field of the MMFR2 CPU ID
register. This permits the associated LVA feature to be overridden early
enough for the boot code that creates the kernel mapping to take it into
account.

Given that LPA2 implies LVA, disabling the latter should disable the
former as well. So override the ID_AA64MMFR0.TGran field of the current
page size as well if it advertises support for 52-bit addressing.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h    | 17 ++++++-----
 arch/arm64/include/asm/cpufeature.h   |  4 +++
 arch/arm64/kernel/cpufeature.c        |  8 +++--
 arch/arm64/kernel/image-vars.h        |  2 ++
 arch/arm64/kernel/pi/idreg-override.c | 31 ++++++++++++++++++++
 5 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index beb53bbd8c19bb1c..0710c17800a49b75 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -576,18 +576,21 @@ alternative_endif
 	.endm
 
 /*
- * Offset ttbr1 to allow for 48-bit kernel VAs set with 52-bit PTRS_PER_PGD.
+ * If the kernel is built for 52-bit virtual addressing but the hardware only
+ * supports 48 bits, we cannot program the pgdir address into TTBR1 directly,
+ * but we have to add an offset so that the TTBR1 address corresponds with the
+ * pgdir entry that covers the lowest 48-bit addressable VA.
+ *
  * orr is used as it can cover the immediate value (and is idempotent).
- * In future this may be nop'ed out when dealing with 52-bit kernel VAs.
  * 	ttbr: Value of ttbr to set, modified.
  */
 	.macro	offset_ttbr1, ttbr, tmp
 #ifdef CONFIG_ARM64_VA_BITS_52
-	mrs_s	\tmp, SYS_ID_AA64MMFR2_EL1
-	and	\tmp, \tmp, #(0xf << ID_AA64MMFR2_EL1_VARange_SHIFT)
-	cbnz	\tmp, .Lskipoffs_\@
-	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
-.Lskipoffs_\@ :
+	mrs	\tmp, tcr_el1
+	and	\tmp, \tmp, #TCR_T1SZ_MASK
+	cmp	\tmp, #TCR_T1SZ(VA_BITS_MIN)
+	orr	\tmp, \ttbr, #TTBR1_BADDR_4852_OFFSET
+	csel	\ttbr, \tmp, \ttbr, eq
 #endif
 	.endm
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a37f4956d5a7ef6e..7faf9a48339e7c8c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -920,7 +920,9 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 
 struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id);
 
+extern struct arm64_ftr_override id_aa64mmfr0_override;
 extern struct arm64_ftr_override id_aa64mmfr1_override;
+extern struct arm64_ftr_override id_aa64mmfr2_override;
 extern struct arm64_ftr_override id_aa64pfr0_override;
 extern struct arm64_ftr_override id_aa64pfr1_override;
 extern struct arm64_ftr_override id_aa64zfr0_override;
@@ -994,6 +996,8 @@ static inline bool cpu_has_lva(void)
 	u64 mmfr2;
 
 	mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
+	mmfr2 &= ~id_aa64mmfr2_override.mask;
+	mmfr2 |= id_aa64mmfr2_override.val;
 	return cpuid_feature_extract_unsigned_field(mmfr2,
 						    ID_AA64MMFR2_EL1_VARange_SHIFT);
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 660dedcae173841a..f8e3f37accdddc86 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -649,7 +649,9 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 #define ARM64_FTR_REG(id, table)		\
 	__ARM64_FTR_REG_OVERRIDE(#id, id, table, &no_override)
 
+struct arm64_ftr_override id_aa64mmfr0_override;
 struct arm64_ftr_override id_aa64mmfr1_override;
+struct arm64_ftr_override id_aa64mmfr2_override;
 struct arm64_ftr_override id_aa64pfr0_override;
 struct arm64_ftr_override id_aa64pfr1_override;
 struct arm64_ftr_override id_aa64zfr0_override;
@@ -713,10 +715,12 @@ static const struct __ftr_reg_entry {
 			       &id_aa64isar2_override),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
-	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0,
+			       &id_aa64mmfr0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
 			       &id_aa64mmfr1_override),
-	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2,
+			       &id_aa64mmfr2_override),
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
 	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 61d1d283a69ba5d8..79a7e0e3edd1aa21 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -36,7 +36,9 @@ PROVIDE(__pi___memset			= __pi_memset);
 
 PROVIDE(__pi_id_aa64isar1_override	= id_aa64isar1_override);
 PROVIDE(__pi_id_aa64isar2_override	= id_aa64isar2_override);
+PROVIDE(__pi_id_aa64mmfr0_override	= id_aa64mmfr0_override);
 PROVIDE(__pi_id_aa64mmfr1_override	= id_aa64mmfr1_override);
+PROVIDE(__pi_id_aa64mmfr2_override	= id_aa64mmfr2_override);
 PROVIDE(__pi_id_aa64pfr0_override	= id_aa64pfr0_override);
 PROVIDE(__pi_id_aa64pfr1_override	= id_aa64pfr1_override);
 PROVIDE(__pi_id_aa64smfr0_override	= id_aa64smfr0_override);
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 265b35b09dd488f1..c4ae5ffe5cb0c999 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -63,6 +63,35 @@ static const struct ftr_set_desc mmfr1 __prel64_initconst = {
 	},
 };
 
+
+static bool __init mmfr2_varange_filter(u64 val)
+{
+	int __maybe_unused feat;
+
+	if (val)
+		return false;
+
+#ifdef CONFIG_ARM64_LPA2
+	feat = cpuid_feature_extract_signed_field(read_sysreg(id_aa64mmfr0_el1),
+						  ID_AA64MMFR0_EL1_TGRAN_SHIFT);
+	if (feat >= ID_AA64MMFR0_EL1_TGRAN_LPA2) {
+		id_aa64mmfr0_override.val |=
+			(ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
+		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
+	}
+#endif
+	return true;
+}
+
+static const struct ftr_set_desc mmfr2 __prel64_initconst = {
+	.name		= "id_aa64mmfr2",
+	.override	= &id_aa64mmfr2_override,
+	.fields		= {
+		FIELD("varange", ID_AA64MMFR2_EL1_VARange_SHIFT, mmfr2_varange_filter),
+		{}
+	},
+};
+
 static bool __init pfr0_sve_filter(u64 val)
 {
 	/*
@@ -161,6 +190,7 @@ static const union {
 	prel64_t			reg_prel;
 } regs[] __prel64_initconst = {
 	{ .reg = &mmfr1		},
+	{ .reg = &mmfr2		},
 	{ .reg = &pfr0 		},
 	{ .reg = &pfr1 		},
 	{ .reg = &isar1		},
@@ -185,6 +215,7 @@ static const struct {
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
 	{ "rodata=off",			"arm64_sw.rodataoff=1" },
+	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
-- 
2.39.2

