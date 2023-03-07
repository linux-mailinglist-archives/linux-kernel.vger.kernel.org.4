Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DC6AE1BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCGOIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCGOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D88ABE9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2915A61463
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EF3C4339E;
        Tue,  7 Mar 2023 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198029;
        bh=1oCuWk9VXyzMZa12N2n3i7rjkfl0ioumXcP43D4virk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZxoqVBA3o+TyPC758j6soT3BLLlD+0n2bXQHlRjTHq7geYmp6Z8l4AS488r1xkuv
         f2bgyEgCycl8ABzRlf+0gVsyFwlRKMU4xaCTa4ZzhIxzTgqRzvmpGZmbG0KWEP/HOQ
         VpbGvaQLWT+EG8nsz+5NDqtZ8YGTFkvfvdpEnfQ0mFitGbXRH8TQtmQEEuobjvxqD3
         6eSJVA2Vp5rswFTQ/MX5afnlJaGDDzN/v9bLKW8KWtTHoI3xaTWp5ywNjdsvd9q8r5
         Mrw88ipYYgdh1nvW39wimqxkvhcHveIfaM4iUvtPtWqTDxOGyWwrgrkI83Y02kz8Tj
         zdRYobKGrWuTw==
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
Subject: [PATCH v3 13/60] arm64: kvm: honour 'nokaslr' command line option for the HYP VA space
Date:   Tue,  7 Mar 2023 15:04:35 +0100
Message-Id: <20230307140522.2311461-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=ardb@kernel.org; h=from:subject; bh=1oCuWk9VXyzMZa12N2n3i7rjkfl0ioumXcP43D4virk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRdJbqv235+uE8w374+M/zdWw+XQn9vDuVzFzE5YF2 l3Ivx7cUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaiuYORod/hRt3pTfbXdvie +zon9n8PzyKlohXsTTab7JbF9f+8tIHhnwGj8hnP7Gev/7+3l1qjZ9am5nk+fWIvq/HTeubDlY8 +MgAA
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

Debugging the code that runs in HYP is rather difficult, especially when
its placement is randomized. So let's take the 'nokaslr' command line
option into account, and allow it to be disabled at boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h | 15 -------------
 arch/arm64/include/asm/mmu.h    | 23 ++++++++++++++++++++
 arch/arm64/kernel/kaslr.c       |  3 +--
 arch/arm64/kvm/va_layout.c      |  3 ++-
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 830740ff79bab902..f96975466ef1b752 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -197,21 +197,6 @@ extern s64			memstart_addr;
 /* the offset between the kernel virtual and physical mappings */
 extern u64			kimage_voffset;
 
-static inline unsigned long kaslr_offset(void)
-{
-	return (u64)&_text - KIMAGE_VADDR;
-}
-
-static inline bool kaslr_enabled(void)
-{
-	/*
-	 * The KASLR offset modulo MIN_KIMG_ALIGN is taken from the physical
-	 * placement of the image rather than from the seed, so a displacement
-	 * of less than MIN_KIMG_ALIGN means that no seed was provided.
-	 */
-	return kaslr_offset() >= MIN_KIMG_ALIGN;
-}
-
 /*
  * Allow all memory at the discovery stage. We will clip it later.
  */
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466a4be92ac3..9b9a206e4e9c9d4e 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -72,6 +72,29 @@ extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
 
+static inline unsigned long kaslr_offset(void)
+{
+	return (u64)&_text - KIMAGE_VADDR;
+}
+
+static inline bool kaslr_enabled(void)
+{
+	/*
+	 * The KASLR offset modulo MIN_KIMG_ALIGN is taken from the physical
+	 * placement of the image rather than from the seed, so a displacement
+	 * of less than MIN_KIMG_ALIGN means that no seed was provided.
+	 */
+	return kaslr_offset() >= MIN_KIMG_ALIGN;
+}
+
+static inline bool kaslr_disabled_cmdline(void)
+{
+	if (cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
+						 ARM64_SW_FEATURE_OVERRIDE_NOKASLR))
+		return true;
+	return false;
+}
+
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
 
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index abcd996c747b8c97..9e7f0bae5b5fb24b 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -34,8 +34,7 @@ static int __init kaslr_init(void)
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
 
-	if (cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
-						 ARM64_SW_FEATURE_OVERRIDE_NOKASLR)) {
+	if (kaslr_disabled_cmdline()) {
 		pr_info("KASLR disabled on command line\n");
 		return 0;
 	}
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 91b22a014610b22f..341b67e2f2514e55 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -72,7 +72,8 @@ __init void kvm_compute_layout(void)
 	va_mask = GENMASK_ULL(tag_lsb - 1, 0);
 	tag_val = hyp_va_msb;
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1)) {
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1) &&
+	    !kaslr_disabled_cmdline()) {
 		/* We have some free bits to insert a random tag. */
 		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
 	}
-- 
2.39.2

