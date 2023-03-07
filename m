Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264776AE1E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCGOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjCGOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:10:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC78B046
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C3926145B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E972AC4339C;
        Tue,  7 Mar 2023 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198113;
        bh=8hH3Uc2UhkT3/0ty5o1TlACCwFDCvfgL5+D5fFfUrRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgjjhnR4pTHZpaj/6ZDOwtohlCgzHpgWtCMrmDY487+DK61hEpB0pKS9D6MrpiI2x
         /FBOCQF9lVgZno6QOJ5wK9dEpT9v7eQW3Z+eNATCmvGkL616zfS6Kfc8nR8mnSPTpM
         +Gf1v9yTp3b3nzm7775uBCgxI2YHDK2BGYJdCMU0rtt7NekHAQJvjWk4Um0Lzc7XgE
         JuSYku7jBB5t/EsH4yrwtMFBSDWqUFDaD5uV8iJLTzbXnkDQMzHElLP3hu2s3VXEhS
         UQSGdMZV1Dm7ZNRb6s+/HwttDRbNXh1tdGqbU4y2RZ/Kockdolw80TdlvhY77A6Apf
         eCbH4a2sjs+Ow==
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
Subject: [PATCH v3 48/60] arm64: mm: add LPA2 and 5 level paging support to G-to-nG conversion
Date:   Tue,  7 Mar 2023 15:05:10 +0100
Message-Id: <20230307140522.2311461-49-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6585; i=ardb@kernel.org; h=from:subject; bh=8hH3Uc2UhkT3/0ty5o1TlACCwFDCvfgL5+D5fFfUrRw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpfZPfbnckdXbp75p25549WuFMbs7w6XrG4NXGQSlS C9U6GLqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5IMPwh2vHfYXND/ckrzpt pa0x5VK6m7vCKaULv5Ou8O/gucx2s4CRYe3u2luObIs+Hg1KXRVnxnieS3Wi495rNzM4p/18N72 bmRcA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 5 level paging in the G-to-nG routine that creates its
own temporary page tables to traverse the swapper page tables. Also add
support for running the 5 level configuration with the top level folded
at runtime, to support CPUs that do not implement the LPA2 extension.

While at it, wire up the level skipping logic so it will also trigger on
4 level configurations with LPA2 enabled at build time but not active at
runtime, as we'll fall back to 3 level paging in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/cpufeature.c |  9 ++-
 arch/arm64/mm/proc.S           | 70 +++++++++++++++++---
 2 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f8e3f37accdddc86..b0fee11886e54ca2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1729,6 +1729,9 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	pgd_t *kpti_ng_temp_pgd;
 	u64 alloc = 0;
 
