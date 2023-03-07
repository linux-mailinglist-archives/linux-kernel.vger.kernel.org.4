Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1968C6AE1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCGOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCGOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EB93874
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83C90B818F9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E9C433A1;
        Tue,  7 Mar 2023 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198063;
        bh=LGPwuGUBE9+D2Ri4mVTa9KzwPrnmKSHtWXBpjrEGvfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwzOzBuuV/wfG5j8QfOfX32RG0eTjM+i2oreD47PIfD3xfe6B8MWngtR5XRC0GzhU
         5B6cc0APiUj0c+EvQfL1dcFT3tOVcKBJYt3xBd1LA5qKWqjel9ddOwaK9TSr8dlq9S
         bsQ3ieraqDDj+gClYHPuEXhJ+65Ka1BJ+jAIgphsLHMYA8v1ABeGYMWCoL0H3YLJ+E
         pphixn4kEPbe/FsBnLjFah7Q4mhll9rULdSHzJhLssrLHSGIe8OZgvk4udC32738SE
         Gg84NPJJAs94/bytiFf1AoJ+9oQni2qFHObKbvekDheKuCwdKbb5vkqWlnU3hMz6w+
         GSwxrNUkJcohA==
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
Subject: [PATCH v3 27/60] arm64: head: Run feature override detection before mapping the kernel
Date:   Tue,  7 Mar 2023 15:04:49 +0100
Message-Id: <20230307140522.2311461-28-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=ardb@kernel.org; h=from:subject; bh=LGPwuGUBE9+D2Ri4mVTa9KzwPrnmKSHtWXBpjrEGvfU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxenLuW+3y64XPmd4dOOZjIxXtH5B38riC5cW7E5d2 HJqu9zEjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRlfMY/qd5fVJ2i2BfrprU flVk2TPP4nqFYv73WeI1mbu/zDo7M53hv7vjEWPNV49u3VqyxGqfzLQvKRcjL7fvvH9USoevqpN RiBMA
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

To permit the feature overrides to be taken into account before the
KASLR init code runs and the kernel mapping is created, move the
detection code to an earlier stage in the boot.

In a subsequent patch, this will be taken advantage of by merging the
preliminary and permanent mappings of the kernel text and data into a
single one that gets created and relocated before start_kernel() is
called.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 17 +++++++++--------
 arch/arm64/kernel/vmlinux.lds.S |  4 +---
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ade0cb99c8a83a3d..0a345898a12939af 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -375,9 +375,9 @@ SYM_FUNC_START_LOCAL(create_idmap)
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
-	/* Remap BSS and the kernel page tables r/w in the ID map */
+	/* Remap [.init].data, BSS and the kernel page tables r/w in the ID map */
 	adrp	x1, _text
-	adrp	x2, __bss_start
+	adrp	x2, __initdata_begin
 	adrp	x3, _end
 	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
 	mov	x5, SWAPPER_RW_MMUFLAGS
@@ -491,9 +491,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
-	mov	x0, x20				// pass the full boot status
-	mov	x1, x22				// pass the low FDT mapping
-	bl	__pi_init_feature_override	// Parse cpu feature overrides
 #ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
 	bl	scs_patch_vmlinux
 #endif
@@ -770,12 +767,16 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-#ifdef CONFIG_RELOCATABLE
-	adrp	x23, KERNEL_START
-	and	x23, x23, MIN_KIMG_ALIGN - 1
 	adrp	x1, early_init_stack
 	mov	sp, x1
 	mov	x29, xzr
+	mov	x0, x20				// pass the full boot status
+	mov	x1, x22				// pass the low FDT mapping
+	bl	__pi_init_feature_override	// Parse cpu feature overrides
+
+#ifdef CONFIG_RELOCATABLE
+	adrp	x23, KERNEL_START
+	and	x23, x23, MIN_KIMG_ALIGN - 1
 #ifdef CONFIG_RANDOMIZE_BASE
 	mov	x0, x22
 	bl	__pi_kaslr_early_init
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ec24b1e70d606ec8..6c79ad2945749260 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -318,10 +318,8 @@ SECTIONS
 	init_pg_dir = .;
 	. += INIT_DIR_SIZE;
 	init_pg_end = .;
-#ifdef CONFIG_RELOCATABLE
-	. += SZ_4K;		/* stack for the early relocation code */
+	. += SZ_4K;		/* stack for the early C runtime */
 	early_init_stack = .;
-#endif
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
-- 
2.39.2

