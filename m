Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD66AE1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCGOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCGOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4285A4C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB7B61453
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B308C4339C;
        Tue,  7 Mar 2023 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198041;
        bh=VdvMqNl4JSt5SmirAQSento60Ayr11cxcKTY8Dzuwjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP2ted0R9U/fUqsNQvWqEs27N/xb5x7NJ/nMlSTGL/QA7FezlBjpNvyK44mZsySyz
         /er95ikyQsAh3q5bM+6HjENLnCJkMZkh1M9mxeLidLx/sUhdcIO5jMeRX0f6wDGg7/
         TnZX3zm4HPnT8gB+Q5BaZehllTf7Jf5xnOZGJoxPtHgYN+5mHz0RYt2ea8aO+u65Zs
         Eov+QoD3vNrBWy1phH/z0Kc5TubMmTZ3WENb0wgiljV840iyvDKbetLCSMp6Jljx8r
         Qd0N2X0FejaNEbwzp31B9BVPV66O1rUQoBO7Ck5XyzSXi5Jwfc15XBv2qXSAg5baM2
         2UzUpl4DbAQAw==
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
Subject: [PATCH v3 18/60] arm64: idreg-override: Prepare for place relative reloc patching
Date:   Tue,  7 Mar 2023 15:04:40 +0100
Message-Id: <20230307140522.2311461-19-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371; i=ardb@kernel.org; h=from:subject; bh=VdvMqNl4JSt5SmirAQSento60Ayr11cxcKTY8Dzuwjc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRestC9O/ad8POB/+d0bZ7zdX7Y4FN5c9XXpNYLlex IWfthfjOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE/pxg+Ke2XL7kg7St14oj l0Ssj82ck2N4q3oGxzJuzZU3+AwNrvcw/M9ZpnpW+Osl8w25TyaY59WVfe27M9uj8/PDiJjUlFu CNiwA
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

The ID reg override handling code uses a rather elaborate data structure
that relies on statically initialized absolute address values in pointer
fields. This means that this code cannot run until relocation fixups
have been applied, and this is unfortunate, because it means we cannot
discover overrides for KASLR or LVA/LPA without creating the kernel
mapping and performing the relocations first.

This can be solved by switching to place-relative relocations, which can
be applied by the linker at build time. This means some additional
arithmetic is required when dereferencing these pointers, as we can no
longer dereference the pointer members directly.

So let's implement this for idreg-override.c in a preliminary way, i.e.,
convert all the references in code to use a special accessor that
produces the correct absolute value at runtime.

To preserve the strong type checking for the static initializers, use
union types for representing the hybrid quantities.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 98 +++++++++++++-------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index b6e90ee6857eb758..fc9ed722621412bf 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -21,14 +21,32 @@
 
 static u64 __boot_status __initdata;
 
+// temporary __prel64 related definitions
+// to be removed when this code is moved under pi/
+
+#define __prel64_initconst	__initconst
+
+typedef void *prel64_t;
+
+static void *prel64_to_pointer(const prel64_t *p)
+{
+	return *p;
+}
+
 struct ftr_set_desc {
 	char 				name[FTR_DESC_NAME_LEN];
-	struct arm64_ftr_override	*override;
+	union {
+		struct arm64_ftr_override *override;
+		prel64_t		override_prel;
+	};
 	struct {
 		char			name[FTR_DESC_FIELD_LEN];
 		u8			shift;
 		u8			width;
-		bool			(*filter)(u64 val);
+		union {
+			bool		(*filter)(u64 val);
+			prel64_t	filter_prel;
+		};
 	} 				fields[];
 };
 
@@ -46,7 +64,7 @@ static bool __init mmfr1_vh_filter(u64 val)
 		 val == 0);
 }
 
