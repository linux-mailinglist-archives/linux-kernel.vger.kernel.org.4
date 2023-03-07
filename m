Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0653F6AE1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCGOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCGOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258577C977
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C12B818F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614BDC4339C;
        Tue,  7 Mar 2023 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198022;
        bh=I8MxwL21SRYQVbydpsDFcPf3vt74+IxUQU27Dld7h4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qp+dRVrDYWXKQ2Z4zwwsNBCYRqaD6UOgUCntdwC+5sDbVarIDLaSuriL4tNQffUu0
         MgnDccBLBrIzxwHYtppwtgy6CrkFnK0aI4KqMk/TUgKExeLkC8gTYlam/4aWdZ7uP4
         t6dXIF459MQXdNoh+lzmxgyN0jFishmUa/NVR+2o2hyZUoPPZIt3nJxaX+l/qDrO4U
         5h3tyQkbrN2IcYAmd+6BBEavXotcy49QgZeXd5PTdXOFD4YA/b3h7TjSjsifJpIFln
         igDPrAnMshSJqJ1uQ/XkaX+UiAwfun7mgO33ZZxGi3qOlW3TAK5E1n5XVQtHBnwZn5
         LzuMhCggLh0BQ==
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
Subject: [PATCH v3 10/60] arm64: kaslr: Adjust randomization range dynamically
Date:   Tue,  7 Mar 2023 15:04:32 +0100
Message-Id: <20230307140522.2311461-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=ardb@kernel.org; h=from:subject; bh=I8MxwL21SRYQVbydpsDFcPf3vt74+IxUQU27Dld7h4c=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRSiFc+mN/GOGRgZ6IoWXfrgrxTwxmpn7fE3tof8b7 6796lveUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSE87wTzc8VvzmGaa9hqsX zYxeOr9kR/78oh898ueXijxY38/If5Xhf8JNfYfi/xlyz3culPq99P7St8/W8LccvvNOqPrsbZe rR3gA
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

Currently, we base the KASLR randomization range on a rough estimate of
the available space in the upper VA region: the lower 1/4th has the
module region and the upper 1/4th has the fixmap, vmemmap and PCI I/O
ranges, and so we pick a random location in the remaining space in the
middle.

Once we enable support for 5-level paging with 4k pages, this no longer
works: the vmemmap region, being dimensioned to cover a 52-bit linear
region, takes up so much space in the upper VA region (the size of which
is based on a 48-bit VA space for compatibility with non-LVA hardware)
that the region above the vmalloc region takes up more than a quarter of
the available space.

So instead of a heuristic, let's derive the randomization range from the
actual boundaries of the vmalloc region.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h     |  2 ++
 arch/arm64/kernel/pi/kaslr_early.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8309197c0ebd4a8e..b5906f8e18d7eb8d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -34,6 +34,8 @@ PROVIDE(__pi___memcpy			= __pi_memcpy);
 PROVIDE(__pi___memmove			= __pi_memmove);
 PROVIDE(__pi___memset			= __pi_memset);
 
+PROVIDE(__pi_vabits_actual		= vabits_actual);
+
 #ifdef CONFIG_KVM
 
 /*
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 17bff6e399e46b0b..b9e0bb4bc6a9766f 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -14,6 +14,7 @@
 
 #include <asm/archrandom.h>
 #include <asm/memory.h>
+#include <asm/pgtable.h>
 
 /* taken from lib/string.c */
 static char *__strstr(const char *s1, const char *s2)
@@ -87,7 +88,7 @@ static u64 get_kaslr_seed(void *fdt)
 
 asmlinkage u64 kaslr_early_init(void *fdt)
 {
-	u64 seed;
+	u64 seed, range;
 
 	if (is_kaslr_disabled_cmdline(fdt))
 		return 0;
@@ -102,9 +103,9 @@ asmlinkage u64 kaslr_early_init(void *fdt)
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
-	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
-	 * the lower and upper quarters to avoid colliding with other
-	 * allocations.
+	 * 'middle' half of the VMALLOC area, and stay clear of the lower and
+	 * upper quarters to avoid colliding with other allocations.
 	 */
-	return BIT(VA_BITS_MIN - 3) + (seed & GENMASK(VA_BITS_MIN - 3, 0));
+	range = (VMALLOC_END - KIMAGE_VADDR) / 2;
+	return range / 2 + (((__uint128_t)range * seed) >> 64);
 }
-- 
2.39.2

