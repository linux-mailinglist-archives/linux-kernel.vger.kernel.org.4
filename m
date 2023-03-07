Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB016AE1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCGOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCGOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8882A97
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCAECB818FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D267C433A8;
        Tue,  7 Mar 2023 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198005;
        bh=hBUqn7EZsvUyWwjx7asK+P907e4suMk6qjEd4crdyQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvo/Hg08mBnHc9fz669GQGSADGEm5qsN1v4mbr78UWGMA8gQe98pgftKpnVST0tN1
         xC9ri5iafO2UOEVPxceNcF4KQg2SwdHwWxL+IjoUVT1payPlvueLo0XmL8VFYHBCFq
         88fTDGd0sMGo1LJvIFRybz6G4QXq/mNuQpibkAXJJQRuHJKZ9RiPxSiyDosnUsLEEe
         kAZHAUp1PQOKlXNBEhpcgZXhtHpArh9s49lU7tAo41mjudrNd5xXZAbtupUKc7lTpm
         lHAxPQ4mvXdzyG9cc7FfZeh6QCyKXUCvWG1YZI/cZfFxhfCqN8kMHECBwzqVCa+Pst
         tdP1q3jbsw5QQ==
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
Subject: [PATCH v3 03/60] arm64: mm: get rid of kimage_vaddr global variable
Date:   Tue,  7 Mar 2023 15:04:25 +0100
Message-Id: <20230307140522.2311461-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=ardb@kernel.org; h=from:subject; bh=hBUqn7EZsvUyWwjx7asK+P907e4suMk6qjEd4crdyQM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhUXbq3bTyunX+x8VqO+4uYjb8fxDT/u9ia8d7esSu wsqGc92lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInIOTL8Fe1LX33GdE3hs/xX zytaNbrmR3x5sNdS2qxbTdiC8fVFM0aG67eunz/Q91rl4Po9wiZXVhx4w7nqLAfzSZ/qFDNltYk rOAE=
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

We store the address of _text in kimage_vaddr, but since commit
09e3c22a86f6889d ("arm64: Use a variable to store non-global mappings
decision"), we no longer reference this variable from modules so we no
longer need to export it.

In fact, we don't need it at all so let's just get rid of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h | 6 ++----
 arch/arm64/kernel/head.S        | 2 +-
 arch/arm64/mm/mmu.c             | 3 ---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0ab95..a4e1d832a15a2d7a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -182,6 +182,7 @@
 #include <linux/types.h>
 #include <asm/boot.h>
 #include <asm/bug.h>
+#include <asm/sections.h>
 
 #if VA_BITS > 48
 extern u64			vabits_actual;
@@ -193,15 +194,12 @@ extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
 
-/* the virtual base of the kernel image */
-extern u64			kimage_vaddr;
-
 /* the offset between the kernel virtual and physical mappings */
 extern u64			kimage_voffset;
 
 static inline unsigned long kaslr_offset(void)
 {
-	return kimage_vaddr - KIMAGE_VADDR;
+	return (u64)&_text - KIMAGE_VADDR;
 }
 
 static inline bool kaslr_enabled(void)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b98970907226b36c..65cdaaa2c859418f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -482,7 +482,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 
-	ldr_l	x4, kimage_vaddr		// Save the offset between
+	adrp	x4, _text			// Save the offset between
 	sub	x4, x4, x0			// the kernel virtual and
 	str_l	x4, kimage_voffset, x5		// physical mappings
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f9d8898a02516f6..81e1420d2cc13246 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -50,9 +50,6 @@ u64 vabits_actual __ro_after_init = VA_BITS_MIN;
 EXPORT_SYMBOL(vabits_actual);
 #endif
 
-u64 kimage_vaddr __ro_after_init = (u64)&_text;
-EXPORT_SYMBOL(kimage_vaddr);
-
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-- 
2.39.2