-static const struct ftr_set_desc mmfr1 __initconst = {
+static const struct ftr_set_desc mmfr1 __prel64_initconst = {
 	.name		= "id_aa64mmfr1",
 	.override	= &id_aa64mmfr1_override,
 	.fields		= {
@@ -70,7 +88,7 @@ static bool __init pfr0_sve_filter(u64 val)
 	return true;
 }
 
-static const struct ftr_set_desc pfr0 __initconst = {
+static const struct ftr_set_desc pfr0 __prel64_initconst = {
 	.name		= "id_aa64pfr0",
 	.override	= &id_aa64pfr0_override,
 	.fields		= {
@@ -94,7 +112,7 @@ static bool __init pfr1_sme_filter(u64 val)
 	return true;
 }
 
-static const struct ftr_set_desc pfr1 __initconst = {
+static const struct ftr_set_desc pfr1 __prel64_initconst = {
 	.name		= "id_aa64pfr1",
 	.override	= &id_aa64pfr1_override,
 	.fields		= {
@@ -105,7 +123,7 @@ static const struct ftr_set_desc pfr1 __initconst = {
 	},
 };
 
-static const struct ftr_set_desc isar1 __initconst = {
+static const struct ftr_set_desc isar1 __prel64_initconst = {
 	.name		= "id_aa64isar1",
 	.override	= &id_aa64isar1_override,
 	.fields		= {
@@ -117,7 +135,7 @@ static const struct ftr_set_desc isar1 __initconst = {
 	},
 };
 
-static const struct ftr_set_desc isar2 __initconst = {
+static const struct ftr_set_desc isar2 __prel64_initconst = {
 	.name		= "id_aa64isar2",
 	.override	= &id_aa64isar2_override,
 	.fields		= {
@@ -127,7 +145,7 @@ static const struct ftr_set_desc isar2 __initconst = {
 	},
 };
 
-static const struct ftr_set_desc smfr0 __initconst = {
+static const struct ftr_set_desc smfr0 __prel64_initconst = {
 	.name		= "id_aa64smfr0",
 	.override	= &id_aa64smfr0_override,
 	.fields		= {
@@ -138,7 +156,7 @@ static const struct ftr_set_desc smfr0 __initconst = {
 	},
 };
 
-static const struct ftr_set_desc sw_features __initconst = {
+static const struct ftr_set_desc sw_features __prel64_initconst = {
 	.name		= "arm64_sw",
 	.override	= &arm64_sw_feature_override,
 	.fields		= {
@@ -147,14 +165,17 @@ static const struct ftr_set_desc sw_features __initconst = {
 	},
 };
 
-static const struct ftr_set_desc * const regs[] __initconst = {
-	&mmfr1,
-	&pfr0,
-	&pfr1,
-	&isar1,
-	&isar2,
-	&smfr0,
-	&sw_features,
+static const union {
+	const struct ftr_set_desc	*reg;
+	prel64_t			reg_prel;
+} regs[] __prel64_initconst = {
+	{ .reg = &mmfr1		},
+	{ .reg = &pfr0 		},
+	{ .reg = &pfr1 		},
+	{ .reg = &isar1		},
+	{ .reg = &isar2		},
+	{ .reg = &smfr0		},
+	{ .reg = &sw_features	},
 };
 
 static const struct {
@@ -194,15 +215,20 @@ static void __init match_options(const char *cmdline)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		const struct ftr_set_desc *reg = prel64_to_pointer(&regs[i].reg_prel);
+		struct arm64_ftr_override *override;
 		int f;
 
-		for (f = 0; strlen(regs[i]->fields[f].name); f++) {
-			u64 shift = regs[i]->fields[f].shift;
-			u64 width = regs[i]->fields[f].width ?: 4;
+		override = prel64_to_pointer(&reg->override_prel);
+
+		for (f = 0; strlen(reg->fields[f].name); f++) {
+			u64 shift = reg->fields[f].shift;
+			u64 width = reg->fields[f].width ?: 4;
 			u64 mask = GENMASK_ULL(shift + width - 1, shift);
+			bool (*filter)(u64 val);
 			u64 v;
 
-			if (find_field(cmdline, regs[i], f, &v))
+			if (find_field(cmdline, reg, f, &v))
 				continue;
 
 			/*
@@ -210,16 +236,16 @@ static void __init match_options(const char *cmdline)
 			 * it by setting the value to the all-ones while
 			 * clearing the mask... Yes, this is fragile.
 			 */
-			if (regs[i]->fields[f].filter &&
-			    !regs[i]->fields[f].filter(v)) {
-				regs[i]->override->val  |= mask;
-				regs[i]->override->mask &= ~mask;
+			filter = prel64_to_pointer(&reg->fields[f].filter_prel);
+			if (filter && !filter(v)) {
+				override->val  |= mask;
+				override->mask &= ~mask;
 				continue;
 			}
 
-			regs[i]->override->val  &= ~mask;
-			regs[i]->override->val  |= (v << shift) & mask;
-			regs[i]->override->mask |= mask;
+			override->val  &= ~mask;
+			override->val  |= (v << shift) & mask;
+			override->mask |= mask;
 
 			return;
 		}
@@ -293,11 +319,16 @@ void init_feature_override(u64 boot_status);
 
 asmlinkage void __init init_feature_override(u64 boot_status)
 {
+	struct arm64_ftr_override *override;
+	const struct ftr_set_desc *reg;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		regs[i]->override->val  = 0;
-		regs[i]->override->mask = 0;
+		reg = prel64_to_pointer(&regs[i].reg_prel);
+		override = prel64_to_pointer(&reg->override_prel);
+
+		override->val  = 0;
+		override->mask = 0;
 	}
 
 	__boot_status = boot_status;
@@ -305,8 +336,9 @@ asmlinkage void __init init_feature_override(u64 boot_status)
 	parse_cmdline();
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		dcache_clean_inval_poc((unsigned long)regs[i]->override,
-				       (unsigned long)regs[i]->override +
-				       sizeof(*regs[i]->override));
+		reg = prel64_to_pointer(&regs[i].reg_prel);
+		override = prel64_to_pointer(&reg->override_prel);
+		dcache_clean_inval_poc((unsigned long)override,
+				       (unsigned long)(override + 1));
 	}
 }
-- 
2.39.2