+	if (levels == 5 && !pgtable_l5_enabled())
+		levels = 4;
+
 	if (__this_cpu_read(this_cpu_vector) == vectors) {
 		const char *v = arm64_get_bp_hardening_vector(EL1_VECTOR_KPTI);
 
@@ -1756,9 +1759,9 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 		//
 		// The physical pages are laid out as follows:
 		//
-		// +--------+-/-------+-/------ +-\\--------+
-		// :  PTE[] : | PMD[] : | PUD[] : || PGD[]  :
-		// +--------+-\-------+-\------ +-//--------+
+		// +--------+-/-------+-/------ +-/------ +-\\\--------+
+		// :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
+		// +--------+-\-------+-\------ +-\------ +-///--------+
 		//      ^
 		// The first page is mapped into this hierarchy at a PMD_SHIFT
 		// aligned virtual address, so that we can manipulate the PTE
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 74b846d77b88e843..f425cfc3e4dad188 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -215,16 +215,15 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	.macro	kpti_mk_tbl_ng, type, num_entries
 	add	end_\type\()p, cur_\type\()p, #\num_entries * 8
 .Ldo_\type:
-	ldr	\type, [cur_\type\()p]		// Load the entry
+	ldr	\type, [cur_\type\()p], #8	// Load the entry and advance
 	tbz	\type, #0, .Lnext_\type		// Skip invalid and
 	tbnz	\type, #11, .Lnext_\type	// non-global entries
 	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
-	str	\type, [cur_\type\()p]		// Update the entry
+	str	\type, [cur_\type\()p, #-8]	// Update the entry
 	.ifnc	\type, pte
 	tbnz	\type, #1, .Lderef_\type
 	.endif
 .Lnext_\type:
-	add	cur_\type\()p, cur_\type\()p, #8
 	cmp	cur_\type\()p, end_\type\()p
 	b.ne	.Ldo_\type
 	.endm
@@ -234,18 +233,18 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	 * fixmap slot associated with the current level.
 	 */
 	.macro	kpti_map_pgtbl, type, level
-	str	xzr, [temp_pte, #8 * (\level + 1)]	// break before make
+	str	xzr, [temp_pte, #8 * (\level + 2)]	// break before make
 	dsb	nshst
-	add	pte, temp_pte, #PAGE_SIZE * (\level + 1)
+	add	pte, temp_pte, #PAGE_SIZE * (\level + 2)
 	lsr	pte, pte, #12
 	tlbi	vaae1, pte
 	dsb	nsh
 	isb
 
 	phys_to_pte pte, cur_\type\()p
-	add	cur_\type\()p, temp_pte, #PAGE_SIZE * (\level + 1)
+	add	cur_\type\()p, temp_pte, #PAGE_SIZE * (\level + 2)
 	orr	pte, pte, pte_flags
-	str	pte, [temp_pte, #8 * (\level + 1)]
+	str	pte, [temp_pte, #8 * (\level + 2)]
 	dsb	nshst
 	.endm
 
@@ -278,6 +277,8 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	end_ptep	.req	x15
 	pte		.req	x16
 	valid		.req	x17
+	cur_p4dp	.req	x19
+	end_p4dp	.req	x20
 
 	mov	x5, x3				// preserve temp_pte arg
 	mrs	swapper_ttb, ttbr1_el1
@@ -285,6 +286,12 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 
 	cbnz	cpu, __idmap_kpti_secondary
 
+#if CONFIG_PGTABLE_LEVELS > 4
+	stp	x29, x30, [sp, #-32]!
+	mov	x29, sp
+	stp	x19, x20, [sp, #16]
+#endif
+
 	/* We're the boot CPU. Wait for the others to catch up */
 	sevl
 1:	wfe
@@ -302,9 +309,32 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	mov	pte_flags, #KPTI_NG_PTE_FLAGS
 
 	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
+
+#ifdef CONFIG_ARM64_LPA2
+	/*
+	 * If LPA2 support is configured, but 52-bit virtual addressing is not
+	 * enabled at runtime, we will fall back to one level of paging less,
+	 * and so we have to walk swapper_pg_dir as if we dereferenced its
+	 * address from a PGD level entry, and terminate the PGD level loop
+	 * right after.
+	 */
+	adrp	pgd, swapper_pg_dir	// walk &swapper_pg_dir at the next level
+	mov	cur_pgdp, end_pgdp	// must be equal to terminate the PGD loop
+alternative_if_not ARM64_HAS_VA52
+	b	.Lderef_pgd		// skip to the next level
+alternative_else_nop_endif
+	/*
+	 * LPA2 based 52-bit virtual addressing requires 52-bit physical
+	 * addressing to be enabled as well. In this case, the shareability
+	 * bits are repurposed as physical address bits, and should not be
+	 * set in pte_flags.
+	 */
+	bic	pte_flags, pte_flags, #PTE_SHARED
+#endif
+
 	/* PGD */
 	adrp		cur_pgdp, swapper_pg_dir
-	kpti_map_pgtbl	pgd, 0
+	kpti_map_pgtbl	pgd, -1
 	kpti_mk_tbl_ng	pgd, PTRS_PER_PGD
 
 	/* Ensure all the updated entries are visible to secondary CPUs */
@@ -317,16 +347,33 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 
 	/* Set the flag to zero to indicate that we're all done */
 	str	wzr, [flag_ptr]
+#if CONFIG_PGTABLE_LEVELS > 4
+	ldp	x19, x20, [sp, #16]
+	ldp	x29, x30, [sp], #32
+#endif
 	ret
 
 .Lderef_pgd:
+	/* P4D */
+	.if		CONFIG_PGTABLE_LEVELS > 4
+	p4d		.req	x30
+	pte_to_phys	cur_p4dp, pgd
+	kpti_map_pgtbl	p4d, 0
+	kpti_mk_tbl_ng	p4d, PTRS_PER_P4D
+	b		.Lnext_pgd
+	.else		/* CONFIG_PGTABLE_LEVELS <= 4 */
+	p4d		.req	pgd
+	.set		.Lnext_p4d, .Lnext_pgd
+	.endif
+
+.Lderef_p4d:
 	/* PUD */
 	.if		CONFIG_PGTABLE_LEVELS > 3
 	pud		.req	x10
-	pte_to_phys	cur_pudp, pgd
+	pte_to_phys	cur_pudp, p4d
 	kpti_map_pgtbl	pud, 1
 	kpti_mk_tbl_ng	pud, PTRS_PER_PUD
-	b		.Lnext_pgd
+	b		.Lnext_p4d
 	.else		/* CONFIG_PGTABLE_LEVELS <= 3 */
 	pud		.req	pgd
 	.set		.Lnext_pud, .Lnext_pgd
@@ -370,6 +417,9 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	.unreq	end_ptep
 	.unreq	pte
 	.unreq	valid
+	.unreq	cur_p4dp
+	.unreq	end_p4dp
+	.unreq	p4d
 
 	/* Secondary CPUs end up here */
 __idmap_kpti_secondary:
-- 
2.39.2

