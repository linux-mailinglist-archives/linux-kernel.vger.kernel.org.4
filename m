Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF696AE1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCGOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCGOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5C8314A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D54D61457
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD895C433D2;
        Tue,  7 Mar 2023 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198089;
        bh=uWLIu3yqNCwcrGkRr50TGOXKaa6P6eE4gao1D3xoCEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwFAh6VGmHFEMKpps+Sndm/kF/KFeIpQ5F+mfHpWHoLpyPyy0AIil6DnL38nbFaz0
         V/32tC5/+fBAMEk+RZ2/vg0XSKJbkhKBcFX4YPu+k4wvmV92qSFaqhmqVq0LD4IFWw
         LEz8nRAndNcOb+gm8NBBZOR9KnCTMz4YpytDpORhYCJnjgXVnu7nLFbuuEL3wRByBf
         XZsOO9mpXMsv//CgtIK+BHVsC/zfucJu1GAEXsTPGKjNqYN9nM12m63Z10/NW2k83E
         ZqG56RV2YbmVmRIKZXlDQyogUck/gpMYJF4ubL0xk1S5EJ4mIkHLqq2CHFyeOApyxJ
         wUXmsvFEEUf2A==
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
Subject: [PATCH v3 38/60] arm64: mm: avoid fixmap for early swapper_pg_dir updates
Date:   Tue,  7 Mar 2023 15:05:00 +0100
Message-Id: <20230307140522.2311461-39-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=ardb@kernel.org; h=from:subject; bh=uWLIu3yqNCwcrGkRr50TGOXKaa6P6eE4gao1D3xoCEo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJengQ+5ILZ+4yZ9msfx3jPXdZhPU7u7Ol/7ZgPlZy TbFj3wdJSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIz6xi+afk8mqa8y2apu9bv Wx7fft8tTHfYlfzF7qrwPS+Nls1KDH/lNktwyi7Z2i/UPnWCSf+SHNYd0mekTDTrvptY1De4LOI CAA==
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

Early in the boot, when .rodata is still writable, we can poke
swapper_pg_dir entries directly, and there is no need to go through the
fixmap. After a future patch, we will enter the kernel with
swapper_pg_dir already active, and early swapper_pg_dir updates for
creating the fixmap page table hierarchy itself cannot go through the
fixmap for obvious reaons. So let's keep track of whether rodata is
writable, and update the descriptor directly in that case.

As the same reasoning applies to early KASAN init, make the function
noinstr as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 13f46c911558f21f..3f631f3bc2f80b2b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -53,6 +53,8 @@ EXPORT_SYMBOL(kimage_voffset);
 
 u32 __boot_cpu_mode[] = { BOOT_CPU_MODE_EL2, BOOT_CPU_MODE_EL1 };
 
+static bool rodata_is_rw __ro_after_init = true;
+
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
  * with MMU turned off.
@@ -73,10 +75,21 @@ static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
 static DEFINE_MUTEX(fixmap_lock);
 
-void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
+void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	pgd_t *fixmap_pgdp;
 
+	/*
+	 * Don't bother with the fixmap if swapper_pg_dir is still mapped
+	 * writable in the kernel mapping.
+	 */
+	if (rodata_is_rw) {
+		WRITE_ONCE(*pgdp, pgd);
+		dsb(ishst);
+		isb();
+		return;
+	}
+
 	spin_lock(&swapper_pgdir_lock);
 	fixmap_pgdp = pgd_set_fixmap(__pa_symbol(pgdp));
 	WRITE_ONCE(*fixmap_pgdp, pgd);
@@ -614,6 +627,7 @@ void mark_rodata_ro(void)
 	 * to cover NOTES and EXCEPTION_TABLE.
 	 */
 	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
+	WRITE_ONCE(rodata_is_rw, false);
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
 
-- 
2.39.2

