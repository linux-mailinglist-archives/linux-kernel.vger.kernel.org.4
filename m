Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395E6AE1E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCGOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCGOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC64B867D8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B25CE61455
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D269C433A0;
        Tue,  7 Mar 2023 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198133;
        bh=ltQ/YiIke0+sXL8Rr299HB1L+76Qb5rdyScY2DfhQis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwi6ZGc9uiOfW12N3hmOy3TkZ8WYrqP3d8EKMbB9r2KXKqStCbxO2kLGZ0A/d0zBr
         evN4HcZWcm3wQTfmNwnCH1/MHbcIybNdlFhkV215BuaWgA1IpFfzN/nW90XNkpx7pg
         MmIinHRXNQYROIkLCoFQedYkVBkfQS45hSh/z1jZQs4z3o0YFBRcPs77Dh9LbycgED
         PwIOuWDzVCZ5ImqkyI+CDY99tO/vvG5Ki4RuCBJcHmjwPm790UOKOcX8f0PGPWnXE8
         ZJ2p0NIzi7BId+OocRZLwVgZXuildH0SZh8EbbOcYfupwAnVUzLo3kQrWlaCMaPo3m
         mjNRGxwuGpWVA==
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
Subject: [PATCH v3 56/60] arm64: kvm: Limit HYP VA and host S2 range to 48 bits when LPA2 is in effect
Date:   Tue,  7 Mar 2023 15:05:18 +0100
Message-Id: <20230307140522.2311461-57-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=ardb@kernel.org; h=from:subject; bh=ltQ/YiIke0+sXL8Rr299HB1L+76Qb5rdyScY2DfhQis=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZfq5Vavm1mX9fnaAz6wwr7m94rztkk+GvIUPVSS/L P6ZsTS7o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkgwvDf/cHaRVvReZwdZV/ idMQWbzx7BPuoqJyB6d4XZ3/nKqdhxgZbq/nfN5xTMI5IzjfouNBe2KPi1SRomNZa9tuneXqMd1 8AA==
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

The KVM code needs more work to support 5 level paging with LPA2, so for
the time being, limit KVM to 48 bit addressing on 4k and 16k pagesize
configurations. This can be reverted once the LPA2 support for KVM is
merged.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 ++
 arch/arm64/kvm/mmu.c                  | 5 ++++-
 arch/arm64/kvm/va_layout.c            | 9 +++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 552653fa18be34b2..e00b87ed4a8400f6 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -128,6 +128,8 @@ static void prepare_host_vtcr(void)
 	/* The host stage 2 is id-mapped, so use parange for T0SZ */
 	parange = kvm_get_parange(id_aa64mmfr0_el1_sys_val);
 	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
+	if (IS_ENABLED(CONFIG_ARM64_LPA2) && phys_shift > 48)
+		phys_shift = 48; // not implemented yet
 
 	host_mmu.arch.vtcr = kvm_get_vtcr(id_aa64mmfr0_el1_sys_val,
 					  id_aa64mmfr1_el1_sys_val, phys_shift);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 4e7c0f9a9c286c09..2ad9e6f1e101e52d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -661,7 +661,8 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
 {
 	struct kvm_pgtable pgt = {
 		.pgd		= (kvm_pteref_t)kvm->mm->pgd,
-		.ia_bits	= vabits_actual,
+		.ia_bits	= IS_ENABLED(CONFIG_ARM64_LPA2) ? 48
+								: vabits_actual,
 		.start_level	= (KVM_PGTABLE_MAX_LEVELS -
 				   ARM64_HW_PGTABLE_LEVELS(pgt.ia_bits)),
 		.mm_ops		= &kvm_user_mm_ops,
@@ -1703,6 +1704,8 @@ int __init kvm_mmu_init(u32 *hyp_va_bits)
 	idmap_bits = 48;
 	kernel_bits = vabits_actual;
 	*hyp_va_bits = max(idmap_bits, kernel_bits);
+	if (IS_ENABLED(CONFIG_ARM64_LPA2))
+		*hyp_va_bits = 48; // LPA2 is not yet supported in KVM
 
 	kvm_debug("Using %u-bit virtual addresses at EL2\n", *hyp_va_bits);
 	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 341b67e2f2514e55..ac87d0c39c38f7d9 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -59,12 +59,13 @@ static void init_hyp_physvirt_offset(void)
  */
 __init void kvm_compute_layout(void)
 {
+	u64 vabits = IS_ENABLED(CONFIG_ARM64_LPA2) ? 48 : vabits_actual; // not yet
 	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
 	u64 hyp_va_msb;
 
 	/* Where is my RAM region? */
-	hyp_va_msb  = idmap_addr & BIT(vabits_actual - 1);
-	hyp_va_msb ^= BIT(vabits_actual - 1);
+	hyp_va_msb  = idmap_addr & BIT(vabits - 1);
+	hyp_va_msb ^= BIT(vabits - 1);
 
 	tag_lsb = fls64((u64)phys_to_virt(memblock_start_of_DRAM()) ^
 			(u64)(high_memory - 1));
@@ -72,10 +73,10 @@ __init void kvm_compute_layout(void)
 	va_mask = GENMASK_ULL(tag_lsb - 1, 0);
 	tag_val = hyp_va_msb;
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1) &&
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits - 1) &&
 	    !kaslr_disabled_cmdline()) {
 		/* We have some free bits to insert a random tag. */
-		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
+		tag_val |= get_random_long() & GENMASK_ULL(vabits - 2, tag_lsb);
 	}
 	tag_val >>= tag_lsb;
 
-- 
2.39.2

