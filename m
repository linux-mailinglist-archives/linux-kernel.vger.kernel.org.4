Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B366AE1D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCGOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCGOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49CC211CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043CF6135E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DE3C433A0;
        Tue,  7 Mar 2023 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198058;
        bh=WFiiboUNlXGaUmkdqX5fmc34WsQ0VoU7MZXGSi+88TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaLcnLPEg0R+H7zkhz3RRod76KFXo1jHQJ+Z2pIZw8gBUIaW920u2MWBAmmWFdtKP
         8dvvK9g9F+GKwTaN5prLbCyhc8eVemUZCWJq1ZGQkECClqtwEUjo+zWRE5nRBkgiXY
         fzJbMXpG0hH+B2/0kM7PEcSKjnIttGefaKzzJRxe5sXlOT4jyYbnp1QJOpXyu/sme2
         tL/ldM3Ry/gF4tHQN2bHSIXOAZDGDRq42ujT/Gg+kWZVWZRe39bY4Bdka6rUSICEoQ
         lNtKXSQLKwpr157uiwgiwPtjo+A14yZGy3ZXJvZw97A2zMhhtbSfu6vgepvECvLty6
         vxtK5iidqEnPw==
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
Subject: [PATCH v3 25/60] arm64: head: Clear BSS and the kernel page tables in one go
Date:   Tue,  7 Mar 2023 15:04:47 +0100
Message-Id: <20230307140522.2311461-26-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710; i=ardb@kernel.org; h=from:subject; bh=WFiiboUNlXGaUmkdqX5fmc34WsQ0VoU7MZXGSi+88TY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxa4nKujXcpU7UUunp7dPm2V91+ioYHtD9PcSgc0Kl Q6WK4I7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESu3GP4zSJrGhGr3XMr3WO3 MePS4n1MhiGmidrP95xlZ0tJs/26hZGhYcsnfq7aKU21ytETP+vEmM9WnKO85YPQ7uiwN60LBcV ZAA==
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

We will move the CPU feature overrides into BSS in a subsequent patch,
and this requires that BSS is zeroed before the feature override
detection code runs. So let's map BSS read-write in the ID map, and zero
it via this mapping.

Since the kernel page tables are right next to it, and also zeroed via
the ID map, let's drop the separate clear_page_tables() function, and
just zero everything in one go.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 33 +++++++-------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0fa44b3188c1e204..ade0cb99c8a83a3d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -177,17 +177,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	ret
 SYM_CODE_END(preserve_boot_args)
 
-SYM_FUNC_START_LOCAL(clear_page_tables)
-	/*
-	 * Clear the init page tables.
-	 */
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	sub	x2, x1, x0
-	mov	x1, xzr
-	b	__pi_memset			// tail call
-SYM_FUNC_END(clear_page_tables)
-
 /*
  * Macro to populate page table entries, these entries can be pointers to the next level
  * or last level entries pointing to physical memory.
@@ -386,9 +375,9 @@ SYM_FUNC_START_LOCAL(create_idmap)
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
-	/* Remap the kernel page tables r/w in the ID map */
+	/* Remap BSS and the kernel page tables r/w in the ID map */
 	adrp	x1, _text
-	adrp	x2, init_pg_dir
+	adrp	x2, __bss_start
 	adrp	x3, _end
 	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
 	mov	x5, SWAPPER_RW_MMUFLAGS
@@ -489,14 +478,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
 
-	// Clear BSS
-	adr_l	x0, __bss_start
-	mov	x1, xzr
-	adr_l	x2, __bss_stop
-	sub	x2, x2, x0
-	bl	__pi_memset
-	dsb	ishst				// Make zero page visible to PTW
-
 #if VA_BITS > 48
 	adr_l	x8, vabits_actual		// Set this early so KASAN early init
 	str	x25, [x8]			// ... observes the correct value
@@ -780,6 +761,15 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
+
+	// Clear BSS
+	adrp	x0, __bss_start
+	mov	x1, xzr
+	adrp	x2, init_pg_end
+	sub	x2, x2, x0
+	bl	__pi_memset
+	dsb	ishst				// Make zero page visible to PTW
+
 #ifdef CONFIG_RELOCATABLE
 	adrp	x23, KERNEL_START
 	and	x23, x23, MIN_KIMG_ALIGN - 1
@@ -794,7 +784,6 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	orr	x23, x23, x0			// record kernel offset
 #endif
 #endif
-	bl	clear_page_tables
 	bl	create_kernel_mapping
 
 	adrp	x1, init_pg_dir
-- 
2.39.2

