Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD86AE1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCGOH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCGOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D785B32
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1D97CE1BDB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367EC433A4;
        Tue,  7 Mar 2023 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198020;
        bh=Z0j9wObyTVXTZrQkvIz4QQhYFAAbwmqHXOPjNCPpS40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmh/0+WLWyZKE1AZ3RFWsVNPhgKp5N7kvnG6UXYFoRSwV742n6zU5hHla6sYel8b8
         gelii+DvPq3+paT6Q8VQpr+1MSznAYJVO+H7ewASUZC36Uj3UvEP7totQL9gEYlkUd
         nkXfyque6u9vmwh4N65YehGqBPLgrLSlovO5XKvglPPlGyjzUFVy6/x/37Mc40jx+3
         v846mKqopwhcSJm6xWrdnZMQmYZFQ9kdYn+kvst5kBLKb9C+ncfkHBEjHEZDbqEE6u
         /NDV7UJF0Dvris3SEjHM3WMXfNv6tAxPZPZ2ZkA4x3XVCQaqfW2AqHZpASMt+E+isr
         FTwy4IHFKhl+g==
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
Subject: [PATCH v3 09/60] arm64: mm: Reclaim unused vmemmap region for vmalloc use
Date:   Tue,  7 Mar 2023 15:04:31 +0100
Message-Id: <20230307140522.2311461-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ardb@kernel.org; h=from:subject; bh=Z0j9wObyTVXTZrQkvIz4QQhYFAAbwmqHXOPjNCPpS40=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRcCqS6Dq49uTy+6v12D4px0bKZe08mLAWU8/5j8OC cuv8jh0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIksFmBkeHaolWfTxmUGO+cd 7IjIXa8+J3uSbt/t8G/LL7Z2sP77NJuR4fedH2YyrWsUV6+7uqPwdlK95S7N0p3zL53T3LZ9Ybj JBXYA
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

The vmemmap array is statically sized based on the maximum supported
size of the virtual address space, but it is located inside the upper VA
region, which is statically sized based on the *minimum* supported size
of the VA space. This doesn't matter much when using 64k pages, which is
the only configuration that currently supports 52-bit virtual
addressing.

However, upcoming LPA2 support will change this picture somewhat, as in
that case, the vmemmap array will take up more than 25% of the upper VA
region when using 4k pages. Given that most of this space is never used
when running on a system that does not support 52-bit virtual
addressing, let's reclaim the unused vmemmap area in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3eff06c5d0eb73c7..2259898e8c3d990a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -18,11 +18,15 @@
  * VMALLOC range.
  *
  * VMALLOC_START: beginning of the kernel vmalloc space
- * VMALLOC_END: extends to the available space below vmemmap, PCI I/O space
- *	and fixed mappings
+ * VMALLOC_END: extends to the available space below vmemmap
  */
 #define VMALLOC_START		(MODULES_END)
+#if VA_BITS == VA_BITS_MIN
 #define VMALLOC_END		(VMEMMAP_START - SZ_8M)
+#else
+#define VMEMMAP_UNUSED_NPAGES	((_PAGE_OFFSET(vabits_actual) - PAGE_OFFSET) >> PAGE_SHIFT)
+#define VMALLOC_END		(VMEMMAP_START + VMEMMAP_UNUSED_NPAGES * sizeof(struct page) - SZ_8M)
+#endif
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
-- 
2.39.2

