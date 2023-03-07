Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF46AE1E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCGOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCGOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:11:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82C8B05B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A60B61458
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAAFC4339C;
        Tue,  7 Mar 2023 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198094;
        bh=PQI4coC3/ibnm3/mD+JXkBCOdMxxUJnhmcG2A1VOyNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFMQQf+WtXmiw+m8jB4brIlFnzMWsBhXfd1g7Fi+I27gwyc4e+efcJWcx+zrK/lnd
         dqWFRmz/WUSohHI9wDlpJ4OcVTuFAX4oyxaWH5bo4lzuROE1XH/BDIB7fN/HNTz/ch
         aXBb/8ZFPa3KGsH8ApheDzEGNp16+JhGsdI8VWTqtIGs5BJZTAa6qYcex2EKfqWyc7
         ekLRxzbTkVH0ywzgZuvE1uy3qefbdZGvncYUmYv4oqiIigy/7MIjwDDiKivY4xVE4V
         a5sVneCSA0o0ulki0bdQ1N9SxrDjvu0scgqXv24OcAbbirW80Idvu7tpxwlGZgR1O+
         8zoWg774s3Y/g==
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
Subject: [PATCH v3 40/60] arm64: Revert "mm: provide idmap pointer to cpu_replace_ttbr1()"
Date:   Tue,  7 Mar 2023 15:05:02 +0100
Message-Id: <20230307140522.2311461-41-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3767; i=ardb@kernel.org; h=from:subject; bh=PQI4coC3/ibnm3/mD+JXkBCOdMxxUJnhmcG2A1VOyNA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJd2wI3XZxHcbg78XCtwqTV+vbr7kpe/3iLab5bumb WZrPcDQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSzM3wV2zxykVWmnOXrzXh LrtUMvFc6C95va8cShmx+tl33kX4izL8dz/y46OtypvzP1qfVqxOT/m8pvNTAbdWVI757YMWBb4 6LAA=
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

This reverts commit 1682c45b920643c, which is no longer needed now that
we create the permanent kernel mapping directly during early boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 13 ++++---------
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/suspend.c          |  2 +-
 arch/arm64/mm/kasan_init.c           |  4 ++--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f9ae2891e4c72c7f..bc1cef5002d60e02 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -104,18 +104,13 @@ static inline void cpu_uninstall_idmap(void)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
-static inline void __cpu_install_idmap(pgd_t *idmap)
+static inline void cpu_install_idmap(void)
 {
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
 	cpu_set_idmap_tcr_t0sz();
 
-	cpu_switch_mm(lm_alias(idmap), &init_mm);
-}
-
-static inline void cpu_install_idmap(void)
-{
-	__cpu_install_idmap(idmap_pg_dir);
+	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
 }
 
 /*
@@ -146,7 +141,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
@@ -170,7 +165,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
-	__cpu_install_idmap(idmap);
+	cpu_install_idmap();
 
 	/*
 	 * We really don't want to take *any* exceptions while TTBR1 is
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e9788671be044a47..b206de4758ce6fb3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3456,7 +3456,7 @@ subsys_initcall_sync(init_32bit_el0_mask);
 
 static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *cap)
 {
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 }
 
 /*
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 0fbdf5fe64d8da08..7c2391851db6c198 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -55,7 +55,7 @@ void notrace __cpu_suspend_exit(void)
 
 	/* Restore CnP bit in TTBR1_EL1 */
 	if (system_supports_cnp())
-		cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
+		cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index df98f496539f0e39..7e32f21fb8e1e227 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -221,7 +221,7 @@ static void __init kasan_init_shadow(void)
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
-	cpu_replace_ttbr1(lm_alias(tmp_pg_dir), idmap_pg_dir);
+	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -265,7 +265,7 @@ static void __init kasan_init_shadow(void)
 				PAGE_KERNEL_RO));
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 }
 
 static void __init kasan_init_depth(void)
-- 
2.39.2

