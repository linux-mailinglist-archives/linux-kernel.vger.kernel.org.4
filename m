Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324472E7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbjFMPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbjFMPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB91BC;
        Tue, 13 Jun 2023 08:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FCB61F1E;
        Tue, 13 Jun 2023 15:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F14CC433F0;
        Tue, 13 Jun 2023 15:52:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sh: Move the ARCH_DMA_MINALIGN definition to asm/cache.h
Date:   Tue, 13 Jun 2023 16:52:45 +0100
Message-Id: <20230613155245.1228274-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613155245.1228274-1-catalin.marinas@arm.com>
References: <20230613155245.1228274-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sh architecture defines ARCH_DMA_MINALIGN in asm/page.h. Move it to
asm/cache.h to allow a generic ARCH_DMA_MINALIGN definition in
linux/cache.h without redefine errors/warnings.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/cache.h | 6 ++++++
 arch/sh/include/asm/page.h  | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
index 32dfa6b82ec6..b38dbc975581 100644
--- a/arch/sh/include/asm/cache.h
+++ b/arch/sh/include/asm/cache.h
@@ -14,6 +14,12 @@
 
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
+/*
+ * Some drivers need to perform DMA into kmalloc'ed buffers
+ * and so we have to increase the kmalloc minalign for this.
+ */
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+
 #define __read_mostly __section(".data..read_mostly")
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 09ac6c7faee0..62f4b9edcb98 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -174,10 +174,4 @@ typedef struct page *pgtable_t;
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-/*
- * Some drivers need to perform DMA into kmalloc'ed buffers
- * and so we have to increase the kmalloc minalign for this.
- */
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
-
 #endif /* __ASM_SH_PAGE_H */
