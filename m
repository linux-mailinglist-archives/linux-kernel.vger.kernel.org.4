Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3C6AE1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCGOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCGOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11130EFB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D068E6145B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C9C433A4;
        Tue,  7 Mar 2023 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198075;
        bh=fcy++RWuRbBBHw56QOT+oXIgL+AugLZxq+IvNCB50sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUzHbJjf7kiWWmaqsrzJIjXwiaG8HD504qAbcJqXcK3SWWQQxmDlHqAIcytgLAW40
         sMRCt+PKe8J0HHpiGK98GdPjdByLrIscwhPG2PJye2lUYjEdADOZ4doOMUVc1w2VfF
         zt6fvfJ3QvtrKolEzUbx0QjVE6vL+32NhrmKy4xb2RKDCQ6b4oANRXdvbIW5Grik3D
         bf+gYK2IoGv1ZypSGeDo/wFSeW0HM8JCU/nLv/r7u54vHarO7cWdSt9O3gE8T1YVCM
         wSFSLhCSQk+u1Vdc2or8y0buQ3u3hfDl1MU9MtIyiNmob+PR3M4ReWTrPuCU7JDljG
         fvX1vLaYgBc2A==
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
Subject: [PATCH v3 32/60] arm64: head: allocate more pages for the kernel mapping
Date:   Tue,  7 Mar 2023 15:04:54 +0100
Message-Id: <20230307140522.2311461-33-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=ardb@kernel.org; h=from:subject; bh=fcy++RWuRbBBHw56QOT+oXIgL+AugLZxq+IvNCB50sk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxf+jbe4jxmXOrYUVzf6Klzkn9cy+dCUs8Fz0DX/hv xdNHas6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERm3mD4X+G0QT9N4bjxaTfb cxdXH/CbIy+ueSZ4s7gQm1LBrOYP0xkZti5JqlnnNfuFwKR9htP5pt23m7i4yU5C/uDxuQ2PRRN mMwAA
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

In preparation for switching to an early kernel mapping routine that
maps each segment according to its precise boundaries, and with the
correct attributes, let's allocate some extra pages for page tables for
the 4k page size configuration. This is necessary because the start and
end of each segment may not be aligned to the block size, and so we'll
need an extra page table at each segment boundary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 4d13c73171e1e360..50b5c145358a5d8e 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -80,7 +80,7 @@
 			+ EARLY_PGDS((vstart), (vend), add) 	/* each PGDIR needs a next level page table */	\
 			+ EARLY_PUDS((vstart), (vend), add)	/* each PUD needs a next level page table */	\
 			+ EARLY_PMDS((vstart), (vend), add))	/* each PMD needs a next level page table */
-#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR))
+#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR) + EARLY_SEGMENT_EXTRA_PAGES))
 
 /* the initial ID map may need two extra pages if it needs to be extended */
 #if VA_BITS < 48
@@ -101,6 +101,15 @@
 #define SWAPPER_TABLE_SHIFT	PMD_SHIFT
 #endif
 
+/* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
+#define KERNEL_SEGMENT_COUNT	5
+
+#if SWAPPER_BLOCK_SIZE > SEGMENT_ALIGN
+#define EARLY_SEGMENT_EXTRA_PAGES (KERNEL_SEGMENT_COUNT + 1)
+#else
+#define EARLY_SEGMENT_EXTRA_PAGES 0
+#endif
+
 /*
  * Initial memory map attributes.
  */
-- 
2.39.2

