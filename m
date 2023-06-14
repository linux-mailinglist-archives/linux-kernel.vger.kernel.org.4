Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1472FB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbjFNKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbjFNKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:48:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4CE41;
        Wed, 14 Jun 2023 03:48:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so4222395e9.0;
        Wed, 14 Jun 2023 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686739688; x=1689331688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54awEcwIqAI+xJ9eKb8uhlwdu40FnMLdikz9jtZBxm4=;
        b=dOf21LQJi4YaxOaXsTRIRBfl5mzMPsK/ljTLaVc7Sf/IEKb5nPBBzLkza5lqDVjJlk
         gswK/LmWfmJCguDWOYIzkNz8la2pIfITbbdGdHcqgF3H8GfexMsTOYPxnCLRvnrl6zFy
         gB3ocwnBQlR/ZvuksBy3f14zo5ru+bh26cHxXLrVO2MegCYUozMHeEhM2cRzau/gAFMP
         9cqC4D6Am/thiWBJmlgMQXgaiAW1USkE9UNdAabcgGN2OhSO+jcaAcJGky8Rb66BgHIe
         WNzUCvoSljptc7+esj381mZ0gBu6E/EZZBY1RXqQ9JScvy5JM1NuaOo0yCUw21w3+UkW
         rwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739688; x=1689331688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54awEcwIqAI+xJ9eKb8uhlwdu40FnMLdikz9jtZBxm4=;
        b=kdyOmw5uyjAiAayTy6wfzkUqHUJzaRwKG6097eahnd2XZQ+7GSuFvIVB6Ztsqzntwt
         4QFljGkl+mGqKsyS5rYs0oqdmm4DusCLr4K05w2me0egFqrDZ5Ah01aSHWW8bU+ZDr1m
         xncHfqM9lbMhvsrFk9H2e0zmfQ0L6HzneJek2rsIhK2eIT++y6WwvEuh2Sq/O9pgfHcc
         KJmbmWW0sH3ITuY+OQoD8GWiBUGPr/aAfALU9+/ecDzlX8ajeCZpBA9avkGfFeOJ8kqU
         KxzPf83CKJKPmGpIZ6CB6r+pXDlnJGvwJDx+OjQw6UPKKkf1puMVttebJerOKogyYeLT
         QQ+A==
X-Gm-Message-State: AC+VfDwic5G4BIQzdcDsG7WRFuohhtpnmDM1LZ7syhJiG9ePbiVRSm8z
        y3YxF38QMLKvBEr1KtJHE6Q=
X-Google-Smtp-Source: ACHHUZ5P4TrP2GYMKWeWTFq+27scIGpqfV0wL9ukpLCckZxd7nluyFYMvOYPe90VCMfY4x9iqhxueA==
X-Received: by 2002:a7b:cb92:0:b0:3f5:ffe3:46a7 with SMTP id m18-20020a7bcb92000000b003f5ffe346a7mr9503412wmi.9.1686739687813;
        Wed, 14 Jun 2023 03:48:07 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm17154904wma.24.2023.06.14.03.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:48:07 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations support
Date:   Wed, 14 Jun 2023 11:47:56 +0100
Message-Id: <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Introduce support for nonstandard noncoherent systems in the RISC-V
architecture. It enables function pointer support to handle cache
management in such systems.

This patch adds a new configuration option called
"RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
support for cache management in nonstandard noncoherent systems.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v8 -> v9
* New patch
---
 arch/riscv/Kconfig                       |  7 ++++
 arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
 arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
 arch/riscv/mm/pmem.c                     | 13 +++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 628aad4fb6e2..325ab2124f0a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -261,6 +261,13 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select DMA_DIRECT_REMAP
 
+config RISCV_NONSTANDARD_CACHE_OPS
+	bool
+	depends on RISCV_DMA_NONCOHERENT
+	help
+	  This enables function pointer support for non-standard noncoherent
+	  systems to handle cache management.
+
 config AS_HAS_INSN
 	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
 
diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..f4e9bb2d3800
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#ifndef __ASM_DMA_NONCOHERENT_H
+#define __ASM_DMA_NONCOHERENT_H
+
+#include <linux/dma-direct.h>
+
+/*
+ * struct riscv_cache_ops - Structure for CMO function pointers
+ *
+ * @clean: Function pointer for clean cache
+ * @inval: Function pointer for invalidate cache
+ * @flush: Function pointer for flushing the cache
+ */
+struct riscv_cache_ops {
+	void (*clean)(phys_addr_t paddr, unsigned long size);
+	void (*inval)(phys_addr_t paddr, unsigned long size);
+	void (*flush)(phys_addr_t paddr, unsigned long size);
+};
+
+extern struct riscv_cache_ops noncoherent_cache_ops;
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops);
+
+#endif	/* __ASM_DMA_NONCOHERENT_H */
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b9a9f57e02be..4cdaa879839a 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -9,13 +9,26 @@
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 static bool noncoherent_supported;
 
+struct riscv_cache_ops noncoherent_cache_ops = {
+	.clean = NULL,
+	.inval = NULL,
+	.flush = NULL,
+};
+
 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.clean)) {
+		noncoherent_cache_ops.clean(paddr, size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inval)) {
+		noncoherent_cache_ops.inval(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.flush)) {
+		noncoherent_cache_ops.flush(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -50,6 +77,13 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.flush)) {
+		noncoherent_cache_ops.flush(page_to_phys(page), size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
 }
 
@@ -75,3 +109,12 @@ void riscv_noncoherent_supported(void)
 	     "Non-coherent DMA support enabled without a block size\n");
 	noncoherent_supported = true;
 }
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops)
+{
+	if (!ops)
+		return;
+
+	noncoherent_cache_ops = *ops;
+}
+EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
index 089df92ae876..fb481f5b930a 100644
--- a/arch/riscv/mm/pmem.c
+++ b/arch/riscv/mm/pmem.c
@@ -7,15 +7,28 @@
 #include <linux/libnvdimm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.clean)) {
+		noncoherent_cache_ops.clean(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
 void arch_invalidate_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inval)) {
+		noncoherent_cache_ops.inval(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.25.1

