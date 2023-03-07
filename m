Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057106AE1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCGOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCGOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B815CA7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCC961455
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD50DC433A7;
        Tue,  7 Mar 2023 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198077;
        bh=5NPb4B7DLXdRfGBUFKwsc4EGZ/Nj6237LOVxsKjUH1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3W34T8rh8RZYuV/7rNzp72cLllzIuLaA7QzKPle0lj3WaPJptvdI2zioMoVebCWv
         bu6NR7/hneCcKdNele7Hxe2Eht+ZulSb4D1LuQJzHiXJKJFmdyexvM3cuRblMpRT93
         qJY6/bWJOyq7Gu6ISZwExtgpUT66owY03eGWzjdlWU3lwMCqGaLmNl7zNtBty4kh9X
         s9nzzGonQVCPxOdL/E/pJ9E6wz3uzPLKxlAnE4o/65mPCbQkx3uQDEcHXj6cEv5Aoy
         ADhLH5hUPmfpaZm8Z4z4ImiFtbEv44lNXq61crSY0xUWHWiy3vU8qCHqYV97q+71wo
         WplSaTarwOAvA==
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
Subject: [PATCH v3 33/60] arm64: head: move memstart_offset_seed handling to C code
Date:   Tue,  7 Mar 2023 15:04:55 +0100
Message-Id: <20230307140522.2311461-34-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; i=ardb@kernel.org; h=from:subject; bh=5NPb4B7DLXdRfGBUFKwsc4EGZ/Nj6237LOVxsKjUH1g=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJbBs68xHV729dDdOMVjnwHtLdeu8HsflazifWT7bG 53gVbKoo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEjY/hr1j7tCbOj3lvr/Re 3sdScD7jHyeXTj9rdL2LaMtLd8YjUgx/OFvaFKPczIS5K8IX2SU0frvSudJ5Qo3HKvdDfaUvghO 4AA==
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

Now that we can set BSS variables from the early code running from the
ID map, we can set memstart_offset_seed directly from the C code that
derives the value instead of passing it back and forth between C and asm
code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S           | 7 -------
 arch/arm64/kernel/image-vars.h     | 1 +
 arch/arm64/kernel/pi/kaslr_early.c | 4 ++++
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 70ad180eed364906..81c2dd06420992ea 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -82,7 +82,6 @@
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        __primary_switch()                       physical misalignment/KASLR offset
-	 *  x24        __primary_switch()                       linear map KASLR seed
 	 *  x25        primary_entry() .. start_kernel()        supported VA size
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
@@ -483,11 +482,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	str	x25, [x8]			// ... observes the correct value
 	dc	civac, x8			// Make visible to booting secondaries
 #endif
-
-#ifdef CONFIG_RANDOMIZE_BASE
-	adrp	x5, memstart_offset_seed	// Save KASLR linear map seed
-	strh	w24, [x5, :lo12:memstart_offset_seed]
-#endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
@@ -777,7 +771,6 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #ifdef CONFIG_RANDOMIZE_BASE
 	mov	x0, x22
 	bl	__pi_kaslr_early_init
-	and	x24, x0, #SZ_2M - 1		// capture memstart offset seed
 	bic	x0, x0, #SZ_2M - 1
 	orr	x23, x23, x0			// record kernel offset
 #endif
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 5aa914ea919a1149..b7fa7fbf8fa543a6 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -44,6 +44,7 @@ PROVIDE(__pi_id_aa64smfr0_override	= id_aa64smfr0_override);
 PROVIDE(__pi_id_aa64zfr0_override	= id_aa64zfr0_override);
 PROVIDE(__pi_arm64_sw_feature_override	= arm64_sw_feature_override);
 PROVIDE(__pi__ctype			= _ctype);
+PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 
 #ifdef CONFIG_KVM
 
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index f2305e276ec36803..eeecee7ffd6fa125 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -16,6 +16,8 @@
 #include <asm/memory.h>
 #include <asm/pgtable.h>
 
+extern u16 memstart_offset_seed;
+
 static u64 __init get_kaslr_seed(void *fdt)
 {
 	static char const chosen_str[] __initconst = "chosen";
@@ -51,6 +53,8 @@ asmlinkage u64 __init kaslr_early_init(void *fdt)
 			return 0;
 	}
 
+	memstart_offset_seed = seed & U16_MAX;
+
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
-- 
2.39.2

