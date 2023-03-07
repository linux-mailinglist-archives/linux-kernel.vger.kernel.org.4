Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16E36AE1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCGOIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCGOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472088ABF9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96B761457
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C3C433A1;
        Tue,  7 Mar 2023 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198027;
        bh=Hq8nHTyQr1XHq5oR1wC0C3a0J3sTD/A+RXL9gidFldA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tasMtYwVLBsYQ2coKtO/UrLuNh5Xk04axrum5aB+CLGXjp2+1xnnfrDABu+WuSdFR
         sFKVeRhFY/rtzakdiLI9Vx9zHgeju92OdtjnyyWJK9W0lP041NFlw7x5tY9MRtMEVh
         P45tZmK/0H1DuVTOHtalkzTXpWOAyXQr67p0hNoeXjdshmmlhni9HA8jS+qNWVeFx1
         oC+5r5Km1QyyyXZkSaDgc/I5r+SSCvTKxh86NSSTh0fIFG2wmJ35E+RN8ojn5jrVGu
         TFPUyrz+CMcFWrf3MUW/nRk1HjPHaLaPT+Wudbn63vTeXHaRsssPUhsFNjZw+4ypJ9
         riEyjmcFs3NJA==
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
Subject: [PATCH v3 12/60] arm64: Turn kaslr_feature_override into a generic SW feature override
Date:   Tue,  7 Mar 2023 15:04:34 +0100
Message-Id: <20230307140522.2311461-13-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=ardb@kernel.org; h=from:subject; bh=GSuvLi6RwTLuJqeqKu2UWNgSFMdiiU3kHbNFtROgd2w=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRWzH1bdWNns5bhsHSbeKR5p8q2/fmdl97PnBHRcbO ufbPlveUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYincnIsH/u4TUfvh0MmHMg 3nyO8enfLZccfx5cPmtCV/EqdY1d0/4wMvy52bzHzZV3gcT6dyr/T0/dm5SWXOzFmckQ0XEowf3 1V3YA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

Disabling KASLR from the command line is implemented as a feature
override. Repaint it slightly so that it can further be used as
more generic infrastructure for SW override purposes.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[ardb: don't apply the override mask to val]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  4 ++++
 arch/arm64/kernel/cpufeature.c      |  2 ++
 arch/arm64/kernel/idreg-override.c  | 16 ++++++----------
 arch/arm64/kernel/kaslr.c           |  5 ++---
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 6bf013fb110d7923..bc10098901808c00 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -15,6 +15,8 @@
 #define MAX_CPU_FEATURES	128
 #define cpu_feature(x)		KERNEL_HWCAP_ ## x
 
+#define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
+
 #ifndef __ASSEMBLY__
 
 #include <linux/bug.h>
@@ -925,6 +927,8 @@ extern struct arm64_ftr_override id_aa64smfr0_override;
 extern struct arm64_ftr_override id_aa64isar1_override;
 extern struct arm64_ftr_override id_aa64isar2_override;
 
+extern struct arm64_ftr_override arm64_sw_feature_override;
+
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e9a138b7e3b22cc7..88cec6c14743c4c5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -657,6 +657,8 @@ struct arm64_ftr_override __ro_after_init id_aa64smfr0_override;
 struct arm64_ftr_override __ro_after_init id_aa64isar1_override;
 struct arm64_ftr_override __ro_after_init id_aa64isar2_override;
 
+struct arm64_ftr_override arm64_sw_feature_override;
+
 static const struct __ftr_reg_entry {
 	u32			sys_id;
 	struct arm64_ftr_reg 	*reg;
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index d833d78a7f313563..434703e4e55cb785 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -138,15 +138,11 @@ static const struct ftr_set_desc smfr0 __initconst = {
 	},
 };
 
-extern struct arm64_ftr_override kaslr_feature_override;
-
-static const struct ftr_set_desc kaslr __initconst = {
-	.name		= "kaslr",
-#ifdef CONFIG_RANDOMIZE_BASE
-	.override	= &kaslr_feature_override,
-#endif
+static const struct ftr_set_desc sw_features __initconst = {
+	.name		= "arm64_sw",
+	.override	= &arm64_sw_feature_override,
 	.fields		= {
-		FIELD("disabled", 0, NULL),
+		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
 		{}
 	},
 };
@@ -158,7 +154,7 @@ static const struct ftr_set_desc * const regs[] __initconst = {
 	&isar1,
 	&isar2,
 	&smfr0,
-	&kaslr,
+	&sw_features,
 };
 
 static const struct {
@@ -175,7 +171,7 @@ static const struct {
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
-	{ "nokaslr",			"kaslr.disabled=1" },
+	{ "nokaslr",			"arm64_sw.nokaslr=1" },
 };
 
 static int __init find_field(const char *cmdline,
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index e7477f21a4c9d062..abcd996c747b8c97 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -23,8 +23,6 @@
 u64 __ro_after_init module_alloc_base;
 u16 __initdata memstart_offset_seed;
 
-struct arm64_ftr_override kaslr_feature_override __initdata;
-
 static int __init kaslr_init(void)
 {
 	u64 module_range;
@@ -36,7 +34,8 @@ static int __init kaslr_init(void)
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
 
-	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
+	if (cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
+						 ARM64_SW_FEATURE_OVERRIDE_NOKASLR)) {
 		pr_info("KASLR disabled on command line\n");
 		return 0;
 	}
-- 
2.39.2

